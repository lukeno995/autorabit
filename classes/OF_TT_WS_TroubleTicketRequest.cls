global class OF_TT_WS_TroubleTicketRequest {

    global class TroubleTicket{            
            webservice String TIPO_COMUNICAZIONE;
            webservice String CODICE_OPERATORE;
            webservice String CODICE_COMUNICAZIONE_OLO;
            webservice String CATEGORIA_GUASTO;        
            webservice String ID_NOTIFICA;        
            webservice String ID_RISORSA;
            webservice String DATA_ORA_INIZIO_GUASTO;
            webservice String DATA_ORA_RICHIESTA_ANNULLAMENTO;
            webservice String DATA_ORA_DESOSPENSIONE;
            webservice String DATA_ORA_AUTORIPRISTINATO;
            webservice String CAUSALE_RICHIESTA_ANNULLAMENTO;
            webservice String CAUSALE_DESOSPENSIONE;
            webservice String NOME_CLIENTE;
            webservice String COGNOME_CLIENTE;
            webservice String RECAPITO_TELEFONICO_CLIENTE_1;
            webservice String RECAPITO_TELEFONICO_CLIENTE_2;            
            webservice String NOME_REFERENTE_TECNICO_OLO;            
            webservice String TELEFONO_REFERENTE_TECNICO_OLO;
            webservice String EMAIL_REFERENTE_TECNICO_OLO;
            webservice String REFERENTE_DESOSPENSIONE;
            webservice String VERIFICA_APPARATO_CLIENTE;
            webservice String DESCRIZIONE_PROBLEMA;
            webservice String NOTE_CLIENTE;            
            webservice String NOTE;   
            webservice String CAUSALE_APERTURA;
            webservice String INTERVENTO_CONGIUNTO;
            webservice String TEC_OLO;
            webservice String TEL_TEC_OLO;
            webservice String DATA_ORA_INTERVENTO_CONGIUNTO;
        }

    global class returnTroubleTicketResponse{
        webservice String Esito;
        webservice String CodiceErrore;
        webservice String CausaleErrore;
    }

    webservice static returnTroubleTicketResponse TroubleTicket(TroubleTicket tt){ 
        //Generating TroubleTicket Service Log        
        OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_EAI_Log(tt);
        insert OF_TTM_Utils.sLogOLOSF;
        //AA 14/06/18 Modifica implementazione cruscotto
        if(string.isBlank(tt.TIPO_COMUNICAZIONE)){
            return OF_TTM_Utils.syncError(tt, 'A_K9', 'Tipo Comunicazione');
        }
        
        if (tt.TIPO_COMUNICAZIONE.equals('1')){//Richiesta inserimento nuovo TT
            //Controllo se esiste già un codice comunicazione olo
            if (OF_TTM_Utils.checkCaseOriginale){
                return OF_TTM_Utils.syncError(tt, 'A_K10', 'CODICE_COMUNICAZIONE_OLO');
            }
            //Per decidere su quale servizio inoltrare la richiesta mi basterà confrontare la data
            //odierna con quella presente all'interno del custom setting 

            /* AA - Nuova logica di controllo inoltro verso TTM;
                1) Viene recuperata la data di switch(OF_DataSwitchTTM__c) presente nel custom setting "OF_Configurazioni__c";
                Se la data è precedente ad oggi, si prosegue con i controlli per il TTM, altrimenti si utilizza la vecchia logica.                
                Superato il controllo sulla data, si effettuano i seguenti controlli:
                    1)Dal custom setting "OF_Configurazioni__c", si va a verificare la checkbox "OF_TT_TuttoSuTTM__c", se è true si va direttamente su TTM,
                        se è false, si prosegue con i controlli
                    2) Si fa una query sull'Asset per recuperare TipologiaServizio e POP
                    3) Con la coppia "CodiceOperatore_TipologiaServizio" {Es. TIS_OPENSTREAM}, si va ad interrogare il custom setting "OF_Conf_Tripletta_TTM__c"
                        Il custom setting avrà una lista di POP nel campo "POP_Abilitati__c" separati da ";"
                    4) Se l'interrogazione sul custom setting restituisce un record, si va a ciclare la lista di POP e si verifica l'esistenza del POP, 
                        se è presente allora si va verso TTM.
                        Nel caso in cui qualsiasi di questi controlli vada in errore, si va sulla vecchia logica
            */
            //Recupero i valori di configurazione
            System.debug('**** Tipo comunicazione 1');
            List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
            //Verifico che sia inserito almeno un record, altrimenti vado sul vecchio flusso
            if(listCustomSett != null && !listCustomSett.isEmpty()){
                System.debug('*** Superato il check sulla valorizzazione del custom setting OF_Configurazioni__c');
                Date dataswitchTTM = listCustomSett[0].OF_DataSwitchTTM__c;
                Boolean tuttoSuTTM = listCustomSett[0].OF_TT_TuttoSuTTM__c;
                System.debug('***** dataswitchTTM => ' + dataswitchTTM);
                System.debug('***** tuttoSuTTM => ' + tuttoSuTTM);
                //Vado a verificare se è partito lo switch su TTM
                if(dataswitchTTM != null && date.today() >= dataswitchTTM){
                    System.debug('**** Data ok per nuovo flusso!!!');
                    //Verifico se bisogna inviare tutto su TTM
                    if(tuttoSuTTM){
                        System.debug('**** Tutte le richieste su TTM');
                        return OF_TTM_EntryChecks.checkSync(tt);
                    }else{//Faccio i controlli sulla tripletta del custom setting "OF_Conf_Tripletta_TTM__c"
                        System.debug('Ancora non va tutto su TTM');
                        //Per problematiche ignote di salesforce, ho dovuto creare un metodo nella classe di Utils per recuperare recordtype e POP
                        String tipoServizio = OF_TTM_Utils.getTipologiaServizioByAssetRecordType(tt.ID_RISORSA, tt.CODICE_OPERATORE);
                        System.debug('***** tipoServizio => ' + tipoServizio);
                        String assetPop = OF_TTM_Utils.assetPOP;
                        System.debug('***** assetPop => ' + assetPop);
                        if(String.isNotBlank(assetPop) && String.isNotBlank(tipoServizio)){
                            System.debug('**** Superato il controllo pop e tiposervizio != null');
                            //Vado a recuperare il record di configurazione
                            System.debug('**** CodiceOperatore_TipoServizio => ' + tt.CODICE_OPERATORE + '_' + tipoServizio);
                            OF_Conf_Tripletta_TTM__c configTTM = OF_Conf_Tripletta_TTM__c.getInstance(tt.CODICE_OPERATORE + '_' + tipoServizio);
                            System.debug('***** configTTM => ' + configTTM);
                            //Se il record è vuoto, o la lista di POP è vuota, vado sul vecchio flusso
                            if(configTTM != null && configTTM.POP_Abilitati__c != null){
                                System.debug('**** Superato il controllo configTTM e configTTM.POP_Abilitati__c != null');
                                Boolean popfound = false;
                                //Avendo controllato il campo POP_Abilitati, sono sicuro di non andare in nullpointer
                                System.debug('**** configTTM.POP_Abilitati__c.split => ' + configTTM.POP_Abilitati__c.split(';') );
                                for(String pop : configTTM.POP_Abilitati__c.split(';')){
                                    //Avendo controllato l'esistenza dell'assetPop, sono sicuro di non andare in nullpointer
                                    if(assetPop.equalsIgnoreCase(pop)){
                                        //Se trovo il pop, esco dal ciclo e vado verso TTM
                                        popfound = true;
                                        break;
                                    }
                                }
                                System.debug('****** popfound => ' + popfound);
                                //La tripletta è abilitata a procedere verso il TTM
                                if(popfound){
                                    return OF_TTM_EntryChecks.checkSync(tt);
                                }else{//La tripletta non è abilitata a procedere verso il TTM e va sul vecchio flusso
                                    return OF_TT_EntryChecks.checkSync(tt);  
                                }
                            }else{//Vado a richiamare il vecchio flusso
                                return OF_TT_EntryChecks.checkSync(tt);  
                            }
                        }else{//POP o recordType non riconosciuti, vado sul vecchio flusso
                            return OF_TT_EntryChecks.checkSync(tt);  
                        }                                  
                    }
                }else{//Se ancora non è partito lo switch su TTM, vado sui vecchi flussi
                    return OF_TT_EntryChecks.checkSync(tt);  
                }
            }else{//Custom setting "Configurazioni" non valorizzato
                return OF_TT_EntryChecks.checkSync(tt);  
            }            
        }else{//Richiesta di modifica ad un TT
            //Done AA : Implementare recupero case originale all'interno della creazione dell'EAI_Log
            if(String.isBlank(tt.CODICE_COMUNICAZIONE_OLO)){
                return OF_TT_Utils.syncError(tt, 'A_K9', 'Codice Comunicazione OLO');
            }
            //check se trovo il case a sistema sfruttando il service log creato
            if(!OF_TTM_Utils.checkCaseOriginale){ 
                return OF_TT_Utils.syncError(tt, 'A_K10', 'Codice Comunicazione OLO');
            }
            if(OF_TTM_Utils.caseOriginale.OF_TroubleTicketManager__c){//Controllo se è un TT relativo al nuovo sistema TTM
                           
                return OF_TTM_EntryChecks.checkSync(tt);        
            }else{//Caso in cui il TT è relativo al vecchio sistema TT
                //Checking for Synchro and Asynchro controls
                return OF_TT_EntryChecks.checkSync(tt);
            }
        }
    }      
    
}
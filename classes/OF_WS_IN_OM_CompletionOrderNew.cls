global class OF_WS_IN_OM_CompletionOrderNew {
    global class OM_Notify_CompletionOrder{
        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String CODICE_ORDINE_OF;
        webservice String DATA_NOTIFICA; 
        webservice String ID_NOTIFICA;
        webservice String STATO_ORDINE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String ID_RISORSA;
        webservice String DATA_ESPLETAMENTO_ORDINE;
        //AA 18/10/2018 - Aggiunti nuovi campi per servizi passivi
        webservice String ID_SPLITTER_SECONDARIO;
        webservice String POSIZIONE_SPLITTER_SECONDARIO;
        webservice String PARAMETRI_TRASMISSIVI_OTTICI;
        //FINE AA 
        webservice String SCALA_PALAZZINA;
        webservice String DDT;
        webservice String NOTE;
        //2018/08/24 MM : aggiunta nuovi campi per verticali
        webservice String ID_GIS_SCALA_PALAZZINA;
        webservice String SCALA;
        webservice String PALAZZINA; 
        // 2018/08/24 MM : fine.
        // AA 300119 - Aggiunti campi come comunicato
        webservice String SERIALE_BORCHIA;
        webservice String GPON_DI_ATTESTAZIONE;
        webservice String FLAG_PAGAMENTO;
        webservice String NUMERO_OPERATORE;
        webservice String BRETELLA_OTTICA;
        webservice String ESTENSIONE_IMPIANTO_EFFETTUATA;
        webservice String ESTENSIONE_IMPIANTO;
        webservice String METRI_TOT;
        // FINE AA
        webservice List<SERVIZIO_AGGIUNTIVO> SERVIZIO_AGGIUNTIVO;
        webservice List<APPARATO> APPARATO;
    }
    
    global class APPARATO{
        webservice String TIPOLOGIA_APPARATO;
        webservice String ESITO_CONSEGNA_APPARATO;
        webservice String ID_APPARATO_CONSEGNATO;
        webservice String CODICE_MOTIVAZIONE_CONSEGNA;
        webservice String MOTIVAZIONE_CONSEGNA;
    }
    
    global class SERVIZIO_AGGIUNTIVO{
        webservice String NOME_SERVIZIO;
        webservice String ESITO_SERVIZIO;
        webservice String CODICE_MOTIVAZIONE_SERVIZIO;
        webservice String MOTIVAZIONE_SERVIZIO;
        // 2018/08/24 MM : aggiunta nuovi campi per verticali
        webservice String ESTENSIONE_IMPIANTO;
        webservice String METRI_TOT;
        //2018/08/24 MM : fine.
    }
    
    global class OM_Notify_CompletionOrderResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
    webservice static OM_Notify_CompletionOrderResponse OM_Notify_CompletionOrder (OM_Notify_CompletionOrder co){        
        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp espletamento
        OF_SA_GE_UtilsNew.CreateTemlogOM(co);
        OF_SA_GE_UtilsNew.AttrTime = datetime.now().getTime();
        // finisce qui
        
        //Recupero il case e il rtype per capire se è un attivo o un passivo
        List<Case> lstCase = [SELECT Recordtype.DeveloperName, OF_Response_da_SH__c, OF_Response_Da_OLO__c, OF_Response_Da_OM__c
                              FROM Case
                              WHERE EOF_Codice_Operatore_WS__c = :co.CODICE_OPERATORE
                              AND EOF_codice_Ordine_OLO__c = :co.CODICE_ORDINE_OLO
                              AND Codice_Ordine_Eof__C = :co.CODICE_ORDINE_OF];

        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse respUp;
        if(!lstCase.isEmpty()){//Se ho trovato il case vado con le entrychecks
            Case tmpCase = lstCase[0];
            //Controllo se c'è una retry in corso
            if( 'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_da_SH__c) || 
                'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_Da_OLO__c) ||
                'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_Da_OM__c))
            {
                respUp = OF_SA_GE_UtilsNew.syncError (co,'A04','');
            }else{
                //Attivi
                if(tmpCase.Recordtype.DeveloperName == 'OF_SA_Cessazione' || tmpCase.Recordtype.DeveloperName == 'OF_SA_Attivazione'){
                    respUp = OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
                }else{//Passivi
                    respUp = OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
                }   
            }
        }else{//Caso in cui non trovo il case
            respUp = OF_SA_GE_UtilsNew.syncError(co,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        }        
        
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrderResponse resp = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrderResponse();
            resp.ESITO = respUp.Esito;
            resp.codice_motivazione = respup.codice_motivazione;
            resp.motivazione = respup.motivazione;
            resp.Id_Notifica = co.id_Notifica;
        return resp;    	 
    } 
}
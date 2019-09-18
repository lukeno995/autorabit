global class OF_WS_IN_OM_StatusUpdateNew {
    global class OM_Notify_StatusUpdate{
        webservice String CODICE_OPERATORE; 
        webservice String CODICE_ORDINE_OLO;
        webservice String CODICE_ORDINE_OF;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String STATO_ORDINE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String GPON_DI_ATTESTAZIONE;
        webservice String ID_SERVIZIO;
        webservice String NOME_CLIENTE;
        webservice String COGNOME_CLIENTE;
        webservice String RECAPITO_TELEFONICO_CLIENTE;
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
        webservice String PIN_INTERVENTO_A_VUOTO;
        webservice String NOTE;
        //AA - Nuovo campo falg desospensione
        webservice String FLAG_DESOSPENSIONE;
        webservice String REMOTE_ID;
        //FINE AA
        webservice List<APPARATO> APPARATO;
        webservice List<VLAN> VLAN; 
    }
    
    global class APPARATO {
        webservice String TIPOLOGIA_APPARATO;
        webservice String ESITO_RITIRO_APPARATO;
        webservice String CODICE_MOTIVAZIONE_RITIRO;
        webservice String MOTIVAZIONE_RITIRO;
        webservice String ID_APPARATO;
    }
    
    global class VLAN{
        webservice String USER_VLAN;
        webservice String SERVICE_VLAN;
        webservice String CUSTOMER_VLAN;
    }
    
    global class OM_Notify_StatusUpdateResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE; 
    } 
    
    webservice static OM_Notify_StatusUpdateResponse OM_Notify_StatusUpdate (OM_Notify_StatusUpdate su){
        
        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp status update
         
        OF_SA_GE_UtilsNew.CreateTemlogOM(su); 
        OF_SA_GE_UtilsNew.AttrTime = datetime.now().getTime();
        
        // finisce qui
        //Recupero il case e il rtype per capire se è un attivo o un passivo
        List<Case> lstCase = [SELECT Recordtype.DeveloperName, OF_Response_da_SH__c, OF_Response_Da_OLO__c, OF_Response_Da_OM__c
                              FROM Case
                              WHERE EOF_Codice_Operatore_WS__c = :su.CODICE_OPERATORE
                              AND EOF_codice_Ordine_OLO__c = :su.CODICE_ORDINE_OLO
                              AND Codice_Ordine_Eof__C = :su.CODICE_ORDINE_OF];

        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse respUp;
        if(!lstCase.isEmpty()){//Se ho trovato il case vado con le entrychecks
            Case tmpCase = lstCase[0];
            //Controllo se c'è una retry in corso
            if( 'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_da_SH__c) || 
                'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_Da_OLO__c) ||
                'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_Da_OM__c))
            {
                respUp = OF_SA_GE_UtilsNew.syncError (su,'A04','');
            }else{
                //Attivi
                if(tmpCase.Recordtype.DeveloperName == 'OF_SA_Cessazione' || tmpCase.Recordtype.DeveloperName == 'OF_SA_Attivazione'){
                    respUp = OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
                }else{//Passivi
                    respUp = OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
                }
            }
        }else{//Caso in cui non trovo il case
            respUp = OF_SA_GE_UtilsNew.syncError(su,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        }
        
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdateResponse resp = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdateResponse();
            resp.ESITO=respUp.Esito;
            resp.codice_motivazione=respup.codice_motivazione;
            resp.motivazione=respup.motivazione;
            resp.Id_Notifica=su.id_Notifica;
        return resp;
    }
}
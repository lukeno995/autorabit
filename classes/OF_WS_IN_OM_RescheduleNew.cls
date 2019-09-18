global class OF_WS_IN_OM_RescheduleNew {
    global class OM_Notify_Reschedule{
        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        //webservice String CODICE_ORDINE_OF;        
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String NOME_CLIENTE;
        webservice String COGNOME_CLIENTE;
        webservice String RECAPITO_TELEFONICO_CLIENTE_1;
        webservice String RECAPITO_TELEFONICO_CLIENTE_2;
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String NOTE;
    }
    
    global class OM_Notify_RescheduleResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
    webservice static OM_Notify_RescheduleResponse OM_Reschedule (OM_Notify_Reschedule r){
        
        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp rimodulazione da OM
        OF_SA_GE_UtilsNew.CreateTemlogOM(r);
        OF_SA_GE_UtilsNew.AttrTime = datetime.now().getTime();        
        // finisce qui
        //Recupero il case e il rtype per capire se è un attivo o un passivo
        List<Case> lstCase = [SELECT Recordtype.DeveloperName, OF_Response_da_SH__c, OF_Response_Da_OLO__c, OF_Response_Da_OM__c
                              FROM Case
                              WHERE EOF_Codice_Operatore_WS__c = :r.CODICE_OPERATORE
                              AND EOF_codice_Ordine_OLO__c = :r.CODICE_ORDINE_OLO
                              /*AND Codice_Ordine_Eof__C = :r.CODICE_ORDINE_OF*/];

        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse respUp;
        if(!lstCase.isEmpty()){//Se ho trovato il case vado con le entrychecks
            Case tmpCase = lstCase[0];
            //Controllo se c'è una retry in corso
            if( 'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_da_SH__c) || 
                'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_Da_OLO__c) ||
                'NACK TECNICO'.equalsIgnoreCase(tmpCase.OF_Response_Da_OM__c))
            {
                respUp = OF_SA_GE_UtilsNew.syncError (r,'A04','');
            }else{
                //Attivi
                if(tmpCase.Recordtype.DeveloperName == 'OF_SA_Cessazione' || tmpCase.Recordtype.DeveloperName == 'OF_SA_Attivazione'){
                    respUp = OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
                }else{//Passivi
                    respUp = OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
                }
            }
        }else{//Caso in cui non trovo il case
            respUp = OF_SA_GE_UtilsNew.syncError(r,'A06','CODICE_ORDINE_OLO');
        }
         
        OF_WS_IN_OM_RescheduleNew.OM_Notify_RescheduleResponse resp = new OF_WS_IN_OM_RescheduleNew.OM_Notify_RescheduleResponse();
            resp.ESITO=respUp.Esito;
            resp.codice_motivazione=respup.codice_motivazione;
            resp.motivazione=respup.motivazione;
            resp.Id_Notifica=r.id_Notifica;
        return resp;
    }
}
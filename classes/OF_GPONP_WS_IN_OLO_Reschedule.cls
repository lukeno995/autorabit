global class OF_GPONP_WS_IN_OLO_Reschedule {
    
    global class OLO_RescheduleRequest_GPONP{
        webservice String CODICE_ORDINE_OF;
        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String NOME_CLIENTE;
        webservice String COGNOME_CLIENTE;
        webservice String RECAPITO_TELEFONICO_CLIENTE_1;
        webservice String RECAPITO_TELEFONICO_CLIENTE_2;
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
        webservice String NOTE;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
        webservice String IDENTIFICATIVO_PRENOTAZIONE;
    }

    global class OLO_RescheduleResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
    webservice static OLO_RescheduleResponse OLO_Reschedule (OLO_RescheduleRequest_GPONP rr){
        // 15/06/2018 MM : creazione templog
        OF_GPONP_GE_Utils.CreateTemplogOLO(rr);
        OF_GPONP_GE_Utils.AttrTime = datetime.now().getTime();
        // finisce qui
        
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_GPONP_OLO_EntryChecks.SyncChecksRescheduleNew(rr);
        OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleResponse resp = new OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleResponse();
            resp.ESITO=respUp.Esito;
            resp.codice_motivazione=respup.codice_motivazione;
            resp.motivazione=respup.motivazione;
            resp.Id_Notifica=rr.id_Notifica;
        return resp;
    }
    
}
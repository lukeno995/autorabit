global class OF_SA_WS_IN_OLO_StatusUpdate {
    
    global class OLO_StatusUpdateRequest{
        webservice String CODICE_ORDINE_OF;
        webservice String CODICE_OPERATORE; 
        webservice String CODICE_ORDINE_OLO;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String AZIONE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
        webservice String NOME_CLIENTE;
        webservice String COGNOME_CLIENTE;
        webservice String RECAPITO_TELEFONICO_CLIENTE_1;
        webservice String RECAPITO_TELEFONICO_CLIENTE_2;
        webservice String NOTE;
    }
    
    global class OLO_StatusUpdateResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }

    webservice static OLO_StatusUpdateResponse OLO_StatusUpdate (OLO_StatusUpdateRequest sur){

		// 15/06/2018 MM : creazione templog
        OF_SA_GE_Utils.CreateTemplogOLO(sur);
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui         
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_OLO_EntryChecks.SyncChecksStatusUpdate(sur);
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse resp = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse();

        resp.ESITO=respUp.Esito;
        resp.codice_motivazione=respup.codice_motivazione;
        resp.motivazione=respup.motivazione;
        resp.Id_Notifica=sur.id_Notifica;
           
    	return resp;
        
    }
    
}
global class OF_SA_WS_IN_OM_Reschedule {
	
	global class OM_Notify_Reschedule{
		webservice String CODICE_OPERATORE;
	    webservice String CODICE_ORDINE_OLO;
	    webservice String CODICE_ORDINE_OF; // non presente nel documento: par 5.2.2.2
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
		OF_SA_GE_Utils.CreateTemlogOM(r);
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
                
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(r);
    		OF_SA_WS_IN_OM_Reschedule.OM_Notify_RescheduleResponse resp = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_RescheduleResponse();
    		resp.ESITO=respUp.Esito;
        	resp.codice_motivazione=respup.codice_motivazione;
        	resp.motivazione=respup.motivazione;
        	resp.Id_Notifica=r.id_Notifica;
        	return resp;
    }
    
}
global class OF_SA_WS_IN_OM_StatusUpdate {
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
        webservice String NOME_CLIENTE;
        webservice String COGNOME_CLIENTE;
        webservice String RECAPITO_TELEFONICO_CLIENTE;
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
        webservice String PIN_INTERVENTO_A_VUOTO;
        webservice String NOTE;
        webservice List<APPARATO> APPARATO;
        webservice List<VLAN> VLAN; 
    }
    
    global class APPARATO {
        webservice String TIPOLOGIA_APPARATO;
        webservice String ESITO_RITIRO_APPARATO;
        webservice String CODICE_MOTIVAZIONE_RITIRO;
        webservice String MOTIVAZIONE_RITIRO;
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
        
		OF_SA_GE_Utils.CreateTemlogOM(su);
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
               
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
    		OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse resp = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse();
    		resp.ESITO=respUp.Esito;
        	resp.codice_motivazione=respup.codice_motivazione;
        	resp.motivazione=respup.motivazione;
        	resp.Id_Notifica=su.id_Notifica;
        	return resp;
    }
    
}
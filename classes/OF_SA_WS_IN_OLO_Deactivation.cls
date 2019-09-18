global class OF_SA_WS_IN_OLO_Deactivation {
    
    global class OLO_DeactivationRequest{
    	webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String ID_RISORSA;
        webservice String NOME_CLIENTE;
        webservice String COGNOME_CLIENTE;
        webservice String RECAPITO_TELEFONICO_CLIENTE_1;
        webservice String RECAPITO_TELEFONICO_CLIENTE_2;
        webservice String CODICE_MOTIVAZIONE;
		webservice String MOTIVAZIONE;
        webservice String NOTE;
        webservice List<APPARATO> APPARATO;
    }
    
    global class APPARATO{
    	webservice String TIPOLOGIA_APPARATO;
        webservice String ID_APPARATO;
    }
    
    global class OLO_DeactivationResponse{
    	webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
    webservice static OLO_DeactivationResponse OLO_Deactivation (OLO_DeactivationRequest Deact){
        
        // 15/06/2018 MM : Aggiunta creazione Templog per cattura timestamp cessazione
		OF_SA_GE_Utils.CreateTemplogOLO(Deact);
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
                
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_OLO_EntryChecks.SyncChecksDeactivation(Deact);
    		OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationResponse resp = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationResponse();
    		resp.ESITO=respUp.Esito;
        	resp.codice_motivazione=respup.codice_motivazione;
        	resp.motivazione=respup.motivazione;
        	resp.Id_Notifica=Deact.id_Notifica;
        	return resp;
    }
    
}
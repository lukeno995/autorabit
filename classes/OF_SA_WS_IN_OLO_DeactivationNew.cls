global class OF_SA_WS_IN_OLO_DeactivationNew {
    
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
        webservice String NOTE;
        //aa aggiunto campo 29/11/2018
        webservice String TRACCIATO_TRASCODIFICATO;
        webservice String CODICE_OPERATORE_SECONDARIO;
        webservice List<APPARATO> APPARATO;
    }
    
    global class APPARATO{
    	webservice String TIPOLOGIA_APPARATO;
    }
    
    global class OLO_DeactivationResponse{
    	webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
    webservice static OLO_DeactivationResponse OLO_Deactivation (OLO_DeactivationRequest Deact){
        
        // 15/06/2018 MM : Aggiunta creazione Templog per cattura timestamp cessazione
		OF_SA_GE_UtilsNew.CreateTemplogOLO(Deact);
        OF_SA_GE_UtilsNew.AttrTime = datetime.now().getTime();
        // finisce qui
                
    	OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse respUp = OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
    		
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationResponse resp = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationResponse();
    		resp.ESITO=respUp.Esito;
        	resp.codice_motivazione=respup.codice_motivazione;
        	resp.motivazione=respup.motivazione;
        	resp.Id_Notifica=Deact.id_Notifica;
        	return resp;
    }
    
}
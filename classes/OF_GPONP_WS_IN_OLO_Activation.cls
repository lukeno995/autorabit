global class OF_GPONP_WS_IN_OLO_Activation {
     
    global class OLO_ActivationRequest_GPONP{
    	webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String NOME_REFERENTE_TECNICO_OLO;
        webservice String COGNOME_REFERENTE_TECNICO_OLO;
        webservice String TELEFONO_REFERENTE_TECNICO_OLO;
        webservice String EMAIL_REFERENTE_TECNICO_OLO;
        webservice String TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH;
        webservice String NOME_CLIENTE;
        webservice String COGNOME_CLIENTE;
        webservice String RECAPITO_TELEFONICO_CLIENTE_1;
        webservice String RECAPITO_TELEFONICO_CLIENTE_2;
        webservice String INFORMAZIONI_LOGISTICA_APPARATI;
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
        webservice String CODICE_PROGETTO_SPECIALE;
        webservice String PROMOZIONE;
        webservice String CLUSTER_PROMOZIONE;
        webservice String NOTE;
        webservice String ID_BUILDING;
        webservice String SCALA_PALAZZINA;
        webservice String NUMERO_TELEFONICO_PRINCIPALE_LINEA;
        webservice String RECAPITO_TEST_LINEA;
        webservice String IDENTIFICATIVO_DEL_POP;
        webservice String GPON_RICHIESTA;
        webservice List<SERVIZIO_AGGIUNTIVO> SERVIZIO_AGGIUNTIVO;
        webservice List<APPARATO> APPARATO;
        //aa aggiunto campo 29/11/2018
        webservice String TRACCIATO_TRASCODIFICATO;
        webservice String CODICE_OPERATORE_SECONDARIO;
        webservice String IDENTIFICATIVO_PRENOTAZIONE;
    }
    
    global class APPARATO{
    	webservice String TIPOLOGIA_APPARATO;
        webservice String PASSWORD_APPARATO;
        webservice String AZIONE_APPARATO;
        webservice String CAUSALE;
    }
    
    global class SERVIZIO_AGGIUNTIVO{
    	webservice String NOME_SERVIZIO; 
        webservice String INFORMAZIONI_SERVIZIO;
    }
    
    global class OLO_ActivationResponse{
    	webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
     
    webservice static OLO_ActivationResponse OLO_Activation_GPONP (OLO_ActivationRequest_GPONP act){
        
        // 15/06/2018 MM : creazione templog
		OF_GPONP_GE_Utils.CreateTemplogOLO(act);
        OF_GPONP_GE_Utils.AttrTime = datetime.now().getTime();
		// 15/06/2018 MM : finisce qui
        //Check syncroni
        return OF_GPONP_OLO_EntryChecks.SyncChecksActivationNew(act); 

    }    
}
global class OF_SA_WS_IN_OLO_ActivationNew {
     
    global class OLO_ActivationRequest{
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
        webservice String PROFILO;
        //aa aggiunto campo 29/11/2018
        webservice String TRACCIATO_TRASCODIFICATO;
        webservice String CODICE_OPERATORE_SECONDARIO;
        //FINE AA    
        webservice List<SERVIZIO_AGGIUNTIVO> SERVIZIO_AGGIUNTIVO;
        webservice List<APPARATO> APPARATO;
        webservice List<VLAN> VLAN;
        webservice String IDENTIFICATIVO_PRENOTAZIONE;
    }
    
    global class VLAN{
    	webservice String KIT_CONSEGNA_VLAN;
        webservice String USER_VLAN;
        webservice String SERVICE_VLAN;
        webservice String PROFILO_VLAN;
        webservice String INFORMAZIONI_VLAN;
        webservice String CUSTOMER_VLAN;
        webservice String MODELLO_DI_SERVIZIO_VLAN;
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
    
    global class KIT_ActivationRequest{
    	webservice String NOME_KIT;
        webservice String MODELLO_SERVIZIO;
        webservice String IDENTIFICATIVO_DEL_POP;
        webservice String BANDA;
        webservice String ODF;
        webservice String TRAFFICO;
        webservice String SERVIZIFINALI;
        webservice String DATA_NOTIFICA; 
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String PROFILO;
        webservice String ID_NOTIFICA;
        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice List<VLAN> VLAN;
    }
    
    global class S_VLAN_ActivationRequest{
        webservice String NOME_KIT;
    	webservice String POP;
        webservice String BANDA_INTERFACCIA;
        webservice String SVLAN;
        webservice String COS_REMARKING;
        webservice String DHCP_OPTION82;
        webservice String COS_TYPE;
        webservice String COS_CLASS;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
    }
     
    webservice static OLO_ActivationResponse OLO_Activation (OLO_ActivationRequest act){
        
        // 15/06/2018 MM : creazione templog
		OF_SA_GE_UtilsNew.CreateTemplogOLO(act);
        OF_SA_GE_UtilsNew.AttrTime = datetime.now().getTime();
		// 15/06/2018 MM : finisce qui
        //Check syncroni
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse res = OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act); 
    	//Mapping new response
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse response = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
            response.ID_NOTIFICA = res.ID_NOTIFICA;
            response.ESITO = res.ESITO;
            response.CODICE_MOTIVAZIONE = res.CODICE_MOTIVAZIONE;
            response.MOTIVAZIONE = res.MOTIVAZIONE;

        return response;
    }    
}
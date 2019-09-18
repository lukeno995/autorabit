global class OF_PP_WS_IN_OLO_Activation {

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
        webservice String INTERFACCIA;
        webservice String ODF;
        webservice String TRAFFICO;
        webservice String SERVIZIFINALI;
        webservice String DATA_NOTIFICA;
        webservice String DATA_PREVISTA_ATTIVAZIONE;
        webservice String PROFILO;
        webservice String ID_NOTIFICA;
        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String CODICE_ORDINE_OF;
        webservice String NOTE;
        webservice List<VLAN_PP> listaVLAN;
        webservice String STATO_ORDINE;
        webservice String CODICE_ORDINE_SO;
    }
    
    global class COS{
    	webservice String TIPO;
        webservice String CLASSE;
        webservice String ID_VLAN;
    }
    
    global class VLAN_PP{
        webservice String ID;
        webservice String NOME_KIT;
        webservice String ID_RICHIESTA;
        webservice String CODICE_ORDINE_SO;
        webservice String CODICE_ORDINE_SFDC;
    	webservice String POP;
        webservice String BANDA_INTERFACCIA;
        webservice String INTERFACCIA;
        webservice String POP_KIT;
        webservice String SVLAN;
        webservice String COS_REMARKING;
        webservice String DHCP_OPTION82;
        webservice String COS_TYPE;
        webservice String COS_CLASS;
        webservice String ID_ASSET;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String STATO_ORDINE;
        webservice String NOTE;
        webservice Integer PROGRESSIVO_ORDINE;
        webservice String USER_VLAN;
        webservice List<COS> listaCOS;
        
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String ERRODESC;
        webservice String TIPO_COMUNICAZIONE;
        webservice String RICHIESTA_NOTIFICA;
        webservice String METODO;
        webservice String FLUSSO;
    }
     
    webservice static OLO_ActivationResponse OLO_Activation (KIT_ActivationRequest act){
        
        // 15/06/2018 MM : creazione templog
		OF_PP_GE_Utils.CreateTemplogOLO(act);
        OF_PP_GE_Utils.AttrTime = datetime.now().getTime();
		// 15/06/2018 MM : finisce qui
		       
    	return OF_PP_OLO_EntryChecksKIT.SyncChecksActivation(act); 
    } 
    
}
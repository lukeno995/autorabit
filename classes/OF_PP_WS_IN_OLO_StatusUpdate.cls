global class OF_PP_WS_IN_OLO_StatusUpdate {
    
    global class OLO_StatusUpdateRequest{
        webservice String CODICE_ORDINE_OF;
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
        webservice String NOTE;
        webservice String AZIONE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
    }
    
    global class OLO_StatusUpdateRequestVLAN_PP{
        webservice String CODICE_ORDINE_OF;
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
        webservice String NOTE;
        webservice String AZIONE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String ORARIO_APPUNTAMENTO;
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
    	webservice String POP;
        webservice String BANDA_INTERFACCIA;
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
        webservice List<COS> listaCOS;
        
        webservice String ESITO ;
        webservice String CODICE_MOTIVAZIONE ;
        webservice String MOTIVAZIONE ;
        webservice String ERRODESC ;
        webservice String TIPO_COMUNICAZIONE;
        webservice String RICHIESTA_NOTIFICA;
        webservice String METODO;
        webservice String FLUSSO;

    }
    
    global class OLO_StatusUpdateResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }

   /* webservice static OLO_StatusUpdateResponse OLO_StatusUpdate (OLO_StatusUpdateRequestVLAN_PP sur){

		
        OF_PP_WS_IN_OLO_Activation.VLAN_PP respUp = OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(sur);
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse resp = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateResponse();

        resp.ESITO=respUp.Esito;
        resp.codice_motivazione=respup.codice_motivazione;
        resp.motivazione=respup.motivazione;
        resp.Id_Notifica=sur.id_Notifica;
           
    	return resp;
        
    }*/
    
}
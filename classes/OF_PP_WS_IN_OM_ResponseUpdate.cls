global class OF_PP_WS_IN_OM_ResponseUpdate {
    
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
        webservice List<SERVIZI_UTENTE> SERVIZI_UTENTE;
    }

    global class SERVIZI_UTENTE{ // cos
    	webservice String TIPO;
        webservice String CLASSE;
        webservice String ID_VLAN;
    }
    
    global class OLO_StatusUpdateResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
    global class OLO_StatusUpdateRequestVLAN_PP{
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
        webservice String CODICE_ORDINE_OF;
        webservice String AZIONE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String CODICE_ORDINE_SFDC;
        webservice String CODICE_ORDINE_SO;
        webservice String SERVICE_VLAN_ID;
        webservice String USER_VLAN ;
        webservice String[] SERVIZI_UTENTE;
    }
    
    global class OM_StatusUpdateRequestVLAN{

        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_SFDC;
        webservice String CODICE_ORDINE_SO;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String STATO_ORDINE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String NOTE;
        webservice String SERVICE_VLAN_ID;
        webservice String USER_VLAN;
        webservice String[] SERVIZI_UTENTE;
    }

    webservice static OLO_StatusUpdateResponse OLO_PreProv_StatusUpdate (OM_StatusUpdateRequestVLAN sur){
        
        OF_PP_WS_IN_OLO_Activation.VLAN_PP respUp = OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(sur);
        OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateResponse resp = new OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateResponse();

        resp.ESITO=respUp.Esito;
        resp.codice_motivazione=respUp.codice_motivazione;
        resp.motivazione=respUp.motivazione;
        resp.Id_Notifica=sur.id_Notifica;
           system.debug('>>>>>>>>>>>>> RESP: ' + resp);
    	return resp;
    }
    
}
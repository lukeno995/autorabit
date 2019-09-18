/**
* Author:       Team Napoli
* Description:  Integrazione Change Order – Open Stream
* SI:           doc. "SF_ChangeOrder_v0_1_draft"
*/ 

global class OF_CO_WS_IN_OLO_ChangeSetup_OpenStream {
     
    global class OLO_ChangeSetup_OpenStream_Request{
        webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String ID_RISORSA;
        webservice String CODICE_PROGETTO_SPECIALE;
        webservice String PROMOZIONE;
        webservice String CLUSTER_PROMOZIONE;
        webservice String NOTE;
        webservice String PROFILO;
        webservice List<VLAN> VLAN;
    }
    
    global class VLAN{
        webservice String KIT_CONSEGNA_VLAN;
        webservice String USER_VLAN;
        webservice String SERVICE_VLAN;
        webservice String PROFILO_VLAN;
        webservice String CUSTOMER_VLAN;
        webservice String MODELLO_DI_SERVIZIO_VLAN;
        webservice String INFORMAZIONI_VLAN;
    }

    
    global class OLO_ChangeSetup_OpenStream_Response{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }  
     
     
    webservice static OLO_ChangeSetup_OpenStream_Response OLO_ChangeSetup_OpenStream (OLO_ChangeSetup_OpenStream_Request changeOrd){
        //Mi faccio restituire un OLO_ActivationResponse
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(changeOrd);
        //Mappo la response di OLO_Activation con la OLO_ChangeSetup
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response resp = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response();
            resp.ESITO=respUp.Esito;
            resp.codice_motivazione=respup.codice_motivazione;
            resp.motivazione=respup.motivazione;
            resp.Id_Notifica = changeOrd.id_Notifica;
        return resp;
    } 
    
}
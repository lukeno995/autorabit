public  class OF_CO_OLO_SendToOM {
 public static String reqNot;
    //Done AA: Farsi passare l'intero case
    public static String OM_CreateAckNackRequestActivation(Case c, List<OF_CommercialElementIstanziato__c> listVLANToMap){
        //Recupero il case avente tutte le info della request
        /*Case c = [SELECT Id,Codice_Ordine_EOF__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Ordine_OLO__c, EOF_Data_Notifica__c, EOF_Id_Notifica__c, EOF_Id_Risorsa__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Promozione__c, OF_SA_Cluster_Promozione__c, EOF_Note__c, OF_SA_Profilo__c    
                          FROM Case
                          WHERE Id = :caseId 
                          LIMIT 1];*/
        //Vado a recuperarmi l'id servizio dal case di attivazione
        /*Case caseAttivazione = [Select Id,OF_SA_ID_Servizio__c, RecordType.Name, RecordType.DeveloperName, Status, Asset.Name
                              FROM Case
                              WHERE RecordType.Name = 'EOF_Caso_Attivazione_OPENSTREAM'
                              AND RecordType.DeveloperName = 'OF_SA_Attivazione'
                              AND Status = 'Espletato'
                              AND Asset.Name =:c.EOF_Id_Risorsa__c LIMIT 1];*/
        //Recupero la lista di VLAN richieste dall'utente
        //Done AA: Farsi passare lista VLAN
        /*List<OF_CommercialElementIstanziato__c> listVLANToMap = [SELECT OF_KITCONSEGNAVLAN__C, OF_USERVLAN__C, OF_SERVICEVLAN__C, OF_PROFILOVLAN__C, OF_CUSTOMERVLAN__C, OF_MODELLODISERVIZIOVLAN__C, OF_INFORMAZIONIVLAN__C
                                                                 FROM OF_CommercialElementIstanziato__c
                                                                 WHERE OF_Case__c = :caseId];*/
        //Creo l'oggetto da passare al metodo del ws
        GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element wsInput = new GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element();
            wsInput.TIPO_COMUNICAZIONE = '15';
            wsInput.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
            wsInput.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
            wsInput.CODICE_ORDINE_OF = c.Codice_Ordine_EOF__c;
            wsInput.DATA_NOTIFICA = c.EOF_Data_Notifica__c;
            wsInput.ID_NOTIFICA = c.EOF_Id_Notifica__c;
            wsInput.ID_RISORSA = c.EOF_Id_Risorsa__c;
            wsInput.CODICE_PROGETTO_SPECIALE = c.OF_SA_CODICE_PROGETTO_SPECIALE__c;
            wsInput.PROMOZIONE = c.OF_SA_Promozione__c;
            wsInput.CLUSTER_PROMOZIONE = c.OF_SA_Cluster_Promozione__c;
            wsInput.NOTE = c.EOF_Note__c;
            //Done AA: Recuperare id servizio
            wsInput.ID_SERVIZIO = c.OF_SA_ID_Servizio__c;
            wsInput.PROFILO = c.OF_SA_Profilo__c;
            wsInput.VLAN = mapVLAN(listVLANToMap);
        
        //Variabile esito chiamata
        GW_ChangeSetupOpenStream_Response.Esito_element respTemp = new GW_ChangeSetupOpenStream_Response.Esito_element();
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if( OF_CO_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
            respTemp.Esito='0';
            //resetto il campo a false per evitare problemi successivi
            OF_CO_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{ 
            
            //Done AA: Sostituire la chiamata dal vecchio servizio, al nuovo servizio!!
            //inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM
            GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1 stub = new GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1();           
            //set timeout
            stub.timeout_x = 30000;
            //Done AA: richiamare metodo nuovo
            respTemp = stub.ChangeSetupOpenStream(wsInput);
            
            /*
            respTemp.Esito='1';
            respTemp.CODICE_MOTIVAZIONE='A00';
            respTemp.MOTIVAZIONE='Test Retry';
            */
        }
        //Done AA: Gestire ACK
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            /*OF_CO_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_CO_GE_Utils.slSFOM.EOF_Response__C='ACK';*/
            
            //setto l'ACK sul case
            c.OF_Response_Da_OM__c='ACK';
            
            OF_CO_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OM - ACK - ChangeOrderRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_ChangeOrder',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                EOF_Codice_Ordine_Olo__c = c.EOF_Codice_Ordine_OLO__c,
                EOF_Data_Notifica__c = c.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'OK',
                //Done AA: va bene l'id notifica della response?
                EOF_ID_NOTIFICA__C = respTemp.ID_NOTIFICA,
                OF_SA_ESITO__C = respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
                EOF_Retry__c = OF_CO_GE_Utils.retry,
                OF_SA_ACK__c = true  
            );  
            
        } 
        //Done AA: Gestire NACK con retry
        else{
            //aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            /*OF_CO_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_CO_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_CO_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;*/

           //setto il NACK sul case
           if(String.isBlank(respTemp.CODICE_MOTIVAZIONE) || respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                c.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
                c.OF_Response_Da_OM__c='NACK';
           } 
            OF_CO_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OM - NACK - ChangeOrderRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_ChangeOrder',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - NACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                EOF_Codice_Ordine_Olo__c = c.EOF_Codice_Ordine_OLO__c,
                EOF_Data_Notifica__c = c.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'KO',
                //Done AA: va bene l'id notifica della response?
                EOF_ID_NOTIFICA__C = respTemp.ID_NOTIFICA,
                OF_SA_ESITO__C = respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
                EOF_Retry__c = OF_CO_GE_Utils.retry,
                OF_SA_ACK__c = false
            );
        }
        //Aggiorno lo stato su sLog da portale (solo la prima volta e non nel retry)
        if (OF_CO_GE_Utils.caseOriginale.PO_SA_Portale__c && !OF_CO_GE_Utils.retry){
            EOF_EAI_Service_Log__c fakeLog = new EOF_EAI_Service_Log__c();
            fakeLog.EOF_COdice_Ordine_OLO__c = c.EOF_Codice_Ordine_OLO__c;
            List<EOF_EAI_Service_Log__c> fakeList = new List<EOF_EAI_Service_Log__c>();
            fakeList.add(fakeLog);
            OF_CO_GE_Utils.aggiornaSLPortale(fakeList, 'OLO_ActivationTO_OM');
        }
        
        
        //aggiorno l'ordine solo se non è retry
        if(!OF_CO_GE_Utils.retry){
            //LOGGO LA REQUEST 
            OF_CO_GE_Utils.create_EAI_Log(wsInput);
            OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(c);
        }
        
        //Inserisco il log
        insert OF_CO_GE_Utils.slSFOMResp;
        return respTemp.Esito;
        //Update per settare il campo
        //update c;
        
    }
    //Metodo per il map CEI VLAN -> VLAN ws
    private static List<GW_ChangeSetupOpenStream_Input.VLAN_element> mapVLAN(List<OF_CommercialElementIstanziato__c> listVLANToMap){
        //Creo la lista che restituirò
        List<GW_ChangeSetupOpenStream_Input.VLAN_element> wsVLANList = new List<GW_ChangeSetupOpenStream_Input.VLAN_element>();
        //Setto i valori nella nuova lista
        for(OF_CommercialElementIstanziato__c vlan : listVLANToMap){
            GW_ChangeSetupOpenStream_Input.VLAN_element vlanToAdd = new GW_ChangeSetupOpenStream_Input.VLAN_element();
                vlanToAdd.KIT_CONSEGNA_VLAN = vlan.OF_KITCONSEGNAVLAN__C;
                vlanToAdd.USER_VLAN = vlan.OF_USERVLAN__C;
                vlanToAdd.SERVICE_VLAN = vlan.OF_SERVICEVLAN__C;
                vlanToAdd.PROFILO_VLAN = vlan.OF_PROFILOVLAN__C;
                vlanToAdd.CUSTOMER_VLAN = vlan.OF_CUSTOMERVLAN__C;
                vlanToAdd.MODELLO_DI_SERVIZIO_VLAN = vlan.OF_MODELLODISERVIZIOVLAN__C;
                vlanToAdd.INFORMAZIONI_VLAN = vlan.OF_INFORMAZIONIVLAN__C;
            wsVLANList.add(vlanToAdd);
        }
        return wsVLANList;
    }
}
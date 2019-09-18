public class OF_PP_OLO_SendToOM {
    
    public static String reqNot;
    
    //INIZIO - PG - DEV - Metodo chiamato nella classe OF_PP_OLO_AsyncChecks (SVLAN_AsyncActivation)
    public static void OM_CreateAckNackRequestActivation(List<EOF_EAI_Service_Log__C> sList)
    {
        //OF_PP_WS_VLAN_OM_Response
        OF_PP_WS_VLAN_OM_Response.Esito_element respTemp;
        
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if(OF_PP_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c)
        {
            respTemp = new OF_PP_WS_VLAN_OM_Response.Esito_element();
            respTemp.Esito='0';
            //resetto il campo a false per evitare problemi successivi
            OF_PP_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c = false;
            system.debug('##### OM_CreateAckNackRequestActivation - IF OF_Bonifica_Locked_Row__c');
        }
        else
        {
            //inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM
            //OF_PP_WS_VLAN_OM_Activation
            system.debug('##### OM_CreateAckNackRequestActivation - ELSE OF_Bonifica_Locked_Row__c');
            OF_PP_WS_VLAN_OM_Activation.AsyncActivation_PreProvisioning_OpenStreamPortTypeEndpoint0 stub = new OF_PP_WS_VLAN_OM_Activation.AsyncActivation_PreProvisioning_OpenStreamPortTypeEndpoint0();
            
            //set timeout
            stub.timeout_x = 30000;
            respTemp = stub.Activation_PreProvisioning_OpenStream(sList);
        }

        if(respTemp.Esito=='0')
        {
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_PP_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_PP_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            System.debug('***respTemp.Esito == 0 --->Creo il log di ACK');
            System.debug('Testing'+OF_PP_GE_Utils.rtMap);
            OF_PP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='OM->SF - ACK - ActivationVLAN',
                OF_SA_Direzione_Flusso__c='OM-SF',
                OF_SA_Metodo__c='OLO_ActivationVLANSetup_OpenStream',
                Caso__c = OF_PP_GE_Utils.CaseOriginale.Id, 
                RecordTypeId = OF_PP_GE_Utils.rtMap.get('OF_PP_VLAN_ACK'),
                EOF_Codice_Operatore__c = OF_PP_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
                //EOF_Codice_Ordine_Olo__c = OF_PP_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = OF_PP_GE_Utils.slSFOM.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'OK',
                EOF_ID_NOTIFICA__C = OF_PP_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
                OF_SA_ESITO__C = respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
                EOF_Retry__c = OF_PP_GE_Utils.retry    
            );
            
            update OF_PP_GE_Utils.caseOriginale;
            insert OF_PP_GE_Utils.slSFOMResp;
        } 
        else
        {
           //aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
           OF_PP_GE_Utils.slSFOM.OF_SA_ACK__c=false;
           OF_PP_GE_Utils.slSFOM.EOF_Response__C='NACK';
           OF_PP_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
            
           System.debug('***respTemp.Esito == 1 --->Creo il log di NACK');
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
                System.debug('****respTemp.CODICE_MOTIVAZIONE****: '+respTemp.CODICE_MOTIVAZIONE);
           }
           else{
                OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }
           System.debug('***OF_PP_GE_Utils.caseOriginale***:'+OF_PP_GE_Utils.caseOriginale);
            
           OF_PP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='OM->SF - NACK - ActivationVLAN',
                OF_SA_Direzione_Flusso__c='OM-SF',
                OF_SA_Metodo__c='OLO_ActivationVLANSetup_OpenStream',
                Caso__c = OF_PP_GE_Utils.CaseOriginale.Id,
                RecordTypeId = OF_PP_GE_Utils.rtMap.get('OF_PP_VLAN_NACK'),
                EOF_Codice_Operatore__c = OF_PP_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
                //EOF_Codice_Ordine_Olo__c=OF_PP_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = OF_PP_GE_Utils.slSFOM.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'KO',
                EOF_ID_NOTIFICA__C = OF_PP_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
                OF_SA_ESITO__C = respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
                EOF_Retry__c = OF_PP_GE_Utils.retry
            );
            System.debug('*****OF_PP_GE_Utils.slSFOMResp*****:'+OF_PP_GE_Utils.slSFOMResp);
            
            update OF_PP_GE_Utils.caseOriginale;
            insert OF_PP_GE_Utils.slSFOMResp;
        }
    }
    //END - PG - DEV - Metodo chiamato nella classe OF_PP_OLO_AsyncChecks (SVLAN_AsyncActivation)
    
    /*
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestStatusUpdate(EOF_EAI_Service_Log__C sl){
        
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        //set timeout 
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.StatusUpdateOM(sl);
        
        system.debug('OSCRM OF_SA_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate--respTemp:'+respTemp);
        
        EOF_EAI_Service_Log__c slResp;
        
        if(respTemp.Esito=='0'){
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - StatusUpdate',
            Caso__c = sl.caso__c,
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_StatusUpdate',
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE    
            ); 
            
        } 
        else{
            system.debug('la response esito è: '+respTemp.Esito);
            respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - StatusUpdate',
            Caso__c = sl.caso__c,
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_StatusUpdate',
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE
            );
        }
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        
        system.debug('OSCRM OF_SA_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate--response:'+response);
        return response;
        
    }
    */
    /*
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestReschedule(EOF_EAI_Service_Log__C sl){

        OF_SA_WS_OM_Reschedule.RischedulazionePortTypeEndpoint stub = new OF_SA_WS_OM_Reschedule.RischedulazionePortTypeEndpoint();
        
        //set timeout
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.RescheduleOM(sl);
        EOF_EAI_Service_Log__c slResp;
        
        if(respTemp.Esito=='0'){
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Reschedule',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_Reschedule',
            Caso__c = sl.caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE    
            ); 
            
        } 
        else{
            system.debug('############################################## '+respTemp.Esito);
            respTemp.esito='1';
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - Reschedule',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_Reschedule',
            Caso__c = sl.caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE
            );
        }
        
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
        
    }
    */
    
    /*
    //metodo per l'invio sincrono ad OM a valle dell'acquisizione KO
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestDeactivation(List<EOF_EAI_Service_Log__C> sList){

        OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint stub = new OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint();
        
        //set timeout
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.DeactivationOrderOM(sList);
        
        
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_PP_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_PP_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';

            OF_PP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - DeactivationRequest',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_DeactivationOrder',
            Caso__c = sList[0].caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = sList[0].EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sList[0].EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sList[0].EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_PP_GE_Utils.retry     
            ); 
            
        } 
        else{
            //setto l'esito perche OM puo rispondere con qualsiasi numero
            respTemp.Esito='1';
            
            //aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_PP_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_PP_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_PP_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
                       
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
                OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }

            OF_PP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - DeactivationRequest',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_DeactivationOrder',
            Caso__c = sList[0].caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = sList[0].EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sList[0].EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sList[0].EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_PP_GE_Utils.retry 
            );
        }
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
         
    }
    */
    
    /*
    //metodo per l'invio asincrono ad OM
    @future(callout=true)
    public static void OM_CreateAckNackRequestDeactivation(String slId){
        
        List<EOF_EAI_Service_Log__c> sList = [select EOF_CODICE_OPERATORE__c, EOF_CODICE_ORDINE_OLO__c, EOF_CODICE_ORDINE_EOF__c, EOF_DATA_NOTIFICA__c, 
        EOF_ID_NOTIFICA__c, EOF_CODICE_MOTIVAZIONE__c, EOF_MOTIVAZIONE__c, EOF_GPON_Attestazione__c, EOF_NOME_CLIENTE__c, EOF_COGNOME_CLIENTE__c, 
        EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, EOF_NOTE__c, EOF_ID_RISORSA__c , EOF_TIPO_COMUNICAZIONE__c , 
        EOF_SORGENTE__c , EOF_SLA_DATE__c , EOF_GPON_VINCOLANTE__c , EOF_OPZIONE_SYSTEM_UNICO__c , EOF_COLLEGAMENTO_P2P__c , EOF_TRACCIATO__c , 
        EOF_ID_SERVIZIO__c , EOF_PROFILO__c , EOF_Provincia__c , EOF_Comune__c, EOF_Particella_Toponomastica__c , EOF_Indirizzo__c , EOF_Numero_Civico__c,
        EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__c, EOF_Tipo_Comunicazione_String__C, recordType.name,recordType.developername,Caso__c
        from EOF_EAI_Service_Log__c where ID=:slId or OF_SA_Cpe_Log__c=:slid Order by createdDate ASC];
        
        
        //setto la variabile statica
        for(EOF_EAI_Service_Log__c sl : sList){
            if(sl.recordType.developername=='OF_SA_FiberRequest'){
                OF_PP_GE_Utils.slSFOM=sl;
            }
        }
        
        //tiro fuori il case
        OF_PP_GE_Utils.caseOriginale=[select id from case where id=:OF_PP_GE_Utils.slSFOM.caso__c];
        
        //setto la mappa dei recordtype
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_PP_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_PP_GE_Utils.rtMap.put(rt.developerName, rt.Id); 
        }
        OF_PP_GE_Utils.checkrtMap=true;
        
        OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint stub = new OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint();
        
        //set timeout
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.DeactivationOrderOM(sList);
        
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_PP_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_PP_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            OF_PP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Deactivation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_DeactivationOrder',
            Caso__c = OF_PP_GE_Utils.slSFOM.caso__c,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_PP_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_PP_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_PP_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_PP_GE_Utils.retry    
            ); 
            
        } 
        else{
            //aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_PP_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_PP_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_PP_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
           
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
                OF_PP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }
           
            OF_PP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - Deactivation',
            Caso__c = OF_PP_GE_Utils.slSFOM.caso__c,
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_DeactivationOrder',
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_PP_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_PP_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_PP_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_PP_GE_Utils.retry
            );
        }
        update OF_PP_GE_Utils.caseOriginale;
        insert OF_PP_GE_Utils.slSFOMResp;  
    }
    */
}
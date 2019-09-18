public class OF_SA_OLO_SendToOMNew {
    public static String reqNot;
    
    public static void OM_CreateAckNackRequestActivationNew(List<EOF_EAI_Service_Log__C> sList){
        
        OF_WS_OM_Schema_Res_ActivationNew.Esito_element respTemp;
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if(OF_SA_GE_UtilsNew.caseOriginale.OF_Bonifica_Locked_Row__c){
        	respTemp= new OF_WS_OM_Schema_Res_ActivationNew.Esito_element();
        	respTemp.Esito='0';
        	//resetto il campo a false per evitare problemi successivi
        	OF_SA_GE_UtilsNew.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }else{    
            OF_WS_OM_ActivationNew.PortTypeEndpoint3 stub = new OF_WS_OM_ActivationNew.PortTypeEndpoint3();
            
            //set timeout
            stub.timeout_x = 30000;
            
            respTemp = stub.ActivationSetup(sList);
            
        }

        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_GE_UtilsNew.slSFOM.OF_SA_ACK__c=true;
            OF_SA_GE_UtilsNew.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            OF_SA_GE_UtilsNew.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
            Caso__c = OF_SA_GE_UtilsNew.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_GE_UtilsNew.retry    
            ); 
            
        } 
        else{
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_SA_GE_UtilsNew.slSFOM.OF_SA_ACK__c=false;
            OF_SA_GE_UtilsNew.slSFOM.EOF_Response__C='NACK';
            OF_SA_GE_UtilsNew.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;

           
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
                //Done AA - Aggiungerò qui il flusso su cui fare la retry
                OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';
           }
           else{
           		OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK';
           }
            
            OF_SA_GE_UtilsNew.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
            Caso__c = OF_SA_GE_UtilsNew.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_GE_UtilsNew.retry
            );
        }
        
    }
    //Attivazione verso OM passivi
    public static void OM_CreateAckNackRequestActivationNew_GPONP(List<EOF_EAI_Service_Log__C> sList){
        
        OF_WS_OM_Schema_Res_ActivationNew.Esito_element respTemp;
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if(OF_GPONP_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
        	respTemp= new OF_WS_OM_Schema_Res_ActivationNew.Esito_element();
        	respTemp.Esito='0';
        	//resetto il campo a false per evitare problemi successivi
        	OF_GPONP_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{
            //AA - Come richiesto dal 17/12/18, se il CodOrdOLO comincia con TEST_ bisogna mockare la chiamata
            /*if(!OF_GPONP_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c.startsWithIgnoreCase('TEST_')){
                respTemp = new OF_WS_OM_Schema_Res_ActivationNew.Esito_element();
        	    respTemp.ESITO = '0';
                respTemp.MOTIVAZIONE = 'STUBBED ACK';
            }else{*/
                //inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM
                OF_WS_OM_ActivationNew.PortTypeEndpoint3 stub = new OF_WS_OM_ActivationNew.PortTypeEndpoint3();	        
                //set timeout
                stub.timeout_x = 30000;	        
                respTemp = stub.ActivationSetup(sList);
            //}           
        }

        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_GPONP_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_GPONP_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            OF_GPONP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup',
            Caso__c = OF_GPONP_GE_Utils.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_GPONP_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_GPONP_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_GPONP_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_GPONP_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_GPONP_GE_Utils.retry    
            ); 
            
        } 
        else{
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_GPONP_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_GPONP_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_GPONP_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;

           
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
           		OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }
            
            OF_GPONP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup',
            Caso__c = OF_GPONP_GE_Utils.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_GPONP_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_GPONP_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_GPONP_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_GPONP_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_GPONP_GE_Utils.retry
            );
        }
        
    }

    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestStatusUpdateNew(EOF_EAI_Service_Log__C sl){
        OF_WS_OM_Schema_Res_SUpdateNew.Esito_element respTemp;
    
        OF_WS_OM_SUpdateNew.PortTypeEndpoint6 stub = new OF_WS_OM_SUpdateNew.PortTypeEndpoint6();
        
        //set timeout 
        stub.timeout_x = 30000;
        
        respTemp = stub.StatusUpdate(sl);        

        EOF_EAI_Service_Log__c slResp;
        
        if(respTemp.Esito=='0'){
            OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='ACK';
            
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
            //setto il NACK sul case
            if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
                //Done AA - Aggiungerò qui il flusso su cui fare la retry
                OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c = 'OLO_StatusUpdate';                
            }
            else{
                OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK';                
            }
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
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestStatusUpdateNew_GPONP(EOF_EAI_Service_Log__C sl){
        OF_WS_OM_Schema_Res_SUpdateNew.Esito_element respTemp;
        //AA - Come richiesto dal 17/12/18, se il CodOrdOLO comincia con TEST_ bisogna mockare la chiamata
        /*if(!sl.EOF_Codice_Ordine_Olo__c.startsWithIgnoreCase('TEST_')){
            respTemp = new OF_WS_OM_Schema_Res_SUpdateNew.Esito_element();
            respTemp.ESITO = '0';
            respTemp.MOTIVAZIONE = 'STUBBED ACK';
        }else{*/
            OF_WS_OM_SUpdateNew.PortTypeEndpoint6 stub = new OF_WS_OM_SUpdateNew.PortTypeEndpoint6();
            
            //set timeout 
            stub.timeout_x = 30000;
            
            respTemp = stub.StatusUpdate(sl);        
        //}
        EOF_EAI_Service_Log__c slResp;
        
        if(respTemp.Esito=='0'){
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
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
            //setto il NACK sul case
            if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
                //Done AA - Aggiungerò qui il flusso su cui fare la retry
                OF_GPONP_GE_Utils.caseOriginale.OF_Flusso_Retry__c = 'OLO_StatusUpdate';
            }else{
                OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
            }
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
    //Nuovo metodo per sky
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestRescheduleNew(EOF_EAI_Service_Log__C sl){
        OF_WS_OM_Schema_Res_RescheduleNew.Esito_element respTemp;

        OF_WS_OM_RescheduleNew.PortTypeEndpoint5 stub = new OF_WS_OM_RescheduleNew.PortTypeEndpoint5();
        
        //set timeout
        stub.timeout_x = 30000;
        
        respTemp = stub.Reschedule(sl); 
        
        EOF_EAI_Service_Log__c slResp;
        
        if(respTemp.Esito=='0'){
            OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            
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
            //setto il NACK sul case
            if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
                //Done AA - Aggiungerò qui il flusso su cui fare la retry
                OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c = 'OLO_Reschedule';                                
            }else{
                OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK';               
            }
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
    //Nuovo metodo per sky
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestRescheduleNew_GPONP(EOF_EAI_Service_Log__C sl){
        OF_WS_OM_Schema_Res_RescheduleNew.Esito_element respTemp;
        /*if(!sl.EOF_Codice_Ordine_Olo__c.startsWithIgnoreCase('TEST_')){
            respTemp = new OF_WS_OM_Schema_Res_RescheduleNew.Esito_element();
            respTemp.ESITO = '0';
            //respTemp.CODICE_MOTIVAZIONE = '100';
            respTemp.MOTIVAZIONE = 'STUBBED ACK';
        }else{*/
            OF_WS_OM_RescheduleNew.PortTypeEndpoint5 stub = new OF_WS_OM_RescheduleNew.PortTypeEndpoint5();
            
            //set timeout
            stub.timeout_x = 30000;
            
            respTemp = stub.Reschedule(sl); 
        //}
        
        EOF_EAI_Service_Log__c slResp;
        
        if(respTemp.Esito=='0'){
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
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
            
        }else{
        	respTemp.esito='1';
            //setto il NACK sul case
            if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
                //Done AA - Aggiungerò qui il flusso su cui fare la retry
                OF_GPONP_GE_Utils.caseOriginale.OF_Flusso_Retry__c = 'OLO_Reschedule';                
            }else{
                OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
            }
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
    //metodo per l'invio sincrono ad OM a valle dell'acquisizione KO
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestDeactivationNew(List<EOF_EAI_Service_Log__C> sList){
        OF_WS_OM_Schema_Res_DeactivationNew.Esito_element respTemp;

        OF_WS_OM_DeactivationOrderNew.PortTypeEndpoint4 stub = new OF_WS_OM_DeactivationOrderNew.PortTypeEndpoint4();
        
        //set timeout
        stub.timeout_x = 30000;
        
        respTemp = stub.DeactivationOrder(sList);
        
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_GE_UtilsNew.slSFOM.OF_SA_ACK__c=true;
            OF_SA_GE_UtilsNew.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='ACK';

            OF_SA_GE_UtilsNew.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_SA_GE_UtilsNew.retry     
            ); 
            
        } 
        else{
        	//setto l'esito perche OM puo rispondere con qualsiasi numero
        	respTemp.Esito='1';
        	
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_SA_GE_UtilsNew.slSFOM.OF_SA_ACK__c=false;
            OF_SA_GE_UtilsNew.slSFOM.EOF_Response__C='NACK';
            OF_SA_GE_UtilsNew.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
                       
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
           		OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OM__c='NACK';
           }

            OF_SA_GE_UtilsNew.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_SA_GE_UtilsNew.retry 
            );
        }
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
         
    }
    //Metodo per l'invio della cessazione passiva
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestDeactivationNew_GPONP(List<EOF_EAI_Service_Log__C> sList){
        OF_WS_OM_Schema_Res_DeactivationNew.Esito_element respTemp;
        //AA - Come richiesto dal 17/12/18, se il CodOrdOLO comincia con TEST_ bisogna mockare la chiamata
        /*if(!sList[0].EOF_Codice_Ordine_Olo__c.startsWithIgnoreCase('TEST_')){
            respTemp = new OF_WS_OM_Schema_Res_DeactivationNew.Esito_element();
            respTemp.ESITO = '0';
            respTemp.MOTIVAZIONE = 'STUBBED ACK';
        }else{*/
            OF_WS_OM_DeactivationOrderNew.PortTypeEndpoint4 stub = new OF_WS_OM_DeactivationOrderNew.PortTypeEndpoint4();
            
            //set timeout
            stub.timeout_x = 30000;
            
            respTemp = stub.DeactivationOrder(sList);
        //}
        
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_GPONP_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_GPONP_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';

            OF_GPONP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_GPONP_GE_Utils.retry     
            ); 
            
        } 
        else{
        	//setto l'esito perche OM puo rispondere con qualsiasi numero
        	respTemp.Esito='1';
        	
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_GPONP_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_GPONP_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_GPONP_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
                       
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
           		OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }

            OF_GPONP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_GPONP_GE_Utils.retry 
            );
        }
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
         
    }
}
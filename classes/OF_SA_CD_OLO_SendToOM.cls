public class OF_SA_CD_OLO_SendToOM {
     
    public static String reqNot;
    
    public static void OM_CreateAckNackRequestActivation(List<EOF_EAI_Service_Log__C> sList){
        
        OF_SA_WS_OM_Response.Esito_element respTemp;
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if(OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
        	respTemp = new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito='0';
        	//resetto il campo a false per evitare problemi successivi
        	OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{
        	//qui mockiamo OM
        	/*
        	//inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM
	        OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint stub = new OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.ActivationOpenStreamOM(sList);
	        */
	        respTemp = new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito = '0';
        }

        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c = true;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C = 'ACK';
            
            //setto l'ACK sul case
            OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c = 'ACK';
            
            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
            Caso__c = OF_SA_CD_GE_Utils.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_SA_CD_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry    
            ); 
        } 
        else
        {
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
           
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }
            
            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
            Caso__c = OF_SA_CD_GE_Utils.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_CD_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry
            );
        }
    }
    
    /*
    public static void OM_CreateAckNackRequestActivationNew(List<EOF_EAI_Service_Log__C> sList){
        
        OF_SA_WS_OM_Response.Esito_element respTemp;
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if(OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
        	respTemp= new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito='0';
        	//resetto il campo a false per evitare problemi successivi
        	OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{
        	//inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM

	        /*MOCKED WS
            OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint stub = new OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.ActivationOpenStreamOM(sList);
	        */
            
        /*
            respTemp= new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito='0';
        }

        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
            Caso__c = OF_SA_CD_GE_Utils.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_SA_CD_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry    
            ); 
        } 
        else
        {
            //aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
            
            //setto il NACK sul case
            if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
               	OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
            }
            else{
               	OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
            }
            
            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream',
            Caso__c = OF_SA_CD_GE_Utils.CaseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_CD_GE_Utils.slSFOM.EOF_ID_NOTIFICA__C,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry
            );
        }
    }
    */
    
    /*
    //Attivazione verso OM passivi
    public static void OM_CreateAckNackRequestActivationNew_GPONP(List<EOF_EAI_Service_Log__C> sList){
        
        OF_SA_WS_OM_Response.Esito_element respTemp;
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if(OF_GPONP_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
        	respTemp= new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito='0';
        	//resetto il campo a false per evitare problemi successivi
        	OF_GPONP_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{
        	//inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM
        */
	        /*MOCKED WS
            OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint stub = new OF_SA_WS_OM_Activation.AttivazioneGponaPortTypeEndpoint();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.ActivationOpenStreamOM(sList);
	        */
	   /*
            
            respTemp= new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito='0';
        }

        if(respTemp.Esito=='0')
        {
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_GPONP_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_GPONP_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            OF_GPONP_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Activation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_ActivationSetup_GPONP',
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
        */
        //Add PG - 11-12 - Chiamata mockata respTemp è sempre 0, commento l'else
        /*
        else
        {
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
            OF_SA_Metodo__c='OLO_ActivationSetup_GPONP',
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
    */
    
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestStatusUpdate(EOF_EAI_Service_Log__C sl){
        
        /*AA - Mockato la request
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        //set timeout 
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.StatusUpdateOM(sl);*/
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito = '0';
        
        system.debug('OSCRM OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate--respTemp:'+respTemp);
        
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
        else
        {
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
        
        system.debug('OSCRM OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate--response:'+response);
        return response;
    }
    
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestReschedule(EOF_EAI_Service_Log__C sl){

        /*AA Mocko la chiamata
        OF_SA_WS_OM_Reschedule.RischedulazionePortTypeEndpoint stub = new OF_SA_WS_OM_Reschedule.RischedulazionePortTypeEndpoint();
        
        //set timeout
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.RescheduleOM(sl);
        */
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito = '0';
        
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
        //Add PG - 11-12 - Chiamata mockata respTemp è sempre 0, commento l'else
        /*
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
        */
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
        
    }
    //metodo per l'invio sincrono ad OM a valle dell'acquisizione KO
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestDeactivation(List<EOF_EAI_Service_Log__C> sList){
		/*
        OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint stub = new OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint();
        
        //set timeout
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.DeactivationOrderOM(sList);
        */
        OF_SA_WS_OM_Response.Esito_element respTemp= new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito='0';
        
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';

            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry     
            ); 
        } 
        //Add PG - 11-12 - Chiamata mockata respTemp è sempre 0, commento l'else
        /*
        else
        {
        	//setto l'esito perche OM puo rispondere con qualsiasi numero
        	respTemp.Esito='1';
        	
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
                       
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }

            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry 
            );
        }
        */
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
         
    }
    //metodo per l'invio sincrono ad OM a valle dell'acquisizione KO
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRequestDeactivationNew(List<EOF_EAI_Service_Log__C> sList){

        /*AA - Mocko la request
        OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint stub = new OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint();
        
        //set timeout
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.DeactivationOrderOM(sList);
        */
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
            respTemp.Esito = '0';
            
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';

            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry     
            ); 
        }
        /*
        else
        {
        	//setto l'esito perche OM puo rispondere con qualsiasi numero
        	respTemp.Esito='1';
        	
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
                       
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }

            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
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
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry 
            );
        }
        */
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
         
    }
    //metodo per l'invio asincrono ad OM
    @future(callout=true)
    public static void OM_CreateAckNackRequestDeactivation(String slId){
        
        List<EOF_EAI_Service_Log__c> sList = [select EOF_CODICE_OPERATORE__c, EOF_CODICE_ORDINE_OLO__c, EOF_CODICE_ORDINE_EOF__c, EOF_DATA_NOTIFICA__c, 
   											  EOF_ID_NOTIFICA__c, EOF_CODICE_MOTIVAZIONE__c, EOF_MOTIVAZIONE__c, EOF_GPON_Attestazione__c, 
   											  EOF_NOME_CLIENTE__c, EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, 
   											  EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, EOF_NOTE__c, EOF_ID_RISORSA__c , EOF_TIPO_COMUNICAZIONE__c , 
											  EOF_SORGENTE__c , EOF_SLA_DATE__c , EOF_GPON_VINCOLANTE__c , EOF_OPZIONE_SYSTEM_UNICO__c , 
											  EOF_COLLEGAMENTO_P2P__c, EOF_TRACCIATO__c, EOF_ID_SERVIZIO__c , EOF_PROFILO__c , EOF_Provincia__c,
											  EOF_Comune__c, EOF_Particella_Toponomastica__c , EOF_Indirizzo__c , EOF_Numero_Civico__c,
											  EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__c, EOF_Tipo_Comunicazione_String__C, 
											  recordType.name,recordType.developername,Caso__c
											  from EOF_EAI_Service_Log__c 
											  where ID=:slId 
											  or OF_SA_Cpe_Log__c=:slid 
											  Order by createdDate ASC];
        
        
        //setto la variabile statica
        for(EOF_EAI_Service_Log__c sl : sList){
        	if(sl.recordType.developername=='PO_SA_CD_Log_OpenStreamRequest'){
        		OF_SA_CD_GE_Utils.slSFOM=sl;
        	}
        }
        
        //tiro fuori il case
        OF_SA_CD_GE_Utils.caseOriginale=[select id from case where id=:OF_SA_CD_GE_Utils.slSFOM.caso__c];
        
        /*
        OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint stub = new OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint();
        
        //set timeout
        stub.timeout_x = 30000;
        
        OF_SA_WS_OM_Response.Esito_element respTemp = stub.DeactivationOrderOM(sList);
        */
        OF_SA_WS_OM_Response.Esito_element respTemp= new OF_SA_WS_OM_Response.Esito_element();
        	respTemp.Esito='0';
        	
        if(respTemp.Esito=='0'){
        	//aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='ACK';
            
            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - ACK - Deactivation',
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_DeactivationOrder',
            Caso__c = OF_SA_CD_GE_Utils.slSFOM.caso__c,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_ACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry    
            ); 
        }
        //Add PG - 11-12 - Chiamata mockata respTemp è sempre 0, commento l'else
        /*
        else
        {
        	//aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_SA_CD_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
           
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OM__c='NACK';
           }
           
            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OM - NACK - Deactivation',
            Caso__c = OF_SA_CD_GE_Utils.slSFOM.caso__c,
            OF_SA_Direzione_Flusso__c='SF-OM',
            OF_SA_Metodo__c='OLO_DeactivationOrder',
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_NACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOM.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOM.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=respTemp.ID_NOTIFICA,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry
            );
        }
        */
        update OF_SA_CD_GE_Utils.caseOriginale;
        insert OF_SA_CD_GE_Utils.slSFOMResp;  
    }
    
    //Add by PG - 27-12 Metodi copiati dalla classe OF_CO_OLO_SendToOM
    public static String OM_CreateAckNackRequestActivation_ChOrd(Case c, List<OF_CommercialElementIstanziato__c> listVLANToMap){

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
            wsInput.ID_SERVIZIO = c.OF_SA_ID_Servizio__c;
            wsInput.PROFILO = c.OF_SA_Profilo__c;
            wsInput.VLAN = mapVLAN(listVLANToMap);
        
        //Variabile esito chiamata
        GW_ChangeSetupOpenStream_Response.Esito_element respTemp = new GW_ChangeSetupOpenStream_Response.Esito_element();
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if( OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
            respTemp.Esito='0';
            //resetto il campo a false per evitare problemi successivi
            OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{ 
            
            //Done AA: Sostituire la chiamata dal vecchio servizio, al nuovo servizio!!
            //inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM
            //qui mockiamo OM
            
            /*
            GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1 stub = new GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1();           
            //set timeout
            stub.timeout_x = 30000;
            //Done AA: richiamare metodo nuovo
            respTemp = stub.ChangeSetupOpenStream(wsInput);
            */
            respTemp = new GW_ChangeSetupOpenStream_Response.Esito_element();
        	respTemp.Esito = '0';
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
            
            OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
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
                EOF_Retry__c = OF_SA_CD_GE_Utils.retry,
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
           OF_SA_CD_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c = 'SF->OM - NACK - ChangeOrderRequest',
                OF_SA_Direzione_Flusso__c = 'SF-OM',
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
                EOF_Retry__c = OF_SA_CD_GE_Utils.retry,
                OF_SA_ACK__c = false
            );
        }
        System.debug('#####Sono qui######');
        System.debug('>>>>>OF_SA_CD_GE_Utils.caseOriginale.PO_SA_Portale__c >>>> : '+OF_SA_CD_GE_Utils.caseOriginale.PO_SA_Portale__c);
        System.debug('>>>>>OF_SA_CD_GE_Utils.retry >>>> : '+OF_SA_CD_GE_Utils.retry);
        
        //Aggiorno lo stato su sLog da portale (solo la prima volta e non nel retry)
        if(OF_SA_CD_GE_Utils.caseOriginale.PO_SA_Portale__c && !OF_SA_CD_GE_Utils.retry){
            System.debug('<<<< Sono dentro IF >>>>');
            EOF_EAI_Service_Log__c fakeLog = new EOF_EAI_Service_Log__c();
            fakeLog.EOF_COdice_Ordine_OLO__c = c.EOF_Codice_Ordine_OLO__c;
            List<EOF_EAI_Service_Log__c> fakeList = new List<EOF_EAI_Service_Log__c>();
            fakeList.add(fakeLog);
            OF_SA_CD_GE_Utils.aggiornaSLPortale(fakeList, 'OLO_ActivationTO_OM');
        }
        //aggiorno l'ordine solo se non è retry
        if(!OF_SA_CD_GE_Utils.retry){
            //LOGGO LA REQUEST 
            OF_SA_CD_GE_Utils.create_EAI_Log(wsInput);
            OF_ManageOrderFromCase_CD.manageOrderSyncChOrd(c);
        }
        //Inserisco il log
        insert OF_SA_CD_GE_Utils.slSFOMResp;
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
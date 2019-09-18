public class OF_OM_SendToOLONew {
    
    //Attivi - StatusUpdate dopo OLO_Activation
    public static OF_Schema_StatusUpdateNew.StatusUpdateResponseType OM_CreateAckNackNotifyStatusUpdateNew(EOF_EAI_Service_Log__C sl){  
        
        OF_Schema_StatusUpdateNew.StatusUpdateResponseType respTemp;
        if(!OF_SA_GE_UtilsNew.caseOriginale.PO_SA_Portale__C && !OF_SA_GE_UtilsNew.caseOriginale.OF_Bonifica_Locked_Row__c){
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@ Attenzione entrato qui');
            //Done AA - Sostituire ws
            OF_StatusUpdateNew.StatusUpdateEndpoint stub = new OF_StatusUpdateNew.StatusUpdateEndpoint();
            respTemp = new OF_Schema_StatusUpdateNew.StatusUpdateResponseType();
            
            //set timeout
            stub.timeout_x = 30000; 
            
            respTemp = stub.StatusUpdate(OF_SA_GE_UtilsNew.slSFOLO); 
            
        }
        //fingiamo l'ACK da OLO in caso di inserimento da portale
        else{
            respTemp=new OF_Schema_StatusUpdateNew.StatusUpdateResponseType();
            respTemp.Esito='0'; 
        }
        //----- 2017_08_29 Alessandro: fine modifica 2
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_GE_UtilsNew.slSFOLO.OF_SA_ACK__c=true;
            OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OLO__c='ACK';
            
            OF_SA_GE_UtilsNew.slSFOLOResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - StatusUpdate',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate', 
                Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'OK',
                EOF_ID_NOTIFICA__C=sl.EOF_ID_Notifica__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_Retry__c=OF_SA_GE_UtilsNew.retry    
            ); 
            
        } 
        else{
            //aggiungo la ricezione del NACK sul service Log della notifica all'OLO
            OF_SA_GE_UtilsNew.slSFOLO.OF_SA_ACK__c=false;
            OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__C='NACK';
            OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
            
            //setto il NACK sul case
            if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OLO__c='NACK TECNICO';
                //Done AA - Aggiungerò qui il flusso su cui fare la retry
                if(OF_SA_GE_UtilsNew.slSFOLO.EOF_Tipo_Comunicazione__c == '5'){
                    OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';
                }else{
                    OF_SA_GE_UtilsNew.caseOriginale.OF_Flusso_Retry__c = 'OLO_Deactivation';
                }
            }
            else{
                OF_SA_GE_UtilsNew.caseOriginale.OF_Response_Da_OLO__c='NACK';
            }
            
            OF_SA_GE_UtilsNew.slSFOLOResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - StatusUpdate',
                Caso__c = OF_SA_GE_UtilsNew.caseOriginale.Id,
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate',
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'KO',
                EOF_ID_NOTIFICA__C=sl.EOF_ID_Notifica__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_Codice_Errore__c=respTemp.CODICE_MOTIVAZIONE,
                EOF_Causale_Errore__c=respTemp.MOTIVAZIONE,
                EOF_Retry__c=OF_SA_GE_UtilsNew.retry
            );
            
        }
        return resptemp;
    }
    //Passivi - StatusUpdate dopo OLO_Activation
    public static OF_GPONP_Schema_Res_StatusUpdateNew.Response_element OM_CreateAckNackNotifyStatusUpdateNew_GPONP(EOF_EAI_Service_Log__C sl){  
         
        OF_GPONP_Schema_Res_StatusUpdateNew.Response_element respTemp;
        if(!OF_GPONP_GE_Utils.caseOriginale.PO_SA_Portale__C && !OF_GPONP_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
            //Chiamo il nuovo ws
            OF_GPONP_StatusUpdateNew.StatusUpdate_GPONPEndpoint4 stub = new OF_GPONP_StatusUpdateNew.StatusUpdate_GPONPEndpoint4();
            stub.timeout_x = 30000;

            respTemp = stub.StatusUpdate_GPONP(OF_GPONP_GE_Utils.slSFOLO);
        }
        //fingiamo l'ACK da OLO in caso di inserimento da portale
        else{
            respTemp=new OF_GPONP_Schema_Res_StatusUpdateNew.Response_element();
            respTemp.Esito='0'; 
        }
        //----- 2017_08_29 Alessandro: fine modifica 2
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_GPONP_GE_Utils.slSFOLO.OF_SA_ACK__c=true;
            OF_GPONP_GE_Utils.slSFOLO.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='ACK';
            
            OF_GPONP_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - StatusUpdate',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate', 
                Caso__c = OF_GPONP_GE_Utils.caseOriginale.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'OK',
                EOF_ID_NOTIFICA__C=sl.EOF_ID_Notifica__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_Retry__c=OF_GPONP_GE_Utils.retry    
            ); 
            
        } 
        else{
            //aggiungo la ricezione del NACK sul service Log della notifica all'OLO
            OF_GPONP_GE_Utils.slSFOLO.OF_SA_ACK__c=false;
            OF_GPONP_GE_Utils.slSFOLO.EOF_Response__C='NACK';
            OF_GPONP_GE_Utils.slSFOLO.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
            
            //setto il NACK sul case
            if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK TECNICO';
                //Done AA - Aggiungerò qui il flusso su cui fare la retry
                if(OF_GPONP_GE_Utils.slSFOLO.EOF_Tipo_Comunicazione__c == '5'){
                    OF_GPONP_GE_Utils.caseOriginale.OF_Flusso_Retry__c = 'OLO_Activation';
                }else{
                    OF_GPONP_GE_Utils.caseOriginale.OF_Flusso_Retry__c = 'OLO_Deactivation';
                }
            }
            else{
                OF_GPONP_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK';
            }
            
            OF_GPONP_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - StatusUpdate',
                Caso__c = OF_GPONP_GE_Utils.caseOriginale.Id,
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate',
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'KO',
                EOF_ID_NOTIFICA__C=sl.EOF_ID_Notifica__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_Codice_Errore__c=respTemp.CODICE_MOTIVAZIONE,
                EOF_Causale_Errore__c=respTemp.MOTIVAZIONE,
                EOF_Retry__c=OF_GPONP_GE_Utils.retry
            );
            
        }
        return resptemp;
    }
    //Nuovo metodo per ws OM_StatusUpdateUnificato
    //per tutti gli altri metodi dello status update 
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackStatusUpdateDaOMNew(Case c,OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su){
        //creo i log relativi alla request post ingresso SF 
        OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO = OF_SA_GE_UtilsNew.OM_CreateStatusUpdate_LogNew(c, su);
        
        //------ 2017_08_29 Alessandro: modifica 3
        OF_Schema_StatusUpdateNew.StatusUpdateResponseType respTemp;
        if(!c.PO_SA_Portale__c){
            OF_StatusUpdateNew.StatusUpdateEndpoint stub = new OF_StatusUpdateNew.StatusUpdateEndpoint();
            
            //set timeout
            stub.timeout_x = 30000;
            
            respTemp = stub.StatusUpdate(OF_SA_GE_UtilsNew.slSFOLO);
        }else{
            respTemp = new OF_Schema_StatusUpdateNew.StatusUpdateResponseType();
            respTemp.esito='0';
        }
        
        if(respTemp.esito=='0'){
            OF_SA_GE_UtilsNew.Response='ACK';
        }else{
            OF_SA_GE_UtilsNew.Response='NACK';
        }
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_GE_UtilsNew.Create_EAI_Log(su);
        
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        //inserisco quello post SF
        OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
        // 30/01/2018 Marco : aggiunta checkbox sul log per identificazione desospensione da OM
        if(OF_SA_GE_UtilsNew.desospendi){
            OF_SA_GE_UtilsNew.slSFOLO.OF_SA_Azione__c='0';
        }
        
        insert OF_SA_GE_UtilsNew.slSFOLO;
        
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();
        
        if(OF_SA_GE_UtilsNew.checkApp){ 
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListApp){
                sl.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
                slAggiuntivi.add(sl);
            }
        }
        if(OF_SA_GE_UtilsNew.checkVlan){
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListVlan){
                sl.OF_SA_VLan_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
                slAggiuntivi.add(sl);
            }
        }	
        if(slAggiuntivi.size()>0){
            insert slAggiuntivi;
        }        
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
            slResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - StatusUpdate',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'OK',
                EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id    
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 6
            if(c.PO_SA_Portale__c){
                OF_SA_GE_UtilsNew.aggiornaSLPortale(OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            }
            //ALessandro fine MOdifica 6
        }else{
            respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - StatusUpdate',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'KO',
                EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id
            );
        }
        
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;        
    }
    //OF_StatusUpdate Passivi 
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackStatusUpdateDaOMNew_GPONP(Case c,OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su){
        //creo i log relativi alla request post ingresso SF 
        OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO = OF_SA_GE_UtilsNew.OM_CreateStatusUpdate_LogNew(c, su);
        
        //------ 2017_08_29 Alessandro: modifica 3
        OF_GPONP_Schema_Res_StatusUpdateNew.Response_element respTemp;
        if(!c.PO_SA_Portale__c){
            //Chiamo il nuovo ws
            OF_GPONP_StatusUpdateNew.StatusUpdate_GPONPEndpoint4 stub = new OF_GPONP_StatusUpdateNew.StatusUpdate_GPONPEndpoint4();
            stub.timeout_x = 30000;

            respTemp = stub.StatusUpdate_GPONP(OF_SA_GE_UtilsNew.slSFOLO);
        }else{
            respTemp = new OF_GPONP_Schema_Res_StatusUpdateNew.Response_element();
            respTemp.esito='0';
        }
        
        if(respTemp.esito=='0'){
            OF_SA_GE_UtilsNew.Response='ACK';
        }else{
            OF_SA_GE_UtilsNew.Response='NACK';
        }
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_GE_UtilsNew.Create_EAI_Log(su);
        
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        //inserisco quello post SF
        OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
        // 30/01/2018 Marco : aggiunta checkbox sul log per identificazione desospensione da OM
        if(OF_SA_GE_UtilsNew.desospendi){
            OF_SA_GE_UtilsNew.slSFOLO.OF_SA_Azione__c='0';
        }
        
        insert OF_SA_GE_UtilsNew.slSFOLO;
        
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();
        
        if(OF_SA_GE_UtilsNew.checkApp){ 
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListApp){
                sl.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
                slAggiuntivi.add(sl);
            }
        }
        if(OF_SA_GE_UtilsNew.checkVlan){
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListVlan){
                sl.OF_SA_VLan_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
                slAggiuntivi.add(sl);
            }
        }	
        if(slAggiuntivi.size()>0){
            insert slAggiuntivi;
        }        
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
            slResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - StatusUpdate',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'OK',
                EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id    
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 6
            if(c.PO_SA_Portale__c){
                OF_SA_GE_UtilsNew.aggiornaSLPortale(OF_SA_GE_UtilsNew.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            }
            //ALessandro fine MOdifica 6
        }else{
            respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - StatusUpdate',
                OF_SA_Direzione_Flusso__c='SF-OLO',
                OF_SA_Metodo__c='OF_StatusUpdate',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
                EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
                EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'KO',
                EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
                OF_SA_ESITO__C=respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
                EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id
            );
        }
        
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;        
    }
    //OF_Reschedule Attivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRescheduleNew(Case c,OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r){
        //creo il log relativo alla request post ingresso SF
        OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.OM_CreateReschedule_LogNew(c, r); 
        
        //------ 2017_08_29 Alessandro: modifica 4
        OF_Schema_Response_RescheduleNew.Response_element respTemp;
        if(!c.PO_SA_Portale__c){
            //Done AA - Cambiare ws olo
	        OF_RescheduleNew.PortTypeEndpoint1 stub = new OF_RescheduleNew.PortTypeEndpoint1();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.RescheduleNotify(OF_SA_GE_UtilsNew.slSFOLO);
        }
        else{
        	respTemp = new OF_Schema_Response_RescheduleNew.Response_element();
        	respTemp.esito='0';
        }
        //setto una variabile statica per valorizzare il campo response
        if(respTemp.esito=='0'){
        	OF_SA_GE_UtilsNew.Response='ACK';
        }
        else{
        	OF_SA_GE_UtilsNew.Response='NACK';
        }
        
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_GE_UtilsNew.Create_EAI_Log(r);
        
        //e di quella postSF
        OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
        insert OF_SA_GE_UtilsNew.slSFOLO;
        
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - Reschedule',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_Reschedule',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Sl_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id    
            ); 
            //------ 2017_09_01 Alessandro: modifica 8
            if(c.PO_SA_Portale__c){
            	//creo una lista per richiamare il metodo
            	List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
            	slList.add(OF_SA_GE_UtilsNew.slSFOLO);
            	OF_SA_GE_UtilsNew.aggiornaSLPortale(slList, 'OM_Reschedule');
            }
            //ALessandro fine MOdifica 8
        } 
        else{
        	respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - Reschedule',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_Reschedule',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Sl_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id 
            );
        }
        
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
        
    }
    //OF_Rescehdule Passivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackRescheduleNew_GPONP(Case c,OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r){
        //creo il log relativo alla request post ingresso SF
        OF_SA_GE_UtilsNew.slSFOLO = OF_SA_GE_UtilsNew.OM_CreateReschedule_LogNew(c, r); 
        
        //------ 2017_08_29 Alessandro: modifica 4
        OF_GPONP_Schema_Res_RescheduleNew.Response_element respTemp;
        if(!c.PO_SA_Portale__c){
            OF_GPONP_RescheduleNew.PortTypeEndpoint5 stub = new OF_GPONP_RescheduleNew.PortTypeEndpoint5();
            //set timeout
	        stub.timeout_x = 30000;

            respTemp = stub.Reschedule_GPONP(OF_SA_GE_UtilsNew.slSFOLO);
        }
        else{
        	respTemp = new OF_GPONP_Schema_Res_RescheduleNew.Response_element();
        	respTemp.esito='0';
        }
        //setto una variabile statica per valorizzare il campo response
        if(respTemp.esito=='0'){
        	OF_SA_GE_UtilsNew.Response='ACK';
        }
        else{
        	OF_SA_GE_UtilsNew.Response='NACK';
        }
        
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_GE_UtilsNew.Create_EAI_Log(r);
        
        //e di quella postSF
        OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
        insert OF_SA_GE_UtilsNew.slSFOLO;
        
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - Reschedule',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_Reschedule',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Sl_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id    
            ); 
            //------ 2017_09_01 Alessandro: modifica 8
            if(c.PO_SA_Portale__c){
            	//creo una lista per richiamare il metodo
            	List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
            	slList.add(OF_SA_GE_UtilsNew.slSFOLO);
            	OF_SA_GE_UtilsNew.aggiornaSLPortale(slList, 'OM_Reschedule');
            }
            //ALessandro fine MOdifica 8
        } 
        else{
        	respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - Reschedule',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_Reschedule',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Sl_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id 
            );
        }
        
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
        
    }
    //OF_CompletionOrder Attivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackCompletionOrderNew(Case c,OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co){
        //creo i log relativi alla request post ingresso SF
        OF_SA_GE_UtilsNew.ListSlCompletionOrderSFOLO = OF_SA_GE_UtilsNew.OM_CreateCompletionOrder_Log(c, co);
         
        //------ 2017_08_29 Alessandro: modifica 5 
        OF_Schema_CompletionOrderNew.CompletionOrderResponseType respTemp;
        if(!c.PO_SA_Portale__c){
            //TODO AA - Cambiare ws olo
	        OF_CompletionOrderNew.CompletionOrderEndpoint stub = new OF_CompletionOrderNew.CompletionOrderEndpoint();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.CompletionOrderNotify(OF_SA_GE_UtilsNew.ListSlCompletionOrderSFOLO);
        }
        else{
        	respTemp = new OF_Schema_CompletionOrderNew.CompletionOrderResponseType();
        	respTemp.esito='0';
        }
        //------ fine modifica 5
        
        //setto una variabile statica per valorizzare il campo response
        if(respTemp.esito=='0'){
        	OF_SA_GE_UtilsNew.Response='ACK';
        }
        else{
        	OF_SA_GE_UtilsNew.Response='NACK';
        }
        
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_GE_UtilsNew.Create_EAI_Log(co); 
        
        //inserisco quello post SF
        OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
        insert OF_SA_GE_UtilsNew.slSFOLO;
        
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();
        
        if(OF_SA_GE_UtilsNew.checkApp){ 
        	for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListApp){
        		sl.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }
        if(OF_SA_GE_UtilsNew.checkServAgg){
        	for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListServAgg){
        		sl.OF_SA_servizi_Aggiuntivi_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }	
        if(slAggiuntivi.size()>0){
            insert slAggiuntivi;
        }
        
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        if(respTemp.Esito=='0'){
            OF_SA_GE_UtilsNew.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - CompletionOrder',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_CompletionOrder_OpenStream',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id   
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 7
            if(c.PO_SA_Portale__c){
            	OF_SA_GE_UtilsNew.aggiornaSLPortale(OF_SA_GE_UtilsNew.ListSlCompletionOrderSFOLO, 'OM_CompletionOrder');
            }
            //ALessandro fine MOdifica 7
        } 
        else{
            OF_SA_GE_UtilsNew.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - CompletionOrder',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_CompletionOrder_OpenStream',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id
            );
        }
        
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, OF_SA_GE_UtilsNew.slSFOLOResp);
        return response;
        
    }
    //OF_CompletionOrder Passivi
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackCompletionOrderNew_GPONP(Case c,OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co){
        //creo i log relativi alla request post ingresso SF
        OF_SA_GE_UtilsNew.ListSlCompletionOrderSFOLO = OF_SA_GE_UtilsNew.OM_CreateCompletionOrder_Log(c, co);
         
        //------ 2017_08_29 Alessandro: modifica 5 
        OF_GPONP_Res_Schema_CompletionOrderNew.Response_element respTemp;
        if(!c.PO_SA_Portale__c){ 
            OF_GPONP_CompletionOrderNew.PortTypeEndpoint6 stub = new OF_GPONP_CompletionOrderNew.PortTypeEndpoint6();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.CompletionOrder_GPONP(OF_SA_GE_UtilsNew.ListSlCompletionOrderSFOLO);
        }
        else{
        	respTemp = new OF_GPONP_Res_Schema_CompletionOrderNew.Response_element();
        	respTemp.esito='0';
        }
        //------ fine modifica 5
        
        //setto una variabile statica per valorizzare il campo response
        if(respTemp.esito=='0'){
        	OF_SA_GE_UtilsNew.Response='ACK';
        }
        else{
        	OF_SA_GE_UtilsNew.Response='NACK';
        }
        
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_GE_UtilsNew.Create_EAI_Log(co); 
        
        //inserisco quello post SF
        OF_SA_GE_UtilsNew.slSFOLO.EOF_Response__c=OF_SA_GE_UtilsNew.Response;
        insert OF_SA_GE_UtilsNew.slSFOLO;
        
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();
        
        if(OF_SA_GE_UtilsNew.checkApp){ 
        	for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListApp){
        		sl.OF_SA_Cpe_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }
        if(OF_SA_GE_UtilsNew.checkServAgg){
        	for(EOF_EAI_Service_Log__c sl : OF_SA_GE_UtilsNew.ListServAgg){
        		sl.OF_SA_servizi_Aggiuntivi_Log__c=OF_SA_GE_UtilsNew.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }	
        if(slAggiuntivi.size()>0){
            insert slAggiuntivi;
        }
        
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        if(respTemp.Esito=='0'){
            OF_SA_GE_UtilsNew.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - CompletionOrder',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_CompletionOrder_GPONP',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id   
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 7
            if(c.PO_SA_Portale__c){
            	OF_SA_GE_UtilsNew.aggiornaSLPortale(OF_SA_GE_UtilsNew.ListSlCompletionOrderSFOLO, 'OM_CompletionOrder');
            }
            //ALessandro fine MOdifica 7
        } 
        else{
            OF_SA_GE_UtilsNew.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - CompletionOrder',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_CompletionOrder_GPONP',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_GE_UtilsNew.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_GE_UtilsNew.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_GE_UtilsNew.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c=OF_SA_GE_UtilsNew.slSFOLO.Id
            );
        }
        
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, OF_SA_GE_UtilsNew.slSFOLOResp);
        return response;
        
    }
}
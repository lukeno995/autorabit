public class OF_SA_CD_OM_SendToOLO {

    //metodo per inviare la notifica di acquisizione all'olo
    public static OF_SA_WS_OLO_Response.Esito_element OM_CreateAckNackNotifyStatusUpdate(EOF_EAI_Service_Log__C sl){  
     
        OF_SA_WS_OLO_Response.Esito_element respTemp;
        if(!OF_SA_CD_GE_Utils.caseOriginale.PO_SA_Portale__C && !OF_SA_CD_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
        	system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@ Attenzione entrato qui');
	        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
	        respTemp = new OF_SA_WS_OLO_Response.Esito_element();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	            
	        respTemp = stub.NotifyAggiornaStato(OF_SA_CD_GE_Utils.slSFOLO); 

        }
        //fingiamo l'ACK da OLO in caso di inserimento da portale
        else{
        	respTemp=new OF_SA_WS_OLO_Response.Esito_element();
        	respTemp.Esito='0'; 
        }
        //----- 2017_08_29 Alessandro: fine modifica 2
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_SA_CD_GE_Utils.slSFOLO.OF_SA_ACK__c=true;
            OF_SA_CD_GE_Utils.slSFOLO.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='ACK';
            
            OF_SA_CD_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate', 
            Caso__c = OF_SA_CD_GE_Utils.caseOriginale.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_ACK'),                                        
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=sl.EOF_ID_Notifica__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry    
            ); 
        } 
        else{
        	//aggiungo la ricezione del NACK sul service Log della notifica all'OLO
            OF_SA_CD_GE_Utils.slSFOLO.OF_SA_ACK__c=false;
            OF_SA_CD_GE_Utils.slSFOLO.EOF_Response__C='NACK';
            OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
           
           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK TECNICO';
           }
           else{
           		OF_SA_CD_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK';
           }
            
            OF_SA_CD_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - StatusUpdate',
            Caso__c = OF_SA_CD_GE_Utils.caseOriginale.Id,
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_NACK'),                                        
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
            EOF_Retry__c=OF_SA_CD_GE_Utils.retry
            );
        }
        return resptemp;
    }
    
    //per tutti gli altri metodi dello status update 
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackStatusUpdateDaOM(Case c,OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){
        //creo i log relativi alla request post ingresso SF
        OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO = OF_SA_CD_GE_Utils.OM_CreateStatusUpdate_Log(c, su);
        
        //------ 2017_08_29 Alessandro: modifica 3
        OF_SA_WS_OLO_Response.Esito_element respTemp;
        if(!c.PO_SA_Portale__c){
        	OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.NotifyAggiornaStato(OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO);
        }
        else{
        	respTemp = new OF_SA_WS_OLO_Response.Esito_element();
        	respTemp.esito='0';
        }
        
        if(respTemp.esito=='0'){
        	OF_SA_CD_GE_Utils.Response='ACK';
        }
        else{
        	OF_SA_CD_GE_Utils.Response='NACK';
        }
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_CD_GE_Utils.Create_EAI_Log(su);
         
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        //inserisco quello post SF
        OF_SA_CD_GE_Utils.slSFOLO.EOF_Response__c=OF_SA_CD_GE_Utils.Response;
        // 30/01/2018 Marco : aggiunta checkbox sul log per identificazione desospensione da OM
        if(OF_SA_CD_GE_Utils.desospendi){
            OF_SA_CD_GE_Utils.slSFOLO.OF_SA_Azione__c='0';
        }
        
        system.debug('30/01/2018 MARCO : desospendi nella utils:'+ OF_SA_CD_GE_Utils.desospendi);
        system.debug('30/01/2018 MARCO : checkbox nella utils per il log:'+OF_SA_CD_GE_Utils.slSFOLO.OF_SA_Desospensione_Attivi__c);
        
        // 30/01/2018 Marco : fine modifica
        
        insert OF_SA_CD_GE_Utils.slSFOLO;
 
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();

        if(OF_SA_CD_GE_Utils.checkApp){ 
        	for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListApp){
        		sl.OF_SA_Cpe_Log__c=OF_SA_CD_GE_Utils.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }
        if(OF_SA_CD_GE_Utils.checkVlan){
        	for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListVlan){
        		sl.OF_SA_VLan_Log__c=OF_SA_CD_GE_Utils.slSFOLO.Id;
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
            EOF_Tipo_comunicazione_String__c = 'SF->OLO - ACK - StatusUpdate',
            OF_SA_Direzione_Flusso__c = 'SF-OLO',
            OF_SA_Metodo__c = 'OF_StatusUpdate',
            Caso__c = c.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_ACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C = OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C = respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c = OF_SA_CD_GE_Utils.slSFOLO.Id    
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 6
            if(c.PO_SA_Portale__c){
                System.debug('<<<<<< Prima della chiamata di aggiornaSLPortale>>>>>');
            	OF_SA_CD_GE_Utils.aggiornaSLPortale(OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            }
            //ALessandro fine MOdifica 6
        } 
        else{
        	respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            Caso__c = c.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_NACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C = OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C = respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c = OF_SA_CD_GE_Utils.slSFOLO.Id
            );
        }
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
    }

    /*
    //START - Add by PG - 07-01 - Copiato metodo OM_CreateAckNackStatusUpdateDaOM (da utilizzare per il change Order)
    
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackStatusUpdateDaOMChOrd(Case c,OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){
        //creo i log relativi alla request post ingresso SF
        OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO = OF_SA_CD_GE_Utils.OM_CreateStatusUpdate_Log(c, su);
        
        //------ 2017_08_29 Alessandro: modifica 3
        OF_SA_WS_OLO_Response.Esito_element respTemp;
        if(!c.PO_SA_Portale__c){
        	OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.NotifyAggiornaStato(OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO);
        }
        else{
        	respTemp = new OF_SA_WS_OLO_Response.Esito_element();
        	respTemp.esito='0';
        }
        
        if(respTemp.esito=='0'){
        	OF_SA_CD_GE_Utils.Response='ACK';
        }
        else{
        	OF_SA_CD_GE_Utils.Response='NACK';
        }
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_CD_GE_Utils.Create_EAI_Log(su);
         
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        //inserisco quello post SF
        OF_SA_CD_GE_Utils.slSFOLO.EOF_Response__c=OF_SA_CD_GE_Utils.Response;
        // 30/01/2018 Marco : aggiunta checkbox sul log per identificazione desospensione da OM
        if(OF_SA_CD_GE_Utils.desospendi){
            OF_SA_CD_GE_Utils.slSFOLO.OF_SA_Azione__c='0';
        }
        
        system.debug('30/01/2018 MARCO : desospendi nella utils:'+ OF_SA_CD_GE_Utils.desospendi);
        system.debug('30/01/2018 MARCO : checkbox nella utils per il log:'+OF_SA_CD_GE_Utils.slSFOLO.OF_SA_Desospensione_Attivi__c);
        
        // 30/01/2018 Marco : fine modifica
        
        insert OF_SA_CD_GE_Utils.slSFOLO;
 
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();

        if(OF_SA_CD_GE_Utils.checkApp){ 
        	for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListApp){
        		sl.OF_SA_Cpe_Log__c=OF_SA_CD_GE_Utils.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }
        if(OF_SA_CD_GE_Utils.checkVlan){
        	for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListVlan){
        		sl.OF_SA_VLan_Log__c=OF_SA_CD_GE_Utils.slSFOLO.Id;
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
            EOF_Tipo_comunicazione_String__c = 'SF->OLO - ACK - StatusUpdate',
            OF_SA_Direzione_Flusso__c = 'SF-OLO',
            OF_SA_Metodo__c = 'OF_StatusUpdate',
            Caso__c = c.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_ACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C = OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C = respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c = OF_SA_CD_GE_Utils.slSFOLO.Id    
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 6
            if(c.PO_SA_Portale__c){
                System.debug('<<<<<< Prima della chiamata di aggiornaSLPortale>>>>>');
            	//OF_SA_CD_GE_Utils.aggiornaSLPortale(OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            	OF_SA_CD_GE_Utils.aggiornaSLPortaleChangeOrd(OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            }
            //ALessandro fine MOdifica 6
        } 
        else{
        	respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            Caso__c = c.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_NACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C = OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C = respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c = OF_SA_CD_GE_Utils.slSFOLO.Id
            );
        }
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
    }
    //END - Add by PG - 07-01
    */

    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackReschedule(Case c,OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r){
        //creo il log relativo alla request post ingresso SF
        OF_SA_CD_GE_Utils.slSFOLO = OF_SA_CD_GE_Utils.OM_CreateReschedule_Log(c, r);
        
        //------ 2017_08_29 Alessandro: modifica 4
        OF_SA_WS_OLO_Response.Esito_element respTemp;
        if(!c.PO_SA_Portale__c){
	        OF_SA_WS_OLO_Reschedule.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_Reschedule.NotifyPortTypeEndpoint();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.NotifyRischedulazione(OF_SA_CD_GE_Utils.slSFOLO);
        }
        else{
        	respTemp = new OF_SA_WS_OLO_Response.Esito_element();
        	respTemp.esito='0';
        }
        //setto una variabile statica per valorizzare il campo response
        if(respTemp.esito=='0'){
        	OF_SA_CD_GE_Utils.Response='ACK';
        }
        else{
        	OF_SA_CD_GE_Utils.Response='NACK';
        }
        
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_CD_GE_Utils.Create_EAI_Log(r);
        
        //e di quella postSF
        OF_SA_CD_GE_Utils.slSFOLO.EOF_Response__c=OF_SA_CD_GE_Utils.Response;
        insert OF_SA_CD_GE_Utils.slSFOLO;
        
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        EOF_EAI_Service_Log__c slResp;
        if(respTemp.Esito=='0'){
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c = 'SF->OLO - ACK - Reschedule',
            OF_SA_Direzione_Flusso__c = 'SF-OLO',
            OF_SA_Metodo__c = 'OF_Reschedule',
            Caso__c = c.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_ACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C = OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C = respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
            EOF_Sl_Riferimento__c = OF_SA_CD_GE_Utils.slSFOLO.Id    
            ); 
            //------ 2017_09_01 Alessandro: modifica 8
            if(c.PO_SA_Portale__c){
            	//creo una lista per richiamare il metodo
            	List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
            	slList.add(OF_SA_CD_GE_Utils.slSFOLO);
            	OF_SA_CD_GE_Utils.aggiornaSLPortale(slList, 'OM_Reschedule');
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
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_NACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Sl_Riferimento__c=OF_SA_CD_GE_Utils.slSFOLO.Id 
            );
        }
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
    }
    
    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackCompletionOrder(Case c,OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co){
        //creo i log relativi alla request post ingresso SF
        OF_SA_CD_GE_Utils.ListSlCompletionOrderSFOLO = OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(c, co);
        
        //------ 2017_08_29 Alessandro: modifica 5
        OF_SA_WS_OLO_Response.Esito_element respTemp;
        if(!c.PO_SA_Portale__c){
	        OF_SA_WS_OLO_CompletionOrder.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_CompletionOrder.NotifyPortTypeEndpoint();
	        
	        //set timeout
	        stub.timeout_x = 30000;
	        
	        respTemp = stub.NotifyCompletamentoOrdine(OF_SA_CD_GE_Utils.ListSlCompletionOrderSFOLO);
        }
        else{
        	respTemp = new OF_SA_WS_OLO_Response.Esito_element();
        	respTemp.esito='0';
        }
        //------ fine modifica 5
        
        //setto una variabile statica per valorizzare il campo response
        if(respTemp.esito=='0'){
        	OF_SA_CD_GE_Utils.Response='ACK';
        }
        else{
        	OF_SA_CD_GE_Utils.Response='NACK';
        }
        
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_SA_CD_GE_Utils.Create_EAI_Log(co); 
        
        //inserisco quello post SF
        OF_SA_CD_GE_Utils.slSFOLO.EOF_Response__c=OF_SA_CD_GE_Utils.Response;
        insert OF_SA_CD_GE_Utils.slSFOLO;
        
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();
        
        if(OF_SA_CD_GE_Utils.checkApp){ 
        	for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListApp){
        		sl.OF_SA_Cpe_Log__c=OF_SA_CD_GE_Utils.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }
        if(OF_SA_CD_GE_Utils.checkServAgg){
        	for(EOF_EAI_Service_Log__c sl : OF_SA_CD_GE_Utils.ListServAgg){
        		sl.OF_SA_servizi_Aggiuntivi_Log__c=OF_SA_CD_GE_Utils.slSFOLO.Id;
        		slAggiuntivi.add(sl);
        	}
        }	
        if(slAggiuntivi.size()>0){
            insert slAggiuntivi;
        }
        
        //ora costruisco il log di ACK/NACK verso l'OLO
        if(respTemp.Esito=='0'){
            OF_SA_CD_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - CompletionOrder',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_CompletionOrder_OpenStream',
            Caso__c = c.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_ACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C = OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C = respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c = OF_SA_CD_GE_Utils.slSFOLO.Id   
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 7
            if(c.PO_SA_Portale__c){
            	OF_SA_CD_GE_Utils.aggiornaSLPortale(OF_SA_CD_GE_Utils.ListSlCompletionOrderSFOLO, 'OM_CompletionOrder');
            }
            //ALessandro fine MOdifica 7
        } 
        else{
            OF_SA_CD_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - CompletionOrder',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_CompletionOrder_OpenStream',
            Caso__c = c.Id,
            RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_NACK'),                                        
            EOF_Codice_Operatore__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_SA_CD_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_SA_CD_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c=OF_SA_CD_GE_Utils.slSFOLO.Id
            );
        }
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, OF_SA_CD_GE_Utils.slSFOLOResp);
        return response;
    }
}
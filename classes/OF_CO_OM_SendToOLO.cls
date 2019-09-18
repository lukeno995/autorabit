public class OF_CO_OM_SendToOLO {

    //metodo per inviare la notifica di acquisizione all'olo
    public static OF_SA_WS_OLO_Response.Esito_element OM_CreateAckNackNotifyStatusUpdate(EOF_EAI_Service_Log__C sl){  
        
        OF_CO_GE_Utils.slSFOLO = sl;
        OF_SA_WS_OLO_Response.Esito_element respTemp;
        if(!OF_CO_GE_Utils.caseOriginale.PO_SA_Portale__C && !OF_CO_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
            OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
            respTemp= new OF_SA_WS_OLO_Response.Esito_element();
            
            //set timeout
            stub.timeout_x = 30000; 
                 
            respTemp = stub.NotifyAggiornaStato(sl); 
        }
        //fingiamo l'ACK da OLO in caso di inserimento da portale
        else{
            respTemp=new OF_SA_WS_OLO_Response.Esito_element();
            respTemp.Esito='0'; 
        }
        //----- 2017_08_29 Alessandro: fine modifica 2
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            OF_CO_GE_Utils.slSFOLO.OF_SA_ACK__c=true;
            OF_CO_GE_Utils.slSFOLO.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            OF_CO_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='ACK';
            
            OF_CO_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - OF_StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate', 
            Caso__c = OF_CO_GE_Utils.caseOriginale.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = sl.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=sl.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = sl.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=sl.EOF_ID_Notifica__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_Retry__c=OF_CO_GE_Utils.retry    
            ); 
            //------ 2017_08_29 Alessandro: modifica 6
            if(OF_CO_GE_Utils.caseOriginale.PO_SA_Portale__c){
                List<EOF_EAI_Service_Log__C> fakeList = new List<EOF_EAI_Service_Log__c>();
                fakeList.add(OF_CO_GE_Utils.slSFOLO);
                OF_CO_GE_Utils.aggiornaSLPortale(fakeList, 'OM_StatusUpdate');
            }
            //ALessandro fine MOdifica 6
            
        } 
        else{
            //aggiungo la ricezione del NACK sul service Log della notifica all'OLO
            OF_CO_GE_Utils.slSFOLO.OF_SA_ACK__c=false;
            OF_CO_GE_Utils.slSFOLO.EOF_Response__C='NACK';
            OF_CO_GE_Utils.slSFOLO.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;
           
           //setto il NACK sul case
           if(String.isBlank(respTemp.CODICE_MOTIVAZIONE) || respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                OF_CO_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK TECNICO';
           }
           else{
                OF_CO_GE_Utils.caseOriginale.OF_Response_Da_OLO__c='NACK';
           }
            
            OF_CO_GE_Utils.slSFOLOResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - OF_StatusUpdate',
            Caso__c = OF_CO_GE_Utils.caseOriginale.Id,
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - NACK').getRecordTypeId(),                                        
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
            EOF_Retry__c=OF_CO_GE_Utils.retry
            );

        }
        //creo l'ordine KO solo se non è retry
        if(!OF_CO_GE_Utils.retry){
            OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(OF_CO_GE_Utils.caseOriginale);
        }
        return resptemp;
    }



    public static Map<String,EOF_EAI_Service_Log__c> OM_CreateAckNackStatusUpdateDaOM(Case c,OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){
        //creo i log relativi alla request post ingresso SF
        OF_CO_GE_Utils.ListSlStatusUpdateSFOLO = OF_CO_GE_Utils.OM_CreateStatusUpdate_Log(c, su);
        
        //------ 2017_08_29 Alessandro: modifica 3
        OF_SA_WS_OLO_Response.Esito_element respTemp;
        if(!c.PO_SA_Portale__c){
            OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        
            //set timeout
            stub.timeout_x = 30000;
            
            respTemp = stub.NotifyAggiornaStato(OF_CO_GE_Utils.ListSlStatusUpdateSFOLO);
        }
        else{
            respTemp = new OF_SA_WS_OLO_Response.Esito_element();
            respTemp.esito='0';
        }
        
        if(respTemp.esito=='0'){
            OF_CO_GE_Utils.Response='ACK';
        }
        else{
            OF_CO_GE_Utils.Response='NACK';
        }
        //una volta fatta la chiamata sincrona inserisco i slog della request pre SF
        OF_CO_GE_Utils.Create_EAI_Log(su);
         
        //a questo punto inserisco quelli post SF e che abbiamo inviato all'OLO
        //inserisco quello post SF
        OF_CO_GE_Utils.slSFOLO.EOF_Response__c=OF_CO_GE_Utils.Response;
        // 30/01/2018 Marco : aggiunta checkbox sul log per identificazione desospensione da OM
        if(OF_CO_GE_Utils.desospendi){
            OF_CO_GE_Utils.slSFOLO.OF_SA_Azione__c='0';
        }
        
        system.debug('30/01/2018 MARCO : desospendi nella utils:'+ OF_CO_GE_Utils.desospendi);
        system.debug('30/01/2018 MARCO : checkbox nella utils per il log:'+OF_CO_GE_Utils.slSFOLO.OF_SA_Desospensione_Attivi__c);
        
        // 30/01/2018 Marco : fine modifica
        
        insert OF_CO_GE_Utils.slSFOLO;
 
        List<EOF_EAI_Service_Log__c> slAggiuntivi = new List<EOF_EAI_Service_Log__c>();

        if(OF_CO_GE_Utils.checkApp){ 
            for(EOF_EAI_Service_Log__c sl : OF_CO_GE_Utils.ListApp){
                sl.OF_SA_Cpe_Log__c=OF_CO_GE_Utils.slSFOLO.Id;
                slAggiuntivi.add(sl);
            }
        }
        if(OF_CO_GE_Utils.checkVlan){
            for(EOF_EAI_Service_Log__c sl : OF_CO_GE_Utils.ListVlan){
                sl.OF_SA_VLan_Log__c=OF_CO_GE_Utils.slSFOLO.Id;
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
            EOF_Tipo_comunicazione_String__c='SF->OLO - ACK - OF_StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_CO_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_CO_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_CO_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'OK',
            EOF_ID_NOTIFICA__C=OF_CO_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c=OF_CO_GE_Utils.slSFOLO.Id    
            ); 
            
            //------ 2017_08_29 Alessandro: modifica 6
            if(c.PO_SA_Portale__c){
                OF_CO_GE_Utils.aggiornaSLPortale(OF_CO_GE_Utils.ListSlStatusUpdateSFOLO, 'OM_StatusUpdate');
            }
            //ALessandro fine MOdifica 6
        } 
        else{
            respTemp.Esito='1';
            slResp = new EOF_EAI_Service_Log__c(
            EOF_Tipo_comunicazione_String__c='SF->OLO - NACK - OF_StatusUpdate',
            OF_SA_Direzione_Flusso__c='SF-OLO',
            OF_SA_Metodo__c='OF_StatusUpdate',
            Caso__c = c.Id,
            RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - NACK').getRecordTypeId(),                                        
            EOF_Codice_Operatore__c = OF_CO_GE_Utils.slSFOLO.EOF_Codice_Operatore__c,
            EOF_Codice_Ordine_Olo__c=OF_CO_GE_Utils.slSFOLO.EOF_Codice_Ordine_Olo__c,
            EOF_Data_Notifica__c = OF_CO_GE_Utils.slSFOLO.EOF_Data_Notifica__c,
            EOF_Stato_Richiesta__c = 'KO',
            EOF_ID_NOTIFICA__C=OF_CO_GE_Utils.slSFOLO.EOF_ID_NOTIFICA__c,
            OF_SA_ESITO__C=respTemp.ESITO,
            EOF_CODICE_MOTIVAZIONE__C=respTemp.CODICE_MOTIVAZIONE, 
            EOF_MOTIVAZIONE__C=respTemp.MOTIVAZIONE,
            EOF_SL_Riferimento__c=OF_CO_GE_Utils.slSFOLO.Id
            );
        }
        
        //e lo restituisco come ritorno in una mappa in cui la chiave è la stringa di esito 
        Map<String,EOF_EAI_Service_Log__c> response = new Map<String,EOF_EAI_Service_Log__c>();
        response.put(respTemp.Esito, slResp);
        return response;
        
    }
}
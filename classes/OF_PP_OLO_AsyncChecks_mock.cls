@isTest
    global class OF_PP_OLO_AsyncChecks_mock implements WebServiceMock {
    
        global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType){
                EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
            ser.EOF_PROFILO__c = 'Test';
            ser.EOF_ID_Notifica__c = 'Test';
            insert ser;
            
            OF_PP_WS_VLAN_OM_Response.Esito_element es = new OF_PP_WS_VLAN_OM_Response.Esito_element();
            response.put('response_x', es); 
            
            /* 
            OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint stub1 = new OF_SA_WS_OM_Deactivation.DisattivazioneOrdinePortTypeEndpoint();
            stub1.timeout_x = 30000;
            response.put('response_x', stub1); 
            
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest resp = new  OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
            response.put('response_x', resp ); 
            //OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest resp1 = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
           // response.put('response_x', resp1 ); 
           //OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint resp1= new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
          // response.put('response_x', resp1);
          */
        }
    }
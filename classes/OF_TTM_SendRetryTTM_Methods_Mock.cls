@isTest
global class OF_TTM_SendRetryTTM_Methods_Mock implements WebServiceMock {
       global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = 'Test';
        ser.EOF_ID_Notifica__c = 'Test';
        insert ser;
        
/*OF_TTM_ForwardRequest.SyncPortTypeEndpoint1 stub1 = new OF_TTM_ForwardRequest.SyncPortTypeEndpoint1();
stub1.timeout_x = 30000;
response.put('response_x', stub1); */
               
        //OF_TT_WS_Notifica.TroubleTicketNotifyResp_element resp = new OF_TT_WS_Notifica.TroubleTicketNotifyResp_element();
        OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element resp = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
        resp.Esito = '0';
        
        response.put('response_x', resp ); 
               
      
}
}
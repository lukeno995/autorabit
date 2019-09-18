@isTest
global class EntryCheckMock1 implements WebServiceMock {
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
               
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new   OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();
      //  resp.Esito = '0';
        response.put('response_x', resp ); 
               
      
}
}
@isTest
global class OF_CO_OM_EntryChecks_mock_Test implements WebServiceMock {
    
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
           
           List<case> cseList = new List<case>();
           Case c = new Case();
           c.Status = 'Chiuso';
           cseList.add(c);
           insert cseList;
           
           EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = 'Test';
        ser.EOF_ID_Notifica__c = 'Test';
        insert ser;

          OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint resp = new  OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        response.put('response_x', resp ); 
   }
}
@isTest
global class OF_CO_OM_SendToOLO_Mockcls2 implements WebServiceMock {
    
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

         OF_SA_WS_OLO_Response.Esito_element resp = new   OF_SA_WS_OLO_Response.Esito_element();
              // resp.Esito = '0';
        response.put('response_x', resp ); 
   }
   
    
}
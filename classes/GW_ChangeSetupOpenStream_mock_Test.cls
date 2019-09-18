@isTest
global class GW_ChangeSetupOpenStream_mock_Test implements WebServiceMock {
    
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

        GW_ChangeSetupOpenStream_Response.Esito_element responseElement = new GW_ChangeSetupOpenStream_Response.Esito_element();
        response.put('response_x', responseElement); 
   }
}
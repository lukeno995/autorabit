@isTest
global class OF_CO_OLO_AsyncChecks_mock2 implements WebServiceMock {
    
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
           
          

        OF_SA_WS_OLO_Response.Esito_element resp = new  OF_SA_WS_OLO_Response.Esito_element();
      // OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp=new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
        resp.esito ='1';
        response.put('response_x', resp ); 
   }
}
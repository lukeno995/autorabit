@isTest
global class OF_SA_GE_UtilsNew_Mock implements WebServiceMock {
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
           
         WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType responseElement = new WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType();
         response.put('response_x', responseElement);
         
           }
         
}
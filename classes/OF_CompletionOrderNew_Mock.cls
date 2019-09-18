@isTest
global class OF_CompletionOrderNew_Mock implements WebServiceMock {
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
            
        OF_Schema_CompletionOrderNew.CompletionOrderResponseType responseElement = new OF_Schema_CompletionOrderNew.CompletionOrderResponseType();
        response.put('response_x', responseElement);    
        }      
}
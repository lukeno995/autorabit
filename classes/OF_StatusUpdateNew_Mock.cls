@isTest
global class OF_StatusUpdateNew_Mock implements WebServiceMock {
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
            
        OF_Schema_StatusUpdateNew.StatusUpdateResponseType responseElement = new OF_Schema_StatusUpdateNew.StatusUpdateResponseType();
        response.put('response_x', responseElement);    
        }      
}
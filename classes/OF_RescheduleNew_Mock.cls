@isTest

global class OF_RescheduleNew_Mock implements WebServiceMock {
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
            
         OF_Schema_Response_RescheduleNew.Response_element responseElement = new  OF_Schema_Response_RescheduleNew.Response_element();
        response.put('response_x', responseElement);    
        }      
}
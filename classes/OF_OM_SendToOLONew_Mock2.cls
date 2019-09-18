@isTest
global class OF_OM_SendToOLONew_Mock2 implements WebServiceMock {
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
            
                OF_Schema_Response_RescheduleNew.Response_element responseElement = new OF_Schema_Response_RescheduleNew.Response_element();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                response.put('response_x', responseElement);
            
        } 
    
}
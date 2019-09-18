@isTest
global class OF_GPONP_StatusUpdateNewMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) 
    {
            
        OF_GPONP_Schema_Res_StatusUpdateNew.Response_element responseElement = new OF_GPONP_Schema_Res_StatusUpdateNew.Response_element();
        response.put('response_x', responseElement);    
             
}
}
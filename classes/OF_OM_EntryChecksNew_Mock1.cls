@isTest
global class OF_OM_EntryChecksNew_Mock1 implements WebServiceMock {
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
            
                OF_GPONP_Schema_Res_StatusUpdateNew.Response_element responseElement = new OF_GPONP_Schema_Res_StatusUpdateNew.Response_element();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                responseElement.esito = '1';
                response.put('response_x', responseElement);
            
        } 
    
}
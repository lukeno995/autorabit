@isTest

global class OF_WS_OM_RescheduleNew_Mock implements WebServiceMock {
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
            
         OF_WS_OM_Schema_Res_RescheduleNew.Esito_element responseElement = new  OF_WS_OM_Schema_Res_RescheduleNew.Esito_element();
        response.put('response_x', responseElement);    
        }      
}
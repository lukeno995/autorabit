@isTest

global class OF_WS_OM_DeactivationOrderNew_Mock implements WebServiceMock {
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
            
        OF_WS_OM_Schema_Res_DeactivationNew.Esito_element responseElement = new  OF_WS_OM_Schema_Res_DeactivationNew.Esito_element();
        response.put('response_x', responseElement);    
        }      
}
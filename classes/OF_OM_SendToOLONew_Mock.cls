@isTest
global class OF_OM_SendToOLONew_Mock implements WebServiceMock {
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
            
           // if(request instanceOf OF_Schema_StatusUpdateNew.StatusUpdateNotifyType){
                OF_Schema_StatusUpdateNew.StatusUpdateResponseType responseElement = new OF_Schema_StatusUpdateNew.StatusUpdateResponseType();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                response.put('response_x', responseElement);
           // } 
        } 
    
}
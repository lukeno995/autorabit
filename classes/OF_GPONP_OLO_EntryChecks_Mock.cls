@isTest
global class OF_GPONP_OLO_EntryChecks_Mock implements WebServiceMock {
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
            
            OF_GPONP_GE_Utils.SH_Response_For_Confirmation responseElement = new OF_GPONP_GE_Utils.SH_Response_For_Confirmation();
            //responseElement.Result = 'OK';
            responseElement.Code = 'A04';
            responseElement.Description = 'Data passed';
            response.put('response_x', responseElement);
            
        }
}
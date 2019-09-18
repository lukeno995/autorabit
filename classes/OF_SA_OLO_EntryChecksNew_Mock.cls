@isTest
global class OF_SA_OLO_EntryChecksNew_Mock implements WebServiceMock {
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
            
            OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse resp = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationResponse();
            
            resp.ID_NOTIFICA = String.valueOf(System.now().getTime());
            resp.ESITO = '0';
            resp.CODICE_MOTIVAZIONE = 'CNN';
            resp.MOTIVAZIONE = 'Test';
            
            OF_SA_GE_UtilsNew.responseFromSH.Result = 'OK';
            response.put('response_x', resp ); 
        }
    
}
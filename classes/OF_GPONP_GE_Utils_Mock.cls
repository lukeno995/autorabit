@isTest
global class OF_GPONP_GE_Utils_Mock implements WebServiceMock {
 global void doInvoke(
    Object stub,
    Object request,
    Map<String, Object> response,
    String endpoint,
    String soapAction,
    String requestName,
    String responseNS,
    String responseName,
    String responseType){
         EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
         eaiLog.EOF_ID_Notifica__c = 'test_01';
         insert eaiLog;
         OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        //WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType  res = new WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType();
        OF_GPONP_Schema_Res_StatusUpdateNew.Response_element res = new OF_GPONP_Schema_Res_StatusUpdateNew.Response_element();
        res.esito = '0';
        response.put('response_x', res);
    }

}
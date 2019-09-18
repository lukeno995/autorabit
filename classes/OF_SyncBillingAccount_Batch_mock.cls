@isTest
global class OF_SyncBillingAccount_Batch_mock implements WebServiceMock {

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
        
        OF_Billing_Outbound_Schema.BillingAccountManagerResponsetType  res = new OF_Billing_Outbound_Schema.BillingAccountManagerResponsetType();
        res.esito = '0';
        response.put('response_x', res);
    }
}
@isTest
global class SyncBillingAssettUtils_Mock  implements WebServiceMock{

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
        
        OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType  res = new   OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType();
        res.esito = '1';
        response.put('response_x', res);
    }
}
global class Billing_Outbound_Service3_Mock implements WebServiceMock {
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
            
                OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType responseEl = new OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType();
                responseEl.esito = '0'; 
                response.put('response_x', responseEl);
            
}
}
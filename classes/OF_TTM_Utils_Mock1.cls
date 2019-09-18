@isTest
global class OF_TTM_Utils_Mock1 implements WebServiceMock {
    
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
               
        OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element responseElement = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element();
        responseElement.Esito = '1';
        response.put('response_x', responseElement); 
                 
   }
}
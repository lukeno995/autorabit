@isTest
global class OF_TTM_WS_OUT_Sincronizzazione_Mock implements WebServiceMock { 
   
    global void doInvoke(
        Object stub,
        Object request,
        Map<String,Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
         
           
            if( request instanceof OF_TTM_WS_OUT_Notifica.TroubleTicketNotify_Forward2TTM_Req_element)
            {
                OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element responseElement = new OF_TTM_WS_OUT_Notifica.TroubleTicketNotifyResp_element();
                response.put('response__x',responseElement);
            }
        
        }
}
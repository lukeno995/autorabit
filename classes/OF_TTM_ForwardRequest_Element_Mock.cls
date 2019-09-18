@isTest
global class OF_TTM_ForwardRequest_Element_Mock implements WebServiceMock {
    
    public static boolean isACK;
    
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
                       
            if(isAck){
            	OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element response_tt = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
                response_tt.ESITO ='0';
                response.put('response_x', response_tt);

            }
            if(!isACK){
            	OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element response_tt = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
                response_tt.ESITO ='1';
				response_tt.codice_motivazione ='A_K8';               
                response.put('response_x', response_tt);
                
            }
        }
}
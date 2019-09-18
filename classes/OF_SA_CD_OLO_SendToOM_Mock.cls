@isTest
global class OF_SA_CD_OLO_SendToOM_Mock implements WebServiceMock {
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
               
        OF_SA_WS_OM_Response.Esito_element resp= new OF_SA_WS_OM_Response.Esito_element();
        //OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element resp = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
       // resp.Esito = '1';
        
        response.put('response_x', resp ); 
      
    }
}
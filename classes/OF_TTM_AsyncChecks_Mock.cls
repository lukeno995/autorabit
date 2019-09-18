@isTest
global class OF_TTM_AsyncChecks_Mock implements WebServiceMock {
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
               
      /*  EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = 'Test';
        ser.EOF_ID_Notifica__c = 'Test';
        insert ser;*/
        if(request instanceOf OF_TT_WS_Notifica.TroubleTicketNotify_element){
	        if(!OF_TTM_AsyncChecksTEST.nack){
					OF_TT_WS_Notifica.TroubleTicketNotifyResp_element resp1 = new OF_TT_WS_Notifica.TroubleTicketNotifyResp_element();
					resp1.Esito = '0';
			        response.put('response_x', resp1);
	        }
        	else{
				OF_TT_WS_Notifica.TroubleTicketNotifyResp_element resp1 = new OF_TT_WS_Notifica.TroubleTicketNotifyResp_element();
				resp1.Esito = '1';
		        response.put('response_x', resp1);
			}
        }
    	if(request instanceOf OF_TTM_ForwardRequest_Element.Forward2TTM_Req_element){
        	 if(!OF_TTM_AsyncChecksTEST.nackTTM){
	        	OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element resp1 = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
		        resp1.Esito = '0';
		        response.put('response_x', resp1); 
        	 }
        	 else{
        	 	OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element resp1 = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
		        resp1.Esito = '1';
		        response.put('response_x', resp1);
        	} 
	        	
        } 
}


}
@isTest
global class OF_TTM_AsyncChecks_Mock1 implements WebServiceMock {
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
        /*       
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        //eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Tipo_Comunicazione__c = '1';
        insert eaiLog;
        */
        
		if(request instanceOf OF_TT_WS_Notifica.TroubleTicketNotify_element){
			OF_TT_WS_Notifica.TroubleTicketNotifyResp_element resp1 = new OF_TT_WS_Notifica.TroubleTicketNotifyResp_element();
			resp1.Esito = '0';
	        response.put('response_x', resp1);
		}
		if(request instanceOf OF_TTM_ForwardRequest_Element.Forward2TTM_Req_element){
        	OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element resp1 = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
	        resp1.Esito = '0';
	        response.put('response_x', resp1); 
        } 
	}
}
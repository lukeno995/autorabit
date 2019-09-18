@isTest
    global class OF_PP_OLO_SendToOM_mock implements WebServiceMock {
    
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
                EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
                ser.EOF_PROFILO__c = 'Test';
                ser.EOF_ID_Notifica__c = 'Test';
                insert ser;
                
                //OF_PP_WS_VLAN_OM_Activation.AsyncActivation_PreProvisioning_OpenStreamPortTypeEndpoint0 res= new OF_PP_WS_VLAN_OM_Activation.AsyncActivation_PreProvisioning_OpenStreamPortTypeEndpoint0();
                OF_PP_WS_VLAN_OM_Response.Esito_element res = new OF_PP_WS_VLAN_OM_Response.Esito_element();
                res.Esito = '0';
                System.debug('***res mock***:'+res);
                response.put('response_x', res); 
                
       }
    }
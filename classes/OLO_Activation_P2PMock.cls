@isTest
global with sharing class OLO_Activation_P2PMock implements WebServiceMock {

    OLO_Activation_P2PSchema.Create_Response response_x = new OLO_Activation_P2PSchema.Create_Response();
    
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

            response_x.ID_NOTIFICA = '1111';
            response_x.ESITO = '0';
        
        	response.put('response_x', response_x);
        }
}
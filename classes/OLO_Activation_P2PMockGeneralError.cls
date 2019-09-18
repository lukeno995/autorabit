@isTest
global with sharing class OLO_Activation_P2PMockGeneralError implements WebServiceMock {

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
        	
            response_x.ID_NOTIFICA = '1234';
            response_x.ESITO = '1';
            response_x.CODICE_MOTIVAZIONE = OF_CheckManager_P2P.OBB_ERROR_CODE_TB;
            response_x.MOTIVAZIONE = OF_CheckManager_P2P.OBB_ERROR_MSG_TB;
        
        	response.put('response_x', response_x);
        }
}
public without sharing class OF_StatusUpdateP2PManager {

    private static OF_StatusUpdateP2PService servicee;

    private OF_StatusUpdateP2PManager() {

    }

    public static OF_StatusUpdate_P2P.Response start(OF_StatusUpdate_P2P.Request rqst) {
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);

        // esito ko 
        // traccio i log e do la response
        if(rspnse.esito == '1') {
            OF_Utils_P2P.writeLog(rqst, rspnse);
            return rspnse;
        }
        
        if(rspnse.esito == '0') { 
            if(rqst.tipo_notifica.equalsIgnoreCase('Ordine')) {
                servicee = OF_StatusUpdateFactory.getP2PService(rqst.id_ordine);
                System.debug('@@@@@ OF_StatusUpdateP2PManager.start: servicee : ' + servicee);
            } else {
                servicee = new OF_StatusUpdateP2PAttiva();
                System.debug('@@@@@ OF_StatusUpdateP2PManager.start: servicee : ' + servicee);
            }

            if(servicee == null) {
                return OF_CheckManager_P2P.buildResponseError(OF_CheckManager_P2P.TYPE_ERROR_CODE, 'id_ordine', rqst.id_notifica);
            }
    
            rspnse = servicee.doEspletamento(rqst, rspnse);
            if(!Test.isRunningTest()){
                OF_Utils_P2P.writeLog(rqst, rspnse);  }      
        }
        
        return rspnse;
    }

}
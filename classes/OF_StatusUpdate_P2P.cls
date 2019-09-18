global class OF_StatusUpdate_P2P {
    
    global class Request {
        webservice String id_notifica;
        webservice String id_esito;
        webservice Datetime data_notifica;
        webservice String id_fattibilita;
        webservice String tipo_notifica;
        webservice String id_ordine;
        webservice String id_ordine_kit;
        webservice String stato_ordine;
        webservice String codice_motivazione;
        webservice String motivazione;
        webservice String id_risorsa;
        webservice String data_espletamento_ordine;
        webservice String note; 
        webservice String attachment_name;
        webservice Blob attachment;
        webservice String svlan_id;
    }

    global class Response {
        webservice String id_notifica;
        webservice String esito;
        webservice String codice_motivazione;
        webservice String motivazione;
    }

    webservice static Response updateStat(Request rqst) { 
        try {
            Response response = OF_StatusUpdateP2PManager.start(rqst);       
            System.debug('OF_StatusUpdate_P2P -- request : ' + rqst);
            System.debug('OF_StatusUpdate_P2P -- response : ' + response);
            return response;
        } catch (IllegalRequestException e) {
            Response response = new Response();
            response.esito = '1';
            response.id_notifica = rqst.id_notifica;
            response.codice_motivazione = e.getDescription();
            response.motivazione = e.getCode();
            System.debug('updateStat - error / stacktrace ' + e.getMessage() + ' / ' + e.getStackTraceString());
            return response;
        } catch (Exception e) {
            Response response = new Response();
            response.esito = '1';
            response.id_notifica = rqst.id_notifica;
            response.codice_motivazione = OF_CheckManager_P2P.TECH_ERROR_CODE;
            response.motivazione = e.getMessage();
            System.debug('updateStat - error / stacktrace ' + e.getMessage() + ' / ' + e.getStackTraceString());
            return response;
        }        
    }
}
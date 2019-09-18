global class OF_CV_WS_Invio_Link {

    global class Tracking {
        webservice String ID_REQUEST;
        webservice String ID_RICHIESTA_VENDIBILITA;
        webservice String OLO;
        webservice String SERVIZIO;   
        webservice String LINK_FILE;
        webservice String ESITO;
        webservice String DESCRIZIONE_ESITO;   
    }
    
    global class ResponseFromSend{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String DESCRIZIONE_ESITO; 
    }
    
    webservice static ResponseFromSend ResponseRegoleVendita (Tracking tr){
       return OF_CV_Entry_Checks_Invio_Link.syncCheck(tr);
    }
}
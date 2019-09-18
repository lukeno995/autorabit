public without sharing class OF_CheckManager_P2P {

    public static final String ESITO_OK = '0';
    public static final String ESITO_KO = '1';

    public static String STATO_ORDINE_0 ='0'; 
    public static String STATO_ORDINE_1 ='1';
    public static String STATO_ORDINE_2 ='2'; // EspletatoOK
    public static String STATO_ORDINE_3 ='3';

    public static String TIPO_NOTIFICA_ORD = 'Ordine';
    public static String TIPO_NOTIFICA_KIT = 'Kit';

    // TIBCO
    // codice errore tecnico tibco
    public static final String TECH_ERROR_CODE_TB = 'A_K8';
    // codice campo obbligatorio assente tibco
    public static final String OBB_ERROR_CODE_TB = 'A_K9';
    // codice valore non consentito tibco
    public static final String TYPE_ERROR_CODE_TB = 'A_K10';
     
    public static String TECH_ERROR_MSG_TB = 'Errore Tecnico di Interfaccia (errore Tibco).';
    public static String OBB_ERROR_MSG_TB = 'Campo xx obbligatorio non valorizzato (errore Tibco).';
    public static String TYPE_ERROR_MSG_TB = 'Valore campo xx non ammesso (errore Tibco).';
    // END - TIBCO
    // Errori dal SF verso TIBCO
    
    // codice errore tecnico 
    public static final String TECH_ERROR_CODE = 'A_K11';
    // codice campo obbligatorio assente 
    public static final String OBB_ERROR_CODE = 'A_K12';
    // codice valore non consentito 
    public static final String TYPE_ERROR_CODE = 'A_K13'; 

    public static String TECH_ERROR_MSG = 'Errore Tecnico di Interfaccia.';
    public static String OBB_ERROR_MSG = 'Campo xx obbligatorio non valorizzato.';
    public static String TYPE_ERROR_MSG = 'Valore campo xx non ammesso.';  
    // END - Errori dal SF verso TIBCO 

    private static OF_StatusUpdate_P2P.Request rqst = null;
    private static OF_StatusUpdate_P2P.Response rspnse = null;
    private static ErrorField errField = new ErrorField();

    private OF_CheckManager_P2P() {}

    // Check campi request del servizio OF_StatusUpdate_P2P
    public static OF_StatusUpdate_P2P.Response checkUpdateRqst(OF_StatusUpdate_P2P.Request rqst) {
        System.debug('##### OF_CheckManager_P2P.checkUpdateRqst #####');
        OF_CheckManager_P2P.rqst = rqst;
        System.debug('##### Request: ' + rqst + ' #####');

        if( (checkStringField(rqst.id_notifica, 'id_notifica', 255) != null)
            || (checkStringField(rqst.id_esito, 'id_esito', 255) != null)
            || (checkDataNotifica(rqst.data_notifica, 'data_notifica') != null)
            || (checkStringField(rqst.id_fattibilita, 'id_fattibilita', 255) != null)
            || (checkTipoNotifica(rqst.tipo_notifica, 'tipo_notifica') != null)
            || (checkIdOrdine(rqst.id_ordine, 'id_ordine', 255) != null)
            || (checkIdOrdineKit(rqst.id_ordine_kit, 'id_ordine_kit', 255) != null)
            || (checkStatoOrdine(rqst.stato_ordine, 'stato_ordine') != null)
            || (checkIdRisorsa(rqst.id_risorsa, 'id_risorsa', 255) != null)
            || (checkDataEspletamentoOrdine(rqst.data_espletamento_ordine, 'data_espletamento_ordine', 255) != null)
            || (checkAttachment(rqst.attachment, rqst.attachment_name) != null)) {
                buildError(errField.errorCode, errField.field);

                System.debug('##### OF_CheckManager_P2P.checkUpdateRqst -- NACK response: ' + rspnse + ' #####');
                
                return rspnse;
        } else {
            rspnse = new OF_StatusUpdate_P2P.Response();
            rspnse.id_notifica = rqst.id_notifica;
            rspnse.esito = ESITO_OK;
            System.debug('##### OF_CheckManager_P2P.checkUpdateRqst -- ACK response: ' + rspnse + ' #####');
            return rspnse;
        }

    }

    @testVisible
    private static ErrorField checkDataNotifica(Datetime value, String field) {
        if(rqst.data_notifica == null) {
            errField.errorCode = OBB_ERROR_CODE;
            errField.field = field;
            return errField;
        } 
        return null;
    } 

    @testVisible
    private static ErrorField checkTipoNotifica(String value, String field) {
        if (TIPO_NOTIFICA_ORD.equalsIgnoreCase(value) || TIPO_NOTIFICA_KIT.equalsIgnoreCase(value)) {
            return null;
        } else {
            if (String.isBlank(value)) {
                errField.errorCode = OBB_ERROR_CODE;
                errField.field = field;
                return errField;
            } else {
                errField.errorCode = TYPE_ERROR_CODE;
                errField.field = field;
                return errField;
            }

        }       
    }

    // Campo obbligatorio se tipo notifica == 'Ordine'
    @testVisible
    private static ErrorField checkIdOrdine(String value, String field, Integer maxLength) {
        if(TIPO_NOTIFICA_ORD.equalsIgnoreCase(rqst.tipo_notifica)) {
            return checkStringField(value, field, maxLength);
        } else {
            return null;
        }
    }

    // Campo obbligatorio se tipo notifica == 'Kit'
     @testVisible
    private static ErrorField checkIdOrdineKit(String value, String field, Integer maxLength) {
        if(TIPO_NOTIFICA_KIT.equalsIgnoreCase(rqst.tipo_notifica)) {
           return checkStringField(value, field, maxLength);
        } else {
            return null;
        }
        
    }
	@testVisible
    private static ErrorField checkStatoOrdine(String value, String field) {
        if( STATO_ORDINE_2.equalsIgnoreCase(value)) {            
            return null;
        } else {
            if(String.isBlank(value)) {
                errField.errorCode = OBB_ERROR_CODE;
                errField.field = field;
                return errField;
            } else {
                errField.errorCode = TYPE_ERROR_CODE;
                errField.field = field;
                return errField;
            }
        }  
    }
	@testVisible
    private static ErrorField checkIdRisorsa(String value, String field, Integer maxLength) {
        if(TIPO_NOTIFICA_ORD.equalsIgnoreCase(rqst.tipo_notifica) && STATO_ORDINE_2.equals(rqst.stato_ordine)) {
            return checkStringField(value, field, maxLength);
        } else {
            return null;
        }
    }

    // TODO - to test
    @testVisible
    private static ErrorField checkDataEspletamentoOrdine(String value, String field, Integer maxLength) {
        if(STATO_ORDINE_2.equals(rqst.stato_ordine)) {
            ErrorField check =  checkStringField(value, field, maxLength);
            if(check != null) {
                return check;
            } else {
                return checkFormat(value, field);
            }
        } else {
            return null;
        } 
    }

    // TODO
    // Mancano dettagli sul tracciato - To complete
    @testVisible
    private static ErrorField checkAttachment(Blob field, String fileName) {    
        Integer maxDimension = 6 * 1024 * 1024;  
        if(rqst.stato_ordine == STATO_ORDINE_2) {
            return null;
        }
        if (field != null ) {
            if (String.isBlank(fileName) || fileName.length() > 255) {
                errField.errorCode = OBB_ERROR_CODE;
                errField.field = 'attachment_name';
                return errField;            
            }
            if(field.size() > maxDimension) {
                errField.errorCode = TYPE_ERROR_CODE;
                errField.field = 'attachment';
                return errField;   
            }
            return null;
        } else {
            errField.errorCode = OBB_ERROR_CODE;
            errField.field = 'attachment';
            return errField;
        }        
    }

    // Verifica valorizzazione e lunghezza massima di un campo
    // maxLength == -1 per saltare il controllo sulla lunghezza
    public static ErrorField checkStringField(String value, String field, Integer maxLength) {
        System.debug('##### -- OF_CheckManager_P2P.checkStringField -- value: ' + value + ' -- field : ' + field + ' -- maxLength ' + maxLength);
        if(String.isBlank(value)) {
            errField.errorCode = OBB_ERROR_CODE;
            errField.field = field;
            return errField;
        } else if( (maxLength != -1) && value.length() > maxLength) {
            errField.errorCode = TYPE_ERROR_CODE;
            errField.field = field;
            return errField;
        }
        return null;
    }

    // TODO- to test
    @testVisible
    private static ErrorField checkFormat(String value, String field) {
        String[] values = value.split('-');
        if(values.size() != 3) {
            errField.errorCode = TYPE_ERROR_CODE;
            errField.field = field;
            return errField;
        } 

        if(values[0].length() != 4 || values[1].length() != 2 || values[2].length() != 2) {
            errField.errorCode = TYPE_ERROR_CODE;
            errField.field = field;
            return errField;
        } 
        return null;

    }
	@testVisible
    private static void buildError(String errorCode, String field) {
        System.debug('##### -- OF_CheckManager_P2P.buildError -- errorCode: ' + errorCode + ' -- field : ' + field);
        buildError(errorCode, field, rqst.id_notifica);
    }

    public static OF_StatusUpdate_P2P.Response buildResponseError(String errorCode, String field, String idNotifica) {
        buildError(errorCode, field, idNotifica);
        System.debug('##### buildResponseError: ' + rspnse);
        return rspnse;
    }
	@testVisible
    private static void buildError(String errorCode, String field, String idNotifica) {
        System.debug('OF_CheckManager_P2P.buildError');
        rspnse = new OF_StatusUpdate_P2P.Response();
        rspnse.esito = ESITO_KO;
        rspnse.id_notifica = idNotifica;
        rspnse.codice_motivazione = errorCode;

        if(errorCode == OBB_ERROR_CODE) {
            rspnse.motivazione = OBB_ERROR_MSG.replace('xx', field);
        }

        if(errorCode == TYPE_ERROR_CODE) {
            rspnse.motivazione = TYPE_ERROR_MSG.replace('xx', field);
        }

        if (errorCode == TECH_ERROR_CODE) {
            rspnse.motivazione = TECH_ERROR_MSG;
        }
        System.debug('##### -- OF_CheckManager_P2P.buildError -- response: ' + rspnse);
    }

    public class ErrorField {
        public String errorCode = '';
        public String field = '';
    }

}
public without sharing class RequestChecker {

    public static final String MANDATORY_ERR_CODE = 'mandatoryErrCode';
    public static final String MANDATORY_ERR_MSG = 'mandatoryErrMsg';

    public static final String TYPE_ERR_CODE = 'typeErrCode';
    public static final String TYPE_ERR_MSG = 'typeErrMsg';
    
    /*
        I campi mandatoryErrMsg, typeErrMsg sono nel formato '.. campo .. xx etc.' dove xx è il nome 
        del campo da validare. In caso di errore xx sarà sostituito dal nome del campo che ha 
        generato l'errore.  
    */
    private String mandatoryErrCode;
    private String mandatoryErrMsg;

    private String typeErrCode;
    private String typeErrMsg;

    // Passare una mappa in cui le chiavi sono i nomi delle variabili di istanza di questa
    // classe e i valori i corrispondenti messaggi e codici di errore
    public RequestChecker(Map<String,String> messages) {
        this.mandatoryErrCode = messages.get('mandatoryErrCode');
        this.mandatoryErrMsg = messages.get('mandatoryErrMsg');
        this.typeErrCode = messages.get('typeErrCode');
        this.typeErrMsg = messages.get('typeErrMsg');
    }

    public void checkStringField(String value, String name, Integer maxLength) {
        System.debug('#### checkField -- START');
        checkStringNotBlank(value, name);
        checkStringFieldLength(value, name, maxLength);
    }

    public void checkStringNotBlank(String value, String name) {
        System.debug('#### checkStringNotBlank -- START - name - value: ' + name + ' - ' + value);
        if(String.isBlank(value)) {
            System.debug('#### checkStringNotBlank -- value is blank. Field: ' + name);
            String code = mandatoryErrCode;
            String description = mandatoryErrMsg.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public void checkStringFieldLength(String value, String name, Integer maxLength) {
        System.debug('#### checkFieldLength -- START - name - value: ' + name + ' - ' + value);
        if(value.length() > maxLength) {
            System.debug('#### checkStringNotBlank -- value is too long. Field: ' + name);
            String code = typeErrCode;
            String description = typeErrMsg.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public void checkObjectField(Object value, String name) {
        System.debug('#### checkObjectField -- START');
        if(value == null ) {
            System.debug('#### checkObjectField -- object is null. Field: ' + name);
            String code = mandatoryErrCode;
            String description = mandatoryErrMsg.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public void checkListField(List<Object> value, String name) {
        System.debug('#### checkListField -- START');
        if(value == null || value.isEmpty()) {
            System.debug('#### checkListField -- list is null or empty. Field: ' + name);
            String code = mandatoryErrCode;
            String description = mandatoryErrMsg.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public void checkValueField(String value, String name, Integer maxLength, Set<String> permittedValues){
        System.debug('#### checkValueField -- START');
        checkStringField(value, name, maxLength);
        if(!permittedValues.contains(value)){
            System.debug('#### checkValueField -- value not permitted. Field / value ' + name + ' / ' + value);
            String code = typeErrCode;
            String description = typeErrMsg.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public void checkAttachment(Blob value, String name, Integer maxSize) {    
        checkObjectField(value, name);
        if(value.size() > maxSize){
            System.debug('#### checkAttachment -- attachement size too large. Size: ' + value.size());
            String code = typeErrCode;
            String description = typeErrMsg.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }       
    }

}
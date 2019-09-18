public without sharing class OLO_ActivationP2PRequestCheck {

    public static final String SEDE_SATELLITE = 'Satellite';
    public static final String SEDE_MASTER = 'Master';

    OLO_ActivationP2PRequestCheck() {}

    public static void checkActivationRequest(OLO_Activation_P2PSchema.Create_P2P_Request_element rqst) {
        System.debug('#### checkActivationRequest -- START');      
        //HEADER  
        checkStringField(rqst.header.ID_NOTIFICA, 'ID_NOTIFICA', 255);
        checkStringField(rqst.header.TIPO_RICHIESTA, 'TIPO_RICHIESTA', 100);
        checkObjectField(rqst.header.DATA_CREAZIONE, 'DATA_CREAZIONE');

        // FATTIBILITA'
        checkStringField(rqst.fattibilita.ID_FATTIBILITA, 'ID_FATTIBILITA', 255);
        checkStringField(rqst.fattibilita.CODICE_OPERATORE, 'CODICE_OPERATORE', 255);

        //ORDINE
        for(OLO_Activation_P2PSchema.ORDINE_element ordine : rqst.fattibilita.ORDINE) {
            checkStringField(ordine.AZIONE, 'AZIONE', 255);
            checkStringField(ordine.ID_ORDINE, 'ID_ORDINE', 255);            
            checkStringField(ordine.TIPO_COLLEGAMENTO, 'TIPO_COLLEGAMENTO', 255);

            //SEDE
            for(OLO_Activation_P2PSchema.SEDE sede : ordine.SubInput1) {
                checkStringField(sede.ID_SEDE, 'ID_SEDE', 100);
                checkStringField(sede.NOME_SEDE, 'NOME_SEDE', 255);
                checkStringField(sede.INDIRIZZO, 'INDIRIZZO', 255);
                checkStringField(sede.CIVICO, 'CIVICO', 255);
                checkStringField(sede.COMUNE, 'COMUNE', 255);
                checkStringField(sede.CODICE_ISTAT, 'CODICE_ISTAT', 255);
                checkStringField(sede.POP_RACCOLTA, 'POP_RACCOLTA', 255);
                
                // POP CONSEGNA e NOME KIT CONSEGNA obbligatori per p2p attiva e-access
                if('E-Access'.equalsIgnoreCase(ordine.TIPO_COLLEGAMENTO)) {
                    checkStringField(sede.POP_CONSEGNA, 'POP_CONSEGNA', 255);
                    checkStringField(sede.NOME_KIT_CONSEGNA, 'NOME_KIT_CONSEGNA', 40);
                }

                checkStringField(sede.ID_COLLEGAMENTO, 'ID_COLLEGAMENTO', 255);
                checkStringField(sede.TIPO_PERCORSO, 'TIPO_PERCORSO', 255);

                // E-Line
                if(OLO_ActivationP2PUtils.COLLEGAMENTO_E_LINE.equals(ordine.TIPO_COLLEGAMENTO)) {
                    checkStringField(sede.TIPOLOGIA_SEDE, 'TIPOLOGIA_SEDE', 255);
                    if(SEDE_SATELLITE.equals(sede.TIPOLOGIA_SEDE)) {
                        checkStringField(sede.ID_SEDE_MASTER, 'ID_SEDE_MASTER', 255);
                    } 
                    if(SEDE_MASTER.equals(sede.TIPOLOGIA_SEDE)) {
                        checkStringField(sede.SERVICE_ATTRIBUTE, 'SERVICE_ATTRIBUTE', 255);
                    }              
                        
                }
                
                // VLAN
                if(OLO_ActivationP2PUtils.CONTRATTO_P2P_ATTIVA.equalsIgnoreCase(rqst.fattibilita.TIPO_CONTRATTO)
                    && !OLO_ActivationP2PUtils.SEDE_MASTER.equals(sede.TIPOLOGIA_SEDE)) {
                    checkListField(sede.SubInput2, 'VLAN');
                    for(OLO_Activation_P2PSchema.VLAN vlan : sede.SubInput2) {
                        checkStringField(vlan.MODELLO_SERVIZIO, 'MODELLO_SERVIZIO', 255);
                        checkStringField(vlan.PROFILO, 'PROFILO', 255);
                        
                        // E' una lista che, in caso sia presente una vlan,
                        // al massimo può essere vuota
                        checkObjectField(vlan.SubInput5, 'COS');                        
                    }
                }
            }
        }
        // KIT
        if(rqst.fattibilita.SubInput4 != null) {
            for(OLO_Activation_P2PSchema.KIT kit : rqst.fattibilita.SubInput4) {
                checkStringField(kit.AZIONE, 'AZIONE', 255);
                checkStringField(kit.ID_ORDINE_KIT, 'ID_ORDINE_KIT', 255);
                checkStringField(kit.NOME_KIT_CONSEGNA, 'NOME_KIT_CONSEGNA', 40);
                checkStringField(kit.POP_CONSEGNA, 'POP_CONSEGNA', 255);
                checkStringField(kit.INDIRIZZO_CONSEGNA, 'INDIRIZZO_CONSEGNA', 255); 
                checkStringField(kit.SERVICE_ATTRIBUTE, 'SERVICE_ATTRIBUTE', 255);           
            }
        }
    }

    public static void checkStringField(String value, String name, Integer maxLength) {
        System.debug('#### checkField -- START');
        checkStringNotBlank(value, name);
        checkStringFieldLength(value, name, maxLength);
    }

    public static void checkStringNotBlank(String value, String name) {
        System.debug('#### checkStringNotBlank -- START - name - value: ' + name + ' - ' + value);
        if(String.isBlank(value)) {
            System.debug('#### checkStringNotBlank -- value is blank. Field: ' + name);
            String code = OF_CheckManager_P2P.OBB_ERROR_CODE_TB;
            String description = OF_CheckManager_P2P.OBB_ERROR_MSG_TB.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public static void checkStringFieldLength(String value, String name, Integer maxLength) {
        System.debug('#### checkFieldLength -- START - name - value: ' + name + ' - ' + value);
        if(value.length() > maxLength) {
            System.debug('#### checkStringNotBlank -- value is too long. Field: ' + name);
            String code = OF_CheckManager_P2P.TYPE_ERROR_CODE_TB;
            String description = OF_CheckManager_P2P.TYPE_ERROR_MSG_TB.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public static void checkObjectField(Object value, String name) {
        System.debug('#### checkObjectField -- START');
        if(value == null ) {
            System.debug('#### checkObjectField -- object is null. Field: ' + name);
            String code = OF_CheckManager_P2P.OBB_ERROR_CODE_TB;
            String description = OF_CheckManager_P2P.OBB_ERROR_MSG_TB.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

    public static void checkListField(List<Object> value, String name) {
        System.debug('#### checkListField -- START');
        if(value == null || value.isEmpty()) {
            System.debug('#### checkListField -- list is null or empty. Field: ' + name);
            String code = OF_CheckManager_P2P.OBB_ERROR_CODE_TB;
            String description = OF_CheckManager_P2P.OBB_ERROR_MSG_TB.replace('xx', name);
            throw new IllegalRequestException(code, description);
        }
    }

}
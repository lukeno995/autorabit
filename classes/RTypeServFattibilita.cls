public class RTypeServFattibilita {
    private RTypeServFattibilita() {}

    /*
        RecordType.DeveloperName fields
    */
    public static final String ASSET_P2P_ATTIVA_KIT            = 'PO_Asset_P2P_Attiva_KIT';

    public static final String CASE_P2P_ATTIVA_REQUEST         = 'PO_Richiesta_a_servizio_a_fattibilit';
    public static final String LOG_P2P_ATTIVA_REQUEST          = 'PO_P2PAttiva_Request';
    public static final String CASE_P2P_ATTIVA_COLLEGAMENTO    = 'PO_Collegamento_P2P_Attiva';
    public static final String LOG_P2P_ATTIVA_COLLEGAMENTO     = 'P2P_Attiva_Collegamento';
    public static final String CASE_P2P_ATTIVA_KIT             = 'PO_Case_P2P_Attiva_KIT';
    public static final String LOG_P2P_ATTIVA_KIT              = 'PO_Log_P2P_Attiva_KIT';
    public static final String CASE_P2P_ATTIVA_ORDINE          = 'PO_Ordine_P2P_Attiva';
    public static final String LOG_P2P_ATTIVA_ORDINE           = 'PO_P2P_Attiva_Ordine';
    public static final String CASE_P2P_ATTIVA_COLLEGAMENTO_ELINE    = 'PO_Collegamento_P2P_Attiva_ELine';
    public static final String LOG_P2P_ATTIVA_COLLEGAMENTO_ELINE     = 'P2P_Attiva_Collegamento_ELine';  

    public static final String CASE_P2P_BASE_COLLEGAMENTO      = 'PO_Collegamento_P2P';
    public static final String CASE_P2P_BASE_ORDINE            = 'PO_Ordine_P2P';  
    public static final String CASE_P2P_ORDINE_ELINE = 'P2P_Attiva_COrdine_ELine';

    public static final String LOG_VLAN         = 'OF_SA_Vlan';
    public static final String LOG_VLAN_ELINE   = 'OF_SA_Vlan_ELine';
    public static final String VLAN_EACCESS     = 'OF_VLAN_EAccess';
    public static final String VLAN_ELINE       = 'OF_VLAN_ELine';
    

    public static Id getRecordTypeIdByDevName(Schema.SObjectType objectType, String developerName) {
        try {
            return objectType
            .getDescribe()
            .getRecordTypeInfosByDeveloperName()
            .get(developerName)
            .getRecordTypeId();
        } catch (Exception e) {
            throw new InvalidParameterValueException('Unknown recordtype developer name ', developerName);
        }
        
    }

    public static Id getRecordTypeIdByName(Schema.SObjectType objectType, String name) {
        try {
            return objectType
            .getDescribe()
            .getRecordTypeInfosByName()
            .get(name)
            .getRecordTypeId();
        } catch (Exception e) {
            throw new InvalidParameterValueException('Unknown recordtype name: ', name);
        }
        
    }

}
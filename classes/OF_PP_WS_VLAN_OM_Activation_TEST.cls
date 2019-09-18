@isTest
private class OF_PP_WS_VLAN_OM_Activation_TEST { 

    public static EOF_EAI_Service_Log__c richiestaLogCreation()
    {
        EOF_EAI_Service_Log__c richiestaLog = new EOF_EAI_Service_Log__c();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF RichiestaVLAN').getRecordTypeId();
        richiestaLog.recordTypeId = rtId;
        richiestaLog.EOF_Codice_Operatore__c = 'TIS';
        richiestaLog.EOF_Tipo_Comunicazione_String__c = 'Richiesta VLAN';
        return richiestaLog;
    }

    public static EOF_EAI_Service_Log__c vlanLogCreation()
    {
        EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - ActivationRequest').getRecordTypeId();
        log.recordTypeId = rtId;
        log.Nome_del_KIT__c = 'TEST_K';
        log.EOF_Codice_Operatore__c = 'TIS';
        log.POP__c = 'pop_c_01';
        log.PO_PP_POP_raccolta__c = 'pop_r_01';  
        log.Traffico__c = 'VULA Openstream Direct';
        log.Banda_Interfaccia__c = '400';
        log.PO_PP_Interfaccia__c = '1 Giga';
        log.EOF_Stato_Richiesta__c = 'Inserita Portale';
        log.PO_PP_Progressivo_Ordine__c = 1;
        log.PO_PP_User_VLAN__c = 'vlan_01';
        log.EOF_ID_NOTIFICA__c = 'A123456';
        log.PO_PP_cos_class__c = 'MonoCOS';
        log.PO_PP_cos_type__c = '5';
        log.PO_PP_cos_remarking__c = 'SI';
        log.PO_PP_dhcp_Option82__c = 'NO';
        log.EOF_DATA_NOTIFICA__c = System.Today();
        return log;
    }
    
    public static Case caseCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }
    
    public static Account tiscaliAccountCreation()
    {
        Account a = new Account();
        a.name = 'Tiscali';
        a.EOF_Codice_Operatore__c = 'TIS';
        insert a;
        return a;
    }
    
    public static EOF_EAI_Service_Log__c cosLogCreation()
    {
        EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c ();
        Id rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - COS').getRecordTypeId();
        log.recordTypeId = rtId;
        log.PO_PP_cos_class__c = 'MonoCOS';
        return log;
    }

	static testmethod void testMethod1()
    {
        OF_Puntamento_Callout__c p = new OF_Puntamento_Callout__c();
        p.Name='OGW';
        p.OF_OGW__c='OFS-SVIL-WS';
        insert p;
        
        String endpoint_x = 'https://OFS-SVIL-WS.ENEL.COM:44300/Business/Services/PreProvisioning/Resource/GW_Activation_PreProvisioning_OpenStream.serviceagent/Activation_PreProvisioning_OpenStreamPortTypeEndpoint0';
        
        String[] ns_map_type_info = new String[]{'http://www.tibco.com/schemas/OLO_Gat_ChangeOrder/SharedResources/CommonSchema/PreProvisioning/Activation_PreProvisioning_OpenStream.xsd2', 'wwwTibcoComSchemasOloGatChangeorde_v2', 'http://xmlns.example.com/1531227217802', 'xmlnsExampleCom1531227217802_v2', 'http://www.tibco.com/schemas/OLO_Gat_ChangeOrder/SharedResources/CommonSchema/PreProvisioning/Esito.xsd3', 'wwwTibcoComSchemasOloGatChangeorde_v2'};
        
        
        RecordType rt = [Select id, name, DeveloperName
                        from RecordType
                        where name = 'OF - PP - VLAN - ActivationRequest'];
        
        
        EOF_EAI_Service_Log__c log = vlanLogCreation();
        //log.recordType = rt;
        EOF_EAI_Service_Log__c richiestaLog = richiestaLogCreation();
        insert richiestaLog;
        log.PO_PP_ID_Richiesta_testo__c = richiestaLog.id;
        
        Account a = tiscaliAccountCreation();
        Case c = caseCreation(a);
        log.caso__c = c.id;
        
        List<EOF_EAI_Service_Log__c> listLogs = new List<EOF_EAI_Service_Log__c>();
        
        listLogs.add(log);
        insert listLogs;
        
        
        Map<String,id> recordTypeMap = new map<String,Id>();
        recordTypeMap.put('OF_PP_VLAN_ActivationRequest',rt.id);
        OF_PP_GE_Utils.rtMap = recordTypeMap;
        OF_PP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        test.startTest();
        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());	
        OF_PP_WS_VLAN_OM_Activation.AsyncActivation_PreProvisioning_OpenStreamPortTypeEndpoint0 actPP = new OF_PP_WS_VLAN_OM_Activation.AsyncActivation_PreProvisioning_OpenStreamPortTypeEndpoint0();

        actPP.Activation_PreProvisioning_OpenStream(listLogs);
        
        test.stopTest();
    }
}
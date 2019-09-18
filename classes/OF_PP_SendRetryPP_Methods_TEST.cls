@isTest
private class OF_PP_SendRetryPP_Methods_TEST {
    
    public static Account tiscaliAccountCreation()
    {
        Account a = new Account();
        a.name = 'Tiscali';
        a.EOF_Codice_Operatore__c = 'TIS';
        insert a;
        return a;
    }
    
    public static EOF_EAI_Service_Log__c vlanLogCreation(Case c)
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
        log.caso__c = c.id;
        insert log;
        return log;
    }
    
    public static Case caseCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning VLAN').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }

	private static testMethod void test_retryCalloutOLOOM() 
	{
	    OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
	    insert pnt;
	    
	    OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='test';
        tibco.name='Tibco UserID';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
	    
	    Account acc = tiscaliAccountCreation();
	    Case c = caseCreation(acc);
	    EOF_EAI_Service_Log__c vlog = vlanLogCreation(c);
	    
	    Test.startTest();
	    
	    Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock1());
	    OF_PP_SendRetryPP_Methods.retryCalloutOLOOM(c.id);
	    
	    Test.stopTest();
	}
}
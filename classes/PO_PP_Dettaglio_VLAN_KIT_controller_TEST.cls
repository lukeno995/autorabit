@isTest
private class PO_PP_Dettaglio_VLAN_KIT_controller_TEST {

    public static EOF_EAI_Service_Log__c vlanLogCreation()
    {
        EOF_EAI_Service_Log__c vlanLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - PP - VLAN').getRecordTypeId();
        vlanLog.recordTypeId = rtId;
        vlanLog.PO_PP_POP_raccolta__c = 'pop_001';
        vlanLog.PO_PP_cos_type__c = 'MultiCOS';
        vlanLog.PO_PP_cos_class__c = '0 - 1 - 5';
        vlanLog.PO_PP_MultiCos_Class__c = '0 - 1 - 5';
        vlanLog.SVLAN__c = 'AX1';
        vlanLog.PO_PP_cos_remarking__c = 'None';
        vlanLog.PO_PP_dhcp_Option82__c = 'None';
        vlanLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
        insert vlanLog;
        return vlanLog;
    }

	private static testMethod void test() {
       
        EOF_EAI_Service_Log__c logV = vlanLogCreation();
        
        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('vlan',logV.id);
        ApexPages.currentPage().getParameters().put('tipo','vlan');
        PO_PP_Dettaglio_VLAN_KIT_controller contr = new PO_PP_Dettaglio_VLAN_KIT_controller();
        
        Test.stopTest();
	}
}
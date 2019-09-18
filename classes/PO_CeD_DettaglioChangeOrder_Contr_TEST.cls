@isTest
public class PO_CeD_DettaglioChangeOrder_Contr_TEST{
    
    public static testMethod void test_DettaglioChangeOrder(){
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'Canone';
        a.AccountID = acc.Id;
        insert a;
        
        EOF_EAI_Service_Log__c  service = new EOF_EAI_Service_Log__c ();
        service.OF_SA_ACK__c = True;
        service.EOF_Stato_Richiesta__c='Bozza Portale';
        service.EOF_ID_Risorsa__c = a.name;
        service.RecordTypeId = RecordTypeIdser;
        insert service;
        
        EOF_EAI_Service_Log__c  service1 = new EOF_EAI_Service_Log__c ();
        service1.OF_SA_ACK__c = true;
        service1.EOF_ID_Risorsa__c = a.name;
        service1.RecordTypeId = RecordTypeIdser1;
        service1.OF_SA_VLan_Log__c = service.Id;
        service1.EOF_Stato_Richiesta__c='Bozza Portale';
        insert service1;
        Apexpages.currentPage().getParameters().put('idRisorsa',service1.Id);
        
        PO_CeD_DettaglioChangeOrder_Controller detail = new PO_CeD_DettaglioChangeOrder_Controller();
    }
}
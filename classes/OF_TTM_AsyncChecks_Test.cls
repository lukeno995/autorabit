@isTest
public class OF_TTM_AsyncChecks_Test{
    @testSetup 
    public static void testSetUpData() {
    Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
    Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
    Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    
    }
    public static testMethod void OF_TTM_AsyncChecksMethod(){
        Id RecordTypeIdcas = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Asset a = new Asset();
        //a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'Canone';
        a.AccountID = acc.Id;
        a.OF_DataAttivazione2__c = system.today();
        a.OF_DataCessazione2__c = system.today();
        a.OF_ProfiloOpenStream__c = 'test';
        insert a;
        
        case cse = new case();
        cse.status = 'Espletato';
        cse.OF_Bonifica_Locked_Row__c  = true;
        cse.RecordTypeId = RecordTypeIdcas;
        //cse.status = 'Acquisito';
        cse.EOF_Id_Risorsa__c = a.Name;
        //cse.EOF_Id_Risorsa__c = 'Test';
        cse.AssetId = a.Id;
        cse.OF_SA_ID_Building_OM__c = 'Test';
        insert cse;
        
        EOF_EAI_Service_Log__c  service = new EOF_EAI_Service_Log__c ();
        service.OF_SA_ACK__c = True;
        service.EOF_Stato_Richiesta__c='Bozza Portale';
        service.EOF_ID_Risorsa__c = a.name;
        service.RecordTypeId = RecordTypeIdser;
        service.EOF_Tipo_Comunicazione__c = '1';
        insert service;
        
        EOF_EAI_Service_Log__c  service1 = new EOF_EAI_Service_Log__c ();
        service1.OF_SA_ACK__c = True;
        service1.EOF_ID_Risorsa__c = a.name;
        service1.RecordTypeId = RecordTypeIdser1;
        service1.OF_SA_VLan_Log__c = service.Id;
        service1.EOF_Stato_Richiesta__c='Bozza Portale';
        service1.EOF_Tipo_Comunicazione__c = '1';
        insert service1;
        
        OF_TTM_EntryChecks.sl = service;
        Test.StartTest();
        
        
        
        Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
        Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock1());
        //OF_TTM_AsyncChecks.executeDML(true,true);
        OF_TTM_AsyncChecks.checkAsync(cse.id,service.id);
        
        Test.StopTest();
    }
}
@isTest
public class OF_SyncBillingAssetTrigger_Test {
    
    @testSetup
	public static void testSetUpData() {
		Verticali__c cs2 = new Verticali__c();
		cs2.createNotifyBatchLimit__c = 10000;
		cs2.callWsBillingBatchSize__c = 4;
	
		cs2.RecordTypesAssets__c ='\'OF_Open_Stream\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'';
		
		insert cs2;
	}
     public static testMethod void test4()
     {
         test.starttest();
          String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
         
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset asset_1 = new Asset();
		asset_1.Name = 'IDR1234';
		asset_1.Status = '';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.Sync_Verticali__c=false;
        asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contratto.id;
		insert asset_1;
         
         asset_1.Name = 'IDR12345';
         asset_1.Sync_Verticali__c=true;
         update asset_1;
         test.stopTest();
     }
    
    
}
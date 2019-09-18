@isTest
public class Batch_PBEStaging_Test {
    
	
	 public static testMethod void test1() {
         Test.startTest();
         DataBase.executeBatch(new Batch_PBEStaging());
         Test.stopTest();
     }
    
    @testSetup public static void  createData(){
		
        Id pbsId = Test.getStandardPricebookId();
        List<OF_STAGING_PBE__c> stagingpbeToInsert = new List<OF_STAGING_PBE__c>();
		Product2 pApp = new Product2(
			Name = 'SERV_FATT_APPOGGIO',
			IsActive = true
		);
		insert pApp;
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
		
		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = accList[0].id;
		insert contratto;

        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = accList[0].id;
        o.OF_AccountTemporaneo__c=null;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.ContractId=contratto.id;
        o.Name ='test1';
        insert o;

		OF_STAGING_PBE__c pbeApp = new OF_STAGING_PBE__c(
			Pricebook2Id__c = pbsId,
			Product2Id__c = pApp.Id,
			UnitPrice__c = 1,
			IsActive__c = true,
			OF_Order__c = o.id,
            ERROR__c = false
		);
		stagingpbeToInsert.add(pbeApp);
        
        Pricebook2 pbApp = new Pricebook2 (
			IsActive = true,
			Name = 'SERV_FATT_APPOGGIO',
			Unit_Price__c = 1
		);
		insert pbApp;
		
		order o2 = new order();
        o2.recordtypeID = mpRT.get('OF_INORDER');
        o2.EffectiveDate = Date.newInstance(2016,3,1);
        o2.Status = 'Aperto';
        o2.AccountId = accList[0].id;
        o2.OF_AccountTemporaneo__c=null;
        o2.OF_TipologiaDiServizio__c='Attivo';
        o2.PO_IsFromOpportunity__c=true;
        o2.ContractId=contratto.id;
        o2.Name ='test2';
        insert o2;
         

		OF_STAGING_PBE__c pbeApp2 = new OF_STAGING_PBE__c(
			Pricebook2Id__c = pbApp.Id,
			Product2Id__c = pApp.Id,
			UnitPrice__c = 1,
			IsActive__c = true,
			OF_Order__c = o2.id,
            ERROR__c = false
		);
		stagingpbeToInsert.add(pbeApp2);
		insert stagingpbeToInsert;
    }

}
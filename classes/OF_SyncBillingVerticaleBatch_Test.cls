@isTest
public class OF_SyncBillingVerticaleBatch_Test {

    @testSetup
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        Insert new Verticali__c(RecordTypesAssets__c ='\'PO_Asset_Backhauling_Collegamento\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'', createNotifyBatchLimit__c = 10000, callWsBillingBatchSize__c = 4);
    }
    
	public static testMethod void test1() {

		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset asset1 = new Asset();
		asset1.Name = 'IDR1234';
		asset1.Status = 'Cessato';
		asset1.EOF_ID_Risorsa__c = 'IDR1234';
		asset1.Sync_Verticali__c=true;
		asset1.accountId = acc.id;
		asset1.OF_Contract__c = contratto.id;
		insert asset1;

		List<OF_Billing_Element_Verticale__c> bevs = new List<OF_Billing_Element_Verticale__c>();
		OF_Billing_Element_Verticale__c bev1 = new OF_Billing_Element_Verticale__c();
		bev1.name = 'BEV-' + asset1.EOF_ID_Risorsa__c + 'a';
		bev1.ID_Risorsa__c = asset1.EOF_ID_Risorsa__c;
		bev1.OF_Status__c = 'ATTIVO';
		bev1.Update_Billing__c = true;
		bev1.Asset__c = asset1.id;
		bevs.add(bev1);

		OF_Billing_Element_Verticale__c bev2 = new OF_Billing_Element_Verticale__c();
		bev2.name = 'BEV-' + asset1.EOF_ID_Risorsa__c + 'b';
		bev2.ID_Risorsa__c = asset1.EOF_ID_Risorsa__c;
		bev2.OF_Status__c = 'ATTIVO';
		bev2.Update_Billing__c = true;
		bev2.Asset__c = asset1.id;
		bevs.add(bev2);

		OF_Billing_Element_Verticale__c bev3 = new OF_Billing_Element_Verticale__c();
		bev3.name = 'BEV-' + asset1.EOF_ID_Risorsa__c + 'c';
		bev3.ID_Risorsa__c = asset1.EOF_ID_Risorsa__c;
		bev3.OF_Status__c = 'ATTIVO';
		bev3.Update_Billing__c = true;
		bev3.Asset__c = asset1.id;
		bevs.add(bev3);

		OF_Billing_Element_Verticale__c bev4 = new OF_Billing_Element_Verticale__c();
		bev4.name = 'BEV-' + asset1.EOF_ID_Risorsa__c + 'd';
		bev4.ID_Risorsa__c = asset1.EOF_ID_Risorsa__c;
		bev4.OF_Status__c = 'ATTIVO';
		bev4.Update_Billing__c = true;
		bev4.Asset__c = asset1.id;
		bevs.add(bev4);

		insert bevs;

		String assetId=(String)asset1.id;
		List<string> listidAsset=new List<string>();
		listidAsset.add(assetId);
		OF_SyncBillingVerticaleBatch SBVB1=new OF_SyncBillingVerticaleBatch(listidAsset);
		Database.BatchableContext BC;
		SBVB1.start(BC);
		SBVB1.finish(BC);
		SBVB1.execute(BC, bevs);
	}

	public static testMethod void test2()
	{
        		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset asset1 = new Asset();
		asset1.Name = 'IDR1234';
		asset1.Status = 'Cessato';
		asset1.EOF_ID_Risorsa__c = 'IDR1234';
		asset1.Sync_Verticali__c=true;
		asset1.accountId = acc.id;
		asset1.OF_Contract__c = contratto.id;
		insert asset1;
        
        OF_Billing_Element_Verticale__c bev4 = new OF_Billing_Element_Verticale__c();
		bev4.name = 'BEV-' + asset1.EOF_ID_Risorsa__c + 'd';
		bev4.ID_Risorsa__c = asset1.EOF_ID_Risorsa__c;
		bev4.OF_Status__c = 'ATTIVO';
		bev4.Update_Billing__c = true;
		bev4.Asset__c = asset1.id;
		insert bev4;

        
		// string assetId='';
		List<string> listidAsset=new List<string>();
		// listidAsset.add(assetId);
		OF_SyncBillingVerticaleBatch SBVB1=new OF_SyncBillingVerticaleBatch(listidAsset);
		Database.BatchableContext BC;
		SBVB1.start(BC);
		SBVB1.finish(BC);

	}
}
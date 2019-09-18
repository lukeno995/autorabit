@isTest
private class BatchSendAssetVerticali_TEST {
    
    public static Verticali__c createVerticaliCustomSetting() {

        Verticali__c cs = new Verticali__c();
        cs.Name='test';
        cs.delayAlgoritmo__c = 1;
        cs.delayBonifica__c = 240;
        cs.Email__c = 'test@test.org';
        cs.Email_CC__c = 'test@test.org';
        cs.Email_from__c = 'Contattaci OpenFiber';
        cs.emailSubject__c = 'subj';
        cs.giorniTolleranza__c = -2;
        cs.limitBatch__c = 10;
        cs.TextBody__c = 'text';
        
        insert cs;
        return cs;
    } 
    
    public static OF_Asset_Verticale__c assetVerticaleCreation1()
    {
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Nazionale'; 
        va.Civico__c = '34';
        va.Comune__c = 'Milano';
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001'; 
        va.ID_GIS_Scala_Palazzina__c = 'AX001'; 
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        insert va;
        
        return va;
    }
    
    public static OF_Asset_Verticale__c assetVerticaleCreation2()
    {
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Nazionale'; 
        va.Civico__c = '34';
        va.Comune__c = 'Milano';
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001'; 
        va.ID_GIS_Scala_Palazzina__c = 'AX001'; 
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Inviato_PostGreSQL__c = true;
        insert va;
        
        return va;
    }
    
    public static Account accountCreation()
    {
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
        
        return acc;
    }
    
    public static Asset assetCreation(Account acc){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = '1234567890123456789';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        //asset_1.EOF_ID_Risorsa__c = 'xxxx';
        asset_1.OF_ID_Building__c = 'yyyyy';
		asset_1.OF_Particella_Toponomastica__c  ='VIA';
        asset_1.OF_Indirizzo__c = 'JJJJJ';  
        asset_1.OF_Civico__c ='9';  
        asset_1.OF_Comune__c ='Napoli';        
        insert asset_1;

        return asset_1;
    }
    
    public static OF_Billing_Element_Verticale__c billingElementVCreation(Asset asset_t, OF_Asset_Verticale__c va)
    {
        OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
        verticalBE.name = 'BEV-'+asset_t.EOF_ID_Risorsa__c;
        verticalBE.ID_Risorsa__c = asset_t.EOF_ID_Risorsa__c;
        verticalBE.Data_Attivazione__c = System.now();
        //Relaziono il BE Verticale all'Asset Standard
        verticalBE.Asset__c = asset_t.id;
        //Relaziono il BE Verticale all'Asset Verticale
        verticalBE.Asset_Verticale__c = va.id;
        insert verticalBE;
        return verticalBE;
    }
    
      public static OF_Staging_PNI__c stagingCreation()
    {
        OF_Staging_PNI__c stg = new OF_Staging_PNI__c();
        stg.OF_Comune__c='Napoli';
        insert stg;
        
        return stg;
    }

    private static testMethod void test_batch() {
       
        Test.startTest();
        
        createVerticaliCustomSetting();
        Account acc = accountCreation();
        Asset stdAsset = assetCreation(acc);
        OF_Asset_Verticale__c va1 = assetVerticaleCreation1();
        OF_Billing_Element_Verticale__c bev1 = billingElementVCreation(stdAsset, va1);
        
        BatchSendAssetVerticali batchSend = new BatchSendAssetVerticali();
        
        OF_Asset_Verticale__c va2 = assetVerticaleCreation2();
        OF_Billing_Element_Verticale__c bev2 = billingElementVCreation(stdAsset, va2);
        BatchSendAssetVerticali batchSend2 = new BatchSendAssetVerticali();
        
        DataBase.executeBatch(batchSend2); 
        
        Test.stopTest();
    }
    
    private static testMethod void test_batch2() {
       
        
        
        Test.startTest();
        createVerticaliCustomSetting();
            OF_Staging_PNI__c stg2 = stagingCreation();
    
            DataBase.executeBatch(new OF_PNI_DeleteStaging_Batch());
            Test.stopTest();
     
    }
    
    public static testMethod void BonificaAssetVerticali_schedTestMethod() {
        
        Verticali__c cs = new Verticali__c();
		cs.Name = 'test';
		cs.delayAlgoritmo__c = 1;
		cs.delayBonifica__c = 240;
		cs.Email__c = 'test@test.org';
		cs.Email_CC__c = 'test@test.org';
		cs.Email_from__c = 'Delivery Services Openfiber';
		cs.emailSubject__c = 'subj';
		cs.giorniTolleranza__c = -2;
		cs.limitBatch__c = 10;
		cs.TextBody__c = 'text';

		insert cs;
        
        DateTime jobAlgoritmo = System.now().addMinutes(1);
        String hour = String.valueOf(jobAlgoritmo.hour());
        String min = String.valueOf(jobAlgoritmo.minute()); 
        String ss = String.valueOf(jobAlgoritmo.second());

        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        Test.startTest();
        BatchSendAssetVerticali_sched t2 = new BatchSendAssetVerticali_sched();
        system.schedule('test 02', nextFireTime, t2);
        Test.stopTest();
        
    }
}
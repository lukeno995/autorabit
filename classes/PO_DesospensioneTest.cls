@isTest
Private class PO_DesospensioneTest {
 static testmethod void DesospensioneTest()
 {
     
     Schema.DescribeSObjectResult accSchema = Schema.SObjectType.ASSET; 
        Map<String,Schema.RecordTypeInfo> AssetRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
      
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= testAccount.id;
        insert cont;
    
     User U1 = [select id from USer limit 1];
    
    
    Asset  a = new Asset();
    a.Name = 'test';
   // a.RecordTypeId =rId1;
    a.Accountid = testAccount.id;
    a.contactid = cont.id;
    a.status = 'Purchased';
    a.OF_DataAttivazione2__c = System.today();
    a.OF_Rinnovabile__c = false;
    a.OF_DataScadenza__c = System.today()+3;
   
    Asset  a1 = new Asset();  
    a1.Name = 'test1';
  //  a1.RecordTypeId =rId1;
    a1.Accountid = testAccount.id;
    a1.contactid = cont.id;
    a1.status = 'Purchased';
    a1.OF_DataAttivazione2__c = System.today();
    a1.OF_Rinnovabile__c = false;
    a1.OF_DataScadenza__c = System.today()+3;
    
    List<Asset> assList = new List<Asset>();
    assList.add(a);
    assList.add(a1);
    insert assList;
    string assetid = assList[0].id;
    OF_CommercialElementIstanziato__c ofc = new OF_CommercialElementIstanziato__c();
    ofc.OF_Asset__c = assList[1].id;
    ofc.OF_DataSospensione__c = system.today();
    ofc.OF_Stato__c = 'Attivo';
    insert ofc;
    
    Task task1= new task();
    task1.OwnerId = u1.Id;
    task1.Subject='Message Sent';
    task1.status='Completed';
    task1.Priority = 'Low';
    task1.Description = 'Test';
    task1.ReminderDateTime = system.now();
    task1.Data_Appuntamento__c = system.today();
    task1.WhatId = assList[0].Id;
   // task1.RecordTypeId = rId2 ;
    insert task1;
    
    Product2 p = new product2(name='x');
    insert p;
    
    
    Pricebook2 pb = new pricebook2(name='test');
    insert pb;
    
     Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = p.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice; 
    
    
    PricebookEntry pbe = new PricebookEntry(pricebook2id=pb.id, product2id=p.id,unitprice=1.0, isActive=true,OF_Asset__c = assList[0].id );
    insert pbe;
     PO_Desospensione.DesospensioneAssetBECE(assetid);
 }
}
@isTest

public class PO_BatchAssetFattibil_Test{

    //@TestVisible private static void PO_BatchAssetFattibilMethod(){
    public static testmethod void PO_BatchAssetFattibilMethod(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite Fittizio'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        system.RunAs(thisUser){
            Schema.DescribeSObjectResult accSchema = Schema.SObjectType.ASSET; 
            Map<String,Schema.RecordTypeInfo> AssetRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
            Id rId1 = AssetRecordTypeInfo.get('P2P').getRecordTypeId();
            //Id rId2 = AssetRecordTypeInfo.get('PO Fattibilità').getRecordTypeId();
            
            Account testAccount = new Account();
            testAccount.Name='Test Account' ;
            insert testAccount;
            
            Contact cont = new Contact();
            cont.FirstName='Test';
            cont.LastName='Test';
            cont.Accountid= testAccount.id;
            insert cont;
            
            User U = [select id from USer limit 1];
            
            Asset  a = new Asset();
            a.Name = 'test';
            a.RecordTypeId =rId1;
            a.Accountid = testAccount.id;
            a.contactid = cont.id;
            a.status = 'Purchased';
            a.OF_DataAttivazione2__c = System.today();
            a.OF_Rinnovabile__c = false;
            a.OF_DataScadenza__c = System.today();
            //insert a;
            
            Asset  a1 = new Asset();  
            a1.Name = 'test1';
            a1.RecordTypeId =rId1;
            a1.Accountid = testAccount.id;
            a1.contactid = cont.id;
            a1.status = 'Purchased';
            a1.OF_DataAttivazione2__c = System.today();
            a1.OF_Rinnovabile__c = false;
            a1.OF_DataScadenza__c = System.today();
            
            List<Asset> assList = new List<Asset>();
            assList.add(a);
            assList.add(a1);
            insert assList;
            
            OF_CommercialElementIstanziato__c ofc = new OF_CommercialElementIstanziato__c();
            ofc.OF_Asset__c = assList[1].id;
            ofc.OF_DataSospensione__c = system.today();
            ofc.OF_Stato__c = 'Attivo';
            insert ofc;
            
            List<Task> taskList =New List<Task>();
            for(Integer i=0;i<2;i++){
                Task task= new task();
                task.OwnerId = u.Id;
                task.Subject='Message Sent';
                task.status='Completed';
                task.Priority = 'Low';
                task.Description = 'Test';
                task.ReminderDateTime = system.now();
                task.Data_Appuntamento__c = system.today();
                task.WhatId = assList[0].Id;
                taskList.add(task);
            }
            //task.RecordTypeId=rId1;
            //task.WhoId =assList[0].Id;
            //task.RecordTypeId = rId2 ;
            insert taskList;
            
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
            //Pricebook2 stdPb = [select Id from Pricebook2 where isStandard=true limit 1];
            //insert new PricebookEntry(pricebook2id = stdPb.id, product2id = p.id,unitprice=1.0, isActive=true);
            
            PricebookEntry pbe = new PricebookEntry(pricebook2id=pb.id, product2id=p.id,unitprice=1.0, isActive=true,OF_Asset__c = assList[0].id );
            insert pbe;
            system.debug('!!!!!'+pbe);
            PO_BatchAssetFattibil poBatch = new PO_BatchAssetFattibil(1);
            //poBatch.taskToInsert =taskList;
            //poBatch.mapRT.put('test',rId1);
            PO_BatchAssetFattibil poBatch1 = new PO_BatchAssetFattibil(0);
            poBatch1.taskToInsert=taskList;
            DataBase.executebatch(poBatch);
            poBatch.checkAssetToElaborate(assList);
            //poBatch.execute(assList);
        }
    }
    
    public static testmethod void PO_BatchAssetFattibilMethod1(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite Fittizio'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        system.RunAs(thisUser){
            Schema.DescribeSObjectResult accSchema = Schema.SObjectType.ASSET; 
            Map<String,Schema.RecordTypeInfo> AssetRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
            Id rId1 = AssetRecordTypeInfo.get('P2P').getRecordTypeId();
            //Id rId2 = AssetRecordTypeInfo.get('PO Fattibilità').getRecordTypeId();
            
            Account testAccount = new Account();
            testAccount.Name='Test Account' ;
            insert testAccount;
            
            Contact cont = new Contact();
            cont.FirstName='Test';
            cont.LastName='Test';
            cont.Accountid= testAccount.id;
            insert cont;
            
            User U = [select id from USer limit 1];
            
            Asset  a = new Asset();
            a.Name = 'test';
            a.RecordTypeId =rId1;
            a.Accountid = testAccount.id;
            a.contactid = cont.id;
            a.status = 'Purchased';
            a.OF_DataAttivazione2__c = System.today();
            a.OF_Rinnovabile__c = false;
            a.OF_DataScadenza__c = System.today()+3;
            //insert a;
            
            Asset  a1 = new Asset();  
            a1.Name = 'test1';
            a1.RecordTypeId =rId1;
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
            
            OF_CommercialElementIstanziato__c ofc = new OF_CommercialElementIstanziato__c();
            ofc.OF_Asset__c = assList[1].id;
            ofc.OF_DataSospensione__c = system.today();
            ofc.OF_Stato__c = 'Attivo';
            insert ofc;
            
            List<Task> taskList =New List<Task>();
            for(Integer i=0;i<2;i++){
                Task task= new task();
                task.OwnerId = u.Id;
                task.Subject='Message Sent';
                task.status='Completed';
                task.Priority = 'Low';
                task.Description = 'Test';
                task.ReminderDateTime = system.now();
                task.Data_Appuntamento__c = system.today();
                task.WhatId = assList[0].Id;
                taskList.add(task);
            }
            //task.RecordTypeId=rId1;
            //task.WhoId =assList[0].Id;
            //task.RecordTypeId = rId2 ;
            insert taskList;
            
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
            //Pricebook2 stdPb = [select Id from Pricebook2 where isStandard=true limit 1];
            //insert new PricebookEntry(pricebook2id = stdPb.id, product2id = p.id,unitprice=1.0, isActive=true);
            
            PricebookEntry pbe = new PricebookEntry(pricebook2id=pb.id, product2id=p.id,unitprice=1.0, isActive=true,OF_Asset__c = assList[0].id );
            insert pbe;
            system.debug('!!!!!'+pbe);
            PO_BatchAssetFattibil poBatch = new PO_BatchAssetFattibil(1);
            //poBatch.taskToInsert =taskList;
            //poBatch.mapRT.put('test',rId1);
            PO_BatchAssetFattibil poBatch1 = new PO_BatchAssetFattibil(0);
            poBatch1.taskToInsert=taskList;
            DataBase.executebatch(poBatch);
            poBatch.checkAssetToElaborate(assList);
            //poBatch.execute(assList);
        }
    }
    
   /* public static testmethod void PO_BatchAssetFattibilMethodNumberDaysDueThree(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite Fittizio'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser;
        
        system.RunAs(thisUser){
            Schema.DescribeSObjectResult accSchema = Schema.SObjectType.ASSET; 
            Map<String,Schema.RecordTypeInfo> AssetRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
            Id rId1 = AssetRecordTypeInfo.get('P2P').getRecordTypeId();
            
            Account testAccount = new Account();
            testAccount.Name='Test Account' ;
            insert testAccount;
            
            Contact cont = new Contact();
            cont.FirstName='Test';
            cont.LastName='Test';
            cont.Accountid= testAccount.id;
            insert cont;
            
            User U = [select id from USer limit 1];
            
            Asset  a = new Asset();
            a.Name = 'test';
            a.RecordTypeId =rId1;
            a.Accountid = testAccount.id;
            a.contactid = cont.id;
            a.status = 'Purchased';
            a.OF_DataAttivazione2__c = System.today();
            a.OF_Rinnovabile__c = false;
            a.OF_DataScadenza__c = System.today() + 4;
            
            Asset  a1 = new Asset();  
            a1.Name = 'test1';
            a1.RecordTypeId =rId1;
            a1.Accountid = testAccount.id;
            a1.contactid = cont.id;
            a1.status = 'Purchased';
            a1.OF_DataAttivazione2__c = System.today();
            a1.OF_Rinnovabile__c = false;
            a1.OF_DataScadenza__c = System.today() + 4;
            
            List<Asset> assList = new List<Asset>();
            assList.add(a);
            assList.add(a1);
            insert assList;
            
            OF_CommercialElementIstanziato__c ofc = new OF_CommercialElementIstanziato__c();
            ofc.OF_Asset__c = assList[1].id;
            ofc.OF_DataSospensione__c = system.today();
            ofc.OF_Stato__c = 'Attivo';
            insert ofc;
            
            List<Task> taskList =New List<Task>();
            for(Integer i=0;i<2;i++){
                Task task= new task();
                task.OwnerId = u.Id;
                task.Subject='Message Sent';
                
                if(i == 0){
                    task.status='Completed';
                }
                else{
                    task.status='Not Started';
                }
                task.Priority = 'Low';
                task.Description = 'Test';
                task.ReminderDateTime = system.now();
                task.Data_Appuntamento__c = system.today();
                task.WhatId = assList[0].Id;
                taskList.add(task);
            }
            
            insert taskList;
            
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
            
            PO_BatchAssetFattibil poBatch = new PO_BatchAssetFattibil(1);
            PO_BatchAssetFattibil poBatch1 = new PO_BatchAssetFattibil(0);
            //DataBase.executebatch(poBatch);
            DataBase.executebatch(poBatch);
        }
    }*/
}
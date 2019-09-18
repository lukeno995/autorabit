@isTest
public class PO_TP_ExportListaLineeAtt_Ctrl_Test{
   /* public static testMethod void ExportListaLineeAttMethod(){
        Account acc = new Account();
        acc.name= 'Test';
        //acc.ownerId = u.Id;
        insert acc;
        
         Contact con = new Contact();
        con.LastName= 'Test';
        con.AccountId = acc.Id;
        insert con;
       Profile p = [select id from profile where name='Partner Community Super User'];
        // UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'Vodafone Partner User');
        //insert r;
       
        //Vodafone Partner User
        User u = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',ContactId = con.Id,
            localesidkey='en_US', profileid = p.Id, country='United States',
            
            timezonesidkey='America/Los_Angeles', username='test123000@noemail.com');
        insert u;
       
            
        
        List<Asset> assList = new list<Asset>();
        Asset a1 = new Asset();
        a1.Status = 'Attivo';
        a1.Name = 'Canone';
        a1.EOF_ID_Risorsa__c = 'risorsa';
        a1.AccountID = acc.Id;
        a1.OF_DataAttivazione2__c=Date.newInstance(2018,2,1);
        a1.OF_DataCessazione2__c=Date.newInstance(2018,12,1);
        a1.OF_ProfiloOpenStream__c='op1';
        a1.ContactId = con.Id;
        a1.OwnerId = u.Id;
        assList.add(a1);
        
        Asset a2 = new Asset();
        a2.Status = 'Attivo';
        a2.Name = 'Canone';
        a2.EOF_ID_Risorsa__c = 'risorsa';
        a2.AccountID = acc.Id;
        a2.OF_DataAttivazione2__c=Date.newInstance(2018,2,1);
        a2.OF_DataCessazione2__c=Date.newInstance(2018,12,1);
        a2.OF_ProfiloOpenStream__c='op1';
        a2.ContactId = con.Id;
        a2.OwnerId = u.Id;  
        assList.add(a2);
        
        //insert assList;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        
        pricebook2 priceB = new Pricebook2(
        Name='Canone', isActive=true
        );
        insert priceB;
        
        List<pricebookentry> pbeList = new list<pricebookentry>();
        pricebookentry pbeStd = new pricebookentry(
        Product2Id = prod.id,
        Pricebook2Id = pricebookId,
        isActive = true,
        unitprice = -9999
        
        );
        pbeList.add(pbeStd);
        
        pricebookentry pbe = new pricebookentry(
        Product2Id = prod.id,
        Pricebook2Id = priceB.Id,
        isActive = true,
        UnitPrice = -9999,
        OF_Asset__c = a1.Id,OF_DataCessazione2__c = system.today()
        
        );
        pbeList.add(pbe);
        
       // insert pbeList;
        system.runAs(u)
        {
            

        PO_TP_ExportListaLineeAtt_Ctrl.AssetWrapper innerobj= new  PO_TP_ExportListaLineeAtt_Ctrl.AssetWrapper();
        PO_TP_ExportListaLineeAtt_Ctrl  exp = new PO_TP_ExportListaLineeAtt_Ctrl();
        exp.populateWrapper(assList, pbeList);
        
        
        
        System.currentPagereference().getParameters().put('DataInizio','201811');
        System.currentPagereference().getParameters().put('DataFine','2018121');
        System.currentPagereference().getParameters().put('IDRisorsa','risorsa');
        System.currentPagereference().getParameters().put('Profilo','op1');
        System.currentPagereference().getParameters().put('statusJSON','null');
        System.currentPagereference().getParameters().put('Listino','Test');
        exp.fetchList();
        
       
        }
        
    }*/
     public static testMethod void ListaLineeAttiveMethod(){
    
        Id RecordTypeIdass = Schema.SObjectType.asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.LastName= 'Test';
        con.AccountId = acc.Id;
        insert con;
        
        Profile p = [select id from profile where name='Partner Community Super User'];

        User u = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US', profileid = p.Id, country='United States',
            ContactId = con.Id,
            timezonesidkey='America/Los_Angeles', username='test1230@noemail.com');
        insert u;
       
       System.runas(u){
       List<Asset> assList = new List<Asset>();
        Asset a1 = new Asset();
        a1.Status = 'Attivo';
        a1.Name = 'Canone';
        a1.EOF_ID_Risorsa__c = 'Canone';
        a1.AccountID = acc.Id;
        a1.ContactId = con.Id;
      // a1.OF_DataAttivazione2__c=system.now();
      //  a1.OF_DataCessazione2__c=system.now();
        a1.RecordTypeId = RecordTypeIdass;
        assList.add(a1);
        
        
        insert assList;
        
        System.debug('assList'+assList);
        
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        
         Id pricebookId = Test.getStandardPricebookId();
    
        pricebook2 priceB = new Pricebook2(
          Name='Canone', isActive=true
        );
        insert priceB;
        
        pricebookentry pbeStd = new pricebookentry(
          Product2Id = prod.id,
            Pricebook2Id = pricebookId,
            isActive = true,
            unitprice = -9999
        );
        insert pbeStd;
        
        List<pricebookentry> pbeList = new List<pricebookentry>();
        pricebookentry pbe = new pricebookentry(
            Product2Id = prod.id,
            Pricebook2Id = priceB.Id,
            isActive = true,
            UnitPrice = -9999,
            OF_Asset__c = assList[0].Id,OF_DataCessazione2__c = system.today()
            
        );
        pbeList.add(pbe);
        insert pbeList;
        System.debug('pbeList'+pbeList);
        
        PO_TP_ExportListaLineeAtt_Ctrl.AssetWrapper innerobj= new  PO_TP_ExportListaLineeAtt_Ctrl.AssetWrapper();
        PO_TP_ExportListaLineeAtt_Ctrl  exp = new PO_TP_ExportListaLineeAtt_Ctrl();
        exp.populateWrapper(assList, pbeList);
        
        
        
       /* System.currentPagereference().getParameters().put('DataInizio','201811');
        System.currentPagereference().getParameters().put('DataFine','2018121');
        System.currentPagereference().getParameters().put('IDRisorsa','risorsa');
        System.currentPagereference().getParameters().put('Profilo','op1');
        System.currentPagereference().getParameters().put('statusJSON','null');
        System.currentPagereference().getParameters().put('Listino','Test');*/
        exp.fetchList();
        
     }
        
      
    }
}
@isTest
public class PO_TP_COMP_ListaLineeAttive_Controller_T{
    
    public static testMethod void ListaLineeAttiveMethod(){
    
        Id RecordTypeIdass = Schema.SObjectType.asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        
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
       // insert r;
        
        //Vodafone Partner User
        User u = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',ContactId = con.Id,
            localesidkey='en_US', profileid = p.Id, country='United States',
            
            timezonesidkey='America/Los_Angeles', username='test1230@noemail.com');
        insert u; 
       //User u= [ select Id from User where Id = :UserInfo.getUserId() ]; 
       
       
        
        
        
        system.runas(u){
        
        
        
        List<Asset> assList = new List<Asset>();
        Asset a1 = new Asset();
        a1.Status = 'Attivo';
        a1.Name = 'Canone';
        a1.EOF_ID_Risorsa__c = 'Canone';
        a1.AccountID = acc.Id;
        a1.ContactId = con.Id;
        a1.OwnerId = u.Id;
       // a1.OF_DataAttivazione2__c  = System.now();
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
        
        
     
        PO_TP_COMP_ListaLineeAttive_Controller  lis = new PO_TP_COMP_ListaLineeAttive_Controller();
        
        lis.titolare= 'Test';
        lis.checkMessage= True;
        lis.message= 'Test';
        lis.IdScelta = 'Test';
       // lis.DataInizio = '20180625022353';
       // lis.Listino = 'Test';
       // lis.soql = 'Test';
       // lis.statusJSON = '{"Response"}';

        lis.ViewDetail();
        //lis.preparePage();
        //lis.setPagination(true);
       //String myObj = 
        //lis.statusJSON = '{ "name":"John" }';
        
        
        lis.pageDown();
        lis.pageUp();
        lis.runSearch();
       
        lis.populateWrapper(assList,pbeList);
        lis.preparePage();
        lis.checkMessage= false;
        lis.pageUp();
        }
      
    }
     
}
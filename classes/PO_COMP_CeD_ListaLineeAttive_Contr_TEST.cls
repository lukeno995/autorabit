@isTest
public class PO_COMP_CeD_ListaLineeAttive_Contr_TEST{

    public static testMethod void test1(){
    
        Id RecordTypeIdass = Schema.SObjectType.asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        
        Profile prf = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt11', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = prf.Id,UserRoleID = Usr.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'PFProduction@test.com',isactive = true);
        insert thisUser ;
        
        System.RunAs(thisUser)
        {
            // Inserting test Account
            Account acc = new Account();
            acc.name = 'test';
            insert acc;
            
            // Inserting test contact
            contact con = new contact();
            con.FirstName = 'testName';
            con.lastname = 'Last';
            con.Email = 'email@abc.com';
            con.PO_Contatto_telefonico__c ='1234';
            con.PO_N_Licenza__c = 'test';
            con.PO_Struttura_di_appartenenza__c = 'test';
            con.AccountId = acc.Id;
            insert con;
            
            Profile prof = [SELECT Id FROM Profile WHERE Name='Partner Community Super User'];
            
            // Inserting test user 
            User u = new User();
            u.Firstname = 'mike12';
            u.LastName = 'Smith12';
            u.email = 'msmithtest25@company.com';
            u.Alias = 'alias12';
            u.CommunityNickname = 'commnick';
            u.EmailEncodingKey = 'UTF-8';
            u.Username = 'msmithtest25@company.com';
            u.TimeZoneSidKey = 'America/Denver';
            u.LocaleSidKey = 'en_US';
            u.EmailEncodingKey = 'UTF-8';
            u.LanguageLocaleKey = 'en_US';
            u.ProfileId = prof.Id;
            u.ContactId = con.id;
            insert u;
            
            //Updating  Test contact owner with Test user 
            con.ownerid = u.id;
            update con;
            
            System.runAs(u)
            {
                List<Asset> assList = new List<Asset>();
                Asset a1 = new Asset();
                a1.Status = 'Attivo';
                a1.Name = 'Canone';
                a1.EOF_ID_Risorsa__c = 'Canone';
                a1.AccountID = acc.Id;
                a1.ContactId = con.Id;
                a1.OwnerId = u.Id;
                //a1.OF_DataAttivazione2__c  = System.now();
                a1.RecordTypeId = RecordTypeIdass;
                assList.add(a1);
                
                Asset a2 = new Asset();
                a2.Status = 'Attivo';
                a2.Name = 'Canone2';
                a2.EOF_ID_Risorsa__c = 'Canone2';
                a2.AccountID = acc.Id;
                a2.ContactId = con.Id;
                a2.OwnerId = u.Id;
                // a1.OF_DataAttivazione2__c  = System.now();
                a2.RecordTypeId = RecordTypeIdass;
                assList.add(a2);
                
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
                
                PO_COMP_CeD_ListaLineeAttive_Controller lis = new PO_COMP_CeD_ListaLineeAttive_Controller();
                
                lis.titolare= 'Test';
                lis.checkMessage = True;
                lis.message= 'Test';
                lis.IdScelta = 'Test';
                lis.Listino = 'Test';
                lis.soql = 'Test';
                lis.statusJSON = '["Attivo"]';
                lis.IDRisorsa = 'Canone';
                lis.Profilo = 'Profilo';

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
}
@isTest
public class PO_EditContactControllerTest
{
    public static testmethod void PO_EditContactTestMethod() 
    {
        
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
            Account a = new Account();
            a.name = 'test';
            insert a;
            
            // Inserting test contact
            contact con = new contact();
            con.FirstName = 'testName';
            con.lastname = 'Last';
            con.Email = 'email@abc.com';
            con.PO_Contatto_telefonico__c ='1234';
            con.PO_N_Licenza__c = 'test';
            con.PO_Struttura_di_appartenenza__c = 'test';
            con.AccountId = a.Id;
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
                contact con1 = new contact();
                con1 = [Select FirstName,LastName, Email,PO_Contatto_telefonico__c,PO_N_Licenza__c,PO_Struttura_di_appartenenza__c
                        From Contact
                        Where Id =:con.id];
                
                PageReference pref = Page.PO_Index;
                Test.setCurrentPage(pref);
                ApexPages.currentPage().getParameters().put('Id', con.Id);
                
                Test.startTest();
                PO_EditContactController mycon = new PO_EditContactController();
                account accTest = mycon.userAcc;
                mycon.saveIt(); 
                mycon.cancelIt();
                Test.stopTest();
            }
        }
    }
}
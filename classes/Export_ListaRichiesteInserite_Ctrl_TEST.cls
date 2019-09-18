@isTest
public class Export_ListaRichiesteInserite_Ctrl_TEST{

    static testmethod void test_exportProv()
    {
        Profile prf = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt11', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = prf.Id,UserRoleID = Usr.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'PFProduction@test.com',isactive = true);
        insert thisUser;
        
        System.RunAs(thisUser)
        {
            //--------------EAI Log creation--------------
            String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_CO_FiberRequest').getRecordTypeId();
            EOF_EAI_Service_Log__c eaiLog = new EOF_EAI_Service_Log__c();
            //eaiLog.Caso__c  = c.Id;
            eaiLog.EOF_ID_Notifica__c = 'TEST_01';
            eaiLog.EOF_Codice_Ordine_OLO__c = 'TEST_ATT_001';
            eaiLog.EOF_Codice_Operatore__c = 'VF';
            eaiLog.EOF_Data_Notifica__c = System.today() - 50;
            eaiLog.EOF_STATO_ORDINE__c = 'Inviato';
            eaiLog.EOF_ID_Pop__c = '';
            eaiLog.PO_SA_Data_Inserimento_Ordine__c = System.today() - 50;
            eaiLog.EOF_Tipo_Comunicazione_String__c = 'Change Order';
            eaiLog.recordTypeId = eaiRecordType;
            eaiLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
            insert eaiLog;
            
            // Inserting test Account
            Account a = new Account();
            a.name = 'Vodafone';
            a.EOF_Codice_Operatore__c = 'VF';
            insert a;
            
            // Inserting test contact
            contact con = new contact();
            con.FirstName = 'Vlado';
            con.lastname = 'Test';
            con.Email = 'email@abc.com';
            con.PO_Contatto_telefonico__c ='1234';
            con.PO_N_Licenza__c = 'test';
            con.PO_Struttura_di_appartenenza__c = 'test';
            con.AccountId = a.Id;
            con.PO_Super_User__c = true;
            insert con;
            
            Profile prof = [SELECT Id FROM Profile WHERE Name='Partner Community Super User'];
            
            // Inserting test user 
            User portal_user = new User();
            portal_user.Firstname = 'John';
            portal_user.LastName = 'Smith';
            portal_user.email = 'msmithtest25@company.com';
            portal_user.Alias = 'alias12';
            portal_user.CommunityNickname = 'commnick';
            portal_user.EmailEncodingKey = 'UTF-8';
            portal_user.Username = 'msmithtest25@company.com';
            portal_user.TimeZoneSidKey = 'America/Denver';
            portal_user.LocaleSidKey = 'en_US';
            portal_user.EmailEncodingKey = 'UTF-8';
            portal_user.LanguageLocaleKey = 'en_US';
            portal_user.ProfileId = prof.Id;
            portal_user.ContactId = con.id;
            insert portal_user;
            
            //Updating  Test contact owner with Test user 
            con.ownerid = portal_user.id;
            update con;
            
            System.runAs(portal_user)
            {              
                Test.startTest();
                Export_ListaRichiesteInserite_Ctrl contr = new Export_ListaRichiesteInserite_Ctrl();
                PageReference pageRef1 = page.Export_ListaRichiesteInserite;               
                pageRef1.getParameters().put('DataInizioCreazione','2018-04-03T00:00:00 02:00');
                pageRef1.getParameters().put('DataFineNotifica','2018-06-08T00:00:00 02:00');
                pageRef1.getParameters().put('DataFineCreazione','2018-04-15T00:00:00 02:00');
                pageRef1.getParameters().put('valPOP','["MI/FCO/2"]');
                pageRef1.getParameters().put('valCodOrdOLO','["TEST_ATT_001"]');
                pageRef1.getParameters().put('valIDRisorsa','["ASSET_001"]');
                pageRef1.getParameters().put('ListTipo','["Change Order","Attivazione"]');
                pageRef1.getParameters().put('ListStatus','["Inviato","Espletato","Acquisito"]');
                Test.setCurrentPageReference(pageRef1); 
                contr.fetchList();
                Test.stopTest();    
            }    
        }
    }
}
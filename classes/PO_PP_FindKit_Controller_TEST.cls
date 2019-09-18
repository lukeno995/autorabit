@isTest
public class PO_PP_FindKit_Controller_TEST {

    public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        return catalogo;
    }
    
    public static EOF_EAI_Service_Log__c kitLogCreation()
    {
        EOF_EAI_Service_Log__c kitLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - KIT - ActivationRequest').getRecordTypeId();
        kitlog.Nome_del_KIT__c = 'TEST_K';
        kitlog.recordTypeId = rtId;
        insert kitLog;
        return kitLog;
    }
    
    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'KIT';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
    public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO KIT';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    }  
    
    public static Asset assetCreation(Account acc){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Preprovisioning').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'Test Asset PP';
        asset_1.Status = 'Attivo';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.AccountId = acc.id;
        insert asset_1;
        return asset_1;
    }
    
    public static Account accountCreation()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'TISCALI';
        acc.EOF_Codice_Operatore__c = 'TIS';
        acc.RecordTypeId = AccountRecordTypeId;
        insert acc;
        
        return acc;
    }

    public static testmethod void test_method1()
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
            // account creation
            String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
            account acc = new account();
            acc.name ='test';
            acc.EOF_Codice_Operatore__c= 'TIS';
            acc.Type = 'OLO';
            acc.industry = 'Telecommunications';
            acc.RecordTypeID = oloAccountRecordTypeId;
            
            insert acc;
            // end account creation
            
            // business account creation        
            String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
            Account bus = new Account();
            bus.name = 'Test';
            bus.RecordTypeId = busAccountRecordTypeId;
            insert bus;
            // end business account creation
            
            // case creation
            String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
            case c = new case();
            c.RecordTypeId = CaseRecordTypeId;
            c.EOF_Account_OLO__c = acc.id;
            c.EOF_Codice_Ordine_OLO__c = 'Tiscali';
            c.EOF_Contact__c = null;
            c.status = 'Accettato';
            c.EOF_FASE__C = 'NA';
            c.EOF_Data_Notifica__c= system.now();
            insert c;
            // end case creation
            
            //service log creation 
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
            sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
            sl.EOF_Codice_Ordine_OLO__c = 'Tiscali';
            sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
            sl.EOF_ID_Notifica__c ='';
            sl.EOF_STATO_ORDINE__c ='Accettato';
            insert sl;
            
            EOF_EAI_Service_Log__c logK = kitLogCreation();
            PO_KIT_AttInserita_Controller.slOrig = sl;
            // end service log creation
            
            EOF_EAI_Service_Log__c sl_error = new EOF_EAI_Service_Log__c();
            sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
            sl.EOF_Codice_Ordine_OLO__c = 'Tiscali';
            sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
            sl.EOF_ID_Notifica__c ='';
            sl.EOF_STATO_Ordine__c='';
            insert sl_error;
            
            Account acc1 = AccountCreation();
            
            Contact con = new Contact();
            con.AccountId = acc1.Id;
            con.LastName = 'Test';
            insert con;
            
            Asset asset_test = assetCreation(acc1);
            
            asset_test.contactId = con.id;
            update asset_test;
            
            OF_CatalogoCommerciale__c cat = Catalogo_Creation();
            OF_Servizio__c serv = Servizio_Creation(cat);
            OF_CommercialElement__c ce_test = CE_Creation(serv);
            
            OF_CommercialElementIstanziato__c kit = new OF_CommercialElementIstanziato__c();
            kit.PO_PP_Nome_KIT__c = 'TEST_KIT_001';
            kit.OF_CommercialElement__c = ce_test.id;
            kit.OF_Asset__c = asset_test.id;
            insert kit;
            
            // Inserting test Account
            Account a = new Account();
            a.name = 'Tiscali';
            a.EOF_Codice_Operatore__c = 'TIS';
            insert a;
            
            // Inserting test contact
            contact contatto = new contact();
            contatto.FirstName = 'Vlado';
            contatto.lastname = 'Test';
            contatto.Email = 'email@abc.com';
            contatto.PO_Contatto_telefonico__c ='1234';
            contatto.PO_N_Licenza__c = 'test';
            contatto.PO_Struttura_di_appartenenza__c = 'test';
            contatto.AccountId = a.Id;
            contatto.PO_Super_User__c = true;
            insert contatto;
            
            Profile prof = [SELECT Id 
                            FROM Profile 
                            WHERE Name='Partner Community Super User'];
            
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
            contatto.ownerid = portal_user.id;
            update contatto;
            
            Test.StartTest();
            PO_PP_FindKit_Controller contr = new PO_PP_FindKit_Controller();
            contr.codOp = 'Tiscali';
            contr.nameKit = 'TEST_KIT_001';
            
            System.runAs(portal_user)
            {
                contr.passSelectValueToController();
                PageReference pageRef = contr.runSearchKit();
            }
            Test.StopTest();
        }
    }   
}
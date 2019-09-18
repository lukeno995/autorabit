@isTest
private class PO_RiepilogoKITnew_Cntrl_TEST {
    
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

    public static Account tiscaliAccountCreation()
    {
        Account a = new Account();
        a.name = 'Tiscali';
        a.EOF_Codice_Operatore__c = 'TIS';
        insert a;
        return a;
    }
    
    public static EOF_EAI_Service_Log__c kitLogCreation()
    {
        EOF_EAI_Service_Log__c kitLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - KIT - ActivationRequest').getRecordTypeId();
        kitlog.Nome_del_KIT__c = 'TEST_K';
        kitlog.EOF_Codice_Operatore__c = 'TIS';
        kitlog.recordTypeId = rtId;
        kitlog.POP__c = 'pop_01';
        kitlog.Traffico__c = 'VULA Openstream Direct';
        kitlog.Banda_Interfaccia__c = '400';
        kitlog.PO_PP_Interfaccia__c = '1 Giga';
        kitlog.EOF_Stato_Richiesta__c = 'Inserita Portale';
        kitlog.EOF_Tipo_Comunicazione_String__c = 'KIT Consegna';
        kitlog.EOF_STATO_ORDINE__c = 'Espletato';
        insert kitLog;
        return kitLog;
    }


    private static testMethod void test() {
        
         UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        system.debug('portalRole is ' + portalRole);
    
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        User portalAccountOwner1 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test2@test.com',
            Alias = 'batman',
            Email='bruce.wayne@wayneenterprises.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce',
            Lastname='Wayne',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        Database.insert(portalAccountOwner1);
    
        //User u1 = [Select ID From User Where Id =: portalAccountOwner1.Id];
    
        System.runAs (portalAccountOwner1) 
        {
            //Create account
                Account portalAccount1 = new Account(
                Name = 'Tiscali',
                EOF_Codice_Operatore__c = 'TIS',
                OwnerId = portalAccountOwner1.Id
            );
            Database.insert(portalAccount1);
        
            //Create contact
            Contact contact1 = new Contact(
                FirstName = 'Test',
                Lastname = 'McTesty',
                AccountId = portalAccount1.Id,
                Email = System.now().millisecond() + 'test@test.com',
                PO_Servizio_Ticket_Provisioning__c = true
            );
            Database.insert(contact1);
        
            //Create user
            Profile portalProfile = [SELECT Id 
                                    FROM Profile 
                                    WHERE Name='Partner Community User'];
            
            User user1 = new User(
                Username = System.now().millisecond() + 'test12345@test.com',
                ContactId = contact1.Id,
                ProfileId = portalProfile.Id,
                Alias = 'test123',
                Email = 'test12345@test.com',
                EmailEncodingKey = 'UTF-8',
                LastName = 'McTesty',
                CommunityNickname = 'test12345',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US'
            );
            Database.insert(user1);
            
            System.runAs(user1)
            { 
                Account acc = tiscaliAccountCreation();
        
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = 'Test';
                insert con;
                
                Asset asset_test = assetCreation(acc);
                
                asset_test.accountId = acc.id;
                asset_test.contactId = con.id;
                update asset_test;
                
                OF_CatalogoCommerciale__c cat = Catalogo_Creation();
                OF_Servizio__c serv = Servizio_Creation(cat);
                OF_CommercialElement__c ce_test = CE_Creation(serv);
                OF_CommercialElementIstanziato__c kit = new OF_CommercialElementIstanziato__c();
                kit.PO_PP_Nome_KIT__c = 'TEST_K';
                kit.PO_PP_Pop__c = 'pop_01';
                kit.PO_PP_Servizio_Commerciale__c = 'VULA Openstream Direct';
                kit.PO_PP_Banda_Interfaccia__c = '400';
                kit.PO_PP_InterfacciaKit__c = '1 Giga';
                kit.OF_CommercialElement__c = ce_test.id;
                kit.OF_Asset__c = asset_test.id;
                insert kit;
                
                EOF_EAI_Service_Log__c kLog = kitLogCreation();
        
                Test.startTest();
                
                System.currentPageReference().getParameters().put('ceiId', kit.id);
                System.currentPageReference().getParameters().put('NomeKit', 'TEST_K');
                PO_RiepilogoKITnew_Cntrl contr = new PO_RiepilogoKITnew_Cntrl();
                contr.insertVLAN();
                
                Test.stopTest();
            }
        }
    }
}
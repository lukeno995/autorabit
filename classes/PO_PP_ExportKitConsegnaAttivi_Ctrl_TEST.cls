@isTest
public class PO_PP_ExportKitConsegnaAttivi_Ctrl_TEST{

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
    
	public static Asset assetCreation(Account acc)
	{
		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Preprovisioning').getRecordTypeId();
		Asset asset_1 = new Asset();
		asset_1.Name = 'Test Asset PP';
		asset_1.EOF_ID_Risorsa__c = 'Test Asset PP';
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
    
    public static Case caseCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_POP__c = 'pop_01';
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.PO_PP_Traffico__c = 'VULA Openstream Direct';
        c.PO_PP_Banda__c = '400';
        c.PO_PP_Interfaccia_Kit__c = '1 Giga';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }

    static testmethod void test_exportPreProv()
    {
    	UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
    	system.debug('portalRole is ' + portalRole);
    
    	Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
    	
    	User portalAccountOwner1 = new User(
    		UserRoleId = portalRole.Id,
    		ProfileId = profile1.Id,
    		Username = System.now().millisecond() + 'test2@test.com',
    		Alias = 'superman',
    		Email='clark.kent@acme.com',
    		EmailEncodingKey='UTF-8',
    		Firstname='clark',
    		Lastname='Kent',
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
                Case caso = caseCreation(acc);
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
                kit.OF_DataAttivazione__c = system.today()-5;
                kit.OF_CommercialElement__c = ce_test.id;
                kit.OF_Asset__c = asset_test.id;
                kit.OF_Case__c = caso.id;
                insert kit;

                Test.startTest();
    			PO_PP_ExportKitConsegnaAttivi_Controller contr = new PO_PP_ExportKitConsegnaAttivi_Controller();
    		    
    		    PageReference pageRef1 = page.PO_PP_ExportKitConsegnaAttivi_Page;              
    	        pageRef1.getParameters().put('nomeKit','TEST_K');
    	        pageRef1.getParameters().put('idRisorsa','Test Asset PP');
    	        //pageRef1.getParameters().put('stato','Accettato');
    	        pageRef1.getParameters().put('banda','400');
    	        pageRef1.getParameters().put('DataInizio','2018-06-08T00:00:00 02:00');
    	        pageRef1.getParameters().put('servizioCommerciale','["VULA Openstream Direct"]');
    	        pageRef1.getParameters().put('pop','pop_01');
    	        
    	        Test.setCurrentPageReference(pageRef1);
    
        		contr.fetchList();
                Test.stopTest();       
            }
        }        
    }
}
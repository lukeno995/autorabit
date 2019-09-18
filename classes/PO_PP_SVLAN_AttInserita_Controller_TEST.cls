@isTest
public class PO_PP_SVLAN_AttInserita_Controller_TEST {
    
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
        kitlog.recordTypeId = rtId;
        insert kitLog;
        return kitLog;
    }
    
    public static EOF_EAI_Service_Log__c richiestaLogCreation(EOF_EAI_Service_Log__c kLog)
    {
        EOF_EAI_Service_Log__c richiestaLog = new EOF_EAI_Service_Log__c();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF RichiestaVLAN').getRecordTypeId();
        richiestaLog.OF_PP_KIT_Log__c = kLog.id;
        richiestaLog.recordTypeId = rtId;
        richiestaLog.EOF_Codice_Operatore__c = 'TIS';
        richiestaLog.EOF_Tipo_Comunicazione_String__c = 'Richiesta VLAN';
        insert richiestaLog;
        return richiestaLog;
    }
    
    public static EOF_EAI_Service_Log__c vlanLogCreation(EOF_EAI_Service_Log__c richiestaLog)
    {
        EOF_EAI_Service_Log__c vlanLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - PP - VLAN').getRecordTypeId();
        vlanLog.recordTypeId = rtId;
        vlanLog.PO_PP_POP_raccolta__c = 'pop_001';
        vlanLog.PO_PP_cos_type__c = 'MultiCOS';
        vlanLog.PO_PP_cos_class__c = '0 - 1 - 5';
        vlanLog.PO_PP_MultiCos_Class__c = '0 - 1 - 5';
        vlanLog.SVLAN__c = 'AX1';
        vlanLog.PO_PP_cos_remarking__c = 'None';
        vlanLog.PO_PP_dhcp_Option82__c = 'None';
        vlanLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
        vlanLog.PO_PP_ID_RichiestaVLAN__c = richiestaLog.id;
        insert vlanLog;
        return vlanLog;
    }
    
    public static EOF_EAI_Service_Log__c vlanLogCreation2(EOF_EAI_Service_Log__c richiestaLog)
    {
        EOF_EAI_Service_Log__c vlanLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - PP - VLAN').getRecordTypeId();
        vlanLog.recordTypeId = rtId;
        vlanLog.PO_PP_POP_raccolta__c = 'pop_001';
        vlanLog.PO_PP_cos_type__c = 'MonoCOS';
        vlanLog.PO_PP_cos_class__c = '0';
        vlanLog.SVLAN__c = 'vlan_002';
        vlanLog.PO_PP_cos_remarking__c = 'SI';
        vlanLog.PO_PP_dhcp_Option82__c = 'None';
        vlanLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
        vlanLog.PO_PP_ID_RichiestaVLAN__c = richiestaLog.id;
        insert vlanLog;
        return vlanLog;
    }
    
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

    public static Case caseCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }
    
    public static testmethod void test_method1()
    {   
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
        		Email = System.now().millisecond() + 'test@test.com'
        	);
        	Database.insert(contact1);
        
        	//Create user
        	Profile portalProfile = [SELECT Id FROM Profile WHERE Name='Partner Community User'];
        	
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
                EOF_EAI_Service_Log__c logK = kitLogCreation();
                EOF_EAI_Service_Log__c richiestaVLAN = richiestaLogCreation(logK);
                EOF_EAI_Service_Log__c logV = vlanLogCreation(richiestaVLAN);
                EOF_EAI_Service_Log__c logV2 = vlanLogCreation2(richiestaVLAN);
                
                Account acc = tiscaliAccountCreation();
                Case caso = caseCreation(acc);
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = 'Test';
                insert con;
                
                Asset asset_test = assetCreation(acc);
                
                asset_test.contactId = con.id;
                update asset_test;
                OF_CatalogoCommerciale__c cat = Catalogo_Creation();
                OF_Servizio__c serv = Servizio_Creation(cat);
                OF_CommercialElement__c ce_test = CE_Creation(serv);
                
                OF_CommercialElementIstanziato__c kit = new OF_CommercialElementIstanziato__c();
                kit.PO_PP_Nome_KIT__c = 'TEST_K';
                kit.OF_CommercialElement__c = ce_test.id;
                kit.OF_Asset__c = asset_test.id;
                kit.OF_Case__c = caso.id;
                insert kit;

                ApexPages.currentPage().getParameters().put('nameKit','TEST_K');
                ApexPages.currentPage().getParameters().put('idVLAN',logV.id);
                ApexPages.currentPage().getParameters().put('proc','editVLAN');
                ApexPages.currentPage().getParameters().put('id_richVLAN',richiestaVLAN.id);
                ApexPages.currentPage().getParameters().put('show_buttons','false');
                
                Test.startTest();
                
                PO_PP_SVLAN_AttInserita_Controller vlan_contr = new PO_PP_SVLAN_AttInserita_Controller();
                List<SelectOption> listMonoCos = vlan_contr.getItemsMonoCos();
                List<SelectOption> listMultiCos = vlan_contr.getItemsMultiCos();
                PageReference aggiungi = vlan_contr.aggiungiVLAN();
                PageReference editV = vlan_contr.editVLAN();
                //PageReference deleteV = vlan_contr.deleteVLAN();
                PageReference aggiorna = vlan_contr.aggiorna();
                PageReference annullaModifiche = vlan_contr.annullaModifiche();
                PageReference inoltraRequest = vlan_contr.inoltraRequest();
                
                Test.stopTest();
            }
        }
    }
}
@IsTest
public class PO_PP_COMP_ListaRichiesteBozza_Ctrl_TEST{

    public static EOF_EAI_Service_Log__c kitLogCreation()
    {
        EOF_EAI_Service_Log__c kitLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - PP - KIT').getRecordTypeId();
        kitlog.Nome_del_KIT__c = 'TEST_K';
        kitlog.EOF_Codice_Operatore__c = 'TIS';
        kitlog.recordTypeId = rtId;
        kitlog.POP__c = 'pop_01';
        kitlog.Traffico__c = 'VULA Openstream Direct';
        kitlog.Banda_Interfaccia__c = '400';
        kitlog.PO_PP_Interfaccia__c = '1 Giga';
        kitlog.EOF_Stato_Richiesta__c =	'Bozza Portale';
        kitlog.EOF_Tipo_Comunicazione_String__c = 'KIT Consegna';
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
        vlanLog.EOF_Tipo_Comunicazione_String__c = 'VLAn';
        insert vlanLog;
        return vlanLog;
    }
    
    public static testmethod void test1()
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
            
            EOF_EAI_Service_Log__c klog = kitLogCreation();
            EOF_EAI_Service_Log__c richiestaLog = richiestaLogCreation(kLog);
            EOF_EAI_Service_Log__c vlanLog = vlanLogCreation(richiestaLog);
            
            String idLogVlan = [Select id
                                from EOF_EAI_Service_Log__c
                                where id =: vlanLog.id
                                limit 1].id;
            
            System.runAs(user1)
            { 
                test.startTest();

                PO_PP_COMP_ListaRichiesteBozza_Ctrl listaBozzeContr = new PO_PP_COMP_ListaRichiesteBozza_Ctrl();
                listaBozzeContr.setPagination(true);
                PageReference page_up = listaBozzeContr.pageUp();
                PageReference page_down = listaBozzeContr.pageDown();
                listaBozzeContr.preparePage();
                listaBozzeContr.tipoRichiesta = 'KIT Consegna';
                PageReference page_show = listaBozzeContr.vediReq();
                
                PO_PP_COMP_ListaRichiesteBozza_Ctrl listaBozzeContr2 = new PO_PP_COMP_ListaRichiesteBozza_Ctrl();
                listaBozzeContr2.tipoRichiesta = 'VLAN';
                listaBozzeContr2.idBozza = idLogVlan;
                PageReference page_show2 = listaBozzeContr2.vediReq();
                
                test.stopTest();
            } 
        }
    }     
}
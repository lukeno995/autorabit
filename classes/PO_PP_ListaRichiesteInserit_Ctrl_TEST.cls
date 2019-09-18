@IsTest
public class PO_PP_ListaRichiesteInserit_Ctrl_TEST{
    
    static Map<String,String> RecordType()
    { 
        //Record Type case
        List<RecordType> rtypes = [Select Name, Id 
                                    From RecordType where (sObjectType='Case' OR sObjectType='Asset') 
                                    and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
        
        for(RecordType rt: rtypes)
            RecordType.put(rt.Name,rt.Id);
        
        return RecordType;
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
        kitlog.EOF_Stato_Richiesta__c =	'Inserita Portale';
        kitlog.EOF_Tipo_Comunicazione_String__c = 'KIT Consegna';
        insert kitLog;
        return kitLog;
    }
    
    public static testmethod void test1()
    {
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
    	system.debug('portalRole is ' + portalRole);
    
    	Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
    	User portalAccountOwner1 = new User(
    		UserRoleId = portalRole.Id,
    		ProfileId = profile1.Id,
    		Username = System.now().millisecond() + 'test.portaleDEV@test.com',
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
            System.debug('****klog***:'+klog);
            String name = [Select name
                          from EOF_EAI_Service_Log__c
                          where id =:klog.id].name;
                          
            System.debug('@@Name:'+name);
            
            System.runAs(user1)
            { 
                test.startTest();
                List<String> jstr = new List<String>();
                jstr.add('KIT Consegna');
                List<String> jstr1 = new List<String>();
                jstr1.add('Accettato');
                
                Apexpages.currentPage().getParameters().put('DataInizioCreazione','2018-04-03T00:00:00 02:00');
                Apexpages.currentPage().getParameters().put('DataFineCreazione','2018-12-30T00:00:00 02:00');
                Apexpages.currentPage().getParameters().put('selectValueL1',JSON.serialize(jstr) );
                Apexpages.currentPage().getParameters().put('selectValueL2',JSON.serialize(jstr1));
                Apexpages.currentPage().getParameters().put('valCodRichiesta',name);
                PO_PP_ListaRichiesteInserit_Controller listaRicInsContr = new PO_PP_ListaRichiesteInserit_Controller();
                PageReference page_search = listaRicInsContr.runSearch();
                listaRicInsContr.setPagination(true);
                PageReference page_up = listaRicInsContr.pageUp();
                PageReference page_down = listaRicInsContr.pageDown();
                listaRicInsContr.filtered = false;
                listaRicInsContr.preparePage();
                listaRicInsContr.runQuery();
                PO_PP_ListaRichiesteInserit_Controller.optionApex opt = new PO_PP_ListaRichiesteInserit_Controller.optionApex('A','B');
                PO_PP_ListaRichiesteInserit_Controller lista_ric_cont_1 = new PO_PP_ListaRichiesteInserit_Controller();        
                Double x = lista_ric_cont_1.offset;
                listaRicInsContr.tipoRichiesta = 'KIT Consegna';
                PageReference page_show = listaRicInsContr.vediReq();
                PageReference page_show2 = listaRicInsContr.vediDettaglioCodiceKitVlan();
                
                test.stopTest();
            } 
        }
    }     
}
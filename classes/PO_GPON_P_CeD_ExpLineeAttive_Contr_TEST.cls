@isTest
public class PO_GPON_P_CeD_ExpLineeAttive_Contr_TEST{

    public static testMethod void test1(){
    
        Id RecordTypeIdass = Schema.SObjectType.asset.getRecordTypeInfosByName().get('GPON Passiva CD').getRecordTypeId(); 
        
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
        	
        	Account acc = new Account();
            acc.name= 'Test';
            //acc.ownerId = u.Id;
            insert acc;
            
            Contact con = new Contact();
            con.LastName= 'Test';
            con.AccountId = acc.Id;
            insert con;
        
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
    		
		    List<Asset> assList = new List<Asset>();
            Asset a1 = new Asset();
            a1.Status = 'Attivo';
            a1.Name = 'Canone';
            a1.EOF_ID_Risorsa__c = 'Test Asset CD';
            a1.AccountID = acc.Id;
            a1.ContactId = con.Id;
            a1.OwnerId = user1.Id;
            // a1.OF_DataAttivazione2__c  = System.now();
            a1.RecordTypeId = RecordTypeIdass;
            assList.add(a1);
            insert assList;
            
            System.runAs(user1)
            {
                System.debug('assList'+assList);
                Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
                insert prod;
                
                Id pricebookId = Test.getStandardPricebookId();
            
                pricebook2 priceB = new Pricebook2(
                    Name='Canone', 
                    isActive=true
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
                    OF_Asset__c = assList[0].Id,
                    OF_DataCessazione2__c = system.today()
                );
                pbeList.add(pbe);
                insert pbeList;
                
                System.debug('pbeList'+pbeList);
             
                PO_GPON_Passiva_CeD_ExpLineeAttive_Contr lis = new PO_GPON_Passiva_CeD_ExpLineeAttive_Contr();
                //PageReference pageRef1 = page.PO_GPON_Passiva_CeD_ExportLineeAttive; 
    	        System.currentPagereference().getParameters().put('idRisorsa','Test Asset CD');
    	        System.currentPagereference().getParameters().put('statusJSON','["Attivo"]');
    	        System.currentPagereference().getParameters().put('DataInizio','2018-06-08T00:00:00 02:00');
    	        System.currentPagereference().getParameters().put('DataFine','2018-07-08T00:00:00 02:00');
    	        //pageRef1.getParameters().put('Profilo','1');
    	        System.currentPagereference().getParameters().put('Listino','11');
                
                lis.populateWrapper(assList,pbeList);
                lis.fetchList();
            }
        }
    }
}
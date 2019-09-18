@isTest
private class PO_UpdateOppCaseTest {
	static testmethod void OpportunityData(){

        PO_ServFatt_DataFactory.createCustomSettings();
	    List<Account> accounts = new List<Account>();
	    accounts.add(new Account(Name = 'Interactive Ties', Website = 'http://www.interactiveties.com/'));
	    insert accounts; //insert the account list
	    //create some testing contacts
	    List<Contact> contacts = new List<Contact>();
	    contacts.add(new Contact(AccountId = accounts[0].Id, FirstName = 'Tess', LastName = 'Dachshund', email='tess@ities.co')); //new Contact detail
	    contacts.add(new Contact(AccountId = accounts[0].Id, FirstName = 'Grachus', LastName = 'Dachshund', email='grachus@ities.co')); //another new Contact detail
	    insert contacts; //insert the contact list
	    RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
	        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
	    paramFat.Name='Default';
	    paramFat.Fascia1__c=1;
	    insert paramFat;
	   // OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
	   // tibco.OF_Tibco_ID__c='00558000001f743AAA';
	   // tibco.name='Tibco UserID';
	   // insert tibco;

	   // OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
	   // abilitaTrig.name='Status';
	   // abilitaTrig.OF_Enable_Trigger__c=true;
	   // insert abilitaTrig;

	    //create some testing Cases
	    Case cas = new Case(Status ='New', Priority = 'Medium', Origin = 'Email',RecordtypeID=rt.id);
	    insert cas;
	    cas=[select ID,recordType.developerName from case where id=:cas.id];
	    Case cas1 = new Case(Status ='New', Priority = 'Medium',RecordtypeID=rt.id, Origin = 'Email',PO_Drop_FL_1__c=true,PO_Lunghezza_m__c=10,parentid=cas.id, PO_Incluso_nell_offerta__c = true);
	    insert cas1;
	    
	    //create some testing opportunities
	    List<Opportunity> opportunities = new List<Opportunity>();
	    opportunities.add(new Opportunity(AccountId = accounts[0].Id, Amount = 20000, CloseDate = date.today(), Name = 'Test Opportunity', StageName = 'Identified',PO_Richiesta_fattibilit__c=cas.id));
	    opportunities.add(new Opportunity(AccountId = accounts[0].Id, Amount = 10000, CloseDate = date.today(), Name = 'Test Opportunity', StageName = 'Identified',PO_Richiesta_fattibilit__c=cas.id));
	    insert opportunities; //insert the opportunity list

	    List<Opportunity> opportunities1 = new List<Opportunity>();
	    for (Integer count = 0; count < 3; count++) {
	        opportunities1.add(new Opportunity(AccountId = accounts[0].Id, Amount = 20000, CloseDate = date.today(), Name = 'Test Opportunity', StageName = 'Identified',PO_Collegamento__c=cas1.Id,PO_Richiesta_fattibilit__c=null));
	        opportunities1.add(new Opportunity(AccountId = accounts[0].Id, Amount = 10000, CloseDate = date.today(), Name = 'Test Opportunity', StageName = 'Identified', PO_Sconto_canone__c = 0.0, PO_Collegamento__c=cas1.Id,PO_Richiesta_fattibilit__c=null));
	    }
	    
	    insert opportunities1; //insert the opportunity list
	    cas1.PO_Lunghezza_m__c =20;
	    cas1.PO_Incluso_nell_offerta__c =false;
	  //  cas1.RecordtypeID=rt.id;
	     // cas1=[select ID,recordType.developerName from case where id=:cas1.id];


	    //END: perform some setup steps...
	    Test.startTest();
	    update cas1;
	   // update opportunities1;
	   // opportunities1=[select id from opportunity where PO_ParentCase__c=:cas.id and PO_Richiesta_fattibilit__c = null and PO_Collegamento__c != null ];
	    Test.stopTest();

	}
}
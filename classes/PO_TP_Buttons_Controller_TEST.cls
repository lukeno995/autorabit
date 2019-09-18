@isTest
public class PO_TP_Buttons_Controller_TEST{
    
    public static OF_Tibco_userID__c UserTibcoCreation(){
	 
	    OF_Tibco_userID__c tibco_user = new OF_Tibco_userID__c();
	    tibco_user.Name = 'Tibco UserID';
	    tibco_user.OF_Tibco_ID__c = '00558000001f743AAA';   
	    insert tibco_user;
	    return tibco_user;
    }    

    public static testmethod void test_method1()
    {       
    	Profile profilo_soc = [Select id, name
                                from Profile
                                where name = 'TP Soc'];

    	OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();   

        /*
        User user_Soc = new User(Alias = 'SOC', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = profilo_soc.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'soc@test.com',isactive = true);
        insert user_Soc;
        */
        
        Group coda_Soc = [select Id, name 
                          from Group where Type = 'Queue' 
                          and name = 'TT - Coda SOC Ordini in Attivazione'];
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        Case c = new Case();
        c.Subject = 'Segnalazione Provisioning';
        c.Status = 'Acquisito';
        c.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.OwnerId = coda_Soc.id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Portal';
        insert c;

    	Test.StartTest();
    	PageReference pageRef = page.PO_TP_ButtonsPhaseTransition_Page;
    	pageRef.getParameters().put('Id',c.Id);       
        pageRef.getParameters().put('proc','close');        
    	Test.setCurrentPageReference(pageRef);	    
        
        PageReference pageRef1 = page.PO_TP_ButtonsPhaseTransition_Page;
    	pageRef1.getParameters().put('Id',c.Id);       
        pageRef1.getParameters().put('proc','addNote');        
    	Test.setCurrentPageReference(pageRef1);	
        
        PageReference pageRef2 = page.PO_TP_ButtonsPhaseTransition_Page;
    	pageRef2.getParameters().put('Id',c.Id);       
        pageRef2.getParameters().put('proc','addNoteInc');        
    	Test.setCurrentPageReference(pageRef2);	
        
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        PO_TP_Buttons_Controller buttonC = new PO_TP_Buttons_Controller(sc);
        buttonC.noteOLO = true;
        buttonC.noteInterne = true;
        PageReference p1 = buttonC.lavoraCase();	
        PageReference p2 = buttonC.inviaAlSOC();
         
        buttonC.PrendiInCarico();
        buttonC.InviaNotaOLO();
        buttonC.codaTerr = 'TP_Coda_Delivery_Centro';
        PageReference p3 = buttonC.inviaAllaCodaTerr();       
        buttonC.PrendiInCarico();
        List<SelectOption> list_options = buttonC.getCodeTerr();
        PageReference p5 = buttonC.chiudiTicket();

        Test.StopTest();
    }	
}
@isTest
private class PO_KIT_Controller_TEST {
public static EOF_EAI_Service_Log__c sl {get;set;}
	    public static testmethod void savesl_test() 
    { 
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        Id rectyId = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs ( thisUser ) 
        { 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c=1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
            acc.name = 'test';        
            insert acc;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
            ofe.name = 'Status';
            ofe.OF_Enable_Trigger__c = false;
            insert ofe;
            
            OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
            oft.Name = 'Tibco UserID';
            oft.OF_Tibco_ID__c = 'Test';
            insert oft;
            
            contact con = new contact(); 
            con.lastname = 'test';
            con.PO_Servizi_a_fattibilit__c = True;
            con.PO_P2P_Base__c = True;
            con.PO_Fiber_Link__c = True;
            con.PO_IRU__c = True;
            con.PO_Fiber_Lease__c = True;
            con.PO_Misto_Fiber_Lease_Link_per_Fastweb__c = True;
            con.PO_Servizio_Open_Stream__c = True;
            con.AccountId = acc.Id;      
            con.Email= 'testmail@atos.net';
            insert con;
            
            contact con1 = new contact();
            con1.lastname = 'test1';
            con1.PO_Servizi_a_fattibilit__c = True;
            con1.PO_P2P_Base__c = True;
            con1.PO_Fiber_Link__c = True;
            con1.PO_IRU__c = True;
            con1.PO_Fiber_Lease__c = True;
            con1.PO_Misto_Fiber_Lease_Link_per_Fastweb__c = True;
            con1.PO_Servizio_Open_Stream__c = True;
            con1.AccountId = acc.Id;      
            con1.Email= 'unitTest@atos.net';
            insert con1;
            
            Profile p = [SELECT Id FROM Profile WHERE Name='Partner Community Super User'];
            User u = new User(Alias = 'standt', Email='unitTestMail1@atos.net', 
                              EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = p.Id,ContactId = con.Id,
                              TimeZoneSidKey='America/Los_Angeles', UserName='testmail1@po.net',isactive=true);
            insert u;
            
            Profile p1 = [SELECT Id FROM Profile WHERE Name='Partner Community User'];
            User u1 = new User(Alias = 'standt1', Email='unitTestMail2@atos.net', 
                               EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                               LocaleSidKey='en_US', ProfileId = p1.Id, ContactId = con1.Id,
                               TimeZoneSidKey='America/Los_Angeles', UserName='testmail2@atos.net',isactive=true);
            insert u1;
            
            case c = new case();
            c.recordtypeid = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
            c.ContactId = con.id;
            c.status = 'Bozza';
            c.origin = 'Web';
            c.Priority = 'Medium';
            c.PO_OLO_Registrazione__c = 'Test';
            c.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
            c.PO_Cognome_Registrazione__c = 'Test'; 
            c.PO_Cognome_Registrazione__c = 'Test'; 
            c.PO_Email_Registrazione__c = 'test@test.com';
            c.PO_Telefono_Registrazione__c = '1234567890';
            c.PO_Nome_Progetto__c='test';
            insert c;


   recordtype rt = [select Id from recordtype where recordtype.name='NACK'];
      sl = new EOF_EAI_Service_log__c();
      sl.recordtypeId = rt.Id;
      //sl.Notify__c='adasdasd';
      sl.EOF_Codice_errore__c='A_K8';
      insert sl;
            
            PO_KIT_Controller testPlan = new PO_KIT_Controller();

            
            
            testPlan.pop = 'pop';
            testPlan.BandaInterfaccia='100';
            testPlan.interfaccia='333';
            testPlan.Traffico='traffico';
            testPlan.Note='Note';
            
             testPlan.savesl();
            testPlan.redirectToRegPage();
            testPlan.redirectToRegPage ();
            testPlan.contactInformation     ();
            testPlan.deleteUserContact      ();
            testPlan.ParentCaseRecord       ();
            testPlan.Fiberlease             ();
            testPlan.Fiberlink              ();
            testPlan.IRU                    ();
            testPlan.MistoFiber             ();
            testPlan.ServizioOpenStream     ();
            testPlan.ServizioTT             ();
            testPlan.TTList                 ();
            testPlan.ServizioTP             ();
            testPlan.TPList                 ();
            testPlan.Incident               ();
            testPlan.IncidentList           ();
            testPlan.redirectServizioKIT    ();
            testPlan.redirectFindKIT        ();
            testPlan.deleteChildAlone       ();
            testPlan.DeleteSL();
            testPlan.SearchCase();
            Boolean bool = testPlan.isSuperUser;
            User bool2 = testPlan.Usr;
            	testPlan.contList();
	testPlan.EditContact();
	testPlan.OpenStreamList();
	testPlan.LineeAttive();
           
            Test.stopTest();
   
        }
    }
	
	
	
	

}
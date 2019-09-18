@isTest

public class PO_RegistrationControllerTest {
    
    public static String[] csvFileLines;
    public static Blob csvFileBody;
    public static testmethod void registration() 
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
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs ( thisUser )
        { 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c =   1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
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
            
            OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
            ofe.name = 'Status';
            ofe.OF_Enable_Trigger__c = false;
            insert ofe;
            
            OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
            oft.Name = 'Tibco UserID';
            oft.OF_Tibco_ID__c = 'Test';
            insert oft;
            
            case c = new case();
            c.recordtypeid = rtId;
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = rtId7;
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            // inserting multiple cases  
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = rtId2;
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = rtId4;
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID = u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.Status = 'Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.Status = 'Bozza';
            ChildCase2.recordtypeid = rtId5;
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.Status = 'Bozza';
            ChildCase3.recordtypeid = rtId6;
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.Status = 'Bozza';
            ChildCase4.recordtypeid = rtId3;
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testPlan.parentCaseObj = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            case testca = testPlan.testcase;
            string nameFi = testPlan.nameFile;
            Blob conFile = testPlan.contentFile;
            List<Case> casestoup = testPlan.casestoupload;
            string st = testPlan.str;
            string dt4 = testPlan.date4;
            case editchildparentCs = testPlan.editchildparentCaseObj;
            OF_ElencoComuniItaliani__c OFElencoComuniItaliani = testPlan.OF_ElencoComuniItalianiobj;
            List<User> contUsrList = testPlan.contactUserList;
            string fileName1 = testPlan.fileName1;
            Blob fileBody1 = testPlan.fileBody1;
            string CaseDetailTest = testPlan.CaseDetail;
            string offe = testPlan.offerta;
            List<Attachment> atLink = testPlan.attLink;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument>  qutedc = testplan.quoteDoc;
            date childdt = testplan.childrecdate;
            Id  quoid = testplan.quoteDocid;
            String  qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            testPlan.ParentCaseRecord();
            testPlan.saveCasesFromWeb();
            testPlan.redirectToRegPage();
            testplan.enbleB();
            testplan.enbleC();
            testplan.enbleD();            
            testplan.contactInformation();
            testplan.saveContactInformation();
            testPlan.deleteUserContact();
            testplan.Home(); 
            testPlan.Fiberlease();
            testPlan.Fiberlink();
            testPlan.MistoFiber();
            testPlan.IRU();
            testPlan.Fiberlease();
            testPlan.Fiberlink();
            testPlan.currentUserParentCases_P2P();
            testPlan.backtochild();
            Test.stopTest();
        }
    }
    
    public static testmethod void registrationChildCase() 
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
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            
            OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
            ofe.name = 'Status';
            ofe.OF_Enable_Trigger__c = false;
            insert ofe;
            
            OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
            oft.Name = 'Tibco UserID';
            oft.OF_Tibco_ID__c = 'Test';
            insert oft;
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID = u.id;
            parentCase.Status ='Acquisito';
            parentCase.EOF_Fase__c ='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            ChildCase4.status='Bozza';
            insert ChildCase4;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testPlan.parentCaseObj=parentCase;
            testPlan.parentCase=parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument>  qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            Id  quoid=testplan.quoteDocid;
            String  qutname=testplan.quoteName;
            String condid=testplan.ContDocId;
            String bsurl=testplan.baseURL;
            testPlan.childCase();
            Test.stopTest();
        }
    }
    
    public static testmethod void registration1() 
    {
        Test.startTest();
        PO_RegistrationController testPlan = new PO_RegistrationController();
        PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
        
        PO_RegistrationController.addAdressClass addCl= new PO_RegistrationController.addAdressClass('test','test1');
        addCl.ContactNamelable = 'UnitTest';
        addCl.ContactNameValue = 'UnitTest';
        addCl.ContactNamelable1 = 'UnitTest';
        addCl.ContactNameValue1 = 'UnitTest';
        
        testPlan.saveCasesFromWeb();
        testPlan.redirectToRegPage();
        testplan.saveContactInformation();
        testplan.Home();
        testPlan.deleteUserContact();
        Test.stopTest();
    }
    
    
    public static testmethod void registration2() 
    {   
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        System.runAs ( thisUser ) { 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c=1;
            insert paramFat;
            
            account acc = new account();
            acc.RecordTypeId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
            acc.name = 'test';        
            insert acc;
            System.debug('acc===>'+acc);
            
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
            System.debug('case===>'+c);
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.Status='Bozza';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            childCase1.ownerID=thisuser.ID;
            ChildCase1.accountId = acc.Id;
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            ChildCase4.status='Bozza';
            insert ChildCase4;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            testPlan.conId = con.Id;
            testplan.CaseDetail=ChildCase1.ID;
            testplan.accId = acc.Id;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3 = testPlan.textarea;            
            testPlan.getsortingCases();
            testPlan.currentUserParentCases();
            //testplan.displayChildCases();
            testPlan.DisplayCaseInfo();
            testPlan.EditCaseInfo();
            testplan.SaveCaseInfo();
            testplan.StausUpdate(); 
            testplan.AddAttachment();
            testPlan.upload();
            testPlan.ServizioOpenStream();
            testPlan.saveparentCaseNew();
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;
            Test.stopTest();
        }
    }
    
    public static testmethod void registration3() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            case parentCase = new Case();
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.accountId = acc.Id;
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.Status='Bozza';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            // insert ChildCase;
            System.debug('ChildCase------>'+ChildCase);
            
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            ChildCase4.status='Bozza';
            insert ChildCase4;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            // Contact contact = testPlan.enableFeasibilityService ;
            Boolean bool = testPlan.isSuperUser;
            
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            testPlan.CaseDetail=ChildCase1.id;
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            testPlan.getsortingCases();
            testPlan.currentUserParentCases();
            //testplan.displayChildCases();
            testPlan.DisplayCaseInfo();
            testPlan.EditCaseInfo();
            //   testplan.SaveCaseInfo();
            testplan.StausUpdate(); 
            testplan.AddAttachment();
            // testPlan.upload();
            testPlan.ServizioOpenStream();
            testPlan.saveparentCaseNew();
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase1.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;
            Test.stopTest();
        }
    }
    
    public static testmethod void registration4() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            ChildCase4.status='Bozza';
            insert ChildCase4;
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            
            List<opportunity> testOpp=new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp=testOpp;
            testplan.childrecdate=System.Today();
            //AA - 251018
            //testplan.runQueryP2PAttiva();
            testplan.runQueryTicketProv();
            testplan.runSearchProfilo();
            testplan.scegliTipoReq();
            testplan.requestSelected = 'ATT';
            testplan.toP2PAttiva();
            testplan.creaSlP2PAttivaPadre();
            testplan.requestSelected = 'CESS';
            testplan.toP2PAttiva();
            
            ApexPages.currentPage().getParameters().put('Codice','123456');
            ApexPages.currentPage().getParameters().put('TipoRichiesta','3255235');
            ApexPages.currentPage().getParameters().put('StatoRichiesta','123456');
            ApexPages.currentPage().getParameters().put('idPop','3255235');
            ApexPages.currentPage().getParameters().put('idRisorsa','123456');
            ApexPages.currentPage().getParameters().put('DataInizioFilter','');
            ApexPages.currentPage().getParameters().put('DataFineFilter','');
            ApexPages.currentPage().getParameters().put('DataInizioP2PAtt','');
            ApexPages.currentPage().getParameters().put('DataFineP2PAtt','');
            testplan.runSearchP2PATT();
            ApexPages.currentPage().getParameters().put('causale_apertura','123456');
            ApexPages.currentPage().getParameters().put('descr_causale','3255235');
            ApexPages.currentPage().getParameters().put('codice_ordine','123456');
            ApexPages.currentPage().getParameters().put('stato_ordine','3255235');
            ApexPages.currentPage().getParameters().put('idRisorsa','123456');
            ApexPages.currentPage().getParameters().put('escalation','yes');
            ApexPages.currentPage().getParameters().put('DataInizioTP','');
            ApexPages.currentPage().getParameters().put('DataFineTP','');
            testplan.runSearchTicketProv();
            ApexPages.currentPage().getParameters().put('TipoRichiesta','Change Order');
            testplan.runSearchTicketProv();
            testplan.getIDPoplist();
            testplan.getStatoOrdinelist();
            testplan.getCasualelist();
            testplan.offertaSelected='Segnalazione Provisioning';
            testplan.getCausaleAperturaItems();
            testplan.offertaSelected='Problema tecnico/applicativo';
            testplan.getCausaleAperturaItems();
            testplan.getDescrCausaleItems();
            //Too many query testplan.OpportunityStageNameUpdate2();
            //testplan.OpportunityStageNameUpdate();
            Test.stopTest();
        }
    }

    
    /*public static testmethod void registration5() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator' limit 1];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite' limit 1];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            
            Profile p = [SELECT Id FROM Profile WHERE Name='Partner Community Super User' limit 1];
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c ='In Verifica BO';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            // insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.OwnerID=thisUser.Id;
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.OwnerID=thisUser.Id;
            ChildCase2.Status='Acquisito';
            ChildCase2.EOF_Fase__c='In Verifica BO';
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.OwnerID=thisUser.Id;
            ChildCase3.Status='Acquisito';
            ChildCase3.EOF_Fase__c='In Verifica BO';
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID=thisUser.Id;
            ChildCase4.Status='Acquisito';
            ChildCase4.EOF_Fase__c='In Verifica BO';
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            List<opportunity> testOpp=new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp = testOpp;
            testplan.childrecdate = System.Today();
            testplan.OpportunityStageNameUpdate2();
            Test.stopTest();
        }
    }*/
   
    public static testmethod void registration6() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;        
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.OwnerID = thisuser.Id;
            parentCase.Status ='Acquisito';
            parentCase.EOF_Fase__c ='In Verifica BO';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            ChildCase4.status='Bozza';
            insert ChildCase4;
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            List<opportunity> testOpp = new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp = testOpp;
            testplan.childrecdate = System.Today();
            testplan.OpportunityStageNameUpdate3();
            Test.stopTest();
            
        }
    } 
    
    
    public static testmethod void registration7() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c ='test';
            parentCase.OwnerID = thisuser.Id;
            parentCase.Status = 'Acquisito';
            parentCase.EOF_Fase__c ='In Verifica BO';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.OwnerID=thisUser.Id;
            ChildCase.Status='Acquisito';
            ChildCase.EOF_Fase__c='In Verifica BO';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.OwnerID=thisUser.Id;
            ChildCase2.Status='Acquisito';
            ChildCase2.EOF_Fase__c='In Verifica BO';
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.OwnerID=thisUser.Id;
            ChildCase3.Status='Acquisito';
            ChildCase3.EOF_Fase__c='In Verifica BO';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.OwnerID=thisUser.Id;
            ChildCase4.Status='Acquisito';
            ChildCase4.EOF_Fase__c='In Verifica BO';
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            List<opportunity> testOpp=new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp=testOpp;
            testplan.childrecdate=System.Today();
            testplan.OpportunityStageNameUpdate4();
            Test.stopTest();
        }
    }
    
/*
public static testmethod void registration8() 
{
Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
insert thisUser ;

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

case parentCase = new Case();
parentCase.accountId = acc.Id;
ParentCase.OwnerID=u.id;
parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
parentCase.PO_Offerta__c = 'P2P Base';
parentCase.PO_Nome_Progetto__c='test';
parentCase.OwnerID=thisuser.Id;
parentCase.Status='Acquisito';
parentCase.EOF_Fase__c='In Verifica BO';
insert parentCase;

case ChildCase = new Case();
ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
ChildCase.ContactId = con.id;
ChildCase.ParentId = parentCase.id;
ChildCase.accountId = acc.Id;
ChildCase.PO_Offerta__c = 'Fiber Link';
ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
ChildCase.PO_Area_Geografica__c = 'Nord Est';
ChildCase.PO_Prime_Contractor__c = 'test';
ChildCase.PO_Numero_fibre_richieste__c = 'test';
ChildCase.PO_Tipo_percorso__c = 'Singola Via';
ChildCase.PO_Numero_fibre_richieste__c = 'test';
ChildCase.PO_Siti_da_collegare__c = 'test';
ChildCase.PO_Nome_sito__c = 'test';
ChildCase.PO_Note_collegamento__c = 'test';
//  insert ChildCase;            

case ChildCase1 = new Case();
ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
ChildCase1.ContactId = con1.id;
ChildCase1.OwnerID = u.id;
ChildCase1.ParentId = parentCase.id;
ChildCase1.accountId = acc.Id;
ChildCase1.PO_Offerta__c =  'Fiber Lease';
ChildCase1.Status ='Acquisito';
ChildCase1.EOF_Fase__c ='In Verifica BO';
ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
ChildCase1.PO_Area_Geografica__c = 'Nord Est';
ChildCase1.PO_Prime_Contractor__c = 'test';
ChildCase1.PO_Numero_fibre_richieste__c = 'test';
ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
ChildCase1.PO_Numero_fibre_richieste__c = 'test';
ChildCase1.PO_Siti_da_collegare__c = 'test';
ChildCase.PO_Nome_sito__c = 'test';
ChildCase1.PO_Note_collegamento__c = 'test';
insert ChildCase1;

case ChildCase2 = new Case();
ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
ChildCase2.ContactId = con.id;
ChildCase2.OwnerID=u.id;
ChildCase2.ParentId = parentCase.id;
ChildCase2.accountId = acc.Id;
ChildCase2.PO_Offerta__c = 'P2P Base';
ChildCase2.OwnerID=thisUser.Id;
ChildCase2.Status='Acquisito';
ChildCase2.EOF_Fase__c='In Verifica BO';
ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
ChildCase2.PO_Area_Geografica__c = 'Nord Est';
ChildCase2.PO_Prime_Contractor__c = 'test';
ChildCase2.PO_Numero_fibre_richieste__c = 'test';
ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
ChildCase2.PO_Numero_fibre_richieste__c = 'test';
ChildCase2.PO_Siti_da_collegare__c = 'test';
ChildCase2.PO_Nome_sito__c = 'test';
ChildCase2.PO_Note_collegamento__c = 'test';
insert ChildCase2;
//update ChildCase2;

case ChildCase3 = new Case();
ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
ChildCase3.ContactId = con.id;
ChildCase3.OwnerID=u.id;
ChildCase3.ParentId = parentCase.id;
ChildCase3.accountId = acc.Id;
ChildCase3.PO_Offerta__c = 'IRU';
ChildCase3.Status='Acquisito';
ChildCase3.EOF_Fase__c='In Verifica BO';
ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
ChildCase3.PO_Area_Geografica__c = 'Nord Est';
ChildCase3.PO_Prime_Contractor__c = 'test';
ChildCase3.PO_Numero_fibre_richieste__c = 'test';
ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
ChildCase3.PO_Numero_fibre_richieste__c = 'test';
ChildCase3.PO_Siti_da_collegare__c = 'test';
ChildCase3.PO_Nome_sito__c = 'test';
ChildCase3.PO_Note_collegamento__c = 'test';
insert ChildCase3;

case ChildCase4 = new Case();
ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
ChildCase4.ContactId = con.id;
ChildCase4.OwnerID=u.id;
ChildCase4.OwnerID=thisUser.Id;
ChildCase4.Status='Acquisito';
ChildCase4.EOF_Fase__c='In Verifica BO';
ChildCase4.ParentId = parentCase.id;
ChildCase4.accountId = acc.Id;
ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
ChildCase4.PO_Area_Geografica__c = 'Nord Est';
ChildCase4.PO_Prime_Contractor__c = 'test';
ChildCase4.PO_Numero_fibre_richieste__c = 'test';
ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
ChildCase4.PO_Numero_fibre_richieste__c = 'test';
ChildCase4.PO_Siti_da_collegare__c = 'test';
ChildCase4.PO_Nome_sito__c = 'test';
ChildCase4.PO_Note_collegamento__c = 'test';
insert ChildCase4;

case OrderCase= new Case();
OrderCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
OrderCase.ContactId = con.id;
OrderCase.OwnerID=u.id;
OrderCase.OwnerID=thisUser.Id;
OrderCase.Status='Acquisito';
OrderCase.EOF_Fase__c='In Verifica BO';
OrderCase.ParentId = parentCase.id;
OrderCase.accountId = acc.Id;
Ordercase.PO_Case_Collegamento__c=ChildCase4.id;
OrderCase.PO_Offerta__c = 'Evento Temporaneo';
OrderCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
OrderCase.PO_Area_Geografica__c = 'Nord Est';
OrderCase.PO_Prime_Contractor__c = 'test';
OrderCase.PO_Numero_fibre_richieste__c = 'test';
OrderCase.PO_Tipo_percorso__c = 'Singola Via';
OrderCase.PO_Numero_fibre_richieste__c = 'test';
OrderCase.PO_Siti_da_collegare__c = 'test';
OrderCase.PO_Nome_sito__c = 'test';
OrderCase.PO_Note_collegamento__c = 'test';
insert OrderCase;




list<case> testChildCases=new list<case>();
testChildCases.add(ChildCase4);
testChildCases.add(ChildCase3);
testChildCases.add(ChildCase2);

OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c='TestID');
insert testComune;

ApexPages.StandardController sc = new ApexPages.StandardController(c);

Test.startTest();
PO_RegistrationController testPlan = new PO_RegistrationController(sc);
PO_RegistrationController testPlanEmpty = new PO_RegistrationController();

PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
addCls.ContactNamelable = 'Test';
addCls.ContactNameValue = 'Test';
addCls.ContactNamelable1 = 'Test';
addCls.ContactNameValue1 = 'Test';

Boolean bool = testPlan.isSuperUser;
Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
testPlan.fileName = 'unit test';

testPlan.fileBody = bodyBlob;
ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
testPlan.conId = con.Id;
testplan.accId = acc.Id; 
testplan.parentCaseObj = parentCase;
testplan.ChildCaseObj = childCase1;
testPlan.ChildCases=testChildCases;
List<Contact> conListTest = testPlan.conList;
String AccountName = testPlan.AccName;
String SelParentTest = testPlan.SelParent;
Case parentCaseObjTest = testPlan.parentCaseObj;
string CaseDetailTest = testPlan.CaseDetail;
Attachment myAttachmentTest = testPlan.myAttachment;
Map<Id,String> uploadMapTest = testPlan.uploadMap;
string str3 = testPlan.textarea;

Opportunity opportunity = new Opportunity();
opportunity.Name = 'Test Opportunity';
opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
opportunity.PO_Collegamento__c = ChildCase1.id;
opportunity.PO_Totale_canoni__c = 100.00;
opportunity.PO_Summary__c = true;
opportunity.StageName = 'Offerta presentata';
opportunity.CloseDate = System.today();
opportunity.PO_Sconto_canone__c = 10;
opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
insert opportunity;  



Opportunity opportunity1 = new Opportunity();
opportunity1.Name = 'Test Opportunity';
opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
// opportunity1.PO_Collegamento__c = ChildCase1.id;
opportunity1.PO_Totale_canoni__c = 100.00;
opportunity1.PO_Summary__c = true;
opportunity1.StageName = 'Offerta presentata';
opportunity1.CloseDate = System.today();
opportunity1.PO_Sconto_canone__c = 10;
opportunity1.PO_Sconto_costi_aggiuntivi__c = 10;
insert opportunity1;  

List<opportunity> testOpp=new List<Opportunity>();
testOpp.add(Opportunity);
testPlan.Opp = testOpp;
testplan.childrecdate = System.Today();
testplan.date4='30/05/2017';
testplan.ordercasedit =orderCase;
testplan.OpportunityStageNameUpdate3a();
testplan.enbleE();
testplan.enbleF();
ApexPages.currentPage().getParameters().put('recId',ParentCase.Id);
testplan.RecId = ParentCase.Id;
testplan.selectedIDComune=testComune.ID;
testplan.SaveOrderCase();
testplan.collegmentaDate();
testplan.getorderCases();

testplan.displayChildCases();
testplan.ParentDataOrderUpdation();
testplan.Annula();
//  testPlan.InviaRichiesta();
//  testplan.SaveParentChildCaseInfo();
//  testplan.AddParentAttachment();
//  testplan.parentUpload();
Test.stopTest();
}
}
*/
    
    public static testmethod void registration9() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
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
            System.debug('Usr1===>'+u1); 
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            ParentCase.OwnerID = u.id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c ='test';
            parentCase.OwnerID = thisuser.Id;
            parentCase.Status ='Acquisito';
            parentCase.EOF_Fase__c ='In Verifica BO';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.OwnerID=thisUser.Id;
            ChildCase2.Status='Acquisito';
            ChildCase2.EOF_Fase__c='In Verifica BO';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.Status ='Acquisito';
            ChildCase3.EOF_Fase__c ='In Verifica BO';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.OwnerID=thisUser.Id;
            ChildCase4.Status='Acquisito';
            ChildCase4.EOF_Fase__c='In Verifica BO';
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            list<case> testChildCases = new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c='TestID');
            insert testComune;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('id',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase1;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase1.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            List<opportunity> testOpp=new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp=testOpp;
            testplan.childrecdate=System.Today();
            
            testplan.OpportunityStageNameUpdate3a();
            testplan.enbleE();
            testplan.enbleF();
            ApexPages.currentPage().getParameters().put('recId',ParentCase.Id);
            testplan.RecId = ParentCase.Id;
            testplan.selectedIDComune = testComune.ID;
            testPlan.ParentAnnula();
            testPlan.contList();
            testPlan.EditContact();
            testPlan.deleteChildAlone();
            testPlan.getuploadedCases();
            //testPlan.ReadFile();
            testPlan.parentupload();
            ApexPages.currentPage().getParameters().put('id',ParentCase.Id);
            testPlan.DeleteParentChildCase();
            List<String> lstTestImp = new List<String>();
            lstTestImp.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            lstTestImp.add('Vodafone,Dark Fiber,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');
            String blobstring = '';
            for(String x : lstTestImp){
                blobstring = blobstring + x; 
            }
            Blob b = Blob.valueOf(blobstring);
            String cc = PO_RegistrationController.blobToString(b, 'ISO-8859-1');
            String ccDate = testPlan.transformDate('1/1/2001');
            String ccDate2 = testPlan.transformDate('');
            testPlan.ServizioTP();
            testPlan.Incident();
            testPlan.TPList();
            testPlan.IncidentList();
            /*testPlan.contentFile = b;
            testPlan.ReadFile();*/
            Test.stopTest();
        }
    }
    
    
    public static testmethod void registration10() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
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
            System.debug('con1===>'+con1);
            
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
            System.debug('Usr1===>'+u1); 
            
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
            System.debug('case===>'+c);
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            ParentCase.OwnerID=u.id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            insert parentCase;
            System.debug('insert parentCase===>'+parentCase);
            
            //update parentCase;
            System.debug('after update parentCase===>'+parentCase);
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.OwnerID=thisUser.Id;
            ChildCase2.Status='Acquisito';
            ChildCase2.EOF_Fase__c='In Verifica BO';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            //ChildCase3.OwnerID=thisUser.Id;
            ChildCase3.Status='Acquisito';
            ChildCase3.EOF_Fase__c='In Verifica BO';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.OwnerID = u.id;
            ChildCase4.OwnerID = thisUser.Id;
            ChildCase4.Status ='Acquisito';
            ChildCase4.EOF_Fase__c ='In Verifica BO';
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c='TestID');
            insert testComune;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            Boolean bool = testPlan.isSuperUser;
            
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('id',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase1;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3 = testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase1.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            List<opportunity> testOpp = new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp=testOpp;
            testplan.childrecdate=System.Today();
            testplan.OpportunityStageNameUpdate3a();
            testplan.enbleE();
            testplan.enbleF();
            ApexPages.currentPage().getParameters().put('recId',ParentCase.Id);
            testplan.RecId = ParentCase.Id;
            testplan.selectedIDComune = testComune.ID;
            testPlan.UpdateChildcaseInfo();
            Test.stopTest();
        }
    }
    
    public static testmethod void registration11() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
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
            con.Email = 'testmail@atos.net';
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
            System.debug('case===>'+c);
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            ParentCase.OwnerID=u.id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status ='Acquisito';
            parentCase.EOF_Fase__c ='In Verifica BO';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //  insert ChildCase;
            //   
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status ='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.OwnerID = thisUser.Id;
            ChildCase2.Status = 'Acquisito';
            ChildCase2.EOF_Fase__c = 'In Verifica BO';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID = u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            //ChildCase3.OwnerID=thisUser.Id;
            ChildCase3.Status='Acquisito';
            ChildCase3.EOF_Fase__c='In Verifica BO';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.OwnerID=thisUser.Id;
            ChildCase4.Status='Acquisito';
            ChildCase4.EOF_Fase__c='In Verifica BO';
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c='TestID');
            insert testComune;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('id',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase1;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase1.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            List<opportunity> testOpp = new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp=testOpp;
            testPlan.ParentCase=parentCase;
            testplan.childrecdate=System.Today();
            testplan.OpportunityStageNameUpdate3a();
            testplan.enbleE();
            testplan.enbleF();
            ApexPages.currentPage().getParameters().put('recId',ParentCase.Id);
            testplan.RecId = ParentCase.Id;
            testplan.selectedIDComune = testComune.ID;
            testplan.DeleteParentCase();
            Test.stopTest();
        }
    }
    
    
    public static testmethod void registrationChildCase1() 
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Fiber Link';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            System.debug('ChildCase1------>'+ChildCase1.OwnerID);
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.status='Bozza';
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.status='Bozza';
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testPlan.parentCaseObj=parentCase;
            testPlan.parentCase=parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument>  qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            Id quoid = testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            testPlan.childCase();
            Test.stopTest();
        }
    }
    
    public static testmethod void registrationChildCase2() 
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Fiber Lease';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            //  
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID = u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            ChildCase4.status='Bozza';
            insert ChildCase4;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            // Contact contact = testPlan.enableFeasibilityService ;
            Boolean bool = testPlan.isSuperUser;
            
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testPlan.parentCaseObj=parentCase;
            testPlan.parentCase=parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            // contact enservice = testPlan.enableFeasibilityService;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument>  qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            Id quoid= testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            testPlan.childCase();
            Test.stopTest();
        }
    } 
    
    public static testmethod void registrationChildCase3() 
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
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            Profile p1 = [SELECT Id FROM Profile WHERE Name = 'Partner Community User'];
            User u1 = new User(Alias = 'standt1', Email = 'unitTestMail2@atos.net', 
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'IRU';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            System.debug('ChildCase1------>'+ChildCase1.OwnerID);
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.status='Bozza';
            ChildCase2.OwnerID=u.id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.status='Bozza';
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testPlan.parentCaseObj = parentCase;
            testPlan.parentCase = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument>  qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            Id quoid = testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            testPlan.childCase();
            Test.stopTest();
        }
    } 
    
    
/*    public static testmethod void registrationChildCase4() 
    {   
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator' limit 1];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite' limit 1];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        Id rectyId = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Evento Temporaneo';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Lease';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case parentCase2 = new Case();
            parentCase2.accountId = acc.Id;
            parentCase2.OwnerID=u.id;
            parentCase2.Status='Accettato';
            parentCase2.EOF_Fase__c='In Verifica BO';
            parentCase2.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase2.PO_Offerta__c = 'Evento Temporaneo';
            parentCase2.PO_Nome_Progetto__c='test';
            insert parentCase2;
            
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.status='Bozza';
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.status='Bozza';
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID = u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.status='Bozza';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID = u.id;
            ChildCase4.status='Bozza';
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            
            
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            String contentFile = 'Milano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito1';
            Blob testContentFile = Blob.valueOF(contentFile);
            String csvAsString = testContentFile.toString();
            csvFileLines = csvAsString.split('\n');
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            
            
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testplan.Indirizzo = 'test';
            testPlan.contentFile = testContentFile;
            testPlan.parentCaseObj = parentCase;
            testPlan.parentCase = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            // contact enservice = testPlan.enableFeasibilityService;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument> qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            
            testplan.childcasedisplayobj=ChildCase;
            Id quoid = testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            testPlan.ReadFile();
            
            testPlan.childCase();
            testPlan.uploadCSV();
            testPlan.uploadCSV();
            testplan.EditOrderInfo();
            testplan.OpenStreamList();
            testplan.redirectparentcasedetail();
            testplan.childcasedisplayid=ChildCase1.Id;
            testplan.redirectchildcasedetail();
            testplan.ParentCaseDisplay=parentCase;
            testplan.DetailPage1();
            testplan.detailparentcase();
            
            Test.stopTest();
        }
    }
*/        
    
    public static testmethod void registrationChildCase5() 
    {   
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        Id rectyId = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Evento Temporaneo';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Lease';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.status='Bozza';
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.status='Bozza';
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID = u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.status='Bozza';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID = u.id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.status='Bozza';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Milano');
            insert testComune;
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            String contentFile = 'Milano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito1\nMilano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito,test,test,test,test';
            Blob testContentFile = Blob.valueOF(contentFile);
            String csvAsString = testContentFile.toString();
            csvFileLines = csvAsString.split('\n');
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            
            
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testplan.Indirizzo = 'test';
            testPlan.contentFile = testContentFile;
            testPlan.parentCaseObj = parentCase;
            testPlan.parentCase = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            // contact enservice = testPlan.enableFeasibilityService;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument> qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            
            testplan.childcasedisplayobj=ChildCase;
            Id quoid = testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            //testPlan.ReadFile();
            
            
            
            Test.stopTest();
        }
    }
    
    /*
    public static testmethod void registration19() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            ParentCase.OwnerID=u.id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //  insert ChildCase;            
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.OwnerID = u.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status ='Acquisito';
            ChildCase1.EOF_Fase__c ='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.OwnerID=thisUser.Id;
            ChildCase2.Status='Acquisito';
            ChildCase2.EOF_Fase__c='In Verifica BO';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.Status='Acquisito';
            ChildCase3.EOF_Fase__c='In Verifica BO';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.OwnerID=thisUser.Id;
            ChildCase4.Status='Acquisito';
            ChildCase4.EOF_Fase__c='In Verifica BO';
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            case OrderCase= new Case();
            OrderCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            OrderCase.ContactId = con.id;
            OrderCase.OwnerID=u.id;
            OrderCase.OwnerID=thisUser.Id;
            OrderCase.Status='Acquisito';
            OrderCase.EOF_Fase__c='In Verifica BO';
            OrderCase.ParentId = parentCase.id;
            OrderCase.accountId = acc.Id;
            Ordercase.PO_Case_Collegamento__c=ChildCase4.id;
            OrderCase.PO_Offerta__c = 'Evento Temporaneo';
            OrderCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            OrderCase.PO_Area_Geografica__c = 'Nord Est';
            OrderCase.PO_Prime_Contractor__c = 'test';
            OrderCase.PO_Numero_fibre_richieste__c = 'test';
            OrderCase.PO_Tipo_percorso__c = 'Singola Via';
            OrderCase.PO_Numero_fibre_richieste__c = 'test';
            OrderCase.PO_Siti_da_collegare__c = 'test';
            OrderCase.PO_Nome_sito__c = 'test';
            OrderCase.PO_Note_collegamento__c = 'test';
            insert OrderCase;
            
            
            
            
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c='TestID');
            insert testComune;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase1;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3 = testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase1.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            
            
            Opportunity opportunity1 = new Opportunity();
            opportunity1.Name = 'Test Opportunity';
            opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
            // opportunity1.PO_Collegamento__c = ChildCase1.id;
            opportunity1.PO_Totale_canoni__c = 100.00;
            opportunity1.PO_Summary__c = true;
            opportunity1.StageName = 'Offerta presentata';
            opportunity1.CloseDate = System.today();
            opportunity1.PO_Sconto_canone__c = 10;
            opportunity1.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity1;  
            
            List<opportunity> testOpp=new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp = testOpp;
            testplan.childrecdate = System.Today();
            testplan.date4='30/05/2017';
            testplan.ordercasedit =orderCase;
            testplan.OpportunityStageNameUpdate3a();
            testplan.enbleE();
            testplan.enbleF();
            ApexPages.currentPage().getParameters().put('recId',ParentCase.Id);
            testplan.RecId = ParentCase.Id;
            testplan.selectedIDComune=testComune.ID;
            testplan.SaveOrderCase();
            testplan.collegmentaDate();
            testplan.getorderCases();
            
            // testplan.displayChildCases();
            testplan.ParentDataOrderUpdation();
            testplan.Annula();
            testPlan.InviaRichiesta();
            // testplan.SaveParentChildCaseInfo();
            testplan.AddParentAttachment();
            // testplan.parentUpload();
            Test.stopTest();
        }
    }
    */
    /*
    public static testmethod void registration20() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            ParentCase.OwnerID=u.id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //  insert ChildCase;            
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.OwnerID = u.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status ='Acquisito';
            ChildCase1.EOF_Fase__c ='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.OwnerID=thisUser.Id;
            ChildCase2.Status='Acquisito';
            ChildCase2.EOF_Fase__c='In Verifica BO';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            //update ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID=u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.Status='Acquisito';
            ChildCase3.EOF_Fase__c='In Verifica BO';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.OwnerID=u.id;
            ChildCase4.OwnerID=thisUser.Id;
            ChildCase4.Status='Acquisito';
            ChildCase4.EOF_Fase__c='In Verifica BO';
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            case OrderCase= new Case();
            OrderCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            OrderCase.ContactId = con.id;
            OrderCase.OwnerID=u.id;
            OrderCase.OwnerID=thisUser.Id;
            OrderCase.Status='Acquisito';
            OrderCase.EOF_Fase__c='In Verifica BO';
            OrderCase.ParentId = parentCase.id;
            OrderCase.accountId = acc.Id;
            Ordercase.PO_Case_Collegamento__c=ChildCase4.id;
            OrderCase.PO_Offerta__c = 'Evento Temporaneo';
            OrderCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            OrderCase.PO_Area_Geografica__c = 'Nord Est';
            OrderCase.PO_Prime_Contractor__c = 'test';
            OrderCase.PO_Numero_fibre_richieste__c = 'test';
            OrderCase.PO_Tipo_percorso__c = 'Singola Via';
            OrderCase.PO_Numero_fibre_richieste__c = 'test';
            OrderCase.PO_Siti_da_collegare__c = 'test';
            OrderCase.PO_Nome_sito__c = 'test';
            OrderCase.PO_Note_collegamento__c = 'test';
            insert OrderCase;
            
            
            
            
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c='TestID');
            insert testComune;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase1;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3 = testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase1.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            
            
            
            Opportunity opportunity1 = new Opportunity();
            opportunity1.Name = 'Test Opportunity';
            opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
            // opportunity1.PO_Collegamento__c = ChildCase1.id;
            opportunity1.PO_Totale_canoni__c = 100.00;
            opportunity1.PO_Summary__c = true;
            opportunity1.StageName = 'Offerta presentata';
            opportunity1.CloseDate = System.today();
            opportunity1.PO_Sconto_canone__c = 10;
            opportunity1.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity1;  
            
            List<opportunity> testOpp=new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp = testOpp;
            testplan.childrecdate = System.Today();
            testplan.date4='30/05/2017';
            testplan.ordercasedit =orderCase;
            testplan.OpportunityStageNameUpdate3a();
            testplan.enbleE();
            testplan.enbleF();
            ApexPages.currentPage().getParameters().put('recId',ParentCase.Id);
            testplan.RecId = ParentCase.Id;
            testplan.selectedIDComune=testComune.ID;
            testplan.SaveOrderCase();
            testplan.collegmentaDate();
            testplan.getorderCases();
            
            // testplan.displayChildCases();
            // testplan.ParentDataOrderUpdation();
            // testplan.Annula();
            // testPlan.InviaRichiesta();
            testplan.SaveParentChildCaseInfo();
            testplan.AddParentAttachment();
            testplan.parentUpload();
            Test.stopTest();
        }
    }
    */
    //Start-Added by Sasya on 01-12-2017
    @testSetup
    static void createData()
    {
        list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustSett1 = new list<OF_FiberLeaseListinoPrezzoAnnuo__c>();
        CustSett1 = OF_AreaGeograficaUtilityTest.CustomSettingFibLease();
        
        list<OF_FiberLeasePrezzoMedioAnnuo__c> CustSett2 = new list<OF_FiberLeasePrezzoMedioAnnuo__c>();
        CustSett2 = OF_AreaGeograficaUtilityTest.CustomSettingFibLease1();
    }
    
    static testmethod void MetodoIRU()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità IRU').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty IRU').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
        contr.savePDF();
        contr.savePDF_FiberLink();
    }
    
    static testmethod void MetodoP2P()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty collegamenti').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    //Durata affitto = 1
    static testmethod void MetodoFiberLink1()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 1,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    //Durata affitto = 2
    static testmethod void MetodoFiberLink2()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 2,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    //Durata affitto = 3
    static testmethod void MetodoFiberLink3()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 3,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    //Durata affitto > 3
    static testmethod void MetodoFiberLink4()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Link').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Link').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_affitto__c = 4,
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            PO_Numero_Anni__c = 4,
            PO_Richiesta_fattibilit__c = cas.id,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoEventoTempo()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Evento Temporaneo').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Evento Temporaneo').getRecordTypeId();
        
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft; 
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoEventoTempo1()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Evento Temporaneo').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Evento Temporaneo').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas1 = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Durata_mesi__c = 1
            );
        insert cas1;
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            name = 'Offerta totale',
            PO_Richiesta_fattibilit__c = cas1.id
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoFiberLease()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Fiber Lease').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Fiber Lease').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            PO_CostiCollegamento__c = 100,
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    
    static testmethod void MetodoFiberLeaseMisto()
    {
        string RTParentId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Richiesta fattibilità Misto Lease-Link per FW').getRecordTypeId();
        string RTChildId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('PO Oppty Misto Lease-Link per FW').getRecordTypeId();
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        case cas = new case
            (
                status = 'Test',
                priority = 'Medium',
                Origin = 'Web',
                PO_Incluso_nell_offerta__c = true
            );
        insert cas;
        
        opportunity opp = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            recordtypeid = RTParentId,
            name = 'Offerta totale'
        );
        insert opp;
        
        opportunity opp1 = new opportunity(
            CloseDate = system.today(),
            StageName = 'Offerta Accettata',
            name = 'Collegamento',
            PO_CostiCollegamento__c = 100,
            recordtypeid = RTChildId,
            PO_Offerta_totale__c = opp.id,
            PO_Collegamento__c = cas.id
        );
        insert opp1;
        
        quote q = new quote(
            name = 'test',
            OpportunityId = opp.id
        );
        insert q;
        
        ApexPages.currentPage().getParameters().put('id',q.id);
        ApexPages.currentPage().getParameters().put('Duratta','5');
        
        PO_RegistrationController contr = new PO_RegistrationController();
        //contr.savePDF();
        contr.ToReturn();
        contr.getdate();
    }
    //End-Added by Sasya on 01-12-2017
    
    public static testmethod void registrationChildCase6() 
    {   
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        Id rectyId = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Evento Temporaneo';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Lease';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.status='Bozza';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase1.PO_Nome_sito__c = 'test';
            // ChildCase1.PO_Case_Type_Formula__c='Richieste';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.status='Bozza';
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID = u.id;
            ChildCase3.status='Bozza';
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID = u.id;
            ChildCase4.status='Bozza';
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            //childCase4.Createddate = system.today();
            insert ChildCase4;
            
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Milano');
            insert testComune;
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            String contentFile = 'Milano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito1\nMilano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito,test,test,test,test';
            Blob testContentFile = Blob.valueOF(contentFile);
            String csvAsString = testContentFile.toString();
            csvFileLines = csvAsString.split('\n');
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            
            
            ApexPages.currentPage().getParameters().put('CaseDetail',ParentCase.Id);
            ApexPages.currentPage().getParameters().put('Id',ParentCase.Id);
            ApexPages.currentPage().getParameters().put('Casenumber','000');
            ApexPages.currentPage().getParameters().put('Status','Bozza');
            ApexPages.currentPage().getParameters().put('Datefrom','22/05/2017');
            ApexPages.currentPage().getParameters().put('Dateto','22/05/2017');
            ApexPages.currentPage().getParameters().put('Commune','Milano');
            ApexPages.currentPage().getParameters().put('Nome','Test');
            ApexPages.currentPage().getParameters().put('Offerta','--Select--');
            ApexPages.currentPage().getParameters().put('Tipodicollegamento','Ordine');
            ApexPages.currentPage().getParameters().put('PrimeContractor','Test');
            
            ApexPages.currentPage().getParameters().put('tipodi1','--Select--');
            ApexPages.currentPage().getParameters().put('Indirizzo1','test');
            
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testplan.Indirizzo = 'test';
            testPlan.contentFile = testContentFile;
            testPlan.parentCaseObj = parentCase;
            testPlan.parentCase = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            // contact enservice = testPlan.enableFeasibilityService;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            //  List<QuoteDocument> qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            
            testplan.childcasedisplayobj=ChildCase;
            Id quoid = testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            
            Apexpages.currentPage().getParameters().put('DataInizioCreazione','system.today()');  
            Apexpages.currentPage().getParameters().put('DataFineCreazione','system.today()');  
            testplan.runSearch();
            //  testPlan.next();
            //   testPlan.Previous();
            //  testPlan.last();
            //   testPlan.first();
            testPlan.SearchCases();
            testPlan.toggleSort();
            
            Test.stopTest();
        }
    }
    
    
    public static testmethod void registrationChildCase7() 
    {   
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        Id rectyId = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Evento Temporaneo';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Lease';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase.PO_Tipo_percorso__c = 'DOPPIA VIA DIVERSIFICATA';
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Case_Collegamento__c=parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase1.PO_Nome_sito__c = 'test';
            // ChildCase1.PO_Case_Type_Formula__c='Richieste';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase.PO_Tipo_percorso__c = 'DOPPIA VIA DIVERSIFICATA';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.status='Bozza';
            ChildCase3.OwnerID = u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase.PO_Tipo_percorso__c = 'DOPPIA VIA DIVERSIFICATA';
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID = u.id;
            ChildCase4.status='Bozza';
            ChildCase.PO_Tipo_percorso__c = 'DOPPIA VIA DIVERSIFICATA';
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            
            OF_ElencoComuniItaliani__c  testComune=new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Milano');
            insert testComune;
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            String contentFile = 'Milano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito1\nMilano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito,test,test,test,test';
            Blob testContentFile = Blob.valueOF(contentFile);
            String csvAsString = testContentFile.toString();
            csvFileLines = csvAsString.split('\n');
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            
            
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase1.Id);
            ApexPages.currentPage().getParameters().put('Casenumber','000');
            ApexPages.currentPage().getParameters().put('Status','Bozza');
            ApexPages.currentPage().getParameters().put('Datefrom','22/05/2017');
            ApexPages.currentPage().getParameters().put('Dateto','22/05/2017');
            ApexPages.currentPage().getParameters().put('Commune','Milano');
            ApexPages.currentPage().getParameters().put('Nome','Test');
            ApexPages.currentPage().getParameters().put('Offerta','P2P Base');
            ApexPages.currentPage().getParameters().put('Offerta','--Select--');
            ApexPages.currentPage().getParameters().put('Tipodicollegamento','Ordine');
            ApexPages.currentPage().getParameters().put('Tipodicollegamento','Richieste');
            ApexPages.currentPage().getParameters().put('Tipodicollegamento','Collegamento');
            ApexPages.currentPage().getParameters().put('PrimeContractor','Test');
            
            ApexPages.currentPage().getParameters().put('tipodi1','--Select--');
            ApexPages.currentPage().getParameters().put('Indirizzo1','test');
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testplan.Indirizzo = 'test';
            testPlan.contentFile = testContentFile;
            testPlan.parentCaseObj = parentCase;
            testPlan.parentCase = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            // contact enservice = testPlan.enableFeasibilityService;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument> qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            testPlan.Casedetail=ChildCase1.id;
            testplan.childcasedisplayobj=ChildCase;
            Id quoid = testplan.quoteDocid;
            // String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            
            testplan.childcaseobj = childcase;
            testplan.DetailPage();
            testplan.ordercasedit = childCase1;
            testplan.orderAnnula();
            testPlan.SearchCase();
            testPlan.redirectparentcasedetailNew();
            Apexpages.currentPage().getParameters().put('DataInizioCreazione','system.today()');  
            Apexpages.currentPage().getParameters().put('DataFineCreazione','system.today()');
            testplan.runSearch();
            testplan.comune='test';
            // testplan.debugSoql='test';
            //testPlan.next();
            //  testPlan.Previous();
            //  testPlan.last();
            //  testPlan.first();
            testPlan.SearchCases();
            testPlan.toggleSort();
            testPlan.EditOrderInfo();
            PO_RegistrationController.searchComune1('Test');
            PO_RegistrationController.searchComune2('Test');
            
            Test.stopTest();
        }
    }
    
    public static testmethod void registrationChildCase14() 
    {   
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        
        
        
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        Id rectyId = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Evento Temporaneo';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Lease';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase1.status='Bozza';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.status='Bozza';
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID = u.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.status='Bozza';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID = u.id;
            ChildCase4.status='Bozza';
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            
            
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            String contentFile = 'Milano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito1';
            Blob testContentFile = Blob.valueOF(contentFile);
            String csvAsString = testContentFile.toString();
            csvFileLines = csvAsString.split('\n');
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            
            testplan.ParentCaseDisplay=parentCase;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testplan.Indirizzo = 'test';
            testPlan.contentFile = testContentFile;
            testPlan.parentCaseObj = parentCase;
            testPlan.parentCase = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            // contact enservice = testPlan.enableFeasibilityService;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument> qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            // testPlan.parentCaseObj=parentCase;
            testplan.childcasedisplayobj=ChildCase;
            Id quoid = testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            testplan.childcasedisplayid=ChildCase1.Id;
            testplan.redirectchildcasedetail();
            
            testplan.homePageRef();
            testPlan.StatoSelected='Richieste'; 
            testplan.getStatoilist();
            testPlan.StatoSelected='Collegamento'; 
            testplan.getStatoilist();
            testPlan.StatoSelected='Ordine'; 
            testplan.getStatoilist();
            testplan.CostiAttivazione = 0.01;
            testplan.durataaff = 1.10;
            testplan.selectedValueTipo = 'Test';
            testplan.selectedValueStato= 'Test';
            testplan.ShowIndietro = true;
            testplan.childDate= 'Test';
            testplan.ordercasedispayordinedate= 'Test';
            
            Test.stopTest();
        }
    }  
    
    public static testmethod void registrationChildCase15() 
    {   
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        
        
        
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        Id rectyId = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
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
            System.debug('acc===>'+acc);
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.OwnerID=u.id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'Evento Temporaneo';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID=u.id;
            parentCase1.Status='Acquisito';
            parentCase1.EOF_Fase__c='In Verifica BO';
            parentCase1.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase1.PO_Offerta__c = 'Fiber Lease';
            parentCase1.PO_Nome_Progetto__c='test';
            insert parentCase1;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase1.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase1.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            ChildCase.status='Bozza';
            //  insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.status='Bozza';
            ChildCase1.OwnerID=u.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.OwnerID=u.id;
            ChildCase2.status='Bozza';
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.OwnerID = u.id;
            ChildCase3.status='Bozza';
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.OwnerID = u.id;
            ChildCase4.status='Bozza';
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            
            
            
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test'; 
            
            Boolean bool = testPlan.isSuperUser;
            String contentFile = 'Milano,Piaggio,Backhauling,1,Singola Via,Sito 1,Viale Monza,45,Sito1';
            Blob testContentFile = Blob.valueOF(contentFile);
            String csvAsString = testContentFile.toString();
            csvFileLines = csvAsString.split('\n');
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            
            testplan.ParentCaseDisplay=parentCase;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id;
            testplan.Indirizzo = 'test';
            testPlan.contentFile = testContentFile;
            testPlan.parentCaseObj = parentCase;
            testPlan.parentCase = parentCase;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            case parentCaseObjTest = testPlan.parentCaseObj;
            case discase = testPlan.displayCase;
            // contact enservice = testPlan.enableFeasibilityService;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            list<opportunity> oppty1 = testPlan.opp;
            List<QuoteDocument> qutedc = testplan.quoteDoc;
            date dt = testplan.childrecdate;
            // testPlan.parentCaseObj=parentCase;
            testplan.childcasedisplayobj=ChildCase;
            Id quoid = testplan.quoteDocid;
            String qutname = testplan.quoteName;
            String condid = testplan.ContDocId;
            String bsurl = testplan.baseURL;
            testplan.childcasedisplayid=ChildCase1.Id;
            testplan.redirectchildcasedetail();
            
            testplan.homePageRef();
            testPlan.offertaSelected='--Select--'; 
            testplan.getTipodilist();
            testPlan.offertaSelected='Fiber Link'; 
            testplan.getTipodilist();
            testPlan.offertaSelected='IRU'; 
            testplan.getTipodilist();
            testPlan.offertaSelected='P2P Base'; 
            testplan.getTipodilist();
            testPlan.offertaSelected='Fiber Lease'; 
            testplan.getTipodilist();
            testPlan.offertaSelected='Evento Temporaneo'; 
            testplan.getTipodilist();
            testPlan.ServizioTT();
            testPlan.TTList();
            //testPlan.OpportunityStageNameUpdate5();
            testplan.CostiAttivazione = 0.01;
            testplan.durataaff = 1.10;
            testplan.selectedValueTipo = 'Test';
            testplan.selectedValueStato= 'Test';
            testplan.ShowIndietro = true;
            testplan.childDate= 'Test';
            testplan.ordercasedispayordinedate= 'Test';
            
            Test.stopTest();
        }
    }  
    public static testmethod void registration12() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
            ofe.name = 'Status';
            ofe.OF_Enable_Trigger__c = false;
            insert ofe;
            
            OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
            oft.Name = 'Tibco UserID';
            oft.OF_Tibco_ID__c = 'Test';
            insert oft; 
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status='Acquisito';
            //parentCase.PO_CreatedDate__c = 'Test';
            parentCase.PO_Offerta__c = 'IRU';
            parentCase.PO_Note_rifiuto_offerta__c = 'Test';
            parentCase.PO_Note_Modifica_Offerta__c = 'Test';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            ChildCase2.status='Bozza';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            ChildCase4.status='Bozza';
            insert ChildCase4;
            
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            
            
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            testPlan.selectedValueIdPop = 'Test';
            testPlan.selectedValueIdStatoOrdine = 'Test';
            testPlan.selectedCasuale = 'Test';
            testPlan.searchTerm = 'Test';
            testPlan.searchTerm1 = 'Test';
            testPlan.searchTerm2 = 'Test';
            testPlan.IdScelta = 'Test';
            
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Test Opportunity';
            opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
            opportunity.PO_Collegamento__c = ChildCase.id;
            opportunity.PO_Totale_canoni__c = 100.00;
            opportunity.PO_Summary__c = true;
            opportunity.StageName = 'Offerta presentata';
            opportunity.CloseDate = System.today();
            opportunity.PO_Sconto_canone__c = 10;
            opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
            insert opportunity;  
            quote q = new quote(
                name = 'test',
                OpportunityId = opportunity.id
            );
            insert q;
            List<opportunity> testOpp=new List<Opportunity>();
            testOpp.add(Opportunity);
            testPlan.Opp=testOpp;
            testplan.childrecdate=System.Today();
            //testplan.OpportunityStageNameUpdate5();
            ApexPages.currentPage().getParameters().put('id',q.id);
            // testplan.savePDF_FiberLinkPortal();
            testplan.Tabella1IRU(opportunity);
            testplan.Tabella1P2P(opportunity);
            testplan.Tabella1FiberLease(opportunity);
            testplan.Tabella1FiberLeaseMisto(opportunity);
            //testplan.vediReq();
            testplan.ViewCaseDettail();
            ApexPages.currentPage().getParameters().put('editid',ParentCase.Id); 
            testplan.collegmentaDateEdit();
            PO_RegistrationController.searchComune('Test');
            
            testplan.getparentOppty();
            // testplan.getCasualelist();
            /*  Apexpages.currentPage().getParameters().put('Comunicazione','Test');
Apexpages.currentPage().getParameters().put('Causale','Test');
Apexpages.currentPage().getParameters().put('Stato','Test');
Apexpages.currentPage().getParameters().put('DataInizioTT','Test');
Apexpages.currentPage().getParameters().put('DataFineTT','Test');

testplan.runSearchTroubleTicket();

Apexpages.currentPage().getParameters().put('Codice','Test');
Apexpages.currentPage().getParameters().put('TipoRichiesta','Test');
Apexpages.currentPage().getParameters().put('StatoRichiesta','Test');
Apexpages.currentPage().getParameters().put('idPop','Test');
Apexpages.currentPage().getParameters().put('idRisorsa','Test');
Apexpages.currentPage().getParameters().put('DataInizioFilter','Test');
Apexpages.currentPage().getParameters().put('DataFineFilter','Test');
Apexpages.currentPage().getParameters().put('DataInizioOStream','Test');
Apexpages.currentPage().getParameters().put('DataFineOstream','Test');

testplan.runSearchOpenStream(); */
            
            // ApexPages.currentPage().getParameters().put('CaseDetail',ParentCase.Id);
            // testPlan.searchcases();
            Test.stopTest();
        }
    }
    
    public static testmethod void registration13() 
    {
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
            OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
            ofe.name = 'Status';
            ofe.OF_Enable_Trigger__c = false;
            insert ofe;
            
            OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
            oft.Name = 'Tibco UserID';
            oft.OF_Tibco_ID__c = 'Test';
            insert oft; 
            
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
            
            case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
            parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.OwnerID=thisuser.Id;
            parentCase.Status='Acquisito';
            //parentCase.PO_CreatedDate__c = 'Test';
            parentCase.PO_Offerta__c = 'IRU';
            parentCase.PO_Note_rifiuto_offerta__c = 'Test';
            parentCase.PO_Note_Modifica_Offerta__c = 'Test';
            parentCase.EOF_Fase__c='In Verifica BO';
            parentCase.PO_Nome_Progetto__c='test';
            insert parentCase;
            
            case ChildCase = new Case();
            ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
            ChildCase.ContactId = con.id;
            ChildCase.ParentId = parentCase.id;
            ChildCase.accountId = acc.Id;
            ChildCase.PO_Offerta__c = 'Fiber Link';
            ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase.PO_Area_Geografica__c = 'Nord Est';
            ChildCase.PO_Prime_Contractor__c = 'test';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase.PO_Numero_fibre_richieste__c = 'test';
            ChildCase.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase.PO_Note_collegamento__c = 'test';
            //insert ChildCase;
            
            case ChildCase1 = new Case();
            ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
            ChildCase1.ContactId = con1.id;
            ChildCase1.ParentId = parentCase.id;
            ChildCase1.accountId = acc.Id;
            ChildCase1.PO_Offerta__c =  'Fiber Lease';
            ChildCase1.Status='Acquisito';
            ChildCase1.EOF_Fase__c='In Verifica BO';
            ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase1.PO_Area_Geografica__c = 'Nord Est';
            ChildCase1.PO_Prime_Contractor__c = 'test';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase1.PO_Numero_fibre_richieste__c = 'test';
            ChildCase1.PO_Siti_da_collegare__c = 'test';
            ChildCase.PO_Nome_sito__c = 'test';
            ChildCase1.PO_Note_collegamento__c = 'test';
            ChildCase1.status='Bozza';
            insert ChildCase1;
            
            case ChildCase2 = new Case();
            ChildCase2.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
            ChildCase2.ContactId = con.id;
            ChildCase2.status='Bozza';
            ChildCase2.ParentId = parentCase.id;
            ChildCase2.accountId = acc.Id;
            ChildCase2.PO_Offerta__c = 'P2P Base';
            ChildCase2.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase2.PO_Area_Geografica__c = 'Nord Est';
            ChildCase2.PO_Prime_Contractor__c = 'test';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase2.PO_Numero_fibre_richieste__c = 'test';
            ChildCase2.PO_Siti_da_collegare__c = 'test';
            ChildCase2.PO_Nome_sito__c = 'test';
            ChildCase2.PO_Note_collegamento__c = 'test';
            insert ChildCase2;
            
            case ChildCase3 = new Case();
            ChildCase3.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
            ChildCase3.ContactId = con.id;
            ChildCase3.ParentId = parentCase.id;
            ChildCase3.accountId = acc.Id;
            ChildCase3.PO_Offerta__c = 'IRU';
            ChildCase3.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase3.PO_Area_Geografica__c = 'Nord Est';
            ChildCase3.PO_Prime_Contractor__c = 'test';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase3.PO_Numero_fibre_richieste__c = 'test';
            ChildCase3.PO_Siti_da_collegare__c = 'test';
            ChildCase3.PO_Nome_sito__c = 'test';
            ChildCase3.PO_Note_collegamento__c = 'test';
            ChildCase3.status='Bozza';
            insert ChildCase3;
            
            case ChildCase4 = new Case();
            ChildCase4.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
            ChildCase4.ContactId = con.id;
            ChildCase4.status='Bozza';
            ChildCase4.ParentId = parentCase.id;
            ChildCase4.accountId = acc.Id;
            ChildCase4.PO_Offerta__c = 'Evento Temporaneo';
            ChildCase4.PO_Richiesta_a_fattibilit__c = parentCase.id;
            ChildCase4.PO_Area_Geografica__c = 'Nord Est';
            ChildCase4.PO_Prime_Contractor__c = 'test';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Tipo_percorso__c = 'Singola Via';
            ChildCase4.PO_Numero_fibre_richieste__c = 'test';
            ChildCase4.PO_Siti_da_collegare__c = 'test';
            ChildCase4.PO_Nome_sito__c = 'test';
            ChildCase4.PO_Note_collegamento__c = 'test';
            insert ChildCase4;
            list<case> testChildCases=new list<case>();
            testChildCases.add(ChildCase4);
            testChildCases.add(ChildCase3);
            testChildCases.add(ChildCase2);
            
            
            
            
            
            ApexPages.StandardController sc = new ApexPages.StandardController(c);
            
            Test.startTest();
            //AA - 251018
            Test.setCurrentPage(Page.PO_FeasibilityService1);
            PO_RegistrationController testPlan = new PO_RegistrationController(sc);
            PO_RegistrationController testPlanEmpty = new PO_RegistrationController();
            
            PO_RegistrationController.addAdressClass addCls= new PO_RegistrationController.addAdressClass('test','test1');
            addCls.ContactNamelable = 'Test';
            addCls.ContactNameValue = 'Test';
            addCls.ContactNamelable1 = 'Test';
            addCls.ContactNameValue1 = 'Test';
            
            testPlan.selectedValueIdPop = 'Test';
            testPlan.selectedValueIdStatoOrdine = 'Test';
            testPlan.selectedCasuale = 'Test';
            testPlan.searchTerm = 'Test';
            testPlan.searchTerm1 = 'Test';
            testPlan.searchTerm2 = 'Test';
            testPlan.IdScelta = 'Test';
            
            
            Boolean bool = testPlan.isSuperUser;
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');            
            testPlan.fileName = 'unit test';
            testPlan.fileBody = bodyBlob;
            ApexPages.currentPage().getParameters().put('CaseDetail',ChildCase.Id);
            ApexPages.currentPage().getParameters().put('SelParent',ParentCase.Id);
            testPlan.conId = con.Id;
            testplan.accId = acc.Id; 
            testplan.parentCaseObj = parentCase;
            testplan.ChildCaseObj = childCase;
            testPlan.ChildCases=testChildCases;
            List<Contact> conListTest = testPlan.conList;
            String AccountName = testPlan.AccName;
            String SelParentTest = testPlan.SelParent;
            Case parentCaseObjTest = testPlan.parentCaseObj;
            string CaseDetailTest = testPlan.CaseDetail;
            Attachment myAttachmentTest = testPlan.myAttachment;
            Map<Id,String> uploadMapTest = testPlan.uploadMap;
            string str3=testPlan.textarea;
            
            
            
            
            Apexpages.currentPage().getParameters().put('Comunicazione','Test');
            Apexpages.currentPage().getParameters().put('Causale','Test');
            Apexpages.currentPage().getParameters().put('Stato','Test');
            Apexpages.currentPage().getParameters().put('DataInizioTT','Test');
            Apexpages.currentPage().getParameters().put('DataFineTT','Test');
            
            testplan.runSearchTroubleTicket();
            
            Apexpages.currentPage().getParameters().put('Codice','Test');
            Apexpages.currentPage().getParameters().put('TipoRichiesta','Test');
            Apexpages.currentPage().getParameters().put('StatoRichiesta','Test');
            Apexpages.currentPage().getParameters().put('idPop','Test');
            Apexpages.currentPage().getParameters().put('idRisorsa','Test');
            Apexpages.currentPage().getParameters().put('DataInizioFilter','Test');
            Apexpages.currentPage().getParameters().put('DataFineFilter','Test');
            Apexpages.currentPage().getParameters().put('DataInizioOStream','Test');
            Apexpages.currentPage().getParameters().put('DataFineOstream','Test');
            
            testplan.runSearchOpenStream();
            
            
            Apexpages.currentPage().getParameters().put('Offerta','Test');
            testplan.Offertaselect();
            
            Test.stopTest();
        }
    }  
   /* 
    public static testMethod void CodeCoverage(){
        test.starttest();
        PO_RegistrationController.CodeCoverage(2);
        PO_RegistrationController reg = new PO_RegistrationController();
        reg.viewDettaglioIncident();
        reg.ServizioChangeOrder();
        reg.viewStatoOrdine();
        reg.ViewCaseDettail();
        test.stoptest();   
    }
*/
    
}
@isTest
public class PO_Serv_Circuiti_Diretti_Controller_Test {
    
     static testMethod void testMethod1() 
    {
        Account acc = PO_ServFatt_DataFactory.createAccount('Ambrogio','VF');
        
         Contact c = new Contact();
        c.AccountId = acc.Id;
        c.LastName='caramella';
        c.FirstName='andonio';
        insert c;
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Partner Community Super User'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            contactId = c.id
        );
        
        insert u;
        
       
        EOF_EAI_Service_Log__c serv2= new EOF_EAI_Service_Log__c();
        Id rtId = [select id from RecordType where developerName= 'PO_Log_CircuitiDiretti_Request'].id;
        //serv2.EOF_Stato_Richiesta__c='In Lavorazione';
        serv2.EOF_Stato_Richiesta__c='Bozza';
        serv2.EOF_Codice_Operatore__c= 'VF';
        insert serv2;
        
       
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();     
        
        Case theCase = new Case();
        insert theCase;
           
        system.runAs(u){
        Test.startTest();         
        PageReference pageRef = Page.PO_Serv_Circuiti_Diretti_NuovaRichiesta;
        
        //pageRef.getParameters().put('DataInizioCreazione', Datetime.now().format('yyyy-MM-dd'));
        //pageRef.getParameters().put('DataFineCreazione', Datetime.now().format('yyyy-MM-dd'));
        pageRef.getParameters().put('DataInizioCreazione', '');
        pageRef.getParameters().put('DataFineCreazione', '');
        
        pageRef.getParameters().put('valRich', 'testing');
        pageRef.getParameters().put('valOff', 'testing');
        pageRef.getParameters().put('valNomP', 'testing');                                         
        Test.setCurrentPage(pageRef);                 
        
        PO_Serv_Circuiti_Diretti_Controller theController = new PO_Serv_Circuiti_Diretti_Controller(); 
        
        theController.pageRecordBozze = 0;
        theController.tipoRIchiesta = 'Attivazione';        
        theController.testcase = theCase;
        
        theController.listInserite = new List<EOF_EAI_Service_Log__c>();
        theController.listInserite.add(theLog);
        
        theController.filtered = true;
        theController.pageActual = 1;
        theController.totalpage = 2;
        
        theController.pageActualBozze = 2;
        theController.totalpageBozze = 3;
        
        theController.parentCase = new Case();
        theController.collCase = new Case();
        theController.orderCase = new Case();
        
        theController.fattCaseList = new List<Case>();
    	theController.collCaseList = new List<Case>();
    	theController.ordCaseList = new List<Case>();
            
        //
        theController.parentLog=new EOF_EAI_Service_Log__c();
       	theController.collLog=new EOF_EAI_Service_Log__c();
        theController.ordLog=new EOF_EAI_Service_Log__c();
        theController.parentCaseObj=new Case();
          
        
        theController.searchTerm = 'testing';
        theController.selectedIdComune = 'testing';
        theController.searchTerm1 = 'testing';
        theController.selectedIdComune1 = 'testing';
        theController.searchTerm2 = 'testing';
        theController.selectedIdComune2 = 'testing';
                
        PO_Serv_DarkFiber_Controller.searchComune('testing'); 
        PO_Serv_DarkFiber_Controller.searchComune1('testing');
        PO_Serv_DarkFiber_Controller.searchComune2('testing');
        
        //theController.uploadCSV();
        theController.childCase();
        //theController.DeleteParentCase();
        theController.pageUp();
        theController.pageDown();
        
        theController.setPagination(null);
        theController.setPagination(true);
        theController.setPagination(false);        
        
        theController.setPaginationBozze(null); 
        theController.setPaginationBozze(true); 
        theController.setPaginationBozze(false); 
        
        theController.preparePage();
        theController.preparePageBozze();
        
        theController.runSearch();
        theController.runQuery();
        //theController.vediReqBozza();
        theController.vediReqInserita();
        theController.fetchList();
        
        theController.nuovaRichiesta();
        theController.richiesteInserite();
        
       // theController.uploadCSV();
        //theController.DeleteParentCase();
        
        Test.stopTest();  
            
       theController.DeleteParentCase();
        }
        }
    
    @isTest
    private static void searchComuneTest(){
        OF_ElencoComuniItaliani__c eci=new OF_ElencoComuniItaliani__c();
        eci.OF_Comune__c='test';
        eci.OF_CodiceIstat__c='test';
        insert eci;
        
        
        
        String searchTerm='test';
        test.startTest();
        PO_Serv_Circuiti_Diretti_Controller.searchComune(searchTerm);
        test.stopTest();
    }
    
    @isTest
    private static void searchComuneTest2(){
        
        OF_ElencoComuniItaliani__c eci=new OF_ElencoComuniItaliani__c();
        eci.OF_Comune__c='test';
        eci.OF_CodiceIstat__c='test';
        insert eci;
        
        
        
        String searchComune1='test';
        test.startTest();
        PO_Serv_Circuiti_Diretti_Controller.searchComune(searchComune1);
        test.stopTest();
    }
    
    @isTest
    private static void searchComune1Test(){
        
        OF_ElencoComuniItaliani__c eci=new OF_ElencoComuniItaliani__c();
        eci.OF_Comune__c='test';
        eci.OF_CodiceIstat__c='test';
        insert eci;
        
        
        
        String searchComune1='test';
        test.startTest();
        PO_Serv_Circuiti_Diretti_Controller.searchComune1(searchComune1);
        test.stopTest();
    }
    
    
    @isTest
    private static void searchComune2Test(){
        
        OF_ElencoComuniItaliani__c eci=new OF_ElencoComuniItaliani__c();
        eci.OF_Comune__c='test';
        eci.OF_CodiceIstat__c='test';
        insert eci;
        
        
        
        String searchComune1='test';
        test.startTest();
        PO_Serv_Circuiti_Diretti_Controller.searchComune2(searchComune1);
        test.stopTest();
    }

@isTest
    private static void optionApexTest(){
         String s='test';
        String t='test';
        test.startTest();
        PO_Serv_Circuiti_Diretti_Controller.optionApex istanza= new PO_Serv_Circuiti_Diretti_Controller.optionApex(s,t);
       test.stopTest();
        
        
    }    
    
    @isTest
    private static void testMethod2(){
        
        Account acc=new Account();
        acc.EOF_Codice_Operatore__c='VF';
        acc.name='test';
        insert acc;
        
        Contact c=new Contact();
        c.AccountId=acc.Id;
        c.FirstName='mario';
        c.LastName='rossi';
        insert c;
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Partner Community Super User'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            contactId = c.id
        );
        
        
        EOF_EAI_Service_Log__c log=new EOF_EAI_Service_Log__c();
        log.RecordTypeId=[Select id From RecordType Where DeveloperName='PO_Log_CircuitiDiretti_Request'].ID;
        log.EOF_Stato_Richiesta__c='test';
        log.EOF_Codice_Operatore__c='VF';
        log.EOF_STATO_ORDINE__c='Acquisito';
        insert log;
        
        System.runAs(u){  
            
            PO_Serv_Circuiti_Diretti_Controller controller= new PO_Serv_Circuiti_Diretti_Controller();
            
        }
      
    }
    
    }
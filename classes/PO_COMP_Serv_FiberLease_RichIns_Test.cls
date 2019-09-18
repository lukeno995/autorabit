@isTest
public class PO_COMP_Serv_FiberLease_RichIns_Test {
	static testMethod void testMethod1() 
    {	
        Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }
        
        Test.startTest();    
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test'; 
        testParentLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Request');
        testParentLog.EOF_Stato_Richiesta__c ='test';
        testParentLog.EOF_Codice_Operatore__c =
        [select Id,AccountId,Account.EOF_Codice_Operatore__c,ContactId,Contact.AccountId from user where Id=:userinfo.getUserId()].Account.EOF_Codice_Operatore__c;
        insert testParentLog;               
        
        
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();     
        
        Case theCase = new Case();
        insert theCase;
                
        PageReference pageRef = Page.PO_Serv_FiberLease_Richieste;
        
        //pageRef.getParameters().put('DataInizioCreazione', Datetime.now().format('yyyy-MM-dd'));
        //pageRef.getParameters().put('DataFineCreazione', Datetime.now().format('yyyy-MM-dd'));
        pageRef.getParameters().put('DataInizioCreazione', '');
        pageRef.getParameters().put('DataFineCreazione', '');
        
        pageRef.getParameters().put('valRich', 'testing');
        pageRef.getParameters().put('valOff', 'testing');
        pageRef.getParameters().put('valNomP', 'testing');                                         
        Test.setCurrentPage(pageRef);                 
        
        PO_COMP_Serv_FiberLease_RichIns_cntr theController = new PO_COMP_Serv_FiberLease_RichIns_cntr(); 
        
        
        theController.tipoRIchiesta = 'Attivazione';        
        theController.testcase = theCase;
        
        theController.listInserite = new List<EOF_EAI_Service_Log__c>();
        theController.listInserite.add(theLog);
        
        theController.filtered = true;
        theController.pageActual = 1;
        theController.totalpage = 2;
        
        
        
        theController.parentCase = new Case();
        theController.collCase = new Case();
        theController.orderCase = new Case();
        
        theController.fattCaseList = new List<Case>();
    	theController.collCaseList = new List<Case>();
    	theController.ordCaseList = new List<Case>();
        
        theController.searchTerm = 'testing';
        theController.selectedIdComune = 'testing';
        theController.searchTerm1 = 'testing';
        theController.selectedIdComune1 = 'testing';
        theController.searchTerm2 = 'testing';
        theController.selectedIdComune2 = 'testing';
                
        PO_COMP_Serv_FiberLease_RichIns_cntr.searchComune('testing'); 
        PO_COMP_Serv_FiberLease_RichIns_cntr.searchComune1('testing');
        PO_COMP_Serv_FiberLease_RichIns_cntr.searchComune2('testing');
        
        //theController.uploadCSV();
        theController.childCase();
        //theController.DeleteParentCase();
        theController.pageUp();
        theController.pageDown();
        
        theController.setPagination(null);
        theController.setPagination(true);
        theController.setPagination(false);        
        
         
        
        theController.preparePage();
        
        
        theController.runSearch();
        theController.runQuery();
        
        theController.vediReqInserita();
        theController.fetchList();
        
        
        
        theController.uploadCSV();
        //theController.DeleteParentCase();
        
        Test.stopTest();
    }
}
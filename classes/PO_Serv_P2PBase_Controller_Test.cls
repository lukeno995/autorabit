@isTest
private class PO_Serv_P2PBase_Controller_Test {
    
static testMethod void testMethod1() 
    {
        Test.startTest();    
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();     
        
        Case theCase = new Case();
        insert theCase;
                
        PageReference pageRef = Page.PO_Serv_P2PBase_NuovaRichiesta;
        
        //pageRef.getParameters().put('DataInizioCreazione', Datetime.now().format('yyyy-MM-dd'));
        //pageRef.getParameters().put('DataFineCreazione', Datetime.now().format('yyyy-MM-dd'));
        pageRef.getParameters().put('DataInizioCreazione', '');
        pageRef.getParameters().put('DataFineCreazione', '');
        
        pageRef.getParameters().put('valRich', 'testing');
        pageRef.getParameters().put('valOff', 'testing');
        pageRef.getParameters().put('valNomP', 'testing');                                         
        Test.setCurrentPage(pageRef);                 
        
        PO_Serv_P2PBase_Controller theController = new PO_Serv_P2PBase_Controller(); 
        
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
        
        theController.searchTerm = 'testing';
        theController.selectedIdComune = 'testing';
        theController.searchTerm1 = 'testing';
        theController.selectedIdComune1 = 'testing';
        theController.searchTerm2 = 'testing';
        theController.selectedIdComune2 = 'testing';
                
        PO_Serv_P2PBase_Controller.searchComune('testing'); 
        PO_Serv_P2PBase_Controller.searchComune1('testing');
        PO_Serv_P2PBase_Controller.searchComune2('testing');
        
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
        theController.vediReqBozza();
        theController.vediReqInserita();
        theController.fetchList();
        
        theController.nuovaRichiesta();
        theController.richiesteInserite();
        
        theController.uploadCSV();
        //theController.DeleteParentCase();
        
        Test.stopTest();
    }

    
static testMethod void testMethod2() 
    {
        Test.startTest();    
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();     
        
        Case theCase = new Case();
        insert theCase;
                
        PageReference pageRef = Page.PO_Serv_P2PBase_NuovaRichiesta;
        
        //pageRef.getParameters().put('DataInizioCreazione', Datetime.now().format('yyyy-MM-dd'));
        //pageRef.getParameters().put('DataFineCreazione', Datetime.now().format('yyyy-MM-dd'));
        pageRef.getParameters().put('DataInizioCreazione', '');
        pageRef.getParameters().put('DataFineCreazione', '');
        
        pageRef.getParameters().put('valRich', 'testing');
        pageRef.getParameters().put('valOff', 'testing');
        pageRef.getParameters().put('valNomP', 'testing'); 
        
       // pageRef.getParameters().put('selectValueL2',JSON.serialize('In Lavorazione'));
        Test.setCurrentPage(pageRef);                 
        
        PO_Serv_P2PBase_Controller theController = new PO_Serv_P2PBase_Controller(); 
        
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
        
        theController.searchTerm = 'testing';
        theController.selectedIdComune = 'testing';
        theController.searchTerm1 = 'testing';
        theController.selectedIdComune1 = 'testing';
        theController.searchTerm2 = 'testing';
        theController.selectedIdComune2 = 'testing';
                
        PO_Serv_P2PBase_Controller.searchComune('testing'); 
        PO_Serv_P2PBase_Controller.searchComune1('testing');
        PO_Serv_P2PBase_Controller.searchComune2('testing');
        
        //theController.uploadCSV();
        theController.childCase();
        //theController.DeleteParentCase();
        theController.pageUp();
        theController.pageDown();
        
        theController.setPagination(null);
        theController.setPagination(true);
        theController.setPagination(false);        
        
        //theController.setPaginationBozze(null); 
        theController.setPaginationBozze(true); 
        //theController.setPaginationBozze(false); 
        
        theController.preparePage();
        theController.preparePageBozze();
        
        theController.runSearch();
        theController.runQuery();
        theController.vediReqBozza();
        theController.vediReqInserita();
        theController.fetchList();
        
        theController.nuovaRichiesta();
        theController.richiesteInserite();
        
        theController.uploadCSV();
        //theController.DeleteParentCase();
        
        Test.stopTest();
    }
}
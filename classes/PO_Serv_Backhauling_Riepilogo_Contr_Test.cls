@isTest
private class PO_Serv_Backhauling_Riepilogo_Contr_Test
{
    public static testMethod void testInviaRichiesta2() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createBTSData();
        Test.startTest();
        PO_Serv_Backhauling_Riepilogo_Controller ctrl = new PO_Serv_Backhauling_Riepilogo_Controller();
        ctrl.parentLogObj = data.logRichiesta;
        ctrl.accId = data.casePadre.AccountId;
        ctrl.slListToDelete = new List<EOF_EAI_Service_Log__c>();
        ctrl.BackhaulingLogList = new List<EOF_EAI_Service_Log__c>{data.logCollegamento};
        
        ctrl.InviaRichiesta();
        ctrl.InviaRichiesta_2();
        
        Test.stopTest();
    }
    
    public static testMethod void testFast() {
        Test.startTest();
        PO_Serv_Backhauling_Riepilogo_Controller ctrl = new PO_Serv_Backhauling_Riepilogo_Controller();
        
        ctrl.creaCaseKit(new List<EOF_EAI_Service_Log__c>());
        ctrl.deleteVoidKitLog();
        Test.stopTest();
    }
    
    @isTest static void testMethod1() 
    {
        Case fakeCase = new Case(); 
        insert(fakeCase);
        
         
        Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }
        
        Test.startTest();
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
        
		//prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');         
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        insert testParentCase; 
        
        EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test';  
        testParentLog.Caso__c = testParentCase.Id;
        insert testParentLog;               
        
        EOF_EAI_Service_Log__c testCollegamentoLog = new EOF_EAI_Service_Log__c();
        testCollegamentoLog.RecordTypeId = theRecordTypes.get('PO_Log_Backhauling_Collegamento'); 
        testCollegamentoLog.EOF_Codice_Ordine_OLO__c = 'test';
        testCollegamentoLog.EOF_SL_Riferimento__c = testParentLog.Id;
        insert testCollegamentoLog;        
        
        EOF_EAI_Service_Log__c testOrdineLog = new EOF_EAI_Service_Log__c(); 
        testOrdineLog.RecordTypeId = theRecordTypes.get('PO_Log_Backhauling_Ordine'); 
        testOrdineLog.EOF_Codice_Ordine_OLO__c = 'test';
        testOrdineLog.EOF_SL_Riferimento__c = testCollegamentoLog.Id;
        insert testOrdineLog;                                   
        
        PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));        
        pageRef.getParameters().put('recordOfferta', 'Backhauling');  
        pageRef.getParameters().put('CaseDetail', testParentLog.Id);           
        Test.setCurrentPage(pageRef);
                
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();    
        
        theController.sortLogs=new List<EOF_EAI_Service_Log__c>();
        theController.currentUserLogs= new List<EOF_EAI_Service_Log__c>();
        theController.caseObj=fakeCase;
        theController.logObj=new EOF_EAI_Service_Log__c();
        theController.kLogObj=new EOF_EAI_Service_Log__c();
        theController.displayCase=fakeCase;
        theController.displayLog=new EOF_EAI_Service_Log__c();
        theController.searchTerm='';
        theController.comune='';
        theController.ordercaselst=new List<case>();
        theController.orderLoglst=new list<EOF_EAI_Service_Log__c>();
        theController.childDate='';
        theController.ordLogDetail='';
        theController.logDetail='';
        theController.ordercasedispayordinedate='';
        theController.orderLogdispayordinedate='';
        theController.stringdate_In_PO_ModalController='';
        theController.orderLogEdit= new EOF_EAI_Service_Log__c();
        theController.childrecdate=date.today();
        theController.orderline=false;
        theController.testlog=new list<EOF_EAI_Service_Log__c>();
        theController.ParentDate='';
        theController.childcasedisplayid=fakeCase.id;
        theController.childlogdisplayid=fakeCase.id;
        theController.ordLogId=fakeCase.id;
        theController.collOrdLogID=fakeCase.Id;
        theController.childcasedisplayobj=fakeCase;
        theController.childlogdisplayobj=new EOF_EAI_Service_Log__c();
        theController.IndirizzoCliente='';
        theController.childoppobj=new Opportunity();
        theController.childlogdisplayattlist=new list<Attachment>();
        theController.parentOppty=new Opportunity();
        theController.childOppty= new Opportunity();
        theController.orderId=fakeCase.id;
        theController.sl=new EOF_EAI_Service_Log__c();
    
        
        
        
        
        
        
        
        
        
        
        
        
        theController.CaseDetail = testParentCase.Id;
        
        theController.childLogObj = testCollegamentoLog;
        
        //theController. testParentCase.Id;
        
        theController.ParentDataOrderUpdation();
        theController.SearchLog();
        theController.runSearchProfilo();
        theController.currentUserParentCases();
        //theController.currentUserParentLogs();
        theController.getsortingCases();
        //theController.getsortingLogs();
        
        //theController.OpportunityStageNameUpdate(); 
        
        
        //theController.OrderCreation();    
        
        
        theController.EditOrderInfo();
        
        theController.DetailPage();
        theController.checkStageName();
        
        theController.createChildLog();
        
        Case anOtherCase = new Case();
        
        //prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');        
        
        anOtherCase.PO_Offerta__c = 'Backhauling';
        insert anOtherCase;
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c(); 
        anOtherLog.Caso__c = anOtherCase.Id; 
        insert anOtherLog;
        
        PageReference pageRef2 = Page.PO_Serv_Backhauling_Riepilogo;        
        pageRef2.getParameters().put('CaseDetail', testParentCase.Id);           
        pageRef2.getParameters().put('Id', testParentCase.Id); 
        pageRef2.getParameters().put('editid', testParentCase.Id);   
        pageRef2.getParameters().put('parentId', anOtherLog.Id);    
        Test.setCurrentPage(pageRef2);
        
        theController.testcase = testParentCase;
        
        theController.DisplayCaseInfo();        
        theController.childCase();        
        theController.collegmentaDateEdit();        
        theController.SaveParentChildCaseInfo();                 
                
        //theController.deleteLog();   da scommentare
        
        Test.stopTest();  
    }
    
    @isTest static void testMethod2() 
    {
        Test.startTest();
        
		Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }        
        
		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);        
        
		Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test';   
        
		//prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');               
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        insert testParentCase; 

		Case anOtherCase = new Case();
        anOtherCase.PO_Offerta__c = 'Backhauling';
        
		//prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');               
        
        insert anOtherCase;        
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c(); 
        anOtherLog.Caso__c = anOtherCase.Id; 
        insert anOtherLog;        
        
		PageReference pageRef2 = Page.PO_Serv_Backhauling_Riepilogo;        
        pageRef2.getParameters().put('CaseDetail', testParentCase.Id);           
        pageRef2.getParameters().put('Id', testParentCase.Id); 
        pageRef2.getParameters().put('editid', testParentCase.Id);   
        pageRef2.getParameters().put('parentId', anOtherLog.Id);    
        Test.setCurrentPage(pageRef2);                        
                
        Case caseOpportunity = new Case();
        insert caseOpportunity;        
        
        Opportunity theOpportunity = new Opportunity();
        theOpportunity.PO_Collegamento__c = null;
        theOpportunity.PO_Richiesta_fattibilit__c = caseOpportunity.Id;
        theOpportunity.Name = 'testing';
        theOpportunity.StageName = 'open';
        theOpportunity.CloseDate = Date.today();                        
        insert theOpportunity;          
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();   
                               
        theController.testcase = testParentCase;        
                              
        theController.parentLogObj.Caso__c = caseOpportunity.Id;
        
        //
        Account theAccount = new Account();
        theAccount.Name = 'testing';
        insert theAccount;
        
        Contract theContratto = new Contract();        
        theContratto.StartDate = Date.today().addDays(-2);
        theContratto.accountId = theAccount.Id;
        theContratto.ContractTerm = 2;
        theContratto.Status = 'Attivo';
        insert theContratto;
        
        theContratto.OF_IdContratto__c = theContratto.Id;
        update theContratto;
        
        theController.parentLogObj.PO_Accordo_Quadro_Number__c = theContratto.Id;
        
        theController.OpportunityStageNameUpdate();                
        
        Test.stopTest();  
    }
    
    @isTest static void testMethod3() 
    {
        Test.startTest();
        
		Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }        
        
		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);        
        
		Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test';   
        testParentCase.PO_Offerta__c = 'Backhauling';
        
		//prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');         
        
        insert testParentCase; 

		Case anOtherCase = new Case();
        anOtherCase.PO_Offerta__c = 'Backhauling';
        
		//prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');           
        
        insert anOtherCase;        
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c(); 
        anOtherLog.Caso__c = anOtherCase.Id; 
        insert anOtherLog;        
        
		PageReference pageRef2 = Page.PO_Serv_Backhauling_Riepilogo;        
        pageRef2.getParameters().put('CaseDetail', testParentCase.Id);           
        pageRef2.getParameters().put('Id', testParentCase.Id); 
        pageRef2.getParameters().put('editid', testParentCase.Id);   
        pageRef2.getParameters().put('parentId', anOtherLog.Id);    
        Test.setCurrentPage(pageRef2);                        
                
        Case caseOpportunity = new Case();
        insert caseOpportunity;        
        
        Opportunity theOpportunity = new Opportunity();
        theOpportunity.PO_Collegamento__c = null;
        theOpportunity.PO_Richiesta_fattibilit__c = caseOpportunity.Id;
        theOpportunity.Name = 'testing';
        theOpportunity.StageName = 'Offerta presentata';
        theOpportunity.CloseDate = Date.today();                        
        insert theOpportunity;          
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();   
                               
        theController.testcase = testParentCase;        
                              
        theController.parentLogObj.Caso__c = caseOpportunity.Id;        

        theController.BackhaulingLogList.add(anOtherLog);        
        
        theController.OpportunityStageNameUpdate2();
        
        Test.stopTest();  
    }       
    
    @isTest static void testMethod5() 
    {
        Test.startTest();
        
		Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }        
        
		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);        
        
		Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test';   
        
		//prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');            
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        insert testParentCase; 

		Case anOtherCase = new Case();
        anOtherCase.PO_Offerta__c = 'Backhauling';
        
		//prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');           
        
		anOtherCase.PO_Data_Attivazione_Ordine__c = Date.today();        
        
        insert anOtherCase;        
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c(); 
        anOtherLog.Caso__c = anOtherCase.Id;                         
        insert anOtherLog;        
        
		PageReference pageRef2 = Page.PO_Serv_Backhauling_Riepilogo;        
        pageRef2.getParameters().put('CaseDetail', anOtherLog.Id);           
        pageRef2.getParameters().put('Id', testParentCase.Id); 
        pageRef2.getParameters().put('editid', testParentCase.Id);   
        pageRef2.getParameters().put('parentId', anOtherLog.Id);    
        Test.setCurrentPage(pageRef2);                        
                
        Case caseOpportunity = new Case();
        insert caseOpportunity;        
        
        Opportunity theOpportunity = new Opportunity();
        theOpportunity.PO_Collegamento__c = null;
        theOpportunity.PO_Richiesta_fattibilit__c = caseOpportunity.Id;
        theOpportunity.Name = 'testing';
        theOpportunity.StageName = 'Offerta presentata';
        theOpportunity.CloseDate = Date.today();                        
        insert theOpportunity;          
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();   
                               
        theController.testcase = testParentCase;        
                              
        theController.parentLogObj.Caso__c = caseOpportunity.Id;   
        
        theController.CaseDetail = anOtherCase.Id;                
        
        theController.EditOrderInfo();
        
        Test.stopTest();  
    }  
    
    
    
    @isTest static void testMethod4() 
    {
        Test.startTest();
        
        Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }            
        
		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);        
        
		Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test'; 
        
		//prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');           
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        insert testParentCase; 

		Case anOtherCase = new Case();
        anOtherCase.PO_Offerta__c = 'Backhauling';
        
		//prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');         
        
        anOtherCase.PO_Incluso_nell_offerta__c = true;
        anOtherCase.parentid = testParentCase.Id;
        insert anOtherCase;        
        
        
        String collegamentoRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO Log Backhauling Collegamento').getRecordTypeId();
        

        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c(); 
        anOtherLog.Caso__c = anOtherCase.Id; 
        anOtherLog.recordTypeId = collegamentoRecordType; 
        insert anOtherLog;        
        
		PageReference pageRef2 = Page.PO_Serv_Backhauling_Riepilogo;        
        pageRef2.getParameters().put('CaseDetail', testParentCase.Id);           
        pageRef2.getParameters().put('Id', testParentCase.Id); 
        pageRef2.getParameters().put('editid', testParentCase.Id);   
        pageRef2.getParameters().put('parentId', anOtherLog.Id);    
        Test.setCurrentPage(pageRef2);                        
                
        Case caseOpportunity = new Case();
        insert caseOpportunity;        
        
        Opportunity theOpportunity = new Opportunity();
        theOpportunity.PO_Collegamento__c = null;
        theOpportunity.PO_Richiesta_fattibilit__c = caseOpportunity.Id;
        theOpportunity.Name = 'testing';
        theOpportunity.StageName = 'open';
        theOpportunity.CloseDate = Date.today();                        
        insert theOpportunity;          
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();   
                               
        theController.testcase = testParentCase;        
                              
        theController.parentLogObj.Caso__c = caseOpportunity.Id;
        
        List<Case> casesFromPortal = new List<Case>();
        
        Case aCaseFromPortal = new Case();
        aCaseFromPortal.parentId = anOtherCase.Id;        
        insert aCaseFromPortal;
        
        casesFromPortal.add(aCaseFromPortal);
        
        theController.parentCaseObj = new Case();                                                            
        
        EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test';  
        testParentLog.Caso__c = testParentCase.Id;
        insert testParentLog;           
        
        EOF_EAI_Service_Log__c testCollegamentoLog = new EOF_EAI_Service_Log__c();
        testCollegamentoLog.RecordTypeId = theRecordTypes.get('PO_Log_Backhauling_Collegamento'); 
        testCollegamentoLog.EOF_Codice_Ordine_OLO__c = 'test';
        testCollegamentoLog.EOF_SL_Riferimento__c = testParentLog.Id;
        
        testCollegamentoLog.Caso__c = anOtherCase.Parentid;
        
        insert testCollegamentoLog;        
        
        EOF_EAI_Service_Log__c testOrdineLog = new EOF_EAI_Service_Log__c(); 
        testOrdineLog.RecordTypeId = theRecordTypes.get('PO_Log_Backhauling_Ordine'); 
        testOrdineLog.EOF_Codice_Ordine_OLO__c = 'test';
        testOrdineLog.EOF_SL_Riferimento__c = testCollegamentoLog.Id;
        insert testOrdineLog;                                   
        
        PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));        
        pageRef.getParameters().put('recordOfferta', 'Backhauling');  
        pageRef.getParameters().put('CaseDetail', testParentLog.Id);   
 		pageRef.getParameters().put('OffUploaded', 'string');        
        Test.setCurrentPage(pageRef);        
        
        theController.OrderCreation(casesFromPortal);                
        
        Test.stopTest();  
    }        
                
    @isTest static void testMethod6() 
    {
        Test.startTest();
        
        Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }           
        
		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);        
        
		Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test';   
        
		//prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');         
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        insert testParentCase; 

		Case anOtherCase = new Case();
        anOtherCase.PO_Offerta__c = 'Backhauling';
        
		//prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');         
        
        insert anOtherCase;        
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c(); 
        anOtherLog.Caso__c = anOtherCase.Id; 
        insert anOtherLog;        
        
		PageReference pageRef2 = Page.PO_Serv_Backhauling_Riepilogo;        
        pageRef2.getParameters().put('CaseDetail', testParentCase.Id);           
        pageRef2.getParameters().put('Id', testParentCase.Id); 
        pageRef2.getParameters().put('editid', testParentCase.Id);   
        pageRef2.getParameters().put('parentId', anOtherLog.Id);    
        Test.setCurrentPage(pageRef2);                        
                
        Case caseOpportunity = new Case();
        insert caseOpportunity;        
        
        Opportunity theOpportunity = new Opportunity();
        theOpportunity.PO_Collegamento__c = null;
        theOpportunity.PO_Richiesta_fattibilit__c = caseOpportunity.Id;
        theOpportunity.Name = 'testing';
        theOpportunity.StageName = 'Offerta presentata';
        theOpportunity.CloseDate = Date.today();                        
        insert theOpportunity;                         
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();   
        
        theController.opp = new list<opportunity>();
        theController.opp.add(theOpportunity);
                               
        theController.testcase = testParentCase;        
                              
        theController.parentLogObj.Caso__c = caseOpportunity.Id;    
        
        theController.parentCaseObj = caseOpportunity;
        
        
        theController.OpportunityStageNameUpdate3a();         
        
        Test.stopTest();  
    }  
        
    @isTest static void testMethod7() 
    {
        Test.startTest();
        
        Account theAccount = new Account();
        theAccount.Name = 'testing';
        insert theAccount;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();        
        catalogo.OF_DataFineValidita__c = Date.today();
        catalogo.OF_DataInizioValidita__c = Date.today();             
        insert catalogo;
        
        OF_Servizio__c theServizio = new OF_Servizio__c();
        theServizio.Name = 'Backhauling';     
                        
        theServizio.OF_CatalogoCommerciale__c = catalogo.Id;
        theServizio.OF_DataFineValidita__c = Date.today();
        theServizio.OF_DataInizioValidita__c = Date.today();
        
        insert theServizio;
        
        Contract theContratto = new Contract();
        theContratto.AccountId = theAccount.Id;
        theContratto.StartDate = Date.today().addDays(-2);
        theContratto.ContractTerm = 2;
        theContratto.Status = 'Attivo';
        insert theContratto;
        
        OF_ContrattoServizio__c theContrattoServizio = new OF_ContrattoServizio__c(); 
        theContrattoServizio.OF_Contract__c = theContratto.Id;
        theContrattoServizio.OF_Servizio__c = theServizio.Id;
        insert theContrattoServizio;
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();   
        theController.checkVendibilitaRichiesta(theAccount.Id, 'Backhauling');
        
        Test.stopTest();  
    }  
    
    @isTest static void testMethod8() 
    {
        Test.startTest();                
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();          
        insert anOtherLog;   
        
		PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('parentId', anOtherLog.Id);                  
        Test.setCurrentPage(pageRef);        
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();   
        
        theController.parentLogObj = anOtherLog;                
        
        theController.AddParentAttachment();
        theController.inserisciNuovoCollegamento();
        
        Test.stopTest();  
    }     
        
    @isTest static void testMethod9() 
    {
        Test.startTest();                
        
        Account theAccount = new Account();
        theAccount.Name = 'testing';
        insert theAccount;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();        
        catalogo.OF_DataFineValidita__c = Date.today();
        catalogo.OF_DataInizioValidita__c = Date.today();             
        insert catalogo;
        
        OF_Servizio__c theServizio = new OF_Servizio__c();
        theServizio.Name = 'Backhauling';     
                        
        theServizio.OF_CatalogoCommerciale__c = catalogo.Id;
        theServizio.OF_DataFineValidita__c = Date.today();
        theServizio.OF_DataInizioValidita__c = Date.today();
        
        insert theServizio;
        
        Contract theContratto = new Contract();
        theContratto.AccountId = theAccount.Id;
        theContratto.StartDate = Date.today().addDays(-2);
        theContratto.ContractTerm = 2;
        theContratto.Status = 'Attivo';
        insert theContratto;
        
        OF_ContrattoServizio__c theContrattoServizio = new OF_ContrattoServizio__c(); 
        theContrattoServizio.OF_Contract__c = theContratto.Id; 
        theContrattoServizio.OF_Servizio__c = theServizio.Id;
        insert theContrattoServizio;    
        
        OF_AreaGeograficaJunction__c areaGeografica = new OF_AreaGeograficaJunction__c(); 
        areaGeografica.OF_Contratto__c = theContratto.Id;
        areaGeografica.OF_Comune__c = 'Roma';
        insert areaGeografica;
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();    
        
        theController.checkVendibilitaRichiesta(theAccount.Id, 'Backhauling');
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();
        theLog.EOF_Comune__c = 'Roma';
        insert theLog;
        
        theController.BackhaulingLogList = new List<EOF_EAI_Service_Log__c>();
        theController.BackhaulingLogList.add(theLog);
        
        theController.InviaRichiesta_2();        
        
        Test.stopTest();  
    }
    
	@isTest static void testMetho10() 
    {
        Test.startTest();  
        
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
        Case aCase = new Case();
        insert aCase;
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();  
        anOtherLog.Caso__c = aCase.Id;        
        insert anOtherLog;  
        
        Opportunity theOpportunity = new Opportunity();
        theOpportunity.PO_Collegamento__c = null;
        theOpportunity.PO_Richiesta_fattibilit__c = aCase.Id;
        theOpportunity.Name = 'testing';
        theOpportunity.StageName = 'Offerta presentata';
        theOpportunity.CloseDate = Date.today();                        
        insert theOpportunity; 
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();  
        
        theController.parentLogObj = anOtherLog;
        
        theController.OpportunityStageNameUpdate3();
        theController.redirectparentlogdetail();
        
        Test.stopTest();
    }
     @isTest static void testMethod11() 
    {
      
        
         
        Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }
        
        Test.startTest();
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test';                  
        
        //prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');         
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        insert testParentCase; 
        
        EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test';  
        testParentLog.Caso__c = testParentCase.Id;
        insert testParentLog;               
        
        EOF_EAI_Service_Log__c testCollegamentoLog = new EOF_EAI_Service_Log__c();
        testCollegamentoLog.RecordTypeId = theRecordTypes.get('PO_Log_Backhauling_Collegamento'); 
        testCollegamentoLog.EOF_Codice_Ordine_OLO__c = 'test';
        testCollegamentoLog.EOF_SL_Riferimento__c = testParentLog.Id;
        insert testCollegamentoLog;        
        
        EOF_EAI_Service_Log__c testOrdineLog = new EOF_EAI_Service_Log__c(); 
        testOrdineLog.RecordTypeId = theRecordTypes.get('PO_Log_Backhauling_Ordine'); 
        testOrdineLog.EOF_Codice_Ordine_OLO__c = 'test';
        testOrdineLog.EOF_SL_Riferimento__c = testCollegamentoLog.Id;
        insert testOrdineLog;                                   
        
        PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));        
        pageRef.getParameters().put('recordOfferta', 'Backhauling');  
        pageRef.getParameters().put('CaseDetail', testParentLog.Id);   
 		pageRef.getParameters().put('OffUploaded', 'string');        
        Test.setCurrentPage(pageRef);
                
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller(); 
        
        

        theController.CaseDetail = testParentCase.Id;
        
        theController.childLogObj = testCollegamentoLog;
        
        //theController. testParentCase.Id;
        
        theController.ParentDataOrderUpdation();
        theController.SearchLog();
        theController.runSearchProfilo();
        theController.currentUserParentCases();
        //theController.currentUserParentLogs();
        theController.getsortingCases();
        //theController.getsortingLogs();
        
        //theController.OpportunityStageNameUpdate(); 
        
        
       	list<case> caseList=new list<case>();
        case c=new case();
        caseList.add(c);        
       
 
        insert(caseList);
        pageRef.getParameters().put('parentId', c.Id);
        Test.setCurrentPage(pageRef);
        system.debug('peodebe: ' +pageref.getParameters());
        
        Account theAccount = new Account();
        theAccount.Name = 'testing';
        insert theAccount;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();        
        catalogo.OF_DataFineValidita__c = Date.today();
        catalogo.OF_DataInizioValidita__c = Date.today();             
        insert catalogo;
        
        OF_Servizio__c theServizio = new OF_Servizio__c();
        theServizio.Name = 'Backhauling';     
                        
        theServizio.OF_CatalogoCommerciale__c = catalogo.Id;
        theServizio.OF_DataFineValidita__c = Date.today();
        theServizio.OF_DataInizioValidita__c = Date.today();
        
        insert theServizio;        
        
        Contract theContratto = new Contract();
        theContratto.AccountId = theAccount.Id;
        theContratto.StartDate = Date.today().addDays(-2);
        theContratto.ContractTerm = 2;
        theContratto.Status = 'Attivo';
        insert theContratto;
        
        OF_ContrattoServizio__c theContrattoServizio = new OF_ContrattoServizio__c(); 
        theContrattoServizio.OF_Contract__c = theContratto.Id;
        theContrattoServizio.OF_Servizio__c = theServizio.Id;
        insert theContrattoServizio;
        
        theController.parentCaseObj = new Case();
        theController.parentCaseObj.Accordo_Operativo__c = 'testing';
        theController.parentCaseObj.PO_Accordo_Quadro_Number__c = theContratto.Id;
        
		testParentCase.PO_Data_Attivazione_Ordine__c = Date.today();        
                                
        theController.EditOrderInfo();
        
        theController.DetailPage();
        theController.checkStageName();
        
        theController.createChildLog();
        
        Case anOtherCase = new Case();
        
		//prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');         
        
        anOtherCase.PO_Offerta__c = 'Backhauling';
        insert anOtherCase;
        
        EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
        anOtherLog.Caso__c = anOtherCase.Id;                 
        
        insert anOtherLog;
        
        PageReference pageRef2 = Page.PO_Serv_Backhauling_Riepilogo;        
        pageRef2.getParameters().put('CaseDetail', testParentCase.Id);           
        pageRef2.getParameters().put('Id', testParentCase.Id); 
        pageRef2.getParameters().put('editid', testParentCase.Id);   
        pageRef2.getParameters().put('parentId', anOtherLog.Id);    
        Test.setCurrentPage(pageRef2);
        
        theController.testcase = testParentCase;
        
        theController.DisplayCaseInfo();        
        theController.childCase();        
        theController.collegmentaDateEdit();        
        theController.SaveParentChildCaseInfo();                 
                
        //theController.deleteLog();   da scommentare
        
        Test.stopTest();  
    }
    
	@isTest static void testMetho12() 
    {   
        Test.startTest();      
        
		Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }        
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
                      
        Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test'; 
        
		//prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');           
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        insert testParentCase; 
                        
		EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.RecordTypeId = theRecordTypes.get('PO_Log_Backhauling_Collegamento'); 
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test';                          
        testParentLog.Caso__c = testParentCase.Id;
        insert testParentLog;  
        
        Case anOtherCase = new Case();
        anOtherCase.PO_Offerta__c = 'Backhauling';
        
		//prova fix restricted picklist    
        anOtherCase.Status = 'Bozza';            
        anOtherCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');        
        
        anOtherCase.Parentid = testParentCase.Id;
        insert anOtherCase;        
                    
 		PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));        
        pageRef.getParameters().put('recordOfferta', 'Backhauling');  
        pageRef.getParameters().put('CaseDetail', testParentLog.Id);   
 		pageRef.getParameters().put('OffUploaded', 'string');        
        Test.setCurrentPage(pageRef);                        
        
        Account theAccount = new Account();
        theAccount.Name = 'testing';
        insert theAccount;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();        
        catalogo.OF_DataFineValidita__c = Date.today();
        catalogo.OF_DataInizioValidita__c = Date.today();             
        insert catalogo;
        
        OF_Servizio__c theServizio = new OF_Servizio__c();
        theServizio.Name = 'Backhauling';     
                        
        theServizio.OF_CatalogoCommerciale__c = catalogo.Id;
        theServizio.OF_DataFineValidita__c = Date.today();
        theServizio.OF_DataInizioValidita__c = Date.today();
        
        insert theServizio;        
        
        Contract theContratto = new Contract();
        theContratto.AccountId = theAccount.Id;
        theContratto.StartDate = Date.today().addDays(-2);
        theContratto.ContractTerm = 2;
        theContratto.Status = 'Attivo';
        insert theContratto;
        
        OF_ContrattoServizio__c theContrattoServizio = new OF_ContrattoServizio__c(); 
        theContrattoServizio.OF_Contract__c = theContratto.Id;
        theContrattoServizio.OF_Servizio__c = theServizio.Id;
        insert theContrattoServizio;        		
        
        Case caseOpportunity = new Case();
        insert caseOpportunity;  
        
		PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();              
        
        theController.parentLogObj.Caso__c = caseOpportunity.Id;           
        
        theController.parentCaseObj = new Case();
        theController.parentCaseObj.Accordo_Operativo__c = 'testing';
        theController.parentCaseObj.PO_Accordo_Quadro_Number__c = theContratto.Id;        
                        
		List<Case> caseList = new List<Case>();        
        caseList.add(anOtherCase);        
        
        upsert(caseList);
        //pageRef.getParameters().put('parentId', c.Id);
        Test.setCurrentPage(pageRef);        
        
        
        //theController.OrderCreation(caseList); 
        
		Test.stopTest();          
    }
    
    @isTest static void testMetho13() 
    { 
        Account theAccount = new Account();
        theAccount.Name = 'testing';
        insert theAccount;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();        
        catalogo.OF_DataFineValidita__c = Date.today();
        catalogo.OF_DataInizioValidita__c = Date.today();             
        insert catalogo;
        
        OF_Servizio__c theServizio = new OF_Servizio__c();
        theServizio.Name = 'Open Stream';                             
        theServizio.OF_CatalogoCommerciale__c = catalogo.Id;
        theServizio.OF_DataFineValidita__c = Date.today();
        theServizio.OF_DataInizioValidita__c = Date.today();        
        insert theServizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c(); 
        ce.Name='VLAN';
        ce.OF_Servizio__c = theServizio.Id;  
        ce.OF_DataInizioValidita__c = date.today();
        ce.OF_DataFineValidita__c = date.today();
        insert ce;
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();  
        
		Case caseOpportunity = new Case();
        insert caseOpportunity; 
        
        EOF_EAI_Service_Log__c aLog = new EOF_EAI_Service_Log__c();
        aLog.Caso__c = caseOpportunity.Id;
        insert aLog;
        
        theController.parentLogObj = aLog;
        
        
        theController.BackhaulingLogList.add(aLog);  
        
        
    	theController.InviaRichiesta();
    }
    
	@isTest static void testMetho14() 
    { 
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller(); 
        theController.EditLogInfo();
        theController.redirectchildlogdetail();
        theController.redirectToOrdLogDetail();
        theController.deleteLog();
    }
    
	@isTest static void testMetho15() 
    { 
		Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }        
        
        Case testParentCase = new Case();        
        testParentCase.EOF_Codice_Ordine_OLO__c = 'test';  
                
        //prova fix restricted picklist    
        testParentCase.Status = 'Bozza';            
        testParentCase.RecordTypeId = theRecordTypes.get('PO_Collegamento_Backhauling');
        
        testParentCase.PO_Offerta__c = 'Backhauling';
        testParentCase.PO_Tempi_di_attivazione_mesi__c = 2;
        insert testParentCase; 
        
        EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test';  
        testParentLog.Caso__c = testParentCase.Id;
        testParentLog.PO_Tempi_di_attivazione_mesi__c = 2;
        insert testParentLog;  
        
        PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('recid', String.valueOf(testParentLog.Id));                  
        Test.setCurrentPage(pageRef); 
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller(); 
                        
        theController.collegmentaDate();
        
        theController.Annulla();
    }  
        
    @isTest static void testMetho16() 
    {
        Case caseOpportunity = new Case();
        insert caseOpportunity; 
        
        Opportunity theOpportunity = new Opportunity();
        theOpportunity.PO_Collegamento__c = null;
        theOpportunity.PO_Richiesta_fattibilit__c = caseOpportunity.Id;
        theOpportunity.Name = 'testing';
        theOpportunity.StageName = 'open';
        theOpportunity.CloseDate = Date.today();                        
        insert theOpportunity; 
        
        PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('id', caseOpportunity.Id);                  
        Test.setCurrentPage(pageRef); 
        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller(); 
                        
        theController.getparentOppty();
    }
    
    @isTest static void testMetho17() 
    {
        Case case1 = new Case();        
        insert case1;         
        
        Case case2 = new Case();
        case2.PO_Case_Collegamento__c = case1.Id;
        insert case2;         
                                        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();         
        
        theController.ChildCases.add(case2);
                        
        theController.getorderCases();
    } 
    
    @isTest static void testMetho18() 
    {
        Case case1 = new Case();        
        insert case1;         
        
        Case case2 = new Case();
        case2.PO_Case_Collegamento__c = case1.Id;
        insert case2; 
        
		EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test';          
        testParentLog.PO_Tempi_di_attivazione_mesi__c = 2;
        insert testParentLog;        
                                        
        PO_Serv_Backhauling_Riepilogo_Controller theController = new PO_Serv_Backhauling_Riepilogo_Controller();  
        
        theController.BackhaulingLogPadre = testParentLog;
        
        theController.createChildLog();                                
        
		theController.BackhaulingLogPadre = null; 
        theController.parentLogObj = null;
        
        theController.testlog = new List<EOF_EAI_Service_Log__c>(); 
        
        theController.testlog.add(testParentLog);
                                
        theController.createChildLog();                           
                
                    
        PageReference pageRef = Page.PO_Serv_Backhauling_Riepilogo;
        pageRef.getParameters().put('cLogId', testParentLog.Id);                  
        Test.setCurrentPage(pageRef); 

        theController.BackhaulingLogPadre = null; 
        theController.parentLogObj = null;
        theController.testlog = null;        
        
        theController.createChildLog();
    }     
}
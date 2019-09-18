@isTest
private class PO_Serv_FiberLease_Riepilogo_Contr_Test
{
    public static testMethod void testInviaRichiesta2() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createFiberLeaseData();
        Test.startTest();
        PO_Serv_FiberLease_Riepilogo_Controller ctrl = new PO_Serv_FiberLease_Riepilogo_Controller();
        ctrl.accId = data.casePadre.AccountId;
        ctrl.parentLogObj = data.logRichiesta;
        ctrl.FiberLeaseLogList = new List<EOF_EAI_Service_Log__c>{data.logCollegamento};
        
        ctrl.InviaRichiesta();
        ctrl.InviaRichiesta_2();
        ctrl.ParentCaseRecord();
        Test.stopTest();
    }
    
	@isTest static void testMethod1()
	{
		Case fakeCase = new Case();
		insert(fakeCase);

		Map<String,String> theRecordTypes = new Map<String,String>();
		for (RecordType rt : [select id, developername from recordtype])
		{
			theRecordTypes.put(rt.developername, rt.id);
		}

		Test.startTest();

		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);

		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';
		insert testParentCase;

		EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();
		testParentLog.EOF_Codice_Ordine_OLO__c = 'test';
		testParentLog.Caso__c = testParentCase.Id;
		insert testParentLog;

		EOF_EAI_Service_Log__c testCollegamentoLog = new EOF_EAI_Service_Log__c();
		testCollegamentoLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Collegamento');
		testCollegamentoLog.EOF_Codice_Ordine_OLO__c = 'test';
		testCollegamentoLog.EOF_SL_Riferimento__c = testParentLog.Id;
		insert testCollegamentoLog;

		EOF_EAI_Service_Log__c testOrdineLog = new EOF_EAI_Service_Log__c();
		testOrdineLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Ordine');
		testOrdineLog.EOF_Codice_Ordine_OLO__c = 'test';
		testOrdineLog.EOF_SL_Riferimento__c = testCollegamentoLog.Id;
		insert testOrdineLog;

		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));
		pageRef.getParameters().put('recordOfferta', 'Fiber Lease');
		pageRef.getParameters().put('CaseDetail', testParentLog.Id);
		Test.setCurrentPage(pageRef);

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

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
		anOtherCase.PO_Offerta__c = 'Fiber Lease';
		insert anOtherCase;

		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		anOtherLog.Caso__c = anOtherCase.Id;
		insert anOtherLog;

		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef2.getParameters().put('CaseDetail', testParentCase.Id);
		pageRef2.getParameters().put('Id', testParentCase.Id);
		pageRef2.getParameters().put('editid', testParentCase.Id);
		pageRef2.getParameters().put('parentId', anOtherLog.Id);
		Test.setCurrentPage(pageRef2);

		theController.testcase = testParentCase;

		theController.DisplayCaseInfo();
		theController.childCase();
		theController.collegmentaDateEdit();


		//theController.deleteLog();   da scommentare

		Test.stopTest();
	}



	@isTest static void testMethod2_1()
	{
		Test.startTest();

		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);

		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';
		insert testParentCase;

		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		anOtherLog.Caso__c = testParentCase.Id;
		anOtherLog.PO_Accordo_Quadro_Number__c = '1';
		insert anOtherLog;

		Opportunity theOpportunity2 = new Opportunity();
		theOpportunity2.PO_Collegamento__c = null;
		theOpportunity2.PO_Richiesta_fattibilit__c = testParentCase.Id;
		theOpportunity2.Name = 'testing';
		theOpportunity2.StageName = 'Offerta presentata';
		theOpportunity2.CloseDate = Date.today();
		insert theOpportunity2;

		Quote qt = new Quote();
		qt.Name = 'Test';
		qt.OpportunityId = theOpportunity2.Id;
		insert qt;

		System.debug('#### theOpportunity2.Id: ' + theOpportunity2.Id + ' - testParentCase.Id: ' + testParentCase.Id);
		Quote qt2 = [select id, name, Opportunity.name, account.name, Account.BillingStreet,Account.BillingCity,
					 Account.BillingState,Account.BillingPostalCode, PO_Durata_affitto__c,OpportunityId,
					 Opportunity.PO_Richiesta_fattibilit__c, PO_ContaPDF__c
					 from Quote
					 where Opportunity.PO_Richiesta_fattibilit__c =: testParentCase.Id
						 limit 1];

		System.debug('#### QT2: ' + qt2);

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef2.getParameters().put('CaseDetail', testParentCase.Id);
		pageRef2.getParameters().put('Id', testParentCase.Id);
		pageRef2.getParameters().put('editid', testParentCase.Id);
		pageRef2.getParameters().put('parentId', anOtherLog.Id);
		pageRef2.getParameters().put('duratadiaffitto','2');
		Test.setCurrentPage(pageRef2);

		theController.testcase = testParentCase;
		theController.parentLogObj.Caso__c = testParentCase.Id;

		try {
			theController.OpportunityStageNameUpdate();
		}
		catch (Exception e) {}

		Test.stopTest();
	}

	@isTest static void testMethod3()
	{
		Test.startTest();

		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);

		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';
		insert testParentCase;

		Case anOtherCase = new Case();
		anOtherCase.PO_Offerta__c = 'Fiber Lease';
		insert anOtherCase;

		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		anOtherLog.Caso__c = anOtherCase.Id;
		insert anOtherLog;

		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef2.getParameters().put('CaseDetail', testParentCase.Id);
		pageRef2.getParameters().put('Id', testParentCase.Id);
		pageRef2.getParameters().put('editid', testParentCase.Id);
		pageRef2.getParameters().put('parentId', anOtherLog.Id);
		pageRef2.getParameters().put('duratadiaffitto', '2');
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

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		theController.testcase = testParentCase;

		theController.parentLogObj.Caso__c = caseOpportunity.Id;

		theController.FiberLeaseLogList.add(anOtherLog);

		theController.OpportunityStageNameUpdate2();

		Test.stopTest();
	}

	@isTest static void test_DeleteParentChildCase()
	{
		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';
		insert testParentCase;

		Test.startTest();
		PO_Serv_FiberLease_Riepilogo_Controller contr = new PO_Serv_FiberLease_Riepilogo_Controller();
		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef2.getParameters().put('parentId', testParentCase.Id);
		Test.setCurrentPage(pageRef2);

		contr.DeleteParentChildCase();
		Test.stopTest();
	}

	@isTest static void test_DeleteParentChildLog()
	{
		EOF_EAI_Service_Log__c parentLog = new EOF_EAI_Service_Log__c();
		parentLog.PO_Accordo_Quadro_Number__c = '1';
		insert parentLog;

		EOF_EAI_Service_Log__c childLog = new EOF_EAI_Service_Log__c();
		childLog.PO_Accordo_Quadro_Number__c = '1';
		childLog.EOF_SL_Riferimento__c = parentLog.Id;
		insert childLog;

		Test.startTest();
		PO_Serv_FiberLease_Riepilogo_Controller contr = new PO_Serv_FiberLease_Riepilogo_Controller();
		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef2.getParameters().put('parentId', parentLog.Id);
		Test.setCurrentPage(pageRef2);

		contr.DeleteParentChildLog();
		Test.stopTest();
	}



	@isTest static void testMethod5()
	{
		Test.startTest();

		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);

		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';
		insert testParentCase;

		Case anOtherCase = new Case();
		anOtherCase.PO_Offerta__c = 'Fiber Lease';

		anOtherCase.PO_Data_Attivazione_Ordine__c = Date.today();

		insert anOtherCase;

		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		anOtherLog.Caso__c = anOtherCase.Id;
		insert anOtherLog;

		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
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

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		theController.testcase = testParentCase;

		theController.parentLogObj.Caso__c = caseOpportunity.Id;

		theController.CaseDetail = anOtherCase.Id;

		theController.EditOrderInfo();

		Test.stopTest();
	}


	@isTest static void testMethod4()
	{
		PO_ServFatt_DataFactory.WrapData wrap = PO_ServFatt_DataFactory.createFiberLeaseData();

		Test.startTest();

		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);

		Case testParentCase = wrap.casePadre;
		//testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		//testParentCase.PO_Offerta__c = 'Fiber Lease';
		testParentCase.PO_Durata_affitto__c = 1;
		update testParentCase;

		Case anOtherCase = wrap.caseCollegamento;
		//anOtherCase.PO_Offerta__c = 'Fiber Lease';
		anOtherCase.PO_Incluso_nell_offerta__c = true;
		//anOtherCase.parentid = testParentCase.Id;
		anOtherCase.PO_Durata_affitto__c = 1;
		anOtherCase.PO_Tipo_percorso__c = 'DOPPIA VIA DIVERSIFICATA';
		update anOtherCase;


		String collegamentoRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO Log FiberLease Collegamento').getRecordTypeId();


		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		anOtherLog.Caso__c = anOtherCase.Id;
		anOtherLog.recordTypeId = collegamentoRecordType;
		insert anOtherLog;

		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef2.getParameters().put('CaseDetail', testParentCase.Id);
		pageRef2.getParameters().put('Id', testParentCase.Id);
		pageRef2.getParameters().put('editid', testParentCase.Id);
		pageRef2.getParameters().put('parentId', anOtherLog.Id);
		Test.setCurrentPage(pageRef2);

		Case caseOpportunity = new Case();
		caseOpportunity.PO_Durata_affitto__c = 1;
		insert caseOpportunity;

		Opportunity theOpportunity = new Opportunity();
		theOpportunity.PO_Collegamento__c = null;
		theOpportunity.PO_Richiesta_fattibilit__c = caseOpportunity.Id;
		theOpportunity.Name = 'testing';
		theOpportunity.StageName = 'open';
		theOpportunity.CloseDate = Date.today();
		insert theOpportunity;

		EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();
		testParentLog.EOF_Codice_Ordine_OLO__c = 'test';
		testParentLog.Caso__c = testParentCase.Id;
		insert testParentLog;


		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));
		pageRef.getParameters().put('recordOfferta', 'FiberLease');
		pageRef.getParameters().put('CaseDetail', testParentLog.Id);
		pageRef.getParameters().put('OffUploaded', 'string');
		pageRef.getParameters().put('duratadiaffitto', '1');

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		theController.testcase = testParentCase;

		theController.parentLogObj.Caso__c = caseOpportunity.Id;

		List<Case> casesFromPortal = new List<Case>();

		/*Case aCaseFromPortal = new Case();
		   aCaseFromPortal.parentId = anOtherCase.Id;
		   aCaseFromPortal.PO_Numero_fibre_richieste__c='1';
		   //aCaseFromPortal.PO_Lunghezza_tratta_prima_via__c=1730;
		   aCaseFromPortal.PO_BB_1_via_interessato__c=100;
		   aCaseFromPortal.PO_Posa_1_via_nuovo_Drop__c=200;
		   aCaseFromPortal.PO_Tipo_percorso__c = 'SINGOLA VIA';
		   aCaseFromPortal.PO_Durata_affitto__c = 1;


		   //c.PO_Tipo_percorso__c,String.valueOf(c.PO_Numero_fibre_richieste__c),Integer.valueOf(c.PO_Lunghezza_tratta_prima_via__c),stringDurataAffitto
		   insert aCaseFromPortal;*/

		//casesFromPortal.add(aCaseFromPortal);
		casesFromPortal.add(anOtherCase);

		theController.parentCaseObj = wrap.casePadre;
		theController.parentCaseObj.PO_Durata_affitto__c = 1;

		Map<String,String> theRecordTypes = new Map<String,String>();
		for (RecordType rt : [select id, developername from recordtype])
		{
			theRecordTypes.put(rt.developername, rt.id);
		}


		EOF_EAI_Service_Log__c testCollegamentoLog = new EOF_EAI_Service_Log__c();
		testCollegamentoLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Collegamento');
		testCollegamentoLog.EOF_Codice_Ordine_OLO__c = 'test';
		testCollegamentoLog.EOF_SL_Riferimento__c = testParentLog.Id;

		testCollegamentoLog.Caso__c = anOtherCase.Parentid;

		insert testCollegamentoLog;

		EOF_EAI_Service_Log__c testOrdineLog = new EOF_EAI_Service_Log__c();
		testOrdineLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Ordine');
		testOrdineLog.EOF_Codice_Ordine_OLO__c = 'test';
		testOrdineLog.EOF_SL_Riferimento__c = testCollegamentoLog.Id;
		insert testOrdineLog;


		Test.setCurrentPage(pageRef);

		System.debug('casesFromPortal: ' + casesFromPortal);

		theController.OrderCreation(casesFromPortal);

		Test.stopTest();
	}

	@isTest static void testMethod6()
	{
		Test.startTest();

		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);

		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';

		insert testParentCase;

		Case anOtherCase = new Case();
		anOtherCase.PO_Offerta__c = 'Fiber Lease';
		insert anOtherCase;

		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		anOtherLog.Caso__c = anOtherCase.Id;
		insert anOtherLog;

		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
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

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

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
		theServizio.Name = 'Fiber Lease';

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

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();
		theController.checkVendibilitaRichiesta(theAccount.Id, 'Fiber Lease');

		Test.stopTest();
	}

	@isTest static void testMethod8()
	{
		Test.startTest();

		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		insert anOtherLog;

		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef.getParameters().put('parentId', anOtherLog.Id);
		Test.setCurrentPage(pageRef);

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

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
		theServizio.Name = 'Fiber Lease';

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

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();
		theLog.EOF_Comune__c = 'Roma';
		insert theLog;

		EOF_EAI_Service_Log__c theParentLog = new EOF_EAI_Service_Log__c();
		theParentLog.EOF_Comune__c = 'Roma';
		theParentLog.PO_Offerta__c = 'Fiber Lease';
		insert theParentLog;

		theController.FiberLeaseLogList = new List<EOF_EAI_Service_Log__c>();
		theController.FiberLeaseLogList.add(theLog);
		theController.parentLogObj = theParentLog;
		theController.accId = theAccount.Id;

		//theController.checkVendibilitaRichiesta(theAccount.Id, 'Fiber Lease');





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

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		theController.parentLogObj = anOtherLog;

		theController.OpportunityStageNameUpdate3();
		theController.redirectparentlogdetail();

		Test.stopTest();
	}
	@isTest static void testMethod11()
	{

		Map<String,String> theRecordTypes = new Map<String,String>();
		for (RecordType rt : [select id, developername from recordtype])
		{
			theRecordTypes.put(rt.developername, rt.id);
		}

		Test.startTest();

		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);

		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';
		insert testParentCase;

		EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();
		testParentLog.EOF_Codice_Ordine_OLO__c = 'test';
		testParentLog.Caso__c = testParentCase.Id;
		insert testParentLog;

		EOF_EAI_Service_Log__c testCollegamentoLog = new EOF_EAI_Service_Log__c();
		testCollegamentoLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Collegamento');
		testCollegamentoLog.EOF_Codice_Ordine_OLO__c = 'test';
		testCollegamentoLog.EOF_SL_Riferimento__c = testParentLog.Id;
		insert testCollegamentoLog;

		EOF_EAI_Service_Log__c testOrdineLog = new EOF_EAI_Service_Log__c();
		testOrdineLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Ordine');
		testOrdineLog.EOF_Codice_Ordine_OLO__c = 'test';
		testOrdineLog.EOF_SL_Riferimento__c = testCollegamentoLog.Id;
		insert testOrdineLog;

		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));
		pageRef.getParameters().put('recordOfferta', 'Fiber Lease');
		pageRef.getParameters().put('CaseDetail', testParentLog.Id);
		pageRef.getParameters().put('OffUploaded', 'string');
		Test.setCurrentPage(pageRef);

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

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
	case c=new case ();
		caseList.add(c);


		insert(caseList);
		pageRef.getParameters().put('parentId', c.Id);
		Test.setCurrentPage(pageRef);
		system.debug('peodebe: ' + pageref.getParameters());

		Account theAccount = new Account();
		theAccount.Name = 'testing';
		insert theAccount;

		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		catalogo.OF_DataFineValidita__c = Date.today();
		catalogo.OF_DataInizioValidita__c = Date.today();
		insert catalogo;

		OF_Servizio__c theServizio = new OF_Servizio__c();
		theServizio.Name = 'Fiber Lease';

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
		anOtherCase.PO_Offerta__c = 'Fiber Lease';
		insert anOtherCase;

		EOF_EAI_Service_Log__c anOtherLog = new EOF_EAI_Service_Log__c();
		anOtherLog.Caso__c = anOtherCase.Id;

		insert anOtherLog;

		PageReference pageRef2 = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef2.getParameters().put('CaseDetail', testParentCase.Id);
		pageRef2.getParameters().put('Id', testParentCase.Id);
		pageRef2.getParameters().put('editid', testParentCase.Id);
		pageRef2.getParameters().put('parentId', anOtherLog.Id);
		Test.setCurrentPage(pageRef2);

		theController.testcase = testParentCase;

		theController.DisplayCaseInfo();
		theController.childCase();
		theController.collegmentaDateEdit();


		//theController.deleteLog();   da scommentare

		Test.stopTest();
	}

// 	@isTest static void testMetho12()
// 	{
// 		Test.startTest();

// 		Map<String,String> theRecordTypes = new Map<String,String>();
// 		for (RecordType rt: [select id, developername from recordtype])
// 		{
// 			theRecordTypes.put(rt.developername, rt.id);
// 		}

// 		insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
// 		insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);



// 		Case testParentCase = new Case();
// 		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
// 		testParentCase.PO_Offerta__c = 'Fiber Lease';
// 		insert testParentCase;

// 		EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();
// 		testParentLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Collegamento');
// 		testParentLog.EOF_Codice_Ordine_OLO__c = 'test';
// 		testParentLog.Caso__c = testParentCase.Id;
// 		insert testParentLog;

// 		Case anOtherCase = new Case();
// 		anOtherCase.PO_Offerta__c = 'Fiber Lease';
// 		anOtherCase.Parentid = testParentCase.Id;
// 		insert anOtherCase;



// 		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
// 		pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));
// 		pageRef.getParameters().put('recordOfferta', 'Fiber Lease');
// 		pageRef.getParameters().put('CaseDetail', testParentLog.Id);
// 		pageRef.getParameters().put('OffUploaded', 'string');
// 		Test.setCurrentPage(pageRef);

// 		Account theAccount = new Account();
// 		theAccount.Name = 'testing';
// 		insert theAccount;

// 		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
// 		catalogo.OF_DataFineValidita__c = Date.today();
// 		catalogo.OF_DataInizioValidita__c = Date.today();
// 		insert catalogo;

// 		OF_Servizio__c theServizio = new OF_Servizio__c();
// 		theServizio.Name = 'Fiber Lease';

// 		theServizio.OF_CatalogoCommerciale__c = catalogo.Id;
// 		theServizio.OF_DataFineValidita__c = Date.today();
// 		theServizio.OF_DataInizioValidita__c = Date.today();

// 		insert theServizio;

// 		Contract theContratto = new Contract();
// 		theContratto.AccountId = theAccount.Id;
// 		theContratto.StartDate = Date.today().addDays(-2);
// 		theContratto.ContractTerm = 2;
// 		theContratto.Status = 'Attivo';
// 		insert theContratto;

// 		OF_ContrattoServizio__c theContrattoServizio = new OF_ContrattoServizio__c();
// 		theContrattoServizio.OF_Contract__c = theContratto.Id;
// 		theContrattoServizio.OF_Servizio__c = theServizio.Id;
// 		insert theContrattoServizio;

// 		Case caseOpportunity = new Case();
// 		insert caseOpportunity;

// 		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

// 		theController.parentLogObj.Caso__c = caseOpportunity.Id;

// 		theController.parentCaseObj = new Case();
// 		theController.parentCaseObj.Accordo_Operativo__c = 'testing';
// 		theController.parentCaseObj.PO_Accordo_Quadro_Number__c = theContratto.Id;

// 		List<Case> caseList = new List<Case>();
// 		caseList.add(anOtherCase);

// 		upsert(caseList);
// 		//pageRef.getParameters().put('parentId', c.Id);
// 		Test.setCurrentPage(pageRef);


// 		//theController.OrderCreation(caseList);

// 		Test.stopTest();
// 	}

// 	@isTest static void testMetho13()
// 	{
// 		Account theAccount = new Account();
// 		theAccount.Name = 'testing';
// 		insert theAccount;

// 		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
// 		catalogo.OF_DataFineValidita__c = Date.today();
// 		catalogo.OF_DataInizioValidita__c = Date.today();
// 		insert catalogo;

// 		OF_Servizio__c theServizio = new OF_Servizio__c();
// 		theServizio.Name = 'Open Stream';
// 		theServizio.OF_CatalogoCommerciale__c = catalogo.Id;
// 		theServizio.OF_DataFineValidita__c = Date.today();
// 		theServizio.OF_DataInizioValidita__c = Date.today();
// 		insert theServizio;

// 		OF_CommercialElement__c ce = new OF_CommercialElement__c();
// 		ce.Name='VLAN';
// 		ce.OF_Servizio__c = theServizio.Id;
// 		ce.OF_DataInizioValidita__c = date.today();
// 		ce.OF_DataFineValidita__c = date.today();
// 		insert ce;

// 		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

// 		Case caseOpportunity = new Case();
// 		insert caseOpportunity;

// 		EOF_EAI_Service_Log__c aLog = new EOF_EAI_Service_Log__c();
// 		aLog.Caso__c = caseOpportunity.Id;
// 		insert aLog;

// 		theController.parentLogObj = aLog;


// 		theController.FiberLeaseLogList.add(aLog);


// 		theController.InviaRichiesta();
// 	}

	@isTest static void testMetho14()
	{
		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();
		theController.EditLogInfo();
		theController.redirectchildlogdetail();
		theController.redirectToOrdLogDetail();
		theController.deleteLog();
	}

	@isTest static void testMetho15()
	{
		Case testParentCase = new Case();
		testParentCase.EOF_Codice_Ordine_OLO__c = 'test';
		testParentCase.PO_Offerta__c = 'Fiber Lease';
		testParentCase.PO_Tempi_di_attivazione_mesi__c = 2;
		insert testParentCase;

		EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();
		testParentLog.EOF_Codice_Ordine_OLO__c = 'test';
		testParentLog.Caso__c = testParentCase.Id;
		testParentLog.PO_Tempi_di_attivazione_mesi__c = 2;
		insert testParentLog;

		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef.getParameters().put('recid', String.valueOf(testParentLog.Id));
		Test.setCurrentPage(pageRef);

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

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

		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef.getParameters().put('id', caseOpportunity.Id);
		Test.setCurrentPage(pageRef);

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		theController.getparentOppty();
	}

	@isTest static void testMetho17()
	{
		Case case1 = new Case();
		insert case1;

		Case case2 = new Case();
		case2.PO_Case_Collegamento__c = case1.Id;
		insert case2;

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

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

		PO_Serv_FiberLease_Riepilogo_Controller theController = new PO_Serv_FiberLease_Riepilogo_Controller();

		theController.FiberLeaseLogPadre = testParentLog;

		theController.createChildLog();

		theController.FiberLeaseLogPadre = null;
		theController.parentLogObj = null;

		theController.testlog = new List<EOF_EAI_Service_Log__c>();

		theController.testlog.add(testParentLog);

		theController.createChildLog();


		PageReference pageRef = Page.PO_Serv_FiberLease_Riepilogo;
		pageRef.getParameters().put('cLogId', testParentLog.Id);
		Test.setCurrentPage(pageRef);

		theController.FiberLeaseLogPadre = null;
		theController.parentLogObj = null;
		theController.testlog = null;

		theController.createChildLog();
	}
}
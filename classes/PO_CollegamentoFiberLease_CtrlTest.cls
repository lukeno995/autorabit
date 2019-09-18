@isTest
public class PO_CollegamentoFiberLease_CtrlTest {
	@isTest
	public static void FiberLeaseBackend_test1() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_P2P_Base__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.sospendi();
		FiberLeaseCtr.desospendi();
		FiberLeaseCtr.annulla();
		FiberLeaseCtr.PrendiInCarico();
		FiberLeaseCtr.InviaAlNetworkCreation();
		FiberLeaseCtr.setViewPopUpPSM();
		FiberLeaseCtr.setViewErrorFilePopUpPSM();
	}

	@isTest
	public static void FiberLeaseBackend_test2() {
		PO_ServFatt_DataFactory.wrapdata wrp = PO_ServFatt_DataFactory.createFiberLeaseData();


		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = wrp.casecollegamento.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);

		ApexPages.currentPage().getParameters().put('Id', wrp.casecollegamento.Id);

		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(wrp.casecollegamento));
		FiberLeaseCtr.esitiCompletati();
	}

	@isTest
	public static void FiberLeaseBackend_test2B() {
		PO_ServFatt_DataFactory.wrapdata wrp = PO_ServFatt_DataFactory.createFiberLeaseData();

		/*
		   EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c (Caso__c = wrp.casecollegamento.Id);
		   Case caseClone = wrp.casecollegamento.clone(false, true, false, false);
		   caseClone.EOF_Fase__c = 'Completato';
		   insert caseClone;
		   insert logFiglio;
		 */
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);

		ApexPages.currentPage().getParameters().put('Id', wrp.casecollegamento.Id);

		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(wrp.casecollegamento));
		//FiberLeaseCtr.esitiCompletati();
		PO_CollegamentoFiberLease_Controller.findObjectNameFromRecordIdPrefix('test');
		wrp.casecollegamento.PO_Esito_collegamento__c = null;
		FiberLeaseCtr.checkEsitiFiberLease(wrp.casecollegamento);
		wrp.casecollegamento.PO_Esito_collegamento__c = 'SI in FTTH';
		wrp.casecollegamento.PO_Drop_FL_1__c = false;
		wrp.casecollegamento.PO_Posa_1_nuovo_Drop__c = null;
		FiberLeaseCtr.checkEsitiFiberLease(wrp.casecollegamento);
		wrp.casecollegamento.PO_Drop_FL_1__c = true;
		wrp.casecollegamento.PO_Lunghezza_m__c = null;
		FiberLeaseCtr.checkEsitiFiberLease(wrp.casecollegamento);

		FiberLeaseCtr.title = 'test';
		FiberLeaseCtr.CaseId = 'test';
		FiberLeaseCtr.idNotify = 'test';
		FiberLeaseCtr.urlRedir = 'test';
		FiberLeaseCtr.perform = 'test';
		// FiberLeaseCtr.c = wrp.casecollegamento;
		PO_CollegamentoFiberLease_Controller.createAssetId = wrp.casecollegamento.Id;
	}


	@isTest
	public static void FiberLeaseBackend_test3() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.InvioPSM();
		FiberLeaseCtr.assegnaAlTecnico();
	}

	@isTest
	public static void FiberLeaseBackend_test4() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   OwnerId = [select Id from Group where Name = 'Coda Ref. Fattibilità Centro' and Type = 'Queue'].Id,
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento1
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								OwnerId = [select Id from Group where Name = 'Coda Ref. Fattibilità Centro' and Type = 'Queue'].Id,
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Fase__c='In Lavorazione Supporto Vendite',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina1
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'SupVenToRefFat');
		ApexPages.currentPage().getParameters().put('OLO', 'true');
		User u = [SELECT Id, Name, Profile.Name FROM User WHERE Profile.Name != 'System Administrator'][0];
		System.runAs(u) {
			PO_CollegamentoFiberLease_Controller FiberLeaseCtr1 = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio)); // controllare parametri
			FiberLeaseCtr1.PrendiInCarico();
			FiberLeaseCtr1.InviaAlDelivery();
			FiberLeaseCtr1.InviaAlSupportoVendite();

		}
	}

	@isTest
	public static void FiberLeaseBackend_test5() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								PO_Owner_Originario__c = 'Test',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
								EOF_Fase__c='In Lavorazione Network Creation',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'Sos');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.inserisciNote();
	}

	@isTest
	public static void FiberLeaseBackend_test6() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
								EOF_Fase__c='In Lavorazione Network Creation',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'Del');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.inserisciNote();
	}

	@isTest
	public static void FiberLeaseBackend_test7() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
								EOF_Fase__c='In Lavorazione Network Creation',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'Des');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.inserisciNote();
	}

	@isTest
	public static void FiberLeaseBackend_test8() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
								EOF_Fase__c='In Lavorazione Referente Fattibilità',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'NetCreToSupVen');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.inviaAlTecFat();
		FiberLeaseCtr.inserisciNote();
	}


	@isTest
	public static void FiberLeaseBackend_test9() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
								EOF_Fase__c='In Lavorazione Network Creation',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'DelToSupVen');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.inviaAlTecFat();
		FiberLeaseCtr.inserisciNote();
	}

	@isTest
	public static void FiberLeaseBackend_test10() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
								EOF_Fase__c='In Lavorazione Supporto Vendite',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'Ann');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.inviaAlRefFat();
		FiberLeaseCtr.inserisciNote();

	}

	@isTest
	public static void FiberLeaseBackend_test11() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_Fiber_Lease__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
								EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'NC');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.inviaAlRefFat();
		FiberLeaseCtr.inserisciNote();
	}

	@isTest
	public static void FiberLeaseBackend_test12() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_P2P_Base__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Centro',
								PO_Assegnazione_Area_Geografica__c='Centro',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.assegnaAlTecnico();
		FiberLeaseCtr.setViewPopUpPSM();
		FiberLeaseCtr.setViewErrorFilePopUpPSM();
		FiberLeaseCtr.assegnaAlTecnico();
	}



	@isTest
	public static void FiberLeaseBackend_test13() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_P2P_Base__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Nord Ovest',
								PO_Assegnazione_Area_Geografica__c='Nord Ovest',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c= 'Test',
								EOF_Note__c = 'Test',
								EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		Test.startTest();

		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'NC');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.mostraNoteTecFatToRefFat = true;
		FiberLeaseCtr.mostraNoteTecFatToNetCre = true;
		FiberLeaseCtr.inserisciNote();
		Test.stopTest();
	}

	@isTest
	public static void FiberLeaseBackend_test13B() {
		OF_Tibco_userID__c oft = new OF_Tibco_userID__c();
		oft.Name = 'Tibco UserID';
		oft.OF_Tibco_ID__c = 'Test';
		insert oft;
		OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		ofe.name = 'Status';
		ofe.OF_Enable_Trigger__c = false;
		insert ofe;
		Map<String, Id> RecordTypeNameId = new Map<String,Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM recordType]) {RecordTypeNameId.put(rt.DeveloperName, rt.Id);}
		Contact contactTest = new Contact(LastName = 'Test');
		insert contactTest;
		//Inserimento case Richiesta di fattibilità
		Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
							   Contact = contactTest,
							   PO_Offerta__c = 'Fiber Lease',
							   Status = 'In Lavorazione',
							   Origin = 'Web',
							   Priority = 'Medium',
							   PO_P2P_Base__c = true,
							   Subject = 'TestSetUpPadre');
		insert padre;
		//Inserimento case Collegamento
		Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
								PO_Offerta__c = 'Fiber Lease',
								PO_Owner_Originario__c = UserInfo.getUserId(),
								Status = 'In Lavorazione',
								PO_BB_1_via_interessato__c=4.3,
								PO_Posa_1_via_nuovo_Drop__c=4.3,
								PO_Tempi_di_attivazione_mesi__c=4.3,
								PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
								PO_Area_Geografica__c='Nord Ovest',
								PO_Assegnazione_Area_Geografica__c='Nord Ovest',
								PO_Fiber_Lease__c = true,
								PO_Richiesta_a_fattibilit__c=padre.Id,
								PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c= 'Test',
								EOF_Note__c = 'Test',
								EOF_Fase__c='In Lavorazione Network Creation',
								Subject = 'TestSetUpFiglio');
		insert figlio;
		EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
		insert logFiglio;
		//Creazione pagina
		PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
		Test.setCurrentPage(pageRef);
		Test.startTest();

		ApexPages.currentPage().getParameters().put('Id', figlio.Id);
		ApexPages.currentPage().getParameters().put('Oper', 'NC');
		PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
		FiberLeaseCtr.mostraNoteTecFatToRefFat = true;
		FiberLeaseCtr.mostraNoteTecFatToNetCre = true;
		FiberLeaseCtr.inserisciNote();
		Test.stopTest();
	}

	/*@isTest
	   public static void FiberLeaseBackend_test14(){
	    OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
	    oft.Name = 'Tibco UserID';
	    oft.OF_Tibco_ID__c = 'Test';
	    insert oft;
	    OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
	    ofe.name = 'Status';
	    ofe.OF_Enable_Trigger__c = false;
	    insert ofe;
	    Map<String, Id> RecordTypeNameId = new Map<String,Id>();
	    for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
	    Contact contactTest = new Contact(LastName = 'Test');
	    insert contactTest;
	    //Inserimento case Richiesta di fattibilità
	    Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'),
	                           Contact = contactTest,
	                           PO_Offerta__c = 'Fiber Lease',
	                           Status = 'In Lavorazione',
	                           Origin = 'Web',
	                           Priority = 'Medium',
	                           PO_P2P_Base__c = true,
	                           Subject = 'TestSetUpPadre');
	    insert padre;
	    //Inserimento case Collegamento
	    Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_Lease'),
	                            PO_Offerta__c = 'Fiber Lease',
	                            Status = 'In Lavorazione',
	                            PO_BB_1_via_interessato__c=4.3,
	                            PO_Posa_1_via_nuovo_Drop__c=4.3,
	                            PO_Tempi_di_attivazione_mesi__c=4.3,
	                            PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
	                            PO_Area_Geografica__c='Nord Ovest',
	                            PO_Assegnazione_Area_Geografica__c='Nord Ovest',
	                            PO_Fiber_Lease__c = true,
	                            PO_Richiesta_a_fattibilit__c=padre.Id,
	                            PO_Esito_collegamento__c = 'SI Inf. OP',
	                            EOF_Note_Operatore__c= 'Test',
	                            EOF_Note__c = 'Test',
	                            EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
	                            Subject = 'TestSetUpFiglio');
	    insert figlio;
	    EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
	    insert logFiglio;
	    //Creazione pagina
	    PageReference pageRef = Page.PO_CollegamentoFiberLease_Buttons_Page;
	    Test.setCurrentPage(pageRef);
	    ApexPages.currentPage().getParameters().put('Id', figlio.Id);
	    ApexPages.currentPage().getParameters().put('Oper', 'SupVenToNetCre');
	    PO_CollegamentoFiberLease_Controller FiberLeaseCtr = new  PO_CollegamentoFiberLease_Controller(new ApexPages.StandardController(figlio));
	    FiberLeaseCtr.esitiCompletati();
	    FiberLeaseCtr.title='';
	    FiberLeaseCtr.CaseId='';
	    FiberLeaseCtr.idNotify='';
	    FiberLeaseCtr.urlRedir='';
	    FiberLeaseCtr.perform='';
	    FiberLeaseCtr.getMethodStatic();
	   }    */
}
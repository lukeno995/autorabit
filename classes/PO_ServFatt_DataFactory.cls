@isTest
public class PO_ServFatt_DataFactory {

	public class WrapData {
		public Case casePadre {get; set;}
		public Case caseCollegamento {get; set;}
		public Case caseOrdine {get; set;}
		public Case caseKit {get; set;}
		public EOF_EAI_Service_Log__c logCollegamento {get; set;}
		public EOF_EAI_Service_Log__c logRichiesta {get; set;}
		public Opportunity oppChild {get; set;}
		public ServFattList__c cs {get; set;}
	}

	/**
	 * Crea i seguenti CS:
	 * <ul>
	 * <li>ServFattList</li>
	 * <li>CodificaProfiloListini</li>
	 * <li>Enable_PO_UpdateOppCase_Trigger</li>
	 * <li>Tibco_userID</li>
	 * <li>OF_FiberLeaseListinoPrezzoAnnuo__c</li>
	 * <li>OF_FiberLeasePrezzoMedioAnnuo__c</li>
	 * </ul>
	 */
	public static void createCustomSettings() {
		List<ServFattList__c> csList = new List<ServFattList__c>();
		ServFattList__c cs = new ServFattList__c();
		cs.Name = 'Fiber Link';
		cs.code__c = 'SE-OF000007';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_Fiber_Link';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_Fiber_link';
		cs.assetDevName__c = 'Fiber_Link';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Canone,Contributo Attivazione,Contributo Aggiuntivo';
		cs.oppChildDevName__c = 'PO_Oppty_Fiber_Link';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_Fiber_Link';
		cs.oppChildName__c = 'Offerta Collegamento';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'Fiber Lease';
		cs.code__c = 'SE-OF000011';
		cs.ceiDevName__c = 'PO_CEI_FiberLease';
		cs.caseDevName__c = 'PO_Ordine_Fiber_Lease';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_Fiber_Lease';
		cs.assetDevName__c = 'Fiber_Lease';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Contributo Attivazione';
		cs.oppChildDevName__c = 'PO_Oppty_Fiber_Lease';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_Fiber_Lease';
		csList.add(cs);
		
		cs = new ServFattList__c();
		cs.Name = 'Fiber Lease Misto';
		cs.code__c = 'SE-OF000011';
		cs.ceiDevName__c = 'PO_CEI_FiberLease';
		cs.caseDevName__c = 'PO_Ordine_Fiber_Lease';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_Fiber_Lease';
		cs.assetDevName__c = 'Fiber_Lease';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Contributo Attivazione';
		cs.oppChildDevName__c = 'PO_Oppty_Fiber_Lease';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_Misto_Lease_Link_per_FW';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'Backhauling';
		cs.code__c = 'SE-OF000003';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_Backhauling';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_Backhauling';
		cs.assetDevName__c = 'PO_Asset_Backhauling_Collegamento';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Contributo Attivazione,Contributo Aggiuntivo,Canone Manutenzione,Corrispettivo IRU';
		cs.oppChildDevName__c = 'Oppty_collegamenti_Backhauling';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_Backhauling';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'P2P Base';
		cs.code__c = 'SE-OF000005';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_P2P';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_P2P';
		cs.assetDevName__c = 'P2P';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Canone,Contributo Attivazione,Contributo Aggiuntivo';
		cs.oppChildDevName__c = 'PO_Oppty_collegamenti_P2PBase';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_P2PBase';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'P2P Attiva';
		cs.code__c = 'SE-OF000006';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_P2P_Attiva';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_P2P_Attiva';
		cs.assetDevName__c = 'PO_Asset_P2P_Attiva_Collegamento';
		cs.externalSystem__c = '';
		cs.attBeList__c = 'Canone,Contributo Attivazione,Contributo Aggiuntivo';
		cs.oppChildDevName__c = 'PO_Oppty_collegamenti_P2P_Attiva';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_P2P_Attiva';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'Dark Fiber';
		cs.code__c = 'SE-OF000008';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_DarkFiber';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_DarkFiber';
		cs.assetDevName__c = 'PO_Asset_DarkFiber_Collegamento';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Contributo Attivazione,Contributo Aggiuntivo,Canone Manutenzione,Corrispettivo IRU';
		cs.oppChildDevName__c = 'PO_Oppty_collegamenti_DarkFiber';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_DarkFiber';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'BTS';
		cs.code__c = 'SE-OF000004';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_BTS';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_BTS';
		cs.assetDevName__c = 'PO_Asset_BTS_Collegamento';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Contributo Attivazione,Contributo Aggiuntivo,Canone Manutenzione,Corrispettivo IRU';
		cs.oppChildDevName__c = 'Oppty_collegamenti_BTS';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_BTS';
		csList.add(cs);

		insert csList;

		List<OF_CodificaProfiloListini__c> cplList = new List<OF_CodificaProfiloListini__c>();
		OF_CodificaProfiloListini__c cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = '1';
		cpl.OF_ListinoCanoneName__c = 'OPSTR_001_CAN_20_5';
		cpl.OF_ProfiloCommerciale__c = 'OPENSTREAM_20_5';
		cpl.PO_PREPROV_ListinoCanoneName__c = 'PREPROV_20_5';
		cpl.PO_CD_Profilo_Commerciale__c = 'OPENSTREAM_1000_300';
		cplList.add(cpl);

		cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = '100M';
		cpl.OF_ListinoCanoneName__c = 'P2PATTIVA_100M';
		cpl.OF_ProfiloCommerciale__c = 'P2PATTIVA_100M';
		cpl.servizio__c = 'P2P Attiva';
		cplList.add(cpl);

		cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = '1G';
		cpl.OF_ListinoCanoneName__c = 'P2PATTIVA_1G';
		cpl.OF_ProfiloCommerciale__c = 'P2PATTIVA_1G';
		cpl.servizio__c = 'P2P Attiva';
		cplList.add(cpl);

		cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = 'P2PBase_Mono';
		cpl.OF_ListinoCanoneName__c = 'P2PBASE_MONOFIBRA';
		cpl.OF_ProfiloCommerciale__c = 'P2PBASE_MONOFIBRA';
		cpl.servizio__c = 'P2P Base';
		cplList.add(cpl);

		cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = 'P2PBase_Bi';
		cpl.OF_ListinoCanoneName__c = 'P2PBASE_BIFIBRA';
		cpl.OF_ProfiloCommerciale__c = 'P2PBASE_BIFIBRA';
		cpl.servizio__c = 'P2P Base';
		cplList.add(cpl);

		cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = 'FLINK_DPPDVFIB22DC1F1';
		cpl.OF_ListinoCanoneName__c = 'FLINK_DPPDVFIB22DC1F1';
		cpl.OF_ProfiloCommerciale__c = 'FLINK_DPPDVFIB22DC1F1';
		cpl.servizio__c = 'Fiber Link';
		cplList.add(cpl);

		cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = 'FLINK_SINGVFIB22DF1';
		cpl.OF_ListinoCanoneName__c = 'FLINK_DPPDVFIB22DC1F1,FLINK_DPPDVFIB22DC2F1,FLINK_DPPDVFIB22DC3F1';
		cpl.OF_ProfiloCommerciale__c = 'FLINK_DPPDVFIB22DC1F1';
		cpl.servizio__c = 'Fiber Link';
		cplList.add(cpl);
		insert cplList;

		OF_Enable_PO_UpdateOppCase_Trigger__c t = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		t.Name = 'Status';
		t.OF_Enable_Trigger__c = false;
		insert t;

		OF_Tibco_userID__c tib = new OF_Tibco_userID__c();
		tib.Name = 'Tibco UserID';
		tib.OF_Tibco_ID__c = 'abc1245';
		insert tib;

		Verticali__c cs2 = new Verticali__c();
		cs2.createNotifyBatchLimit__c = 10000;
		cs2.callWsBillingBatchSize__c = 4;
		cs2.RecordTypesAssets__c ='\'OF_Open_Stream\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'';

		insert cs2;

		List<OF_FiberLeaseListinoPrezzoAnnuo__c> flpaList = new List<OF_FiberLeaseListinoPrezzoAnnuo__c>();
		OF_FiberLeaseListinoPrezzoAnnuo__c flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '1';
		flpa.Anno__c = '2030';
		flpa.Prezzo__c = 2.5;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '10';
		flpa.Anno__c = '2021';
		flpa.Prezzo__c = 3.1;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '11';
		flpa.Anno__c = '2020';
		flpa.Prezzo__c = 3.41;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '12';
		flpa.Anno__c = '2019';
		flpa.Prezzo__c = 3.72;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '13';
		flpa.Anno__c = '2018';
		flpa.Prezzo__c = 4.03;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '14';
		flpa.Anno__c = '2017';
		flpa.Prezzo__c = 4.65;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '2';
		flpa.Anno__c = '2029';
		flpa.Prezzo__c = 2.5;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '3';
		flpa.Anno__c = '2028';
		flpa.Prezzo__c = 2.5;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '4';
		flpa.Anno__c = '2027';
		flpa.Prezzo__c = 2.5;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '5';
		flpa.Anno__c = '2026';
		flpa.Prezzo__c = 2.5;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '6';
		flpa.Anno__c = '2025';
		flpa.Prezzo__c = 2.5;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '7';
		flpa.Anno__c = '2024';
		flpa.Prezzo__c = 2.5;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '8';
		flpa.Anno__c = '2023';
		flpa.Prezzo__c = 2.63;
		flpaList.add(flpa);

		flpa = new OF_FiberLeaseListinoPrezzoAnnuo__c();
		flpa.Name = '9';
		flpa.Anno__c = '2022';
		flpa.Prezzo__c = 2.79;
		flpaList.add(flpa);
		insert flpaList;

		List<OF_FiberLeasePrezzoMedioAnnuo__c> flpmList = new List<OF_FiberLeasePrezzoMedioAnnuo__c>();
		OF_FiberLeasePrezzoMedioAnnuo__c flpm = new OF_FiberLeasePrezzoMedioAnnuo__c();
		flpm.Name = 'Backbone1';
		flpm.Prezzo__c = 0.34;
		flpmList.add(flpm);

		flpm = new OF_FiberLeasePrezzoMedioAnnuo__c();
		flpm.Name = 'Backbone2';
		flpm.Prezzo__c = 0.34;
		flpmList.add(flpm);

		flpm = new OF_FiberLeasePrezzoMedioAnnuo__c();
		flpm.Name = 'CostanteFiberLease1';
		flpm.Prezzo__c = 0.08;
		flpmList.add(flpm);

		flpm = new OF_FiberLeasePrezzoMedioAnnuo__c();
		flpm.Name = 'CostanteFiberLease2';
		flpm.Prezzo__c = 0.55;
		flpmList.add(flpm);

		flpm = new OF_FiberLeasePrezzoMedioAnnuo__c();
		flpm.Name = 'Drop1';
		flpm.Prezzo__c = 2.63;
		flpmList.add(flpm);

		flpm = new OF_FiberLeasePrezzoMedioAnnuo__c();
		flpm.Name = 'Drop2';
		flpm.Prezzo__c = 2.63;
		flpmList.add(flpm);

		flpm = new OF_FiberLeasePrezzoMedioAnnuo__c();
		flpm.Name = 'Drop2AltreCoppie';
		flpm.Prezzo__c = 0.84;
		flpmList.add(flpm);

		insert flpmList;
	}

	public static Account createAccount(String nome, String codOp) {
		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account acc = new Account();
		acc.Name = nome;
		acc.Type = 'OLO';
		acc.EOF_Codice_Operatore__c = codOp;
		acc.RecordTYpeId = AccountRecordTypeId;
		insert acc;
		return acc;
	}

	public static Contract createContract(Account acc, OF_Servizio__c srv) {
		Contract contratto = new Contract();
		contratto.Name = 'TEST_TIS_001';
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.Id;
		contratto.ContractTerm = 24;
		contratto.StartDate = System.today();
		contratto.Status = 'Attivo';
		insert contratto;

		OF_ContrattoServizio__c contrattoServizio = new OF_ContrattoServizio__c();
		contrattoServizio.OF_Servizio__c = srv.Id;
		contrattoServizio.OF_Contract__c = contratto.Id;
		insert contrattoServizio;

		return contratto;
	}

	public static Case createCase(Account acc, Id rtId, String idRisorsa, String srvName, Contract contr, Case parentCase, Case caseRichiesta) {
		Case c = new Case();
		c.AccountId = acc.Id;
		//c.EOF_Account_OLO__c = acc.Id;
		c.Status = 'Acquisito';
		c.RecordTypeId = rtId;
		c.EOF_Id_Risorsa__c = idRisorsa;
		if (parentCase != null) {
			c.ParentId = parentCase.Id;
		}
		c.SN_bypassValidation__c = false;
		c.PO_Data_Attivazione_Ordine__c = System.today();
		c.PO_Offerta__c = srvName;
		c.OF_Servizio__c = srvName;
		c.OF_IDContratto__c = contr.Id;
		c.PO_Accordo_Quadro__c = contr.Id;
		c.PO_Accordo_Quadro_Number__c = contr.Name;
		c.PO_Comune__c = 'Roma';
		c.EOF_Identificativo_del_POP__c = 'abc';
		c.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = 'via roma';
		c.PO_PP_NomeKit__c = 'kitkat';
		c.PO_P2PAttiva_KIT_OpticalRateLimiting__c = '255';
		c.PO_Esito_collegamento__c = 'SI in FTTH';
		c.EOF_Fase__C = 'Completato';
		c.PO_Costo_lavori_civili__c = 10;

		if (caseRichiesta != null) {
			c.PO_Richiesta_a_fattibilit__c = caseRichiesta.Id;
			c.PO_Richiesta_a_fattibilit_ordine__c = caseRichiesta.Id;
			c.Accordo_Operativo__c = caseRichiesta.CaseNumber;
		}

		insert c;
		return c;
	}

	public static Order createOrder(Contract contr, Case c) {
		Order o = new Order();
		o.ContractId = contr.Id;
		o.AccountId = c.AccountId;
		o.RecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
		o.Status = 'Aperto';
		o.OF_Esito__c = 'OK';
		o.OF_DataEsito__c = System.today();
		o.EffectiveDate = System.today();
		o.OF_IDOrdineEOF__c = c.Id;
		o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;

		insert o;
		return o;
	}

	public static OF_CatalogoCommerciale__c createCatalogo() {
		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;
		return catalogo;
	}

	public static OF_Servizio__c createServizio(OF_CatalogoCommerciale__c cat, String n, String code) {
		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = n;
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio;
		servizio.OF_DataFineValidita__c = fine;
		servizio.OF_CatalogoCommerciale__c = cat.id;
		servizio.OF_Servizio_Code__c = code;

		insert servizio;
		return servizio;
	}

	public static OF_CommercialElement__c createCE(OF_Servizio__c serv, String nome, String code) {
		OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		ce.name = nome;
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio;
		ce.OF_DataFineValidita__c = fine;
		ce.OF_Servizio__c = serv.id;
		ce.OF_Commercial_Element_Code__c = code;
		insert ce;
		return ce;
	}

	public static OF_BillingElement__c createBE(OF_CommercialElement__c ce, String n, String code) {
		OF_BillingElement__c be = new OF_BillingElement__c();
		be.name = n;
		be.OF_CommercialElement__c = ce.id;
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		be.OF_Attivo__c = true;
		be.OF_DataInizioValidita__c = inizio;
		be.OF_DataFineValidita__c = fine;
		be.OF_Billing_Element_Code__c = code;
		insert be;
		return be;
	}

	public static Pricebook2 createPriceBook(OF_CommercialElement__c ce, OF_BillingElement__c be, OF_Listino__c listino) {
		Pricebook2 pb = new Pricebook2();
		pb.name = be.Name;
		pb.Billing_element__c = be.Id;
		pb.PO_Commercial_element__c = ce.Id;
		pb.IsActive = true;
		pb.Unit_Price__c = 10;
		pb.OF_Listino__c = listino.Id;
		insert pb;
		return pb;
	}

	public static void createProductAppoggio() {
		Id pbsId = Test.getStandardPricebookId();
		List<PricebookEntry> pbeToInsert = new List<PricebookEntry>();
		Product2 pApp = new Product2(
			Name = 'SERV_FATT_APPOGGIO',
			IsActive = true
		);
		insert pApp;

		PricebookEntry pbeApp = new PricebookEntry(
			Pricebook2Id = pbsId,
			Product2Id = pApp.Id,
			UnitPrice = 1,
			IsActive = true
		);
		pbeToInsert.add(pbeApp);

		Pricebook2 pbApp = new Pricebook2 (
			IsActive = true,
			Name = 'SERV_FATT_APPOGGIO',
			Unit_Price__c = 1
		);
		insert pbApp;

		PricebookEntry pbeApp2 = new PricebookEntry(
			Pricebook2Id = pbApp.Id,
			Product2Id = pApp.Id,
			UnitPrice = 1,
			IsActive = true
		);
		pbeToInsert.add(pbeApp2);
		insert pbeToInsert;
	}

	public static List<PricebookEntry> createPriceBooksWithProduct(List<OF_BillingElement__c> beList, OF_Listino__c listino) {
		List<Pricebook2> pbList = new List<Pricebook2>();
		List<Product2> prodList = new List<Product2>();
		for (OF_BillingElement__c be : beList) {
			Pricebook2 pb = new Pricebook2();
			pb.name = be.Name;
			pb.Billing_element__c = be.Id;
			pb.PO_Commercial_element__c = be.OF_CommercialElement__c;
			pb.IsActive = true;
			pb.Unit_Price__c = 10;
			pb.OF_Listino__c = listino.Id;
			pbList.add(pb);

			Product2 p = new Product2();
			p.name = be.Name;
			p.OF_BillingElement__c = be.Id;
			p.IsActive = true;
			prodList.add(p);
		}

		insert pbList;
		insert prodList;

		List<PricebookEntry> pbeList = new List<PricebookEntry>();
		List<PricebookEntry> pbeToInsert = new List<PricebookEntry>();
		Id pbsId = Test.getStandardPricebookId();
		Integer len = prodList.size();
		for (Integer i = 0; i < len; i++) {
			Product2 p = prodList.get(i);
			Pricebook2 pb = pbList.get(i);
			PricebookEntry pbes = new PricebookEntry();
			pbes.Pricebook2Id = pbsId;
			pbes.Product2Id = p.Id;
			pbes.UnitPrice = 100;
			pbes.IsActive = true;
			pbeToInsert.add(pbes);

			PricebookEntry pbe = new PricebookEntry();
			pbe.Pricebook2Id = pb.Id;
			pbe.Product2Id = p.Id;
			pbe.UnitPrice = 100;
			pbe.IsActive = true;
			pbeList.add(pbe);
			pbeToInsert.add(pbe);
		}
		insert pbeToInsert;

		return pbeList;
	}

	public static PricebookEntry createPBE(Pricebook2 pb, Product2 p, OF_CommercialElementIstanziato__c cei) {
		PricebookEntry pbe = new PricebookEntry();
		pbe.Pricebook2Id = pb.Id;
		pbe.Product2Id = p.Id;
		pbe.UnitPrice = 100;
		pbe.OF_Asset__c = cei.OF_Asset__c;
		pbe.OF_CommercialElementIstanziato__c = cei.Id;
		pbe.IsActive = true;
		insert pbe;
		return pbe;
	}

	public static Product2 createProduct(OF_BillingElement__c be) {
		Product2 p = new Product2();
		p.name = be.Name;
		p.OF_BillingElement__c = be.Id;
		p.IsActive = true;
		insert p;
		return p;
	}

	public static Opportunity createOpportunity(Account acc, Case c, String nome, Id rtId) {
		Opportunity o = new Opportunity();
		o.name = nome;
		o.AccountId = acc.Id;
		o.StageName = 'Prospecting';
		o.CloseDate = System.today().addDays(99);
		o.RecordTypeId = rtId;
		o.PO_Collegamento__c = c.Id;
		o.PO_Sconto_canone__c = 0.0;
		o.PO_Sconto_costi_aggiuntivi__c = 0.0;
		o.PO_Sconto_contributi_attivazione__c = 0.0;
		o.PO_Sconto_canone_manutenzione__c = 0.0;
		o.PO_Sconto_corrispettivo_IRU__c = 0.0;
		o.PO_ScontoCanone_annuo_Collegameno_1anno__c = 0.0;
		o.PO_ScontoCanone_annuo_Collegameno_2anno__c = 0.0;
		o.PO_ScontoCanone_annuo_Collegameno_3anno__c = 0.0;
		o.PO_Sconto_ContributoAttivaz_Colleg1anno__c = 0.0;
		o.PO_Sconto_ContributoAttivaz_Colleg2anno__c = 0.0;
		o.PO_Sconto_ContributoAttivaz_Colleg3anno__c = 0.0;
		insert o;
		return o;
	}

	public static OF_Listino__c createListino(OF_Servizio__c s, String nome) {
		OF_Listino__c l = new OF_Listino__c();
		l.name = nome;
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		l.Servizio__c = s.Id;
		l.OF_Attivo__c = true;
		l.OF_ListinoDefault__c = true;
		l.OF_DataInizioValidita__c = inizio;
		l.OF_Attivo__c = true;
		l.OF_ListinoDefault__c = true;
		l.OF_DataFineValidita__c = fine;
		l.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Fattibilità' LIMIT 1].Id;

		insert l;
		return l;
	}

	public static EOF_EAI_Service_Log__c createLog(Case c) {
		EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
		log.EOF_Stato_Richiesta__c = c.Status;
		log.EOF_STATO_ORDINE__c = c.Status;
		log.Caso__c = c.Id;
		log.PO_Offerta__c = c.PO_Offerta__c;
		log.EOF_Comune__c = c.PO_Comune__c;

		insert log;
		return log;
	}

	public static Asset createAsset(String nome, String rtId, Account acc, Contract contr) {
		Asset ass = new Asset();
		ass.Name = nome;
		ass.EOF_ID_Risorsa__c = nome;
		ass.Status = 'Attivo';
		ass.OF_Comune__c = 'Roma';
		ass.OF_Particella_Toponomastica__c = 'via';
		ass.OF_Indirizzo__c = 'Roma';
		ass.OF_Civico__c = '12';
		ass.AccountId = acc.id;
		ass.OF_Contract__c = contr.Id;
		ass.OF_DataAttivazione2__c = System.now();
		ass.RecordTypeId = rtId;

		insert ass;
		return ass;
	}

	public static OF_AreaGeograficaJunction__c createAreaGeograficaJunction(Contract contr, String comune) {
		OF_AreaGeograficaJunction__c areaGeografica = new OF_AreaGeograficaJunction__c();
		areaGeografica.OF_Contratto__c = contr.Id;
		areaGeografica.OF_Comune__c = comune;
		insert areaGeografica;
		return areaGeografica;
	}

	public static WrapData createP2PBaseData() {
		PO_ServFatt_DataFactory.createCustomSettings();
		ServFattList__c cs = ServFattList__c.getAll().get('P2P Base');
		Map<String, Id> rtDevNameIdMap = PO_ServFatt_DataFactory.getRtDevNameIdMap();
		Id caseOrdineRt = rtDevNameIdMap.get(cs.caseDevName__c);
		Id caseRichiestaRt = rtDevNameIdMap.get(cs.caseRichiestaDevName__c);
		Id caseCollegamentoRt = rtDevNameIdMap.get(cs.caseCollegamentoDevName__c);

		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		PO_ServFatt_DataFactory.createAreaGeograficaJunction(contr, 'Roma');
		OF_Listino__c listino_monofibra = PO_ServFatt_DataFactory.createListino(serv, 'P2PBASE_MONOFIBRA');
		OF_Listino__c listino_bifibra = PO_ServFatt_DataFactory.createListino(serv, 'P2PBASE_BIFIBRA');
		OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'Punto Punto Passiva', 'CE-OF000009');
		List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Attivazione', 'BE-OF000020'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Canone', 'BE-OF000018'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Aggiuntivo', 'BE-OF000017'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Disattivazione', 'BE-OF000019'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Migrazione', 'BE-OF000021'));
		PO_ServFatt_DataFactory.createProductAppoggio();
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, listino_monofibra);
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, listino_bifibra);
		Case caseRichiesta = PO_ServFatt_DataFactory.createCase(acc, caseRichiestaRt, 'richiesta', cs.Name, contr, null, null);
		Case caseColl = PO_ServFatt_DataFactory.createCase(acc, caseCollegamentoRt, 'collegamento', cs.Name, contr, caseRichiesta, caseRichiesta);
		Case caseOrd = PO_ServFatt_DataFactory.createCase(acc, caseOrdineRt, 'ordine', cs.Name, contr, caseColl, caseRichiesta);
		Order o = PO_ServFatt_DataFactory.createOrder(contr, caseOrd);

		caseRichiesta.OF_Order__c = o.Id;
		caseRichiesta.PO_Case_Collegamento__c = caseColl.Id;

		caseOrd.PO_Case_Collegamento__c = caseColl.Id;
		caseOrd.OF_Order__c = o.Id;

		List<Case> list_toUpdate = new List<Case>();
		list_toUpdate.add(caseRichiesta);
		list_toUpdate.add(caseOrd);

		update list_toUpdate;

		EOF_EAI_Service_Log__c logRich = PO_ServFatt_DataFactory.createLog(caseRichiesta);
		EOF_EAI_Service_Log__c logColl = PO_ServFatt_DataFactory.createLog(caseColl);

		Opportunity oppChild = PO_ServFatt_DataFactory.createOpportunity(acc, caseColl, cs.oppChildName__c, rtDevNameIdMap.get(cs.oppChildDevName__c));

		WrapData toReturn = new WrapData();
		toReturn.casePadre = caseRichiesta;
		toReturn.caseCollegamento = caseColl;
		toReturn.caseOrdine = caseOrd;
		toReturn.oppChild = oppChild;
		toReturn.logCollegamento = logColl;
		toReturn.logRichiesta = logRich;
		toReturn.cs = cs;

		return toReturn;
	}

	public static WrapData createP2PAttivaData() {
		PO_ServFatt_DataFactory.createCustomSettings();
		ServFattList__c cs = ServFattList__c.getAll().get('P2P Attiva');
		Map<String, Id> rtDevNameIdMap = PO_ServFatt_DataFactory.getRtDevNameIdMap();
		Id caseOrdineRt = rtDevNameIdMap.get(cs.caseDevName__c);
		Id caseRichiestaRt = rtDevNameIdMap.get(cs.caseRichiestaDevName__c);
		Id caseCollegamentoRt = rtDevNameIdMap.get(cs.caseCollegamentoDevName__c);
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		PO_ServFatt_DataFactory.createAreaGeograficaJunction(contr, 'Roma');
		OF_Listino__c l = PO_ServFatt_DataFactory.createListino(serv, 'P2PAttiva_100M');
		OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'Punto Punto Attiva', 'CE-OF000010');
		OF_CommercialElement__c ceKit = PO_ServFatt_DataFactory.createCE(serv, 'KIT di consegna', 'CE-OF000011');
		List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Canone', 'BE-OF000022'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Aggiuntivo', 'BE-OF000023'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Disattivazione', 'BE-OF000024'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Attivazione', 'BE-OF000025'));
		beList.add(PO_ServFatt_DataFactory.createBE(ceKit, 'Contributo Attivazione', 'BE-OF000026'));
		PO_ServFatt_DataFactory.createProductAppoggio();
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l);
		Id caseKitRtId = rtDevNameIdMap.get('PO_Case_P2P_Attiva_KIT');
		Case c = PO_ServFatt_DataFactory.createCase(acc, caseRichiestaRt, 'case_richiesta', cs.Name, contr, null, null);
		Case cColl = PO_ServFatt_DataFactory.createCase(acc, caseCollegamentoRt, 'case_collegamento', cs.Name, contr, c, c);
		Case caseKit = PO_ServFatt_DataFactory.createCase(acc, caseKitRtId, 'case_kit', 'KIT', contr, cColl, null);
		Case caseOrd = PO_ServFatt_DataFactory.createCase(acc, caseOrdineRt, 'ordine', cs.Name, contr, cColl, c);
		Order o = PO_ServFatt_DataFactory.createOrder(contr, c);

		c.OF_Order__c = o.Id;
		caseOrd.OF_Order__c = o.Id;
		c.PO_Case_Collegamento__c = cColl.Id;
		c.PO_KIT_Consegna_VLAN__c = caseKit.Id;
		c.OF_SA_Profilo__c = '100M';
		cColl.OF_SA_Profilo__c = '100M';
		cColl.PO_KIT_Consegna_VLAN__c = caseKit.Id;
		cColl.PO_Richiesta_a_fattibilit__c = c.Id;
		caseKit.PO_Case_Collegamento__c = cColl.Id;
		caseKit.PO_Richiesta_a_fattibilit_KIT__c = c.Id;
		caseOrd.PO_KIT_Consegna_VLAN__c = caseKit.Id;

		List<Case> list_toUpdate = new List<Case>();
		list_toUpdate.add(c);
		list_toUpdate.add(cColl);
		list_toUpdate.add(caseOrd);
		list_toUpdate.add(caseKit);

		update list_toUpdate;

		Opportunity oppChild = PO_ServFatt_DataFactory.createOpportunity(acc, cColl, cs.oppChildName__c, rtDevNameIdMap.get(cs.oppChildDevName__c));

		EOF_EAI_Service_Log__c logRich = PO_ServFatt_DataFactory.createLog(c);
		EOF_EAI_Service_Log__c logColl = PO_ServFatt_DataFactory.createLog(cColl);

		WrapData toReturn = new WrapData();
		toReturn.casePadre = c;
		toReturn.caseCollegamento = cColl;
		toReturn.caseOrdine = caseOrd;
		toReturn.caseKit = caseKit;
		toReturn.oppChild = oppChild;
		toReturn.logCollegamento = logColl;
		toReturn.logRichiesta = logRich;
		toReturn.cs = cs;

		return toReturn;
	}

	public static WrapData createFiberLinkData() {
		Map<String, Id> rtDevNameIdMap = PO_ServFatt_DataFactory.getRtDevNameIdMap();
		PO_ServFatt_DataFactory.createCustomSettings();
		ServFattList__c cs = ServFattList__c.getAll().get('Fiber Link');
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		PO_ServFatt_DataFactory.createAreaGeograficaJunction(contr, 'Roma');
		OF_Listino__c l1 = PO_ServFatt_DataFactory.createListino(serv, 'FLINK_DPPDVFIB22DC1F1');
		OF_Listino__c l2 = PO_ServFatt_DataFactory.createListino(serv, 'FLINK_DPPDVFIB22DC2F1');
		OF_Listino__c l3 = PO_ServFatt_DataFactory.createListino(serv, 'FLINK_DPPDVFIB22DC3F1');
		OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'Fiber Link', 'CE-OF000012');
		List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Canone', 'BE-OF000027'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Aggiuntivo', 'BE-OF000028'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Attivazione', 'BE-OF000029'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Disattivazione', 'BE-OF000030'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Migrazione', 'BE-OF000031'));
		PO_ServFatt_DataFactory.createProductAppoggio();
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l1);
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l2);
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l3);
		Id caseOrdineRt = rtDevNameIdMap.get(cs.caseDevName__c);
		Id caseRichiestaRt = rtDevNameIdMap.get(cs.caseRichiestaDevName__c);
		Id caseCollegamentoRt = rtDevNameIdMap.get(cs.caseCollegamentoDevName__c);
		Case c = PO_ServFatt_DataFactory.createCase(acc, caseRichiestaRt, 'richiesta', cs.Name, contr, null, null);
		Case c2 = PO_ServFatt_DataFactory.createCase(acc, caseCollegamentoRt, 'collegamento', cs.Name, contr, c, c);
		Case caseOrd = PO_ServFatt_DataFactory.createCase(acc, caseOrdineRt, 'ordine', cs.Name, contr, c2, c);
		EOF_EAI_Service_Log__c logRich = PO_ServFatt_DataFactory.createLog(c);
		Order o = PO_ServFatt_DataFactory.createOrder(contr, c);

		c.OF_Order__c = o.Id;
		c.PO_Case_Collegamento__c = c2.Id;
		c.OF_SA_Profilo__c = 'FLINK_SINGVFIB22DF1';
		c2.OF_SA_Profilo__c = 'FLINK_SINGVFIB22DF1';

		c2.PO_Tipo_percorso__c='DOPPIA VIA DIVERSIFICATA';
		c2.PO_Numero_fibre_richieste__c='2+2';
		c2.PO_BB_1_via_interessato__c=100;
		c2.PO_Posa_1_via_nuovo_Drop__c=200;

		caseOrd.PO_Case_Collegamento__c = c2.Id;
		caseOrd.OF_Order__c = o.Id;
		caseOrd.OF_SA_Profilo__c = PO_ServFatt_CRMHandler.FIBER_LINK_ALTRI_ANNI;
		update c;
		update c2;
		update caseOrd;

		EOF_EAI_Service_Log__c logColl = PO_ServFatt_DataFactory.createLog(c2);
		Id oppChildRt = rtDevNameIdMap.get(cs.oppChildDevName__c);
		Opportunity oppChild = PO_ServFatt_DataFactory.createOpportunity(acc, c2, cs.oppChildName__c, oppChildRt);

		WrapData toReturn = new WrapData();
		toReturn.casePadre = c;
		toReturn.caseCollegamento = c2;
		toReturn.caseOrdine = caseOrd;
		toReturn.oppChild = oppChild;
		toReturn.logCollegamento = logColl;
		toReturn.logRichiesta = logRich;
		toReturn.cs = cs;

		return toReturn;
	}

	public static WrapData createBTSData() {
		PO_ServFatt_DataFactory.createCustomSettings();
		ServFattList__c cs = ServFattList__c.getAll().get('BTS');
		Map<String, Id> rtDevNameIdMap = PO_ServFatt_DataFactory.getRtDevNameIdMap();
		Id caseOrdineRt = rtDevNameIdMap.get(cs.caseDevName__c);
		Id caseRichiestaRt = rtDevNameIdMap.get(cs.caseRichiestaDevName__c);
		Id caseCollegamentoRt = rtDevNameIdMap.get(cs.caseCollegamentoDevName__c);

		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		PO_ServFatt_DataFactory.createAreaGeograficaJunction(contr, 'Roma');
		OF_Listino__c l = PO_ServFatt_DataFactory.createListino(serv, 'BTS_DEF');
		OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'BTS', 'CE-OF000005');
		OF_CommercialElement__c ce2 = PO_ServFatt_DataFactory.createCE(serv, 'Manutenzione', 'CE-OF000006');
		List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
		beList.add(PO_ServFatt_DataFactory.createBE(ce2, 'Canone Manutenzione', 'BE-OF000012'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Corrispettivo IRU', 'BE-OF000011'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Aggiuntivo', 'BE-OF000009'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Attivazione', 'BE-OF000010'));
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Disattivazione', 'BE-OF000119'));
		PO_ServFatt_DataFactory.createProductAppoggio();
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l);
		Case caseRichiesta = PO_ServFatt_DataFactory.createCase(acc, caseRichiestaRt, 'richiesta', cs.Name, contr, null, null);
		Case caseColl = PO_ServFatt_DataFactory.createCase(acc, caseCollegamentoRt, 'collegamento', cs.Name, contr, caseRichiesta, caseRichiesta);
		Case caseOrd = PO_ServFatt_DataFactory.createCase(acc, caseOrdineRt, 'ordine', cs.Name, contr, caseColl, caseRichiesta);
		Order o = PO_ServFatt_DataFactory.createOrder(contr, caseOrd);

		caseRichiesta.OF_Order__c = o.Id;
		caseRichiesta.PO_Case_Collegamento__c = caseColl.Id;

		caseOrd.PO_Case_Collegamento__c = caseColl.Id;
		caseOrd.OF_Order__c = o.Id;

		update caseRichiesta;
		update caseOrd;

		EOF_EAI_Service_Log__c logRich = PO_ServFatt_DataFactory.createLog(caseRichiesta);
		EOF_EAI_Service_Log__c logColl = PO_ServFatt_DataFactory.createLog(caseColl);

		Opportunity oppChild = PO_ServFatt_DataFactory.createOpportunity(acc, caseColl, cs.oppChildName__c, rtDevNameIdMap.get(cs.oppChildDevName__c));

		WrapData toReturn = new WrapData();
		toReturn.casePadre = caseRichiesta;
		toReturn.caseCollegamento = caseColl;
		toReturn.caseOrdine = caseOrd;
		toReturn.oppChild = oppChild;
		toReturn.logCollegamento = logColl;
		toReturn.logRichiesta = logRich;
		toReturn.cs = cs;

		return toReturn;
	}

	public static WrapData createFiberLeaseData() {
		Map<String, Id> rtDevNameIdMap = PO_ServFatt_DataFactory.getRtDevNameIdMap();
		PO_ServFatt_DataFactory.createCustomSettings();
		ServFattList__c cs = ServFattList__c.getAll().get('Fiber Lease');
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		PO_ServFatt_DataFactory.createAreaGeograficaJunction(contr, 'Roma');
		OF_Listino__c l = PO_ServFatt_DataFactory.createListino(serv, 'Fiber Lease');
		OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'Fiber Lease', 'CE-OF000138');
		List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
		beList.add(PO_ServFatt_DataFactory.createBE(ce, 'Contributo Attivazione', 'BE-OF000216'));
		PO_ServFatt_DataFactory.createProductAppoggio();
		PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l);
		Id caseOrdineRt = rtDevNameIdMap.get(cs.caseDevName__c);
		Id caseRichiestaRt = rtDevNameIdMap.get(cs.caseRichiestaDevName__c);
		Id caseCollegamentoRt = rtDevNameIdMap.get(cs.caseCollegamentoDevName__c);
		Case caseRichiesta = PO_ServFatt_DataFactory.createCase(acc, caseRichiestaRt, 'richiesta', cs.Name, contr, null, null);
		Case caseColl = PO_ServFatt_DataFactory.createCase(acc, caseCollegamentoRt, 'collegamento', cs.Name, contr, caseRichiesta, caseRichiesta);
		Case caseOrd = PO_ServFatt_DataFactory.createCase(acc, caseOrdineRt, 'ordine', cs.Name, contr, caseColl, caseRichiesta);
		Order o = PO_ServFatt_DataFactory.createOrder(contr, caseOrd);

		caseRichiesta.OF_Order__c = o.Id;
		caseRichiesta.PO_Case_Collegamento__c = caseColl.Id;

		caseColl.PO_Posa_1_nuovo_Drop__c = 100;

		caseOrd.PO_Case_Collegamento__c = caseColl.Id;
		caseOrd.OF_Order__c = o.Id;

		EOF_EAI_Service_Log__c logRich = PO_ServFatt_DataFactory.createLog(caseRichiesta);
		EOF_EAI_Service_Log__c logColl = PO_ServFatt_DataFactory.createLog(caseColl);

		update caseRichiesta;
		update caseColl;
		update caseOrd;
		RecordType oppChildRt = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.oppChildDevName__c LIMIT 1];
		Opportunity oppChild = PO_ServFatt_DataFactory.createOpportunity(acc, caseColl, cs.oppChildName__c, oppChildRt.Id);

		WrapData toReturn = new WrapData();
		toReturn.casePadre = caseRichiesta;
		toReturn.caseCollegamento = caseColl;
		toReturn.caseOrdine = caseOrd;
		toReturn.oppChild = oppChild;
		toReturn.logCollegamento = logColl;
		toReturn.logRichiesta = logRich;
		toReturn.cs = cs;

		return toReturn;
	}

	public static Map<String, Id> getRtDevNameIdMap() {
		Map<String, Id> rtDevNameIdMap = new Map<String, Id>();
		for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType]) {
			rtDevNameIdMap.put(rt.DeveloperName, rt.Id);
		}
		return rtDevNameIdMap;
	}
}
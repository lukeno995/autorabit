@isTest
public class OF_UtilitiesManageOrderFromCaseTEST {
/*  @testSetup
    static void createData() {
        //Creazione Catalogo commerciale
        List<OF_Servizio__c> listServizi = new List<OF_Servizio__c>();
        List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
        List<OF_BillingElement__c> listBillingElement = new List<OF_BillingElement__c>();

        listServizi = OF_AreaGeograficaUtilityTest.createServizi();
        listCommercial=OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
        listBillingElement = OF_AreaGeograficaUtilityTest.createBillingElement(listCommercial);

        List<Account> listAccount = new List<Account>();
        listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO();

        Map<ID,String> mapAcc = new Map<ID,String>();
        List<Contract> listContract = new List<Contract>();
        OF_AreaGeograficaUtilityTest.getMappa(listAccount);//getMappa
        listContract = OF_AreaGeograficaUtilityTest.createContract(listAccount);
        OF_AreaGeograficaUtilityTest.createAreaGeoJunction(listContract, listServizi);

        //Creazione Associazione Contratti-Servizi
        List<OF_ContrattoServizio__c> listContrServ = new List<OF_ContrattoServizio__c>();
        listContrServ = OF_AreaGeograficaUtilityTest.createContractService(listContract,listServizi,mapAcc);

        //Creazione Listini
        List<OF_ServizioBillingElement__c> listServiziBillingElement = new List<OF_ServizioBillingElement__c>();
        listServiziBillingElement=OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement,listContrServ);
        createListini(listServiziBillingElement);

        //Creazione custom setting
        list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
        CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

        OF_Configurazioni__c CustSett1 = new OF_Configurazioni__c();
        CustSett1 = OF_AreaGeograficaUtilityTest.CustomSetting1();

        list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
        CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

        Parametri_Fattibilita__c CustSett3 = new Parametri_Fattibilita__c();
        CustSett3 = OF_AreaGeograficaUtilityTest.CustomSetting3();
    }
 */
	public static void createPriceBookEntryAtt( Product2 prod, PriceBook2 PriceB,ID assetID) {
		PriceBookEntry prE = new PriceBookEntry();
		prE.Product2Id = prod.Id;
		prE.Pricebook2Id = PriceB.Id;
		prE.OF_Asset__c = assetID;
		prE.UnitPrice = -9.999;
		prE.IsActive = true;
		insert prE;
		return;
	}

	public static void createPriceBookEntryCess( Product2 prod, PriceBook2 PriceB,ID assetID) {
		PriceBookEntry prE = new PriceBookEntry();
		prE.Product2Id = prod.Id;
		prE.Pricebook2Id = PriceB.Id;
		prE.OF_Asset__c = assetID;
		prE.UnitPrice = -9.999;
		prE.IsActive = false;
		insert prE;
		return;
	}

	public static void createListini(List<OF_ServizioBillingElement__c> listServizioBilling) {

		String ListRecordTypeAttId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();

		List<OF_Listino__c> listListini = new List<OF_Listino__c>();

		Integer i = 0;
		for (OF_ServizioBillingElement__c item : listServizioBilling)
		{
			OF_Listino__c listinoItem = new OF_Listino__c();
			if (item.OF_ServizioNome__c == 'Open Stream') {

				listinoItem.RecordTypeId = ListRecordTypeAttId;
				listinoItem.Name = item.Name;
				listinoItem.OF_Attivo__c=true;
				listinoItem.OF_DataInizioValidita__c = Date.newInstance(1990,04,24);
				listinoItem.OF_DataFineValidita__c = Date.newInstance(2020,04,24);
				listinoItem.OF_IDContract__c = item.OF_Contract__c;
				listinoItem.OF_ServizioBillingElement__c = item.Id;
				listinoItem.OF_Promozione__c = 'test';
				listinoItem.OF_CodiceProgettoSpeciale__c = 'test';
				listinoItem.OF_ClusterPromozione__c = 'test';
				listinoItem.OF_TipologiaApparato__c = 'test';
				listinoItem.OF_ListinoDefault__c = true;

				listListini.add(listinoItem);
				i++;
				if (i == 10) { break;}
			}
		}
		if (( listListini != null) && ( listListini.size() > 0) ) {
			insert listListini;
		}
	}

	static Map<String,String> RecordType() {
		//Record Type
		List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Asset' OR sObjectType = 'EOF_EAI_Service_Log__c')  and isActive=true];

		Map<String,String> RecordType = new Map<String,String> {};

		for (RecordType rt: rtypes) {
			RecordType.put(rt.Name,rt.Id);
		}

		return RecordType;
	}

	public static testmethod void t1() {
		OF_AreaGeograficaUtilityTest.CustomSetting();
		OF_AreaGeograficaUtilityTest.CustomSetting1();
		OF_AreaGeograficaUtilityTest.CustomSetting2();
		OF_AreaGeograficaUtilityTest.CustomSetting3();

		PO_ServFatt_DataFactory.createCustomSettings();
		ServFattList__c cs = ServFattList__c.getAll().get('P2P Base');
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		//OF_Servizio__c servOpenStream = PO_ServFatt_DataFactory.createServizio(catal, 'Open Stream', 'SRV-OS-01');
		//OF_Servizio__c servGPON = PO_ServFatt_DataFactory.createServizio(catal, 'GPON Passiva', 'SRV-GP-01');
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		String assetRtId = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.assetDevName__c LIMIT 1].Id;
		Asset asset1 = PO_ServFatt_DataFactory.createAsset('idRisorsa', assetRtId, acc, contr);

		Id orderRecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'OF_INORDER' LIMIT 1].Id;
		RecordType caseRt = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.caseDevName__c LIMIT 1];

		Case c = new Case();

		test.startTest();
		OF_UtilitiesManageOrderFromCase.runOnce1();
		OF_UtilitiesManageOrderFromCase.runOnce1();
		OF_UtilitiesManageOrderFromCase.runOnce();
		OF_UtilitiesManageOrderFromCase.runOnce();
		OF_UtilitiesManageOrderFromCase umc = new OF_UtilitiesManageOrderFromCase();
		umc.setIDContratto('pippo');
		System.assertEquals('pippo', umc.getIDContratto());

		umc.SetKO_BK16();
		umc.SetKO_BK17();
		System.assertEquals('B_K17', umc.getstrCodice());
		umc.SetKO_B04();
		umc.SetKO_B05();
		System.assertEquals('OLO non abilitato all\'invio dell\'ordine', umc.getstrDescr());

		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_Attivazione');
		System.assertEquals('Attivo', umc.TipoServ(c));
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('EOF_Caso_Attivazione');
		System.assertEquals('Passivo', umc.TipoServ(c));
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_P2P_Attiva');
		System.assertEquals('P2PAttiva', umc.TipoServ(c));
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_Fiber_Lease');
		System.assertEquals('FiberLease', umc.TipoServ(c));
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_Fiber_Link');
		System.assertEquals('Fiber Link', umc.TipoServ(c));
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_IRU');
		System.assertEquals('IRU', umc.TipoServ(c));
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_Misto_Fiber_Lease_Link_per_Fastweb');
		System.assertEquals('MistoFiberLeaseLinkFastweb', umc.TipoServ(c));
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_P2P');
		System.assertEquals('P2PBase', umc.TipoServ(c));
		c.recordtypeId = null;
		System.assertEquals(null, umc.TipoServ(c));

		OF_CaseOrderStateModelCS__c csCaseOrder = new OF_CaseOrderStateModelCS__c(Name='CaseOrderStateModelCS',OF_RecordTypeOrder__c ='01258000000AhnYAAS',OF_StatoOrder__c ='Chiuso',OF_EsitoOrder__c='KO',OF_TipologiaFlusso__c = 'Cessazione');
		//insert csCaseOrder;
		c = PO_ServFatt_DataFactory.createCase(acc, caseRt.Id, 'test_abcd', cs.Name, contr, null, null);
		c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c.EOF_Identificativo_del_POP__c = 'PG_01';
		umc.CreateOrderKO(c, csCaseOrder);
		csCaseOrder.OF_RecordTypeOrder__c = orderRecordType;
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_P2P');
		c.EOF_Order_Manager__c = true;
		c.OF_SA_Profilo__c = '100M';

		umc.Verifica_BK17(null, null, null);
		umc.Verifica_B05(null, null, null);
		contr.Status = 'Cessato';
		Map<Id, OF_ContrattoServizio__c> contrServMap = new Map<Id, OF_ContrattoServizio__c>([SELECT Id, OF_Servizio__r.name, OF_Contract__c FROM OF_ContrattoServizio__c]);
		umc.Verifica_BK17(contr, c, contrServMap);
		umc.Verifica_B05(contr, c, contrServMap);
		contr = [SELECT Id, Status, StartDate, EndDate,OF_IdContratto__c, AccountId, ContractTerm FROM Contract WHERE Id = :contr.Id];
		contr.Status = 'Attivo';
		c.EOF_Data_Prevista_Attivazione__c = System.today().addDays(800);
		umc.Verifica_BK17(contr, c, contrServMap);
		umc.Verifica_B05(contr, c, contrServMap);
		c.EOF_Data_Prevista_Attivazione__c = System.today().addDays(5);
		umc.Verifica_BK17(contr, c, contrServMap);
		umc.Verifica_B05(contr, c, contrServMap);
		c.EOF_Account_OLO__c = acc.Id;
		umc.Verifica_BK17(contr, c, contrServMap);
		umc.Verifica_B05(contr, c, contrServMap);

		umc.CreateClienteRetail(null);
		c.AssetId = asset1.Id;
		update c;
		umc.CreateClienteRetail(c);

		umc.CreateOrderKO(null, null);
		umc.CreateOrderKO(c, csCaseOrder);
		umc.CreateOrder(c, null, null);
		umc.CreateOrder(c, csCaseOrder, OF_CodificaProfiloListini__c.getAll());

		umc.CreateMap(null);
		Map<Id, Set<Id>> caseMap = new Map<Id, Set<Id>>();
		umc.CreateMap(caseMap);
		caseMap.put(c.Id, new Set<Id>());
		umc.CreateMap(caseMap);

		umc.FindOpportunity(c.Id, null);
		Map<Id, List<Opportunity>> mappaOpp = new Map<Id, List<Opportunity>>();
		List<Opportunity> oppList = new List<Opportunity>();
		mappaOpp.put(c.Id, oppList);
		umc.FindOpportunity(c.Id, mappaOpp);
		Opportunity opp = new Opportunity();
		opp.StageName = 'Prospecting';
		oppList.add(opp);
		umc.FindOpportunity(c.Id, mappaOpp);

		umc.AggiornoCase(null, null);
		Map<Id, Case> caseMap2 = new Map<Id, Case>();
		Map<Id, Order> caseOrderMap = new Map<Id, Order>();
		Order o = PO_ServFatt_DataFactory.createOrder(contr, c);
		umc.AggiornoCase(caseOrderMap, caseMap2);
		caseMap2.put(c.Id, c);
		caseOrderMap.put(c.Id, o);
		umc.AggiornoCase(caseOrderMap, caseMap2);

		umc.getCaseCollegamentoFields(caseMap2);

		OF_UtilitiesManageOrderFromCase.AggiornoOrdine(null, null, null, null);
		OF_UtilitiesManageOrderFromCase.AggiornoOrdine(c, o, csCaseOrder, OF_CodificaProfiloListini__c.getAll());

		umc.VerificheCommContratt(null);
		umc.VerificheCommContratt1(null);

		List<EOF_Network_Inventory__c> netInvList = createNetworkInventory(c);
		OF_AreaGeograficaJunction__c agj = createAreaGeoJunction(c, serv, contr);

		umc.Verifica_BK16(contr, c, null, new List<OF_AreaGeograficaJunction__c> {agj});

		contr.Status = 'Attivo';
		update contr;
		serv.Name = 'GPON Passiva';
		update serv;
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('EOF_Caso_Attivazione');
		umc.VerificheCommContratt(c);
		umc.VerificheCommContratt1(c);

		serv.Name = 'Open Stream';
		update serv;
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_Attivazione');
		umc.VerificheCommContratt(c);
		umc.VerificheCommContratt1(c);

		umc.Verifica_BK16(contr, c, null, new List<OF_AreaGeograficaJunction__c>());

		test.stopTest();
	}

	public static testmethod void t2() {
		OF_AreaGeograficaUtilityTest.CustomSetting();
		OF_AreaGeograficaUtilityTest.CustomSetting1();
		OF_AreaGeograficaUtilityTest.CustomSetting2();
		OF_AreaGeograficaUtilityTest.CustomSetting3();

		PO_ServFatt_DataFactory.createCustomSettings();

		ServFattList__c cs = ServFattList__c.getAll().get('P2P Base');
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, 'Open Stream', cs.code__c);
		//OF_Servizio__c servOpenStream = PO_ServFatt_DataFactory.createServizio(catal, 'GPON Passiva', 'SRV-OS-01');
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		String assetRtId = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.assetDevName__c LIMIT 1].Id;
		Asset asset1 = PO_ServFatt_DataFactory.createAsset('idRisorsa', assetRtId, acc, contr);

		Id orderRecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'OF_INORDER' LIMIT 1].Id;
		RecordType caseRt = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.caseDevName__c LIMIT 1];

		OF_CaseOrderStateModelCS__c csCaseOrder = new OF_CaseOrderStateModelCS__c(Name='CaseOrderStateModelCS',OF_RecordTypeOrder__c ='01258000000AhnYAAS',OF_StatoOrder__c ='Chiuso',OF_EsitoOrder__c='KO',OF_TipologiaFlusso__c = 'Cessazione');
		Case c = PO_ServFatt_DataFactory.createCase(acc, caseRt.Id, 'test_abcd', cs.Name, contr, null, null);
		c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c.EOF_Identificativo_del_POP__c = 'PG_01';
		csCaseOrder.OF_RecordTypeOrder__c = orderRecordType;
		contr.Status = 'Attivo';
		c.EOF_Data_Prevista_Attivazione__c = System.today().addDays(800);
		c.EOF_Data_Prevista_Attivazione__c = System.today().addDays(5);
		c.EOF_Account_OLO__c = acc.Id;
		c.AssetId = asset1.Id;
		c.OF_Servizio__c = serv.Name;
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('EOF_Caso_Attivazione');
		update c;

		Set<Id> caseIds = new Set<Id> {c.Id};

		contr = [SELECT Id, Status, StartDate, EndDate,OF_IdContratto__c, AccountId, ContractTerm FROM Contract WHERE Id = :contr.Id];
		Map<Id, OF_ContrattoServizio__c> contrServMap = new Map<Id, OF_ContrattoServizio__c>([SELECT Id, OF_Servizio__r.name, OF_Contract__c FROM OF_ContrattoServizio__c]);

		test.startTest();
		OF_UtilitiesManageOrderFromCase umc = new OF_UtilitiesManageOrderFromCase();

		EOF_EAI_Service_Log__c log = PO_ServFatt_DataFactory.createLog(c);
		log.EOF_Data_Espletamento_Ordine__c = System.today();
		log.OF_SA_Direzione_Flusso__c = 'OM-SF';
		log.OF_SA_Metodo__c = 'OF_CompletionOrder_OpenStream';
		log.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_FiberNotify');
		update log;

		umc.DateAssetCEBE(null);
		umc.DateAssetCEBE(caseIds);

		log.OF_SA_Direzione_Flusso__c = 'SF-OLO';
		log.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_ACK');
		update log;
		umc.DateAssetCEBE(caseIds);

		asset1.Status = 'Cessato';
		update asset1;
		log.OF_SA_Direzione_Flusso__c = 'OM-SF';
		log.OF_SA_Metodo__c = 'OF_StatusUpdate';
		log.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_FiberNotify');
		update log;
		umc.DateAssetCEBE(caseIds);

		log.OF_SA_Direzione_Flusso__c = 'OLO-SF';
		log.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
		log.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_FiberNotify');
		update log;
		umc.DateAssetCEBE(caseIds);

		test.stopTest();
	}

	public static testmethod void t3() {
		OF_AreaGeograficaUtilityTest.CustomSetting();
		OF_AreaGeograficaUtilityTest.CustomSetting1();
		OF_AreaGeograficaUtilityTest.CustomSetting2();
		OF_AreaGeograficaUtilityTest.CustomSetting3();

		PO_ServFatt_DataFactory.createCustomSettings();

		ServFattList__c cs = ServFattList__c.getAll().get('P2P Base');
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, 'GPON Passiva', cs.code__c);
		//OF_Servizio__c servOpenStream = PO_ServFatt_DataFactory.createServizio(catal, 'Open Stream', 'SRV-OS-01');
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		String assetRtId = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.assetDevName__c LIMIT 1].Id;
		Asset asset1 = PO_ServFatt_DataFactory.createAsset('idRisorsa', assetRtId, acc, contr);

		Id orderRecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'OF_INORDER' LIMIT 1].Id;
		RecordType caseRt = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.caseDevName__c LIMIT 1];

		OF_CaseOrderStateModelCS__c csCaseOrder = new OF_CaseOrderStateModelCS__c(Name='CaseOrderStateModelCS',OF_RecordTypeOrder__c ='01258000000AhnYAAS',OF_StatoOrder__c ='Chiuso',OF_EsitoOrder__c='KO',OF_TipologiaFlusso__c = 'Cessazione');
		Case c = PO_ServFatt_DataFactory.createCase(acc, caseRt.Id, 'test_abcd', cs.Name, contr, null, null);
		c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
		c.EOF_Identificativo_del_POP__c = 'PG_01';
		csCaseOrder.OF_RecordTypeOrder__c = orderRecordType;
		contr.Status = 'Attivo';
		c.EOF_Data_Prevista_Attivazione__c = System.today().addDays(800);
		c.EOF_Data_Prevista_Attivazione__c = System.today().addDays(5);
		c.EOF_Account_OLO__c = acc.Id;
		c.AssetId = asset1.Id;
		c.OF_Servizio__c = serv.Name;
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('EOF_Caso_Attivazione');
		update c;

		Set<Id> caseIds = new Set<Id> {c.Id};

		contr = [SELECT Id, Status, StartDate, EndDate,OF_IdContratto__c, AccountId, ContractTerm FROM Contract WHERE Id = :contr.Id];
		Map<Id, OF_ContrattoServizio__c> contrServMap = new Map<Id, OF_ContrattoServizio__c>([SELECT Id, OF_Servizio__r.name, OF_Contract__c FROM OF_ContrattoServizio__c]);

		test.startTest();
		OF_UtilitiesManageOrderFromCase umc = new OF_UtilitiesManageOrderFromCase();

		List<EOF_Network_Inventory__c> netInvList = createNetworkInventory(c);
		OF_AreaGeograficaJunction__c agj = createAreaGeoJunction(c, serv, contr);

		umc.Verifica_B04(null, null, null, new List<OF_AreaGeograficaJunction__c> {agj});

		contr.Status = 'Attivo';
		update contr;
		umc.VerificheCommContratt(c);
		umc.VerificheCommContratt1(c);

		serv.Name = 'Open Stream';
		update serv;
		c.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_Attivazione');
		umc.VerificheCommContratt(c);
		umc.VerificheCommContratt1(c);

		test.stopTest();
	}

	public static testmethod void t4() {
		OF_AreaGeograficaUtilityTest.CustomSetting();
		OF_AreaGeograficaUtilityTest.CustomSetting1();
		OF_AreaGeograficaUtilityTest.CustomSetting2();
		OF_AreaGeograficaUtilityTest.CustomSetting3();

		PO_ServFatt_DataFactory.WrapData wrap = PO_ServFatt_DataFactory.createFiberLinkData();

		test.startTest();
		OF_UtilitiesManageOrderFromCase umc = new OF_UtilitiesManageOrderFromCase();
		Map<Id, Case> casePadreMap = new Map<Id, Case>();
		casePadreMap.put(wrap.casePadre.Id, wrap.casePadre);
		Map<Id, Case> caseCollegMap  = new Map<Id, Case>();
		caseCollegMap.put(wrap.caseCollegamento.Id, wrap.caseCollegamento);
		umc.CreateOrderPO(null, null, null, null);
		umc.CreateOrderPO(wrap.casePadre.Id, casePadreMap, wrap.oppChild, caseCollegMap);

		test.stopTest();
	}

	public static List<EOF_Network_Inventory__c> createNetworkInventory(Case c) {
		OF_SA_Network_Inventory_Attivi__c nia = new OF_SA_Network_Inventory_Attivi__c();
		nia.OF_SA_ID_Building__c = c.EOF_ID_Building_WS__c;
		nia.OF_SA_Pop__c = c.EOF_Identificativo_del_POP__c;
		nia.OF_SA_Comune__c = '22141';
		insert nia;

		List<EOF_Network_Inventory__c> netInvList = new list<EOF_Network_Inventory__c>();

		EOF_Network_Inventory__c netInv = new EOF_Network_Inventory__c();
		netInv.EOF_ID_Building__c = c.EOF_ID_Building_WS__c;
		netInv.EOF_Stato_Building__c = 110;
		netInv.EOF_Pop__c = c.EOF_Identificativo_del_POP__c;
		netInv.EOF_Comune__c = '22141';
		netInvList.add(netInv);

		netInv = new EOF_Network_Inventory__c();
		netInv.EOF_ID_Building__c = '987654321';
		netInv.EOF_Stato_Building__c = 110;
		netInv.EOF_Pop__c = c.EOF_Identificativo_del_POP__c;
		netInv.EOF_Comune__c = '20000';
		netInvList.add(netInv);

		insert netInvList;
		return netInvList;
	}

	public static OF_AreaGeograficaJunction__c createAreaGeoJunction(Case c, OF_Servizio__c serv, Contract contr) {
		OF_AreaGeograficaCustom__c areaGeoCustom = new OF_AreaGeograficaCustom__c();
		areaGeoCustom.OF_Comune__c = 'Perugia';
		areaGeoCustom.OF_Istat__c = '22141';
		insert areaGeoCustom;

		OF_AreaGeograficaJunction__c areaGeoJunction = new OF_AreaGeograficaJunction__c();
		areaGeoJunction.OF_Contratto__c = contr.Id;
		areaGeoJunction.OF_AreaGeografica__c = AreaGeoCustom.Id;
		areaGeoJunction.Servizio__c = serv.Id;

		insert areaGeoJunction;
		return areaGeoJunction;
	}
}
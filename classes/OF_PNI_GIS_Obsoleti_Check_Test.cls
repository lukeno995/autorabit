@isTest
public class OF_PNI_GIS_Obsoleti_Check_Test {

	public static Account accountCreation()
	{
		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		return acc;
	}

	public static Account accountOFCreation()
	{
		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account acc = new Account();
		acc.Name = 'OpenFiber';
		acc.Type = 'OLO';
		acc.EOF_Codice_Operatore__c = 'OF';
		acc.RecordTYpeId = AccountRecordTypeId;
		insert acc;
		return acc;
	}

	public static Account account_OLO_Creation()
	{
		String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account accOLO = new Account();
		accOLO.Name = 'Vodafone';
		accOLO.EOF_Codice_Operatore__c = 'VF';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTYpeId = oloAccountRecordTypeId;
		insert accOLO;

		return accOLO;
	}

	public static Case caseActivationCreation(Account acc, Account accOLO, Asset asset_t,order ord)
	{
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
		list<case> vlstcase =  new list<case>();
		Case c = new Case();
		c.EOF_Account_OLO__c = accOLO.Id;
		c.Subject = 'Richiesta Attivazione';
		c.EOF_Codice_Ordine_OLO__c = '02112016_37';
		c.EOF_Data_Prevista_Attivazione__c = system.today();
		c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c.Status = 'Espletato';
		c.EOF_Fase__c = 'Espletato OK';
		c.Type = '1';
		c.EOF_Tipologia_Servizio__c = 'test1';
		c.EOF_Codice_Operatore_WS__c = 'VF';
		c.EOF_SLA_Premium_Assurance__c ='Y';
		c.Account = acc;
		c.AssetId = asset_t.id;
		c.OwnerId = userInfo.getUserId();
		c.RecordTypeId = CaseRecordTypeId;
		c.EOF_Id_Notifica__c = 'test_01';
		c.Origin = 'Web';
		c.Priority = 'Medium';
		c.EOF_GPON_Vincolante__c = 'Y';
		c.OF_Order__c=ord.id;
		insert c;

		return c;
	}

	public static Order orderCreation( OF_Asset_Verticale__c va, Asset asset_t, Account acc)
	{
		Order ordine = new Order();
		//ordine.OF_CaseID__c = c.id;
		ordine.OF_Asset_Verticale__c = va.id;
		ordine.OF_Asset__c = asset_t.id;
		ordine.AccountId = acc.id;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		insert ordine;

		return ordine;
	}

	public static OF_Asset_Verticale__c assetVerticaleCreation(Asset asset1)
	{
		OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();

		//va.stato__c = 'Attivo';
		va.Indirizzo__c = 'Nazionale';
		va.Civico__c = '34';
		va.Comune__c = 'Milano';
		va.ID_DB_Building__c = 'ID_DB_001';
		va.ID_DB_Scala_Palazzina__c = 'AX001';
		va.ID_GIS_Scala_Palazzina__c = asset1.EOF_ID_Risorsa__c;
		va.Particella_Toponomastica__c = 'Via';
		va.Cardinalita_Scala__c = 1;
		va.Asset__c=asset1.id;

		insert va;

		return va;
	}

	public static Asset assetCreation(Account acc, String contractId, String idRisorsa) {

		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR1234';
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = idRisorsa;
		asset_1.recordTypeId = assetRecordTypeId;
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contractId;
		asset_1.OF_DataAttivazione2__c = System.now();
		insert asset_1;

		return asset_1;
	}

	public static OF_Staging_PNI__c createStaging(String idGisScalaPalazzina, String idRisorsa) {

		OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
		staging.OF_Source_System__c = 'GIS';
		staging.OF_Civico__c = '12';
		staging.OF_ID_Building__c='test';
		staging.OF_Particella_Toponomastica__c='test1';
		staging.OF_Comune__c = 'Napoli';
		staging.OF_ID_GIS_ScalaPalazzina__c = idGisScalaPalazzina;
		staging.OF_Id_DB_Scala_palazzina__c='test2';
		staging.OF_UI_Scala_Palazzina__c='12345';
		staging.OF_Id_Risorsa__c = idRisorsa;
		staging.OF_Indirizzo__c = 'Malta';
		staging.OF_GIS_Data_Espletamento__c='2018-10-05 20:03:20';


		insert staging;

		return staging;
	}

	public static OF_CatalogoCommerciale__c Catalogo_Creation()
	{
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

	public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
	{
		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'VERTICALE';
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio;
		servizio.OF_DataFineValidita__c = fine;
		servizio.OF_CatalogoCommerciale__c = cat.id;

		insert servizio;
		return servizio;
	}

	public static Contract createContract(Account acc)
	{
		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_GPASS_001';
		contratto.AccountId = acc.id;
		insert contratto;
		return contratto;
	}

	public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
	{
		OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		ce.name = 'Servizio Verticale';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio;
		ce.OF_DataFineValidita__c = fine;
		ce.OF_Servizio__c = serv.id;
		insert ce;
		return ce;
	}

	public static OF_BillingElement__c createContributoVerticale(OF_CommercialElement__c ce)
	{
		OF_BillingElement__c be = new OF_BillingElement__c();
		be.name = 'Contributo Verticale';
		be.OF_CommercialElement__c = ce.id;
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		be.OF_Attivo__c = true;
		be.OF_DataInizioValidita__c = inizio;
		be.OF_DataFineValidita__c = fine;
		insert be;
		return be;
	}

	public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv)
	{
		OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
		conServ.OF_Contract__c = contr.Id;
		conServ.OF_Servizio__c = serv.id;

		insert conServ;
		return conServ;
	}

	public static OF_BillingElement__c createContributoStornoVerticale(OF_CommercialElement__c ce)
	{
		OF_BillingElement__c be = new OF_BillingElement__c();
		be.name = 'Contributo di storno Verticale';
		be.OF_CommercialElement__c = ce.id;
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		be.OF_Attivo__c = true;
		be.OF_DataInizioValidita__c = inizio;
		be.OF_DataFineValidita__c = fine;
		insert be;
		return be;
	}

	public static OF_Billing_Element_Verticale__c billingElementVCreation(Asset asset_t, Case c, OF_Asset_Verticale__c va)
	{
		OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
		verticalBE.name = 'BEV-' + asset_t.EOF_ID_Risorsa__c;
		verticalBE.ID_Risorsa__c = asset_t.EOF_ID_Risorsa__c;
		//verticalBE.OLO__c = c.EOF_Account_OLO__c;
		verticalBE.OF_Status__c = 'ATTIVO';
		verticalBE.Update_Billing__c = true;
		verticalBE.Data_Attivazione__c = asset_t.OF_DataAttivazione2__c;
		//Relaziono il BE Verticale all'Asset Standard
		verticalBE.Asset__c = asset_t.id;
		//Relaziono il BE Verticale all'Asset Verticale
		verticalBE.Asset_Verticale__c = va.id;
		insert verticalBE;
		return verticalBE;
	}

	public static OF_CommercialElementIstanziato__c  CEI_Creation(Asset assetStd,OF_CommercialElement__c CE)
	{
		OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
		//CEI.Name='Test';
		CEI.OF_Asset__c=assetStd.id;
		CEI.OF_Stato__c='Attivo';
		CEI.OF_CommercialElement__c=CE.id;
		CEI.OF_IDRisorsa__c = assetStd.EOF_ID_Risorsa__c;
		CEI.OF_DataAttivazione__c = System.now();
		insert CEI;
		return CEI;

	}

	public static testMethod void test_createStagingPNI() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;

		OF_WS_PNI_ResponseStaging.PNI_Obsoleto ob = new OF_WS_PNI_ResponseStaging.PNI_Obsoleto();
		ob.OF_CIVICO = '12';
		ob.OF_COMUNE = 'Napoli';
		ob.OF_ID_BUILDING = 'ID_001';
		ob.OF_ID_DB_SCALA_PALAZZINA = 'ID_DB_001';
		ob.OF_ID_GIS_SCALAPALAZZINA = 'ID_GI_001';
		ob.OF_ID_PALAZZINA = 'ID_P_001';
		ob.OF_ID_RISORSA = 'ID_RIS_001';
		ob.OF_INDIRIZZO = 'Meridionale';
		ob.OF_PALAZZINA = 'E4';
		ob.OF_PARTICELLA_TOPONOMASTICA = 'Corso';
		ob.OF_SCALA = 'A';
		ob.OF_SCALA_PALAZZINA = 'A12';
		ob.OF_UI_SCALA_PALAZZINA = 'A1234';

		List<OF_WS_PNI_ResponseStaging.PNI_Obsoleto> list_obs = new List<OF_WS_PNI_ResponseStaging.PNI_Obsoleto>();
		list_obs.add(ob);

		Test.startTest();

		OF_WS_PNI_ResponseStaging.PNI_Obsoleto_response resp = OF_PNI_GIS_Obsoleti_Check.createStagingPNI(list_obs);

		Test.stopTest();

	}

	private static testMethod void test_createStagingGIS() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom = new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;

		OF_WS_GIS_ResponseStaging.GIS_Obsoleto ob = new OF_WS_GIS_ResponseStaging.GIS_Obsoleto();

		ob.NUMERO_CIVICO = '12';
		ob.COMUNE = 'Napoli';
		ob.ID_BUILDING = 'ID_001';
		ob.ID_BUILDING_SCALA_PALAZZINA = 'ID_DB_001';
		ob.IDR_SCALA = 'ID_GI_001';
		ob.ID_RISORSA = 'ID_RIS_001';
		ob.INDIRIZZO = 'Meridionale';
		ob.PARTICELLA_TOPONOMASTICA = 'Corso';

		List<OF_WS_GIS_ResponseStaging.GIS_Obsoleto> list_obs = new List<OF_WS_GIS_ResponseStaging.GIS_Obsoleto>();
		list_obs.add(ob);

		Test.startTest();

		OF_WS_GIS_ResponseStaging.GIS_Obsoleto_response resp = OF_PNI_GIS_Obsoleti_Check.createStagingGIS(list_obs);

		Test.stopTest();
	}


	private static testMethod void test_updateElemVerticali1() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;



		Account acc = accountCreation();
		account accOf = accountOFCreation();
		Account accOLO = account_OLO_Creation();

		Contract contratto = createContract(acc);
		//Asset asset_1 = assetCreation(acc,contratto.id, 'IDR1234');
		Asset assetStd = assetCreation(acc,contratto.id, 'IDR1234');
		OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
		order ord=orderCreation(va,assetStd,acc);
		Case c = caseActivationCreation(acc, accOLO,assetStd,ord);

		OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

		//Order ord = orderCreation(c,va,assetStd,acc);
		OF_Staging_PNI__c stag = createStaging('IDR1234', assetStd.EOF_ID_Risorsa__c);
		List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
		lista_staging.add(stag);
		Asset assetConBEIDaInattivare = assetCreation(acc,contratto.id, 'IDR1235');
		OF_Asset_Verticale__c va2 = assetVerticaleCreation(assetConBEIDaInattivare);
		order ord2 = orderCreation(va2,assetConBEIDaInattivare,acc);
		// Case c2 = caseActivationCreation(acc, accOLO,assetConBEIDaInattivare,ord2);
		OF_Billing_Element_Verticale__c billingElemVert2 = billingElementVCreation(assetConBEIDaInattivare, null, va2);
		lista_staging.add(createStaging('N/D', assetConBEIDaInattivare.EOF_ID_Risorsa__c));

		assetCreation(acc,contratto.id, 'IDR1236');
		lista_staging.add(createStaging('N/A', 'IDR1236'));

		Asset asset4 = assetCreation(acc,contratto.id, 'IDR1237');
		OF_Asset_Verticale__c va4 = assetVerticaleCreation(asset4);
		order ord4 = orderCreation(va4,asset4,acc);
		//Case c4 = caseActivationCreation(acc, accOLO,asset4,ord4);
		OF_Billing_Element_Verticale__c billingElemVert4 = billingElementVCreation(assetConBEIDaInattivare, null, va4);
		lista_staging.add(createStaging('IDR1238', asset4.EOF_ID_Risorsa__c));

		OF_CatalogoCommerciale__c cat = Catalogo_Creation();
		//Contract contratto = createContract(acc);
		OF_Servizio__c serv = Servizio_Creation(cat);
		OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
		OF_CommercialElement__c ce_test = CE_Creation(serv);
		OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
		OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);

		OF_CommercialElementIstanziato__c CEI=CEI_Creation(assetStd,ce_test);


		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		// Run an update DML on the Pricebook2 record
		// This is the weird workaround that enables IsStandard to become true
		// on the PricebookEntry record
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = : standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;

		// Create the PricebookEntry
		PricebookEntry testPbe = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct.Id,
			UnitPrice = 100,
			OF_Asset__c=assetConBEIDaInattivare.Id,
			IsActive = true
		);
		insert testPbe;

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Storno Verticale',
			IsActive = true
		);
		insert testProduct1;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe1;

		Test.startTest();

		OF_PNI_GIS_Obsoleti_Check contr = new OF_PNI_GIS_Obsoleti_Check();
		contr.updateElemVerticali(lista_staging);
		//delete billingElemVert;
		//contr.updateElemVerticali(lista_staging);

		Test.stopTest();
	}



	private static testMethod void test_updateElemVerticali2() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;



		Account acc = accountCreation();
		account accOf = accountOFCreation();
		Account accOLO = account_OLO_Creation();

		Contract contratto = createContract(acc);

		OF_CatalogoCommerciale__c cat = Catalogo_Creation();
		//Contract contratto = createContract(acc);
		OF_Servizio__c serv = Servizio_Creation(cat);
		OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
		//Asset asset_1 = assetCreation(acc,contratto.id, 'IDR1234');
		//
		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		Asset assetStd= new Asset();
		assetStd.Name = 'IDR1234';
		assetStd.Status = 'Passivo';
		assetStd.EOF_ID_Risorsa__c = 'IDR1234';
		assetStd.recordTypeId = assetRecordTypeId;
		assetStd.accountId = acc.id;
		assetStd.OF_Contract__c = contratto.Id;
		insert assetStd;
		//Asset assetStd = assetCreation(acc,contratto.id, 'IDR1234');
		// assetStd.Status = 'Passivo';

		OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
		order ord=orderCreation(va,assetStd,acc);
		Case c = caseActivationCreation(acc, accOLO,assetStd,ord);

		OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

		//Order ord = orderCreation(c,va,assetStd,acc);
		// OF_Staging_PNI__c stag = createStaging();

		OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
		staging.OF_Source_System__c = 'GIS';
		staging.OF_Civico__c = '12';
		staging.OF_ID_Building__c='test';
		staging.OF_Particella_Toponomastica__c='test1';
		staging.OF_Comune__c = 'Napoli';
		staging.OF_ID_GIS_ScalaPalazzina__c = 'IDR1234';
		staging.OF_Id_DB_Scala_palazzina__c='test2';
		staging.OF_UI_Scala_Palazzina__c='12345';
		staging.OF_Id_Risorsa__c = 'N/A';
		staging.OF_Indirizzo__c = 'Malta';
		staging.OF_GIS_OLO__c='VF';
		staging.OF_GIS_Data_Espletamento__c='2018-10-05 20:03:20';


		insert staging;
		List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
		lista_staging.add(staging);


		OF_CommercialElement__c ce_test = CE_Creation(serv);
		OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
		OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);

		OF_CommercialElementIstanziato__c CEI=CEI_Creation(assetStd,ce_test);


		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		// Run an update DML on the Pricebook2 record
		// This is the weird workaround that enables IsStandard to become true
		// on the PricebookEntry record
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = :standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;

		// Create the PricebookEntry
		PricebookEntry testPbe = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe;

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Storno Verticale',
			IsActive = true
		);
		insert testProduct1;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe1;

		Test.startTest();

		OF_PNI_GIS_Obsoleti_Check contr = new OF_PNI_GIS_Obsoleti_Check();
		contr.updateElemVerticali(lista_staging);
		//delete billingElemVert;
		//contr.updateElemVerticali(lista_staging);

		Test.stopTest();
	}

	private static testMethod void test_updateElemVerticali_GIS() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;


		Account acc = accountCreation();
		account accOf = accountOFCreation();
		Account accOLO = account_OLO_Creation();

		Contract contratto = createContract(acc);

		OF_CatalogoCommerciale__c cat = Catalogo_Creation();
		//Contract contratto = createContract(acc);
		OF_Servizio__c serv = Servizio_Creation(cat);
		OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
		//Asset asset_1 = assetCreation(acc,contratto.id, 'IDR1234');
		//
		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		Asset assetStd= new Asset();
		assetStd.Name = 'IDR1234';
		assetStd.Status = 'Passivo';
		assetStd.EOF_ID_Risorsa__c = 'IDR1234';
		assetStd.recordTypeId = assetRecordTypeId;
		assetStd.accountId = acc.id;
		assetStd.OF_Contract__c = contratto.Id;
		insert assetStd;
		//Asset assetStd = assetCreation(acc,contratto.id, 'IDR1234');
		// assetStd.Status = 'Passivo';

		OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
		order ord=orderCreation(va,assetStd,acc);
		Case c = caseActivationCreation(acc, accOLO,assetStd,ord);

		OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

		//Order ord = orderCreation(c,va,assetStd,acc);
		// OF_Staging_PNI__c stag = createStaging();

		OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
		staging.OF_Source_System__c = 'GIS';
		staging.OF_Civico__c = '12';
		staging.OF_ID_Building__c='test';
		staging.OF_Particella_Toponomastica__c='test1';
		staging.OF_Comune__c = 'Napoli';
		staging.OF_ID_GIS_ScalaPalazzina__c = 'IDR1234';
		staging.OF_Id_DB_Scala_palazzina__c='test2';
		staging.OF_UI_Scala_Palazzina__c='12345';
		staging.OF_Id_Risorsa__c = '123456780000';
		staging.OF_Indirizzo__c = 'Malta';
		staging.OF_GIS_OLO__c='VF';
		staging.OF_GIS_Data_Espletamento__c='2018-10-05 20:03:20';


		insert staging;
		List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
		lista_staging.add(staging);


		OF_CommercialElement__c ce_test = CE_Creation(serv);
		OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
		OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);

		OF_CommercialElementIstanziato__c CEI=CEI_Creation(assetStd,ce_test);


		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		// Run an update DML on the Pricebook2 record
		// This is the weird workaround that enables IsStandard to become true
		// on the PricebookEntry record
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = :standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;

		// Create the PricebookEntry
		PricebookEntry testPbe = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe;

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Storno Verticale',
			IsActive = true
		);
		insert testProduct1;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe1;

		Test.startTest();

		OF_PNI_GIS_Obsoleti_Check contr = new OF_PNI_GIS_Obsoleti_Check();
		contr.updateElemVerticali(lista_staging);
		//delete billingElemVert;
		//contr.updateElemVerticali(lista_staging);

		Test.stopTest();
	}

	private static testMethod void test_updateElemVerticali_ND() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;



		Account acc = accountCreation();
		account accOf = accountOFCreation();
		Account accOLO = account_OLO_Creation();

		Contract contratto = createContract(acc);

		OF_CatalogoCommerciale__c cat = Catalogo_Creation();
		//Contract contratto = createContract(acc);
		OF_Servizio__c serv = Servizio_Creation(cat);
		OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
		//Asset asset_1 = assetCreation(acc,contratto.id, 'IDR1234');
		//
		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		Asset assetStd= new Asset();
		assetStd.Name = 'IDR1234';
		assetStd.Status = 'Passivo';
		assetStd.EOF_ID_Risorsa__c = 'IDR1234';
		assetStd.recordTypeId = assetRecordTypeId;
		assetStd.accountId = acc.id;
		assetStd.OF_Contract__c = contratto.Id;
		insert assetStd;
		//Asset assetStd = assetCreation(acc,contratto.id, 'IDR1234');
		// assetStd.Status = 'Passivo';

		OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
		order ord=orderCreation(va,assetStd,acc);
		Case c = caseActivationCreation(acc, accOLO,assetStd,ord);

		OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

		//Order ord = orderCreation(c,va,assetStd,acc);
		// OF_Staging_PNI__c stag = createStaging();

		OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
		staging.OF_Source_System__c = 'GIS';
		staging.OF_Civico__c = '12';
		staging.OF_ID_Building__c='test';
		staging.OF_Particella_Toponomastica__c='test1';
		staging.OF_Comune__c = 'Napoli';
		staging.OF_ID_GIS_ScalaPalazzina__c = 'IDR1234';
		staging.OF_Id_DB_Scala_palazzina__c='test2';
		staging.OF_UI_Scala_Palazzina__c='12345';
		staging.OF_Id_Risorsa__c = 'N/D';
		staging.OF_Indirizzo__c = 'Malta';
		staging.OF_GIS_OLO__c='VF';
		staging.OF_GIS_Data_Espletamento__c='2018-10-05 20:03:20';


		insert staging;
		List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
		lista_staging.add(staging);


		OF_CommercialElement__c ce_test = CE_Creation(serv);
		OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
		OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);

		OF_CommercialElementIstanziato__c CEI=CEI_Creation(assetStd,ce_test);


		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		// Run an update DML on the Pricebook2 record
		// This is the weird workaround that enables IsStandard to become true
		// on the PricebookEntry record
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = :standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;

		// Create the PricebookEntry
		PricebookEntry testPbe = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe;

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Storno Verticale',
			IsActive = true
		);
		insert testProduct1;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe1;

		Test.startTest();

		OF_PNI_GIS_Obsoleti_Check contr = new OF_PNI_GIS_Obsoleti_Check();
		contr.updateElemVerticali(lista_staging);
		//delete billingElemVert;
		//contr.updateElemVerticali(lista_staging);

		Test.stopTest();
	}
	private static testMethod void test_updateElemVerticali3() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;



		Account acc = accountCreation();
		account accOf = accountOFCreation();
		Account accOLO = account_OLO_Creation();

		Contract contratto = createContract(acc);

		OF_CatalogoCommerciale__c cat = Catalogo_Creation();
		//Contract contratto = createContract(acc);
		OF_Servizio__c serv = Servizio_Creation(cat);
		OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
		//Asset asset_1 = assetCreation(acc,contratto.id, 'IDR1234');
		//
		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		Asset assetStd= new Asset();
		assetStd.Name = 'IDR1234';
		assetStd.Status = 'Passivo';
		assetStd.EOF_ID_Risorsa__c = 'IDR1234';
		assetStd.recordTypeId = assetRecordTypeId;
		assetStd.accountId = acc.id;
		assetStd.OF_Contract__c = contratto.Id;
		insert assetStd;
		//Asset assetStd = assetCreation(acc,contratto.id, 'IDR1234');
		// assetStd.Status = 'Passivo';

		OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
		order ord=orderCreation(va,assetStd,acc);
		Case c = caseActivationCreation(acc, accOLO,assetStd,ord);

		OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

		//Order ord = orderCreation(c,va,assetStd,acc);
		// OF_Staging_PNI__c stag = createStaging();

		OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
		staging.OF_Source_System__c = 'GIS';
		staging.OF_Civico__c = '12';
		staging.OF_ID_Building__c='test';
		staging.OF_Particella_Toponomastica__c='test1';
		staging.OF_Comune__c = 'Napoli';
		staging.OF_ID_GIS_ScalaPalazzina__c = 'N/A';
		staging.OF_Id_DB_Scala_palazzina__c='test2';
		staging.OF_UI_Scala_Palazzina__c='12345';
		staging.OF_Id_Risorsa__c = 'IDR1234';
		staging.OF_Indirizzo__c = 'Malta';
		staging.OF_GIS_OLO__c='VF';
		staging.OF_GIS_Data_Espletamento__c='2018-10-05 20:03:20';


		insert staging;
		List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
		lista_staging.add(staging);


		OF_CommercialElement__c ce_test = CE_Creation(serv);
		OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
		OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);

		OF_CommercialElementIstanziato__c CEI=CEI_Creation(assetStd,ce_test);


		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		// Run an update DML on the Pricebook2 record
		// This is the weird workaround that enables IsStandard to become true
		// on the PricebookEntry record
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = :standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;

		// Create the PricebookEntry
		PricebookEntry testPbe = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe;

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Storno Verticale',
			IsActive = true
		);
		insert testProduct1;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe1;

		Test.startTest();

		OF_PNI_GIS_Obsoleti_Check contr = new OF_PNI_GIS_Obsoleti_Check();
		contr.updateElemVerticali(lista_staging);
		//delete billingElemVert;
		//contr.updateElemVerticali(lista_staging);

		Test.stopTest();
	}



	private static testMethod void test_updateElemVerticalinew() {

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.Name = 'Tibco UserID';
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom.Name = 'Status';
		IpCustom.OF_Enable_Trigger__c = true;
		insert IpCustom;



		Account acc = accountCreation();
		account accOf = accountOFCreation();
		Account accOLO = account_OLO_Creation();

		Contract contratto = createContract(acc);
		//Asset asset_1 = assetCreation(acc,contratto.id, 'IDR1234');
		Asset assetStd = assetCreation(acc,contratto.id, 'IDR1234');
		OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
		order ord=orderCreation(va,assetStd,acc);
		Case c = caseActivationCreation(acc, accOLO,assetStd,ord);

		//OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

		// OF_Billing_Element_Verticale__c billingElementVCreation(Asset asset_t, Case c, OF_Asset_Verticale__c va)

		OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
		verticalBE.name = 'BEV-' + assetStd.EOF_ID_Risorsa__c;
		verticalBE.ID_Risorsa__c = 'IDR1234';
		verticalBE.OLO__c = c.EOF_Account_OLO__c;
		verticalBE.OF_Status__c = 'ATTIVO';
		verticalBE.Data_Attivazione__c = System.now();
		//Relaziono il BE Verticale all'Asset Standard
		verticalBE.Asset__c = assetStd.id;
		//Relaziono il BE Verticale all'Asset Verticale
		verticalBE.Asset_Verticale__c = va.id;
		insert verticalBE;

		//Order ord = orderCreation(c,va,assetStd,acc);
		OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
		staging.OF_Source_System__c = 'GIS';
		staging.OF_Civico__c = '12';
		staging.OF_ID_Building__c='test';
		staging.OF_Particella_Toponomastica__c='test1';
		staging.OF_Comune__c = 'Napoli';
		staging.OF_ID_GIS_ScalaPalazzina__c = 'IDR456';
		staging.OF_Id_DB_Scala_palazzina__c='test2';
		staging.OF_UI_Scala_Palazzina__c='12345';
		staging.OF_Id_Risorsa__c = 'IDR1234';
		staging.OF_Indirizzo__c = 'Malta';
		staging.OF_GIS_OLO__c='VF';
		staging.OF_GIS_Data_Espletamento__c='2018-10-05 20:03:20';


		insert staging;
		//OF_Staging_PNI__c stag = createStaging();
		List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
		lista_staging.add(staging);

		OF_CatalogoCommerciale__c cat = Catalogo_Creation();
		//Contract contratto = createContract(acc);
		OF_Servizio__c serv = Servizio_Creation(cat);
		OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
		OF_CommercialElement__c ce_test = CE_Creation(serv);
		OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
		OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);

		OF_CommercialElementIstanziato__c CEI=CEI_Creation(assetStd,ce_test);


		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		// Run an update DML on the Pricebook2 record
		// This is the weird workaround that enables IsStandard to become true
		// on the PricebookEntry record
		update standardPricebook;

		// Re-Query for the Pricebook2 record, for debugging
		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = :standardPricebook.Id];

		// Create the Product
		Product2 testProduct = new Product2(
			Name = 'Contributo Verticale',
			IsActive = true
		);
		insert testProduct;

		// Create the PricebookEntry
		PricebookEntry testPbe = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe;

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Storno Verticale',
			IsActive = true
		);
		insert testProduct1;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=assetStd.Id,
			IsActive = true
		);
		insert testPbe1;

		Test.startTest();

		OF_PNI_GIS_Obsoleti_Check contr = new OF_PNI_GIS_Obsoleti_Check();
		contr.updateElemVerticali(lista_staging);
		//delete billingElemVert;
		//contr.updateElemVerticali(lista_staging);

		Test.stopTest();
	}
}
@isTest
public class OF_Staging_CheckInvalidRecords_Test {

	public static Account accountOFCreation() {
		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account acc = new Account();
		acc.Name = 'OpenFiber';
		acc.Type = 'OLO';
		acc.EOF_Codice_Operatore__c = 'OF';
		acc.RecordTYpeId = AccountRecordTypeId;
		insert acc;
		return acc;
	}

	public static Account account_OLO_Creation() {
		String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account accOLO = new Account();
		accOLO.Name = 'Tiscali';
		accOLO.EOF_Codice_Operatore__c = 'TIS';
		accOLO.Type = 'OLO';
		accOLO.Industry = 'Telecommunications';
		accOLO.RecordTYpeId = oloAccountRecordTypeId;
		insert accOLO;

		return accOLO;
	}

	public static Contract createContract(Account acc, String idc) {
		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = idc;
		contratto.AccountId = acc.id;
		insert contratto;
		return contratto;
	}

	public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv) {
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

	public static OF_CatalogoCommerciale__c Catalogo_Creation() {
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

	public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat) {
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

	public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv) {
		OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
		conServ.OF_Contract__c = contr.Id;
		conServ.OF_Servizio__c = serv.id;

		insert conServ;
		return conServ;
	}

	public static Asset assetCreation(Account acc, String contractId, String n, String idr) {
		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		Asset asset_1 = new Asset();
		asset_1.Name = n;
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = idr;
		asset_1.recordTypeId = assetRecordTypeId;
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contractId;
		insert asset_1;

		return asset_1;
	}

	public static OF_Asset_Verticale__c assetVerticaleCreation(Asset asset1, String idScala) {
		OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();

		//va.stato__c = 'Attivo';
		va.Indirizzo__c = 'Nazionale';
		va.Civico__c = '34';
		va.Comune__c = 'Milano';
		va.ID_DB_Building__c = 'ID_DB_001';
		va.ID_DB_Scala_Palazzina__c = 'AX001';
		va.ID_GIS_Scala_Palazzina__c = idScala;
		va.Particella_Toponomastica__c = 'Via';
		va.Cardinalita_Scala__c = 1;
		va.Asset__c = asset1.id;

		insert va;

		return va;
	}

	public static OF_Billing_Element_Verticale__c billingElementVCreation(Case c, OF_Asset_Verticale__c va, DateTime created) {
		OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
		verticalBE.name = 'BEV-' + va.ID_GIS_Scala_Palazzina__c + Math.rint(Math.random() * 100);
		verticalBE.ID_Risorsa__c = 'test';
		verticalBE.OLO__c = c.EOF_Account_OLO__c;
		verticalBE.OF_Status__c = 'ATTIVO';
		verticalBE.Data_Attivazione__c = System.now();
		//Relaziono il BE Verticale all'Asset Standard
		verticalBE.Asset__c = va.Asset__c; // asset_t.id;
		//Relaziono il BE Verticale all'Asset Verticale
		verticalBE.Asset_Verticale__c = va.id;
		insert verticalBE;

		Test.setCreatedDate(verticalBE.Id, created);

		return verticalBE;
	}

	public static Order orderCreation(OF_Asset_Verticale__c va /*, Asset asset_t*/, Account acc) {
		Order ordine = new Order();
		//ordine.OF_CaseID__c = c.id;
		ordine.OF_Asset_Verticale__c = va.id;
		ordine.OF_Asset__c = va.Asset__c; // asset_t.id;
		ordine.AccountId = acc.id; // va.Asset__r.accountId;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		insert ordine;

		return ordine;
	}

	public static Case caseActivationCreation(Account acc, Account accOLO, Asset asset_t,order ord) {
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
		list<case> vlstcase =  new list<case>();
		Case c = new Case();
		c.EOF_Account_OLO__c = accOLO.Id;
		c.Subject = 'Richiesta Attivazione';
		c.EOF_Codice_Ordine_OLO__c = '02112016_37' + Math.rint(Math.random() * 100);
		c.EOF_Data_Prevista_Attivazione__c = system.today();
		c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
		c.Status = 'Espletato';
		c.EOF_Fase__c = 'Espletato OK';
		c.Type = '1';
		c.EOF_Tipologia_Servizio__c = 'test1';
		c.EOF_Codice_Operatore_WS__c = 'VF';
		c.EOF_SLA_Premium_Assurance__c = 'Y';
		c.Account = acc;
		c.AssetId = asset_t.id;
		c.OwnerId = userInfo.getUserId();
		c.RecordTypeId = CaseRecordTypeId;
		c.EOF_Id_Notifica__c = 'test_01';
		c.Origin = 'Web';
		c.Priority = 'Medium';
		c.EOF_GPON_Vincolante__c = 'Y';
		c.OF_Order__c = ord.id;
		insert c;

		return c;
	}

	public static testMethod void CheckInvalidRecordsMethod() {
		Id RecordTypeasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		List<OF_Staging_PNI__c> stageList = new List<OF_Staging_PNI__c>();
		OF_Staging_PNI__c stageGIS_Valid = new OF_Staging_PNI__c();
		stageGIS_Valid.Name = 'Test';
		stageGIS_Valid.OF_Id_Risorsa__c = 'RIS_12-17_T001';
		stageGIS_Valid.OF_Source_System__c = 'GIS';
		stageGIS_Valid.isValid__c = true;
		stageGIS_Valid.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_001';
		stageGIS_Valid.OF_UI_Scala_Palazzina__c = '4';
		stageGIS_Valid.OF_GIS_OLO__c = 'TIS';
		stageGIS_Valid.OF_GIS_Data_Espletamento__c = '2018-01-01 00:00:00';
		stageGIS_Valid.OF_Comune__c = 'Milano';
		stageGIS_Valid.OF_Particella_Toponomastica__c = 'Via';
		stageGIS_Valid.OF_Indirizzo__c = 'aaa';
		stageGIS_Valid.OF_Civico__c = '4';
		stageList.add(stageGIS_Valid);

		OF_Staging_PNI__c stageGIS = new OF_Staging_PNI__c();
		stageGIS.Name = 'Test';
		stageGIS.OF_Id_Risorsa__c = 'RIS_12-17_T002';
		stageGIS.OF_Source_System__c = 'GIS';
		stageGIS.isValid__c = true;
		stageGIS.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_002';
		stageGIS.OF_UI_Scala_Palazzina__c = '4';
		stageGIS.OF_GIS_OLO__c = 'TIS';
		stageGIS.OF_GIS_Data_Espletamento__c = '2018-01-01 00:00:00';
		stageGIS.OF_Comune__c = 'Milano';
		stageGIS.OF_Particella_Toponomastica__c = 'Via';
		stageGIS.OF_Indirizzo__c = 'aaa';
		stageGIS.OF_Civico__c = '4';
		stageList.add(stageGIS);

		OF_Staging_PNI__c stageGIS2 = new OF_Staging_PNI__c();
		stageGIS2.Name = 'Test';
		stageGIS2.OF_Id_Risorsa__c = 'RIS_12-17_T003';
		stageGIS2.OF_Source_System__c = 'GIS';
		stageGIS2.isValid__c = true;
		stageGIS2.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_002';
		stageGIS2.OF_UI_Scala_Palazzina__c = '4';
		stageGIS2.OF_GIS_OLO__c = 'TIS';
		stageGIS2.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS2.OF_Comune__c = 'Milano';
		stageGIS2.OF_Particella_Toponomastica__c = 'Via';
		stageGIS2.OF_Indirizzo__c = 'aaa';
		stageGIS2.OF_Civico__c = '4';
		stageList.add(stageGIS2);

		OF_Staging_PNI__c stageGIS20 = new OF_Staging_PNI__c();
		stageGIS20.Name = 'Test';
		stageGIS20.OF_Id_Risorsa__c = 'RIS_12-17_T003';
		stageGIS20.OF_Source_System__c = 'GIS';
		stageGIS20.isValid__c = true;
		stageGIS20.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_002';
		stageGIS20.OF_UI_Scala_Palazzina__c = '4';
		stageGIS20.OF_GIS_OLO__c = 'TIS';
		stageGIS20.OF_GIS_Data_Espletamento__c = '2017-05-02 00:00:00';
		stageGIS20.OF_Comune__c = 'Milano';
		stageGIS20.OF_Particella_Toponomastica__c = 'Via';
		stageGIS20.OF_Indirizzo__c = 'aaa';
		stageGIS20.OF_Civico__c = '4';
		stageList.add(stageGIS20);

		OF_Staging_PNI__c stageGIS3 = new OF_Staging_PNI__c();
		stageGIS3.Name = 'Test';
		stageGIS3.OF_Id_Risorsa__c = 'RIS_12-17_T004';
		stageGIS3.OF_Source_System__c = 'GIS';
		stageGIS3.isValid__c = true;
		stageGIS3.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_003';
		stageGIS3.OF_UI_Scala_Palazzina__c = '4';
		stageGIS3.OF_GIS_OLO__c = 'TIS';
		stageGIS3.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS3.OF_Comune__c = 'Milan';
		stageGIS3.OF_Particella_Toponomastica__c = 'Via';
		stageGIS3.OF_Indirizzo__c = 'aaa';
		stageGIS3.OF_Civico__c = '4';
		stageList.add(stageGIS3);

		OF_Staging_PNI__c stageGIS4 = new OF_Staging_PNI__c();
		stageGIS4.Name = 'Test';
		stageGIS4.OF_Id_Risorsa__c = 'RIS_12-17_T005';
		stageGIS4.OF_Source_System__c = 'GIS';
		stageGIS4.isValid__c = true;
		stageGIS4.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_003';
		stageGIS4.OF_UI_Scala_Palazzina__c = '4';
		stageGIS4.OF_GIS_OLO__c = 'TIS';
		stageGIS4.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS4.OF_Comune__c = 'Milano';
		stageGIS4.OF_Particella_Toponomastica__c = 'Via';
		stageGIS4.OF_Indirizzo__c = 'aaa';
		stageGIS4.OF_Civico__c = '4';
		stageList.add(stageGIS4);

		OF_Staging_PNI__c stageGIS5 = new OF_Staging_PNI__c();
		stageGIS5.Name = 'Test';
		stageGIS5.OF_Id_Risorsa__c = 'N/A';
		stageGIS5.OF_Source_System__c = 'GIS';
		stageGIS5.isValid__c = true;
		stageGIS5.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_003';
		stageGIS5.OF_UI_Scala_Palazzina__c = '4';
		stageGIS5.OF_GIS_OLO__c = 'TIS';
		stageGIS5.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS5.OF_Comune__c = 'Milano';
		stageGIS5.OF_Particella_Toponomastica__c = 'Via';
		stageGIS5.OF_Indirizzo__c = 'aaa';
		stageGIS5.OF_Civico__c = '4';
		stageList.add(stageGIS5);

		OF_Staging_PNI__c stageGIS6 = new OF_Staging_PNI__c();
		stageGIS6.Name = 'Test';
		stageGIS6.OF_Id_Risorsa__c = 'RIS_12-17_T006';
		stageGIS6.OF_Source_System__c = 'GIS';
		stageGIS6.isValid__c = true;
		stageGIS6.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_004';
		stageGIS6.OF_UI_Scala_Palazzina__c = '4';
		stageGIS6.OF_GIS_OLO__c = '';
		stageGIS6.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS6.OF_Comune__c = 'Milano';
		stageGIS6.OF_Particella_Toponomastica__c = 'Via';
		stageGIS6.OF_Indirizzo__c = 'aaa';
		stageGIS6.OF_Civico__c = '4';
		stageList.add(stageGIS6);

		OF_Staging_PNI__c stageGIS7 = new OF_Staging_PNI__c();
		stageGIS7.Name = 'Test';
		stageGIS7.OF_Id_Risorsa__c = 'RIS_12-17_T010';
		stageGIS7.OF_Source_System__c = 'GIS';
		stageGIS7.isValid__c = true;
		stageGIS7.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_100';
		stageGIS7.OF_UI_Scala_Palazzina__c = '4';
		stageGIS7.OF_GIS_OLO__c = 'VF';
		stageGIS7.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS7.OF_Comune__c = 'Milano';
		stageGIS7.OF_Particella_Toponomastica__c = 'Via';
		stageGIS7.OF_GIS_Codice_Ordine_Olo__c = 'qwertY';
		stageGIS7.OF_Indirizzo__c = 'aaa';
		stageGIS7.OF_Civico__c = '4';
		stageList.add(stageGIS7);

		OF_Staging_PNI__c stageGIS8 = new OF_Staging_PNI__c();
		stageGIS8.Name = 'Test';
		stageGIS8.OF_Id_Risorsa__c = 'RIS_12-17_T011';
		stageGIS8.OF_Source_System__c = 'GIS';
		stageGIS8.isValid__c = true;
		stageGIS8.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_100';
		stageGIS8.OF_UI_Scala_Palazzina__c = '4';
		stageGIS8.OF_GIS_OLO__c = 'VF';
		stageGIS8.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS8.OF_Comune__c = 'MilanoOOO';
		stageGIS8.OF_Particella_Toponomastica__c = 'Via';
		stageGIS8.OF_GIS_Codice_Ordine_Olo__c = 'qwertT';
		stageGIS8.OF_Indirizzo__c = 'aaa';
		stageGIS8.OF_Civico__c = '4';
		stageList.add(stageGIS8);

		OF_Staging_PNI__c stagePNI_8 = new OF_Staging_PNI__c();
		stagePNI_8.Name = 'Test';
		stagePNI_8.OF_Id_Risorsa__c = 'RIS_12-17_T511';
		stagePNI_8.OF_Source_System__c = 'PNI';
		stagePNI_8.isValid__c = true;
		stagePNI_8.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_100';
		stagePNI_8.OF_UI_Scala_Palazzina__c = '4';
		stagePNI_8.OF_GIS_OLO__c = 'VF';
		stagePNI_8.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stagePNI_8.OF_Comune__c = 'MilanoOOO';
		stagePNI_8.OF_Particella_Toponomastica__c = 'Via';
		stagePNI_8.OF_GIS_Codice_Ordine_Olo__c = 'qwertT';
		stagePNI_8.OF_Indirizzo__c = 'aaa';
		stagePNI_8.OF_Civico__c = '4';
		stageList.add(stagePNI_8);

		OF_Staging_PNI__c stageGIS9 = new OF_Staging_PNI__c();
		stageGIS9.Name = 'Test';
		stageGIS9.OF_Id_Risorsa__c = 'RIS_12-17_T012';
		stageGIS9.OF_Source_System__c = 'GIS';
		stageGIS9.isValid__c = true;
		stageGIS9.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_001';
		stageGIS9.OF_UI_Scala_Palazzina__c = '4';
		stageGIS9.OF_GIS_OLO__c = 'VF';
		stageGIS9.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stageGIS9.OF_Comune__c = 'Milano';
		stageGIS9.OF_Particella_Toponomastica__c = 'Via';
		stageGIS9.OF_GIS_Codice_Ordine_Olo__c = 'qwertA';
		stageGIS9.OF_Indirizzo__c = 'aaa';
		stageGIS9.OF_Civico__c = '4';
		stageList.add(stageGIS9);

		OF_Staging_PNI__c stageGIS10 = new OF_Staging_PNI__c();
		stageGIS10.Name = 'Test';
		stageGIS10.OF_Id_Risorsa__c = 'RIS_12-17_T013';
		stageGIS10.OF_Source_System__c = 'GIS';
		stageGIS10.isValid__c = true;
		stageGIS10.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_001';
		stageGIS10.OF_UI_Scala_Palazzina__c = '4';
		stageGIS10.OF_GIS_OLO__c = 'TIS';
		stageGIS10.OF_GIS_Data_Espletamento__c = '2005-01-02 00:00:00';
		stageGIS10.OF_Comune__c = 'Milano';
		stageGIS10.OF_Particella_Toponomastica__c = 'Via';
		stageGIS10.OF_GIS_Codice_Ordine_Olo__c = 'qwertZ';
		stageGIS10.OF_Indirizzo__c = 'aaa';
		stageGIS10.OF_Civico__c = '4';
		stageList.add(stageGIS10);

		OF_Staging_PNI__c stageGIS11 = new OF_Staging_PNI__c();
		stageGIS11.Name = 'Test';
		stageGIS11.OF_Id_Risorsa__c = 'RIS_12-17_T014';
		stageGIS11.OF_Source_System__c = 'GIS';
		stageGIS11.isValid__c = true;
		stageGIS11.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_001';
		stageGIS11.OF_UI_Scala_Palazzina__c = '4';
		stageGIS11.OF_GIS_OLO__c = 'TIS';
		stageGIS11.OF_GIS_Data_Espletamento__c = '2007-01-02 00:00:00';
		stageGIS11.OF_Comune__c = 'Milano';
		stageGIS11.OF_Particella_Toponomastica__c = 'Via';
		stageGIS11.OF_GIS_Codice_Ordine_Olo__c = 'qwert';
		stageGIS11.OF_Indirizzo__c = 'aaa';
		stageGIS11.OF_Civico__c = '4';
		stageList.add(stageGIS11);

		OF_Staging_PNI__c stagePNI = new OF_Staging_PNI__c();
		stagePNI.Name = 'Test';
		stagePNI.OF_Id_Risorsa__c = 'RIS_12-17_PNI000';
		stagePNI.OF_Source_System__c = 'PNI';
		stagePNI.isValid__c = true;
		stagePNI.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_001';
		stagePNI.OF_UI_Scala_Palazzina__c = '4';
		stagePNI.OF_GIS_OLO__c = 'TIS';
		stagePNI.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stagePNI.OF_Comune__c = 'Milano';
		stagePNI.OF_Particella_Toponomastica__c = 'Via';
		stagePNI.OF_Indirizzo__c = 'aaa';
		stagePNI.OF_Civico__c = '4';
		stageList.add(stagePNI);

		OF_Staging_PNI__c stagePNI_1 = new OF_Staging_PNI__c();
		stagePNI_1.Name = 'Test';
		stagePNI_1.OF_Id_Risorsa__c = 'RIS_12-17_PNI000_X';
		stagePNI_1.OF_Source_System__c = 'PNI';
		stagePNI_1.isValid__c = true;
		stagePNI_1.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-18_001';
		stagePNI_1.OF_UI_Scala_Palazzina__c = '';
		stagePNI_1.OF_GIS_OLO__c = 'TIS';
		stagePNI_1.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stagePNI_1.OF_Comune__c = 'Milano';
		stagePNI_1.OF_Particella_Toponomastica__c = 'Via';
		stagePNI_1.OF_Indirizzo__c = 'aaa';
		stagePNI_1.OF_Civico__c = '4';
		stageList.add(stagePNI_1);

		OF_Staging_PNI__c stagePNI2 = new OF_Staging_PNI__c();
		stagePNI2.Name = 'Test';
		stagePNI2.OF_Id_Risorsa__c = 'RIS_12-17_PNI001';
		stagePNI2.OF_Source_System__c = 'GIS';
		stagePNI2.isValid__c = true;
		stagePNI2.OF_ID_GIS_ScalaPalazzina__c = 'N/A';
		stagePNI2.OF_UI_Scala_Palazzina__c = '4';
		stagePNI2.OF_GIS_OLO__c = 'TIS';
		stagePNI2.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stagePNI2.OF_Comune__c = 'Milano';
		stagePNI2.OF_Particella_Toponomastica__c = 'Via';
		stagePNI2.OF_Indirizzo__c = 'aaa';
		stagePNI2.OF_Civico__c = '4';
		stageList.add(stagePNI2);

		OF_Staging_PNI__c stagePNI3 = new OF_Staging_PNI__c();
		stagePNI3.Name = 'Test';
		stagePNI3.OF_Id_Risorsa__c = 'RIS_12-17_PNI002';
		stagePNI3.OF_Source_System__c = 'PNI';
		stagePNI3.isValid__c = true;
		stagePNI3.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_010';
		stagePNI3.OF_UI_Scala_Palazzina__c = '4';
		stagePNI3.OF_GIS_OLO__c = 'TIS';
		stagePNI3.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stagePNI3.OF_Comune__c = 'Milano';
		stagePNI3.OF_Particella_Toponomastica__c = 'Via';
		stagePNI3.OF_Indirizzo__c = 'aaa';
		stagePNI3.OF_Civico__c = '4';
		stageList.add(stagePNI3);

		OF_Staging_PNI__c stagePNI4 = new OF_Staging_PNI__c();
		stagePNI4.Name = 'Test';
		stagePNI4.OF_Id_Risorsa__c = 'RIS_12-17_PNI003';
		stagePNI4.OF_Source_System__c = 'GIS';
		stagePNI4.isValid__c = true;
		stagePNI4.OF_ID_GIS_ScalaPalazzina__c = 'N/A';
		stagePNI4.OF_UI_Scala_Palazzina__c = '4';
		stagePNI4.OF_GIS_OLO__c = 'TIS';
		stagePNI4.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stagePNI4.OF_Comune__c = 'Milano';
		stagePNI4.OF_Particella_Toponomastica__c = 'Via';
		stagePNI4.OF_Indirizzo__c = 'aaa';
		stagePNI4.OF_Civico__c = '4';
		stageList.add(stagePNI4);

		OF_Staging_PNI__c stagePNI5 = new OF_Staging_PNI__c();
		stagePNI5.Name = 'Test';
		stagePNI5.OF_Id_Risorsa__c = 'RIS_12-17_PNI003';
		stagePNI5.OF_Source_System__c = 'GIS';
		stagePNI5.isValid__c = true;
		stagePNI5.OF_ID_GIS_ScalaPalazzina__c = 'SCALA_12-17_011';
		stagePNI5.OF_UI_Scala_Palazzina__c = ' ';
		stagePNI5.OF_GIS_OLO__c = 'TIS';
		stagePNI5.OF_GIS_Data_Espletamento__c = '2018-01-02 00:00:00';
		stagePNI5.OF_Comune__c = 'Milano';
		stagePNI5.OF_Particella_Toponomastica__c = 'Via';
		stagePNI5.OF_Indirizzo__c = 'aaa';
		stagePNI5.OF_Civico__c = '4';
		stageList.add(stagePNI5);


		insert stageList;

		Account accOf = accountOFCreation();
		Account tis = account_OLO_Creation();
		Contract contratto1 = createContract(accOf, 'TEST_TIS_001');
		Contract contratto2 = createContract(accOf, 'TEST_TIS_002');
		Contract contratto3 = createContract(accOf, 'TEST_TIS_003');
		OF_CatalogoCommerciale__c cc = Catalogo_Creation();
		OF_Servizio__c serv = Servizio_Creation(cc);
		OF_CommercialElement__c ce = CE_Creation(serv);
		createContrattoServizio(contratto1, serv);
		Asset asset1 = assetCreation(accOf, contratto1.id, 'name1', 'RIS_12-17_PNI000');
		Asset asset2 = assetCreation(accOf, contratto2.id, 'name2', 'RIS_12-17_PNI002');
		Asset asset3 = assetCreation(accOf, contratto3.id, 'name3', 'RIS_12-17_T511');
		OF_Asset_Verticale__c av1 = assetVerticaleCreation(asset1, 'SCALA_12-17_010');
		createContrattoServizio(contratto3, serv);
		Order ord = orderCreation(av1, accOf);
		Case c1 = caseActivationCreation(accOf, tis, asset1, ord);
		OF_Billing_Element_Verticale__c bev1 = billingElementVCreation(c1, av1, System.now());

		/*Account acc =new Account();
		   acc.name= 'Test';
		   insert acc;

		   List<Asset> assList = new List<Asset>();
		   Asset a = new Asset();
		   a.Status = 'Attivo';
		   a.Name = 'Canone';
		   a.OF_DataAttivazione2__c = System.today();
		   a.EOF_ID_Risorsa__c = 'risorsa';
		   a.RecordTypeId = RecordTypeasset;
		   a.AccountID = acc.Id;
		   assList.add(a);
		   insert a;
		   Map<String, Asset> mapAssetStd = new Map<String, Asset>();
		   mapAssetStd.put('risorsa' ,a);*/

		List<OF_Staging_PNI__c> listaStaging = [SELECT Id, indice__c, OF_Id_Risorsa__c, OF_Source_System__c, OF_ID_GIS_ScalaPalazzina__c, OF_GIS_OLO__c, OF_GIS_Data_Espletamento__c, OF_Comune__c, OF_Particella_Toponomastica__c, OF_Indirizzo__c, OF_Civico__c, OF_UI_Scala_Palazzina__c, OF_GIS_Codice_Ordine_Olo__c, isValid__c, STG_Info_Esecuzione__c
												FROM OF_Staging_PNI__c
												WHERE isValid__c = true AND OF_ID_GIS_ScalaPalazzina__c NOT IN (null, 'N/D', '#N/D', 'N/A', '#N/A') AND OF_Id_Risorsa__c NOT IN (null, 'N/D', '#N/D', 'N/A', '#N/A')
													ORDER BY OF_ID_GIS_ScalaPalazzina__c ASC];

		List<OF_Staging_PNI__c> invalids = [SELECT Id, isValid__c, STG_Info_Esecuzione__c FROM OF_Staging_PNI__c
											WHERE isValid__c = true
												AND (OF_ID_GIS_ScalaPalazzina__c IN (null, 'N/A', '#N/A') OR OF_Id_Risorsa__c IN (null, 'N/D', '#N/D', 'N/A', '#N/A'))];

		Test.startTest();
		OF_Staging_CheckInvalidRecords check = new OF_Staging_CheckInvalidRecords();
		check.run(listaStaging, invalids);

		OF_Staging_CheckInvalidRecords.WrapData wrap = new OF_Staging_CheckInvalidRecords.WrapData();
		wrap.OLO = 'TIS';
		wrap.DataAttivazione = System.now();
		wrap.idScala = 'abcd';

		OF_Staging_CheckInvalidRecords.WrapData innerCheck = new OF_Staging_CheckInvalidRecords.WrapData();
		innerCheck.OLO = 'TIS';
		innerCheck.DataAttivazione = System.now();
		innerCheck.idScala = 'abc';
		innerCheck.stagF = stagePNI5;
		innerCheck.hashCode();
		innerCheck.equals(wrap);
		innerCheck.equals(null);
		innerCheck.equals(stagePNI4);
		Test.stopTest();
	}
}
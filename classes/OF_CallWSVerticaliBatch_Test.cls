@isTest
public class OF_CallWSVerticaliBatch_Test {

	@testSetup
	public static void testSetUpData() {
		Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
		Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
		Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
	}


	static testmethod Map<String,String> RecordType() {
		List<RecordType> rtypes = [Select developerName, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'EOF_Notify__c')  and isActive=true];

		Map<String,String> RecordType = new Map<String,String> {};

		for (RecordType rt: rtypes) {
			RecordType.put(rt.developerName,rt.Id);
		}

		return RecordType;
	}

	public static testMethod void RetryScheduleMethod1() {

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
		acc.AccountNumber='123456';
		insert acc;

		Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		//contratto.BillingFrequency__c='Monthly';
		//contratto.ContractNumber='test';
		insert contratto;

		Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];

		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR1234';
		asset_1.Status = '';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
		asset_1.recordTypeId = assetRecordTypeId;
		asset_1.accountId = acc1.id;
		//OF_DataAttivazione2__c
		asset_1.OF_DataAttivazione2__c=datetime.now();

		asset_1.OF_Contract__c = contratto1.id;
		insert asset_1;

		OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();

		//va.stato__c = 'Attivo';
		va.Indirizzo__c = 'Na';
		va.Civico__c = '34';
		va.Comune__c = 'Mi';
		va.Provincia__c='te';
		va.UI_Scala_Palazzina__c=2.4;
		va.ID_DB_Building__c = 'ID_DB_001';
		va.ID_DB_Scala_Palazzina__c = 'AX001';
		va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
		va.Particella_Toponomastica__c = 'Via';
		va.Cardinalita_Scala__c = 1;
		va.Asset__c=asset_1.id;

		insert va;

		Order ordine = new Order();
		//ordine.OF_CaseID__c = c.id;
		//ordine.OF_Asset_Verticale__c = va.id;
		ordine.OF_Asset__c = asset_1.id;
		ordine.AccountId = acc1.id;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		ordine.ContractId= contratto1.id;
		insert ordine;

		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
		list<case> vlstcase =  new list<case>();
		Case c = new Case();
		//c.EOF_Account_OLO__c = accOLO.Id;
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
		c.Account = acc1;
		c.AssetId = asset_1.id;
		c.OwnerId = userInfo.getUserId();
		c.RecordTypeId = CaseRecordTypeId;
		c.EOF_Id_Notifica__c = 'test_01';
		c.Origin = 'Web';
		c.Priority = 'Medium';
		c.EOF_GPON_Vincolante__c = 'Y';
		c.OF_Order__c=ordine.id;
		c.OLO_ORDER_CODE__c='test';

		insert c;

		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;

		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'VERTICALE';
		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio1;
		servizio.OF_DataFineValidita__c = fine1;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='test';
		//servizio.OF_Durata_Servizio__c=4.2;
		insert servizio;

		OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		ce.name = 'Servizio Verticale';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio2;
		ce.OF_DataFineValidita__c = fine2;
		ce.OF_Servizio__c = servizio.id;
		ce.OF_Commercial_Element_Code__c='test';

		insert ce;

		OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
		//CEI.Name='Test';
		String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
		CEI.OF_Asset__c=asset_1.id;
		CEI.OF_Stato__c='Attivo';
		CEI.OF_CommercialElement__c=ce.id;
		CEI.RecordTypeId=CeiRecordTypeId;
		CEI.OF_DataAttivazione__c=DATETIME.now();
		CEI.Asset_Verticale__c=va.id;

		insert CEI;

		// OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];

		//insert CEI1;
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
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_CommercialElementIstanziato__c=CEI.id
			    // OF_DataAttivazione2__c=datetime.now()
		);
		insert testPbe;

		OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType req = new OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType();

		String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('EOF_BILL_Asset').getRecordTypeId();
		EOF_Notify__c objEOF= new EOF_Notify__c();
		objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
		objEOF.Flag_Pagamento__c = '0';
		objEOF.Numero_Operatore__c = '1';
		objEOF.EOF_Tipo_di_intervento__c = 'Sbraccio';
		objEOF.EOF_Tipo_di_intervento_aggiuntivo__c = 'Nessun Intervento';
		objEOF.EOF_ID_Notifica__c = 'Test Id';
		objEOF.EOF_Stato_Richiesta__c = 'OK';
		objEOF.EOF_Codice_Operatore__c = 'VF';
		objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
		objEOF.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
		objEOF.EOF_Data_Notifica__c = system.now();
		objEOF.EOF_ID_Risorsa__c ='Test';
		objEOF.EOF_ID_Splitter_Secondario__c = 'Test';
		objEOF.EOF_Posizione_Splitter_Secondario__c = 'Test';
		objEOF.EOF_Data_Espletamento_Ordine__c = System.today();
		objEOF.EOF_Note__c = 'Test Note';
		objEOF.EOF_Inviata__c = false;
		objEOF.OF_isElaborato__c  = true;
		objEOF.Commercial_element_istanziato__c = cei.Id;
		objEOF.OF_JsonRequest__c = JSON.serialize(req);
		objEOF.Account__c = acc.Id;
		objEOF.indice__c = 1;
		objEOF.RecordTYpeId = NotifyRecordTypeId;
		insert objEOF;

		Test.startTest();
		//String IdAccount = acc1.id;
		Database.QueryLocator QL;
		Database.BatchableContext BC;
		OF_CallWSVerticaliBatch batc = new OF_CallWSVerticaliBatch(1, 100);
		//Account acc = acc1;

		Test.setMock(WebServiceMock.class, new SyncBillingAssettUtils_Mock());
		database.executeBatch(batc);
		ql = batc.start(BC);
		batc.finish(BC);
		Test.stopTest();
	}
}
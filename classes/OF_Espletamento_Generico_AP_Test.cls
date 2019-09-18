@isTest

public class OF_Espletamento_Generico_AP_Test {

	public static testMethod void Test1()
	{
		OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
		tibco1.Name = 'Tibco UserID';
		tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco1;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom1.Name = 'Status';
		IpCustom1.OF_Enable_Trigger__c = true;
		insert IpCustom1;


		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount1';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR12341';
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contratto.Id;
		asset_1.EOF_SLA_Premium_Assurance__c='N';
		insert asset_1;


		Order ordine = new Order();
		ordine.AccountId = acc.id;
		ordine.ContractId= contratto.id;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		ordine.OF_IDRisorsa__c='test';
		insert ordine;

		Case c = new Case();
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
		c.AccountId = acc.id;
		c.EOF_Codice_Ordine_OLO__c = 'Test1';
		c.EOF_Contact__c = null;
		c.EOF_Id_Risorsa__c='IDR1234';
		c.status = 'Accettato';
		c.EOF_FASE__C = 'NA';
		c.OF_SA_Profilo__c='1';
		c.RecordTypeId=CaseRecordTypeId;
		c.AssetId=asset_1.id;
		c.EOF_Identificativo_del_POP__c='test1';
		c.OF_Esito_Consegna_Apparato__c='2';
		c.OF_Order__c=ordine.id;
		c.OF_IDContratto__c=contratto.id;

		insert c;

		case c1=[select id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];


		Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';
		insert cer;



		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;


		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'Open Stream CD';
		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio2;
		servizio.OF_DataFineValidita__c = fine2;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='123';
		insert servizio;

		Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
		ccus.Name='test1';
		ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
		ccus.assetDevName__c='P2P';
		ccus.beAttivazioneList__c='Contributo Attivazione ,Canone';
		ccus.serviceName__c = servizio.name;
		insert ccus;

		OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
		contrattoServizio.OF_Contract__c=ordine.ContractId;
		contrattoServizio.OF_Servizio__c=servizio.id;
		insert contrattoServizio;


		OF_CommercialElement__c ce = new OF_CommercialElement__c();
		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		ce.name = 'VLAN1';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio1;
		ce.OF_DataFineValidita__c = fine1;
		ce.OF_Servizio__c = servizio.id;
		insert ce;



		OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
		String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
		//CEI.Name='Test';
		CEI.OF_Asset__c=asset_1.id;
		CEI.OF_Stato__c='Attivo';
		CEI.RecordTypeId=ComRecordTypeId;
		CEI.OF_Case__c=c.id;
		CEI.OF_EsitoConsegnaApparato__c='2';
		CEI.OF_CommercialElement__c=ce.id;
		//CEI.OF_CommercialElement__c=CE.id;
		insert CEI;


		OF_CommercialElementIstanziato__c CEI_Std=new OF_CommercialElementIstanziato__c();
		//CEI.Name='Test';
		CEI_Std.OF_Asset__c=asset_1.id;
		CEI_Std.OF_Stato__c='Attivo';
		CEI_Std.RecordTypeId= OF_Espletamento_Generico_AP.getRtMap().get('OF_Standard');
		CEI_Std.OF_Case__c=c.id;
		CEI_Std.OF_EsitoConsegnaApparato__c='2';
		CEI_Std.OF_CommercialElement__c=ce.id;
		//CEI.OF_CommercialElement__c=CE.id;
		insert CEI_Std;


		OF_Listino__c lr1=new OF_Listino__c();
		Date ini11 = Date.newInstance(2099,1,31);
		Date fin11= Date.newInstance(2099,1,3);
		lr1.OF_DataFineValidita__c=ini11;
		lr1.OF_DataInizioValidita__c=fin11;
		//lr1.OF_ServizioBillingElement__c=sb1.Id;
		insert lr1;

		OF_BillingElement__c bec=new OF_BillingElement__c();
		bec.Name='Contributo Attivazione';
		Date ini12 = Date.newInstance(2099,1,31);
		Date fin12= Date.newInstance(2099,1,3);
		bec.OF_DataFineValidita__c=ini12;
		bec.OF_DataInizioValidita__c=fin12;
		bec.OF_CommercialElement__c=ce.id;
		bec.OF_Billing_Element_Code__c = 'abcd-001';
		bec.OF_Attivo__c=true;
		insert bec;

		OF_BillingElement__c becDis=new OF_BillingElement__c();
		becDis.Name='Contributo Disattivazione';
		becDis.OF_DataFineValidita__c=ini12;
		becDis.OF_DataInizioValidita__c=fin12;
		becDis.OF_CommercialElement__c=ce.id;
		becDis.OF_Billing_Element_Code__c = 'abcd-002';
		becDis.OF_Attivo__c=true;
		insert becDis;

		system.debug('in method 1 billingintest:' + bec);
		system.debug('in method 1 billingintest for query field0:' + ce.OF_Servizio__c);
		system.debug('in method 1 billingintest for query field1:' + bec.OF_CommercialElement__c);
		system.debug('in method 1 billingintest for query field2:' + bec.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('in method 1 billingintest for query field3:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
		system.debug('in method 1 billingintest for query field4:' + bec.OF_CommercialElement__r.Name);

		OF_BillingElement__c bec1=[select OF_CommercialElement__r.Name,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];

		system.debug('in method 1 billingintest1:' + bec1);
		system.debug('in method 1 billingintest for query field4test:' + bec1.OF_CommercialElement__r.Name);
		system.debug('in method 1 billingintest for query field3test:' + bec1.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		list<OF_BillingElement__c> lisbe=new list<OF_BillingElement__c>();
		lisbe.add(bec1);

		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true

		);
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
		/*  PricebookEntry testPbe = new PricebookEntry(
		      Pricebook2Id = standardPricebook.Id,
		      Product2Id = testProduct.Id,
		      UnitPrice = 100,
		      OF_Asset__c=asset_1.Id,
		      IsActive = true
		   );
		   insert testPbe;*/

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Consegna e Istallazione',
			IsActive = true
		);
		insert testProduct1;

		Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);

		insert customPB;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =false
		);
		insert testPbe1;

		PricebookEntry testPbecus = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = customPB.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =true
		);

		insert testPbecus;
		Map<String,ID> profiles = new Map<String,ID>();
		List<Profile> ps = [select id, name from Profile where name =
								'Standard User' or name = 'System Administrator'];

		for (Profile p : ps) {
			profiles.put(p.name, p.id);
		}

		// Create the users to be used in this test.

		// First make a new user.


		User standard = new User(alias = 'standt',
								 email='standarduser@testorg.com',
								 emailencodingkey='UTF-8',
								 lastname='Testing', languagelocalekey='en_US',
								 localesidkey='en_US',
								 profileid = profiles.get('System Administrator'),
								 timezonesidkey='America/Los_Angeles',
								 username='standarduser1234*@testorg.com');

		insert standard;

        Case cFail = new Case();
		cFail.AccountId = acc.id;
		cFail.EOF_Codice_Ordine_OLO__c = 'Test12';
		cFail.EOF_Contact__c = null;
		cFail.EOF_Id_Risorsa__c='IDR1234zz';
		cFail.status = 'Accettato';
		cFail.EOF_FASE__C = 'NA';
		cFail.OF_SA_Profilo__c='1';
		cFail.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		insert cFail;

        cFail = [SELECT Id, OF_IDContratto__c, RecordType.DeveloperName FROM Case WHERE Id = :cFail.Id LIMIT 1];
		// system.runas(standard){
        try {
            new OF_Espletamento_Generico_AP(null);
        } catch (InvalidParameterValueException e) {
            System.assertEquals('OF_Espletamento_Generico_AP: Case cannot be null', e.getMessage());
        }
        try {
            new OF_Espletamento_Generico_AP(cFail);
        } catch (NoDataFoundException e) {
            System.assert(e.getMessage().startsWith('Missing Custom Setting for Case.RecordType.DeveloperName = '));
        }
		OF_Espletamento_Generico_AP EGA=new OF_Espletamento_Generico_AP(c1);
		OF_Espletamento_Generico_AP.getRtMap();
		EGA.espletamentoRemedy(asset_1, new List<OF_BillingElement__c>(), false);
		OF_Espletamento_Generico_AP.BeiData BD=new OF_Espletamento_Generico_AP.BeiData(CEI,testProduct1);
		EGA.espletamentoRemedy(asset_1,lisbe,false);
		EGA.espletamentoRemedy(asset_1,lisbe,true);
		ordine.status = 'KO';
		EGA.espletamentoGPONP_OpenStream(ordine);
		EGA.espletamentoGPONP_OLD(ordine);
		EGA.cessazioneBeiGPONP_OpenStream(new List<Case>{c});
		//EGA.espletamentoGPONP_OpenStream(ordine);

		// }
	}

	public static testMethod void Test2()
	{
		OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
		tibco1.Name = 'Tibco UserID';
		tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco1;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom1.Name = 'Status';
		IpCustom1.OF_Enable_Trigger__c = true;
		insert IpCustom1;



		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount1';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR12341';
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contratto.Id;
		asset_1.EOF_SLA_Premium_Assurance__c='Y';

		insert asset_1;


		Order ordine = new Order();
		ordine.AccountId = acc.id;
		ordine.ContractId= contratto.id;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		ordine.OF_IDRisorsa__c='test';
		ordine.OF_SlaPremiumAssurance__c='Y';
		insert ordine;

		Case c = new Case();
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
		c.AccountId = acc.id;
		c.EOF_Codice_Ordine_OLO__c = 'Test1';
		c.EOF_Contact__c = null;
		c.EOF_Id_Risorsa__c='test';
		c.status = 'Accettato';
		c.EOF_FASE__C = 'NA';
		c.OF_SA_Profilo__c='1';
		c.RecordTypeId=CaseRecordTypeId;
		c.AssetId=asset_1.id;
		c.EOF_Identificativo_del_POP__c='test1';
		c.OF_Esito_Consegna_Apparato__c='2';
		c.OF_Order__c=ordine.id;
		c.OF_IDContratto__c=contratto.id;

		insert c;

		case c1=[select id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];


		Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';

		insert cer;


		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;


		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'Open Stream CD';
		// servizio.name = 'GPON';
		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio2;
		servizio.OF_DataFineValidita__c = fine2;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='123';
		insert servizio;

		Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
		ccus.Name='test1';
		ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
		ccus.assetDevName__c='P2P';
		ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione,Contributo Consegna e istallazione,Canone,Contributo Consegna TV BOX';
		ccus.serviceName__c = servizio.name;
		insert ccus;

		OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
		contrattoServizio.OF_Contract__c=ordine.ContractId;
		contrattoServizio.OF_Servizio__c=servizio.id;

		insert contrattoServizio;

		OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		ce.name = 'VLAN1';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio1;
		ce.OF_DataFineValidita__c = fine1;
		ce.OF_Servizio__c = servizio.id;

		insert ce;



		OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
		String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
		//CEI.Name='Test';
		CEI.OF_Asset__c=asset_1.id;
		CEI.OF_Stato__c='Attivo';
		CEI.RecordTypeId=ComRecordTypeId;
		CEI.OF_Case__c=c.id;
		CEI.OF_EsitoConsegnaApparato__c='2';
		CEI.OF_CommercialElement__c=ce.id;
		CEI.OF_TipologiaApparato__c='1ONTVFX-1.10096378-123185280-LVRRST52R21G273B-';
		//CEI.OF_CommercialElement__c=CE.id;
		insert CEI;


		OF_Listino__c lr1=new OF_Listino__c();
		Date ini11 = Date.newInstance(2099,1,31);
		Date fin11= Date.newInstance(2099,1,3);
		lr1.OF_DataFineValidita__c=ini11;
		lr1.OF_DataInizioValidita__c=fin11;

		insert lr1;


		OF_BillingElement__c bec2=new OF_BillingElement__c();
		bec2.Name='Canone premium';
		Date ini123 = Date.newInstance(2099,1,31);
		Date fin123= Date.newInstance(2099,1,3);
		bec2.OF_DataFineValidita__c=ini123;
		bec2.OF_DataInizioValidita__c=fin123;
		bec2.OF_CommercialElement__c=ce.id;
		bec2.OF_Billing_Element_Code__c = 'abcd-004';
		bec2.OF_Attivo__c=true;

		insert bec2;



		system.debug('billingintest:' + bec2);
		system.debug('billingintest for query field0:' + bec2.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec2.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec2.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone premium'];

		bec2=bec3;

		update bec2;



		system.debug('billingintest1:' + bec2);

		system.debug('billingintest2:' + bec2.OF_Attivo__c);
		system.debug('billingintest3:' + bec2.OF_Servizio__c);
		system.debug('billingintest4:' + bec2.name);
		system.debug('billingintest for query field3test:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);



		OF_BillingElement__c bec=new OF_BillingElement__c();
		bec.Name='Contributo Attivazione';
		Date ini12 = Date.newInstance(2099,1,31);
		Date fin12= Date.newInstance(2099,1,3);
		bec.OF_DataFineValidita__c=ini12;
		bec.OF_DataInizioValidita__c=fin12;
		bec.OF_CommercialElement__c=ce.id;
		bec.OF_Attivo__c=true;
		bec.OF_Billing_Element_Code__c = 'abcd-002';

		insert bec;



		system.debug('billingintest:' + bec);
		system.debug('billingintest for query field0:' + bec.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];

		bec=bec1;

		update bec;


		system.debug('billingintest1:' + bec);

		system.debug('billingintest2:' + bec.OF_Attivo__c);
		system.debug('billingintest3:' + bec.OF_Servizio__c);
		system.debug('billingintest4:' + bec.name);
		system.debug('billingintest for query field3test:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);



		OF_BillingElement__c bec4=new OF_BillingElement__c();
		bec4.Name='Contributo Consegna e istallazione';
		Date ini1234 = Date.newInstance(2099,1,31);
		Date fin1234= Date.newInstance(2099,1,3);
		bec4.OF_DataFineValidita__c=ini1234;
		bec4.OF_DataInizioValidita__c=fin1234;
		bec4.OF_CommercialElement__c=ce.id;
		bec4.OF_Attivo__c=true;
		bec4.OF_Billing_Element_Code__c = 'abcd-003';

		insert bec4;




		OF_BillingElement__c bec5=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna e istallazione'];

		bec4=bec5;

		update bec4;


		OF_BillingElement__c bec6=new OF_BillingElement__c();
		bec6.Name='Canone';
		Date ini12345 = Date.newInstance(2099,1,31);
		Date fin12345= Date.newInstance(2099,1,3);
		bec6.OF_DataFineValidita__c=ini12345;
		bec6.OF_DataInizioValidita__c=fin12345;
		bec6.OF_CommercialElement__c=ce.id;
		bec6.OF_Attivo__c=true;
		bec6.OF_Billing_Element_Code__c = 'abcd-005';

		insert bec6;




		OF_BillingElement__c bec7=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone'];

		bec6=bec7;

		update bec6;

		//Contributo Consegna TV BOX
		//
		OF_BillingElement__c bec8=new OF_BillingElement__c();
		bec8.Name='Contributo Consegna TV BOX';
		Date ini123456 = Date.newInstance(2099,1,31);
		Date fin123456= Date.newInstance(2099,1,3);
		bec8.OF_DataFineValidita__c=ini123456;
		bec8.OF_DataInizioValidita__c=fin123456;
		bec8.OF_CommercialElement__c=ce.id;
		bec8.OF_Attivo__c=true;
		bec8.OF_Billing_Element_Code__c = 'abcd-006';

		insert bec8;




		OF_BillingElement__c bec9=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna TV BOX'];

		bec8=bec9;

		update bec8;

		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true

		);
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
		/*  PricebookEntry testPbe = new PricebookEntry(
		      Pricebook2Id = standardPricebook.Id,
		      Product2Id = testProduct.Id,
		      UnitPrice = 100,
		      OF_Asset__c=asset_1.Id,
		      IsActive = true
		   );
		   insert testPbe;*/

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Consegna e Istallazione',
			IsActive = true
		);
		insert testProduct1;

		Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);

		insert customPB;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =false
		);
		insert testPbe1;

		PricebookEntry testPbecus = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = customPB.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =true
		);

		insert testPbecus;


		OF_Espletamento_Generico_AP EGA=new OF_Espletamento_Generico_AP(c1);
		OF_Espletamento_Generico_AP.getRtMap();
		OF_Espletamento_Generico_AP.BeiData BD=new OF_Espletamento_Generico_AP.BeiData(CEI,testProduct1);


		EGA.espletamentoGPONP_OpenStream(ordine);


	}

	public static testMethod void Test3()
	{
		OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
		tibco1.Name = 'Tibco UserID';
		tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco1;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom1.Name = 'Status';
		IpCustom1.OF_Enable_Trigger__c = true;
		insert IpCustom1;



		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount1';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR12341';
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contratto.Id;
		asset_1.EOF_SLA_Premium_Assurance__c='Y';

		insert asset_1;


		Order ordine = new Order();
		ordine.AccountId = acc.id;
		ordine.ContractId= contratto.id;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		ordine.OF_IDRisorsa__c='test';
		ordine.OF_SlaPremiumAssurance__c='Y';
		insert ordine;

		Case c = new Case();
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
		c.AccountId = acc.id;
		c.EOF_Codice_Ordine_OLO__c = 'Test1';
		c.EOF_Contact__c = null;
		c.EOF_Id_Risorsa__c='test';
		c.status = 'Accettato';
		c.EOF_FASE__C = 'NA';
		c.OF_SA_Profilo__c='1';
		c.RecordTypeId=CaseRecordTypeId;
		c.AssetId=asset_1.id;
		c.EOF_Identificativo_del_POP__c='test1';
		c.OF_Esito_Consegna_Apparato__c='2';
		c.OF_Order__c=ordine.id;
		c.OF_IDContratto__c=contratto.id;

		insert c;

		case c1=[select id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];

		Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';

		insert cer;


		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;


		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'GPON Passiva';
		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio2;
		servizio.OF_DataFineValidita__c = fine2;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='123';
		insert servizio;

		Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
		ccus.Name='test1';
		ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
		ccus.assetDevName__c='P2P';
		ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione';
		ccus.serviceName__c = servizio.name;
		insert ccus;

		OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
		contrattoServizio.OF_Contract__c=ordine.ContractId;
		contrattoServizio.OF_Servizio__c=servizio.id;

		insert contrattoServizio;

		OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		ce.name = 'VLAN1';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio1;
		ce.OF_DataFineValidita__c = fine1;
		ce.OF_Servizio__c = servizio.id;

		insert ce;



		OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
		String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
		//CEI.Name='Test';
		CEI.OF_Asset__c=asset_1.id;
		CEI.OF_Stato__c='Attivo';
		CEI.RecordTypeId=ComRecordTypeId;
		CEI.OF_Case__c=c.id;
		CEI.OF_EsitoConsegnaApparato__c='2';
		CEI.OF_CommercialElement__c=ce.id;
		//CEI.OF_CommercialElement__c=CE.id;
		insert CEI;


		OF_Listino__c lr1=new OF_Listino__c();
		Date ini11 = Date.newInstance(2099,1,31);
		Date fin11= Date.newInstance(2099,1,3);
		lr1.OF_DataFineValidita__c=ini11;
		lr1.OF_DataInizioValidita__c=fin11;

		insert lr1;


		OF_BillingElement__c bec2=new OF_BillingElement__c();
		bec2.Name='Canone premium';
		Date ini123 = Date.newInstance(2099,1,31);
		Date fin123= Date.newInstance(2099,1,3);
		bec2.OF_DataFineValidita__c=ini123;
		bec2.OF_DataInizioValidita__c=fin123;
		bec2.OF_CommercialElement__c=ce.id;
		bec2.OF_Attivo__c=true;
		bec2.OF_Billing_Element_Code__c = 'abcd-008';

		insert bec2;



		system.debug('billingintest:' + bec2);
		system.debug('billingintest for query field0:' + bec2.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec2.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec2.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone premium'];

		bec2=bec3;

		update bec2;



		system.debug('billingintest1:' + bec2);

		system.debug('billingintest2:' + bec2.OF_Attivo__c);
		system.debug('billingintest3:' + bec2.OF_Servizio__c);
		system.debug('billingintest4:' + bec2.name);
		system.debug('billingintest for query field3test:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);



		OF_BillingElement__c bec=new OF_BillingElement__c();
		bec.Name='Contributo Attivazione';
		Date ini12 = Date.newInstance(2099,1,31);
		Date fin12= Date.newInstance(2099,1,3);
		bec.OF_DataFineValidita__c=ini12;
		bec.OF_DataInizioValidita__c=fin12;
		bec.OF_CommercialElement__c=ce.id;
		bec.OF_Attivo__c=true;
		bec.OF_Billing_Element_Code__c = 'abcd-009';

		insert bec;



		system.debug('billingintest:' + bec);
		system.debug('billingintest for query field0:' + bec.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];

		bec=bec1;

		update bec;


		system.debug('billingintest1:' + bec);

		system.debug('billingintest2:' + bec.OF_Attivo__c);
		system.debug('billingintest3:' + bec.OF_Servizio__c);
		system.debug('billingintest4:' + bec.name);
		system.debug('billingintest for query field3test:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true

		);
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
		/*  PricebookEntry testPbe = new PricebookEntry(
		      Pricebook2Id = standardPricebook.Id,
		      Product2Id = testProduct.Id,
		      UnitPrice = 100,
		      OF_Asset__c=asset_1.Id,
		      IsActive = true
		   );
		   insert testPbe;*/

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Consegna e Istallazione',
			IsActive = true
		);
		insert testProduct1;

		Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);

		insert customPB;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =false
		);
		insert testPbe1;

		PricebookEntry testPbecus = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = customPB.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =true
		);

		insert testPbecus;


		OF_Espletamento_Generico_AP EGA=new OF_Espletamento_Generico_AP(c1);
		OF_Espletamento_Generico_AP.getRtMap();
		OF_Espletamento_Generico_AP.BeiData BD=new OF_Espletamento_Generico_AP.BeiData(CEI,testProduct1);


		EGA.espletamentoGPONP_OLD(ordine);





	}

	public static testMethod void Test4()
	{
		OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
		tibco1.Name = 'Tibco UserID';
		tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco1;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom1.Name = 'Status';
		IpCustom1.OF_Enable_Trigger__c = true;
		insert IpCustom1;



		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount1';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR12341';
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contratto.Id;
		asset_1.EOF_SLA_Premium_Assurance__c='Y';

		insert asset_1;


		Order ordine = new Order();
		ordine.AccountId = acc.id;
		ordine.ContractId= contratto.id;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		ordine.OF_IDRisorsa__c='test';
		ordine.OF_SlaPremiumAssurance__c='Y';
		insert ordine;

		Case c = new Case();
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
		c.AccountId = acc.id;
		c.EOF_Codice_Ordine_OLO__c = 'Test1';
		c.EOF_Contact__c = null;
		c.EOF_Id_Risorsa__c='test';
		c.status = 'Accettato';
		c.EOF_FASE__C = 'NA';
		c.OF_SA_Profilo__c='1';
		c.RecordTypeId=CaseRecordTypeId;
		c.AssetId=asset_1.id;
		c.EOF_Identificativo_del_POP__c='test1';
		c.OF_Esito_Consegna_Apparato__c='2';
		c.OF_Order__c=ordine.id;
		c.OF_IDContratto__c=contratto.id;

		insert c;

		case c1=[select OF_SA_Motivazione__c,OF_SA_Codice_Motivazione__c,id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];

		Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';
		insert cer;


		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;


		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'GPON Passiva';
		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio2;
		servizio.OF_DataFineValidita__c = fine2;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='123';
		insert servizio;

		Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
		ccus.Name='test1';
		ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
		ccus.assetDevName__c='P2P';
		ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione';
		ccus.serviceName__c = servizio.name;
		insert ccus;

		OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
		contrattoServizio.OF_Contract__c=ordine.ContractId;
		contrattoServizio.OF_Servizio__c=servizio.id;

		insert contrattoServizio;

		OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		ce.name = 'VLAN1';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio1;
		ce.OF_DataFineValidita__c = fine1;
		ce.OF_Servizio__c = servizio.id;

		insert ce;



		OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
		String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
		//CEI.Name='Test';
		CEI.OF_Asset__c=asset_1.id;
		CEI.OF_Stato__c='Attivo';
		CEI.RecordTypeId=ComRecordTypeId;
		CEI.OF_Case__c=c.id;
		CEI.OF_EsitoConsegnaApparato__c='2';
		CEI.OF_CommercialElement__c=ce.id;
		//CEI.OF_CommercialElement__c=CE.id;
		insert CEI;

		OF_Listino__c lr1=new OF_Listino__c();
		Date ini11 = Date.newInstance(2099,1,31);
		Date fin11= Date.newInstance(2099,1,3);
		lr1.OF_DataFineValidita__c=ini11;
		lr1.OF_DataInizioValidita__c=fin11;
		insert lr1;

		OF_BillingElement__c bec2=new OF_BillingElement__c();
		bec2.Name='Canone premium';
		Date ini123 = Date.newInstance(2099,1,31);
		Date fin123= Date.newInstance(2099,1,3);
		bec2.OF_DataFineValidita__c=ini123;
		bec2.OF_DataInizioValidita__c=fin123;
		bec2.OF_CommercialElement__c=ce.id;
		bec2.OF_Attivo__c=true;
		bec2.OF_Billing_Element_Code__c = 'abcd-010';

		insert bec2;



		system.debug('billingintest:' + bec2);
		system.debug('billingintest for query field0:' + bec2.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec2.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec2.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone premium'];

		bec2=bec3;

		update bec2;



		system.debug('billingintest1:' + bec2);

		system.debug('billingintest2:' + bec2.OF_Attivo__c);
		system.debug('billingintest3:' + bec2.OF_Servizio__c);
		system.debug('billingintest4:' + bec2.name);
		system.debug('billingintest for query field3test:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);



		OF_BillingElement__c bec=new OF_BillingElement__c();
		bec.Name='Contributo Attivazione';
		Date ini12 = Date.newInstance(2099,1,31);
		Date fin12= Date.newInstance(2099,1,3);
		bec.OF_DataFineValidita__c=ini12;
		bec.OF_DataInizioValidita__c=fin12;
		bec.OF_CommercialElement__c=ce.id;
		bec.OF_Attivo__c=true;
		bec.OF_Billing_Element_Code__c = 'abcd-011';

		insert bec;



		system.debug('billingintest:' + bec);
		system.debug('billingintest for query field0:' + bec.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];

		bec=bec1;

		update bec;


		system.debug('billingintest1:' + bec);

		system.debug('billingintest2:' + bec.OF_Attivo__c);
		system.debug('billingintest3:' + bec.OF_Servizio__c);
		system.debug('billingintest4:' + bec.name);
		system.debug('billingintest for query field3test:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true

		);
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
		/*  PricebookEntry testPbe = new PricebookEntry(
		      Pricebook2Id = standardPricebook.Id,
		      Product2Id = testProduct.Id,
		      UnitPrice = 100,
		      OF_Asset__c=asset_1.Id,
		      IsActive = true
		   );
		   insert testPbe;*/

		Product2 testProduct1 = new Product2(
			Name = 'Contributo Consegna e Istallazione',
			IsActive = true
		);
		insert testProduct1;

		Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);

		insert customPB;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =false
		);
		insert testPbe1;

		PricebookEntry testPbecus = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = customPB.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =true
		);

		insert testPbecus;


		OF_Espletamento_Generico_AP EGA=new OF_Espletamento_Generico_AP(c1);
		OF_Espletamento_Generico_AP.getRtMap();
		OF_Espletamento_Generico_AP.BeiData BD=new OF_Espletamento_Generico_AP.BeiData(CEI,testProduct1);





		EGA.cessazioneCeiGPONP_OpenStream(false);
		EGA.cessazioneCeiGPONP_Remedy(false);


	}

	public static testMethod void Test5()
	{
		OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
		tibco1.Name = 'Tibco UserID';
		tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
		insert tibco1;

		OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
		IpCustom1.Name = 'Status';
		IpCustom1.OF_Enable_Trigger__c = true;
		insert IpCustom1;

		Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
		verticaliCS.RecordTypesAssets__c='test1\test2';
		insert verticaliCS;

		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
		Account acc = new Account();
		acc.Lastname = 'TestAccount1';
		acc.Phone = '0000';
		acc.EOF_Phone_2__c = '0000';
		acc.EOF_Provincia__c = 'Milano';
		acc.EOF_Comune__c = 'Milano';
		acc.EOF_Indirizzo__c = 'Piazzale Gorini';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Particella_Toponomastica__c = '123';
		acc.EOF_Numero_Civico__c = '7';
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR12341';
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contratto.Id;
		asset_1.EOF_SLA_Premium_Assurance__c='Y';

		insert asset_1;


		Order ordine = new Order();
		ordine.AccountId = acc.id;
		ordine.ContractId= contratto.id;
		ordine.EffectiveDate = date.today();
		ordine.status = 'Aperto';
		ordine.OF_IDRisorsa__c='test';
		ordine.OF_SlaPremiumAssurance__c='Y';
		insert ordine;

		Case c = new Case();
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
		c.AccountId = acc.id;
		c.EOF_Codice_Ordine_OLO__c = 'Test1';
		c.EOF_Contact__c = null;
		c.EOF_Id_Risorsa__c='IDR1234';
		c.status = 'Accettato';
		c.EOF_FASE__C = 'NA';
		c.OF_SA_Profilo__c='1';
		c.RecordTypeId=CaseRecordTypeId;
		c.AssetId=asset_1.id;
		c.EOF_Identificativo_del_POP__c='test1';
		c.OF_Esito_Consegna_Apparato__c='2';
		c.OF_Order__c=ordine.id;
		//c.OF_IDContratto__c=contratto.id;

		insert c;

		case c1=[select actionDate_Remedy__c,OF_SA_Motivazione__c,OF_SA_Codice_Motivazione__c,id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];

		Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
		cer.name='testcer1';
		cer.ceName__c='VLAN1';
		cer.ceiDevName__c='CPE_Passivi';

		insert cer;


		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;


		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'GPON Passiva';
		Date inizio2 = Date.newInstance(2016,1,1);
		Date fine2 = Date.newInstance(2099,12,31);
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio2;
		servizio.OF_DataFineValidita__c = fine2;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c='123';
		insert servizio;

		Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
		ccus.Name='test1';
		ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
		ccus.assetDevName__c='P2P';
		ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione';
		ccus.beCessazioneList__c='Contributo Ritiro';
		ccus.serviceName__c = servizio.name;
		insert ccus;

		OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
		contrattoServizio.OF_Contract__c=asset_1.OF_Contract__c;
		contrattoServizio.OF_Servizio__c=servizio.id;

		insert contrattoServizio;

		OF_CommercialElement__c ce = new OF_CommercialElement__c();

		Date inizio1 = Date.newInstance(2016,1,1);
		Date fine1 = Date.newInstance(2099,12,31);
		ce.name = 'VLAN1';
		ce.OF_Attivo__c = true;
		ce.OF_DataInizioValidita__c = inizio1;
		ce.OF_DataFineValidita__c = fine1;
		ce.OF_Servizio__c = servizio.id;

		insert ce;



		OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
		String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
		//CEI.Name='Test';
		CEI.OF_Asset__c=asset_1.id;
		CEI.OF_Stato__c='Attivo';
		CEI.RecordTypeId=ComRecordTypeId;
		CEI.OF_Case__c=c.id;
		CEI.OF_EsitoConsegnaApparato__c='2';
		CEI.OF_CommercialElement__c=ce.id;
		CEI.OF_EsitoRitiroApparato__c='0';

		//CEI.OF_CommercialElement__c=CE.id;
		insert CEI;

		OF_Listino__c lr1=new OF_Listino__c();
		Date ini11 = Date.newInstance(2099,1,31);
		Date fin11= Date.newInstance(2099,1,3);
		lr1.OF_DataFineValidita__c=ini11;
		lr1.OF_DataInizioValidita__c=fin11;
		insert lr1;

		OF_BillingElement__c bec2=new OF_BillingElement__c();
		bec2.Name='Contributo Ritiro';
		Date ini123 = Date.newInstance(2099,1,31);
		Date fin123= Date.newInstance(2099,1,3);
		bec2.OF_DataFineValidita__c=ini123;
		bec2.OF_DataInizioValidita__c=fin123;
		bec2.OF_CommercialElement__c=ce.id;
		bec2.OF_Attivo__c=true;
		bec2.OF_Billing_Element_Code__c = 'abcd-012';

		insert bec2;



		system.debug('billingintest:' + bec2);
		system.debug('billingintest for query field0:' + bec2.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec2.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec2.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Ritiro'];

		bec2=bec3;

		update bec2;



		system.debug('billingintest1:' + bec2);

		system.debug('billingintest2:' + bec2.OF_Attivo__c);
		system.debug('billingintest3:' + bec2.OF_Servizio__c);
		system.debug('billingintest4:' + bec2.name);
		system.debug('billingintest for query field3test:' + bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);



		OF_BillingElement__c bec=new OF_BillingElement__c();
		bec.Name='Contributo Attivazione';
		Date ini12 = Date.newInstance(2099,1,31);
		Date fin12= Date.newInstance(2099,1,3);
		bec.OF_DataFineValidita__c=ini12;
		bec.OF_DataInizioValidita__c=fin12;
		bec.OF_CommercialElement__c=ce.id;
		bec.OF_Billing_Element_Code__c = 'abcd-013';
		bec.OF_Attivo__c=true;

		insert bec;



		system.debug('billingintest:' + bec);
		system.debug('billingintest for query field0:' + bec.OF_Servizio__c);
		system.debug('billingintest for query field1:' + bec.OF_CommercialElement__c);
		system.debug('billingintest for query field2:' + bec.OF_CommercialElement__r.OF_Servizio__c);
		system.debug('billingintest for query field3:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);

		OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];

		bec=bec1;

		update bec;


		system.debug('billingintest1:' + bec);

		system.debug('billingintest2:' + bec.OF_Attivo__c);
		system.debug('billingintest3:' + bec.OF_Servizio__c);
		system.debug('billingintest4:' + bec.name);
		system.debug('billingintest for query field3test:' + bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
		// Instantiate the Pricebook2 record first, setting the Id
		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true

		);
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



		Product2 testProduct1 = new Product2(
			Name = 'Contributo Consegna e Istallazione',
			IsActive = true
		);
		insert testProduct1;

		Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);

		insert customPB;

		// Create the PricebookEntry
		PricebookEntry testPbe1 = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = standardPricebook.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =false
		);
		insert testPbe1;

		PricebookEntry testPbecus = new PricebookEntry(
			// Name='Contributo Consegna e Istallazione',
			Pricebook2Id = customPB.Id,
			Product2Id = testProduct1.Id,
			UnitPrice = 100,
			OF_Asset__c=asset_1.Id,
			IsActive = true,
			OF_Master__c =true
		);

		insert testPbecus;


		OF_Espletamento_Generico_AP EGA=new OF_Espletamento_Generico_AP(c1);
		OF_Espletamento_Generico_AP.getRtMap();
		OF_Espletamento_Generico_AP.BeiData BD=new OF_Espletamento_Generico_AP.BeiData(CEI,testProduct1);





		EGA.cessazioneCeiGPONP_OpenStream(true);
		EGA.cessazioneCeiGPONP_Remedy(true);


	}

}
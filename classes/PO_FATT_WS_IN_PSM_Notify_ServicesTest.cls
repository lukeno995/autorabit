@isTest
public class PO_FATT_WS_IN_PSM_Notify_ServicesTest {
	private static void createCustomSettings() {
		List<ServFattList__c> csList = new List<ServFattList__c>();
		ServFattList__c cs = new ServFattList__c();
		cs.Name = 'Fiber Link';
		cs.code__c = 'SE-OF000007';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_Fiber_Link';
		cs.assetDevName__c = 'Fiber_Link';
		cs.externalSystem__c = 'PSM';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'Backhauling';
		cs.code__c = 'SE-OF000003';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_Backhauling';
		cs.assetDevName__c = 'PO_Asset_Backhauling_Collegamento';
		cs.externalSystem__c = 'PSM';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'P2P Base';
		cs.code__c = 'SE-OF000005';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_P2P';
		cs.assetDevName__c = 'P2P';
		cs.externalSystem__c = 'PSM';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'P2P Attiva';
		cs.code__c = 'SE-OF000006';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_P2P_Attiva';
		cs.assetDevName__c = 'PO_Asset_P2P_Attiva_Collegamento';
		cs.externalSystem__c = '';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'Dark Fiber';
		cs.code__c = 'SE-OF000008';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_DarkFiber';
		cs.assetDevName__c = 'PO_Asset_DarkFiber_Collegamento';
		cs.externalSystem__c = 'PSM';
		csList.add(cs);

		cs = new ServFattList__c();
		cs.Name = 'BTS';
		cs.code__c = 'SE-OF000004';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_BTS';
		cs.assetDevName__c = 'PO_Asset_BTS_Collegamento';
		cs.externalSystem__c = 'PSM';
		csList.add(cs);

		insert csList;
	}

	public static testMethod void schedBillingJobTest() {
		createCustomSettings();
		Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
		Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
		Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
		Insert new Verticali__c(RecordTypesAssets__c ='\'PO_Asset_Backhauling_Collegamento\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'', createNotifyBatchLimit__c = 10000, callWsBillingBatchSize__c = 4,RecorTypesList__c = '\'OF_ServiziAggiuntivi\',\'OF_CPE\',\'OF_VLAN\',\'OF_Standard\',\'PO_Portalino\'');

		Test.startTest();
		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account acc = new Account();
		acc.Name = 'Test';
		acc.AccountNumber = '123';
		acc.VATNumber__c = 'Test';
		acc.TaxationCode__c = 123;
		acc.Status__c = 'Bozza';
		acc.RecordTYpeId = AccountRecordTypeId;
		acc.EOF_Codice_Operatore__c= 'Te';
		acc.StartDate__c = system.today();
		insert acc;

		Contract contratto = new Contract();
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.id;
		insert contratto;

		Asset ass= new Asset();
		ass.Name = 'Test';
		ass.accountId = acc.id;
		ass.OF_Contract__c = contratto.id;
		insert ass;
		PO_FATT_WS_IN_PSM_Notify_Services.schedBillingJob(ass.Id, '123456');
		Test.stopTest();
	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;


		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'In Lavorazione';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = 'TEstData';
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		insert attach;

		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '2';
		act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;

		Test.startTest();
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyAnnullamento(act);
		cs.Status = 'Annullato';
		Update cs;

		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyEspletamento(act);
		PO_FATT_WS_IN_Espletamento espObj = new PO_FATT_WS_IN_Espletamento(cs);
		//espObj.espletamento_OK();
		//espObj.AggiornoOrdine(cs, od, CustSett,CustSett2);
		//PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act);
		//PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyCessazione(act);
		Test.stopTest();

	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod1() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;


		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'In Lavorazione';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = 'TEst';
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		insert attach;

		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '2';
		act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act.DATA_PREVISTA_ATTIVAZIONE = String.Valueof(cs.DAC_Prevista_OF__c);
		act.MOTIVAZIONE_RIMODULAZIONE_DAC = cs.EOF_Note_Appuntamento__c;

		Test.startTest();
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act);
		update cs;
		Test.stopTest();
	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod2() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;

		//string VUOTA = 'Test';

		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'Espletato';
		cs.AssetId = ass.Id;
		//cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = 'TEstData';
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		insert attach;

		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '2';
		act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act.DATA_PREVISTA_ATTIVAZIONE = String.Valueof(cs.DAC_Prevista_OF__c);
		act.MOTIVAZIONE_RIMODULAZIONE_DAC = cs.EOF_Note_Appuntamento__c;

		List<OF_CommercialElementIstanziato__c> custList=new List<OF_CommercialElementIstanziato__c>();
		OF_CommercialElementIStanziato__c obj = new OF_CommercialElementIStanziato__c();
		obj.OF_Asset__c = ass.Id;
		obj.OF_Case__c = cs.id;
		obj.OF_Stato__c = 'Attivo';
		custList.add(obj);
		insert custList;

		Test.startTest();
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyCessazione(act);
		Test.stopTest();
	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod3() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;

		//string VUOTA = 'Test';

		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'Espletato';
		cs.AssetId = ass.Id;
		//cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = 'TEstData';
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		//insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		//insert attach;

		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '2';
		//act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act.DATA_PREVISTA_ATTIVAZIONE = String.Valueof(cs.DAC_Prevista_OF__c);
		act.MOTIVAZIONE_RIMODULAZIONE_DAC = cs.EOF_Note_Appuntamento__c;

		List<OF_CommercialElementIstanziato__c> custList=new List<OF_CommercialElementIstanziato__c>();
		OF_CommercialElementIStanziato__c obj = new OF_CommercialElementIStanziato__c();
		obj.OF_Asset__c = ass.Id;
		obj.OF_Case__c = cs.id;
		obj.OF_Stato__c = 'Attivo';
		custList.add(obj);
		insert custList;

		Test.startTest();
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyCessazione(act);
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyAnnullamento(act);
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyEspletamento(act);
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act);


		List<Case> listCase1 = new List<Case>();
		Case cs1 = new Case();
		cs1.Status = 'In Lavorazione';
		cs1.AssetId = ass.Id;
		//cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs1.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		cs1.EOF_Note_Appuntamento__c = 'TEstData';
		cs1.PO_FATT_History_Owner__c = 'TEstData';
		cs1.OF_Order__c = od.id;
		cs1.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs1.RecordTypeId = CaseRecordTypeId;
		cs1.OwnerId = userInfo.getUserId();
		insert cs1;

		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act1 =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act1.ID_NOTIFICA = '0';
		act1.CODICE_NOTIFICA = '2';
		//act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act1.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act1.STATO_ORDINE = '0';
		act1.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act1.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act1.DATA_PREVISTA_ATTIVAZIONE = String.Valueof(cs1.DAC_Prevista_OF__c);
		act1.MOTIVAZIONE_RIMODULAZIONE_DAC = cs1.EOF_Note_Appuntamento__c;

		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act1);

		Test.stopTest();
	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod4() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;

		//string VUOTA = 'Test';

		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'In Lavorazione';
		cs.AssetId = ass.Id;
		//cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		//cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = userinfo.getuserId();
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		//insert attach;


		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '2';
		act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act.DATA_PREVISTA_ATTIVAZIONE = String.Valueof(cs.DAC_Prevista_OF__c);
		act.MOTIVAZIONE_RIMODULAZIONE_DAC = cs.EOF_Note_Appuntamento__c;



		List<OF_CommercialElementIstanziato__c> custList=new List<OF_CommercialElementIstanziato__c>();
		OF_CommercialElementIStanziato__c obj = new OF_CommercialElementIStanziato__c();
		obj.OF_Asset__c = ass.Id;
		obj.OF_Case__c = cs.id;
		obj.OF_Stato__c = 'Attivo';
		custList.add(obj);
		insert custList;

		Test.startTest();

		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act);

		Test.stopTest();
	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod5() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;


		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;

		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'In Lavorazione';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = 'TEstData';
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		//cs.PO_Tipo_Percorso__c='Doppia Via Diversificata';
		insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		insert attach;

		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '0';
		act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 06, 29));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act.ID_CIRCUITO_2='';


		Test.startTest();
		/* PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyAnnullamento(act);
		   cs.Status = 'Annullato';
		   Update cs;
		 */
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyEspletamento(act);
		act.STATO_ORDINE = '1';
		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyEspletamento(act);
		PO_FATT_WS_IN_Espletamento espObj = new PO_FATT_WS_IN_Espletamento(cs);
		//espObj.espletamento_OK();
		//espObj.AggiornoOrdine(cs, od, CustSett,CustSett2);
		//PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act);
		//PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyCessazione(act);
		Test.stopTest();

	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod6() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;

		//string VUOTA = 'Test';

		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'In Lavorazione';
		cs.AssetId = ass.Id;
		//cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 04, 18);
		//cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = userinfo.getuserId();
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		cs.PO_Data_Attivazione_Richiesta__c='2018-06-06';
		insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		//insert attach;


		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '2';
		act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act.DATA_PREVISTA_ATTIVAZIONE = String.Valueof(cs.DAC_Prevista_OF__c);
		act.MOTIVAZIONE_RIMODULAZIONE_DAC = cs.EOF_Note_Appuntamento__c;



		List<OF_CommercialElementIstanziato__c> custList=new List<OF_CommercialElementIstanziato__c>();
		OF_CommercialElementIStanziato__c obj = new OF_CommercialElementIStanziato__c();
		obj.OF_Asset__c = ass.Id;
		obj.OF_Case__c = cs.id;
		obj.OF_Stato__c = 'Attivo';
		custList.add(obj);
		insert custList;

		Test.startTest();

		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act);

		Test.stopTest();
	}

	public static testMethod void PO_FATT_WS_IN_PSM_Notify_ServicesTestMethod7() {
		createCustomSettings();
		TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
		Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
		paramFat.Name = 'Default';
		paramFat.Fascia1__c = 1;
		insert paramFat;

		OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
		tibco.OF_Tibco_ID__c = '00558000001f743AAA';
		tibco.name = 'Tibco UserID';
		insert tibco;

		OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
		abilitaTrig.name='Status';
		abilitaTrig.OF_Enable_Trigger__c=true;
		insert abilitaTrig;

		list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
		CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();

		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();

		Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account;
		Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName();
		Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();

		account acc = new account();
		acc.RecordTypeId = rId8;
		acc.name = 'test';
		insert acc;

		//Create and Insert Asset
		Asset ass = new Asset(Name = 'Test Asset',
							  Status = 'Attivo',
							  AccountId = acc.Id,
							  InstallDate = System.Today()
		);
		insert ass;

		Contract ct = new Contract();
		ct.AccountId = acc.Id;
		ct.Status = 'Draft';
		ct.StartDate = Date.Today();
		ct.ContractTerm = 12;
		insert ct;

		//string VUOTA = 'Test';

		Order od = new Order();
		od.AccountId = acc.Id;
		od.EffectiveDate = Date.Today();
		od.ContractId = ct.Id;
		od.Status = 'Chiuso';
		insert od;
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
		List<Case> listCase = new List<Case>();
		Case cs = new Case();
		cs.Status = 'In Lavorazione';
		cs.AssetId = ass.Id;
		//cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.DAC_Prevista_OF__c = Date.newInstance(2018, 06, 29);
		//cs.EOF_Note_Appuntamento__c = 'TEstData';
		cs.PO_FATT_History_Owner__c = userinfo.getuserId();
		cs.OF_Order__c = od.id;
		cs.EOF_Fase__c = 'In Lavorazione Network Creation';
		cs.RecordTypeId = CaseRecordTypeId;
		cs.OwnerId = userInfo.getUserId();
		cs.PO_Data_Attivazione_Richiesta__c='2018-06-06';
		insert cs;

		Attachment attach=new Attachment();
		attach.Name ='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.parentId=cs.id;
		//insert attach;


		PO_FATT_WS_IN_PSM_Notify.PSM_Notify act =  new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
		act.ID_NOTIFICA = '0';
		act.CODICE_NOTIFICA = '2';
		act.CODICE_ORDINE = [SELECT Id,CaseNUmber from Case where Id =: cs.id].caseNumber;
		act.DATA_NOTIFICA = String.Valueof(Date.newInstance(2018, 04, 18));
		act.STATO_ORDINE = '0';
		act.DATA_ESPLETAMENTO_ORDINE = String.ValueOf(Date.newInstance(2018, 04, 18));
		act.ID_RISORSA = [SELECT Id,Name from Asset where Id =: ass.id].Name;
		act.DATA_PREVISTA_ATTIVAZIONE = String.Valueof(cs.DAC_Prevista_OF__c);
		act.MOTIVAZIONE_RIMODULAZIONE_DAC = cs.EOF_Note_Appuntamento__c;



		List<OF_CommercialElementIstanziato__c> custList=new List<OF_CommercialElementIstanziato__c>();
		OF_CommercialElementIStanziato__c obj = new OF_CommercialElementIStanziato__c();
		obj.OF_Asset__c = ass.Id;
		obj.OF_Case__c = cs.id;
		obj.OF_Stato__c = 'Attivo';
		custList.add(obj);
		insert custList;

		Test.startTest();

		PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(act);

		Test.stopTest();
	}
}
@isTest
public class OF_BonificaCaseSenzaOrdine_Batch_Test {
	
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

	public static Case createCase(Account acc, Id rtId, String idRisorsa, String srvName, Contract contr, String stato) {
		Case c = new Case();
		c.AccountId = acc.Id;
		//c.EOF_Account_OLO__c = acc.Id;
		c.Status = stato;
		c.RecordTypeId = rtId;
		c.EOF_Id_Risorsa__c = idRisorsa;
		c.SN_bypassValidation__c = false;
		c.PO_Data_Attivazione_Ordine__c = System.today();
		c.OF_Servizio__c = srvName;
		c.OF_IDContratto__c = contr.Id;
		c.PO_Accordo_Quadro__c = contr.Id;
		c.PO_Accordo_Quadro_Number__c = contr.Name;
		c.PO_Comune__c = 'Roma';
		c.EOF_Identificativo_del_POP__c = 'abc';
		c.EOF_Fase__C = 'Completato';
		c.PO_Costo_lavori_civili__c = 10;
		c.OF_SA_Profilo__c = '1';

		insert c;
		return c;
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
	
	public static void createCustomSettings() {
	    BatchBonifiche__c cs = new BatchBonifiche__c();
	    cs.Name = 'BonificaCaseSenzaOrdine';
	    cs.sogliaMinuti__c = 10;
	    cs.SizeBatch__c = 100;
	    insert cs;
	    
	    OF_CodificaProfiloListini__c cpl = new OF_CodificaProfiloListini__c();
		cpl.Name = '1';
		cpl.OF_ListinoCanoneName__c = 'OPSTR_001_CAN_20_5';
		cpl.OF_ProfiloCommerciale__c = 'OPENSTREAM_20_5';
		cpl.IsPortalValid__c = true;
		cpl.CosType__c = 'MONO_COS';
		cpl.PO_PREPROV_ListinoCanoneName__c = 'PREPROV_20_5';
		cpl.PO_CD_Profilo_Commerciale__c = 'OPENSTREAM_1000_300';
		insert cpl;
	}

	public static testmethod void t1() {
	    OF_BonificaCaseSenzaOrdine_Batch_Test.createCustomSettings();
		Map<String, Id> rtDevNameIdMap = OF_Espletamento_Generico_AP.getRtMap();
		Account acc = OF_BonificaCaseSenzaOrdine_Batch_Test.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = OF_BonificaCaseSenzaOrdine_Batch_Test.createCatalogo();
		OF_Servizio__c serv = OF_BonificaCaseSenzaOrdine_Batch_Test.createServizio(catal, 'Open Stream', 'SE-001');
		Contract contr = OF_BonificaCaseSenzaOrdine_Batch_Test.createContract(acc, serv);
		Case caseCessazioneAcq = OF_BonificaCaseSenzaOrdine_Batch_Test.createCase(acc, rtDevNameIdMap.get('OF_SA_Cessazione'), 'test_cess1', serv.name, contr, 'Acquisito');
		Case caseCessazioneKO = OF_BonificaCaseSenzaOrdine_Batch_Test.createCase(acc, rtDevNameIdMap.get('OF_SA_Cessazione'), 'test_cess2', serv.name, contr, 'Cessato KO');
		Case caseAttivazioneAperto = OF_BonificaCaseSenzaOrdine_Batch_Test.createCase(acc, rtDevNameIdMap.get('OF_SA_Attivazione'), 'test_att1', serv.name, contr, 'Acquisito');
		Case caseAttivazioneChiusoKO = OF_BonificaCaseSenzaOrdine_Batch_Test.createCase(acc, rtDevNameIdMap.get('OF_SA_Attivazione'), 'test_att2', serv.name, contr, 'Acquisito KO');
		Case caseAttivazioneChiusoOK = OF_BonificaCaseSenzaOrdine_Batch_Test.createCase(acc, rtDevNameIdMap.get('OF_SA_Attivazione'), 'test_att3', serv.name, contr, 'Espletato');
		Asset a = OF_BonificaCaseSenzaOrdine_Batch_Test.createAsset('test_cess1', rtDevNameIdMap.get('OF_OpenStream'), acc, contr);

		Test.startTest();
		//Database.executeBatch(new OF_BonificaCaseSenzaOrdine_Batch(), 200);
		DateTime dt = System.now().addSeconds(1);

		String hour = String.valueOf(dt.hour());
		String min = String.valueOf(dt.minute());
		String ss = String.valueOf(dt.second());

		String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';

		OF_BonificaCaseSenzaOrdine_sched sched = new OF_BonificaCaseSenzaOrdine_sched();

		System.schedule('BonificaCaseSenzaOrdini', nextFireTime, sched);
		Test.stopTest();
	}
}
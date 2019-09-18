@isTest
public class PO_CessazioneTest {

	public static testmethod void Method1() {
		PO_ServFatt_DataFactory.createCustomSettings();

		ServFattList__c cs = ServFattList__c.getAll().get('P2P Base');
		Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
		OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
		OF_Servizio__c serv = PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
		Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
		OF_CommercialElement__c ce = PO_ServFatt_DataFactory.createCE(serv, 'test_ce', 'CE-001');
		OF_BillingElement__c be = PO_ServFatt_DataFactory.createBE(ce, 'Contributo Attivazione', 'BE-001');
		OF_BillingElement__c be2 = PO_ServFatt_DataFactory.createBE(ce, 'Contributo Disattivazione', 'BE-002');
		OF_Listino__c listino_monofibra = PO_ServFatt_DataFactory.createListino(serv, 'P2PBASE_MONOFIBRA');
		OF_Listino__c listino_bifibra = PO_ServFatt_DataFactory.createListino(serv, 'P2PBASE_BIFIBRA');
		Pricebook2 pb = PO_ServFatt_DataFactory.createPriceBook(ce, be, listino_monofibra);
		Pricebook2 pbDisattivazione = PO_ServFatt_DataFactory.createPriceBook(ce, be2, listino_monofibra);
		Pricebook2 pbBifibra = PO_ServFatt_DataFactory.createPriceBook(ce, be, listino_bifibra);
		Pricebook2 pbDisattivazioneBifibra = PO_ServFatt_DataFactory.createPriceBook(ce, be2, listino_bifibra);

		Asset asset_1 = new Asset();
		asset_1.Name = 'IDR1234';
		asset_1.Status = 'Attivo';
		asset_1.EOF_ID_Risorsa__c = 'IDR1234';
		asset_1.accountId = acc.id;
		asset_1.OF_Contract__c = contr.Id;
		asset_1.OF_ProfiloOpenStream__c = 'P2PBase_Mono';
		insert asset_1;

		RecordType caseRt = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.caseDevName__c LIMIT 1];
		Case c = PO_ServFatt_DataFactory.createCase(acc, caseRt.Id, 'test_abcd', cs.Name, contr, null, null);
		c.AssetId = asset_1.Id;
		update c;

		OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
		cei.OF_Asset__c = asset_1.Id;
		cei.OF_IDRisorsa__c = asset_1.EOF_ID_Risorsa__c;
		cei.OF_Stato__c = 'Attivo';
		cei.RecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
		cei.OF_CommercialElement__c = ce.id;
		cei.OF_DataAttivazione__c = System.now();
		insert cei;

		Pricebook2 standardPricebook = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		update standardPricebook;

		standardPricebook = [SELECT IsStandard
							 FROM Pricebook2
							 WHERE Id = : standardPricebook.Id];

		Product2 testProduct = PO_ServFatt_DataFactory.createProduct(be);
		PO_ServFatt_DataFactory.createPBE(standardPricebook, testProduct, cei);

		test.startTest();
		PO_Cessazione.CessazioneAssetBECE(asset_1.id);
		test.stopTest();
	}

}
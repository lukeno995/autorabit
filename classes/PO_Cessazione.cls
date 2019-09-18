global with sharing class PO_Cessazione {

	webservice static void CessazioneAssetBECE(Id assetId) {

		PO_ServFattInfo cs = new PO_ServFattInfo();
		// List<String> servName = cs.getNames();
		List<String> servCode = cs.getCodes();

		Asset ast = [SELECT Id, OF_DataCessazione2__c, Status, OF_Contract__c, OF_ServizioRichiesto__c, OF_ProfiloOpenStream__c
					 FROM Asset WHERE Id = :assetId LIMIT 1];

		List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id, OF_Stato__c, OF_DataCessazione__c, OF_Asset__c, OF_CommercialElement__c FROM OF_CommercialElementIstanziato__c
														   WHERE OF_Asset__c = :assetId AND OF_Stato__c != 'Cessato' AND OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c IN :servCode];

		Pricebook2 pbCessazione = null;
		if (!ceiList.isEmpty()) {
			pbCessazione = getPBCessazione(ast, cs);
		}

		DateTime now = System.now();

		ast.Status = 'Cessato';
		ast.OF_DataCessazione2__c = now;

		Set<Id> ceiIds = new Set<Id>();
		PriceBookEntry pbe = null;
		for (OF_CommercialElementIstanziato__c cei : ceiList) {
			cei.OF_Stato__c = 'Cessato';
			cei.OF_DataCessazione__c = now;
			cei.UpdateBilling__c = true; // flag per il billing
			ceiIds.add(cei.Id);

			if ((pbCessazione != null) && (pbe == null) && pbCessazione.PO_Commercial_element__c.equals(cei.OF_CommercialElement__c)) {
				pbe = new PriceBookEntry();
				pbe.Pricebook2Id = pbCessazione.Id;
				pbe.IsActive = true;
				pbe.OF_DataAttivazione2__c = now;
				pbe.OF_Asset__c = assetId;
				pbe.OF_CommercialElementIstanziato__c = cei.Id;
				pbe.UnitPrice = pbCessazione.Unit_Price__c;
				pbe.UseStandardPrice = false;
			}
		}

		List<PricebookEntry> beiList = cessaBEI(ceiIds);

		addBEICessazione(pbe, pbCessazione);

		if (!ceiList.isEmpty()) {
			update ceiList;
			update beiList;
		}

		update ast;

		return;
	}

	private static Pricebook2 getPBCessazione(Asset a, PO_ServFattInfo cs) {
		Case c = [SELECT Id, PO_Offerta__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c
				  FROM Case WHERE AssetId = :a.Id AND (PO_Offerta__c != null OR PO_Tipo_di_collegamento__c != null OR PO_Tipologia_Offerta_ordine__c != null) LIMIT 1];

		String srvName = String.isNotBlank(c.PO_Offerta__c) ? c.PO_Offerta__c : c.PO_Tipologia_Offerta_ordine__c;

		OF_Listino__c listino = PO_ServFatt_OpportunityHandler.getListinoFromContract(a.OF_Contract__c, a.OF_ProfiloOpenStream__c, srvName).get(0);
		List<String> beList = cs.getCessazioneBeList(listino.Servizio__r.Name);
		List<Pricebook2> pbList = [SELECT Id, Name, Unit_Price__c, PO_Commercial_element__c, Billing_element__c, Billing_element__r.Name FROM Pricebook2
								   WHERE IsActive = true AND Unit_Price__c != null AND PO_Commercial_element__c != null AND Billing_element__c != null AND OF_Listino__c = :listino.Id AND Name IN :beList LIMIT 1];

		Pricebook2 pbCessazione = null;
		if (!pbList.isEmpty()) {
			pbCessazione = pbList.get(0);
		}
		return pbCessazione;
	}

	private static List<PricebookEntry> cessaBEI(Set<Id> ceiIds) {
		List<PricebookEntry> beiList = [SELECT Id, IsActive, OF_DataCessazione2__c, OF_CommercialElementIstanziato__c FROM PricebookEntry
										WHERE OF_CommercialElementIstanziato__c IN :ceiIds AND isActive = true];

		DateTime now = System.now();
		for (PricebookEntry bei : beiList) {
			bei.IsActive = false;
			bei.OF_DataCessazione2__c = now;
		}
		return beiList;
	}

	private static void addBEICessazione(PriceBookEntry pbe, Pricebook2 pbCessazione) {
		if ((pbe == null) || (pbCessazione == null)) {
			return;
		}

		Product2 p = PO_ServFatt_CRMHandler.createProduct(pbCessazione.Billing_element__c, pbCessazione.Billing_element__r.Name);
		insert p;
		pbe.Product2Id = p.Id;
		List<PriceBookEntry> pbeList = new List<PriceBookEntry>();
		Id standardPbId = [SELECT Id FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id;
		pbeList.add(PO_ServFatt_CRMHandler.createPBES(p.Id, standardPbId));
		pbeList.add(pbe);
		insert pbeList;
	}
}
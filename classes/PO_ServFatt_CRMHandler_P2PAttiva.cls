public with sharing class PO_ServFatt_CRMHandler_P2PAttiva extends PO_ServFatt_CRMHandler {

	public PO_ServFatt_CRMHandler_P2PAttiva(String s) {
		super(s);
	}

	public override Id espletamento(Case caseOrdine, Boolean esitoOK) {
		System.debug('Inizio Espletamento P2PAttiva - CaseId: ' + caseOrdine.Id + ' - EsitoOK: ' + esitoOK);
		String stato = esitoOK ? ESPLETATO_OK : ESPLETATO_KO;
		caseOrdine.Status = stato;
		caseOrdine.EOF_Fase__c = stato;
		caseOrdine.OF_AggiornoOrdine__c = true;
		Order o = chiusuraOrdine(caseOrdine);
		System.debug('Aggiornato ordine [' + o.Id + '] per il case: ' + caseOrdine.Id);
		if (!esitoOK) {
			update caseOrdine;
			return null;
		}

		Map<String, Id> rtDevName_IdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
		String name = String.isNotBlank(o.OF_IDRisorsa__c) ? o.OF_IDRisorsa__c : o.OF_IDOrdineEOF__c;
		Asset a = createAsset(o, rtDevName_IdMap.get(srvData.assetDevName__c), name, caseOrdine, o.Contract.OF_Rinnovabile__c);

		Case caseKit = null;
		Asset aKit = null;
		if (String.isNotBlank(caseOrdine.PO_KIT_Consegna_VLAN__c) && String.isBlank(caseOrdine.PO_KIT_Consegna_VLAN__r.assetId)) {
			caseKit = [SELECT Id, EOF_Identificativo_del_POP__c, PO_P2PAttiva_Kit_Indirizzo_Consegna__c, PO_PP_NomeKit__c, PO_P2PAttiva_KIT_OpticalRateLimiting__c, EOF_Codice_Ordine_OLO__c
//					   , EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c,
//					   EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_Esito_Consegna_Apparato__c,
//					   EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c, PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c,
//					   OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_SA_Codice_Motivazione__c, OF_SA_Motivazione__c
					   FROM Case WHERE Id = :caseOrdine.PO_KIT_Consegna_VLAN__c LIMIT 1];

			Order orderKit = createOrderKit(caseKit, o, rtDevName_IdMap.get('OF_INORDER'), caseOrdine.OF_SA_Profilo__c);
			aKit = createAsset(orderKit, rtDevName_IdMap.get('PO_Asset_P2P_Attiva_KIT'), orderKit.OF_IDRisorsa__c, caseKit, o.Contract.OF_Rinnovabile__c);
		}

		List<OpportunityLineItem> oppLinItemList = [SELECT Id, PricebookEntryId, Price_Book__c, Price_Book__r.PO_Commercial_element__c, Price_Book__r.PO_Commercial_element__r.Name, Price_Book__r.Billing_element__r.Name, Price_Book__r.Billing_element__c, Quantity, Discount, ListPrice, PO_SalesPrice__c, TotalPrice, UnitPrice
													FROM OpportunityLineItem
													WHERE Opportunity.PO_Collegamento__c = :caseOrdine.PO_Case_Collegamento__c AND Price_Book__c != null];

		List<OpportunityLineItem> oliKitList = removeOliKit(oppLinItemList);
		String ceiRtId = rtDevName_IdMap.get(srvData.ceiDevName__c);
		createBEI(a, ceiRtId, oppLinItemList);

		List<Case> caseToUpdate = new List<Case>();
		caseToUpdate.add(caseOrdine);
		if (caseKit != null) {
			createBEI(aKit, ceiRtId, oliKitList);
			caseToUpdate.add(caseKit);
		}
		update caseToUpdate;

		System.debug('Fine Espletamento P2PAttiva - CaseId: ' + caseOrdine.Id);
		return a.Id;
	}

	private Order createOrderKit(Case caseKit, Order o, String rtId, String profilo) {
		if (caseKit == null) {
			return null;
		}

		System.debug('createOrderKit for CaseKit: ' + caseKit.Id);

		Order orderKit = new Order();
		orderKit.recordtypeId = rtId;
		orderKit.OF_IdentificativoDelPOP__c = caseKit.EOF_Identificativo_del_POP__c;
		orderKit.OF_Esito__c = 'OK';
		orderKit.status = 'Chiuso';
		orderKit.OF_IDRisorsa__c = 'KIT_' + caseKit.EOF_Codice_Ordine_OLO__c; // caseKit.PO_PP_NomeKit__c; // Billing
		orderKit.OF_DataEsito__c = System.today(); // Billing
		orderKit.OF_IDOrdineOLO__c = caseKit.EOF_Codice_Ordine_OLO__c; // Billing
		orderKit.OF_Comune__c = o.OF_Comune__c; // Billing
		orderKit.OF_Provincia__c = o.OF_Provincia__c; // Billing
		orderKit.OF_Indirizzo__c = o.OF_Indirizzo__c; // Billing
		orderKit.OF_Civico__c = o.OF_Civico__c; // Billing
		orderKit.AccountId = o.AccountId; // Billing
		orderKit.ContractId = o.ContractId; // Billing
		orderKit.OF_ProfiloOpenStream__c = profilo;
		orderKit.effectiveDate = o.effectiveDate;
		orderKit.NS_Rif__c = String.isNotBlank(o.NS_Rif__c) ? o.NS_Rif__c : o.Contract.NS_Rif__c;
		if (o.PO_DataAttivazioneOrdine__c != null) {
			orderKit.PO_DataAttivazioneOrdine__c = o.PO_DataAttivazioneOrdine__c;
		}
		if (String.isNotBlank(o.OF_Profilo__c)) {
			orderKit.OF_Profilo__c = o.OF_Profilo__c;
		}

		insert orderKit;
		caseKit.OF_Order__c = orderKit.Id;

		return orderKit;
	}

	private List<OpportunityLineItem> removeOliKit(List<OpportunityLineItem> oppLinItemList) {
		List<OpportunityLineItem> oliKitList = new List<OpportunityLineItem>();
		if ((oppLinItemList == null) || oppLinItemList.isEmpty()) {
			return oliKitList;
		}

		for (Integer i = oppLinItemList.size() - 1; i >= 0; i--) {
			OpportunityLineItem oli = oppLinItemList.get(i);
			if ('KIT di consegna'.equalsIgnoreCase(oli.Price_Book__r.PO_Commercial_element__r.Name)
				|| COMMERCIAL_KIT.equalsIgnoreCase(oli.Price_Book__r.PO_Commercial_element__r.Name)) {
				oliKitList.add(oli);
				oppLinItemList.remove(i);
			}
		}

		return oliKitList;
	}
}
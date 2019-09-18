public without sharing class PO_ServiziFattDOMKitHandler extends PO_ServiziFattDOM {
    public PO_ServiziFattDOMKitHandler(String rTypeDevName) {
        super(rTypeDevName);
    }

    public override Id espletamentoOK(Case theCase) {
        theCase.Status = ESPLETATO_OK;
		theCase.EOF_Fase__c = ESPLETATO_OK;
		theCase.PO_Data_Espletamento_Ordine__c  = System.today();
        update theCase;
        System.debug('##### PO_ServiziFattDOMKitHandler.espletamentoOK - case updated ' + theCase.Id);
        return espletamento(theCase, true);
    }

    public override Id espletamento(Case theCase, Boolean esitoOK) {
        System.debug('##### PO_ServiziFattDOMKitHandler.espletamentoOK - START');
        Map<String, Id> map_rTypeDevNameId = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();

        Case caseOrdine = getCaseOrdine(theCase);
        Order orderCaseOrdine = getOrder(caseOrdine.OF_Order__c);
        String name = String.isNotBlank(orderCaseOrdine.OF_IDRisorsa__c) ? 
			orderCaseOrdine.OF_IDRisorsa__c : orderCaseOrdine.OF_IDOrdineEOF__c;
        
        Order orderKit = createOrderKit(theCase, orderCaseOrdine, map_rTypeDevNameId.get('OF_INORDER'), caseOrdine.OF_SA_Profilo__c);
        Asset assetKit = createAsset(orderKit, map_rTypeDevNameId.get('PO_Asset_P2P_Attiva_KIT'), 
			orderKit.OF_IDRisorsa__c, theCase, orderCaseOrdine.Contract.OF_Rinnovabile__c);

        List<OpportunityLineItem> oppLinItemList = [SELECT Id, PricebookEntryId, Price_Book__c, Price_Book__r.PO_Commercial_element__c, 
				Price_Book__r.PO_Commercial_element__r.Name, Price_Book__r.Billing_element__r.Name, Price_Book__r.Billing_element__c, 
				Quantity, Discount, ListPrice, PO_SalesPrice__c, TotalPrice, UnitPrice, Product2Id
			FROM OpportunityLineItem
			WHERE Opportunity.PO_Collegamento__c = :theCase.PO_Case_Collegamento__c 
			AND Price_Book__c != null
			AND Price_Book__r.PO_Commercial_element__r.Name =: KIT_COMMERCIAL_EL_NAME];
        System.debug('##### PO_ServiziFattDOMKitHandler.espletamentoOK  -- oppLinItemList from query : ' + oppLinItemList);

        String ceiRtId = map_rTypeDevNameId.get(srvData.ceiDevName__c);
		createBEI(assetKit, ceiRtId, oppLinItemList);
        System.debug('##### PO_ServiziFattDOMKitHandler.espletamentoOK - END');
        update theCase;
        //aggiornaLog(theCase);
        return assetKit.Id;
    }

    private Case getCaseOrdine(Case caseKit) {

		List<Case> l_ordine = [SELECT Id, OF_Order__c, OF_SA_Profilo__c FROM Case WHERE PO_KIT_Consegna_VLAN__c =: caseKit.Id
			AND RecordType.DeveloperName = 'PO_Ordine_P2P_Attiva'];
		System.debug('##### PO_ServiziFattDOMKitHandler.getCaseOrdine: ordine associato al kit: ' + l_ordine);
		return (l_ordine.isEmpty()) ? null : l_ordine[0];		
	}

    private static Order getOrder(Id oId) {
		List<Order> l_order = [SELECT Id, ContractId, Contract.OF_Rinnovabile__c, Contract.NS_Rif__c, AccountId, RecordTypeId, Status, OF_Esito__c, OF_Apparato__c,
				   OF_Asset__c, OF_DataEsito__c, OF_EsitoConsegnaApparato__c, OF_ScalaPalazzina__c,
				   OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDOrdineEOF__c, OF_IDOrdineOLO__c,
				   OF_IDRisorsa__c, OF_IDSplitterSecondario__c, OF_IdentificativoDelPOP__c,
				   OF_Provincia__c, OF_Comune__c, OF_ParticellaToponomastica__c, OF_Indirizzo__c, OF_Civico__c,
				   OF_PosizioneSplitterSecondario__c, OF_SlaPremiumAssurance__c, OF_ClusterPromozione__c,
				   OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, OF_IDServizio__c, OF_PasswordApparato__c,
				   OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, OF_ProfiloOpenStream__c,
				   PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_LunghezzaOttica__c, OF_Profilo__c,
				   OF_DescrizioneKO__c, effectiveDate, CreatedDate, OF_IDContratto__c,
				   NS_Rif__c,  // FD 2019-02-27
				   PO_PosizioneRilascioCircuitoOSU__c, OF_CodiceKO__c, (SELECT Accordo_Operativo__c FROM Cases__r)
				   FROM Order WHERE Id =: oId];
		return (l_order.isEmpty()) ? null : l_order[0];
	}

    private static Order createOrderKit(Case caseKit, Order o, String rtId, String profilo) {
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


}
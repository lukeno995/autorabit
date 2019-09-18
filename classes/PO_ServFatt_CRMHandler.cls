public virtual class PO_ServFatt_CRMHandler {

	protected final String servizio;
	protected final ServFattList__c srvData;

	public static final String ESPLETATO_OK = 'Espletato OK';
	public static final String ESPLETATO_KO = 'Espletato KO';
	public static final String FIBER_LINK_ALTRI_ANNI = 'ALTRI_ANNI';
	
	public static final String SERVIZIO_P2P_ATTIVA = 'P2P Attiva';
	public static final String COLLEGAMENTO_E_ACCESS = 'E-Access';
    public static final String COLLEGAMENTO_E_LINE = 'E-Line';
    public static final String SEDE_MASTER = 'Master';
    public static final String SEDE_SATELLITE = 'Satellite';
	public static final String COMMERCIAL_KIT = 'KIT E-Access';

	public PO_ServFatt_CRMHandler(String s) {
		PO_ServFattInfo cs = new PO_ServFattInfo();
		Map<String, ServFattList__c> m = cs.getCaseDevNameMap();
		if (String.isBlank(s) || !m.containsKey(s)) {
			InvalidParameterValueException e = new InvalidParameterValueException('Case.recordType.DeveloperName', s);
			String msg = String.isBlank(s) ? 'The DeveloperName cannot be null or empty' : 'Unknown DeveloperName';
			e.setMessage(msg);
			System.debug(LoggingLevel.ERROR, 'PO_ServFatt_CRMHandler - ERRORE: ' + msg);
			throw e;
		}
		srvData = m.get(s);
		servizio = srvData.Name;
	}

	public virtual Id espletamento(Case caseOrdine, Boolean esitoOK) {
		System.debug('Inizio Espletamento Servizi Fattibilità - CaseId: ' + caseOrdine.Id + ' - EsitoOK: ' + esitoOK);
		String stato = esitoOK ? ESPLETATO_OK : ESPLETATO_KO;
		caseOrdine.Status = stato;
		caseOrdine.EOF_Fase__c = stato;
		caseOrdine.PO_Data_Espletamento_Ordine__c  = System.today(); //FD 2019-03-07
		caseOrdine.OF_AggiornoOrdine__c = true;
		Order o = chiusuraOrdine(caseOrdine);
		System.debug('Aggiornato ordine [' + o.Id + '] per il case: ' + caseOrdine.Id);
		if (!esitoOK) {
			update caseOrdine;

			//gernetti 22/02/2019 inizio
			aggiornaLog(caseOrdine);
			//gernetti 22/02/2019 fine

			return null;
		}

		Map<String, Id> rtDevNameIdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
		String name = String.isNotBlank(o.OF_IDRisorsa__c) ? o.OF_IDRisorsa__c : o.OF_IDOrdineEOF__c;
		Asset a = createAsset(o, rtDevNameIdMap.get(srvData.assetDevName__c), name, caseOrdine, o.Contract.OF_Rinnovabile__c);

        List<OpportunityLineItem> oppLinItemList = new List<OpportunityLineItem>();

		oppLinItemList = [SELECT Id, OpportunityId, Opportunity.RecordType.DeveloperName, Price_Book__c, Product2Id,
				Price_Book__r.OF_Listino__r.Name, Price_Book__r.PO_Commercial_element__c, Price_Book__r.Billing_element__r.Name,
			 	Price_Book__r.Billing_element__c, Quantity, UnitPrice//, PricebookEntryId, Discount, ListPrice, PO_SalesPrice__c, TotalPrice
				FROM OpportunityLineItem
				WHERE Opportunity.PO_Collegamento__c = :caseOrdine.PO_Case_Collegamento__c 
				AND Price_Book__c != null AND Price_Book__r.OF_Listino__r.Servizio__r.Name = :servizio
				AND Price_Book__r.PO_Commercial_element__r.Name !=: COMMERCIAL_KIT];
				// Evito di prendere l'oppty line item creata per il kit e-access perchè l'espletamento del 
				// kit, quando la richiesta di espletamento arriva dal DOM, viene fatto separatamente in un'altra classe, 
				// OF_Utils_P2P. Quando l'espletamento è manuale, da CRM, il kit viene espletato contestualmente all'ordine
				// e la gestione di questo viene fatta nella classe PO_ServFatt_CRMHandler_P2PAttiva.
				// 'KIT E-Access' è il nome del commercial element relativo al kit. Se rimane univoco la where condition
				// su questo valore non impatta gli altri servizi a fattibilità.
		System.debug('@@@@@ PO_ServFatt_CRMHandler.espletamento -- oppLinItemList from query : ' + oppLinItemList);

		oppLinItemList = fiberLinkFilterOpportunityLineItem(oppLinItemList, caseOrdine);

		System.debug('@@@@@ PO_ServFatt_CRMHandler.espletamento -- oppLinItemList from fiberLinkFilterOpportunityLineItem: ' + oppLinItemList);
		createBEI(a, rtDevNameIdMap.get(srvData.ceiDevName__c), oppLinItemList);
		update caseOrdine;
		System.debug('Fine Espletamento Servizi Fattibilità - CaseId: ' + caseOrdine.Id);

		//gernetti 22/02/2019 inizio
		aggiornaLog(caseOrdine);
		//gernetti 22/02/2019 fine

		return a.Id;
	}

	private List<OpportunityLineItem> fiberLinkFilterOpportunityLineItem(List<OpportunityLineItem> oppLinItemList, Case c) {
		String srvName = String.isNotBlank(c.PO_Offerta__c) ? c.PO_Offerta__c : c.PO_Tipologia_Offerta_ordine__c;
		String nomeListino = c.OF_SA_Profilo__c;
		Id offertaCollId = null;

		System.debug('nomeListino = ' + nomeListino);
		System.debug('srvName = ' + srvName);

		if (!'Fiber Link'.equalsIgnoreCase(srvName) || String.isBlank(nomeListino) || oppLinItemList.isEmpty()) {
			return oppLinItemList;
		}

		OpportunityLineItem lineItem = oppLinItemList.get(0);
		Boolean misto = PO_ServFatt_OpportunityHandler.OFFERTA_COLLEGAMENTO_FLEASE_MISTA_RT.equalsIgnoreCase(lineItem.Opportunity.RecordType.DeveloperName);
		// CR Totonno/MOF
		if (PO_ServFatt_CRMHandler.FIBER_LINK_ALTRI_ANNI.equalsIgnoreCase(nomeListino) || misto) {
			nomeListino = lineItem.Price_Book__r.OF_Listino__r.Name;
			if (!misto) {
				offertaCollId = lineItem.OpportunityId;
			}
		}

		for (Integer i = oppLinItemList.size() - 1; i >= 0; i--) {
			OpportunityLineItem oli = oppLinItemList.get(i);
			if (!nomeListino.equalsIgnoreCase(oli.Price_Book__r.OF_Listino__r.Name)) {
				oppLinItemList.remove(i);
			}
		}

		// CR Totonno/MOF
		setFiberLinkAltriAnniPrice(offertaCollId, oppLinItemList);

		return oppLinItemList;
	}

	private void setFiberLinkAltriAnniPrice(Id offertaCollId, List<OpportunityLineItem> oppLinItemList) {
		if (offertaCollId == null) {
			return;
		}

		Opportunity offertaColl = [SELECT Id, PO_Costi_Aggiuntivi_Altri_Anni__c, PO_Canone_annuo_AltriAnni__c, PO_Contributo_attivazione_altri_anni__c,
								   PO_Offerta_totale__c, PO_Offerta_totale__r.PO_Sconto_Canone_annuo_altriAnni__c, PO_Offerta_totale__r.PO_Sconto_ContributoAttivazione_altriAnn__c, PO_Offerta_totale__r.PO_Sconto_Costi_Aggiuntivi_Altri_Anni_1__c
								   FROM Opportunity WHERE Id = :offertaCollId];

		Decimal scontoCanone = offertaColl.PO_Offerta_totale__r.PO_Sconto_Canone_annuo_altriAnni__c != null ? offertaColl.PO_Offerta_totale__r.PO_Sconto_Canone_annuo_altriAnni__c : 0;
		Decimal scontoAttivazione = offertaColl.PO_Offerta_totale__r.PO_Sconto_ContributoAttivazione_altriAnn__c != null ? offertaColl.PO_Offerta_totale__r.PO_Sconto_ContributoAttivazione_altriAnn__c : 0;
		Decimal scontoAggiuntivi = offertaColl.PO_Offerta_totale__r.PO_Sconto_Costi_Aggiuntivi_Altri_Anni_1__c != null ? offertaColl.PO_Offerta_totale__r.PO_Sconto_Costi_Aggiuntivi_Altri_Anni_1__c : 0;
		Decimal canone = offertaColl.PO_Canone_annuo_AltriAnni__c != null ? offertaColl.PO_Canone_annuo_AltriAnni__c : 0;
		Decimal attivazione = offertaColl.PO_Contributo_attivazione_altri_anni__c != null ? offertaColl.PO_Contributo_attivazione_altri_anni__c : 0;
		Decimal aggiuntivi = offertaColl.PO_Costi_Aggiuntivi_Altri_Anni__c != null ? offertaColl.PO_Costi_Aggiuntivi_Altri_Anni__c : 0;

		for (OpportunityLineItem oli : oppLinItemList) {
			if ('Canone'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
				oli.UnitPrice = (canone - ((canone * scontoCanone) / 100));
			} else if ('Contributo Attivazione'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
				oli.UnitPrice = (attivazione - ((attivazione * scontoAttivazione) / 100));
			} else if ('Contributo Aggiuntivo'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
				oli.UnitPrice = (aggiuntivi - ((aggiuntivi * scontoAttivazione) / 100));
			}
		}
	}

	//gernetti 22/02/2019 inizio
	protected void aggiornaLog(Case theCase) {
		if (theCase == null) {
			return;
		}
		List<Attachment> theAttachments = [SELECT ParentId, Name, Body FROM Attachment WHERE ParentId = :theCase.PO_Case_Collegamento__c];

		List<EOF_EAI_Service_Log__c> theLogsOrdini = [SELECT id, EOF_Stato_Richiesta__c, EOF_STATO_ORDINE__c, Caso__c
													  FROM EOF_EAI_Service_Log__c //WHERE Caso__c = :theCase.PO_Case_Collegamento__c];
													  WHERE Caso__c = :theCase.Id];

		EOF_EAI_Service_Log__c theLogOrdine = null;
		if ((theLogsOrdini != null) && !theLogsOrdini.isEmpty()) {
			theLogOrdine = theLogsOrdini[0];
			theLogOrdine.EOF_STATO_ORDINE__c = theCase.Status;
            theLogOrdine.PO_Data_Attivazione_Ordine__c = theCase.PO_Data_Espletamento_Ordine__c;

			update theLogOrdine;
		}

		if ((theLogOrdine != null) && (theAttachments != null) && !theAttachments.isEmpty()) {
			List<Attachment> theAttachmentsToInsert = new List<Attachment>();
			Attachment theAttachment = theAttachments[0];

			theAttachmentsToInsert.addAll(PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob> {theAttachment.Body}, theLogOrdine.Id, new list<String> {theAttachment.Name}));

			insert theAttachmentsToInsert;
		}

		/*
		   List<Attachment> listaAttach = new List<Attachment>()
		   listaAttach.addAll(PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob> {act.Attachment},c.PO_Case_Collegamento__c, new list<String> {act.ATTACHMENT_NAME}));
		   insert listaAttach;
		 */
	}
	//gernetti 22/02/2019 fine

	protected Order chiusuraOrdine(Case c) {
		System.debug(LoggingLevel.INFO, 'Aggiorna Ordine for Case: ' + c.Id);
		Order o = [SELECT Id, ContractId, Contract.OF_Rinnovabile__c, Contract.NS_Rif__c, AccountId, RecordTypeId, Status, OF_Esito__c, OF_Apparato__c,
				   OF_Asset__c, OF_DataEsito__c, OF_EsitoConsegnaApparato__c, OF_ScalaPalazzina__c,
				   OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDOrdineEOF__c, OF_IDOrdineOLO__c,
				   OF_IDRisorsa__c, OF_IDSplitterSecondario__c, OF_IdentificativoDelPOP__c,
				   OF_Provincia__c, OF_Comune__c, OF_ParticellaToponomastica__c, OF_Indirizzo__c, OF_Civico__c,
				   OF_PosizioneSplitterSecondario__c, OF_SlaPremiumAssurance__c, OF_ClusterPromozione__c,
				   OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, OF_IDServizio__c, OF_PasswordApparato__c,
				   OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, OF_ProfiloOpenStream__c,
				   PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_LunghezzaOttica__c, OF_Profilo__c,
				   OF_DescrizioneKO__c, effectiveDate, CreatedDate,
				   NS_Rif__c,  // FD 2019-02-27
				   PO_PosizioneRilascioCircuitoOSU__c, OF_CodiceKO__c, (SELECT Accordo_Operativo__c FROM Cases__r)
				   FROM Order WHERE Id = :c.OF_Order__c LIMIT 1];


		if (String.isBlank(o.ContractId)) {
			NoDataFoundException e = new NoDataFoundException();
			String msg = 'Order without contractId for Case [' + c.Id + ']';
			e.setMessage(msg);
			System.debug(LoggingLevel.ERROR, 'PO_ServFatt_CRMHandler.chiusuraOrdine - ERRORE: ' + msg);
			throw e;
		}
		o.OF_Esito__c = ESPLETATO_OK.equalsIgnoreCase(c.Status) ? 'OK' : 'KO';
		o.status = 'Chiuso';
		o.OF_DataEsito__c = System.today(); // billing
		o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c; // billing
		o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
		o.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
		o.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
		o.OF_Apparato__c = c.EOF_Apparato__c;
		o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
		o.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
		o.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
		o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
		o.OF_IDBuilding__c = c.EOF_ID_Building_WS__c;
		o.OF_IdentificativoDelPOP__c = c.EOF_Identificativo_del_POP__c;
		o.OF_Comune__c = String.IsNotBlank(c.PO_Nome_Comune__c) ? c.PO_Nome_Comune__c : String.isNotBlank(c.PO_Comune__c) ? c.PO_Comune__c : c.EOF_Comune_WS__c;
		//o.OF_Comune__c = String.isNotBlank(c.PO_Comune__c) ? c.PO_Comune__c : String.isNotBlank(c.EOF_Comune_WS__c) ? c.EOF_Comune_WS__c : c.EOF_Istat_Comune__c;
		o.OF_Provincia__c = (String.IsNotBlank(c.PO_Comune2__c) && String.IsNotBlank(c.PO_Comune2__r.OF_Provincia__c)) ? c.PO_Comune2__r.OF_Provincia__c : String.isNotBlank(c.EOF_Provincia_WS__c) ? c.EOF_Provincia_WS__c : c.EOF_Istat_Provincia__c;
		//o.OF_ParticellaToponomastica__c = c.Particella_Toponomastica_1__c; //FD 2019-02-26
		o.OF_Indirizzo__c = String.isNotBlank(c.PO_Indirizzo_collegamento__c) ? c.PO_Indirizzo_collegamento__c : c.EOF_Indirizzo_WS__c;
		o.OF_Civico__c = String.isNotBlank(c.PO_Civico__c) ? c.PO_Civico__c : c.EOF_Numero_Civico_WS__c;
		o.OF_ScalaPalazzina__c = c.EOF_Scala_Palazzina_WS__c;
		o.PO_Attenuazione__c = c.PO_Attenuazione__c;
		o.PO_LunghezzaOttica__c = c.PO_Lunghezza_Ottica__c;
		o.PO_PosizioneRilascioCircuitoOSU__c = c.PO_Posizione_Rilascio_Circuito_OSU__c;
		if (c.PO_Data_Attivazione_Ordine__c != null) {
			o.PO_DataAttivazioneOrdine__c = Datetime.newInstance(c.PO_Data_Attivazione_Ordine__c, Time.newInstance(0, 0, 0, 0));
		}
		if (c.OF_SA_Profilo__c != null) {
			Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
			OF_CodificaProfiloListini__c cpl = mapCodifica.get(c.OF_SA_Profilo__c);
			if (cpl != null) {
				o.OF_Profilo__c = cpl.OF_ListinoCanoneName__c;
			}
		}
		o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
		o.OF_Promozione__c = c.OF_SA_Promozione__c;
		o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c;
		o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
		o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
		o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;

		update o;

		System.debug(LoggingLevel.INFO, 'END - Chiusura Ordine for Case: ' + c.Id);
		return o;
	}

	protected Asset createAsset(Order o, String rtId, String name, Case caseOrig, Boolean rinnovable) {
		if ((caseOrig == null) || (o == null)) {
			return null;
		}

		System.debug(LoggingLevel.INFO, 'CreateAsset for order: ' + o.Id);
		Asset a = new Asset();
		a.recordTypeId = rtId;
		a.name = name;

		String slaPremium = String.isNotBlank(o.OF_SlaPremiumAssurance__c) ? o.OF_SlaPremiumAssurance__c : 'N';
		a.OF_OrdineID__c = o.Id; // Billing
		a.EOF_ID_Risorsa__c = name; // Billing
		a.AccountId = o.AccountID; // Billing
		a.OF_Contract__c = o.ContractId; // Billing
		a.OF_ProfiloOpenStream__c = o.OF_ProfiloOpenStream__c; // Billing
		a.Status = 'Attivo'; // Billing
		a.OF_DataAttivazione2__c = System.now(); // Billing
		a.OF_Provincia__c = o.OF_Provincia__c; // Billing
		a.OF_Comune__c = o.OF_Comune__c; // Billing
		a.OF_Particella_Toponomastica__c = o.OF_ParticellaToponomastica__c; // Billing
		a.OF_Indirizzo__c = o.OF_Indirizzo__c; // Billing
		a.OF_Civico__c = o.OF_Civico__c; // Billing
		a.OF_ID_Building__c = o.OF_IDBuilding__c; // Billing
		a.OF_Identificativo_del_POP__c = o.OF_IdentificativoDelPOP__c;
		a.OF_GPON_Attestazione__c = o.OF_GPONAttestazione__c;
		a.OF_Scala_Palazzina__c = o.OF_ScalaPalazzina__c;
		a.OF_ServizioRichiesto__c = servizio;
		a.EOF_ID_Splitter_Secondario__c = o.OF_IDSplitterSecondario__c;
		a.EOF_Posizione_Splitter_Secondario__c = o.OF_PosizioneSplitterSecondario__c;
		a.OF_ProgettoSpeciale__c = o.OF_ProgettoSpeciale__c;
		a.OF_IDCaseAttivazione__c = o.OF_IDCaso__c;
		a.OF_Promozione__c = o.OF_Promozione__c;
		a.OF_ClusterPromozione__c = o.OF_ClusterPromozione__c;
		a.OF_TipologiaApparato__c = o.OF_TipologiaApparato__c;
		a.OF_CodiceProgettoSpeciale__c = o.OF_CodiceProgettoSpeciale__c;
		a.OF_IDServizio__c = o.OF_IDServizio__c;
		a.EOF_SLA_Premium_Assurance__c = slaPremium;
		a.OF_Data_Accordo_Operativo__c = o.CreatedDate;
		a.NS_Rif__c = String.isNotBlank(o.NS_Rif__c) ? o.NS_Rif__c : o.Contract.NS_Rif__c; // FD 2019-02-27
		a.OF_DataScadenza__c = System.today().addYears(15);
		a.PO_Attenuazione__c = o.PO_Attenuazione__c;
		a.PO_LunghezzaOttica__c = Integer.valueOf(o.PO_LunghezzaOttica__c);
		a.PO_PosizioneRilascioCircuitoOSU__c = o.PO_PosizioneRilascioCircuitoOSU__c;
		a.OF_Rinnovabile__c = rinnovable;
		if (!o.Cases__r.isEmpty()) {
			a.Accordo_Operativo__c = o.Cases__r[0].Accordo_Operativo__c;
		}

		//Accordo Quadro da fare
		insert a;
		System.debug('Asset ID: ' + a.Id);
		o.OF_Asset__c = a.Id; // Billing
		caseOrig.AssetId = a.Id;

		// String className = String.valueOf(this).split(':')[0];

		update o;

		System.debug(LoggingLevel.INFO, 'END - CreateAsset for order: ' + o.Id);
		return a;
	}

	protected List<OF_CommercialElementIstanziato__c> createCEI(Asset a, String rtId, Set<Id> ceIds) {
		System.debug(LoggingLevel.INFO, 'Create CEI for Asset: ' + a.Id);

		Datetime now = System.now();
		List<OF_CommercialElementIstanziato__c> ceiList = new List<OF_CommercialElementIstanziato__c>();
		for (Id ce : ceIds) {
			OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
			cei.OF_CommercialElement__c = ce;
			cei.OF_Asset__c = a.Id;
			cei.OF_AssetTratta__c = a.Id;
			cei.RecordTypeId = rtId;
			cei.OF_BillingSyncronized__c = false; // flag per il billing
			cei.UpdateBilling__c = true; // flag per il billing
			cei.OF_Stato__c = 'Attivo';
			cei.OF_IDRisorsa__c = a.EOF_ID_Risorsa__c;
			cei.OF_DataAttivazione__c = now;
			ceiList.add(cei);
		}

		insert ceiList;
		System.debug(LoggingLevel.INFO, 'END - Create CEI for Asset: ' + a.Id);
		return ceiList;
	}

	protected List<PricebookEntry> createBEI(Asset a, String rtId, List<OpportunityLineItem> oppLinItemList) {
		System.debug(LoggingLevel.INFO, 'Create PBE for Asset: ' + a.Id);
		Set<Id> ceIds = new Set<Id>();

		for (OpportunityLineItem oppLinItem : oppLinItemList) {
			ceIds.add(oppLinItem.Price_Book__r.PO_Commercial_element__c);
		}

		List<OF_CommercialElementIstanziato__c> ceiList = createCEI(a, rtId, ceIds);
		Map<Id, Id> mapCeIdCeiId = new Map<Id, Id>();
		for (OF_CommercialElementIstanziato__c cei : ceiList) {
			mapCeIdCeiId.put(cei.OF_CommercialElement__c, cei.Id);
		}

		List<PricebookEntry> listPBE = new List<PricebookEntry>();
		List<Product2> listProd = new List<Product2>();
		Map<Id, PriceBookEntry> mapIdBePBE = new Map<Id, PriceBookEntry>();
		DateTime now = System.now();
		for (OpportunityLineItem oppLinItem : oppLinItemList) {
			PriceBookEntry pbe = new PriceBookEntry();
			pbe.Pricebook2Id = oppLinItem.Price_Book__c;
			pbe.IsActive = true;
			pbe.OF_DataAttivazione2__c = now;
			pbe.OF_Asset__c = a.Id;
			pbe.OF_CommercialElementIstanziato__c = mapCeIdCeiId.get(oppLinItem.Price_Book__r.PO_Commercial_element__c);
			pbe.UnitPrice = oppLinItem.UnitPrice;
			pbe.Quantity__c = oppLinItem.Quantity;
			pbe.UseStandardPrice = false;
			pbe.OF_Order__c = a.OF_OrdineID__c;
			listPBE.add(pbe);
			mapIdBePBE.put(oppLinItem.Price_Book__r.Billing_element__c, pbe);

			Product2 p = PO_ServFatt_CRMHandler.createProduct(oppLinItem.Price_Book__r.Billing_element__c, oppLinItem.Price_Book__r.Billing_element__r.Name);
			listProd.add(p);
		}

		if (!listProd.isEmpty()) {
			Id pbsId = !Test.isRunningTest() ? [SELECT Id FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id : Test.getStandardPricebookId();
			insert listProd;
			List<PricebookEntry> listPBES = new List<PricebookEntry>();
			for (Product2 p : listProd) {
				PriceBookEntry pbe = mapIdBePBE.get(p.OF_BillingElement__c);
				pbe.Product2Id = p.Id;
				listPBES.add(PO_ServFatt_CRMHandler.createPBES(p.Id, pbsId));
			}
			try {
				insert listPBES;
				insert listPBE;
			} catch (DMLException e) {
				String msg = 'Asset [' + a.Id + '] - BEI non inseriti';
				System.debug(LoggingLevel.ERROR, msg + '\n' + e.getMessage());
				listPBES.addAll(listPBE);
				List<OF_STAGING_PBE__c> pbeStagList = new List<OF_STAGING_PBE__c>();
				for (PricebookEntry pbe : listPBES) {
					OF_STAGING_PBE__c stg = new OF_STAGING_PBE__c();
					stg.isActive__c = pbe.IsActive;
					stg.OF_Asset__c = pbe.OF_Asset__c;
					stg.Pricebook2Id__c = pbe.Pricebook2Id;
					stg.Quantity__c = pbe.Quantity__c;
					stg.OF_DataAttivazione2__c = pbe.OF_DataAttivazione2__c;
					stg.OF_DataCessazione2__c = pbe.OF_DataCessazione2__c;
					stg.UseStandardPrice__c = pbe.UseStandardPrice;
					stg.UnitPrice__c = pbe.UnitPrice;
					stg.OF_CommercialElementIstanziato__c = pbe.OF_CommercialElementIstanziato__c;
					stg.Product2Id__c = pbe.Product2Id;
					stg.OF_Order__c = pbe.OF_Order__c;
					stg.tipoApparato__c = pbe.tipoApparato__c;
					stg.ERROR__c = false;
					pbeStagList.add(stg);
				}
				insert pbeStagList;
			}
		}

		System.debug(LoggingLevel.INFO, 'END - Create PBE for Asset: ' + a.Id);
		return listPBE;
	}

	// See: https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_product2.htm
	// A product can only have one price for a given currency within the same price book.
	// To be used in custom price books, all standard prices must be added as price book entries to the standard price book
	public static PriceBookEntry createPBES(Id prodId, Id pbsId) {
		PriceBookEntry pbes = new PriceBookEntry();
		pbes.Pricebook2Id = pbsId;
		pbes.Product2Id = prodId;
		pbes.UnitPrice = 0;
		pbes.UseStandardPrice = false;
		return pbes;
	}

	public static Product2 createProduct(Id beId, String prodName) {
		Product2 p = new Product2();
		p.name = prodName;
		p.OF_BillingElement__c = beId;
		p.IsActive = true;

		return p;
	}

	public ServFattList__c getSrvData() {
		return srvData;
	}
}
public without sharing class OF_Espletamento_Generico_AP {

	public static final String STATO_ESPLETATO = 'Espletato';
	public static final String STATO_ESPLETATO_KO = 'Espletato KO';
	public static final String FASE_ESPLETATO_OK = 'Espletato OK';
	public static final String FASE_ESPLETATO_KO = 'Espletato KO';
	public static final List<String> beNamesAttivazioneGponOpenstream = new List<String> {'Contributo Attivazione','Canone','Canone premium','Contributo Consegna','Contributo Istallazione','Contributo Consegna e istallazione','Contributo Ribaltamento impianto','Contributo Consegna TV BOX','Contributo prolungamento 0<distanza<20m','Contributo prolungamento >20m'};
	public static final List<String> beNamesCessazioneGponOpenstream = new List<String> {'Contributo Disattivazione','Contributo Ritiro'};

	private static Map<String, Id> rtMap = null;
	private Datetime dataCustomRemedy = null;

	private final Case c;
	private final Case_AssetRecordType__c cs;
	private final String srvName;

	public OF_Espletamento_Generico_AP(Case caseOrdine) {
		if (caseOrdine == null) {
			InvalidParameterValueException e = new InvalidParameterValueException('Case', 'null');
			e.setMessage('OF_Espletamento_Generico_AP: Case cannot be null');
			throw e;
		}

		c = caseOrdine;
		System.debug('Case: ' + c.id);
		System.debug('Case.OF_IDContratto__c:' + c.OF_IDContratto__c);
		System.debug('Case recordtype:' + c.RecordType.DeveloperName);

		for (Case_AssetRecordType__c csCase : Case_AssetRecordType__c.getAll().values()) {
			if (c.RecordType.DeveloperName.equalsIgnoreCase(csCase.caseDevName__c)) {
				cs = csCase;
				srvName = cs.serviceName__c;
				break;
			}
		}

		if (cs == null) {
			NoDataFoundException e = new NoDataFoundException();
			e.setMessage('Missing Custom Setting for Case.RecordType.DeveloperName = ' + c.RecordType.DeveloperName);
			throw e;
		}
	}

	/**
	 * @return Mappa DeveloperName - RecordTypeId
	 */
	public static Map<String, Id> getRtMap() {
		if (rtMap == null) {
			List<RecordType> rtList = [SELECT Id, DeveloperName FROM RecordType];
			rtMap = new Map<String, Id>();
			for (RecordType rt : rtList) {
				rtMap.put(rt.DeveloperName, rt.Id);
			}
		}
		return rtMap;
	}

	public class BeiData {
		public OF_CommercialElementIstanziato__c cei {get; set;}
		public Product2 prod {get; set;}
		public String tipoApparato {get; set;}
		public Decimal quantity {get; set;}

		public BeiData(OF_CommercialElementIstanziato__c c, Product2 p) {
			cei = c;
			prod = p;
			tipoApparato = null;
			quantity = 1;
		}

		public BeiData(OF_CommercialElementIstanziato__c c, Product2 p, String tipo) {
			cei = c;
			prod = p;
			tipoApparato = tipo;
			quantity = 1;
		}
	}

	/**
	 * Crea l'Asset (solo se necessario), crea un'istanza del Commercial Element relativo ai BE in input,
	 * la collega all'Asset quindi crea le istanze dei Billing Element, relazionandole al CEI e all'Asset.
	 *
	 * @param a - L'Asset da collegare ai CEI e BEI. Se <tt>null</tt> viene creato basandosi sulle info presenti nel Case e nell'Ordine a lui collegato.
	 * @param beList - Lista di Billing Element da istanziare. I BE devono essere stati recuperati con Id, Nome, Id del CE e Nome del CE
	 * @param ok - TRUE per andare in Espletato OK, FALSE per andare in Espletato KO
	 *
	 * @return Il CEI appena creato.
	 * @throws NoDataFoundException se l'Ordine non è collegato al Contratto
	 */
	public OF_CommercialElementIstanziato__c espletamentoRemedy(Asset a, List<OF_BillingElement__c> beList, Boolean ok) {
		if (beList.isEmpty()) {
			return null;
		}

		System.debug('Inizio Espletamento - CaseId: ' + c.Id + ' - Esito OK: ' + ok);
		System.debug('case record type:' + c.RecordType.DeveloperName);
		Order o = aggiornaOrdineEspletamento(c,  ok);
		if (!ok) {
			update c;
			return null;
		}
		//Setto la data che mi ha passato l'operatore
		dataCustomRemedy = c.actionDate_Remedy__c;
		if (a == null) {
			a = createAsset(o, c);
			update o;
			System.debug('Aggiornato Ordine: ' + o.Id);
		}

		Map<String, Id> mapRtDevName_RtId = getRtMap();
		Map<String, Id> mapCEName_CeiRtId = new Map<String, String>();
		for (Ce_CeiRecordType__c cs : Ce_CeiRecordType__c.getAll().values()) {
			mapCEName_CeiRtId.put(cs.ceName__c, mapRtDevName_RtId.get(cs.ceiDevName__c));
		}
		System.debug('mapRtDevName_RtId ' + mapRtDevName_RtId);
		System.debug('mapCEName_CeiRtId: ' + mapCEName_CeiRtId);
		List<BeiData> beiDataList = new List<BeiData>();
		List<Product2> prodToInsert = new List<Product2>();

		OF_BillingElement__c be0 = beList.get(0);
		OF_CommercialElementIstanziato__c cei = createCEI(a, be0.OF_CommercialElement__c, mapCEName_CeiRtId.get(be0.OF_CommercialElement__r.Name));
		system.debug('******** cei' + cei);
		//OF_GPONP_FTTH_Utils.ceiMap.put(cei.OF_CommercialElement__r.Name, cei);
		cei.Code_IAV__c=c.Code_IAV__c;
		cei.OF_TT_Number__c=c.OF_TT_Number__c;
		cei.Descrizione_IAV__c=c.Descrizione_IAV__c;
		cei.OLO_Comm_Code__c=c.OLO_Comm_Code__c;
		insert cei;

		for (OF_BillingElement__c be : beList) {
			Product2 p = createProd(be);
			prodToInsert.add(p);
			beiDataList.add(new BeiData(cei, p));
		}

		insert prodToInsert;
		createBEI_Remedy(beiDataList, a);

		return cei;
	}

	public Id espletamentoGPONP_OpenStream(Order o) {
		System.debug('Inizio Espletamento - CaseId: ' + c.Id + ' - Order status: ' + o.Status);
		if ('KO'.equalsIgnoreCase(o.Status)) {
			return null;
		}
		/*Order o = aggiornaOrdineEspletamento(c,  ok);
		   if (!ok) {
		    update c;
		    return null;
		   }*/

		Asset a = createAsset(o, c);

		createPbeGPONP_OpenStream(c, a, o);

		return a.Id;
	}

	public Id espletamentoGPONP_OLD(Order o) {
		System.debug('Inizio Espletamento OLD - CaseId: ' + c.Id + ' - Order status: ' + o.Status);
		if ('KO'.equalsIgnoreCase(o.Status)) {
			return null;
		}

		Asset a = createAsset(o, c);

		createPbeGPONP_OLD(c, a, o);

		return a.Id;
	}

	private List<PricebookEntry> createPbeGPONP_OLD(Case c, Asset a, Order o) {
		OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
													 FROM OF_ContrattoServizio__c
													 WHERE OF_Contract__c = :o.ContractId AND OF_Servizio__r.Name = 'GPON Passiva' LIMIT 1];

		Map<String, OF_BillingElement__c> mapBeName_BE = getMapBeName_BE(beNamesAttivazioneGponOpenstream, contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);

		Map<String, Id> mapRtDevName_RtId = OF_Espletamento_Generico_AP.getRtMap();
		Map<String, Id> mapCEName_CeiRtId = new Map<String, String>();
		for (Ce_CeiRecordType__c cs : Ce_CeiRecordType__c.getAll().values()) {
			mapCEName_CeiRtId.put(cs.ceName__c, mapRtDevName_RtId.get(cs.ceiDevName__c));
		}

		List<OF_CommercialElementIstanziato__c> ceiToInsert = new List<OF_CommercialElementIstanziato__c>();
		List<Product2> prodToInsert = new List<Product2>();
		List<BeiData> beiDataList = new List<BeiData>();

		OF_BillingElement__c beContributoAttivazione = mapBeName_BE.get('Contributo Attivazione'); // sempre
		OF_BillingElement__c beCanone = 'N'.equalsIgnoreCase(a.EOF_SLA_Premium_Assurance__c) ? mapBeName_BE.get('Canone') : mapBeName_BE.get('Canone premium');
		OF_CommercialElementIstanziato__c ceiServizioFibraBase = createCEI(a, beContributoAttivazione.OF_CommercialElement__c, mapCEName_CeiRtId.get(beContributoAttivazione.OF_CommercialElement__r.Name));
		ceiServizioFibraBase.OF_CEStandard__c = a.Id;
		ceiToInsert.add(ceiServizioFibraBase);

		//Contro la mia volontà, stacco un CEI SLA PREMIUM ASSURANCE
		if ('Y'.equalsIgnoreCase(a.EOF_SLA_Premium_Assurance__c)) {
			//Vado a recuperare il CE SLA PREMIUM ASSURANCE
			List<OF_CommercialElement__c> ceSLAPrem = [SELECT Id, Name
													   FROM OF_CommercialElement__c
													   WHERE Name = 'SLA PREMIUM ASSURANCE' AND OF_Attivo__c = true
														   AND OF_Servizio__r.OF_Servizio_Code__c = :contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c
														   LIMIT 1];
			if (!ceSLAPrem.isEmpty()) {
				OF_CommercialElementIstanziato__c ceiSLAPremium = createCEI(a, ceSLAPrem[0].Id, mapCEName_CeiRtId.get(ceSLAPrem[0].Name));
				ceiSLAPremium.OF_Case__c = c.Id;
				ceiSLAPremium.OF_Asset__c = a.Id;
				ceiSLAPremium.OF_ServiziAggiuntivi__c = a.Id;
				ceiToInsert.add(ceiSLAPremium);
			}
		}

		Product2 p = createProd(beContributoAttivazione);
		prodToInsert.add(p);
		beiDataList.add(new BeiData(ceiServizioFibraBase, p));

		p = createProd(beCanone);
		prodToInsert.add(p);
		beiDataList.add(new BeiData(ceiServizioFibraBase, p));

		//Se il campo OF_Apparato__c è valorizzato con Y, allora l'OLO ha richiesto un apparato
		if ('Y'.equalsIgnoreCase(c.EOF_Apparato__c)) {
			/*Se OF_Esito_Consegna_Apparato__c = 1 :
			    - CEI : OF_CPE con rType CPE_Passivi
			    - BEI : Contributo Istallazione
			   Se OF_Esito_Consegna_Apparato__c = 2 :
			    - CEI : OF_CPE con rType CPE_Passivi
			    - BEI : Contributo Istallazione
			    - CEI : Ribaltamento Impianto
			    - BEI : Contributo Ribaltamento
			 */
			if ('1'.equalsIgnoreCase(c.OF_Esito_Consegna_Apparato__c) || '2'.equalsIgnoreCase(c.OF_Esito_Consegna_Apparato__c) ) {
				OF_BillingElement__c beIstall = mapBeName_BE.get('Contributo Istallazione');
				OF_CommercialElementIstanziato__c ceiCPE = createCEI(a, beIstall.OF_CommercialElement__c, mapRtDevName_RtId.get('CPE_Passivi'));
				//Salvo la tipologia apparato
				ceiCPE.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
				//relatedlist asset-cpe
				ceiCPE.OF_CPE__c = a.Id;
				//Campi lookup necessari per legarlo al case di attivazione
				ceiCPE.OF_Case__c = c.Id;
				ceiCPE.OF_SA_CPE__c = c.Id;
				//Azioni per inserire la PBE e i CEI
				ceiToInsert.add(ceiCPE);
				// Gestione Tipologia Apparato
				String tipoApparato = null;
				if (String.isNotBlank(c.EOF_Tipologia_Apparato__c)) {
					Integer tipo = decodificaTipologiaApparato(c.EOF_Tipologia_Apparato__c);
					tipoApparato = getTipoApparato(c.EOF_Tipologia_Apparato__c, tipo);
					if (String.isNotBlank(tipoApparato) && (tipo == 1) && !'CPE'.equalsIgnoreCase(tipoApparato)) {
						OF_BillingElement__c beTvBox = mapBeName_BE.get('Contributo Consegna TV BOX');
						p = createProd(beTvBox);
						prodToInsert.add(p);
						beiDataList.add(new BeiData(ceiCPE, p, tipoApparato));
					}
				}
				p = createProd(beIstall);
				prodToInsert.add(p);
				beiDataList.add(new BeiData(ceiCPE, p, tipoApparato));
				if ('2'.equalsIgnoreCase(c.OF_Esito_Consegna_Apparato__c) ) {
					//Vado a creare il CEI e BEI di Ribaltamento impianto
					OF_BillingElement__c beRibImp = mapBeName_BE.get('Contributo Ribaltamento impianto');
					OF_CommercialElementIstanziato__c ceiServiziAggiuntivi = createCEI(a, beRibImp.OF_CommercialElement__c, mapCEName_CeiRtId.get(beRibImp.OF_CommercialElement__r.Name));
					//Salvo il nome del servizio aggiuntivo
					ceiServiziAggiuntivi.OF_Nome_Servizio__c = 'Ribaltamento impianto';
					//relatedlist asset-serviziaggiuntivi
					ceiServiziAggiuntivi.OF_ServiziAggiuntivi__c = a.Id;
					ceiServiziAggiuntivi.OF_Case__c = c.Id;
					//Azioni per inserire la PBE e i CEI
					ceiToInsert.add(ceiServiziAggiuntivi);
					p = createProd(beRibImp);
					prodToInsert.add(p);
					beiDataList.add(new BeiData(ceiServiziAggiuntivi, p));
				}
			}
		}

		insert ceiToInsert;
		insert prodToInsert;

		return createBEI(beiDataList);
	}

	private Order aggiornaOrdineEspletamento(Case c, Boolean ok) {
		if (ok) {
			c.EOF_Fase__c = FASE_ESPLETATO_OK;
			c.Status = STATO_ESPLETATO;
		} else {
			c.EOF_Fase__c = FASE_ESPLETATO_KO;
			c.Status = STATO_ESPLETATO_KO;
		}
		c.OF_AggiornoOrdine__c = true;
		Order o = chiusuraOrdine(c);
		System.debug('Aggiornato ordine [' + o.Id + '] per il case: ' + c.Id);
		return o;
	}

	private List<PricebookEntry> createPbeGPONP_OpenStream(Case c, Asset a, Order o) {
		String idContr = String.isNotBlank(a.OF_Contract__c) ? a.OF_Contract__c : String.isNotBlank(o.ContractId) ? o.ContractId : c.OF_IDContratto__c;

		System.debug('createPbeGPONP_OpenStream: idContr [' + idContr + '] - srvName [' + srvName + ']');

		OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c, OF_Servizio__r.Name
													 FROM OF_ContrattoServizio__c
													 WHERE OF_Contract__c = :idContr AND OF_Servizio__r.Name = :srvName LIMIT 1];

		Map<String, OF_BillingElement__c> mapBeName_BE = getMapBeName_BE(beNamesAttivazioneGponOpenstream, contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);

		Map<String, Id> mapRtDevName_RtId = getRtMap();
		Map<String, Id> mapCEName_CeiRtId = new Map<String, String>();
		for (Ce_CeiRecordType__c cs : Ce_CeiRecordType__c.getAll().values()) {
			mapCEName_CeiRtId.put(cs.ceName__c, mapRtDevName_RtId.get(cs.ceiDevName__c));
		}

		List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id, Name, OF_CommercialElement__c, OF_CommercialElement__r.Name, OF_TipologiaApparato__c, OF_Password_Apparato__c,
														   OF_AzioneApparato__c, OF_EsitoRitiroApparato__c, OF_EsitoConsegnaApparato__c, OF_ID_Apparato__c,
														   OF_IDAPPARATOCONSEGNATO__c, OF_CodiceMotivazioneConsegna__c, OF_MotivazioneConsegna__c,
														   OF_Nome_Servizio__c, OF_Informazioni_Servizio__c, OF_ESITOSERVIZIO__c, OF_CODICEMOTIVAZIONE_SERVIZIO__c,
														   OF_MOTIVAZIONESERVIZIO__c, OF_ModelloDiServizioVLAN__c, OF_KitConsegnaVLAN__c, OF_UserVLAN__c,
														   OF_ServiceVLAN__c, OF_ProfiloVLAN__c, OF_CustomerVLAN__c, OF_InformazioniVLAN__c, metriTot__c,
														   RecordTypeId, RecordType.DeveloperName
														   FROM OF_CommercialElementIstanziato__c WHERE OF_Case__c = :c.Id ORDER BY OF_CommercialElement__c];


		List<OF_CommercialElementIstanziato__c> ceiToInsert = new List<OF_CommercialElementIstanziato__c>();
		List<Product2> prodToInsert = new List<Product2>();
		List<BeiData> beiDataList = new List<BeiData>();

		OF_BillingElement__c beContributoAttivazione = mapBeName_BE.get('Contributo Attivazione'); // sempre
		OF_BillingElement__c beCanone = (srvName.startsWith('GPON') && 'Y'.equalsIgnoreCase(a.EOF_SLA_Premium_Assurance__c)) ? mapBeName_BE.get('Canone premium') : mapBeName_BE.get('Canone');
		OF_CommercialElementIstanziato__c ceiServizioFibraBase = createCEI(a, beContributoAttivazione.OF_CommercialElement__c, mapCEName_CeiRtId.get(beContributoAttivazione.OF_CommercialElement__r.Name));
		ceiServizioFibraBase.OF_CEStandard__c = a.Id;
		ceiToInsert.add(ceiServizioFibraBase);

		Product2 p = createProd(beContributoAttivazione);
		prodToInsert.add(p);
		beiDataList.add(new BeiData(ceiServizioFibraBase, p));

		p = createProd(beCanone);
		prodToInsert.add(p);
		beiDataList.add(new BeiData(ceiServizioFibraBase, p));

		for (OF_CommercialElementIstanziato__c cei : ceiList) {
			OF_BillingElement__c be = null;
			if ('OF_CPE'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
				if ('1'.equals(cei.OF_EsitoConsegnaApparato__c) || '3'.equals(cei.OF_EsitoConsegnaApparato__c)) {
					be = mapBeName_BE.get('Contributo Consegna');
				} else if ('2'.equals(cei.OF_EsitoConsegnaApparato__c)) {
					be = mapBeName_BE.get('Contributo Consegna e istallazione');
				} else if ('4'.equals(cei.OF_EsitoConsegnaApparato__c)) {
					be = mapBeName_BE.get('Contributo Istallazione');
				}

				if (be != null) {
					Integer tipo = decodificaTipologiaApparato(cei.OF_TipologiaApparato__c);
					String tipoApparato = getTipoApparato(cei.OF_TipologiaApparato__c, tipo);
					if (String.isNotBlank(tipoApparato)) {
						OF_CommercialElementIstanziato__c ceiCPE = createCEIGponOpenStream(cei, a, be, mapCEName_CeiRtId.get(be.OF_CommercialElement__r.Name), prodToInsert, beiDataList, tipoApparato);
						//relatedlist asset-cpe
						ceiCPE.OF_CPE__c = a.Id;
						ceiToInsert.add(ceiCPE);

						if ((tipo == 1) && !'CPE'.equalsIgnoreCase(tipoApparato)) {
							be = mapBeName_BE.get('Contributo Consegna TV BOX');
							ceiCPE = createCEIGponOpenStream(cei, a, be, mapCEName_CeiRtId.get(be.OF_CommercialElement__r.Name), prodToInsert, beiDataList, tipoApparato);
							//relatedlist asset-cpe
							ceiCPE.OF_CPE__c = a.Id;
							ceiToInsert.add(ceiCPE);
						}
					}
				}
			} else if ('OF_ServiziAggiuntivi'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
				if ('0'.equalsIgnoreCase(cei.OF_ESITOSERVIZIO__c)) {
					OF_BillingElement__c beProlungamentoMaggiore20 = null;
					if ('Ribaltamento impianto'.equalsIgnoreCase(cei.OF_Nome_Servizio__c) || '0'.equalsIgnoreCase(cei.OF_Nome_Servizio__c)) {
						be = mapBeName_BE.get('Contributo Ribaltamento impianto');
					} else if ('Estensione Impianto Cliente'.equalsIgnoreCase(cei.OF_Nome_Servizio__c) || '1'.equalsIgnoreCase(cei.OF_Nome_Servizio__c)) {
						be = mapBeName_BE.get('Contributo prolungamento 0<distanza<20m');
						// Staccare un ulteriore BE solo METRI_TOT > 20
						if ((cei.metriTot__c != null) && (cei.metriTot__c > 20)) {
							beProlungamentoMaggiore20 = mapBeName_BE.get('Contributo prolungamento >20m');
						}
					}

					if (be != null) {
						OF_CommercialElementIstanziato__c ceiServiziAggiuntivi = createCEI(a, be.OF_CommercialElement__c, mapCEName_CeiRtId.get(be.OF_CommercialElement__r.Name));
						//relatedlist asset-serviziaggiuntivi
						ceiServiziAggiuntivi.OF_ServiziAggiuntivi__c = a.Id;
						copyCeiFields(cei, ceiServiziAggiuntivi);
						ceiToInsert.add(ceiServiziAggiuntivi);
						p = createProd(be);
						prodToInsert.add(p);
						beiDataList.add(new BeiData(ceiServiziAggiuntivi, p));

						if (beProlungamentoMaggiore20 != null) {
							Product2 prodProlungamento = createProd(beProlungamentoMaggiore20);
							prodToInsert.add(prodProlungamento);
							BeiData wrap = new BeiData(ceiServiziAggiuntivi, prodProlungamento);
							wrap.quantity = cei.metriTot__c - 20;
							beiDataList.add(wrap);
						}
					}
				}
			} else if ('OF_VLAN'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
				OF_CommercialElementIstanziato__c ceiVLAN = createCEI(a, cei.OF_CommercialElement__c, mapCEName_CeiRtId.get(cei.OF_CommercialElement__r.Name));
				//relatedlist asset-vlan
				ceiVLAN.OF_VLAN__c = a.Id;
				copyCeiFields(cei, ceiVLAN);
				ceiToInsert.add(ceiVLAN);
			}
		}
		insert ceiToInsert;
		insert prodToInsert;

		return createBEI(beiDataList);
	}

	private void copyCeiFields(OF_CommercialElementIstanziato__c ceiOrig, OF_CommercialElementIstanziato__c ceiDest) {
		ceiDest.OF_TipologiaApparato__c = ceiOrig.OF_TipologiaApparato__c;
		ceiDest.OF_Password_Apparato__c = ceiOrig.OF_Password_Apparato__c;
		ceiDest.OF_AzioneApparato__c = ceiOrig.OF_AzioneApparato__c;
		ceiDest.OF_EsitoRitiroApparato__c = ceiOrig.OF_EsitoRitiroApparato__c;
		ceiDest.OF_EsitoConsegnaApparato__c = ceiOrig.OF_EsitoConsegnaApparato__c;
		ceiDest.OF_ID_Apparato__c = ceiOrig.OF_ID_Apparato__c;
		ceiDest.OF_IDAPPARATOCONSEGNATO__c = ceiOrig.OF_IDAPPARATOCONSEGNATO__c;
		ceiDest.OF_CodiceMotivazioneConsegna__c = ceiOrig.OF_CodiceMotivazioneConsegna__c;
		ceiDest.OF_MotivazioneConsegna__c = ceiOrig.OF_MotivazioneConsegna__c;
		ceiDest.OF_Nome_Servizio__c = ceiOrig.OF_Nome_Servizio__c;
		ceiDest.OF_Informazioni_Servizio__c = ceiOrig.OF_Informazioni_Servizio__c;
		ceiDest.OF_ESITOSERVIZIO__c = ceiOrig.OF_ESITOSERVIZIO__c;
		ceiDest.OF_CODICEMOTIVAZIONE_SERVIZIO__c = ceiOrig.OF_CODICEMOTIVAZIONE_SERVIZIO__c;
		ceiDest.OF_MOTIVAZIONESERVIZIO__c = ceiOrig.OF_MOTIVAZIONESERVIZIO__c;
		ceiDest.OF_ModelloDiServizioVLAN__c = ceiOrig.OF_ModelloDiServizioVLAN__c;
		ceiDest.OF_KitConsegnaVLAN__c = ceiOrig.OF_KitConsegnaVLAN__c;
		ceiDest.OF_UserVLAN__c = ceiOrig.OF_UserVLAN__c;
		ceiDest.OF_ServiceVLAN__c = ceiOrig.OF_ServiceVLAN__c;
		ceiDest.OF_ProfiloVLAN__c = ceiOrig.OF_ProfiloVLAN__c;
		ceiDest.OF_CustomerVLAN__c = ceiOrig.OF_InformazioniVLAN__c;
		ceiDest.metriTot__c = ceiOrig.metriTot__c;
	}

	private Order chiusuraOrdine(Case caseOrdine) {
		System.debug('Chiusura Ordine for Case: ' + caseOrdine.Id);
		system.debug('caseOrdine.OF_Order__c :' + caseOrdine.OF_Order__c );

		Order o = [SELECT Id, ContractId, Contract.Servizio__r.OF_Servizio_Code__c, Contract.OF_Rinnovabile__c, AccountId, RecordTypeId, Status, OF_Esito__c, OF_Apparato__c,
				   OF_Asset__c, OF_DataEsito__c, OF_EsitoConsegnaApparato__c, OF_ScalaPalazzina__c,
				   OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDOrdineEOF__c, OF_IDOrdineOLO__c,
				   OF_IDRisorsa__c, OF_IDSplitterSecondario__c, OF_IdentificativoDelPOP__c,
				   OF_Provincia__c, OF_Comune__c, OF_ParticellaToponomastica__c, OF_Indirizzo__c, OF_Civico__c,
				   OF_PosizioneSplitterSecondario__c, OF_SlaPremiumAssurance__c, OF_ClusterPromozione__c,
				   OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, OF_IDServizio__c, OF_PasswordApparato__c,
				   OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, OF_ProfiloOpenStream__c,
				   PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_LunghezzaOttica__c, OF_Profilo__c,
				   OF_DescrizioneKO__c, effectiveDate, CreatedDate,
				   PO_PosizioneRilascioCircuitoOSU__c, OF_CodiceKO__c,
				   RecordType.Name, OF_Type__c, OF_TipologiaDiServizio__c, OF_CaseID__c, OF_CaseNome__c
				   FROM Order WHERE Id = :caseOrdine.OF_Order__c LIMIT 1];
		if (String.isBlank(o.ContractId)) {
			NoDataFoundException e = new NoDataFoundException();
			e.setMessage('Order [' + o.Id + '] without contractId');
			throw e;
		}
		o.OF_Esito__c = STATO_ESPLETATO.equalsIgnoreCase(caseOrdine.Status) ? 'OK' : 'KO';
		o.status = 'Chiuso';
		o.OF_DataEsito__c = System.today(); // billing
		o.OF_IDOrdineOLO__c = caseOrdine.EOF_Codice_Ordine_OLO__c; // billing
		o.OF_IDRisorsa__c = caseOrdine.EOF_Id_Risorsa__c;
		o.OF_GPONAttestazione__c = caseOrdine.EOF_GPON_Attestazione__c;
		o.OF_SlaPremiumAssurance__c = caseOrdine.EOF_SLA_Premium_Assurance__c;
		o.OF_Apparato__c = caseOrdine.EOF_Apparato__c;
		o.OF_ProgettoSpeciale__c = caseOrdine.EOF_Progetto_Speciale__c;
		o.OF_TipologiaApparato__c = caseOrdine.EOF_Tipologia_Apparato__c;
		o.OF_PasswordApparato__c = caseOrdine.EOF_Password_Apparato__c;
		o.OF_EsitoConsegnaApparato__c = caseOrdine.OF_Esito_Consegna_Apparato__c;
		o.OF_IDBuilding__c = caseOrdine.EOF_ID_Building_WS__c;
		o.OF_IdentificativoDelPOP__c = caseOrdine.EOF_Identificativo_del_POP__c;
		o.OF_Comune__c = String.isNotBlank(caseOrdine.PO_Comune__c) ? caseOrdine.PO_Comune__c : String.isNotBlank(caseOrdine.EOF_Comune_WS__c) ? caseOrdine.EOF_Comune_WS__c : caseOrdine.EOF_Istat_Comune__c;
		o.OF_Provincia__c = String.isNotBlank(caseOrdine.EOF_Provincia_WS__c) ? caseOrdine.EOF_Provincia_WS__c : caseOrdine.EOF_Istat_Provincia__c;
		o.OF_ParticellaToponomastica__c = caseOrdine.EOF_Particella_Toponomastica_WS__c;
		o.OF_Indirizzo__c = String.isNotBlank(caseOrdine.PO_Indirizzo_collegamento__c) ? caseOrdine.PO_Indirizzo_collegamento__c : caseOrdine.EOF_Indirizzo_WS__c;
		o.OF_Civico__c = String.isNotBlank(caseOrdine.PO_Civico__c) ? caseOrdine.PO_Civico__c : caseOrdine.EOF_Numero_Civico_WS__c;
		o.OF_ScalaPalazzina__c = caseOrdine.EOF_Scala_Palazzina_WS__c;
		if (caseOrdine.OF_SA_Profilo__c != null) {
			Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
			OF_CodificaProfiloListini__c cpl = mapCodifica.get(caseOrdine.OF_SA_Profilo__c);
			if (cpl != null) {
				o.OF_Profilo__c = cpl.OF_ListinoCanoneName__c;
			}
		}
		o.OF_ProfiloOpenStream__c = caseOrdine.OF_SA_Profilo__c;
		o.OF_Promozione__c = caseOrdine.OF_SA_Promozione__c;
		o.OF_CodiceProgettoSpeciale__c = caseOrdine.OF_SA_CODICE_PROGETTO_SPECIALE__c;
		o.OF_ClusterPromozione__c = caseOrdine.OF_SA_Cluster_Promozione__c;
		o.OF_CodiceKO__c = caseOrdine.OF_SA_Codice_Motivazione__c;
		o.OF_DescrizioneKO__c = caseOrdine.OF_SA_Motivazione__c;

		// o.PO_Attenuazione__c = caseOrdine.PO_Attenuazione__c;
		// o.PO_LunghezzaOttica__c = caseOrdine.PO_Lunghezza_Ottica__c;
		// o.PO_PosizioneRilascioCircuitoOSU__c = caseOrdine.PO_Posizione_Rilascio_Circuito_OSU__c;
		// if (caseOrdine.PO_Data_Attivazione_Ordine__c != null) {
		//	o.PO_DataAttivazioneOrdine__c = Datetime.newInstance(caseOrdine.PO_Data_Attivazione_Ordine__c, Time.newInstance(0, 0, 0, 0));
		// }

		update o;

		return o;
	}

	private Asset createAsset(Order o, Case c) {
		System.debug('CreateAsset for order: ' + o.Id);

		Map<String, Id> mapRtDevName_RtId = getRtMap();
		String name = String.isNotBlank(o.OF_IDRisorsa__c) ? o.OF_IDRisorsa__c : o.OF_IDOrdineEOF__c;
		Asset a = new Asset();
		a.recordTypeId = mapRtDevName_RtId.get(cs.assetDevName__c);
		a.name = name;
		a.EOF_ID_Risorsa__c = name;
		a.OF_OrdineID__c = o.Id; // Billing
		a.EOF_ID_Risorsa__c = o.OF_IDRisorsa__c; // Billing
		a.Accordo_Operativo__c = o.PO_Accordo_Operativo__c; // Billing
		a.AccountId = o.AccountID; // Billing
		a.OF_Contract__c = o.ContractId; // Billing
		a.OF_ProfiloOpenStream__c = o.OF_ProfiloOpenStream__c; // Billing
		a.Status = 'Attivo'; // Billing
		//Done AA - Se è remedy, inserire la data presente sul case!!
		a.OF_DataAttivazione2__c = (dataCustomRemedy != null) ? dataCustomRemedy : System.now(); // Billing
		a.OF_Provincia__c = o.OF_Provincia__c; // Billing
		a.OF_Comune__c = o.OF_Comune__c; // Billing
		a.OF_Particella_Toponomastica__c = o.OF_ParticellaToponomastica__c; // Billing
		a.OF_Indirizzo__c = o.OF_Indirizzo__c; // Billing
		a.OF_Civico__c = o.OF_Civico__c; // Billing
		a.OF_ID_Building__c = o.OF_IDBuilding__c; // Billing
		a.OF_Identificativo_del_POP__c = o.OF_IdentificativoDelPOP__c;
		a.OF_GPON_Attestazione__c = o.OF_GPONAttestazione__c;
		a.OF_Scala_Palazzina__c = o.OF_ScalaPalazzina__c;
		a.EOF_ID_Splitter_Secondario__c = o.OF_IDSplitterSecondario__c;
		a.EOF_Posizione_Splitter_Secondario__c = o.OF_PosizioneSplitterSecondario__c;
		a.OF_ProgettoSpeciale__c = o.OF_ProgettoSpeciale__c;
		a.OF_IDCaseAttivazione__c = o.OF_IDCaso__c;
		a.OF_CPE_Quantity__c=c.OF_CPE_Quantity__c;
		a.OF_Promozione__c = o.OF_Promozione__c;
		a.OF_ClusterPromozione__c = o.OF_ClusterPromozione__c;
		a.OF_TipologiaApparato__c = o.OF_TipologiaApparato__c;
		a.OF_CodiceProgettoSpeciale__c = o.OF_CodiceProgettoSpeciale__c;
		a.OF_IDServizio__c = o.OF_IDServizio__c;
		a.EOF_SLA_Premium_Assurance__c = String.isNotBlank(o.OF_SlaPremiumAssurance__c) ? o.OF_SlaPremiumAssurance__c : 'N';
		a.OF_Data_Accordo_Operativo__c = o.CreatedDate;
		a.NS_Rif__c = c.NS_Rif__c;
		// a.PO_Attenuazione__c = o.PO_Attenuazione__c;
		// a.PO_LunghezzaOttica__c = Integer.valueOf(o.PO_LunghezzaOttica__c);
		// a.PO_PosizioneRilascioCircuitoOSU__c = o.PO_PosizioneRilascioCircuitoOSU__c;
		// a.OF_Rinnovabile__c = o.Contract.OF_Rinnovabile__c;

		insert a;
		System.debug('Asset ID: ' + a.Id);
		o.OF_Asset__c = a.Id; // Billing
		c.AssetId = a.Id;

		//update o;
		//System.debug('Aggiornato Ordine: ' + o.Id);

		update c;
		System.debug('Aggiornato Case: ' + c.Id);

		return a;
	}

	private OF_CommercialElementIstanziato__c createCEI(Asset a, Id ceId, String rtId) {
		system.debug('@@@ MG asset id del cei:' + a.id);
		OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
		cei.OF_CommercialElement__c = ceId;
		cei.OF_Asset__c = a.Id;
		cei.RecordTypeId = rtId;
		cei.OF_BillingSyncronized__c = false; // flag per il billing
		cei.UpdateBilling__c = true; // flag per il billing
		cei.OF_Stato__c = 'Attivo';
		cei.OF_IDRisorsa__c = a.EOF_ID_Risorsa__c;
		//Done AA - Controllare se è remedy ed inserire la data presente sul case
		cei.OF_DataAttivazione__c = (dataCustomRemedy != null) ? dataCustomRemedy : System.now();

		return cei;
	}

	private List<PricebookEntry> createBEI(List<BeiData> beiDataList) {
		System.debug('Creating ' + beiDataList.size() + ' BEI');
		Id standardPbId = [SELECT Id FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id;

		List<PricebookEntry> pbeList = new List<PricebookEntry>();
		for (BeiData wrap : beiDataList) {
			PricebookEntry pbe = createPBE(wrap.prod.Id, standardPbId, wrap.cei, wrap.quantity);
			pbe.tipoApparato__c = wrap.tipoApparato;
			pbeList.add(pbe);
		}
		try {
			insert pbeList;
		} catch (DMLException e) {
			System.debug(LoggingLevel.ERROR, 'EspletamentoGenerico: Errore inserimento BEI per Case [' + c.Id + '] - Asset [' + c.AssetId + '] - ' + e.getMessage());
			EOF_EAI_Service_Log__c sLog = new EOF_EAI_Service_Log__c();
			sLog.EOF_Tec_Eof__c = 'UNABLE_TO_LOCK';
			sLog.EOF_Descrizione_Causale_Scarto__c = e.getMessage().abbreviate(255);
			sLog.EOF_Descrizione_Problema__c = 'EspletamentoGenerico: Case [' + c.Id + '] - Asset [' + c.AssetId + '] - BEI non inseriti\n' + e.getStackTraceString().abbreviate(3800);
			insert sLog;
		}

		return pbeList;
	}

	private PricebookEntry createPBE(Id productId, Id standardPbId, OF_CommercialElementIstanziato__c cei, Decimal quantity) {
		PricebookEntry pbe = new PricebookEntry();
		pbe.Pricebook2Id = standardPbId;
		pbe.Quantity__c = quantity;
		pbe.OF_DataAttivazione2__c = System.now();
		pbe.isActive = true;
		pbe.UseStandardPrice = false;
		pbe.UnitPrice = -9999;
		pbe.OF_Asset__c = cei.OF_Asset__c;
		pbe.OF_CommercialElementIstanziato__c = cei.id;
		pbe.Product2Id = productId;
		pbe.OF_Order__c = c.OF_Order__c;
		return pbe;
	}

	private List<PricebookEntry> createBEI_Remedy(List<BeiData> beiDataList, Asset a) {
		System.debug('Creating ' + beiDataList.size() + ' BEI');
		Id standardPbId = [SELECT Id FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id;

		List<PricebookEntry> pbeList = new List<PricebookEntry>();
		for (BeiData wrap : beiDataList) {
			pbeList.add(createPBE_Remedy(wrap.prod.Id, standardPbId, wrap.cei, a));
		}
		try {
			insert pbeList;
		} catch (DMLException e) {
			System.debug(LoggingLevel.ERROR, 'EspletamentoGenerico: Errore inserimento BEI_Remedy per Case [' + c.Id + '] - Asset [' + c.AssetId + '] - ' + e.getMessage());
			EOF_EAI_Service_Log__c sLog = new EOF_EAI_Service_Log__c();
			sLog.EOF_Tec_Eof__c = 'UNABLE_TO_LOCK';
			sLog.EOF_Descrizione_Causale_Scarto__c = e.getMessage().abbreviate(255);
			sLog.EOF_Descrizione_Problema__c = 'EspletamentoGenerico: Case [' + c.Id + '] - Asset [' + c.AssetId + '] - BEI_Remedy non inseriti\n' + e.getStackTraceString().abbreviate(3800);
			insert sLog;
		}

		return pbeList;
	}

	private PricebookEntry createPBE_Remedy(Id productId, Id standardPbId, OF_CommercialElementIstanziato__c cei, Asset a) {
		PricebookEntry pbe = createPBE(productId, standardPbId, cei, 1);
		try {
			if ((a != null) && String.isNotBlank(a.OF_CPE_Quantity__c)) {
				pbe.quantity__c = Decimal.valueOf(a.OF_CPE_Quantity__c);
			}
		} catch (Exception e) {
			System.debug(LoggingLevel.WARN, 'Not a Decimal: a.OF_CPE_Quantity__c = ' + a.OF_CPE_Quantity__c);
		}
		//Done AA - Cambiare data attivazione con quella presente sul case
		pbe.OF_DataAttivazione2__c = (dataCustomRemedy != null) ? dataCustomRemedy : System.now();
		return pbe;
	}

	private Product2 createProd(OF_BillingElement__c be) {
		Product2 p = new Product2();
		p.name = be.Name;
		p.OF_BillingElement__c = be.Id;
		p.IsActive = true;

		return p;
	}

	/**
	 * In seguito allo status update mandatoci da OM
	 * viene chiamato questo metodo per
	 * cessare l'Asset e tutti i CEI e creare gli n BEI "Contributo ritiro"
	 *
	 * @param ok - TRUE in caso di Cessato OK, FALSE altrimenti
	 */
	public void cessazioneCeiGPONP_OpenStream(Boolean ok) {

		Order o = [SELECT Id, Status, OF_Esito__c, ContractId, OF_Data_Cessazione__c, OF_DataEsito__c, OF_CodiceKO__c, OF_DescrizioneKO__c
				   FROM Order WHERE Id = :c.OF_Order__c LIMIT 1];

		cessaOrdine(o, c, ok);
		if (!ok) {
			return;
		}

		Asset a = [SELECT Id, OF_Contract__c, OF_DataCessazione2__c, Status, OF_OrdineId__c, RecordType.DeveloperName
				   FROM Asset WHERE Id = :c.AssetId LIMIT 1];

		String idContr = String.isNotBlank(a.OF_Contract__c) ? a.OF_Contract__c : String.isNotBlank(o.ContractId) ? o.ContractId : c.OF_IDContratto__c;

		System.debug('cessazioneCeiGPONP_OpenStream: idContr [' + idContr + '] - srvName [' + srvName + ']');

		// IMPORTANTE
		// Se va in eccezione a causa della mancanza di ContrattoServizio, non si deve fixare la query,
		// ma bisogna capire perché non è stato trovato un contratto per questo case/olo
		// e bonificare di conseguenza
		OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
													 FROM OF_ContrattoServizio__c
													 WHERE OF_Contract__c = :idContr AND OF_Servizio__r.Name = :srvName LIMIT 1];

		List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id, OF_Stato__c, OF_DataCessazione__c, OF_Asset__c, OF_CommercialElement__c, RecordType.DeveloperName, OF_EsitoRitiroApparato__c FROM OF_CommercialElementIstanziato__c
														   WHERE OF_Asset__c = :c.assetId AND OF_Stato__c != 'Cessato' /*AND RecordType.DeveloperName != 'OF_Standard'*/ AND OF_CommercialElement__r.OF_Servizio__c = :contrattoServizio.OF_Servizio__c];


		cessaCeiCreaBEIContibutoRitiroGPONP_OpenSteam(ceiList, contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
		cessaAsset(a, o);
	}

	public void cessazioneCeiGPONP_Remedy(Boolean ok) {

		Order o = [SELECT Id, Status, OF_Esito__c, ContractId, OF_Data_Cessazione__c, OF_DataEsito__c, OF_CodiceKO__c, OF_DescrizioneKO__c
				   FROM Order WHERE Id = :c.OF_Order__c LIMIT 1];

		cessaOrdine(o, c, ok);
		if (!ok) {
			return;
		}
		dataCustomRemedy = c.actionDate_Remedy__c;
		Asset a = [SELECT Id, OF_Contract__c, OF_DataCessazione2__c, Status, OF_OrdineId__c, RecordType.DeveloperName
				   FROM Asset WHERE Id = :c.AssetId LIMIT 1];

		String idContr = String.isNotBlank(a.OF_Contract__c) ? a.OF_Contract__c : String.isNotBlank(o.ContractId) ? o.ContractId : c.OF_IDContratto__c;

		System.debug('cessazioneCeiGPONP_Remedy: idContr [' + idContr + '] - srvName [' + srvName + ']');
		OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
													 FROM OF_ContrattoServizio__c
													 WHERE OF_Contract__c = :idContr AND OF_Servizio__r.Name = :srvName LIMIT 1];

		System.debug('contrattoServizio: ' + contrattoServizio.id);
		List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id, OF_Stato__c, OF_DataCessazione__c, OF_Asset__c, OF_CommercialElement__c, RecordType.DeveloperName, OF_EsitoRitiroApparato__c FROM OF_CommercialElementIstanziato__c
														   WHERE OF_Asset__c = :c.assetId AND OF_Stato__c != 'Cessato' /*AND RecordType.DeveloperName != 'OF_Standard'*/ AND OF_CommercialElement__r.OF_Servizio__c = :contrattoServizio.OF_Servizio__c];

		cessazioneBeiGPONP_OpenStream();
		cessaCeiCreaBEIContibutoRitiroGPONP_OpenSteam(ceiList, contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
		cessaAsset(a, o);
	}

	/**
	 * In seguito alla richiesta di cessazione ricevuta dall'OLO
	 * vengono cessati tutti i BEI
	 * e creati i BEI "Contributo disattivazione"
	 */
	public void cessazioneBeiGPONP_OpenStream() {
		String idContr = c.OF_IDContratto__c;
		Id idAsset = c.assetId;
		if (String.isBlank(idContr)) {
			Asset a = [SELECT Id, OF_Contract__c FROM Asset WHERE EOF_ID_Risorsa__c = :c.EOF_ID_Risorsa__c LIMIT 1];
			idContr = a.OF_Contract__c;
			idAsset = a.Id;
		}

		OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
													 FROM OF_ContrattoServizio__c
													 WHERE OF_Contract__c = :idContr AND OF_Servizio__r.Name = :srvName LIMIT 1];

		List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id, OF_Stato__c, OF_DataCessazione__c, OF_Asset__c, OF_CommercialElement__c, RecordType.DeveloperName, OF_EsitoRitiroApparato__c
														   FROM OF_CommercialElementIstanziato__c
														   WHERE OF_Asset__c = :idAsset AND OF_Stato__c != 'Cessato'
															   AND OF_CommercialElement__r.OF_Servizio__c = :contrattoServizio.OF_Servizio__c];

		// Recupero i BE da creare tramite il custom setting
		Map<String, OF_BillingElement__c> mapBeName_BE = getMapBeName_BE(beNamesCessazioneGponOpenstream, contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
		List<Product2> prodToInsert = new List<Product2>();
		List<BeiData> beiDataList = new List<BeiData>();
		Set<Id> ceiIds = new Set<Id>(); // Usato per salvare gli Id dei CEI per poi recuperare i BEI
		OF_CommercialElementIstanziato__c ceiServizioBase = null;

		//Vado a controllare tra i CEI se ci sono CPE con esito ritiro = 0, in quel caso creo il "Contributo Ritiro"
		for (OF_CommercialElementIstanziato__c cei : ceiList) {

			ceiIds.add(cei.Id);
			cei.UpdateBilling__c = true; // Billing
			if ('OF_Standard'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
				ceiServizioBase = cei;
			}
		}

		//Vado a creare il BE (da staccare sempre in caso di cessazione) "Contributo Disattivazione"
		if (ceiServizioBase != null) {
			OF_BillingElement__c beContrDisatt = mapBeName_BE.get('Contributo Disattivazione');
			Product2 prodDisatt = createProd(beContrDisatt);
			prodToInsert.add(prodDisatt);
			beiDataList.add(new BeiData(ceiServizioBase, prodDisatt));
		}

		//Recupero tutti i BEI da cessare e li cesso
		List<PricebookEntry> pbeList = [SELECT Id, IsActive, OF_DataCessazione2__c FROM PricebookEntry
										WHERE IsActive = true AND OF_CommercialElementIstanziato__c IN :ceiIds];

		cessaPBE(pbeList);
		update ceiList;
		//Inserisco i prodotti per creare i BEI
		insert prodToInsert;
		//Vado ad inserire il wrapper di BEI che mi sono creato prima
		if (dataCustomRemedy != null) {
			createBEI_Remedy(beiDataList, null);
		}else{
			createBEI(beiDataList);
		}
	}

	public void cessazioneBeiGPONP_OpenStream(List<Case> caseList) {
		Set<String> idRisorsaList = new Set<String>();
		for (Case caseOrd : caseList) {
			idRisorsaList.add(caseOrd.EOF_ID_Risorsa__c);
		}

		List<Asset> assetList = [SELECT Id, EOF_ID_Risorsa__c, OF_Contract__c FROM Asset WHERE EOF_ID_Risorsa__c IN :idRisorsaList];
		Map<String, Asset> mapIdRisorsaAsset = new Map<String, Asset>();
		String idContr = c.OF_IDContratto__c;
		Set<Id> assetIds = new Set<Id>();
		for (Asset a : assetList) {
			mapIdRisorsaAsset.put(a.EOF_ID_Risorsa__c, a);
			idContr = a.OF_Contract__c;
			assetIds.add(a.Id);
		}

		OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
													 FROM OF_ContrattoServizio__c
													 WHERE OF_Contract__c = :idContr AND OF_Servizio__r.Name = :srvName LIMIT 1];

		List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id, OF_Stato__c, OF_DataCessazione__c, OF_Asset__c, OF_CommercialElement__c, RecordType.DeveloperName, OF_EsitoRitiroApparato__c
														   FROM OF_CommercialElementIstanziato__c
														   WHERE OF_Asset__c IN :assetIds AND OF_Stato__c != 'Cessato'
														   AND OF_CommercialElement__r.OF_Servizio__c = :contrattoServizio.OF_Servizio__c];

		// Recupero i BE da creare tramite il custom setting
		Map<String, OF_BillingElement__c> mapBeName_BE = getMapBeName_BE(beNamesCessazioneGponOpenstream, contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
		List<Product2> prodToInsert = new List<Product2>();
		List<BeiData> beiDataList = new List<BeiData>();
		Set<Id> ceiIds = new Set<Id>(); // Usato per salvare gli Id dei CEI per poi recuperare i BEI

		Map<Id, OF_CommercialElementIstanziato__c> mapIdAssetCei = new Map<Id, OF_CommercialElementIstanziato__c>();

		//Vado a controllare tra i CEI se ci sono CPE con esito ritiro = 0, in quel caso creo il "Contributo Ritiro"
		for (OF_CommercialElementIstanziato__c cei : ceiList) {
			ceiIds.add(cei.Id);
			cei.UpdateBilling__c = true; // Billing
			if ('OF_Standard'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
				mapIdAssetCei.put(cei.OF_Asset__c, cei);
			}
		}

		//Vado a creare il BE (da staccare sempre in caso di cessazione) "Contributo Disattivazione"
		for (Id assetId : mapIdAssetCei.keySet()) {
			OF_CommercialElementIstanziato__c cei = mapIdAssetCei.get(assetId);
			OF_BillingElement__c beContrDisatt = mapBeName_BE.get('Contributo Disattivazione');
			Product2 prodDisatt = createProd(beContrDisatt);
			prodToInsert.add(prodDisatt);
			beiDataList.add(new BeiData(cei, prodDisatt));
		}

		//Recupero tutti i BEI da cessare e li cesso
		List<PricebookEntry> pbeList = [SELECT Id, IsActive, OF_DataCessazione2__c FROM PricebookEntry
										WHERE IsActive = true AND OF_CommercialElementIstanziato__c IN :ceiIds];

		cessaPBE(pbeList);
		update ceiList;
		//Inserisco i prodotti per creare i BEI
		insert prodToInsert;
		//Vado ad inserire il wrapper di BEI che mi sono creato prima
		if (dataCustomRemedy != null) {
			createBEI_Remedy(beiDataList, null);
		}else{
			createBEI(beiDataList);
		}
	}

	private void cessaCeiCreaBEIContibutoRitiroGPONP_OpenSteam(List<OF_CommercialElementIstanziato__c> ceiList, String srvCode) {
		Datetime now = System.now();

		Map<String, OF_BillingElement__c> mapBeName_BE = getMapBeName_BE(beNamesCessazioneGponOpenstream, srvCode);
		List<Product2> prodToInsert = new List<Product2>();
		List<BeiData> beiDataList = new List<BeiData>();

		for (OF_CommercialElementIstanziato__c cei : ceiList) {
			cei.OF_Stato__c = 'Cessato';
			//DOne AA - Controllare se è remedy ed inserire data custom
			cei.OF_DataCessazione__c = (dataCustomRemedy != null ) ? dataCustomRemedy : now;
			cei.UpdateBilling__c = true; // flag per il billing
			System.debug('***** cei.EsitoRitiro => ' + cei.OF_EsitoRitiroApparato__c);
			System.debug('***** cei.RecordType.DeveloperName => ' + cei.RecordType.DeveloperName);
			if ('OF_CPE'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
				if ('0'.equals(cei.OF_EsitoRitiroApparato__c)) {
					OF_BillingElement__c be = mapBeName_BE.get('Contributo Ritiro');
					Product2 p = createProd(be);
					prodToInsert.add(p);
					beiDataList.add(new BeiData(cei, p));
				}
			}
		}


		if (!prodToInsert.isEmpty()) {
			insert prodToInsert;
			createBEI(beiDataList);
		}

		update ceiList;
	}

	private void cessaAsset(Asset a, Order o) {
		//Done AA - Controllare se è remedy ed inserire data custom
		a.OF_DataCessazione2__c = (dataCustomRemedy != null ) ? dataCustomRemedy : System.now();
		a.status = 'Cessato';
		a.OF_OrdineId__c = o.Id;
		update a;
	}

	private void cessaOrdine(Order o, Case c, Boolean ok) {
		o.Status = 'Chiuso';
		o.OF_Esito__c = ok ? 'OK' : 'KO';
		o.OF_DataEsito__c = System.today();
		o.OF_Data_Cessazione__c = System.now();
		o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
		o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
		update o;
	}

	private void cessaCei(List<OF_CommercialElementIstanziato__c> ceiList) {
		Datetime now = System.now();

		for (OF_CommercialElementIstanziato__c cei : ceiList) {
			cei.OF_Stato__c = 'Cessato';
			cei.OF_DataCessazione__c = now;
			cei.UpdateBilling__c = true; // flag per il billing
		}
		update ceiList;
	}

	/* AA BACKUP METODO Ruben
	   private void
	   (List<OF_CommercialElementIstanziato__c> ceiList, String srvCode) {
	    Datetime now = System.now();
	    Set<Id> ceiIds = new Set<Id>();

	    Map<String, OF_BillingElement__c> mapBeName_BE = getMapBeName_BECessazione(srvCode);

	    List<Product2> prodToInsert = new List<Product2>();
	    List<BeiData> beiDataList = new List<BeiData>();
	    OF_CommercialElementIstanziato__c ceiServizioBase = null;

	    for (OF_CommercialElementIstanziato__c cei : ceiList) {
	        ceiIds.add(cei.Id);
	        cei.OF_Stato__c = 'Cessato';
	        cei.OF_DataCessazione__c = now;
	        cei.UpdateBilling__c = true; // flag per il billing

	        if ('OF_CPE'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
	            if ('0'.equals(cei.OF_EsitoRitiroApparato__c)) {
	                OF_BillingElement__c be = mapBeName_BE.get('Contributo Ritiro');
	                Product2 p = createProd(be);
	                prodToInsert.add(p);
	                beiDataList.add(new BeiData(cei, p));
	            }
	        } else if ('OF_Standard'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
	            ceiServizioBase = cei;
	        }
	    }

	    OF_BillingElement__c beContrDisatt = mapBeName_BE.get('Contributo Disattivazione');
	    Product2 prodDisatt = createProd(beContrDisatt);
	    prodToInsert.add(prodDisatt);
	    beiDataList.add(new BeiData(ceiServizioBase, prodDisatt));

	    List<PricebookEntry> pbeList = [SELECT Id, IsActive, OF_DataCessazione2__c FROM PricebookEntry
	                                    WHERE IsActive = true AND OF_CommercialElementIstanziato__c IN :ceiIds];

	    cessaPBE(pbeList);
	    insert prodToInsert;
	    createBEI(beiDataList);
	   }*/

	private void cessaPBE(List<PricebookEntry> pbeList) {
		Datetime now = System.now();
		for (PricebookEntry pbe : pbeList) {
			pbe.IsActive = false;
			//Done AA - Cambiare data attivazione con quella presente sul case
			pbe.OF_DataCessazione2__c = (dataCustomRemedy != null ) ? dataCustomRemedy : now;
		}
		update pbeList;
	}

	public static Map<String, OF_BillingElement__c> getMapBeName_BE(List<String> beNames, String srvCode) {
		system.debug('beNames: ' + beNames);
		system.debug('service code:' + srvCode);
		List<OF_BillingElement__c> beList = [SELECT Id, Name, OF_CommercialElement__c, OF_CommercialElement__r.Name
											 FROM OF_BillingElement__c
											 WHERE Name IN :beNames AND OF_Attivo__c = true AND OF_Billing_Element_Code__c != null
												 AND OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c = :srvCode];
		system.debug('getMapBeName_BE:' + beList);
		Map<String, OF_BillingElement__c> mapBeName_BE = new Map<String, OF_BillingElement__c>();
		for (OF_BillingElement__c be : beList) {
			mapBeName_BE.put(be.Name, be);
		}

		return mapBeName_BE;
	}

	public static Integer decodificaTipologiaApparato(String tipologia) {
		String type1RegEx = '[a-zA-Z0-9]{7}-\\d\\.\\d{8}-\\d{9}-[a-zA-Z]{6}\\d{2}[a-zA-Z]\\d{2}[a-zA-Z]\\d{3}[a-zA-Z]-';
		String type2RegEx = '\\S{2,3}_\\d{8}_\\d{4}[a-zA-Z0-9]{6}';

		//Pattern.matches(type1RegEx, '1ONTVFX-1.10096378-123185280-LVRRST52R21G273B-');
		//Pattern.matches(type2RegEx, 'WIN_20171003_0000000006');
		Integer tipo = 3;
		if (Pattern.matches(type1RegEx, tipologia)) {
			tipo = 1;
		} else if (Pattern.matches(type2RegEx, tipologia)) {
			tipo = 2;
		}
		return tipo;
	}

	public static String getTipoApparato(String tipologia, Integer tipo) {
		String tipoApparato = 'CPE';
		if ((tipo != 1) && (tipo != 2)) {
			return tipoApparato;
		}

		if (tipo == 1) {
			String primaParte = tipologia.split('-').get(0);
			tipoApparato = primaParte.endsWithIgnoreCase('X') ? 'TV BOX' : 'CPE';
		} else if (tipo == 2) {
			Set<String> base = new Set<String> {'1', '2', '4', '8', '9'};
			Set<String> plus = new Set<String> {'6', '7'};
			Set<String> premium = new Set<String> {'3', '5'};
			String fine = tipologia.right(7);
			tipoApparato = null;

			for (Integer i = fine.length() - 1; i >= 0; i--) {
				String c = fine.substring(i, i + 1);
				if (base.contains(c)) {
					tipoApparato = 'CPE Base';
					break;
				} else if (plus.contains(c)) {
					tipoApparato = 'CPE Plus';
					break;
				} else if (premium.contains(c)) {
					tipoApparato = 'CPE Premium';
					break;
				}
			}
		}

		return tipoApparato;
	}

	private OF_CommercialElementIstanziato__c createCEIGponOpenStream(OF_CommercialElementIstanziato__c ceiCase, Asset a, OF_BillingElement__c be, Id ceiRtId, List<Product2> prodToInsert, List<BeiData> beiDataList, String tipoApparato) {
		OF_CommercialElementIstanziato__c cei = createCEI(a, be.OF_CommercialElement__c, ceiRtId);
		copyCeiFields(ceiCase, cei);
		Product2 p = createProd(be);
		prodToInsert.add(p);
		beiDataList.add(new BeiData(cei, p, tipoApparato));
		return cei;
	}
}
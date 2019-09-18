public class OF_PNI_GIS_Obsoleti_Check {
	public static Map<String, List<OF_Billing_Element_Verticale__c>> mapScala_Bev {get; set;}
	public static Map<String, Asset> mapAssetStd {get; set;}
	public static Map<Id, PricebookEntry> mapPbe {get; set;}
	public static Map<Id, PricebookEntry> mapPbeS {get; set;}
	public static Map<Id, OF_CommercialElementIstanziato__c> mapIdCeiv {get; set;}
	public static Map<Id, OF_CommercialElement__c> mapCeXidServ {get; set;}
	public static Map<Id, OF_ContrattoServizio__c> mapServizi {get; set;}
	public static Map<String, OF_Billing_Element_Verticale__c> mapIdR_Bev {get; set;}
	private static Map<Id, OF_Asset_Verticale__c> avToUpdate = new Map<Id, OF_Asset_Verticale__c>();
	private static Map<Id, OF_Billing_Element_Verticale__c> bevToUpdate = new Map<Id, OF_Billing_Element_Verticale__c>();
	private static Map<Id, PricebookEntry> pbeToUpdate = new Map<Id, PricebookEntry>();
	private static Map<Id, OF_CommercialElementIstanziato__c> ceiToUpdate = new Map<Id, OF_CommercialElementIstanziato__c>();

	private static List<OF_Billing_Element_Verticale__c> bevToInsert = new List<OF_Billing_Element_Verticale__c>();
	private static List<PricebookEntry> pbeToInsert = new List<PricebookEntry>();
	private static List<OF_CommercialElementIstanziato__c> ceiToInsert = new List<OF_CommercialElementIstanziato__c>();
	private static List<Product2> prodToInsert = new List<Product2>();
	private static List<BillingData> wrapList = new List<BillingData>();

	class BillingData {
		private OF_CommercialElementIstanziato__c c {get; set;}
		private Product2 prod {get; set;}
		private PricebookEntry pb {get; set;}

		public BillingData(OF_CommercialElementIstanziato__c cei, Product2 p, PricebookEntry pbe) {
			c = cei;
			prod = p;
			pb = pbe;
		}
	}

	//Creazione record di Staging con i dati ricevuti da PNI
	public static OF_WS_PNI_ResponseStaging.PNI_Obsoleto_response createStagingPNI (List<OF_WS_PNI_ResponseStaging.PNI_Obsoleto> list_obs) {

		List<OF_Staging_PNI__c> stagingList = new List<OF_Staging_PNI__c>();
		OF_WS_PNI_ResponseStaging.PNI_Obsoleto_response resp = new OF_WS_PNI_ResponseStaging.PNI_Obsoleto_response();

		for (OF_WS_PNI_ResponseStaging.PNI_Obsoleto obs : list_obs) {
			OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
			staging.OF_Source_System__c = 'PNI';
			staging.OF_Civico__c = obs.OF_CIVICO;
			staging.OF_Comune__c = obs.OF_COMUNE;
			staging.OF_ID_Building__c = obs.OF_ID_BUILDING;
			staging.OF_Id_DB_Scala_palazzina__c = obs.OF_ID_DB_SCALA_PALAZZINA;
			staging.OF_ID_GIS_ScalaPalazzina__c = obs.OF_ID_GIS_SCALAPALAZZINA;
			staging.OF_Id_Palazzina__c = obs.OF_ID_PALAZZINA;
			staging.OF_Id_Risorsa__c = obs.OF_ID_RISORSA;
			staging.OF_Indirizzo__c = obs.OF_INDIRIZZO;
			staging.OF_Palazzina__c = obs.OF_PALAZZINA;
			staging.OF_Particella_Toponomastica__c = obs.OF_PARTICELLA_TOPONOMASTICA;
			staging.OF_Scala__c = obs.OF_SCALA;
			staging.OF_Scala_Palazzina__c = obs.OF_SCALA_PALAZZINA;
			staging.OF_UI_Scala_Palazzina__c = obs.OF_UI_SCALA_PALAZZINA;
			stagingList.add(staging);
		}
		insert stagingList;

		resp.ESITO = 'OK';
		return resp;
	}

	//Creazione record di Staging con i dati ricevuti da GIS
	public static OF_WS_GIS_ResponseStaging.GIS_Obsoleto_response createStagingGIS (List<OF_WS_GIS_ResponseStaging.GIS_Obsoleto> list_obs) {

		List<OF_Staging_PNI__c> stagingList = new List<OF_Staging_PNI__c>();
		OF_WS_GIS_ResponseStaging.GIS_Obsoleto_response resp = new OF_WS_GIS_ResponseStaging.GIS_Obsoleto_response();

		for (OF_WS_GIS_ResponseStaging.GIS_Obsoleto obs : list_obs) {
			OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
			staging.OF_Source_System__c = 'GIS';
			staging.OF_GIS_OLO__c = obs.OLO;
			staging.OF_GIS_Codice_Ordine_Olo__c = obs.CODICE_ORDINE_OLO;
			staging.OF_Comune__c = obs.COMUNE;
			staging.OF_GIS_Data_Espletamento__c = String.valueOf(obs.DATA_ESPLETAMENTO);
			staging.OF_ID_Building__c = obs.ID_BUILDING;
			staging.OF_Id_DB_Scala_palazzina__c = obs.ID_BUILDING_SCALA_PALAZZINA;
			staging.OF_Id_Risorsa__c = obs.ID_RISORSA;
			staging.OF_Scala__c = obs.ID_SCALA;
			staging.OF_ID_GIS_ScalaPalazzina__c = obs.IDR_SCALA;
			staging.OF_Indirizzo__c = obs.INDIRIZZO;
			staging.OF_GIS_Nome_Scala__c = obs.NOME_SCALA;
			staging.OF_Civico__c = obs.NUMERO_CIVICO;
			staging.OF_UI_Scala_Palazzina__c = obs.NUMERO_UI_TOT;
			staging.OF_Particella_Toponomastica__c = obs.PARTICELLA_TOPONOMASTICA;
			staging.OF_Gis_Pop_Tmw__c = obs.POP_TMW;
			stagingList.add(staging);
		}
		insert stagingList;

		resp.ESITO = 'OK';
		return resp;
	}

	public static Order createOrder(Asset a, Account acc, String idOrdineOlo) {
		Order o = new Order();
		o.OF_Asset__c = a.Id;
		o.AccountId = acc.id;
		o.OF_IDOrdineOLO__c = idOrdineOlo;
		o.EffectiveDate = Date.today();
		o.Status = 'Chiuso';
		o.OF_Esito__c = 'OK';
		o.ContractId = a.OF_Contract__c;

		return o;
	}

	/*Algoritmo VERTICALI*/
	public void updateElemVerticali(List<OF_Staging_PNI__c> listaStaging) {

		Set<String> idRisorsaList = new Set<String>();
		Set<String> idGisScalaPalazzinaList = new Set<String>();
		for (OF_Staging_PNI__c record : listaStaging) {
			idRisorsaList.add(record.OF_Id_Risorsa__c);
			idGisScalaPalazzinaList.add(record.OF_ID_GIS_ScalaPalazzina__c);
		}

		Map<String, OF_Asset_Verticale__c> mapScala_AssetV = new Map<String, OF_Asset_Verticale__c>();
		mapScala_Bev = new Map<String, List<OF_Billing_Element_Verticale__c>>();
		mapAssetStd = new Map<String, Asset>();
		mapPbe = new Map<Id, PricebookEntry>();
		mapPbeS = new Map<Id, PricebookEntry>();
		mapIdCeiv = new Map<Id, OF_CommercialElementIstanziato__c>();
		mapCeXidServ = new Map<Id, OF_CommercialElement__c>();
		mapServizi = new Map<Id, OF_ContrattoServizio__c>();
		mapIdR_Bev = new Map<String, OF_Billing_Element_Verticale__c>();
		Map<String, Account> mapAcc = new Map<String,Account>();
		String RamoDiEsecuzione = '';

		String AssetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
		String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();

		//GB rivedere, poichè bisogna relazionare al contratto dell'OLO
		OF_BillingElement__c be_Contributo = [SELECT id, name, OF_CommercialElement__c, OF_Attivo__c
											  FROM OF_BillingElement__c
											  WHERE name = 'Contributo Verticale'
												  LIMIT 1];

		OF_BillingElement__c be_Storno = [SELECT id, name, OF_CommercialElement__c, OF_Attivo__c
										  FROM OF_BillingElement__c
										  WHERE name = 'Contributo di storno Verticale'
											  LIMIT 1];

		Pricebook2 standardPb = [SELECT id
								 FROM Pricebook2
								 WHERE isStandard = true
									 LIMIT 1];

		RecordType rtAssetV = [SELECT id, name, SobjectType
							   FROM RecordType
							   WHERE name = 'Asset Verticale' LIMIT 1];

		Account openFiber = [SELECT id
							 FROM Account
							 WHERE name = 'OpenFiber' LIMIT 1];

		List<OF_CommercialElement__c> listaCEVert_totali = [SELECT id, name, OF_Servizio__c
															FROM OF_CommercialElement__c
															WHERE OF_Servizio__r.name LIKE '%VERTICALE%' limit 2];

		for (OF_CommercialElement__c ce : listaCEVert_totali) {
			mapCeXidServ.put(ce.OF_Servizio__c, ce);
		}

		RecordType rtCei = [SELECT id, name, SobjectType
							FROM RecordType
							WHERE name = 'Verticale'
								AND SobjectType = 'OF_CommercialElementIstanziato__c' LIMIT 1];

		/* fix giuseppe
		   List<OF_Asset_Verticale__c> assetV_totali = [Select id, Account__c,Cardinalita_Scala__c, UI_Scala_Palazzina__c,
		                                             ID_DB_Scala_Palazzina__c, ID_GIS_Scala_Palazzina__c
		                                             from OF_Asset_Verticale__c];
		   List<OF_Billing_Element_Verticale__c> beV_totali = [SELECT id, ID_Risorsa__c, OF_Status__c, OLO__c, Asset_Verticale__c, Asset__c, asset__r.Account.name, Update_Billing__c,
		                                                    Data_Attivazione__c, Asset_Verticale__r.ID_GIS_Scala_Palazzina__c, Olo__r.name,Asset__r.EOF_Id_Risorsa__c
		                                                    FROM OF_Billing_Element_Verticale__c
		                                                    WHERE OF_Status__c = 'ATTIVO'];
		 */

		List<OF_Billing_Element_Verticale__c> beV_totali = [SELECT id, ID_Risorsa__c, OF_Status__c, OLO__c, Asset_Verticale__c, Asset__c, Update_Billing__c,
															Data_Attivazione__c, Asset_Verticale__r.ID_GIS_Scala_Palazzina__c, Olo__r.name/*,Asset__r.EOF_Id_Risorsa__c*/
															FROM OF_Billing_Element_Verticale__c
															WHERE OF_Status__c = 'ATTIVO' AND (ID_Risorsa__c IN :idRisorsaList OR Asset_Verticale__r.ID_GIS_Scala_Palazzina__c IN :idGisScalaPalazzinaList) ORDER BY Asset_Verticale__c];

		Set<Id> avIdList = new Set<Id>();
		for (OF_Billing_Element_Verticale__c bev : beV_totali) {
			mapIdR_Bev.put(bev.ID_Risorsa__c, bev);
			avIdList.add(bev.Asset_Verticale__c);
			idRisorsaList.add(bev.ID_Risorsa__c);
			List<OF_Billing_Element_Verticale__c> bevInScala = mapScala_Bev.get(bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c);
			if (bevInScala == null) {
				bevInScala = new List<OF_Billing_Element_Verticale__c>();
				mapScala_Bev.put(bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c, bevInScala);
			}
			bevInScala.add(bev);
		}

		List<OF_Asset_Verticale__c> assetV_totali = [SELECT id, Account__c, Cardinalita_Scala__c, UI_Scala_Palazzina__c, Update_Billing__c,
													 ID_DB_Scala_Palazzina__c, ID_GIS_Scala_Palazzina__c
													 FROM OF_Asset_Verticale__c WHERE Id IN :avIdList OR ID_GIS_Scala_Palazzina__c IN :idGisScalaPalazzinaList];
		// FROM OF_Asset_Verticale__c];

		for (OF_Asset_Verticale__c av : assetV_totali) {
			mapScala_AssetV.put(av.ID_GIS_Scala_Palazzina__c, av);
			if (!mapScala_Bev.containsKey(av.ID_GIS_Scala_Palazzina__c)) {
				mapScala_Bev.put(av.ID_GIS_Scala_Palazzina__c, new List<OF_Billing_Element_Verticale__c>());
			}
			//mapScala_Bev.put(av.ID_GIS_Scala_Palazzina__c, ritornaListaBEV(av.ID_GIS_Scala_Palazzina__c,beV_totali));
		}

		List<Asset> listaAssetStd = [SELECT id, name, Account.name, OF_DataAttivazione2__c, EOF_ID_Risorsa__c, OF_Contract__c, OF_OrdineID__c, recordType.name, AccountId
									 FROM Asset
									 WHERE recordType.name IN('Open Stream', 'GPON Passiva') AND EOF_ID_Risorsa__c IN :idRisorsaList ];

		Set<String> idAssetList = new Set<String>(); //fix giuseppe
		for (Asset record : listaAssetStd) {
			mapAssetStd.put(record.EOF_ID_Risorsa__c, record);
			idAssetList.add(record.id); //fix giuseppe
		}

		//fix giuseppe
		List<OF_ContrattoServizio__c> listaContrattiServizio = [SELECT OF_Servizio__c, OF_Contract__c
																FROM OF_ContrattoServizio__c
																WHERE OF_Servizio__r.Name LIKE '%VERTICALE%'];

		for (OF_ContrattoServizio__c cs : listaContrattiServizio) {
			mapServizi.put(cs.OF_Contract__c, cs);
		}

		//fix giuseppe
		List<OF_CommercialElementIstanziato__c> ceiv_totali = [SELECT Id, name, Asset_Verticale__c, OF_Asset__c, OF_Stato__c, OF_DataCessazione__c, OF_DataAttivazione__c, OF_IDRisorsa__c, RecordTypeId, OF_BillingSyncronized__c
															   FROM OF_CommercialElementIstanziato__c
															   WHERE OF_CommercialElement__r.name = 'Servizio Verticale'
																   AND OF_Stato__c = 'Attivo' AND OF_Asset__c IN :idAssetList];

		for (OF_CommercialElementIstanziato__c cei : ceiv_totali) {
			mapIdCeiv.put(cei.OF_Asset__c, cei);
		}

		/*fix giuseppe
		   List<PricebookEntry> pbe_list = [Select id, name, Product2Id, OF_CommercialElementIstanziato__c, OF_Asset__c, IsActive,
		                                 OF_DataCessazione2__c
		                                 from PricebookEntry
		                                 where Product2.Name = 'Contributo Verticale' AND IsActive = true];

		   List<PricebookEntry> pbes_list = [Select id, name, Product2Id, OF_CommercialElementIstanziato__c, OF_Asset__c, IsActive,
		                                  OF_DataCessazione2__c
		                                  from PricebookEntry
		                                  where Product2.Name = 'Contributo Storno Verticale' AND IsActive = true];
		 */

		//fix giuseppe
		List<PricebookEntry> pbe_list = [SELECT id, name, Product2Id, OF_CommercialElementIstanziato__c, OF_Asset__c, IsActive,
										 OF_DataCessazione2__c
										 FROM PricebookEntry
										 WHERE Product2.Name = 'Contributo Verticale' AND IsActive = true AND OF_Asset__c IN :idAssetList];

		for (PricebookEntry p : pbe_list) {
			mapPbe.put(p.OF_Asset__c, p);
		}

		//fix giuseppe
		List<PricebookEntry> pbes_list = [SELECT id, name, Product2Id, OF_CommercialElementIstanziato__c, OF_Asset__c, IsActive,
										  OF_DataCessazione2__c
										  FROM PricebookEntry
										  WHERE Product2.Name = 'Contributo Storno Verticale' AND IsActive = true AND OF_Asset__c IN :idAssetList];

		for (PricebookEntry p : pbes_list) {
			mapPbeS.put(p.OF_Asset__c, p);
		}

		List<Account> acc_list = [SELECT id,Name,EOF_Codice_Operatore__c,Type
								  FROM Account
								  WHERE Type = 'OLO'];

		for (Account a : acc_list) {
			mapAcc.put(a.EOF_Codice_Operatore__c, a);
		}

		List<Contract> list_contr = [SELECT Id, AccountId, OF_IdContratto__c FROM Contract WHERE OF_IdContratto__c like '%GPASS%'];
		Map<Id, Id> mapAccount_Contract = new Map<Id, Id>();
		for (Contract cont: list_contr) {
			mapAccount_Contract.put(cont.AccountId, cont.Id);
		}

		List<OF_Asset_Verticale__c> avToInsert = new List<OF_Asset_Verticale__c>();
		List<Asset> assetToInsert = new List<Asset>();
		Set<String> newAvScalaPalazzinaList = new Set<String>();
		Map<String, OF_Staging_PNI__c> mapIdRisorsa_Staging = new Map<String, OF_Staging_PNI__c>();
		for (OF_Staging_PNI__c rec : listaStaging) {
			try {
				RamoDiEsecuzione = 'ENTRO FOR ID STAG:' + rec.id + ' - ';
				rec.isElaborato__c = true;

				if ('N/A'.equalsIgnoreCase(rec.OF_Id_Risorsa__c) || '#N/A'.equalsIgnoreCase(rec.OF_Id_Risorsa__c) || 'N/D'.equalsIgnoreCase(rec.OF_Id_Risorsa__c) || '#N/D'.equalsIgnoreCase(rec.OF_Id_Risorsa__c) || (rec.OF_Id_Risorsa__c == null)) {
					system.debug('PUNTO 0. ID RISORSA ERRATA:' + rec.OF_Id_Risorsa__c);
					RamoDiEsecuzione = 'PUNTO 0. ID RISORSA ERRATA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;
					continue;
				}

				if ('N/A'.equalsIgnoreCase(rec.OF_ID_GIS_ScalaPalazzina__c) || '#N/A'.equalsIgnoreCase(rec.OF_ID_GIS_ScalaPalazzina__c)) {
					system.debug('PUNTO 1. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					RamoDiEsecuzione = 'PUNTO 1. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;
					continue;
				}

				mapIdRisorsa_Staging.put(rec.OF_Id_Risorsa__c, rec);
				Asset assetValid = mapAssetStd.get(rec.OF_Id_Risorsa__c);
				if (assetValid == null) {
					system.debug('PUNTO I ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					RamoDiEsecuzione = 'PUNTO I ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;
					if ('GIS'.equals(rec.OF_Source_System__c)) { //Prima di eseguire sincerarsi che sia configurato l'operatore OLO ed il suo contratto.

						Account accOLO = mapAcc.get(rec.OF_GIS_OLO__c);

						Asset objAsset = new Asset();
						objAsset.Name = rec.OF_Id_Risorsa__c;
						objAsset.EOF_ID_Risorsa__c = rec.OF_Id_Risorsa__c;
						objAsset.Status = 'Attivo';
						objAsset.OF_Comune__c = rec.OF_Comune__c;
						objAsset.OF_Particella_Toponomastica__c = rec.OF_Particella_Toponomastica__c;
						objAsset.OF_Indirizzo__c = rec.OF_Indirizzo__c;
						objAsset.OF_Civico__c = rec.OF_Civico__c;

						system.debug('# accOLO: ' + accOLO);
						objAsset.AccountId = accOLO.id;
						objAsset.OF_Contract__c = mapAccount_Contract.get(accOLO.id);
						system.debug('# OF_Contract__c: ' + objAsset.OF_Contract__c);
						objAsset.OF_DataAttivazione2__c = Datetime.valueOf(rec.OF_GIS_Data_Espletamento__c);
						objAsset.RecordTypeId = AssetRecordTypeId;

						assetToInsert.add(objAsset);

						mapAssetStd.put(objAsset.EOF_ID_Risorsa__c, objAsset);
					}
				}

				OF_Asset_Verticale__c av = mapScala_AssetV.get(rec.OF_ID_GIS_ScalaPalazzina__c);
				if (av == null) {
					system.debug('PUNTO 3. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					RamoDiEsecuzione = 'PUNTO 3. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;
					av = createAssetVerticaleByStaging(rec,openFiber,rtAssetV);
					if (av != null) {
						mapScala_AssetV.put(av.ID_GIS_Scala_Palazzina__c, av);
						avToInsert.add(av);
						newAvScalaPalazzinaList.add(rec.OF_ID_GIS_ScalaPalazzina__c);
					}
				}
			} catch (Exception e) {
				rec.isElaborato__c = true;
				rec.STG_Info_Esecuzione__c = RamoDiEsecuzione + '\n' + e.getMessage() + ' - Line number: ' + e.getLineNumber();
			}
		}

		if (!assetToInsert.isEmpty()) {
			insert assetToInsert;

			List<Order> orderToInsert = new List<Order>();
			for (Asset objAsset : assetToInsert) {
				OF_Staging_PNI__c rec = mapIdRisorsa_Staging.get(objAsset.EOF_ID_Risorsa__c);
				Account accOLO = mapAcc.get(rec.OF_GIS_OLO__c);
				Order ordine = createOrder(objAsset, accOLO, rec.OF_GIS_Codice_Ordine_Olo__c);
				orderToInsert.add(ordine);
			}

			insert orderToInsert;
		}

		insert avToInsert;

		//Itero la lista di Staging
		List<OF_Staging_PNI__c> stagList = mapIdRisorsa_Staging.values();
		for (OF_Staging_PNI__c rec : stagList) {
			try {
				Asset stgAsset = mapAssetStd.get(rec.OF_Id_Risorsa__c);
				if ('N/D'.equalsIgnoreCase(rec.OF_ID_GIS_ScalaPalazzina__c) || '#N/D'.equalsIgnoreCase(rec.OF_ID_GIS_ScalaPalazzina__c)) {
					system.debug('PUNTO 2. ID_GIS_ScalaPalazzina__c:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					RamoDiEsecuzione = 'PUNTO 2. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;
					inactiveContributoVerticale(stgAsset.Id);
					createContributoStornoVerticale(rec.OF_Id_Risorsa__c, be_Storno, standardPb);
					OF_CommercialElementIstanziato__c oldCEI = mapIdCeiv.get(stgAsset.id);
					inactiveCEI(oldCEI);
					inactiveBEV(mapIdR_Bev.get(rec.OF_Id_Risorsa__c));
					rec.isElaborato__c = true;
					mapIdRisorsa_Staging.remove(rec.OF_Id_Risorsa__c); // Per non far lavorare questo record in caso di cambiamenti all'ui scala palazzina alla fine dell'algoritmo
					continue;
				}

				OF_Billing_Element_Verticale__c bev = searchBEV(rec.OF_ID_GIS_ScalaPalazzina__c,rec.OF_Id_Risorsa__c);
				OF_Asset_Verticale__c av = mapScala_AssetV.get(rec.OF_ID_GIS_ScalaPalazzina__c);
				system.debug('searchAV:' + av);
				system.debug('searchBEV:' + bev);
				Boolean isNewAv = newAvScalaPalazzinaList.contains(av.ID_GIS_Scala_Palazzina__c);
				if (bev == null) {
					OF_Billing_Element_Verticale__c bevInAv = searchBEVinAVbyOLO(rec.OF_ID_GIS_ScalaPalazzina__c, stgAsset.AccountId);
					system.debug('+ bevInAv:' + bevInAv);
					if (bevInAv == null) {
						OF_Billing_Element_Verticale__c bevOLO = mapIdR_Bev.get(rec.OF_Id_Risorsa__c);
						if (bevOLO == null) {
							system.debug('PUNTO 4. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
							RamoDiEsecuzione = 'PUNTO 4. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;
							av = updateAssetVerticaleForBilling(av,rec,openFiber,rtAssetV);
							bevInAv = createBEV(rec,av);
							inactiveContributoStornoVerticale(bevInAv.Asset__c);
							OF_CommercialElementIstanziato__c newCEI = createCEI(bevInAv, rtCei, av.Id);
							createContributoVerticale(bevInAv.ID_Risorsa__c, newCEI, be_Contributo, standardPb);
							rec.isElaborato__c = true;
							mapIdRisorsa_Staging.remove(rec.OF_Id_Risorsa__c); // Per non far lavorare questo record in caso di cambiamenti all'ui scala palazzina alla fine dell'algoritmo
						} else {
							system.debug('PUNTO 5. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
							RamoDiEsecuzione = 'PUNTO 5. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;

							createContributoStornoVerticale(bevOLO.ID_Risorsa__c, be_Storno, standardPb);
							OF_CommercialElementIstanziato__c newCEI = createCEI(bevOLO, rtCei, av.Id);
							bevOLO = cambiaAV(bevOLO, av, mapScala_AssetV.get(bevOLO.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c));
							createContributoVerticale(bevOLO.ID_Risorsa__c, newCEI, be_Contributo, standardPb);
							mapIdRisorsa_Staging.remove(rec.OF_Id_Risorsa__c); // Per non far lavorare questo record in caso di cambiamenti all'ui scala palazzina alla fine dell'algoritmo
						}
					} else {
						if (!isNewAv) {
							av = updateAssetVerticaleForBilling(av,rec,openFiber,rtAssetV);
							avToUpdate.put(av.Id, av);
						}
						system.debug('@ bevInAv: ' + bevInAv);

						//if(bevInAv.Data_Attivazione__c > stgAsset.OF_DataAttivazione2__c){
						system.debug('PUNTO 6. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
						RamoDiEsecuzione = 'PUNTO 6. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;

						// inactiveContributoVerticale(stgAsset.Id);
						// // OF_CommercialElementIstanziato__c newCEI = createCEI(bevInAv, rtCei, av.Id);
						// createContributoStornoVerticale(bevInAv.ID_Risorsa__c, be_Storno, standardPb);

						// OF_CommercialElementIstanziato__c oldCEI = mapIdCeiv.get(stgAsset.id);
						// inactiveCEI(oldCEI);
						// removeBEV(bevInAv,av);

						OF_Billing_Element_Verticale__c bevOLO2 = mapIdR_Bev.get(rec.OF_Id_Risorsa__c);
						// OF_CommercialElementIstanziato__c newCEI2;
						if (bevOLO2 != null) {
							// createContributoStornoVerticale(bevOLO2.ID_Risorsa__c, be_Storno, standardPb);
							// newCEI2 = createCEI(bevOLO2, rtCei, av.Id);
							// bevOLO2 = cambiaAV(bevOLO2, av, mapScala_AssetV.get(bevOLO2.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c));
							bevOLO2 = cambiaAV(bevOLO2, av, mapScala_AssetV.get(bevOLO2.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c));
						}else{
							bevOLO2 = createBEV(rec,av);
							// newCEI2 = createCEI(bevOLO2, rtCei, av.Id);
						}
						// createContributoVerticale(bevOLO2.ID_Risorsa__c, newCEI2, be_Contributo, standardPb);
						rec.isElaborato__c = true;
						mapIdRisorsa_Staging.remove(rec.OF_Id_Risorsa__c); // Per non far lavorare questo record in caso di cambiamenti all'ui scala palazzina alla fine dell'algoritmo
						//}
					}
				} else {
					/*if (isNewAv) { // Impossibile entrare: se bev != null vuol dire che ha trovato il bev sotto questa scala, quindi non può essere nuova
					    system.debug('PUNTO 7. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					    RamoDiEsecuzione = 'PUNTO 7. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;

					    createContributoStornoVerticale(bev.ID_Risorsa__c, be_Storno, standardPb);
					    OF_CommercialElementIstanziato__c newCEI = createCEI(bev, rtCei, av.Id);
					    bev = cambiaAV(bev, av, mapScala_AssetV.get(bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c));
					    createContributoVerticale(bev.ID_Risorsa__c, newCEI, be_Contributo, standardPb);

					   }*/
					// if (bev.Asset_Verticale__c.equals(av.Id)) { // If inutile, questa condizione è verificata nel metodo searchBEV
					system.debug('PUNTO 8. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					RamoDiEsecuzione = 'PUNTO 8. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;

					av = updateAssetVerticaleForBilling(av,rec,openFiber,rtAssetV);
					avToUpdate.put(av.Id, av);

					/*} else { // Impossibile entrare
					    OF_Billing_Element_Verticale__c bevOLO = searchBEVinAVbyOLO(rec.OF_ID_GIS_ScalaPalazzina__c, stgAsset.AccountId);
					    if (bevOLO == null) {
					        system.debug('PUNTO 9. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					        RamoDiEsecuzione = 'PUNTO 9. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;

					        createContributoStornoVerticale(bev.ID_Risorsa__c, be_Storno, standardPb);
					        OF_CommercialElementIstanziato__c newCEI = createCEI(bev, rtCei, av.Id);
					        bev = cambiaAV(bev, av, mapScala_AssetV.get(bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c));
					        av = updateAssetVerticaleForBilling(av,rec,openFiber,rtAssetV);
					        // update av;
					        avToUpdate.put(av.Id, av);
					        createContributoVerticale(bev.ID_Risorsa__c, newCEI, be_Contributo, standardPb);

					    }
					    if ((bevOLO != null) && (bevOLO.Data_Attivazione__c > stgAsset.OF_DataAttivazione2__c)) {
					        system.debug('PUNTO 10. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
					        RamoDiEsecuzione = 'PUNTO 10. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c;

					        av = updateAssetVerticaleForBilling(av,rec,openFiber,rtAssetV);
					        avToUpdate.put(av.Id, av);
					        createContributoStornoVerticale(bevOLO.ID_Risorsa__c, be_Storno, standardPb);
					        OF_CommercialElementIstanziato__c newCEI = createCEI(bevOLO, rtCei, av.Id);
					        removeBEV(bevOLO,av);

					        createContributoStornoVerticale(rec.OF_Id_Risorsa__c, be_Storno, standardPb);
					        OF_CommercialElementIstanziato__c newCEI2 = createCEI(bev, rtCei, av.Id);
					        bev = cambiaAV(bev, av, mapScala_AssetV.get(bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c));
					    }
					   }*/
				}
			}
			catch (Exception e) {
				rec.isElaborato__c = true;
				rec.STG_Info_Esecuzione__c = RamoDiEsecuzione + '\n' + e.getMessage() + ' - Line number: ' + e.getLineNumber();
			}
			rec.isElaborato__c = true;
		}
		update listaStaging;

		Set<String> modificati = new Set<String>();
		for (OF_Staging_PNI__c rec : mapIdRisorsa_Staging.values()) {
			//if (String.isNotBlank(rec.OF_UI_Scala_Palazzina__c)) {
			OF_Billing_Element_Verticale__c bev = searchBEV(rec.OF_ID_GIS_ScalaPalazzina__c, rec.OF_Id_Risorsa__c);
			OF_Asset_Verticale__c av = mapScala_AssetV.get(rec.OF_ID_GIS_ScalaPalazzina__c);

			Decimal uiScalaP = -1;
			try {
				uiScalaP = Decimal.valueOf(rec.OF_UI_Scala_Palazzina__c);
			} catch (Exception e) {
				System.debug('UI_Scala_Palazzina errato per idRisorsa: ' + rec.OF_Id_Risorsa__c);
				continue;
			}
			System.debug('PUNTO 12. PRE - uiScalaP:' + uiScalaP + ' av.UI_Scala_Palazzina__c:' + av.UI_Scala_Palazzina__c);
			if ((bev != null) /*&& (av != null)*/ && (uiScalaP > 0) && (modificati.contains(rec.OF_ID_GIS_ScalaPalazzina__c) || (av.UI_Scala_Palazzina__c != uiScalaP))) {
				System.debug('PUNTO 12. ID RISORSA:' + rec.OF_Id_Risorsa__c + ' E SCALA:' + rec.OF_ID_GIS_ScalaPalazzina__c);
				//if(!modificati.contains(rec.OF_ID_GIS_ScalaPalazzina__c)){
				av = updateAssetVerticaleForBilling(av,rec,openFiber,rtAssetV);
				av.UI_Scala_Palazzina__c = uiScalaP;
				avToUpdate.put(av.Id, av);
				//}

				createContributoStornoVerticale(bev.ID_Risorsa__c, be_Storno, standardPb);

				OF_CommercialElementIstanziato__c newCEI = createCEI(bev, rtCei, av.Id);
				createContributoVerticale(bev.ID_Risorsa__c, newCEI, be_Contributo, standardPb);
				modificati.add(rec.OF_ID_GIS_ScalaPalazzina__c);

				bev.Update_Billing__c = true;
				bevToUpdate.put(bev.Id, bev);
			}
			//}
		}

		updateDB();
	}

	private void inactiveBEV(OF_Billing_Element_Verticale__c bev) {
		if (bev == null) {
			return;
		}
		bev.OF_Status__c = 'INATTIVO';
		bev.Update_Billing__c = true;
		bev.Asset_Verticale__c = null;
		bevToUpdate.put(bev.Id, bev);
	}

	private void updateDB() {

		insert ceiToInsert;
		insert prodToInsert;
		for (BillingData bd : wrapList) {
			bd.pb.OF_CommercialElementIstanziato__c = bd.c.Id;
			bd.pb.Product2Id = bd.prod.Id;
		}
		insert bevToInsert;
		insert pbeToInsert;

		if (!bevToUpdate.isEmpty() || !avToUpdate.isEmpty()) {
			update bevToUpdate.values();
			update avToUpdate.values();
			update pbeToUpdate.values();
		}
		if (!ceiToUpdate.isEmpty()) {
			update ceiToUpdate.values();
		}
		bevToUpdate.clear();
		avToUpdate.clear();
		pbeToUpdate.clear();
		ceiToUpdate.clear();
		bevToInsert.clear();
		pbeToInsert.clear();

		ceiToInsert.clear();
		prodToInsert.clear();
		wrapList.clear();
	}

	public static OF_Asset_Verticale__c updateAssetVerticaleForBilling(OF_Asset_Verticale__c av,OF_Staging_PNI__c stag,Account openFiber,RecordType rtAssetV) {
		av.RecordTypeId = rtAssetV.Id;
		av.Indirizzo__c = stag.OF_Indirizzo__c;
		av.Civico__c = stag.OF_Civico__c;
		av.Comune__c = stag.OF_Comune__c;
		av.ID_DB_Building__c = stag.OF_ID_Building__c;
		av.ID_DB_Scala_Palazzina__c = stag.OF_Id_DB_Scala_palazzina__c;
		av.ID_GIS_Scala_Palazzina__c = stag.OF_ID_GIS_ScalaPalazzina__c; // serve al createAV
		av.Particella_Toponomastica__c = stag.OF_Particella_Toponomastica__c;
		av.Update_Billing__c = true;
		av.Account__c = openFiber.id;
		av.PNI_OF_ParticellaToponomastica__c = stag.OF_Particella_Toponomastica__c;
		av.PNI_OF_Civico__c = stag.OF_Civico__c;
		av.PNI_OF_Indirizzo__c = stag.OF_Indirizzo__c;
		av.PNI_OF_IDRisorsa__c = stag.OF_Id_Risorsa__c;
		av.PNI_OF_IDBuilding__c = stag.OF_ID_Building__c;
		av.PNI_OF_Comune__c = stag.OF_Comune__c;
		return av;
	}

	//Creazione di un Asset Verticale
	public static OF_Asset_Verticale__c createAssetVerticaleByStaging(OF_Staging_PNI__c stag,Account openFiber,RecordType rtAssetV) {
		System.debug('# createAssetVerticaleByStaging - ');

		Integer uiScalaP = -1;
		try {
			uiScalaP = Integer.valueOf(stag.OF_UI_Scala_Palazzina__c);
		} catch (Exception e) {
			stag.STG_Info_Esecuzione__c = 'UI_Scala_Palazzina errato';
		}
		if (uiScalaP == -1) {
			return null;
		}
		OF_Asset_Verticale__c av = new OF_Asset_Verticale__c();
		av = updateAssetVerticaleForBilling(av,stag,openFiber,rtAssetV);
		av.UI_Scala_Palazzina__c = uiScalaP;
		av.Cardinalita_Scala__c = 1;

		return av;
	}

	public static OF_Billing_Element_Verticale__c searchBEV(String OF_ID_GIS_ScalaPalazzina,String OF_Id_Risorsa) {
		OF_Billing_Element_Verticale__c bev = mapIdR_Bev.get(OF_Id_Risorsa);
		if ((bev == null) || (bev.Asset_Verticale__c == null)) {
			System.debug('+ searchBEV 1 return');
			return null;
		}
		if (OF_ID_GIS_ScalaPalazzina.equalsIgnoreCase(bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c)) {
			return bev;
		}
		// System.debug('++++ searchBEV 2 return');
		return null;
	}

	public static OF_Billing_Element_Verticale__c searchBEVinAVbyOLO(String OF_ID_GIS_ScalaPalazzina, String OLO) {
		//system.debug('= OF_ID_GIS_ScalaPalazzina: ' + OF_ID_GIS_ScalaPalazzina);
		//system.debug('= OLO: ' + OLO);
		List<OF_Billing_Element_Verticale__c> ltmp = mapScala_Bev.get(OF_ID_GIS_ScalaPalazzina);
		if (ltmp == null) {
			return null;
		}
		for (OF_Billing_Element_Verticale__c elem:ltmp) {
			//system.debug('= elem.Olo__c: ' + elem.Olo__c);
			if (elem.Olo__c == OLO) {
				return elem;
			}
		}
		return null;
	}

	/* Creazione del CommercialElementIstanziato */
	public static OF_CommercialElementIstanziato__c createCEI(OF_Billing_Element_Verticale__c bev, RecordType rtCei, Id avId) {
		System.debug('* Ricerca CommercialElementIstanziato in corso *');
		Asset stgAsset = mapAssetStd.get(bev.ID_Risorsa__c);
		system.debug('# Asset: ' + stgAsset);

		OF_CommercialElementIstanziato__c oldCEI = mapIdCeiv.get(stgAsset.id);
		oldCEI = inactiveCEI(oldCEI);
		if (oldCEI != null) {
			mapIdCeiv.remove(oldCEI.OF_Asset__c);
			// return oldCEI;
		}

		OF_ContrattoServizio__c cs = mapServizi.get(stgAsset.OF_Contract__c);
		system.debug('# cs: ' + cs);
		OF_CommercialElement__c servizioVerticale = mapCeXidServ.get(cs.OF_Servizio__c);
		system.debug('# servizioVerticale: ' + servizioVerticale);

		System.debug('*Creazione CommercialElementIstanziato in corso*');
		OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
		cei.RecordTypeId = rtCei.id;
		cei.OF_Stato__c = 'Attivo';
		cei.OF_CommercialElement__c = servizioVerticale.id;
		cei.OF_Asset__c = stgAsset.Id;
		cei.OF_BillingSyncronized__c = false;
		cei.OF_IDRisorsa__c = bev.ID_Risorsa__c;
		cei.OF_DataAttivazione__c = System.now();
		cei.Asset_Verticale__c = avId;

		// insert cei;
		ceiToInsert.add(cei);
		mapIdCeiv.put(cei.OF_Asset__c, cei);
		return cei;
	}

	/* Cessazione del CommercialElementIstanziato old */
	public static OF_CommercialElementIstanziato__c inactiveCEI(OF_CommercialElementIstanziato__c oldCei) {
		System.debug('*Cessazione CommercialElementIstanziato OLD in corso*');
		if (oldCei != null) {
			oldCei.OF_Stato__c = 'Cessato';
			oldCei.OF_DataCessazione__c = System.now();
			ceiToUpdate.put(oldCei.Id, oldCei);
		}
		return oldCei;
	}

	//Creazione del Product/PricebookEntry Contributo Verticale
	public static PricebookEntry createContributoVerticale(String OF_Id_Risorsa, OF_CommercialElementIstanziato__c cei, OF_BillingElement__c be, Pricebook2 standardPb) {
		inactiveContributoVerticale(cei.OF_Asset__c);
		System.debug('*Creazione Contributo Verticale in corso*');

		Product2 p = createProd2(be.id, 'Contributo Verticale');

		PricebookEntry pbeV = createBEI(p.id, standardPb.id, cei);
		mapPbe.put(pbeV.OF_Asset__c, pbeV);

		wrapList.add(new BillingData(cei, p, pbeV));
		return pbeV;
	}

	private static Product2 createProd2(Id beId, String prodName) {
		Product2 p = new Product2();
		p.name = prodName;
		p.OF_BillingElement__c = beId;
		p.IsActive = true;

		// insert p;
		prodToInsert.add(p);
		return p;
	}

	private static PricebookEntry createBEI(Id productId, Id standardPbId, OF_CommercialElementIstanziato__c cei) {
		PricebookEntry pbe = new PricebookEntry();
		pbe.Pricebook2Id = standardPbId;
		pbe.OF_DataAttivazione2__c = System.now();
		pbe.isActive = true;
		pbe.UseStandardPrice = false;
		pbe.UnitPrice = -9999;
		pbe.OF_Asset__c = cei.OF_Asset__c;
		pbe.OF_CommercialElementIstanziato__c = cei.id;
		pbe.Product2Id = productId;
		pbeToInsert.add(pbe);
		return pbe;
	}

	//Creazione del Product/PricebookEntry Contributo Storno Verticale
	public static PricebookEntry createContributoStornoVerticale(String OF_Id_Risorsa, OF_BillingElement__c be, Pricebook2 standardPb) {
		Asset stgAsset = mapAssetStd.get(OF_Id_Risorsa);
		inactiveContributoStornoVerticale(stgAsset.id);
		System.debug('*Creazione Contributo Storno Verticale in corso.*');

		OF_CommercialElementIstanziato__c cei = mapIdCeiv.get(stgAsset.id);

		if (cei == null) {
			System.debug('*Nessun CEI per idRisorsa: ' + OF_Id_Risorsa);
			return null;
		}

		Product2 p = createProd2(be.id, 'Contributo Storno Verticale');

		PricebookEntry pbeV = createBEI(p.id, standardPb.id, cei);
		mapPbeS.put(pbeV.OF_Asset__c,pbeV);

		wrapList.add(new BillingData(cei, p, pbeV));
		return pbeV;
	}

	//Creazione del Product/PricebookEntry Contributo Storno Verticale
	public static void inactiveContributoVerticale(Id assetId) {
		System.debug('*Inactive Contributo Verticale in corso*');

		PricebookEntry pbToRemove = mapPbe.get(assetId);
		//Inattivo Contributo Storno Verticale
		if (pbToRemove != null) {
			pbToRemove.IsActive = false;
			pbToRemove.OF_DataCessazione2__c = System.now();
			// update pbToRemove;
			pbeToUpdate.put(pbToRemove.Id, pbToRemove);
			mapPbe.remove(assetId);
		}
	}

	//Creazione del Product/PricebookEntry Contributo Storno Verticale
	public static void inactiveContributoStornoVerticale(Id assetId) {
		System.debug('*Inactive Contributo Storno Verticale in corso*');

		PricebookEntry pbToRemoveS = mapPbeS.get(assetId);
		//Inattivo Contributo Storno Verticale
		system.debug('pbToRemoveS: ' + pbToRemoveS + '-' + assetId);

		if (pbToRemoveS != null) {
			pbToRemoveS.IsActive = false;
			pbToRemoveS.OF_DataCessazione2__c = System.now();
			// update pbToRemoveS;
			pbeToUpdate.put(pbToRemoveS.Id, pbToRemoveS);
			mapPbeS.remove(assetId);
		}
	}

	/* Creazione Billing Element Verticale */
	public static OF_Billing_Element_Verticale__c createBEV(OF_Staging_PNI__c stag, OF_Asset_Verticale__c av) {
		System.debug('*Creazione BE Verticale in corso*');
		if (av == null) {
			return null;
		}
		Asset stgAsset = mapAssetStd.get(stag.OF_Id_Risorsa__c);

		OF_Billing_Element_Verticale__c bev = new OF_Billing_Element_Verticale__c();
		bev.name = 'BEV-' + stag.OF_Id_Risorsa__c;
		bev.ID_Building__c = stag.OF_ID_Building__c;
		bev.Scala__c = stag.OF_Scala__c;
		bev.Palazzina__c = stag.OF_Palazzina__c;
		bev.ID_Risorsa__c = stag.OF_Id_Risorsa__c;
		bev.OLO__c = stgAsset.AccountId;
		bev.OF_Status__c = 'ATTIVO';
		bev.Update_Billing__c = true;
		// if (stgAsset.OF_OrdineID__c != null) {
		//  ordine = getOrdine(stgAsset.OF_OrdineID__c)
		//  bev.Codice_Ordine_OLO__c = ordine.OF_IDOrdineOLO__c;
		// }
		// bev.Codice_Ordine_OLO__c = caseAttiv.EOF_Codice_Ordine_OLO__c;  //todo: per i dati di remedy prevedere un campo sull'asset

		bev.Data_Attivazione__c = stgAsset.OF_DataAttivazione2__c;

		if ('GIS'.equalsIgnoreCase(stag.OF_Source_System__c)) {
			bev.Data_Attivazione__c = Datetime.valueOf(stag.OF_GIS_Data_Espletamento__c);
		}

		//Relaziono il BE Verticale all'Asset Standard
		bev.Asset__c = stgAsset.id;
		//Relaziono il BE Verticale all'Asset Verticale
		bev.Asset_Verticale__c = av.Id;
		bevToInsert.add(bev);
		mapIdR_Bev.put(bev.ID_Risorsa__c, bev);
		List<OF_Billing_Element_Verticale__c> out = mapScala_Bev.get(av.ID_GIS_Scala_Palazzina__c);
		if (out == null) {
			out = new List<OF_Billing_Element_Verticale__c>();
			mapScala_Bev.put(av.ID_GIS_Scala_Palazzina__c,out);
		}
		out.add(bev);

		av.Cardinalita_Scala__c = out.size();
		//system.debug('out.size()' + out.size());
		avToUpdate.put(av.Id, av);

		return bev;
	}

	/*
	   public static List<OF_Billing_Element_Verticale__c> ritornaListaBEV(String ID_GIS_Scala_Palazzina, List<OF_Billing_Element_Verticale__c>  beV_totali) {
	    List<OF_Billing_Element_Verticale__c> listOut = new List<OF_Billing_Element_Verticale__c>();
	    for (OF_Billing_Element_Verticale__c bev:beV_totali) {
	        if ((bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c).equals(ID_GIS_Scala_Palazzina)) {
	            listOut.add(bev);
	        }
	    }
	    return listOut;
	   }
	 */

	/* usato nel punto 10 e commentato nel punto 6 */
	/*
	   public static svoid removeBEV(OF_Billing_Element_Verticale__c bev,OF_Asset_Verticale__c av) {
	    System.debug('*Remove BE Verticale in corso*');

	    if (bev != null) {
	        mapIdR_Bev.remove(bev.ID_Risorsa__c);
	        //aggiorno la mappa
	        List<OF_Billing_Element_Verticale__c> listTMP = mapScala_Bev.get(av.ID_GIS_Scala_Palazzina__c);
	        List<OF_Billing_Element_Verticale__c> listTMP2 = new List<OF_Billing_Element_Verticale__c>();
	        if (listTMP != null) {
	            for (OF_Billing_Element_Verticale__c tm:listTMP) {
	                if (!tm.Asset__r.EOF_ID_Risorsa__c.equals(bev.ID_Risorsa__c)) {
	                    listTMP2.add(tm);
	                }
	            }
	        }
	        mapScala_Bev.put(av.ID_GIS_Scala_Palazzina__c,listTMP2);

	        mapIdR_Bev.remove(bev.ID_Risorsa__c);
	        bev.OF_Status__c = 'INATTIVO';
	        bev.Update_Billing__c = true;
	        bev.Asset_Verticale__c = null;
	        bevToUpdate.put(bev.Id, bev);

	        av.Cardinalita_Scala__c = listTMP2.size();
	        system.debug('listTMP2.size()' + listTMP2.size());
	        avToUpdate.put(av.Id, av);
	    }
	   }
	 */

	/* Creazione Billing Element Verticale */
	public static OF_Billing_Element_Verticale__c cambiaAV(OF_Billing_Element_Verticale__c bev, OF_Asset_Verticale__c avDest, OF_Asset_Verticale__c avOrigin) {
		//aggiorno la mappa
		List<OF_Billing_Element_Verticale__c> listTMP = mapScala_Bev.get(avOrigin.ID_GIS_Scala_Palazzina__c);
		List<OF_Billing_Element_Verticale__c> listTMP2 = new List<OF_Billing_Element_Verticale__c>();
		if (listTMP != null) {
			for (OF_Billing_Element_Verticale__c tm:listTMP) {
				//if (!bev.ID_Risorsa__c.equals(tm.Asset__r.EOF_ID_Risorsa__c)) {
				if (!bev.ID_Risorsa__c.equals(tm.ID_Risorsa__c)) {
					listTMP2.add(tm);
				}
			}
		}
		mapScala_Bev.put(avOrigin.ID_GIS_Scala_Palazzina__c,listTMP2);
		//avOrigin.Cardinalita_Scala__c = listTMP2.size();
		avOrigin.Cardinalita_Scala__c -= 1;
		avOrigin.Update_Billing__c = true;
		avToUpdate.put(avOrigin.Id, avOrigin);

		bev.Asset_Verticale__c = avDest.Id;
		bev.Update_Billing__c = true;
		bevToUpdate.put(bev.Id, bev);

		mapIdR_Bev.put(bev.ID_Risorsa__c, bev);
		List<OF_Billing_Element_Verticale__c> dest = mapScala_Bev.get(avDest.ID_GIS_Scala_Palazzina__c);
		if (dest == null) {
			dest = new List<OF_Billing_Element_Verticale__c>();
			mapScala_Bev.put(avDest.ID_GIS_Scala_Palazzina__c, dest);
		}
		dest.add(bev);

		avDest.Cardinalita_Scala__c = dest.size();
		avDest.Update_Billing__c = true;
		// system.debug('dest.size()' + dest.size());
		avToUpdate.put(avDest.Id, avDest);

		OF_CommercialElementIstanziato__c cei = mapIdCeiv.get(bev.Asset__c);
		if ((cei != null) && !avDest.Id.equals(cei.Asset_Verticale__c)) {
			cei.Asset_Verticale__c = avDest.Id;
			ceiToUpdate.put(cei.Id, cei);
		}

		return bev;
	}
}
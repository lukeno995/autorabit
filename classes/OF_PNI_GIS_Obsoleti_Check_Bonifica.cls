public class OF_PNI_GIS_Obsoleti_Check_Bonifica {

	private final Datetime creationDateThresold;
	private final Datetime now;

	private final List<OF_Billing_Element_Verticale__c> validBEV;
	private final Map<String, List<OF_Billing_Element_Verticale__c>> mapScala_Bev;
	private final List<OF_Billing_Element_Verticale__c> invalidBEV;
	private final Map<Id, PricebookEntry> mapPbe;
	private final Map<Id, PricebookEntry> mapPbeS;
	private final Map<Id, OF_Asset_Verticale__c> mapAV;
	private final Map<Id, OF_ContrattoServizio__c> mapServizi;
	private final Map<Id, OF_CommercialElementIstanziato__c> mapIdCeiv;
	private final Map<Id, OF_CommercialElement__c> mapCeXidServ;
	private final Map<String, Set<String>> mapScalaOloName;

	private final Map<Id, OF_Asset_Verticale__c> avToUpdate;
	private final Map<Id, OF_Billing_Element_Verticale__c> bevToUpdate;
	private final List<PricebookEntry> pbToUpdate;
	private final List<PricebookEntry> pbsToUpdate;
	private final List<OF_CommercialElementIstanziato__c> ceiToUpdate;

	private final Set<PricebookEntry> pbeToInsert;
	private final List<OF_CommercialElementIstanziato__c> ceiToInsert;
	private final List<Product2> prodToInsert;
	private final List<BillingData> wrapList;

	private final List<OF_Billing_Element_Verticale__c> bevToDelete;

	private final RecordType rtCei;
	private final OF_BillingElement__c be_Storno;
	private final OF_BillingElement__c be_Contributo;
	private final Pricebook2 standardPb;

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

	// Used only for debug
	private String idScala_Olo = null;

	public OF_PNI_GIS_Obsoleti_Check_Bonifica() {

		Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
		system.debug('Minuti Tolleranza: ' + verticaliCS.giorniTolleranza__c.intvalue());
		creationDateThresold = System.now().addMinutes(verticaliCS.giorniTolleranza__c.intvalue());
		now = System.now();
		validBEV = new List<OF_Billing_Element_Verticale__c>();
		mapScala_Bev = new Map<String, List<OF_Billing_Element_Verticale__c> >();
		invalidBEV = new List<OF_Billing_Element_Verticale__c>();
		mapPbe = new Map<Id, PricebookEntry>();
		mapPbeS = new Map<Id, PricebookEntry>();
		mapAV = new Map<Id, OF_Asset_Verticale__c>();
		mapServizi = new Map<Id, OF_ContrattoServizio__c>();
		mapIdCeiv = new Map<Id, OF_CommercialElementIstanziato__c>();
		mapCeXidServ = new Map<Id, OF_CommercialElement__c>();
		mapScalaOloName = new Map<String, Set<String> >();

		avToUpdate = new Map<Id, OF_Asset_Verticale__c>();
		bevToUpdate = new Map<Id, OF_Billing_Element_Verticale__c>();
		pbToUpdate = new List<PricebookEntry>();
		pbsToUpdate = new List<PricebookEntry>();
		ceiToUpdate = new List<OF_CommercialElementIstanziato__c>();

		pbeToInsert = new Set<PricebookEntry>();
		ceiToInsert = new List<OF_CommercialElementIstanziato__c>();
		prodToInsert = new List<Product2>();
		wrapList = new List<BillingData>();

		bevToDelete = new List<OF_Billing_Element_Verticale__c>();

		rtCei = [SELECT id, name, SobjectType
				 FROM RecordType
				 WHERE name = 'Verticale' AND SobjectType = 'OF_CommercialElementIstanziato__c'];

		be_Storno = [SELECT id, name, OF_CommercialElement__c, OF_Attivo__c
					 FROM OF_BillingElement__c
					 WHERE name = 'Contributo di storno Verticale' LIMIT 1];

		be_Contributo = [SELECT id, name, OF_CommercialElement__c, OF_Attivo__c
						 FROM OF_BillingElement__c
						 WHERE name = 'Contributo Verticale' LIMIT 1];

		standardPb = [SELECT id
					  FROM Pricebook2
					  WHERE isStandard = true LIMIT 1];
	}

	private void populateMaps(List<OF_Billing_Element_Verticale__c> listaBEV) {
		Set<Id> avIdSet = new Set<Id>();
		Set<Id> assetIdList = new Set<Id>();
		for (OF_Billing_Element_Verticale__c bev : listaBEV) {
			avIdSet.add(bev.Asset_Verticale__c);
			assetIdList.add(bev.Asset__c);
		}

		List<PricebookEntry> pbe_list = [SELECT id, name, Product2Id, OF_CommercialElementIstanziato__c, OF_Asset__c, IsActive,
										 OF_DataCessazione2__c
										 FROM PricebookEntry
										 WHERE Product2.Name = 'Contributo Verticale' AND IsActive = true AND OF_Asset__c IN :assetIdList];

		List<PricebookEntry> pbes_list = [SELECT id, name, Product2Id, OF_CommercialElementIstanziato__c, OF_Asset__c, IsActive,
										  OF_DataCessazione2__c
										  FROM PricebookEntry
										  WHERE Product2.Name = 'Contributo Storno Verticale' AND IsActive = true AND OF_Asset__c IN :assetIdList];

		for (PricebookEntry p : pbe_list) {
			mapPbe.put(p.OF_Asset__c, p);
		}
		for (PricebookEntry p : pbes_list) {
			mapPbeS.put(p.OF_Asset__c, p);
		}

		List<OF_Asset_Verticale__c> assetV_totali = [SELECT id, Name, Account__c, Cardinalita_Scala__c, Update_Billing__c, ID_GIS_Scala_Palazzina__c
													 FROM OF_Asset_Verticale__c
													 WHERE id IN :avIdSet];

		for (OF_Asset_Verticale__c av : assetV_totali) {
			mapAV.put(av.id, av);
		}

		List<OF_ContrattoServizio__c> listaContrattiServizio = [SELECT OF_Servizio__c, OF_Servizio__r.Id, OF_Contract__c
																FROM OF_ContrattoServizio__c
																WHERE OF_Servizio__r.Name like '%VERTICALE%'];


		Set<Id> listaServizioId = new Set<Id>();
		for (OF_ContrattoServizio__c cs : listaContrattiServizio) {
			mapServizi.put(cs.OF_Contract__c, cs);
			listaServizioId.add(cs.OF_Servizio__c);
		}

		List<OF_CommercialElementIstanziato__c> ceiv_totali = [SELECT Id, CreatedDate, Asset_Verticale__c, OF_Asset__c, OF_Stato__c, OF_DataCessazione__c, OF_DataAttivazione__c, OF_IDRisorsa__c, RecordTypeId, OF_BillingSyncronized__c
															   FROM OF_CommercialElementIstanziato__c
															   WHERE OF_CommercialElement__r.name = 'Servizio Verticale'
																   AND OF_Stato__c = 'Attivo' AND OF_Asset__c IN :assetIdList];

		for (OF_CommercialElementIstanziato__c cei : ceiv_totali) {
			mapIdCeiv.put(cei.OF_Asset__c, cei);
		}

		List<OF_CommercialElement__c> listaCEVert_totali = [SELECT id, name, OF_Servizio__c
															FROM OF_CommercialElement__c
															WHERE OF_Servizio__r.name LIKE '%VERTICALE%' AND OF_Servizio__c IN :listaServizioId];

		for (OF_CommercialElement__c ce : listaCEVert_totali) {
			mapCeXidServ.put(ce.OF_Servizio__c, ce);
		}

	}

	public void run(List<OF_Billing_Element_Verticale__c> listaBEV) {

		populateMaps(listaBEV);

		String prevOLO = null;
		String prevIdScala = null;

		for (OF_Billing_Element_Verticale__c bev : listaBEV) {
			String idScala = bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c;
			String olo = bev.OLO__r.name;
			idScala_Olo = 'idScala: [' + bev.Asset_Verticale__c + '] - Olo: [' + olo + '] - idRisorsa: [' + bev.ID_Risorsa__c + ']';

			if (idScala.equals(prevIdScala)) {
				if (olo.equals(prevOLO)) {
					// Se già ho trovato un BEV per questa coppia <IdScala, OLO>
					// sicuramente sarà da eliminare perché la lista in input è ordinata per Data_Attivazione
					addStorno(bev, idScala, olo);
				} else {
					// Prima volta che incontro questo OLO per questa scala, quindi il bev sarà quello da tenere
					saveValidBev(bev, idScala);
				}
			} else {
				// Prima volta che incontro questa scala, quindi il bev sarà quello da tenere
				saveValidBev(bev, idScala);
			}

			prevIdScala = idScala;
			prevOLO = olo;
		}

		for (OF_Billing_Element_Verticale__c bev : invalidBEV) {
			bev.OF_Status__c = 'INATTIVO';
			bev.Update_Billing__c = true;
			bev.Asset_Verticale__c = null;
		}

		addBeiAndStornoToValidBev();
		updateDB();
	}

	private void saveValidBev(OF_Billing_Element_Verticale__c bev, String idScala) {
		List<OF_Billing_Element_Verticale__c> bevScalaList = mapScala_Bev.get(idScala);
		if (bevScalaList == null) {
			bevScalaList = new List<OF_Billing_Element_Verticale__c>();
			mapScala_Bev.put(idScala, bevScalaList);
		}
		bevScalaList.add(bev);
		validBEV.add(bev);
	}

	private void addBeiAndStornoToValidBev() {
		for (OF_Billing_Element_Verticale__c bev : validBEV) {
			String idScala = bev.Asset_Verticale__r.ID_GIS_Scala_Palazzina__c;
			String olo = bev.OLO__r.name;
			Set<String> oloList = mapScalaOloName.get(idScala);
			// se c'erano più record per questo OLO su questa scala
			if ((oloList != null) && oloList.contains(olo)) {
				idScala_Olo = 'idScala: [' + bev.Asset_Verticale__c + '] - Olo: [' + olo + '] - idRisorsa: [' + bev.ID_Risorsa__c + ']';
				System.debug('Valid - ' + idScala_Olo);
				System.debug('Già presente su questa scala? ' + (bev.LastModifiedDate < creationDateThresold));

				// Se il bev non esisteva già su questa scala devo creare cei & co
				if (bev.LastModifiedDate > creationDateThresold) {

					OF_CommercialElementIstanziato__c oldCei = mapIdCeiv.get(bev.Asset__c);
					// Se il bev è stato spostato aggiungo il bei e lo storno
					Boolean spostato = (bev.CreatedDate < creationDateThresold);
					System.debug('Spostato? ' + spostato);
					Boolean ceiCreatoDalloStep2 = (oldCei != null) && (oldCei.CreatedDate > creationDateThresold);
					System.debug('ceiCreatoDalloStep2? ' + ceiCreatoDalloStep2);
					if (spostato && !ceiCreatoDalloStep2) {
						createContributoStornoVerticale(bev, be_Storno, standardPb);
					}
					if ((spostato && !ceiCreatoDalloStep2) || (oldCei == null)) {
						// Se non c'era alcun CEI associato al bev, non c'era nemmeno un bei
						OF_CommercialElementIstanziato__c cei = createCEI(bev, rtCei);
						createContributoVerticale(bev, cei, be_Contributo, standardPb);
					} else if ((oldCei != null) && !mapPbe.containsKey(bev.Asset__c)) {
						// Se non è presente un BEI per questo CEI
						System.debug('Esisteva solo il CEI ma non il BEI per l\'asset ' + bev.Asset__c);
						createContributoVerticale(bev, oldCei, be_Contributo, standardPb);
					}
				} // altrimenti non faccio nulla perché l'ha già fatto lo step precedente
			}
		}
	}

	private void updateDB() {
		insert ceiToInsert;
		insert prodToInsert;
		for (BillingData bd : wrapList) {
			bd.pb.OF_CommercialElementIstanziato__c = bd.c.Id;
			bd.pb.Product2Id = bd.prod.Id;
		}

		List<OF_Asset_Verticale__c> avList = avToUpdate.values();
		for (OF_Asset_Verticale__c av : avList) {
			List<OF_Billing_Element_Verticale__c> bevScalaList = mapScala_Bev.get(av.ID_GIS_Scala_Palazzina__c);
			av.Cardinalita_Scala__c = bevScalaList.size();
		}

		if (!bevToDelete.isEmpty()) {
			List<OF_CommercialElementIstanziato__c> ceiToDelete = new List<OF_CommercialElementIstanziato__c>();
			List<PricebookEntry> pbeToDelete = new List<PricebookEntry>();
			for (OF_Billing_Element_Verticale__c bev : bevToDelete) {

				OF_CommercialElementIstanziato__c cei = mapIdCeiv.get(bev.Asset__c);
				if ((cei != null) && cei.Asset_Verticale__c.equals(bev.Asset_Verticale__c)) {
					ceiToDelete.add(cei);
					PricebookEntry pbToRemove = mapPbe.remove(bev.Asset__c);
					if ((pbToRemove != null) && pbToRemove.OF_CommercialElementIstanziato__c.equals(cei.id)) {
						pbeToDelete.add(pbToRemove);
					}
				}
			}

			List<Id> product2IdList = new List<Id>();
			for (PricebookEntry pbe : pbeToDelete) {
				product2IdList.add(pbe.Product2Id);
			}
			List<Product2> productToDelete = [SELECT Id FROM Product2 WHERE Id IN :product2IdList];

			delete pbeToDelete;
			delete productToDelete;
			delete ceiToDelete;
			delete bevToDelete;
		}

		insert new List<PricebookEntry>(pbeToInsert);
		update avList;
		update invalidBEV;
		update bevToUpdate.values();
		update pbToUpdate;
		update pbsToUpdate;
		update ceiToUpdate;
	}

	private void addStorno(OF_Billing_Element_Verticale__c bev, String idScala, String olo) {
		Set<String> oloList = mapScalaOloName.get(idScala);
		if (oloList == null) {
			oloList = new Set<String>();
			mapScalaOloName.put(idScala, oloList);
		}
		oloList.add(olo);

		Boolean isNew = (bev.CreatedDate > creationDateThresold);
		System.debug('Invalid - ' + idScala_Olo);
		System.debug('Is new? ' + isNew);

		OF_Asset_Verticale__c av = mapAV.get(bev.Asset_Verticale__c);
		if (av != null) {
			avToUpdate.put(av.Id, av);
		}

		// Se il bev è stato creato dallo step 2
		if (isNew) {
			// Devo cancellare BEV, CEI e BEI
			bevToDelete.add(bev);
		} else {
			invalidBEV.add(bev);
			// Altrimenti devo invalidare il CEI, aggiungere lo storno e cessare il CEI
			inactiveContributoVerticale(bev.Asset__c);
			if (av != null) {
				av.Update_Billing__c = true;
			}
			createContributoStornoVerticale(bev, be_Storno, standardPb);
			inactiveCEI(mapIdCeiv.remove(bev.Asset__c));
		}
	}

	private void inactiveContributoVerticale(Id assetId) {
		System.debug('* Inactive Contributo Verticale in corso *');

		PricebookEntry pbToRemove = mapPbe.remove(assetId);
		// Inattivo Contributo Verticale
		if (pbToRemove != null) {
			pbToUpdate.add(pbToRemove);
			pbToRemove.IsActive = false;
			pbToRemove.OF_DataCessazione2__c = now;
		}
	}

	private void inactiveContributoStornoVerticale(Id assetId) {
		System.debug('* Inactive Contributo Storno Verticale in corso *');

		PricebookEntry pbToRemoveS = mapPbeS.remove(assetId);
		// Inattivo Contributo Storno Verticale
		if ((pbToRemoveS != null) && !pbeToInsert.remove(pbToRemoveS)) {
			// Se il pbe non è stato creato da questo batch, allora è da modificare
			pbsToUpdate.add(pbToRemoveS);
			pbToRemoveS.IsActive = false;
			pbToRemoveS.OF_DataCessazione2__c = now;
		}
	}

	/* Creazione del CommercialElementIstanziato */
	private OF_CommercialElementIstanziato__c createCEI(OF_Billing_Element_Verticale__c bev, RecordType rtCei) {
		System.debug('* Ricerca CommercialElementIstanziato in corso *');

		OF_ContrattoServizio__c cs_curr = mapServizi.get(bev.Asset__r.OF_Contract__c);
		OF_CommercialElement__c servizioVerticale = mapCeXidServ.get(cs_curr.OF_Servizio__c);
		OF_Asset_Verticale__c av = mapAV.get(bev.Asset_Verticale__c);

		OF_CommercialElementIstanziato__c old_cei = mapIdCeiv.get(bev.Asset__c);
		inactiveCEI(old_cei);
		if (old_cei != null) {
			mapIdCeiv.remove(old_cei.OF_Asset__c);
			// return old_cei;
		}

		System.debug('* Creazione CommercialElementIstanziato in corso *');
		OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
		cei.RecordTypeId = rtCei.id;
		cei.OF_Stato__c = 'Attivo';
		cei.OF_CommercialElement__c = servizioVerticale.id;
		cei.OF_Asset__c = bev.Asset__c;
		cei.OF_IDRisorsa__c = bev.ID_Risorsa__c;
		cei.OF_DataAttivazione__c = now;
		cei.OF_BillingSyncronized__c = false;
		if (av != null) {
			cei.Asset_Verticale__c = av.Id;
		}

		ceiToInsert.add(cei);

		mapIdCeiv.put(cei.OF_Asset__c, cei);

		return cei;
	}

	private void inactiveCEI(OF_CommercialElementIstanziato__c oldCeiv) {
		if (oldCeiv != null) {
			System.debug('* Cessazione CommercialElementIstanziato OLD in corso *');
			ceiToUpdate.add(oldCeiv);
			oldCeiv.OF_Stato__c = 'Cessato';
			oldCeiv.OF_DataCessazione__c = now;
		}
	}

	//Creazione del Product/PricebookEntry Contributo Storno Verticale
	private PricebookEntry createContributoStornoVerticale(OF_Billing_Element_Verticale__c bev, OF_BillingElement__c be, Pricebook2 standardPb) {
		inactiveContributoStornoVerticale(bev.Asset__c);
		System.debug('* Creazione Contributo Storno Verticale in corso *');

		OF_CommercialElementIstanziato__c cei = mapIdCeiv.get(bev.Asset__c);

		if (cei == null) {
			System.debug('* Nessun CEI per bev.Asset__c: ' + bev.Asset__c);
			return null;
		}
		Product2 p = createProd2(be.id, 'Contributo Storno Verticale');

		PricebookEntry pbe = createBEI(p.id, standardPb.id, cei, now);
		mapPbeS.put(pbe.OF_Asset__c, pbe);

		//bev.Update_Billing__c = true;
		//bevToUpdate.put(bev.Id, bev);

		wrapList.add(new BillingData(cei, p, pbe));

		return pbe;
	}

	private PricebookEntry createContributoVerticale(OF_Billing_Element_Verticale__c bev, OF_CommercialElementIstanziato__c cei, OF_BillingElement__c be, Pricebook2 standardPb) {
		inactiveContributoVerticale(bev.Asset__c);
		System.debug('* Creazione Contributo Verticale in corso *');

		Product2 p = createProd2(be.id, 'Contributo Verticale');

		PricebookEntry pbe = createBEI(p.id, standardPb.id, cei, now);
		mapPbe.put(pbe.OF_Asset__c, pbe);

		bev.Update_Billing__c = true;
		bevToUpdate.put(bev.Id, bev);

		wrapList.add(new BillingData(cei, p, pbe));

		return pbe;
	}

	private PricebookEntry createBEI(Id productId, Id standardPbId, OF_CommercialElementIstanziato__c cei, DateTime dataAttivazione) {
		PricebookEntry pbe = new PricebookEntry();
		pbe.Pricebook2Id = standardPbId;
		pbe.OF_DataAttivazione2__c = dataAttivazione;
		pbe.isActive = true;
		pbe.UseStandardPrice = false;
		pbe.UnitPrice = -9999;
		pbe.OF_Asset__c = cei.OF_Asset__c;
		pbe.OF_CommercialElementIstanziato__c = cei.id;
		pbe.Product2Id = productId;

		pbeToInsert.add(pbe);
		return pbe;
	}

	private Product2 createProd2(Id beId, String prodName) {
		Product2 p = new Product2();
		p.name = prodName;
		p.OF_BillingElement__c = beId;
		p.IsActive = true;

		prodToInsert.add(p);
		return p;
	}
}
public class OF_Staging_CheckInvalidRecords {
	private Set<OF_Staging_PNI__c> gisElementsList = new Set<OF_Staging_PNI__c>();
	private Set<OF_Staging_PNI__c> pniElementsList = new Set<OF_Staging_PNI__c>();
	private Set<String> invalidIdScalaList = new Set<String>();
	private final String GIS = 'GIS';
	private final String PNI = 'PNI';

	public static final Set<String> invalidIdRisorsaList = new Set<String> {'N/A', '#N/A', 'N/D', '#N/D'};
	public static final Set<String> invalidIdScalaPalazzinaList = new Set<String> {'N/A', '#N/A'};

	@TestVisible
	class WrapData {

		@TestVisible
		String OLO {get; set;}
		@TestVisible
		DateTime DataAttivazione {get; set;}
		@TestVisible
		String idScala {get; set;}
		@TestVisible
		OF_Staging_PNI__c stagF {get; set;}

		public Boolean equals(Object obj) {
			if (obj == null) {
				return false;
			}

			if (!(obj instanceof WrapData)) {
				return false;
			}

			WrapData o = (WrapData) obj;

			return areEquals(this.OLO, o.OLO) && areEquals(this.DataAttivazione, o.DataAttivazione) &&
				   areEquals(this.idScala, o.idScala) && areEquals(this.stagF, o.stagF);
		}

		public Integer hashCode() {
			Integer hash = 31;
			if (this.OLO != null) {
				hash += this.OLO.hashCode();
			}
			if (this.DataAttivazione != null) {
				hash += this.DataAttivazione.getTime().intValue();
			}
			if (this.idScala != null) {
				hash += this.idScala.hashCode();
			}
			if (this.stagF != null) {
				hash += String.valueOf(this.stagF.Id).hashCode();
			}
			return hash;
		}
		@TestVisible
		private Boolean areEquals(Object o1, Object o2) {
			if (o1 == null) {
				if (o2 == null) {
					return true;
				}
				return false;
			}
			if (o2 == null) {
				return false;
			}
			return o1.equals(o2);
		}
	}

	private Map<String, Asset> generateMappingForAssetStd(Set<String> idRisorsaList) {
		System.debug('Retrieving info for ' + idRisorsaList.size() + ' Asset');
		Map<String, Asset> mapAssetStd = new Map<String, Asset>();

		List<Asset> listaAssetStd = [SELECT EOF_ID_Risorsa__c, OF_Contract__c, Account.EOF_Codice_Operatore__c, OF_DataAttivazione2__c, recordType.name
									 FROM Asset
									 WHERE EOF_ID_Risorsa__c IN :idRisorsaList AND recordType.name IN('Open Stream', 'GPON Passiva')];

		for (Asset a : listaAssetStd) {
			mapAssetStd.put(a.EOF_ID_Risorsa__c,a);
		}

		return mapAssetStd;
	}

	public void run(List<OF_Staging_PNI__c> stagingList, List<OF_Staging_PNI__c> invalids) {
		Map<Id, OF_Staging_PNI__c> validList = fillSupportLists(stagingList, invalids);
		flagInvalids(invalids);
		checkMandatoryFields(validList);

		Set<String> idRisorsaList = new Set<String>();
		for (OF_Staging_PNI__c stag : validList.values()) {
			idRisorsaList.add(stag.OF_Id_Risorsa__c);
		}
		Map<String, Asset> mapIdRisorsa_Asset = generateMappingForAssetStd(idRisorsaList);

		validList = checkOLO(validList, mapIdRisorsa_Asset);
		checkUniqueConstraints(validList);
		invalidateByDataAttivazione(validList, mapIdRisorsa_Asset);
		addInfoToStaging(validList, mapIdRisorsa_Asset);
	}

	private void flagInvalids(List<OF_Staging_PNI__c> invalids) {
		System.debug('flagInvalids: found ' + invalids.size() + ' record with N/A or invalid IdRisorsa');
		for (OF_Staging_PNI__c stag : invalids) {
			stag.STG_Info_Esecuzione__c = 'N/A or invalid IdRisorsa';
			stag.isValid__c = false;
		}
		update invalids;
	}

	private Map<Id, OF_Staging_PNI__c> checkOLO(Map<Id, OF_Staging_PNI__c> validMap, Map<String, Asset> mapIdRisorsa_Asset) {
		String errorHeader = 'OLO Error: ';
		Map<Id, OF_ContrattoServizio__c> mapServizi = new Map<Id, OF_ContrattoServizio__c>();

		for (OF_ContrattoServizio__c cs : [SELECT OF_Servizio__c, OF_Contract__c FROM OF_ContrattoServizio__c WHERE OF_Servizio__r.Name LIKE '%VERTICALE%']) {
			mapServizi.put(cs.OF_Contract__c, cs);
		}

		Map<Id, OF_CommercialElement__c> mapCeXidServ = new Map<Id, OF_CommercialElement__c>();

		for (OF_CommercialElement__c ce : [SELECT id, name, OF_Servizio__c FROM OF_CommercialElement__c WHERE OF_Servizio__r.name LIKE '%VERTICALE%' limit 2]) {
			mapCeXidServ.put(ce.OF_Servizio__c, ce);
		}

		List<OF_Staging_PNI__c> invalidList = new List<OF_Staging_PNI__c>();
		List<OF_Staging_PNI__c> validList = new List<OF_Staging_PNI__c>(validMap.values());
		for (OF_Staging_PNI__c stag : validList) {
			Asset assetStd = mapIdRisorsa_Asset.get(stag.OF_Id_Risorsa__c);
			if (assetStd == null) {
				if (PNI.equals(stag.OF_Source_System__c)) {
					stag.isValid__c = false;
					stag.STG_Info_Esecuzione__c = 'There is no Asset with ID_Risorsa [' + stag.OF_Id_Risorsa__c + ']';
					invalidList.add(stag);
					validMap.remove(stag.Id);
				}
				continue;
			}
			if (String.isNotBlank(assetStd.OF_Contract__c)) {
				OF_ContrattoServizio__c cs = mapServizi.get(assetStd.OF_Contract__c);
				if ((cs != null) && String.isNotBlank(cs.OF_Servizio__c)) {
					OF_CommercialElement__c servizioVerticale = mapCeXidServ.get(cs.OF_Servizio__c);
					if (servizioVerticale == null) {
						stag.isValid__c = false;
						stag.STG_Info_Esecuzione__c = errorHeader + 'ServizioVerticale mancante';
						invalidList.add(stag);
						validMap.remove(stag.Id);
					}
				} else {
					stag.isValid__c = false;
					stag.STG_Info_Esecuzione__c = errorHeader + (cs == null ? 'ContrattoServizio mancante' : 'Servizio mancante');
					invalidList.add(stag);
					validMap.remove(stag.Id);
				}
			} else {
				stag.isValid__c = false;
				stag.STG_Info_Esecuzione__c = errorHeader + 'Contratto mancante';
				invalidList.add(stag);
				validMap.remove(stag.Id);
			}
		}

		System.debug(invalidList.size() + ' records are invalid due to OLO configuration issues');
		update invalidList;
		return validMap;
	}

	private Map<Id, OF_Staging_PNI__c> fillSupportLists(List<OF_Staging_PNI__c> stagingList, List<OF_Staging_PNI__c> invalids) {
		Map<Id, OF_Staging_PNI__c> validList = new Map<Id, OF_Staging_PNI__c>();

		for (OF_Staging_PNI__c elem : stagingList) {
			if (OF_Staging_CheckInvalidRecords.isIdRisorsaInvalid(elem.OF_Id_Risorsa__c) || OF_Staging_CheckInvalidRecords.isIdScalaPalazzinaInvalid(elem.OF_ID_GIS_ScalaPalazzina__c)) {
				invalids.add(elem);
			} else {
				validList.put(elem.Id, elem);
				if (GIS.equalsIgnoreCase(elem.OF_Source_System__c)) {
					gisElementsList.add(elem);
				} else if (PNI.equalsIgnoreCase(elem.OF_Source_System__c)) {
					pniElementsList.add(elem);
				}
			}
		}

		System.debug('Checking ' + stagingList.size() + ' records. ' + pniElementsList.size() + ' are from PNI and ' + gisElementsList.size() + ' are from GIS');
		return validList;
	}

	private void checkMandatoryFields(Map<Id, OF_Staging_PNI__c> validList) {
		checkMandatoryPNIFields(validList);
		checkMandatoryGISFields(validList);
	}

	private void checkMandatoryPNIFields(Map<Id, OF_Staging_PNI__c> validList) {
		List<OF_Staging_PNI__c> invalidElementsList = new List<OF_Staging_PNI__c>();

		for (OF_Staging_PNI__c elem : pniElementsList) {
			Boolean blankAnagraficaParams = String.isBlank(elem.OF_UI_Scala_Palazzina__c) || String.isBlank(elem.OF_Comune__c) || String.isBlank(elem.OF_Particella_Toponomastica__c) || String.isBlank(elem.OF_Indirizzo__c) || String.isBlank(elem.OF_Civico__c);
			// UI_Scala_Palazzina è l'unico campo veramente obbligatorio per PNI
			// Ma il commento su STG_Info_Esecuzione ci vuole per tutti
			if (String.isBlank(elem.OF_UI_Scala_Palazzina__c)) {
				pniElementsList.remove(elem);
				validList.remove(elem.Id);
				elem.isValid__c = false;
				invalidElementsList.add(elem);
				invalidIdScalaList.add(elem.OF_ID_GIS_ScalaPalazzina__c);
			}
			if (blankAnagraficaParams) {
				elem.STG_Info_Esecuzione__c = 'Missing mandatory parameters';
			}
		}

		System.debug('checkMandatoryPNIFields: Found ' + invalidElementsList.size() + ' invalid records from PNI');
		update invalidElementsList;
	}

	private void checkMandatoryGISFields(Map<Id, OF_Staging_PNI__c> validList) {
		List<OF_Staging_PNI__c> invalidElementsList = new List<OF_Staging_PNI__c>();

		for (OF_Staging_PNI__c elem : gisElementsList) {
			Boolean blankAnagraficaParams = String.isBlank(elem.OF_UI_Scala_Palazzina__c) || String.isBlank(elem.OF_Comune__c) || String.isBlank(elem.OF_Particella_Toponomastica__c) || String.isBlank(elem.OF_Indirizzo__c) || String.isBlank(elem.OF_Civico__c);
			if (blankAnagraficaParams || String.isBlank(elem.OF_GIS_OLO__c) || String.isBlank(elem.OF_GIS_Data_Espletamento__c) || String.isBlank(elem.OF_GIS_Codice_Ordine_Olo__c)) {

				gisElementsList.remove(elem);
				validList.remove(elem.Id);
				elem.isValid__c = false;
				elem.STG_Info_Esecuzione__c = 'Missing mandatory parameters';
				invalidElementsList.add(elem);
				if (blankAnagraficaParams) {
					invalidIdScalaList.add(elem.OF_ID_GIS_ScalaPalazzina__c);
				}
			}
		}

		System.debug('checkMandatoryGISFields: Found ' + invalidElementsList.size() + ' invalid records from GIS');

		update invalidElementsList;
	}

	private void checkUniqueConstraints(Map<Id, OF_Staging_PNI__c> stagingList) {
		Map<String, List<OF_Staging_PNI__c>> mapIdScalaToStaging = new Map<String, List<OF_Staging_PNI__c>>();

		for (OF_Staging_PNI__c stagingElem : stagingList.values()) {
			List<OF_Staging_PNI__c> stagingInScala = mapIdScalaToStaging.get(stagingElem.OF_ID_GIS_ScalaPalazzina__c);
			if (stagingInScala == null) {
				stagingInScala = new List<OF_Staging_PNI__c>();
				mapIdScalaToStaging.put(stagingElem.OF_ID_GIS_ScalaPalazzina__c, stagingInScala);
			}
			stagingInScala.add(stagingElem);
		}

		List<OF_Staging_PNI__c> invalidRecords = new List<OF_Staging_PNI__c>();
		for (String idScala : mapIdScalaToStaging.keySet()) {
			Set<OF_Staging_PNI__c> invalidRecordsInScala = null;
			if (invalidIdScalaList.contains(idScala)) {
				System.debug('checkUniqueConstraints: Records in scala ' + idScala + ' are invalid');
				invalidRecordsInScala = invalidateRecordsInScala(mapIdScalaToStaging.get(idScala));

			} else {
				invalidRecordsInScala = checkAndInvalidateRecordsInScala(mapIdScalaToStaging.get(idScala), idScala);
			}
			invalidRecords.addAll(invalidRecordsInScala);
		}

		// Aggiorno la mappa globale degli elementi validi
		for (OF_Staging_PNI__c elem : invalidRecords) {
			stagingList.remove(elem.Id);
		}
		update invalidRecords;
	}

	private Set<OF_Staging_PNI__c> invalidateRecordsInScala(List<OF_Staging_PNI__c> stagingInScala) {
		gisElementsList.removeAll(stagingInScala);
		pniElementsList.removeAll(stagingInScala);

		List<OF_Staging_PNI__c> pniValidList = new List<OF_Staging_PNI__c>();

		for (OF_Staging_PNI__c stagingElem : stagingInScala) {
			String previousComment = String.isBlank(stagingElem.STG_Info_Esecuzione__c) ? '' : stagingElem.STG_Info_Esecuzione__c + ' - ';
			stagingElem.STG_Info_Esecuzione__c = previousComment + 'Every record having this idScala has been marked as invalid due to either missing mandatory parameters or data inconsistency';
			if (String.isNotBlank(previousComment) || !PNI.equals(stagingElem.OF_Source_System__c)) {
				stagingElem.isValid__c = false;
			} else if (PNI.equals(stagingElem.OF_Source_System__c)) {
				// Per PNI vogliono il commento nella colonna STG_Info_Esecuzione__c
				// ma non vogliono che il record sia flaggato come invalido
				pniValidList.add(stagingElem);
			}
		}

		pniElementsList.addAll(pniValidList);
		Set<OF_Staging_PNI__c> invalidElements = new Set<OF_Staging_PNI__c>(stagingInScala);
		invalidElements.removeAll(pniValidList);

		return invalidElements;
	}

	private Set<OF_Staging_PNI__c> checkAndInvalidateRecordsInScala(List<OF_Staging_PNI__c> stagingInScala, String idScala) {
		Set<String> uniqueElements = new Set<String>();
		for (OF_Staging_PNI__c stagingElem : stagingInScala) {
			uniqueElements.add(getUniqueFieldsForScala(stagingElem));
		}

		if (uniqueElements.size() > 1) {
			System.debug('checkAndInvalidateRecordsInScala: Records in scala ' + idScala + ' are invalid');
			return invalidateRecordsInScala(stagingInScala);
		}

		return new Set<OF_Staging_PNI__c>();
	}

	private String getUniqueFieldsForScala(OF_Staging_PNI__c stag) {
		String key = 'ui:' + stag.OF_UI_Scala_Palazzina__c;
		key += '_comune:' + stag.OF_Comune__c;
		key += '_particella:' + stag.OF_Particella_Toponomastica__c;
		key += '_indirizzo:' + stag.OF_Indirizzo__c;
		key += '_civico:' + stag.OF_Civico__c;
		return key.toLowerCase();
	}

	private WrapData buildWrapper(OF_Staging_PNI__c stag, Asset stgAsset) {
		WrapData wrap = new WrapData();
		if (PNI.equalsIgnoreCase(stag.OF_Source_System__c)) {
			if (stgAsset == null) {
				return null;
			}
			wrap.OLO = stgAsset.Account.EOF_Codice_Operatore__c;
			wrap.DataAttivazione = stgAsset.OF_DataAttivazione2__c;
		} else {
			wrap.OLO = stag.OF_GIS_OLO__c;
			wrap.DataAttivazione = Datetime.valueOf(stag.OF_GIS_Data_Espletamento__c);
		}

		wrap.idScala = stag.OF_ID_GIS_ScalaPalazzina__c;
		wrap.stagF = stag;

		return wrap;
	}

	private Map<String, OF_Billing_Element_Verticale__c> getMapIdRisorsaBev(Set<String> idRisorsaList, Set<String> idGisScalaPalazzinaList) {
		List<OF_Billing_Element_Verticale__c> beV_totali = [SELECT id, ID_Risorsa__c, OF_Status__c, OLO__c, Asset_Verticale__c, Asset__c, Update_Billing__c,
															Data_Attivazione__c, Asset_Verticale__r.ID_GIS_Scala_Palazzina__c, Olo__r.name,Asset__r.EOF_Id_Risorsa__c
															FROM OF_Billing_Element_Verticale__c
															WHERE OF_Status__c = 'ATTIVO' AND (ID_Risorsa__c IN :idRisorsaList OR Asset_Verticale__r.ID_GIS_Scala_Palazzina__c IN :idGisScalaPalazzinaList)];

		Map<String, OF_Billing_Element_Verticale__c> mapIdR_Bev = new Map<String, OF_Billing_Element_Verticale__c>();
		for (OF_Billing_Element_Verticale__c bev : beV_totali) {
			mapIdR_Bev.put(bev.ID_Risorsa__c, bev);
		}
		return mapIdR_Bev;
	}

	private void invalidateByDataAttivazione(Map<Id, OF_Staging_PNI__c> stagingMap, Map<String, Asset> mapAssetStd) {

		Set<String> idRisorsaList = new Set<String>();
		Set<String> idScalaPalazzinaSet = new Set<String>();
		List<OF_Staging_PNI__c> stagingList = new List<OF_Staging_PNI__c>(stagingMap.values());
		for (OF_Staging_PNI__c record : stagingList) {
			idRisorsaList.add(record.OF_Id_Risorsa__c);
			idScalaPalazzinaSet.add(record.OF_ID_GIS_ScalaPalazzina__c);
		}

		Map<String, OF_Billing_Element_Verticale__c> mapIdR_Bev = getMapIdRisorsaBev(idRisorsaList, idScalaPalazzinaSet);

		List<OF_Staging_PNI__c> toInvalidate = new List<OF_Staging_PNI__c>();
		Map<String, Map<String, WrapData>> mapIdScalaOlo = new Map<String, Map<String, WrapData>>();

		for (OF_Staging_PNI__c stag : stagingList) {
			Asset stgAsset = mapAssetStd.get(stag.OF_Id_Risorsa__c);
			WrapData wrap = buildWrapper(stag, stgAsset);
			if (wrap != null) {

				Map<String, WrapData> mapOloWrapData = mapIdScalaOlo.get(wrap.idScala);
				if (mapOloWrapData == null) {
					// prima volta che incontro questo idScala
					mapOloWrapData = new Map<String, WrapData>();
					mapOloWrapData.put(wrap.OLO, wrap);
					mapIdScalaOlo.put(wrap.idScala, mapOloWrapData);
				} else {
					// ho già incontrato questo idScala
					WrapData currentOldestElement = mapOloWrapData.get(wrap.OLO);
					if (currentOldestElement == null) {
						// non ho mai incontrato questo OLO
						mapOloWrapData.put(wrap.OLO, wrap);
					} else {
						// ho già incontrato questo OLO
						// verifico che l'elemento conservato nella mappa sia più vecchio di quello che sto esaminando in questa iterazione
						if (currentOldestElement.DataAttivazione > wrap.DataAttivazione) {
							// se è più recente lo invalido solo se dovrebbe essere creato.
							// Gli spostamenti vanno elaborati sempre
							if (!mapIdR_Bev.containsKey(currentOldestElement.stagF.OF_Id_Risorsa__c)) {
								currentOldestElement.stagF.isValid__c = false;
								currentOldestElement.stagF.STG_Info_Esecuzione__c = 'Not the oldest one';
								toInvalidate.add(currentOldestElement.stagF);
								stagingMap.remove(currentOldestElement.stagF.Id);
							}
							// e lo sostituisco nella mappa
							mapOloWrapData.put(wrap.OLO, wrap);
						} else if ((stgAsset == null) || !mapIdR_Bev.containsKey(stag.OF_Id_Risorsa__c)) {
							// se il suo asset deve essere creato, o non c'è un BEV per questo asset
							// è un inserimento, non uno spostamento, quindi
							// invalido il record che sto analizzando in questa iterazione
							stag.isValid__c = false;
							stag.STG_Info_Esecuzione__c = 'Not the oldest one';
							toInvalidate.add(stag);
							stagingMap.remove(stag.Id);
						}
					}
				}
			} else {
				// se non esiste l'asset a cui fa riferimento un elemento di PNI
				stag.isValid__c = false;
				stag.STG_Info_Esecuzione__c = 'There is no Asset with ID_Risorsa [' + stag.OF_Id_Risorsa__c + ']';
				toInvalidate.add(stag);
				stagingMap.remove(stag.Id);
			}
		}

		System.debug('invalidateByDataAttivazione: Found ' + toInvalidate.size() + ' invalid records');
		update toInvalidate;

		/*
		   Decimal contatore = 0;
		   List<OF_Staging_PNI__c> latestStag = [SELECT Id, indice__c FROM OF_Staging_PNI__c WHERE indice__c > 0 ORDER BY indice__c DESC LIMIT 1];
		   if (!latestStag.isEmpty()) {
		    contatore = latestStag.get(0).indice__c;
		   }

		   for (OF_Staging_PNI__c stag : stagingList) {
		    stag.indice__c = contatore++;
		   }
		   update stagingList;
		 */
	}

	private void addInfoToStaging(Map<Id, OF_Staging_PNI__c> stagingMap, Map<String, Asset> mapAssetStd) {
		List<OF_Staging_PNI__c> stgList = stagingMap.values();
		for (OF_Staging_PNI__c s : stgList) {
			if (PNI.equalsIgnoreCase(s.OF_Source_System__c)) {
				Asset a = mapAssetStd.get(s.OF_Id_Risorsa__c);
				s.OF_GIS_Data_Espletamento__c = String.valueOf(a.OF_DataAttivazione2__c);
				s.OF_GIS_OLO__c = a.Account.EOF_Codice_Operatore__c;
			}
		}
		update stgList;
	}

	/**
	 * Checks if a String is not suitable for Asset.EOF_ID_Risorsa__c field.<br>
	 * Examples:<br>
	 * <pre>
	 * isIdRisorsaInvalid(null)      = true
	 * isIdRisorsaInvalid("")        = true
	 * isIdRisorsaInvalid(" ")       = true
	 * isIdRisorsaInvalid("N/A")     = true
	 * isIdRisorsaInvalid("N/D")     = true
	 * isIdRisorsaInvalid(" N/a ")   = true
	 * isIdRisorsaInvalid("n/d ")    = true
	 * isIdRisorsaInvalid("#N/A")    = true
	 * isIdRisorsaInvalid(" #N/D")   = true
	 * isIdRisorsaInvalid("bob")     = false
	 * isIdRisorsaInvalid("  bob  ") = false
	 * </pre>
	 *
	 * @param idRisorsa - the String to check, may be null.
	 *
	 * @return TRUE if idRisorsa matches at least one of the following cases (case-insensitive):
	 * <ul>
	 * <li>null, empty or whitespace only</li>
	 * <li>N/A</li>
	 * <li>#N/A</li>
	 * <li>N/D</li>
	 * <li>#N/D</li>
	 * </ul>
	 */
	public static Boolean isIdRisorsaInvalid(String idRisorsa) {
		if (String.isBlank(idRisorsa)) {
			return true;
		}
		String id = idRisorsa.trim().toUpperCase();
		return OF_Staging_CheckInvalidRecords.invalidIdRisorsaList.contains(id);
	}

	/**
	 * Checks if a String is not suitable for OF_Asset_Verticale__c.ID_GIS_Scala_Palazzina__c field.<br>
	 * Examples:<br>
	 * <pre>
	 * isIdScalaPalazzinaInvalid(null)      = true
	 * isIdScalaPalazzinaInvalid("")        = true
	 * isIdScalaPalazzinaInvalid(" ")       = true
	 * isIdScalaPalazzinaInvalid("N/A")	    = true
	 * isIdScalaPalazzinaInvalid(" N/a ")   = true
	 * isIdScalaPalazzinaInvalid("#N/A")	= true
	 * isIdScalaPalazzinaInvalid("bob")	    = false
	 * isIdScalaPalazzinaInvalid("  bob  ") = false
	 * </pre>
	 *
	 * @param idScalaPalazzina - the String to check, may be null.
	 *
	 * @return TRUE if idRisorsa matches at least one of the following cases (case-insensitive):
	 * <ul>
	 * <li>null, empty or whitespace only</li>
	 * <li>N/A</li>
	 * <li>#N/A</li>
	 * </ul>
	 */
	public static Boolean isIdScalaPalazzinaInvalid(String idScalaPalazzina) {
		if (String.isBlank(idScalaPalazzina)) {
			return true;
		}
		String id = idScalaPalazzina.trim().toUpperCase();
		return OF_Staging_CheckInvalidRecords.invalidIdScalaPalazzinaList.contains(id);
	}
}
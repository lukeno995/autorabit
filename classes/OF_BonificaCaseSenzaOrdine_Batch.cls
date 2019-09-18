global class OF_BonificaCaseSenzaOrdine_Batch implements Database.Batchable<sObject>, Database.Stateful {
	global String query;
	global Map<String, Id> mapRtDevNameRtId;

	global Map<String, String> mapDevNameCaseDevNameOrder = new Map<String, String>{'OF_SA_Cessazione' => 'OF_OUTORDER', 'EOF_Caso_Cessazione' => 'OF_OUTORDER', 'OF_SA_Attivazione' => 'OF_INORDER', 'EOF_Caso_Attivazione' => 'OF_INORDER'};
	global Set<String> devNameOpenStream = new Set<String>{'OF_SA_Attivazione', 'OF_SA_Cessazione'};
	global Set<String> devNameGPON = new Set<String>{'EOF_Caso_Attivazione', 'EOF_Caso_Cessazione'};

	global Set<String> caseStatusForOrderInAperto = new Set<String>{'Acquisito', 'Accettato', 'Sospeso'};
	global Set<String> caseStatusForOrderInChiuso = new Set<String>{'Acquisito KO', 'Accettato KO'};
	global Set<String> caseStatusForOrderInChiusoKO = new Set<String>{'Espletato KO', 'Annullato', 'Accettato KO'};

	global Database.QueryLocator start(Database.BatchableContext BC) {
		mapRtDevNameRtId = new Map<String, Id>(); 
		for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType]) {
			mapRtDevNameRtId.put(rt.DeveloperName, rt.Id);
		}

        BatchBonifiche__c cs = BatchBonifiche__c.getAll().get('BonificaCaseSenzaOrdine');
		Datetime d = System.now().addMinutes(cs.sogliaMinuti__c.intValue());
		query = 'SELECT Id, CaseNumber, AssetId, AccountId, EOF_Account_OLO__c, OF_IDContratto__c, CreatedDate, ClosedDate, RecordType.DeveloperName, Status, '+
				'EOF_Codice_Errore__c,  EOF_Causale_Errore__c, EOF_Codice_Ordine_OLO__c, EOF_Order_Manager__c, OF_Order__c, EOF_Id_Risorsa__c, '+
				'EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, '+
				'OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c, OF_SA_Motivazione__c, '+
				'EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c, EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, '+
				'EOF_Scala_Palazzina_WS__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c '+
				'FROM Case WHERE OF_Order__c = null AND Status != \'Inviato\' '+
				'AND lastModifiedDate < :d '+
				'AND RecordType.DeveloperName IN (\'OF_SA_Attivazione\', \'OF_SA_Cessazione\', \'EOF_Caso_Attivazione\', \'EOF_Caso_Cessazione\') '+
				'ORDER BY CreatedDate DESC';

		System.debug('BonificaCaseSenzaOrdine Query: ' + query);

		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<Case> caseList) {
		System.debug('BonificaCaseSenzaOrdine caseList.size: ' + caseList.size());

		String servizio;
		String tipologiaservizio;
		String recordTypeDevName;
		Map<String, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();

		List<Order> orderToInsert = new List<Order>();
		Map<Id, Order> mapCaseIdOrder = new Map<Id, Order>();
		Map<String, List<Case>> caseDaCessare = new Map<String, List<Case>>();

		for (Case c : caseList) {
			Order o = new Order();
			recordTypeDevName = mapDevNameCaseDevNameOrder.get(c.RecordType.DeveloperName);
			o.RecordTypeId = mapRtDevNameRtId.get(recordTypeDevName);
			if (devNameGPON.contains(c.RecordType.DeveloperName)) {
				servizio = 'GPON Passiva';
				tipologiaservizio = 'Passivo';
			}
			if (devNameOpenStream.contains(c.RecordType.DeveloperName)){
				servizio = 'Open Stream';
				tipologiaservizio = 'Attivo';
			}
			if(c.ClosedDate!=null){
				o.OF_DataEsito__c = Date.valueOf(c.ClosedDate);
			}
			o.accountId=c.EOF_Account_OLO__c;
			o.EffectiveDate = Date.valueOf(c.createdDate);
			o.OF_TipologiaDiServizio__c = tipologiaservizio;

			if ('OF_INORDER'.equalsIgnoreCase(recordTypeDevName)) {

				if (caseStatusForOrderInAperto.contains(c.Status)) {
					o.Status = 'Aperto';
					o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
					o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
				} else if (caseStatusForOrderInChiuso.contains(c.Status)) {
					o.Status = 'Chiuso';
					o.OF_Esito__c = 'KO';
					o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;
					o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c;
				} else {
					if ('Espletato'.equalsIgnoreCase(c.Status)) {
						o.Status = 'Chiuso';
						o.OF_Esito__c = 'OK';
					} else if (caseStatusForOrderInChiusoKO.contains(c.Status)) {
						o.Status = 'Chiuso';
						o.OF_Esito__c = 'KO';
					}
					o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
					o.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
					o.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
					o.OF_Apparato__c = c.EOF_Apparato__c;
					o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
					o.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
					o.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
					o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
					o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
					o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
					o.OF_IDBuilding__c = c.EOF_ID_Building_WS__c;
					o.OF_IdentificativoDelPOP__c = c.EOF_Identificativo_del_POP__c;
					o.OF_Comune__c = c.EOF_Comune_WS__c;
					o.OF_Provincia__c = c.EOF_Provincia_WS__c;
					o.OF_ParticellaToponomastica__c = c.EOF_Particella_Toponomastica_WS__c;
					o.OF_Indirizzo__c = c.EOF_Indirizzo_WS__c;
					o.OF_Civico__c = c.EOF_Numero_Civico_WS__c;
					o.OF_ScalaPalazzina__c = c.EOF_Scala_Palazzina_WS__c;
				}
			} else if('OF_OUTORDER'.equalsIgnoreCase(recordTypeDevName)) {

				if('Cessato KO'.equalsIgnoreCase(c.Status)) {
					o.Status = 'Chiuso';
					o.OF_Esito__c = 'KO';
					o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
					o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
				} else if('Acquisito'.equalsIgnoreCase(c.Status)) {
					o.Status = 'Aperto';
					o.OF_Esito__c = 'OK';
					List<Case> cList = caseDaCessare.get(c.RecordType.DeveloperName);
					if (cList == null) {
						cList = new List<Case>();
						caseDaCessare.put(c.RecordType.DeveloperName, cList);
					}
					cList.add(c);
				}
				
				o.OF_Asset__c = c.assetId;
				o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
				o.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
				o.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
				o.OF_Apparato__c = c.EOF_Apparato__c;
				o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
				o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
				o.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
				o.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
				if('Cessato'.equalsIgnoreCase(c.Status) || 'Cessato OK'.equalsIgnoreCase(c.Status)) {
					o.Status = 'Chiuso';
					o.OF_Esito__c = 'OK';
				}
			}

			if(c.OF_IDContratto__c != null){
				o.ContractId = c.OF_IDContratto__c;
			}
			o.OF_CaseID__c = c.Id;
			o.OF_CaseNome__c = c.CaseNumber;
			o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
			o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
			o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
			if(String.isNotBlank(c.OF_SA_Profilo__c)){
				if(mapCodifica.containsKey(c.OF_SA_Profilo__c)){
					o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
				}
			}
			o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
			o.OF_Promozione__c = c.OF_SA_Promozione__c ;
			o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
			o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;

			orderToInsert.add(o);
			mapCaseIdOrder.put(c.id, o);
		}

		if(!orderToInsert.isEmpty()) {
			System.debug('BonificaCaseSenzaOrdine orderToInsert.size(): ' + orderToInsert.size());
			insert orderToInsert;
		}

		// AGGIORNAMENTO ORDER SUL CASE
		for (Case c : caseList) {
			c.OF_Order__c = mapCaseIdOrder.get(c.id).id;
			c.OF_Servizio__c = servizio;
		}

		if (!caseList.isEmpty()) {
			update caseList;
		}

		for (String devName : caseDaCessare.keySet()) {
			System.debug('Cesso i Case ' + devName);
			List<Case> cList = caseDaCessare.get(devName);
			if (!cList.isEmpty() && !Test.isRunningTest()) {
				OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(cList.get(0));
				esplManager.cessazioneBeiGPONP_OpenStream(cList);
			}
		}
	}

	global void finish(Database.BatchableContext BC) {
		
	}
}
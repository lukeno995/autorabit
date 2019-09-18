public class OF_UtilitiesManageOrderFromCase {

	private String IDContratto {get; set;}

	public string getIDContratto() {
		return this.IDContratto;
	}

	//DG stringa che serve per popolare il campo codiceKO
	private String strCodice {get; set;}
	private String strDescr {get; set;}

	public string getstrCodice() {

		return this.strCodice;

	}
	public string getstrDescr() {

		return this.strDescr;

	}

	//START DG contratto
	public void setIDContratto(string s) {
		IDContratto = s;
		//system.debug('DG_OF_UtilitiesManageOrderFromCase - IDContratto: ' + IDContratto);
	}
	//END DG contratto

	//Start DG switch tra case riferiti a servizi attivi e case riferiti a servizi passivi in base al recordtype del case
	//EOF Caso - Attivazione == Servizi Passivi
	//EOF_Caso_Attivazione_OPENSTREAM == Servizi Attivi
	public string TipoServ(case c) {

		if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('OF_SA_Attivazione')) || (c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('OF_SA_Cessazione'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro attivo');
			c.OF_Servizio__c = 'Open Stream';
			return 'Attivo';
		}
		else if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('EOF_Caso_Attivazione')) || (c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('EOF_Caso_Cessazione'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
			c.OF_Servizio__c = 'GPON Passiva';
			return 'Passivo';
		}
		else if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_P2P_Attiva'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
			c.OF_Servizio__c = 'P2P Attiva';
			return 'P2PAttiva';
		}
		else if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_Fiber_Lease'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
			c.OF_Servizio__c = 'Fiber Lease';
			return 'FiberLease';
		}
		else if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_Fiber_Link'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
			c.OF_Servizio__c = 'Fiber Link';
			return 'Fiber Link';
		}
		else if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_IRU'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
			c.OF_Servizio__c = 'IRU';
			return 'IRU';
		}
		else if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_Misto_Fiber_Lease_Link_per_Fastweb'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
			c.OF_Servizio__c = 'Misto Fiber Lease Link Fastweb';
			return 'MistoFiberLeaseLinkFastweb';
		}
		else if ((c.recordtypeId == OF_Utility.getRT_DevNameId_Map().get('PO_Ordine_P2P'))) {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
			c.OF_Servizio__c = 'P2P Base';
			return 'P2PBase';
		}
		return null;
	}

	//26/10/2017 - Metodo vecchio che restituisce un booleano
	public boolean VerificheCommContratt(case c) {

		try {
			//se check = true   --> le verifiche sono passate
			//se check = false  --> le verifiche non sono passate
			boolean check = true;

			map<id, Contract> ContractMap = new map<id, contract> ([select id, Status, StartDate, EndDate, AccountId, OF_IdContratto__c from contract where AccountId =: c.EOF_Account_OLO__c]);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - ContractMap.size(): ' + ContractMap.size() + '-----ContractMap: ' + ContractMap);

			map<id, OF_ContrattoServizio__c> ContrattoServizioMap = new map<id, OF_ContrattoServizio__c>([select id, OF_servizio__c, OF_servizio__r.name, OF_Contract__c from OF_ContrattoServizio__c where OF_Contract__c IN: ContractMap.keyset()]);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - ContrattoServizioMap.size(): ' + ContrattoServizioMap.size() + '-----ContrattoServizioMap: ' + ContrattoServizioMap );

			//DG è presente solo una network inventory per ID Building
			list<EOF_Network_Inventory__c> NetwInvList = new list<EOF_Network_Inventory__c> ([select id, EOF_Comune__c, EOF_ID_Building__c, EOF_Pop__c, EOF_Provincia__c, EOF_Particella_Top__c, EOF_Indirizzo__c, EOF_Civico__c, EOF_Scala_Palazzina__c from EOF_Network_Inventory__c where EOF_ID_Building__c =: c.EOF_ID_Building_WS__c limit 1]);
			//system.debug ('DG_OF_UtilitiesManageOrderFromCase - NetwInvList: ' + NetwInvList);

			//DG è presente solo una network inventory per ID Building
			list<OF_SA_Network_Inventory_Attivi__c> NetwInvListAttivi = new list<OF_SA_Network_Inventory_Attivi__c> ([select id, OF_SA_ID_Building__c, OF_SA_Comune__c from OF_SA_Network_Inventory_Attivi__c where OF_SA_ID_Building__c =: c.EOF_ID_Building_WS__c limit 1]);
			//system.debug ('DG_OF_UtilitiesManageOrderFromCase - NetwInvListAttivi: ' + NetwInvListAttivi);

			list<OF_AreaGeograficaJunction__c> AreaGeoList = new list<OF_AreaGeograficaJunction__c>([select id, Servizio__c, Servizio__r.name, OF_AreaGeografica__r.OF_Istat__c, OF_Contratto__c from OF_AreaGeograficaJunction__c where OF_Contratto__r.AccountId =: c.EOF_Account_OLO__c]);
			//system.debug ('DG_OF_UtilitiesManageOrderFromCase - AreaGeoListSize.size(): ' + AreaGeoList.size() + '-----AreaGeoList: ' + AreaGeoList);

			Map <string, OF_CaseOrderStateModelCS__c> mapCaseOrder = OF_CaseOrderStateModelCS__c.getAll();
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - mapCaseOrder: ' + mapCaseOrder);

			boolean check1 = false;
			boolean check2 = false;
			system.debug('DG_OF_UtilitiesManageOrderFromCase.VerificheCommContratt - ContrattoServizioMap.size(): ' + ContrattoServizioMap.size());

			if (ContrattoServizioMap.size() > 0) {

				string serviz = TipoServ(c);
				system.debug('DG_OF_UtilitiesManageOrderFromCase.VerificheCommContratt - serviz: ' + serviz);

				for (id contrID : ContractMap.keyset()) {
					//18/05/2017 Aggiunta la logica per distinguere se il servizio richiesto è attivo o passivo
					//Passivo --> Verifica_BK17
					//Attivo --> Verifica_B05
					System.debug('serviz: ' + serviz);
					if (serviz == 'Passivo') {
						check1 = Verifica_BK17(ContractMap.get(contrID), c, ContrattoServizioMap);
					}else if (serviz == 'Attivo') {
						check1 = Verifica_B05(ContractMap.get(contrID), c, ContrattoServizioMap);
					}

					//system.debug('DG_OF_UtilitiesManageOrderFromCase - check1: ' + check1);

					if ( (check1 == true) && (AreaGeoList.size() > 0)) {

						//18/05/2017 Aggiunta la logica per distinguere se il servizio richiesto è attivo o passivo
						//Passivo --> Verifica_BK16
						//Attivo --> Verifica_B04

						System.debug('NetwInvList.size: ' + NetwInvList.size());
						System.debug('NetwInvListAttivi.size: ' + NetwInvListAttivi.size());
						if ( (serviz == 'Passivo') && (NetwInvList.size() > 0) ) {
							check2 = Verifica_BK16(ContractMap.get(contrID), c, NetwInvList[0], AreaGeoList);
						}else if ((serviz == 'Attivo') && (NetwInvListAttivi.size() > 0)) {
							check2 = Verifica_B04(ContractMap.get(contrID), c, NetwInvListAttivi[0], AreaGeoList);
						}

						//system.debug('DG_OF_UtilitiesManageOrderFromCase - check2: ' + check2);

						//Se check = true allora ho passato sia le verifiche BK17/B05 sia le BK16/B04
						//Allora ho trovato il contratto giusto e lo memorizzo
						if (check2 == true) {
							//system.debug('DG_OF_UtilitiesManageOrderFromCase - Verifiche B_K16');
							setIDContratto(ContractMap.get(contrID).id);
							break;
						}
					}
				}

				if (!check2) {
					//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro creazione ordine KO');
					CreateOrderKO(c, mapCaseOrder.get('0014'));
					check = false;
				}

			}

			//system.debug('DG_OF_UtilitiesManageOrderFromCase - check: '+ check);
			return check;

		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method: VerificheCommContratt','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}

	//26/10/2017 - Modificato il nome del metodo nuovo che restuituisce una stringa
	public String VerificheCommContratt1(case c) {

		try {
			//se check = true   --> le verifiche sono passate
			//se check = false  --> le verifiche non sono passate
			boolean check = true;

			map<id, Contract> ContractMap = new map<id, contract> ([select id, Status, StartDate, EndDate, AccountId, OF_IdContratto__c from contract where AccountId =: c.EOF_Account_OLO__c]);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - ContractMap.size(): ' + ContractMap.size() + '-----ContractMap: ' + ContractMap);

			map<id, OF_ContrattoServizio__c> ContrattoServizioMap = new map<id, OF_ContrattoServizio__c>([select id, OF_servizio__c, OF_servizio__r.name, OF_Contract__c from OF_ContrattoServizio__c where OF_Contract__c IN: ContractMap.keyset()]);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - ContrattoServizioMap.size(): ' + ContrattoServizioMap.size() + '-----ContrattoServizioMap: ' + ContrattoServizioMap );

			//DG è presente solo una network inventory per ID Building
			list<EOF_Network_Inventory__c> NetwInvList = new list<EOF_Network_Inventory__c> ([select id, EOF_Comune__c, EOF_ID_Building__c, EOF_Pop__c, EOF_Provincia__c, EOF_Particella_Top__c, EOF_Indirizzo__c, EOF_Civico__c, EOF_Scala_Palazzina__c from EOF_Network_Inventory__c where EOF_ID_Building__c =: c.EOF_ID_Building_WS__c limit 1]);
			//system.debug ('DG_OF_UtilitiesManageOrderFromCase - NetwInvList: ' + NetwInvList);

			//DG è presente solo una network inventory per ID Building
			list<OF_SA_Network_Inventory_Attivi__c> NetwInvListAttivi = new list<OF_SA_Network_Inventory_Attivi__c> ([select id, OF_SA_ID_Building__c, OF_SA_Comune__c from OF_SA_Network_Inventory_Attivi__c where OF_SA_ID_Building__c =: c.EOF_ID_Building_WS__c limit 1]);
			//system.debug ('DG_OF_UtilitiesManageOrderFromCase - NetwInvListAttivi: ' + NetwInvListAttivi);

			list<OF_AreaGeograficaJunction__c> AreaGeoList = new list<OF_AreaGeograficaJunction__c>([select id, Servizio__c, Servizio__r.name, OF_AreaGeografica__r.OF_Istat__c, OF_Contratto__c from OF_AreaGeograficaJunction__c where OF_Contratto__r.AccountId =: c.EOF_Account_OLO__c]);
			//system.debug ('DG_OF_UtilitiesManageOrderFromCase - AreaGeoListSize.size(): ' + AreaGeoList.size() + '-----AreaGeoList: ' + AreaGeoList);

			Map <string, OF_CaseOrderStateModelCS__c> mapCaseOrder = OF_CaseOrderStateModelCS__c.getAll();
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - mapCaseOrder: ' + mapCaseOrder);

			boolean check1 = false;
			boolean check2 = false;
			string serviz = TipoServ(c);
			if (ContrattoServizioMap.size() > 0) {


				system.debug('DG_OF_UtilitiesManageOrderFromCase - serviz: ' + serviz);

				for (id contrID : ContractMap.keyset()) {
					//18/05/2017 Aggiunta la logica per distinguere se il servizio richiesto è attivo o passivo
					//Passivo --> Verifica_BK17
					//Attivo --> Verifica_B05
					if (serviz == 'Passivo') {
						check1 = Verifica_BK17(ContractMap.get(contrID), c, ContrattoServizioMap);
					}else
					if (serviz == 'Attivo') {
						check1 = Verifica_B05(ContractMap.get(contrID), c, ContrattoServizioMap);
					}

					system.debug('DG_OF_UtilitiesManageOrderFromCase - check1: ' + check1);

					if ( (check1 == true) && (AreaGeoList.size() > 0)) {

						//18/05/2017 Aggiunta la logica per distinguere se il servizio richiesto è attivo o passivo
						//Passivo --> Verifica_BK16
						//Attivo --> Verifica_B04
						system.debug('DG_OF_UtilitiesManageOrderFromCase - NetwInvListAttivi.size(): ' + NetwInvListAttivi.size());
						if ( (serviz == 'Passivo') && (NetwInvList.size() > 0) ) {
							check2 = Verifica_BK16(ContractMap.get(contrID), c, NetwInvList[0], AreaGeoList);
						}else
						if ((serviz == 'Attivo') && (NetwInvListAttivi.size() > 0)) {
							check2 = Verifica_B04(ContractMap.get(contrID), c, NetwInvListAttivi[0], AreaGeoList);
						}

						system.debug('DG_OF_UtilitiesManageOrderFromCase - check2: ' + check2);

						//Se check = true allora ho passato sia le verifiche BK17/B05 sia le BK16/B04
						//Allora ho trovato il contratto giusto e lo memorizzo
						if (check2 == true) {
							//system.debug('DG_OF_UtilitiesManageOrderFromCase - Verifiche B_K16');
							setIDContratto(ContractMap.get(contrID).id);
							break;
						}
					}
				}
				if (check1 == false)
				{
					if (serviz == 'Passivo') {return 'BK_17';}
					if (serviz == 'Attivo') {return 'B_05';}
				}
				if ((check1 == true) && (check2 == false))
				{
					if (serviz == 'Passivo') {return 'BK_16';}
					if (serviz == 'Attivo') {return 'B_04';}
				}
				/*
				   if((check1 == false) || (check1 == true) && (check2 == false)){
				    //system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro creazione ordine KO');
				    //CreateOrderKO(c, mapCaseOrder.get('0014'));
				    check = false;
				   }
				 */
				return 'Verifiche OK';

			}
			else{
				if (serviz == 'Passivo') {return 'BK_17';}
				if (serviz == 'Attivo') {return 'B_05';}
				return null;
			}

		}
		catch (Exception e) {
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method: VerificheCommContratt','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}

	//DG creazione ordine KO per verifiche contrattuali e commerciali
	public void CreateOrderKO(case c, OF_CaseOrderStateModelCS__c CSCaseOrder) {
		try {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - verifica esistenza contratto non passate - getstrCodice(): ' + getstrCodice() + '-----getstrDescr(): ' + getstrDescr());

			order o = new order();
			o.RecordTypeId = CSCaseOrder.OF_RecordTypeOrder__c;
			o.AccountId = c.EOF_Account_OLO__c;
			o.status = CSCaseOrder.OF_StatoOrder__c;
			o.OF_Esito__c = CSCaseOrder.OF_EsitoOrder__c;

			if (CSCaseOrder.OF_EsitoOrder__c != null) {
				o.OF_DataEsito__c = system.Today();
			}

			/*05/05/2017 DG - OF_DescrizioneKO__c verrà popolata
			   dal trigger OF_NotifyKO andandola a prendere dalla notifica di acquisizione KO*/
			o.OF_CodiceKO__c = getstrCodice();
			//DG 01/06/2017 aggiunta la descrizione per i servizi attivi
			o.OF_DescrizioneKO__c = getstrDescr();
			//END 01/06/2017
			o.EffectiveDate = Date.Today();
			o.OF_CaseID__c = c.id;
			o.OF_CaseNome__c = c.casenumber;
			o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
			//05/05/2017 DG con la nuova gestione delle verifiche commerciali e contrattuali il campo formula Codice_Ordine_EOF__c non è ancora popolato, replico la formula a codice
			//o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
			if (c.EOF_Order_Manager__c == true) {
				o.OF_IDOrdineEOF__c = c.id;
			}
			else{
				o.OF_IDOrdineEOF__c = String.valueOf(c.Id).substring(0, 15);
			}

			o.OF_TipologiaDiServizio__c = TipoServ(c);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - o: ' + o);
			insert o;
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - dopo insert ordine KO');
			c.OF_Order__c = o.id;
			//DG 01/06/2017 aggiunti i campi motivazione e codice motivazione sul case
			c.OF_SA_Motivazione__c = getstrDescr();
			c.OF_SA_Codice_Motivazione__c = getstrCodice();
			//END 01/06/2017

		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method: CreateOrderKO','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return;
		}


	}
	//DG creazione ordine
	public order CreateOrder(case c, OF_CaseOrderStateModelCS__c CSCaseOrder, Map <string, OF_CodificaProfiloListini__c> mapCodifica) {
		try {
			order o = new order();
			o.RecordTypeId = CSCaseOrder.OF_RecordTypeOrder__c;
			o.AccountId = c.EOF_Account_OLO__c;
			o.status = CSCaseOrder.OF_StatoOrder__c;
			o.OF_Esito__c = CSCaseOrder.OF_EsitoOrder__c;

			if (CSCaseOrder.OF_EsitoOrder__c != null)
			{
				o.OF_DataEsito__c = system.Today();
				//DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
				o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
				o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
				//END DG 01/06/2017
			}

			o.EffectiveDate = system.Today();
			o.OF_CaseID__c = c.id;

			//system.debug('DG_OF_UtilitiesManageOrderFromCase - c.OF_IDContratto__c: ' + c.OF_IDContratto__c);
			if (c.OF_IDContratto__c != null) {
				o.ContractId = c.OF_IDContratto__c;
			}


			o.OF_CaseNome__c = c.casenumber;
			o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
			o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
			o.OF_TipologiaDiServizio__c = TipoServ(c);

			//06/06/2017 aggiunto campo
			o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
			//END 06/06/2017

			//START - Campi da considerare solo in cessazione
			if (CSCaseOrder.OF_TipologiaFlusso__c == 'Cessazione') {
				o.OF_Asset__c = c.assetId;
				o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
				o.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
				o.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
				o.OF_Apparato__c = c.EOF_Apparato__c;
				//DG 25/05/2017 modificato il campo da cui prendere OF_EsitoConsegnaApparato__c
				//  non più da EOF_Tipo_di_intervento_aggiuntivo__c ma da OF_Esito_Consegna_Apparato__c
				o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
				o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
				o.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
				o.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
				//END DG 25/05/2017
				//31/05/2017 aggiunti campi da passare all'asset
				//14/07/2017 modificata logica OF_profilo__c --> viene fatta una codifica presente nel custom setting OF_CodificaProfiloListini__c
				if (c.OF_SA_Profilo__c != null)
				{
					//27/09/2017 Modifica CRM - nel custom setting OF_CodificaProfiloListini__c viene scritto tutto il profilo e non solo le prime due lettere
					//o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c.substring(0,2)).OF_Profilolistino__c;
					if (mapCodifica.get(c.OF_SA_Profilo__c) != null) {
						o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
					}
				}
				//OF_ProfiloOpenStream__c viene utilizzato per popolare sull'asset il campo OF_ProfiloOpenStream__c preso dal case
				o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
				o.OF_Promozione__c = c.OF_SA_Promozione__c;
				o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c;
				o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
				//END DG 31/05/2017
			}
			//END
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - o: ' + o);
			return o;
		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method: CreateOrder','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}
	public static void AggiornoOrdine(case c, order o1, OF_CaseOrderStateModelCS__c CSCaseOrder, Map <string, OF_CodificaProfiloListini__c> mapCodifica) {
		try {
			o1.status = CSCaseOrder.OF_StatoOrder__c;
			o1.OF_Esito__c = CSCaseOrder.OF_EsitoOrder__c;

			if (CSCaseOrder.OF_EsitoOrder__c != null) {
				o1.OF_DataEsito__c = system.Today();
			}

			//DG aggiunti campi sull'ordine per poterli gestire a livello di asset (non saranno visibili sull'ordine)
			o1.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
			o1.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
			o1.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
			o1.OF_Apparato__c = c.EOF_Apparato__c;
			o1.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
			o1.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
			o1.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
			//31/05/2017 aggiunti campi da passare all'asset
			//14/07/2017 modificata logica OF_profilo__c --> viene fatta una codifica presente nel custom setting OF_CodificaProfiloListini__c
			if (c.OF_SA_Profilo__c != null)
			{
				//27/09/2017 Modifica CRM - nel custom setting OF_CodificaProfiloListini__c viene scritto tutto il profilo e non solo le prime due lettere
				//o1.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c.substring(0,2)).OF_Profilolistino__c;
				if (mapCodifica.get(c.OF_SA_Profilo__c) != null) {
					o1.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
				}
			}
			//OF_ProfiloOpenStream__c viene utilizzato per popolare sull'asset il campo OF_ProfiloOpenStream__c preso dal case
			o1.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
			o1.OF_Promozione__c = c.OF_SA_Promozione__c;
			o1.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c;
			o1.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
			//END DG 31/05/2017

			//DG 25/05/2017 modificato il campo da cui prendere OF_EsitoConsegnaApparato__c
			//  non più da EOF_Tipo_di_intervento_aggiuntivo__c ma da OF_Esito_Consegna_Apparato__c
			o1.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
			//END DG 25/05/2017

			//DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
			o1.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
			o1.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
			//END DG 01/06/2017

			//DG 23/03/2017 - Come emerso da riunione odierna i campi vanno presi dal case e non dalla network inventory
			o1.OF_IDBuilding__c = c.EOF_ID_Building_WS__c;
			o1.OF_IdentificativoDelPOP__c = c.EOF_Identificativo_del_POP__c;
			o1.OF_Comune__c = c.EOF_Comune_WS__c;
			o1.OF_Provincia__c = c.EOF_Provincia_WS__c;
			o1.OF_ParticellaToponomastica__c = c.EOF_Particella_Toponomastica_WS__c;
			o1.OF_Indirizzo__c = c.EOF_Indirizzo_WS__c;
			o1.OF_Civico__c = c.EOF_Numero_Civico_WS__c;
			o1.OF_ScalaPalazzina__c = c.EOF_Scala_Palazzina_WS__c;

			/* 12/07/2017 PO */
			o1.PO_Attenuazione__c = c.PO_Attenuazione__c;
			o1.PO_LunghezzaOttica__c = c.PO_Lunghezza_Ottica__c;
			o1.PO_PosizioneRilascioCircuitoOSU__c = c.PO_Posizione_Rilascio_Circuito_OSU__c;
			if (c.PO_Data_Attivazione_Ordine__c != null)
			{
				string str = c.PO_Data_Attivazione_Ordine__c + ' 00:00:00';
				o1.PO_DataAttivazioneOrdine__c = datetime.valueOf(str);
			}

		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method: AggiornoOrdine','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return;
		}
	}
	/*
	   public static order CreateOrdine_Kit_P2PAttiva(Case c){
	    //faccio il check se c'è il kit o se è gia stato assettizzato
	    if(!String.isBlank(c.PO_KIT_Consegna_VLAN__c)){
	        Case caseKit=[select id,assetId,accountId from case where id=:c.PO_KIT_Consegna_VLAN__c];
	        if(String.isBlank(caseKit.assetId)){
	            Order o=new Order();
	            o.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('PO_Asset_P2P_Attiva_KIT');
	            o.accountId=c.accountId;
	            insert o;
	            return o;
	        }
	    }
	    return null;
	   }
	 */
	public void SetKO_BK17() {
		//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro SetKO_BK17');
		strCodice = 'B_K17';
	}
	//Metodo che ricevuti un case e un contract mi restituisce true se le verifiche sono passate e false se non sono passate
	//Servizi Passivi
	public boolean Verifica_BK17(contract contr, case ca, map<id, OF_ContrattoServizio__c> ContrServMap) {
		try {
			boolean CheckEsistenza = false;

			SetKO_BK17();

			//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro le verifiche contratto');

			//system.debug('DG_OF_UtilitiesManageOrderFromCase.Verifica_BK17 - contr.Status: ' + contr.Status);
			if (contr.Status == 'Attivo') {
				CheckEsistenza = true;
			}
			else{
				CheckEsistenza = false;
				return CheckEsistenza;
			}

			//system.debug('DG_OF_UtilitiesManageOrderFromCase.Verifica_BK17 - contr.StartDate: ' + contr.StartDate);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase.Verifica_BK17 - contr.EndDate: ' + contr.EndDate);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase.Verifica_BK17 - ca.EOF_Data_Prevista_Attivazione__c: ' + ca.EOF_Data_Prevista_Attivazione__c);
			if ( (ca.EOF_Data_Prevista_Attivazione__c >= contr.StartDate) && (ca.EOF_Data_Prevista_Attivazione__c <= contr.EndDate) ) {
				CheckEsistenza = true;
			}
			else{
				CheckEsistenza = false;
				return CheckEsistenza;
			}

			//system.debug('DG_OF_UtilitiesManageOrderFromCase.Verifica_BK17 - ca.EOF_Account_OLO__c: ' + ca.EOF_Account_OLO__c);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase.Verifica_BK17 - contr.AccountId: ' + contr.AccountId);
			if (ca.EOF_Account_OLO__c == contr.AccountId) {
				CheckEsistenza = true;
			}
			else{
				CheckEsistenza = false;
				return CheckEsistenza;
			}

			system.debug('DG_OF_UtilitiesManageOrderFromCase.Verifica_BK17 - ContrServMap.size(): ' + ContrServMap.size() + '-----ContrServMap: ' + ContrServMap);
			for (id contID: ContrServMap.keySet()) {
				//DG 17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - ContrServMap.get(contID): ' + ContrServMap.get(contID));

				//system.debug('DG_OF_UtilitiesManageOrderFromCase - ContrServMap.get(contID).OF_Servizio__r.name: ' + ContrServMap.get(contID).OF_Servizio__r.name);

				if (( ContrServMap.get(contID).OF_Servizio__r.name == 'GPON Passiva') && ( ContrServMap.get(contID).OF_Contract__c == contr.id) ) {
					CheckEsistenza = true;
					break;
				}
				else{
					//system.debug('DG_OF_UtilitiesManageOrderFromCase - Servizio no GPON Passiva');
					CheckEsistenza = false;
				}
			}
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - CheckEsistenza: ' + CheckEsistenza);

			//system.debug('DG_OF_UtilitiesManageOrderFromCase - verifica esistenza contratto andata a buon fine. CheckEsistenza: ' + CheckEsistenza);
			return CheckEsistenza;
		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:Verifica_BK17','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}

	}

	public void SetKO_BK16() {
		//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro SetKO_BK16');
		strCodice = 'B_K16';
	}
	//Metodo che ricevuti un case e un contract mi restituisce true se le verifiche sono passate e false se non sono passate
	//Servizi Passivi
	public boolean Verifica_BK16(contract contr, case ca, EOF_Network_Inventory__c NI, list<OF_AreaGeograficaJunction__c> AreaGeo) {
		boolean CheckCitta = false;
		try {
			SetKO_BK16();
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro le verifiche città');
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - AreaGeo.size(): ' + AreaGeo.size());
			if (AreaGeo != null) {
				for (OF_AreaGeograficaJunction__c AGJ: AreaGeo) {
					//Parto dall'Id building che trovo sul case e mi vado a ricercare il comune corrispondente!!!
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - contr.id: ' + contr.id);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - AGJ.OF_Contratto__c: ' + AGJ.OF_Contratto__c);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - AGJ.OF_AreaGeografica__r.OF_Istat__c: ' + AGJ.OF_AreaGeografica__r.OF_Istat__c);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - NI.EOF_Comune__c: ' + NI.EOF_Comune__c);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - AGJ.Servizio__r.name: ' + AGJ.Servizio__r.name);
					//DG 17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.
					if ( (contr.id == AGJ.OF_Contratto__c) && (NI.EOF_Comune__c == AGJ.OF_AreaGeografica__r.OF_Istat__c) && (AGJ.Servizio__r.name == 'GPON Passiva') ) {
						CheckCitta = true;
						//system.debug('DG_OF_UtilitiesManageOrderFromCase - check città = true');
						break;
					}
				}
			}
			//system.debug('DG_OF_UtilitiesManageOrderFromCase - verifica esistenza città andata a buon fine. CheckCitta: ' + CheckCitta);

		} catch (Exception e) {
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:Verifica_BK16','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			CheckCitta = null;
		}
		return CheckCitta;
	}

	/* SERVIZI ATTIVI */
	public void SetKO_B05() {
		// system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro SetKO_B05');
		strCodice = 'B_05';
		strDescr = 'OLO non abilitato all\'invio dell\'ordine';
	}
	// Metodo che ricevuti un case e un contract mi restituisce true se le verifiche sono passate e false se non sono passate
	// Servizi Attivi
	public boolean Verifica_B05(contract contr, case ca, map<id, OF_ContrattoServizio__c> ContrServMap) {
		try {
			boolean CheckEsistenza = false;

			SetKO_B05();

			// system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro le verifiche contratto');

			// system.debug('DG_OF_UtilitiesManageOrderFromCase - contr.Status: ' + contr.Status);
			if (contr.Status == 'Attivo') {
				CheckEsistenza = true;
			}
			else{
				CheckEsistenza = false;
				return CheckEsistenza;
			}
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - contr.StartDate: ' + contr.StartDate);
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - contr.EndDate: ' + contr.EndDate);
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - ca.EOF_Data_Prevista_Attivazione__c: ' + ca.EOF_Data_Prevista_Attivazione__c);
			if ( (ca.EOF_Data_Prevista_Attivazione__c >= contr.StartDate) && (ca.EOF_Data_Prevista_Attivazione__c <= contr.EndDate) ) {
				CheckEsistenza = true;
			}
			else{
				CheckEsistenza = false;
				return CheckEsistenza;
			}

			// system.debug('DG_OF_UtilitiesManageOrderFromCase - ca.EOF_Account_OLO__c: ' + ca.EOF_Account_OLO__c);
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - contr.AccountId: ' + contr.AccountId);
			if (ca.EOF_Account_OLO__c == contr.AccountId) {
				CheckEsistenza = true;
			}
			else{
				CheckEsistenza = false;
				return CheckEsistenza;
			}

			// system.debug('DG_OF_UtilitiesManageOrderFromCase - ContrServMap.size(): ' + ContrServMap.size() + '-----ContrServMap: ' + ContrServMap);
			for (id contID: ContrServMap.keySet()) {
				//DG 17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.
				// system.debug('DG_OF_UtilitiesManageOrderFromCase - ContrServMap.get(contID): ' + ContrServMap.get(contID));

				if (( ContrServMap.get(contID).OF_Servizio__r.name == 'Open Stream') && ( ContrServMap.get(contID).OF_Contract__c == contr.id) ) {
					CheckEsistenza = true;
					break;
				} else {
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - Servizio no Open Stream');
					CheckEsistenza = false;
				}
			}
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - CheckEsistenza: ' + CheckEsistenza);
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - verifica esistenza contratto andata a buon fine. CheckEsistenza: ' + CheckEsistenza);
			return CheckEsistenza;
		} catch (Exception e) {
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:Verifica_B05','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}

	}

	public void SetKO_B04() {
		//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro SetKO_B04');
		strCodice = 'B_04';
		strDescr = 'Città/POP non vendibile per l\'OLO';
	}
	//Metodo che ricevuti un case e un contract mi restituisce true se le verifiche sono passate e false se non sono passate
	//Servizi Attivi
	public boolean Verifica_B04(contract contr, case ca, OF_SA_Network_Inventory_Attivi__c NI, list<OF_AreaGeograficaJunction__c> AreaGeo) {
		boolean CheckCitta = false;
		try {
			// system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro le verifiche città');
			SetKO_B04();
			if (AreaGeo != null) {
				for (OF_AreaGeograficaJunction__c AGJ: AreaGeo) {
					//Parto dall'Id building che trovo sul case e mi vado a ricercare il comune corrispondente!!!
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - contr.id: ' + contr.id);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - AGJ.OF_Contratto__c: ' + AGJ.OF_Contratto__c);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - AGJ.OF_AreaGeografica__r.OF_Istat__c: ' + AGJ.OF_AreaGeografica__r.OF_Istat__c);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - NI.OF_SA_Comune__c: ' + NI.OF_SA_Comune__c);
					// system.debug('DG_OF_UtilitiesManageOrderFromCase - AGJ.Servizio__r.name: ' + AGJ.Servizio__r.name);

					//DG 17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.
					if ((contr.id == AGJ.OF_Contratto__c) && (NI.OF_SA_Comune__c == AGJ.OF_AreaGeografica__r.OF_Istat__c) && (AGJ.Servizio__r.name == 'Open Stream')) {
						CheckCitta = true;
						break;
					}
				}
			}

			// system.debug('DG_OF_UtilitiesManageOrderFromCase - verifica esistenza città andata a buon fine. CheckCitta: ' + CheckCitta);
		} catch (Exception e) {
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:Verifica_B04','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			CheckCitta = null;
		}
		return CheckCitta;
	}

	public void DateAssetCEBE (set<id> idcases) {
		try {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase dentro DateAssetCEBE');
			set<id> AssetID = new set<id>();
			list<case> caseList = new list<case>();
			list<case> cases = new list<case>([Select id, assetid, OF_Servizio__c, (select id, Caso__r.AssetId, Caso__r.Asset.OF_DataAttivazione2__c, OF_SA_Direzione_Flusso__c, OF_SA_Metodo__c, recordtype.name, EOF_Data_Espletamento_Ordine__c, LastModifiedDate, EOF_Data_Notifica__c from EAI_Service_Logs1__r)from case where id IN: idcases]);

			for (Case cas : cases)
			{

				if ((cas.OF_Servizio__c == 'Open Stream') && (cas.Assetid != null)) {
					AssetID.add(cas.Assetid);
					caseList.add(cas);
				}
			}

			//Scatta solo se siamo in Open Stream e se l'asset è presente sul case
			if ((caseList.size() > 0) && (caseList != null))
			{
				//Start preparazione dati
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - AssetID: ' + AssetID);

				//Selezione tutti gli asset, CE e BE istanziati per i case che mi arrivano
				map<id,Asset> assetsMap = new map<id,Asset>([select id, OF_DataAttivazione2__c, OF_DataCessazione2__c, status, (select id,OF_DataAttivazione__c, OF_DataCessazione__c, OF_Asset__c from Commercial_element_istanziati__r ), (select id,OF_DataAttivazione2__c, OF_DataCessazione2__c, OF_Asset__c, IsActive from Price_Book_Entries__r) from asset where id IN: AssetID]);
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - assetsMap: ' + assetsMap);

				map<id,List<OF_CommercialElementIstanziato__c>> assetsCEMap = new map<id,List<OF_CommercialElementIstanziato__c>>();
				map<id,List<Pricebookentry>> assetsPBEMap = new map<id,List<Pricebookentry>>();

				//Creazione mappe che tengono traccia dell'asset con tutti i BE e i CE istanziati per quell'asset
				for (id idAss : assetsMap.keyset())
				{
					list<OF_CommercialElementIstanziato__c> listCist = assetsMap.get(idAss).Commercial_element_istanziati__r;
					list<Pricebookentry> PBEList = assetsMap.get(idAss).Price_Book_Entries__r;
					assetsCEMap.put(idAss, listCist);
					assetsPBEMap.put(idAss, PBEList);
				}
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - assetsCEMap: ' + assetsCEMap);
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - assetsPBEMap: ' + assetsPBEMap);

				//Record da aggiornare
				map<id,Asset> assetToUpdate = new map<id, Asset>();
				map<id, OF_CommercialElementIstanziato__c> CEToUpdate = new map<id, OF_CommercialElementIstanziato__c>();
				map<id, PricebookEntry> PBEToUpdate = new map<id, PricebookEntry>();

				for (case cas: caseList)
				{
					list<EOF_EAI_Service_Log__c> SLList = cas.EAI_Service_Logs1__r;
					string StrStatus = assetsMap.get(cas.AssetId).status;
					//system.debug('DG_OF_UtilitiesManageOrderFromCase - StrStatus: ' + StrStatus);

					for (EOF_EAI_Service_Log__c SL : SLList)
					{
						if (StrStatus == 'Attivo')
						{
							/**DATA ATTIVAZIONE ASSET E COMMERCIAL ELEMENT**/
							if ( (sl.OF_SA_Direzione_Flusso__c == 'OM-SF') &&
								 (sl.OF_SA_Metodo__c == 'OF_CompletionOrder_OpenStream') &&
								 (sl.recordtype.name == 'OF - SA - FiberNotify')
							)
							{
								datetime dt;
								if (sl.EOF_Data_Espletamento_Ordine__c != null)
								{
									string str = string.valueof(sl.EOF_Data_Espletamento_Ordine__c);
									string str1 = str + ' ' + '00:00:00';
									dt = DateTime.valueof(str1);
								}
								//system.debug('DG_OF_UtilitiesManageOrderFromCase - dt: ' + dt);
								/**DATA ATTIVAZIONE ASSET**/
								//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro data attivazione asset');
								assetsMap.get(sl.Caso__r.AssetId).OF_DataAttivazione2__c = dt;
								if (!assetToUpdate.containskey(sl.Caso__r.AssetId))
								{
									assetToUpdate.put(sl.Caso__r.AssetId,assetsMap.get(sl.Caso__r.AssetId));
								}

								/**DATA ATTIVAZIONE COMMERCIAL ELEMENT ISTANZIONI**/
								//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro data attivazione CE');
								List<OF_CommercialElementIstanziato__c> listCE = assetsCEMap.get(sl.Caso__r.AssetId);
								for (OF_CommercialElementIstanziato__c CE : listCE)
								{
									CE.OF_DataAttivazione__c = dt;
									if (!CEToUpdate.containskey(CE.id))
									{
										CEToUpdate.put(CE.id, CE);
									}
								}
							}

							/**DATA ATTIVAZIONE BILLING ELEMENT**/
							if ( (sl.OF_SA_Direzione_Flusso__c == 'SF-OLO') &&
								 (sl.OF_SA_Metodo__c == 'OF_CompletionOrder_OpenStream') &&
								 (sl.recordtype.name == 'OF - SA - ACK')
							)
							{
								//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro data attivazione BE');
								List<PriceBookEntry> listPBE = assetsPBEMap.get(sl.Caso__r.AssetId);
								for (PriceBookEntry PBE : listPBE)
								{
									PBE.OF_DataAttivazione2__c = sl.LastModifiedDate;
									if (!PBEToUpdate.containskey(PBE.id)) {
										PBEToUpdate.put(PBE.id, PBE);
									}
								}
							}
						}else if (StrStatus == 'Cessato')
						{
							//20/06/2017 aggiunta logica data cessazione Asset e CE
							/**DATA CESSAZIONE ASSET E COMMERCIAL ELEMENT**/
							if ( (sl.OF_SA_Direzione_Flusso__c == 'OM-SF') &&
								 (sl.OF_SA_Metodo__c == 'OF_StatusUpdate') &&
								 (sl.recordtype.name == 'OF - SA - FiberNotify')
							)
							{
								//Passo la data a stringa per popolare il date time con l'orario di mezzanotte
								//system.debug('DG_OF_UtilitiesManageOrderFromCase - assetsMap.get(sl.Caso__r.AssetId): ' + assetsMap.get(sl.Caso__r.AssetId));
								/**DATA CESSAZIONE ASSET**/
								//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro data attivazione asset');
								assetsMap.get(sl.Caso__r.AssetId).OF_DataCessazione2__c = sl.EOF_Data_Notifica__c;
								if (!assetToUpdate.containskey(sl.Caso__r.AssetId))
								{
									assetToUpdate.put(sl.Caso__r.AssetId,assetsMap.get(sl.Caso__r.AssetId));
								}

								/**DATA CESSAZIONE COMMERCIAL ELEMENT ISTANZIONI**/
								//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro data attivazione CE');
								List<OF_CommercialElementIstanziato__c> listCE = assetsCEMap.get(sl.Caso__r.AssetId);
								for (OF_CommercialElementIstanziato__c CE : listCE)
								{
									CE.OF_DataCessazione__c = sl.EOF_Data_Notifica__c;
									if (!CEToUpdate.containskey(CE.id))
									{
										CEToUpdate.put(CE.id, CE);
									}
								}
							}
						}
						/**DATA ATTIVAZIONE BE DI CESSAZIONE & DATA CESSAZIONE BE DI ATTIVAZIONE**/
						if ( (sl.OF_SA_Direzione_Flusso__c == 'OLO-SF') &&
							 (sl.OF_SA_Metodo__c == 'OLO_DeactivationOrder') &&
							 (sl.recordtype.name == 'OF - SA - FiberNotify')
						)
						{
							//system.debug('DG_OF_UtilitiesManageOrderFromCase - dentro data cessazione BE');
							List<PriceBookEntry> listPBE = assetsPBEMap.get(sl.Caso__r.AssetId);
							for (PriceBookEntry PBE : listPBE)
							{
								//Popolo data attivazione dei BE attivi (BE di cessazione)
								if (PBE.IsActive == true)
								{
									PBE.OF_DataAttivazione2__c = sl.EOF_Data_Notifica__c;
									if (!PBEToUpdate.containskey(PBE.id)) {
										PBEToUpdate.put(PBE.id, PBE);
									}
								}
								//Popolo data di cessazione dei BE disattivi (BE di attivazione)
								else if (PBE.IsActive == false)
								{
									PBE.OF_DataCessazione2__c = sl.EOF_Data_Notifica__c;
									if (!PBEToUpdate.containskey(PBE.id)) {
										PBEToUpdate.put(PBE.id, PBE);
									}
								}
							}
						}
					}
				}

				//system.debug('DG_OF_UtilitiesManageOrderFromCase - assetToUpdate: ' + assetToUpdate);
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - CEToUpdate: ' + CEToUpdate);
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - PBEToUpdate: ' + PBEToUpdate);

				if ((assetToUpdate.size() > 0) && (assetToUpdate != null)) {update assetToUpdate.values();}
				if ((CEToUpdate.size() > 0) && (CEToUpdate != null)) {update CEToUpdate.values();}
				if ((PBEToUpdate.size() > 0) && (PBEToUpdate != null)) {update PBEToUpdate.values();}
			}
		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:DateAssetCEBE','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return;
		}

	}

	/*****END SERVIZI ATTIVI*****/

	//DG creato metodo per ricursività trigger
	private static boolean run1 = true;
	public static boolean runOnce1() {
		if (run1) {
			run1 = false;
			return true;
		}else{
			return run1;
		}
	}

	//DG creato metodo per ricursività trigger quando creo i clienti retail nel trouble ticket
	private static boolean run = true;
	public static boolean runOnce() {
		if (run) {
			run = false;
			return true;
		}else{
			return run;
		}
	}

	//Metodo che crea un cliente retail e lo associa a case e asset
	public OF_AssetCases__c CreateClienteRetail(case c)
	{
		try {
			OF_AssetCases__c obj = new OF_AssetCases__c();
			obj.OF_Asset__c = c.AssetId;
			obj.OF_Caso__c = c.id;

			return obj;

		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:CreateClienteRetail','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}

	/**START Portalino - 10/07/2017**/

	//Prendo gli id del case e trovo le opportunity
	public map<id, list<opportunity>> CreateMap(map<id, set<id>> CaseMap)
	{
		try {
			system.debug('DG_OF_UtilitiesManageOrderFromCase_CreateMap CaseMap: ' + CaseMap);

			map<id, list<opportunity>> mappaOpp = new map<id, list<opportunity>>();
			if (CaseMap.size() > 0)
			{
				Map<id,case> CaseP2PMap = new Map<Id,case>([Select Id, (select id, StageName, PO_Contratto__c from Opportunities__r)from case Where id IN: CaseMap.keyset()]);
				system.debug('DG_OF_UtilitiesManageOrderFromCase_CreateMap CaseP2PMap: ' + CaseP2PMap);

				if (CaseP2PMap.size() > 0)
				{
					for (id ix : CaseP2PMap.keyset())
					{
						set<id> ySet = CaseMap.get(ix);
						for (id y : ySet)
						{
							mappaOpp.put(y,CaseP2PMap.get(ix).Opportunities__r);
						}
					}
				}
			}
			return mappaOpp;
		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:CreateMap','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}

	//Prende in input un case e trova l'opportunity chiusa da associare all'ordine
	public opportunity FindOpportunity(id caseID, map<id, list<opportunity>> MappaOpp)
	{
		try {
			//system.debug('DG_OF_UtilitiesManageOrderFromCase_FindOpportunity MappaOpp: ' + MappaOpp);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase_FindOpportunity caseID: ' + caseID);

			list<opportunity> oppList = MappaOpp.get(caseID);
			//system.debug('DG_OF_UtilitiesManageOrderFromCase_FindOpportunity oppList: ' + oppList);

			for (opportunity opp : oppList)
			{
				system.debug('DG_OF_UtilitiesManageOrderFromCase_FindOpportunity opp.StageName: ' + opp.StageName);
				//27/07/2017 Modifica. Non va più fatto il filtro. Sotto un case collegamento ci sarà sempre solo un'opportunity collegamento
				//if(opp.StageName == 'Offerta accettata')
				//{
				return opp;
				//}
			}
			return null;
		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:FindOpportunity','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}

	//Creazione ordine PO
	public order CreateOrderPO(id idCase, map<id, case> CaseMap, opportunity Opp, map<id, case> CaseColleg) {
		try {

			// system.debug('DG_OF_UtilitiesManageOrderFromCase_CreateOrderPO idCase: ' + idCase);
			// system.debug('DG_OF_UtilitiesManageOrderFromCase_CreateOrderPO CaseMap: ' + CaseMap);
			System.debug('DG_OF_UtilitiesManageOrderFromCase_CreateOrderPO Opp: ' + Opp);

			Id recordTypeId_FiberLink = Schema.SObjectType.case.getRecordTypeInfosByName().get('PO Ordine Fiber Link').getRecordTypeId();
			Id recordTypeId_FiberLease = Schema.SObjectType.case.getRecordTypeInfosByName().get('PO Ordine Fiber Lease').getRecordTypeId();

			Case c = CaseMap.get(idCase);

			string RecordTypeOrder = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();

			order o = new order();
			o.status = 'Aperto';
			o.RecordTypeId = RecordTypeOrder;
			o.OF_TipologiaDiServizio__c = TipoServ(c);
			o.AccountId = c.AccountId;
			o.OF_Esito__c = null;

			//FD 2019-02-08 - START
			//Case colleg = [SELECT EOF_Codice_Ordine_OLO__c FROM Case WHERE Id =: c.PO_Case_Collegamento__c];
			//Case ordine = [SELECT NS_Rif__c, PO_Civico__c, PO_Indirizzo_collegamento__c, Particella_Toponomastica_1__c, EOF_Codice_Ordine_OLO__c, PO_Comune__c FROM Case WHERE Id =: c.Id];

			System.debug('@@@ FD in metodo Utilities create order');
			System.debug('@@@ FD ordine.NS_Rif__c ' + c.NS_Rif__c);
			System.debug('@@@ FD ordine.PO_Civico__c ' + c.PO_Civico__c);
			System.debug('@@@ FD ordine.PO_Indirizzo_collegamento__c ' + c.PO_Indirizzo_collegamento__c);
			System.debug('@@@ FD ordine.Particella_Toponomastica_1__c ' + c.Particella_Toponomastica_1__c);
			System.debug('@@@ FD ordine.EOF_Codice_Ordine_OLO__c ' + c.EOF_Codice_Ordine_OLO__c);
			//System.debug('@@@ FD colleg.EOF_Codice_Ordine_OLO__c ' + colleg.EOF_Codice_Ordine_OLO__c);

			o.NS_Rif__c = c.NS_Rif__c;
			o.OF_Civico__c   = c.PO_Civico__c;
			o.OF_Comune__c = c.PO_Comune__c;
			o.OF_Indirizzo__c = c.PO_Indirizzo_collegamento__c;
			o.OF_ParticellaToponomastica__c = c.Particella_Toponomastica_1__c;
			o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
			//FD 2019-02-08 - END

			o.PO_Accordo_Operativo__c = c.Accordo_Operativo__c; //FD 2019-02-18

			/*Per ora l'ordine si crea sempre in Aperto, non va in KO
				if( o.OF_Esito__c != null)
				{
				o.OF_DataEsito__c = system.Today();
				//Da dove si prendono i campi per il KO??
				}*/
			o.EffectiveDate = system.Today();
			o.OF_CaseID__c = c.id;
			o.OF_CaseNome__c = c.casenumber;
			//o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c; //FD 2019-02-11 il case ordine non avrà mai EOF_Codice_Ordine_OLO__c valorizzato
			o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;

			//system.debug('DG_OF_UtilitiesManageOrderFromCase - c.OF_IDContratto__c: ' + c.OF_IDContratto__c);
			if (c.OF_IDContratto__c != null) {
				o.ContractId = c.OF_IDContratto__c;
			} else {
				o.ContractId = Opp.PO_Contratto__c;
			}

			//Campi specifici Opportunity
			o.PO_Opportunity__c = Opp.id;
			o.PO_IsFromOpportunity__c = true;

			if (c.recordtypeId.equals(recordTypeId_FiberLink)) {
				o.isFiberLink__c = true;
			}

			if (c.recordtypeId.equals( recordTypeId_FiberLease )) {
				o.isFiberLease__c = true;
				Case casoCollegamento = CaseColleg.get( c.PO_Case_Collegamento__c );
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - casoCollegamento:'+casoCollegamento);
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - PO_Tipo_di_collegamento__c:'+casoCollegamento.PO_Tipo_di_collegamento__c);

				//system.debug('DG_OF_UtilitiesManageOrderFromCase - c.PO_Case_Collegamento__c: ' + c.PO_Case_Collegamento__c);
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - c.PO_Case_Collegamento__r.PO_Tipo_di_collegamento__c: ' + c.PO_Case_Collegamento__r.PO_Tipo_di_collegamento__c);
				o.Description = casoCollegamento.PO_Tipo_di_collegamento__c;
				//system.debug('DG_OF_UtilitiesManageOrderFromCase - o.Description:'+o.Description);
			}

			return o;
		} catch (Exception e) {
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:CreateOrderPO','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}


	//Aggiorna il campo OF_Order__c sul case
	public list<case> AggiornoCase(map<id, order> caseorderMap, map<id, case> caseMap)
	{
		try {
			list<case> caseList = new list<case>();

			map<id, case> mappa = new Map<Id,case>([select id, OF_Order__c from case where id IN: caseorderMap.keyset()]);

			for (id ix : mappa.keyset())
			{
			//system.debug('DG Test - caseorderMap.get(ix).id: ' + caseorderMap.get(ix).id);
			case c = mappa.get(ix);
				c.OF_Order__c = caseorderMap.get(ix).id;
				caseList.add(c);
			}

			return caseList;
		}catch (Exception e)
		{
			OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:AggiornoCase','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());
			return null;
		}
	}

	/**END Portalino**/

	//OSCRM 30_08_2017
	public Map<Id,Case> getCaseCollegamentoFields(map<id, case> CaseMap)
	{
		Set<ID> caseCollegamentoIds = new Set<ID>();
		Map<Id,Case> mapCasoColleg = null;
		//new Map<Id,Case>();

		for (Case caso: CaseMap.values())
		{
			caseCollegamentoIds.add( caso.PO_Case_Collegamento__c );
		}

		if (caseCollegamentoIds.size() > 0)
		{

			mapCasoColleg = new Map<Id,Case>([ select id,PO_Tipo_di_collegamento__c
											   from Case
											   where Id IN: caseCollegamentoIds]);
		}
		return mapCasoColleg;

	}

}
public class PO_CollegamentoP2PBase_Controller {
	public Case originalCase {get; set;}
	public String title {get; set;}
	public String CaseId {get; set;}
	public String idNotify {get; set;}
	public String urlRedir {get; set;}
	public String perform {get; set;}
	public final Case c {get; set;}
	public boolean showModifica {get; set;} //FD 2019-02-14 CR Modifica Accordo Operativo
	public boolean mostraNotePerOLO {get; set;}
	public boolean mostraNoteInterneOrdine {get; set;}
	public boolean mostraNoteInterneNetworkCreation {get; set;}
	public boolean erroreAssegnazione {get; set;}
	public boolean collegamentoFattibilita {get; set;}
	public boolean ordineFattibilita {get; set;}
	public boolean richiestaFattibilita {get; set;}
	public boolean mostraNoteOperatore {get; set;}
	public boolean mostraNoteTecFatToNetCre {get; set;}
	public boolean mostraNoteTecFatToRefFat {get; set;}
	public boolean mostraNoteSupVenToRefFat {get; set;}
	public boolean mostraNoteRefFatToSupVen {get; set;}
	public boolean mostraNoteRefFatToTecFat {get; set;}
	public boolean mostraNoteNetCreToTecFat {get; set;}
	public boolean desospensione {get; set;}
	public static ID createAssetId {get; set;}
	public String ruoloDiPartenza {get; set;}
	public String checkEsiti {get; set;}
	public boolean prendiInCaricoP2PAttiva {get; set;}
	public boolean viewPopUpPSM {get; set;}
	// Integrazione DOM
	public boolean viewButtonDom {get; set;}
	// END
	public boolean viewErrorFilePopUpPSM {get; set;}
	public Boolean UserInQueue {get; set;}
	public boolean queueIng {get; set;}
	public boolean showFattibilitaCompletata {get; set;}
	public User usr {get; set;}

	public PO_CollegamentoP2PBase_Controller(ApexPages.StandardController stdController) {
		originalCase = (Case)stdController.getRecord();
		system.debug('PO_CollegamentoP2PBase_Controller originalCase:' + originalCase);
		originalCase=[select Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
					  EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c, PO_Tipologia_Offerta__c,
					  PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
					  PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
					  PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
					  PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
					  EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
					  OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
					  OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
					  EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
					  PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
					  isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
					  PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
					  OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c, PO_Posa_2_nuovo_Drop__c, PO_BB_2_interessato__c  // RDG
					  from Case where Id=:ApexPages.currentPage().getParameters().get('Id')];
		erroreAssegnazione=false;
		collegamentoFattibilita=false;
		ordineFattibilita=false;
		richiestaFattibilita=false;
		mostraNotePerOLO=false;
		mostraNoteInterneOrdine=false;
		mostraNoteTecFatToNetCre=false;
		mostraNoteInterneNetworkCreation=false;
		mostraNoteOperatore=false;
		mostraNoteTecFatToRefFat=false;
		mostraNoteTecFatToNetCre=false;
		mostraNoteSupVenToRefFat=false;
		mostraNoteRefFatToSupVen=false;
		mostraNoteRefFatToTecFat=false;
		mostraNoteNetCreToTecFat=false;
		desospensione = false;
		UserInQueue=false;
		prendiInCaricoP2PAttiva=false;
		queueIng=false; //2018 - 09 - 28

		// Controllare logica visibilità: tolta collegamentoFattibilita e invertito il controllo sul recordType
		User u =  [Select Id, ProfileId,UserRoleId, Profile.Name From User Where Id =:System.UserInfo.getUserId()];

		// condizione aggiunta per cr 2019-002 (cr06 - editabilità campi)
		Boolean editabileDaVendite = (u.Profile.Name == 'PO Supporto Vendite' 
			&& (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Referente Fattibilità' 
			|| originalCase.EOF_Fase__c ==  'In Attesa Presa In Carico Tecnico Fattibilità'));

		showModifica = (originalCase.owner.Id == UserInfo.getUserId() || editabileDaVendite)
			&& !originalCase.isClosed && originalCase.EOF_Fase__c != 'In Attesa di Assegnazione' 
			&& (originalCase.status == 'Accettato' || originalCase.status == 'In Lavorazione' || originalCase.Status == 'Acquisito'); 
				// && !originalCase.isPSM__c;
		showFattibilitaCompletata = ((originalCase.EOF_Fase__c == 'In Lavorazione Tecnico Fattibilità' || originalCase.EOF_Fase__c == 'In Lavorazione Referente Fattibilità') && originalCase.owner.Id == UserInfo.getUserId() && !originalCase.isClosed  && (originalCase.Recordtype.DeveloperName == 'PO_Collegamento_P2P' || originalCase.Recordtype.DeveloperName == 'PO_Collegamento_P2P' ) && !originalCase.isPSM__c);

		if (originalCase.Owner.Type == 'Queue') { // se owner è una queue
			Set<id> UserIdSet = new Set<Id>();
			if (u.Profile.Name == 'System Administrator') {UserInQueue= true;}
			else{
				List<GroupMember> groupMemberList = [SELECT UserOrGroupId FROM GroupMember WHERE GroupId =:originalCase.Owner.Id];
				Set<Id> groupMemberIds = new Set<Id>();
				for (GroupMember gm : groupMemberList) {
					groupMemberIds.add(gm.UserOrGroupId);
				}
				Map<Id, Group> mapIdGroup = new Map<Id, Group>([SELECT Id, RelatedId FROM Group WHERE Id IN: groupMemberIds]);
				for (Id gmId : groupMemberIds) {
					if (findObjectNameFromRecordIdPrefix(gmId) == 'User') {
						if (gmId == u.Id) { //se sono tra i membri della coda allora posso predenre in carico
							UserInQueue= true;
							break;
						}
					}
					if (findObjectNameFromRecordIdPrefix(gmId) == 'Group') {
						Group testgroup = mapIdGroup.get(gmId);
						if ((testgroup != null) && (testgroup.RelatedId == u.UserRoleId)) { //se sono tra i membri della coda allora posso predenre in carico
							UserInQueue= true;
							break;
						}
					}
				}
			}
		}
		if (originalCase.recordType.DeveloperName.contains('Collegamento')) {
			System.debug('PO_CollegamentoP2PBase_Controller DeveloperName contains Collegamento');
			collegamentoFattibilita=true;
			if (originalCase.EOF_FAse__c == 'In Lavorazione Network Creation') {
				System.debug('PO_CollegamentoP2PBase_Controller EOF_FAse__c In Lavorazione Network Creation');
				if (ApexPages.currentPage().getParameters().get('Oper') == 'NetCreToTecFat') {mostraNoteNetCreToTecFat=true;}
				mostraNoteInterneNetworkCreation=true;
			}
			//AS start SOSPESO
			if (originalCase.Status == 'Acquisito') { //
				System.debug('PO_CollegamentoP2PBase_Controller Status Acquisito PER SOSPESO');
				if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {mostraNoteOperatore=true;}
			}
			//AS STOP
			//2018-09-05 MM : aggiunta check status per desospensione
			if (originalCase.Status == 'Sospeso') {
				System.debug('PO_CollegamentoP2PBase_Controller Status SOSPESO per DESOSPENSIONE');
				if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {desospensione=true;}
			}
			// 2018-09-05 MM : fine
			if (originalCase.EOF_FAse__c == 'In Lavorazione Supporto Vendite') {
				System.debug('PO_CollegamentoP2PBase_Controller EOF_FAse__c In Lavorazione Supporto Vendite');
				if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {mostraNoteOperatore=true;}
				if (ApexPages.currentPage().getParameters().get('Oper') == 'SupVenToRefFat') {mostraNoteSupVenToRefFat=true;}
			}
			if (originalCase.EOF_FAse__c == 'In Lavorazione Tecnico Fattibilità') {
				System.debug('PO_CollegamentoP2PBase_Controller EOF_FAse__c In Lavorazione Tecnico Fattibilità');
				if (ApexPages.currentPage().getParameters().get('Oper') == 'TecFatToRefFat') {mostraNoteTecFatToRefFat=true;}
				if (ApexPages.currentPage().getParameters().get('Oper') == 'TecFatToNetCre') {mostraNoteTecFatToNetCre=true;}
			}
			if (originalCase.EOF_FAse__c == 'In Lavorazione Referente Fattibilità') {
				System.debug('PO_CollegamentoP2PBase_Controller EOF_FAse__c In Lavorazione Referente Fattibilità');
				if (ApexPages.currentPage().getParameters().get('Oper') == 'RefFatToSupVen') {mostraNoteRefFatToSupVen=true;}
				if (ApexPages.currentPage().getParameters().get('Oper') == 'RefFatToTecFat') {mostraNoteRefFatToTecFat=true;}
			}
		}
		else if (originalCase.recordType.DeveloperName.contains('Ordine')) {
			ordineFattibilita=true;
			mostraNoteInterneOrdine=true;
			if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {mostraNotePerOLO=true;}
		}
		else{richiestaFattibilita=true;}
		this.setViewPopUpPSM();
		this.setViewErrorFilePopUpPSM();
		system.debug('CRM 03_08_2017 PO_CollegamentoP2PBase_Controller originalCase:' + originalCase);
	}

	//AS START
	public static String findObjectNameFromRecordIdPrefix(String recordIdOrPrefix) {
		String objectName = '';
		try {
			//Get prefix from record ID
			//This assumes that you have passed at least 3 characters
			String myIdPrefix = String.valueOf(recordIdOrPrefix).substring(0,3);

			//Get schema information
			Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe();

			//Loop through all the sObject types returned by Schema
			for (Schema.SObjectType stype : gd.values()) {
				Schema.DescribeSObjectResult r = stype.getDescribe();
				String prefix = r.getKeyPrefix();
				System.debug('Prefix is ' + prefix);

				//Check if the prefix matches with requested prefix
				if ((prefix != null) && prefix.equals(myIdPrefix)) {
					objectName = r.getName();
					System.debug('Object Name! ' + objectName);
					break;
				}
			}
		}catch (Exception e) {System.debug(e);}
		return objectName;
	}
	//AS END

	//FD 2018 - 11 -06 START
	public void esitiCompletati() {
		System.debug('@@@ esitiCompletati');
		if (String.isBlank(originalCase.PO_Esito_collegamento__c)) {checkEsiti='NO';}
		else {
			System.debug('@@@ checkEsiti ' + checkEsiti);
			if (originalCase.PO_Esito_collegamento__c == 'KO') {
				originalCase.Status='Completato KO';
				originalCase.EOF_Fase__c='Completato KO';
				update originalCase;
			}
			List<Case> caseToUpdate = new List<Case>();
			originalCase.Status='Completato';
			originalCase.EOF_Fase__c='Completato';
			caseToUpdate.add(originalCase);
			boolean casePadreCheck=false;
			Case casePadre;
			List<Case> tuttiIFigli = [select Id,EOF_Fase__C,PO_Drop_FL_1__c,status from Case where PO_Richiesta_a_fattibilit__c=:originalCase.PO_Richiesta_a_fattibilit__c];
			system.debug('@@@@ tuttiIFigli.size(): ' + tuttiIFigli.size());
			if (tuttiIFigli.size() == 1) {
				//figlio  unico
				casePadre = new Case();
				casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c;
				casePadre.PO_Offerta__c = originalCase.PO_Richiesta_a_fattibilit__r.PO_Offerta__c; // RDG

				//Modifica Account Name
				casePadre.AccountId = originalCase.AccountId;

				casePadre.AccountId=originalCase.AccountId;
				casePadre.EOF_Fase__c='Offerta Creata';
				caseToUpdate.add(CasePadre);
				casePadreCheck=true;
			}
			else if (tuttiIFigli.size() > 1) {
				system.debug('@@@@ tuttiIFigli.size()>1');
				//parto da 1 in quanto considero l'attuale come completato
				Integer contaFigli=1;
				for (Case c : tuttiIFigli) {
					if ((c.EOF_Fase__C == 'Completato') || (c.status == 'Annullato')) {contaFigli++;}
				}
				system.debug('@@@@ contaFigli: ' + contaFigli);
				if (tuttiIFigli.size() == contaFigli) {
					//i case figli sono tutti completati o annullati
					casePadre = new Case();
					casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c;
					casePadre.PO_Offerta__c = originalCase.PO_Richiesta_a_fattibilit__r.PO_Offerta__c; // RDG

					//Modifica Account Name
					casePadre.AccountId = originalCase.AccountId;

					casePadre.EOF_Fase__c='Offerta Creata';
					caseToUpdate.add(CasePadre);
					casePadreCheck=true;
				}
			}
			update caseToUpdate;
			updateLog(originalCase.Id);

			// RDG 2019-02-02
			Opportunity oc = PO_ServFatt_OpportunityHandler.createOppChild(originalCase);
			// PO_P2PBase_OpportunityHandler.createOppChild(originalCase);

			system.debug('@@@@ casePadreCheck: ' + casePadreCheck);
			// RDG 2019-02-04
			if (casePadreCheck) {
				PO_ServFatt_OpportunityHandler.createOppParent(CasePadre, tuttiIFigli, oc);
			}
			// if(casePadreCheck) PO_P2PBase_OpportunityHandler.createOppParent(CasePadre, tuttiIFigli);
		}
	}
	//FD 2018 - 11 -06 END

	public void sospendi() {
		system.debug('PO_CollegamentoP2PBase_Controller sospendi');
		/*if(ordineFattibilita){
		    originalCase.EOF_Data_Ora_Sospensione__c=system.now();
		    originalCase.Status='Sospeso';
		    originalCase.EOF_Fase__c='Sospeso';
		    if(originalCase.eof_comunicazioni_con_olo__c != null)
		        originalCase.eof_comunicazioni_con_olo__c = originalCase.EOF_COmunicazioni_con_OLO__C +'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - '+'Sospensione OF'+' - '+userinfo.getName()+':\n'+originalCase.Note_Sospensione_Operatore__c;
		    else
		        originalCase.eof_comunicazioni_con_olo__c = OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - '+'Sospensione OF'+' - '+userinfo.getName()+':\n'+originalCase.Note_Sospensione_Operatore__c;
		   }*/
		if (collegamentoFattibilita) {
			originalCase.EOF_Data_Ora_Sospensione__c=system.now();
			originalCase.Status='Sospeso';
			originalCase.EOF_Fase__c='Sospeso OF';
			if (originalCase.EOF_COmunicazioni_con_OLO__c != null) {
				originalCase.EOF_COmunicazioni_con_OLO__c =originalCase.EOF_COmunicazioni_con_OLO__C + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Sospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;
			}
			else{
				originalCase.EOF_COmunicazioni_con_OLO__c = OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Sospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;
			}
		}
		update originalCase;
		//updateLog(originalCase.Id);  //prima era solo per P2P Attiva, serve?
	}

	public void inviaAlRefFat() {
		system.debug('PO_CollegamentoP2PBase_Controller inviaAlRefFat');
		if (originalCase.EOF_Fase__c == 'In Lavorazione Tecnico Fattibilità') {
			ruoloDiPartenza='TecFatToRefFat';
		}
		if (originalCase.EOF_Fase__c == 'In Lavorazione Supporto Vendite') {
			system.debug('Alessandro: setta la variabile');
			ruoloDiPartenza='SupVenToRefFat';
			system.debug('Alessandro: variabile è: ' + ruoloDiPartenza);
		}
	}

	public void inviaAlTecFat() {
		system.debug('PO_CollegamentoP2PBase_Controller inviaAlTecFat');
		if (originalCase.EOF_Fase__c == 'In Lavorazione Network Creation') {
			ruoloDiPartenza='NetCreToTecFat';
		}
		if (originalCase.EOF_Fase__c == 'In Lavorazione Referente Fattibilità') {
			ruoloDiPartenza='RefFatToTecFat';
		}
	}

	public void desospendi() {
		system.debug('PO_CollegamentoP2PBase_Controller desospendi');
		//da rivedere il priorValue
		originalCase.EOF_Data_Ora_Desospensione__c=system.now();
		originalCase.Status='Acquisito';
		originalCase.EOF_Fase__c='NA';
		if (originalCase.EOF_COmunicazioni_con_OLO__c != null) {
			originalCase.EOF_COmunicazioni_con_OLO__c =originalCase.EOF_COmunicazioni_con_OLO__C + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;
		}else{
			originalCase.EOF_COmunicazioni_con_OLO__c = OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;

		}
		update originalCase;
		//updateLog(originalCase.Id); //prima solo per P2PAttiva, serve?
	}

	public void annulla() {
		System.debug('PO_CollegamentoP2PBase_Controller annulla');
		originalCase.Status='Annullato';
		originalCase.EOF_Fase__c='Annullato';
		update originalCase;
		//updateLog(casePadre.Id,originalCase.Id);	//prima solo per P2PAttiva (commentato), serve?
	}

	public void PrendiInCarico() {
		system.debug('PO_CollegamentoP2PBase_Controller PrendiInCarico');
		if (collegamentoFattibilita) {
			system.debug('PO_CollegamentoP2PBase_Controller nell\'if collegamentoFattibilita');
			List<Case> caseToUpdate = new List<Case>();
			originalCase.Status='In Lavorazione';
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Referente Fattibilità') {originalCase.EOF_Fase__c='In Lavorazione Referente Fattibilità';}
			else if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Tecnico Fattibilità') {originalCase.EOF_Fase__c='In Lavorazione Tecnico Fattibilità';}
			else if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Network Creation') {originalCase.EOF_Fase__c='In Lavorazione Network Creation';}
			else if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Supporto Vendite') {originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';}
			Case casePadre = new Case();
			casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c;
			casePadre.PO_P2P_Base__c    = true;
			casePadre.status='In Lavorazione';
			casePadre.EOF_Fase__c='In Lavorazione';
			originalCase.OwnerId=userinfo.getUserId();
			caseToUpdate.add(originalCase);
			caseToUpdate.add(casePadre);
			system.debug(caseToUpdate);
			update caseToUpdate;
			updateLog(casePadre.Id,originalCase.Id);
			return;
		}
		/*if(richiestaFattibilita){
		    system.debug('PO_CollegamentoP2PBase_Controller nell\'if richiestaFattibilita');
		    originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';
		    List<Case> caseToAssign = [select Id from Case where PO_Richiesta_a_fattibilit__c=:originalCase.Id];
		    for(Case c : caseToAssign) c.OwnerId=userinfo.getUserId();
		    originalCase.OwnerId=userinfo.getUserId();
		    caseToAssign.add(originalCase);
		    update caseToAssign;
		    return;
		   }*/
		//AS ordinefattibilita
		if (ordineFattibilita) {
			system.debug('PO_CollegamentoP2PBase_Controller nell\'if ordineFattibilita');
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Supporto Vendite') {originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';}
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Delivery') {originalCase.EOF_Fase__c='In Lavorazione Delivery';}
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Network Creation') {originalCase.EOF_Fase__c='In Lavorazione Network Creation';}
			originalCase.OwnerId=userinfo.getUserId();
			//caseToAssign.add(originalCase);
			update originalCase;
			return;
		}
		originalCase.OwnerId=userinfo.getUserId();
		update originalCase;
	}

	public void updateLog(String idparentCase, string idChildCase) {
		system.debug('@@@@EC chiamiamo il metodo updateLog a cui passiamo due parametri.  idparentCase: ' + idparentCase + ', e idChildCase: ' + idChildCase);
		Case parentCase = [Select id, Status from Case where id=: idparentCase];
		Case childCase = [Select id, Status from Case where id = :idChildCase];
		List<String> idLogStringList = new List<String>();
		idLogStringList.add(idparentCase);
		idLogStringList.add(idChildCase);
		List<EOF_EAI_Service_Log__c> parentAndChildLog = [SELECT id, EOF_Stato_Richiesta__c, EOF_STATO_ORDINE__c, Caso__c
														  FROM EOF_EAI_Service_Log__c
														  WHERE Caso__c IN :idLogStringList];
		system.debug('@@@@EC chiamiamo nel metodo updateLog creiamo e popoliamo una lista di log parentAndChildLog che conta: ' + parentAndChildLog.size() + ' record ed è così popolata: ' + parentAndChildLog);

		for (EOF_EAI_Service_Log__c esl : parentAndChildLog) {
			system.debug('@@@@EC nel for per fare l\'update di ogni serviceLog della lista parentAndChildLog');
			if (esl.Caso__c == parentCase.Id) {
				system.debug('@@@@EC nell\' if del esl.Caso__c == parentCase.Id qui facciamo l\'update  esl.EOF_STATO_ORDINE__c = parentCase.Status');
				esl.EOF_STATO_ORDINE__c = parentCase.Status;
			}else{
				system.debug('@@@@EC nell\' else del esl.Caso__c == parentCase.Id qui facciamo l\'update  esl.EOF_STATO_ORDINE__c = childCase.Status');
				esl.EOF_STATO_ORDINE__c = childCase.Status;
			}
		}
		update parentAndChildLog;
		system.debug('abbiamo appena terminato l\'update della lista di log parentAndChildLog, che adesso è così valorizzata: ' + parentAndChildLog);
	}

	public void updateLog(String idChildCase) {
		system.debug('@@@@EC chiamiamo il metodo updateLog a cui passiamo un solo parametro, idChildCase: ' + idChildCase);
		Case childCase = [Select id, Status, PO_Disponibilit_della_rete_a_partire_da__c, PO_Tempi_di_attivazione_mesi__c from Case where id=: idChildCase]; //FD 2019-03-06
		EOF_EAI_Service_Log__c ChildLog = [SELECT id, EOF_Stato_Richiesta__c, EOF_STATO_ORDINE__c, Caso__c, eof_comunicazioni_con_olo__c, caso__r.Note_Sospensione_Operatore__c, EOF_NOTE__c, PO_Disponibilit_della_rete_a_partire_da__c, PO_Tempi_di_attivazione_mesi__c
										   FROM EOF_EAI_Service_Log__c
										   WHERE Caso__c = :idChildCase
											   LIMIT 1]; //FD 2019-03-06
		system.debug('@@@@EC chiamiamo nel metodo updateLog creiamo e popoliamo serviceLog, ChildLog i cui valori sono: ' + ChildLog + ', dovrebbe essere un solo ChildLog');
		ChildLog.EOF_STATO_ORDINE__c = childCase.Status;
		// faccio l'update del campo comunicazioni con OLO sul log
		if (ChildLog.eof_comunicazioni_con_olo__c != null) {
			ChildLog.eof_comunicazioni_con_olo__c = ChildLog.eof_comunicazioni_con_olo__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + ChildLog.caso__r.Note_Sospensione_Operatore__c;
		}
		else{
			ChildLog.eof_comunicazioni_con_olo__c =  OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + ChildLog.caso__r.Note_Sospensione_Operatore__c;
		}
		// finisce qui

		//FD 2019-03-06
		System.debug('@@@ PO_Tempi_di_attivazione_mesi__c: ' + childCase.PO_Tempi_di_attivazione_mesi__c);
		System.debug('@@@ PO_Disponibilit_della_rete_a_partire_da__c: ' + childCase.PO_Disponibilit_della_rete_a_partire_da__c);
		ChildLog.PO_Tempi_di_attivazione_mesi__c = childCase.PO_Tempi_di_attivazione_mesi__c;
		ChildLog.PO_Disponibilit_della_rete_a_partire_da__c = childCase.PO_Disponibilit_della_rete_a_partire_da__c;

		update ChildLog;
		system.debug('abbiamo appena terminato l\'update dello stato ChildLog, che adesso è: ' + ChildLog.EOF_STATO_ORDINE__c);
	}

	//SERVEEE??
	public void InviaAlNetworkCreation() {
		system.debug('@@@@@@@@EC PO_CollegamentoP2PBase_Controller InviaAlNetworkCreation');
		originalCase.Status='In Lavorazione';
		if (originalCase.EOF_Fase__c == 'In Lavorazione Tecnico Fattibilità') {
			originalCase.PO_Owner_Originario__c=userinfo.getUserId();
		}
		if (originalCase.EOF_Fase__c == 'In Lavorazione Supporto Vendite') {
			originalCase.PO_Owner_Originario__c=userinfo.getUserId();
		}
		//originalCase.EOF_Fase__c='In Lavorazione Network Creation'; //AS sostituito
		originalCase.EOF_Fase__c='In Attesa Presa In Carico Network Creation';
		system.debug('@@@@@@@@@@EC siamo subito prima del controllo relativo al rtDevolperName del case. ed è ' + originalCase.RecordType.DeveloperName);
		system.debug('@@@@@@@@@@@EC originalCase.PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c è ' + originalCase.PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c);

		if (originalCase.RecordType.DeveloperName.contains('P2P')) { ///EC 2018 - 11 - 19 modificato recordtype.developerName P2P sostituisce P2P_Attiva
			system.debug('@@@@@@@@@@@EC siamo nel controllo relativo al rtDevolperName del case. ed è ' + originalCase.RecordType.DeveloperName);
			system.debug('@@@@@@@@@@@EC originalCase.PO_Assegnazione_Area_Geografica__c è ' + originalCase.PO_Assegnazione_Area_Geografica__c);
			system.debug('@@@@@@@@@@@EC originalCase.PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c è ' + originalCase.PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c);
			if (originalCase.PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c == 'Centro') {
				originalCase.OwnerId= [select Id from Group where Type = 'Queue' AND DeveloperNAME = 'Coda_Network_Creation_Ordini_Centro'].id;
			}else if (originalCase.PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c == 'Nord') {
				originalCase.OwnerId= [select Id from Group where Type = 'Queue' AND DeveloperNAME = 'Coda_Network_Creation_Ordini_Nord'].id;
			}else if ((originalCase.PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c == 'Sud') || (originalCase.PO_Assegnazione_Area_Geografica__c == 'Isole')) {
				originalCase.OwnerId= [select Id from Group where Type = 'Queue' AND DeveloperNAME = 'Coda_Network_Creation_Ordini_Sud'].id;
			}
		}
		else{
			Database.DMLOptions dmo = new Database.DMLOptions();
			dmo.assignmentRuleHeader.useDefaultRule = true;
			originalCase.setOptions(dmo);
		}

		update originalCase;
		//updateLog(casePadre.Id,originalCase.Id);   //prima solo per P2PAttiva (commentato), serve?
	}

	//SERVEEE??
	public void InviaAlDelivery() {
		system.debug('PO_CollegamentoP2PBase_Controller InviaAlDelivery');
		if (originalCase.EOF_Fase__c == 'In Lavorazione Supporto Vendite') {
			originalCase.PO_Owner_Originario__c=userinfo.getUserId();
		}
		originalCase.Status='In Lavorazione';
		originalCase.EOF_Fase__c='In Attesa Presa In Carico Delivery';  // AS campbiato da In Lavorazione Delivery a In Attesa Presa In Carico Delivery



		Database.DMLOptions dmo = new Database.DMLOptions();
		dmo.assignmentRuleHeader.useDefaultRule = true;
		originalCase.setOptions(dmo);
		update originalCase;
		//updateLog(casePadre.Id,originalCase.Id);   //prima solo per P2PAttiva (commentato), serve?
	}

	public void InviaAlSupportoVendite() {
		system.debug('PO_CollegamentoP2PBase_Controller InviaAlSupportoVendite');
		originalCase.Status='In Lavorazione';
		originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';
		if (String.isNotBlank(originalCase.PO_Owner_Originario__c)) {
			originalCase.ownerId=originalCase.PO_Owner_Originario__c;
			originalCase.PO_Owner_Originario__c='';
		}
		else{
			Group g = [select Id from Group where Type = 'Queue' AND DeveloperNAME = 'PO_Coda_Ordini_Fattibilita'];
			originalCase.ownerId=g.Id;
		}
		update originalCase;
		//updateLog(casePadre.Id,originalCase.Id);   //prima solo per P2PAttiva (commentato), serve?
	}

	public void assegnaAlTecnico() {
		system.debug('PO_CollegamentoP2PBase_Controller assegnaAlTecnico');
		List<Group> gList = [select Id,DeveloperName from Group where Type = 'Queue'];
		Map<String,Id> gMap = new Map<String,Id>();
		for (Group g : gList) {gMap.put(g.DeveloperName,g.Id);}
		originalCase.EOF_Fase__C='In Attesa Presa In Carico Tecnico Fattibilità';
		if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Est') {originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Nord_Est');}
		if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Ovest') {originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Nord_Ovest');}
		if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Centro') {originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Centro');}
		if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Sud') {originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Sud');}
		if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Isole') {originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Isole');}
		update originalCase;
	}

	/*public void confermaAssegnazione(){

	    system.debug('@@@@@@@@@@@EC PO_CollegamentoP2PBase_Controller confermaAssegnazione');
	    List<Case> caseFigli = new List<Case>();
	    Map<String,Id> gMap = new Map<String,Id>();
	    boolean check=true;

	    for(Group g : [select Id,DeveloperName from Group where Type = 'Queue']){
	        gMap.put(g.DeveloperName,g.Id);
	    }


	    for (Case cf: [select Id, PO_Assegnazione_Area_Geografica__c, RecordType.DeveloperName from case where (PO_Richiesta_a_fattibilit__c=:originalCase.Id OR PO_Richiesta_a_fattibilit_KIT__c=:originalCase.Id) and PO_Incluso_nell_offerta__c=true]){
	        system.debug('@@@@@@@@@EC nel for cf ha il seguente rt ' + cf.RecordType.DeveloperName);

	        if(cf.RecordType.DeveloperName=='PO_Collegamento_P2P_Attiva'){
	            system.debug('@@@@@@@@@@@@@@@@EC rt di case figlio cf ' + cf.RecordType.DeveloperName);
	            caseFigli.add(cf);

	            if(String.isBlank(cf.PO_Assegnazione_Area_Geografica__c)){
	                system.debug('@@@@@@@@@@@@@@@@EC cf.PO_Assegnazione_Area_Geografica__c di case figlio cf ' + cf.PO_Assegnazione_Area_Geografica__c);
	                check=false;
	                erroreAssegnazione=true;
	                return;
	            }
	            else{
	                system.debug('@@@@@@@@@@@@@@@@EC else dopo il controllo String.isBlank(cf.PO_Assegnazione_Area_Geografica__c) rt di case figlio cf ' + cf.RecordType.DeveloperName);
	                originalCase.EOF_Fase__c='Assegnazione Confermata';

	                cf.status='Acquisito';


	                cf.EOF_Fase__c='In Attesa Presa In Carico Referente Fattibilità';
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Nord Est'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Nord Ovest'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Centro'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Sud'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Isole'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
	                }

	            }

	        }
	        else if(cf.RecordType.DeveloperName=='PO_Case_P2P_Attiva_KIT'){
	            system.debug('@@@@@@@@@@@@@@@@EC dentro else if relativo al recordtype. rt di case figlio cf ' + cf.RecordType.DeveloperName);
	            caseFigli.add(cf);

	            cf.status='Acquisito';
	            cf.EOF_Fase__c='In Attesa Presa In Carico Ingegneria';	//Add 2018 - 09 - 28
	            cf.ownerId=gMap.get('Coda_Ingegneria_P2PAttiva');		//Add 2018 - 09 - 28
	            erroreAssegnazione=false;
	        }
	        else if(cf.RecordType.DeveloperName=='PO Collegamento P2P'){
	            caseFigli.add(cf);
	            if(String.isBlank(cf.PO_Assegnazione_Area_Geografica__c)){
	                check=false;
	                erroreAssegnazione=true;
	                return;
	            }
	            else{
	                originalCase.EOF_Fase__c='Assegnazione Confermata';
	                cf.status='Acquisito';
	                cf.EOF_Fase__c='In Attesa Presa In Carico Referente Fattibilità';
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Nord Est'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Nord Ovest'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Centro'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Sud'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Isole'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
	                }
	            }
	        }
	        else {

	            system.debug('MM : dentro else per serevizi fattibilità diversi da P2P Attiva');

	            if(String.isBlank(cf.PO_Assegnazione_Area_Geografica__c)){
	                system.debug('@@@@@@@@@@@@@@@@EC cf.PO_Assegnazione_Area_Geografica__c di case figlio cf ' + cf.PO_Assegnazione_Area_Geografica__c);
	                check=false;
	                erroreAssegnazione=true;
	                return;
	            }

	            if(check){

	                system.debug('MM: dentro if per boolean check = true');

	                originalCase.EOF_Fase__c='Assegnazione Confermata';

	                cf.status='Acquisito';
	                cf.EOF_Fase__c='In Attesa Presa In Carico Referente Fattibilità';
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Nord Est'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Nord Ovest'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Centro'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Sud'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
	                }
	                if(cf.PO_Assegnazione_Area_Geografica__c=='Isole'){
	                    cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
	                }

	                caseFigli.add(cf);

	            }

	        }
	    }

	    caseFigli.add(originalCase);
	    update caseFigli;


	   }*/

	public void inserisciNote() {
		system.debug('PO_CollegamentoP2PBase_Controller inserisciNote');
		if (collegamentoFattibilita) {
			List<Group> gList = [select Id,DeveloperName from Group where Type = 'Queue'];
			Map<String,Id> gMap = new Map<String,Id>();
			for (Group g : gList) {
				gMap.put(g.DeveloperName,g.Id);
			}
			if (ApexPages.currentPage().getParameters().get('Oper') == 'Sos') {
				originalCase.Status='Sospeso';
				originalCase.EOF_FAse__c='Sospeso OF';
			}
			else if (originalCase.EOF_FAse__c == 'In Lavorazione Network Creation') {
				if (String.isNotBlank(originalCase.PO_Owner_Originario__c)) {
					originalCase.ownerId=originalCase.PO_Owner_Originario__c;
					originalCase.EOF_FAse__c='In Lavorazione Tecnico Fattibilità';
					originalCase.PO_Owner_Originario__c='';
				}
				else{
					originalCase.EOF_FAse__c='In Attesa Presa In Carico Tecnico Fattibilità';
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Est') {
						originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Nord_Est');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Ovest') {
						originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Nord_Ovest');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Centro') {
						originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Centro');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Sud') {
						originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Sud');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Isole') {
						originalCase.ownerId=gMap.get('PO_Coda_Tecnico_Fattibilit_Isole');
					}
				}
			}
			else if (originalCase.EOF_FAse__c == 'In Lavorazione Referente Fattibilità') {
				originalCase.ownerId=gMap.get('PO_Coda_Servizi_a_fattibilit');
				originalCase.EOF_Fase__c='In Attesa Presa In Carico Supporto Vendite';
			}
			else if (originalCase.EOF_FAse__c == 'In Lavorazione Supporto Vendite') {
				if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Est') {
					originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
				}
				if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Ovest') {
					originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
				}
				if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Centro') {
					originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
				}
				if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Sud') {
					originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
				}
				if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Isole') {
					originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
				}
				originalCase.EOF_Fase__c='In Attesa Presa In Carico Referente Fattibilità';
			}
			else if (originalCase.EOF_FAse__c == 'In Lavorazione Tecnico Fattibilità') {
				if (mostraNoteTecFatToRefFat) {
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Est') {
						originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Nord Ovest') {
						originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Centro') {
						originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Sud') {
						originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
					}
					if (originalCase.PO_Assegnazione_Area_Geografica__c == 'Isole') {
						originalCase.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
					}
					originalCase.EOF_Fase__c='In Attesa Presa In Carico Referente Fattibilità';
				}
				if (mostraNoteTecFatToNetCre) {
					originalCase.EOF_FAse__c='In Attesa Presa In Carico Network Creation';
					originalCase.ownerId=gMap.get('PO_Coda_fattibilit_Network_Creation');
					originalCase.PO_Owner_Originario__c=userInfo.getUserId();
				}
			}
			/*else{
			   originalCase.EOF_FAse__c='In Attesa Presa In Carico Network Creation';
			   originalCase.ownerId=gMap.get('PO_Coda_fattibilit_Network_Creation');
			   }*/
			update originalCase;
			//return;
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'NC') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Invia al NC - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Invia al NC - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			InviaAlNetworkCreation();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'Del') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Invia al Del - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Invia al Del - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			InviaAlDelivery();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'Sos') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Sospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Sospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Sospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Sospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			sospendi();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'Des') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Desospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Desospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Desospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Desospensione OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			desospendi();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'Ann') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Annullamento OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Annullamento OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Annullamento OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Annullamento OF - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			annulla();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'SupVenToNetCre') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Network Creation - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Network Creation - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Network Creation - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Network Creation - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			InviaAlNetworkCreation();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'NetCreToSupVen') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Supporto Vendite - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Network Creation - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Supporto Vendite - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Network Creation - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			InviaAlSupportoVendite();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'DelToSupVen') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Supporto Vendite - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Supporto Vendite - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Supporto Vendite - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Note per Supporto Vendite - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			InviaAlSupportoVendite();
		}
		return;
	}

	public void setViewPopUpPSM () {
		if (originalCase.view_PopUp_PSM__c) {viewPopUpPSM=true;}
		else{viewPopUpPSM=false;}
	}

	public void setViewErrorFilePopUpPSM() {
		if (originalCase.view_error_file_PSM__c) {viewErrorFilePopUpPSM=true;}
		else{ViewErrorFilePopUpPSM=false;}
	}

	// 16/04/2018 MM : aggiunta metodo per pulsante InvioPSM.
	public void InvioPSM() {
		System.debug('PO_CollegamentoP2PBase_Controller - dentro InvioPSM');
		// qui aggiorno il case con le stesse azioni effettuate dal pulsante Invia A PSM.
		originalCase.Status ='In Lavorazione';                         //todo aspetto email di marianna
		originalCase.EOF_Fase__c= 'In Lavorazione Network Creation';
		originalCase.PO_FATT_History_Owner__c = UserInfo.getUserId();
		update originalCase;
		eof_notify__c iPSM = new eof_notify__c();
		if (!Test.isRunningTest()) {iPSM.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM Notifica di Attivazione').getRecordTypeId();}
		iPSM.EOF_Data_Notifica__c = system.now();
		iPSM.Caso__c = originalCase.id;
		//iPSM.EOF_ID_Notifica__c = iPSM.id;
		insert iPSM;

		Case cpsm =[Select id, EOF_Note_Interne__c, PO_Nome_E_Cognome_PM__c, PO_Case_Collegamento__r.PO_Esito_collegamento__c,
					EOF_Account_OLO__r.Name, PO_Tipologia_Offerta_ordine__c, PO_Tipo_percorso__c,
					PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, PO_Case_Collegamento__r.EOF_ID_Risorsa__c,
		            //GB 12.05 start
					PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c, PO_Case_Collegamento__r.PO_Comune2__c, PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c, PO_Indirizzo_collegamento__c,PO_Sito__c,PO_Nome_Comune__c,PO_Civico__c,PO_Sito_partenza__c,
					PO_Indirizzo_collegamento_partenza__c, PO_Nome_Comune3__c,PO_Civico_partenza__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,
					PO_Nome_Comune4__c, PO_Civico_3__c,CaseNumber,EOF_Note_Operatore__c,//LM 27/08/19
		            //GB 12.05 end
					PO_Numero_fibre_richieste__c, Contact.Name, PO_Case_Collegamento__r.PO_Posa_2_nuovo_Drop__c,
					PO_Case_Collegamento__r.PO_BB_2_via_interessato__c, EOF_Codice_Ordine_OLO__c, PO_Case_Collegamento__r.LastModifiedBy.Name,
					PO_Data_Attivazione_Richiesta__c, PO_Case_Collegamento__r.OF_Order__r.CreatedDate,
					PO_Case_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c, PO_Case_Collegamento__r.PO_BB_1_interessato__c, PO_Case_Collegamento__r.PO_BB_2_interessato__c,
					PO_Pop_1_di_riferimento2__c, PO_Pop_2_di_riferimento2__c, PO_Case_Collegamento__r.PO_Drop_FL_1__c, PO_Case_Collegamento__r.PO_Drop_FL_2__c,
					PO_Case_Collegamento__r.PO_Posa_1_nuovo_Drop__c, PO_Case_Collegamento__r.PO_Posa_1_via_nuovo_Drop__c, PO_Case_Collegamento__r.PO_Posa_2_via_nuovo_Drop__c,
					PO_Case_Collegamento__r.PO_Tempi_di_attivazione_mesi__c, PO_Case_Collegamento__r.PO_BB_1_via_interessato__c, PO_Case_Collegamento__r.PO_Lunghezza_m__c,
					PO_Case_Collegamento__r.PO_Lunghezza_m2__c, PO_Case_Collegamento__r.PO_Note_fattibilit__c,
					PO_Case_Collegamento__r.PO_Note_Network_Creation__c, PO_Case_Collegamento__r.CaseNumber,
					PO_Case_Collegamento__r.PO_Pop_1_di_riferimento2__r.Name, PO_Case_Collegamento__r.PO_Pop_2_di_riferimento2__r.Name,Account.Name,CreatedDate
					from Case where ID =:iPSM.Caso__c];

		EOF_EAI_Service_Log__c slA = new EOF_EAI_Service_Log__c();
		slA.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_log__c.getRecordTypeInfosByName().get('PSM WS OUT Attivazione').getRecordtypeid();
		slA.Caso__c = originalCase.id; 
		slA.Notify__c = iPSM.id;
		slA.EOF_ID_Notifica__c = iPSM.Name;
		slA.OF_SA_Azione__c =PO_FATT_WS_PSM_Notify_Utils.AZIONE_ATTIVAZIONE;
		slA.EOF_Data_Notifica__c = iPSM.EOF_Data_notifica__c;
		slA.EOF_Richiesta_Notifica__c=
			'NOTE_ORDINE: ' + cpsm.EOF_Note_Operatore__c  + '\n' + //LM 27/08/19 come da HLD sostituito Note Interne con Note Operatore
			'PM_DI_RIFERIMENTO: ' + cpsm.PO_Nome_E_Cognome_PM__c  + '\n' +
			//'ESITO_FATTIBILITA: '+ cpsm.PO_Case_Collegamento__r.PO_Esito_collegamento__c  + '\n' +
			'ESITO_FATTIBILITA: ' +  PO_FATT_WS_PSM_Notify_Utils.getEsitoFattibilita(new EOF_Notify__c(Caso__r=cpsm))  + '\n' +  //da portare in sviluppo
			'ACCOUNT: ' + PO_FATT_WS_PSM_Notify_Utils.getAccount(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +  //fix del 01.06
			'TIPO_DI_CONTRATTO: ' + PO_FATT_WS_PSM_Notify_Utils.getTipoDiContratto(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +  //fix del 01.06
			'TIPO_DI_PERCORSO: ' + PO_FATT_WS_PSM_Notify_Utils.getTipoDiPercorso(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
			'TIPO_DI_COLLEGAMENTO: ' + PO_FATT_WS_PSM_Notify_Utils.getTipoCollegamento(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
			'PRIME_CONTRACTOR: ' + cpsm.PO_Prime_Contractor__c  + '\n' +
			'FIBRE_RICHIESTE: ' + cpsm.PO_Numero_fibre_richieste__c + '\n' +
			'RICHIEDENTE: ' + cpsm.Contact.Name  + '\n' +
			'CODICE_ISTAT_SEDE_1: ' + cpsm.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c + '\n' +
			'DENOMIN_SEDE_1: ' + cpsm.PO_Sito__c + '\n' +
			'NOME_VIA_SEDE_1: ' + cpsm.PO_Indirizzo_collegamento__c + '\n' +
			'COMUNE_SEDE_1: ' + cpsm.PO_Nome_Comune__c + '\n' +
			'CIVICO_SEDE_1: ' + cpsm.PO_Civico__c + '\n' +
			//'CODICE_ISTAT_SEDE_2: '+ cpsm.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c + '\n' +
			'CODICE_ISTAT_SEDE_2: N.A. \n' +
			'DENOMIN_SEDE_2: ' + cpsm.PO_Sito_partenza__c + '\n' +
			'NOME_VIA_SEDE_2: ' + cpsm.PO_Indirizzo_collegamento_partenza__c + '\n' +
			'COMUNE_SEDE_2: ' + cpsm.PO_Nome_Comune3__c + '\n' +
			'CIVICO_SEDE_2: ' + cpsm.PO_Civico_partenza__c + '\n' +
			//'CODICE_ISTAT_SEDE_3: '+ cpsm.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c + '\n' +
			'CODICE_ISTAT_SEDE_3: N.A. \n' +
			'DENOMIN_SEDE_3: ' + cpsm.PO_Sito_3__c + '\n' +
			'NOME_VIA_SEDE_3: ' + cpsm.PO_indirizzo_collegamento_3__c + '\n' +
			'COMUNE_SEDE_3: ' + cpsm.PO_Nome_Comune4__c + '\n' +
			'CIVICO_SEDE_3: ' + cpsm.PO_Civico_3__c + '\n' +
			'LUNGHEZZA_DROP_FL_2_LEASE: ' + PO_FATT_WS_PSM_Notify_Utils.getLungDropFlLease2(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
			'CAVO_TRATTA_SECONDA_VIA: ' + cpsm.PO_Case_Collegamento__r.PO_BB_2_via_interessato__c  + '\n' +
			'ID_CIRCUITO_PRIMA_TRATTA: ' + PO_FATT_WS_PSM_Notify_Utils.getIdCircuitoTratta1(cpsm.id)  + '\n' +
			'ID_CIRCUITO_SECONDA_TRATTA: ' + PO_FATT_WS_PSM_Notify_Utils.getIdCircuitoTratta2(cpsm.id)  + '\n' +
			'CODICE_ORDINE: ' + cpsm.casenumber  + '\n' +
			'ID_NOTIFICA: ' + iPSM.id  + '\n' +
			'DATA_NOTIFICA: ' + PO_FATT_WS_PSM_Notify_Utils.dateToString(iPSM.EOF_Data_Notifica__c)  + '\n' +
			'AZIONE: ' + PO_FATT_WS_PSM_Notify_Utils.AZIONE_ATTIVAZIONE  + '\n' +
			'FATTIBILITA_CREATA_DA: ' + cpsm.PO_Case_Collegamento__r.LastModifiedBy.Name  + '\n' +
			//'DATA_ORDINE: '+ PO_FATT_WS_PSM_Notify_Utils.dateToString(cpsm.PO_Case_Collegamento__r.OF_Order__r.CreatedDate)  + '\n' +
			'DATA_ORDINE: ' + PO_FATT_WS_PSM_Notify_Utils.dateToString(cpsm.CreatedDate)  + '\n' + //01.06
			'DISPONIBILITA_RETE: ' + PO_FATT_WS_PSM_Notify_Utils.dateYMToString(cpsm.PO_Case_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) + '\n' +
			'BB_1_INTERESSATO: ' + cpsm.PO_Case_Collegamento__r.PO_BB_1_interessato__c  + '\n' +
			'BB_2_INTERESSATO: ' + cpsm.PO_Case_Collegamento__r.PO_BB_2_interessato__c  + '\n' +
			'POP_DI_RIFERIMENTO_1: ' + cpsm.PO_Case_Collegamento__r.PO_Pop_1_di_riferimento2__r.Name + '\n' +
			'POP_DI_RIFERIMENTO_2: ' + cpsm.PO_Case_Collegamento__r.PO_Pop_2_di_riferimento2__r.Name + '\n' +
			'DROP_FL_1: ' + cpsm.PO_Case_Collegamento__r.PO_Drop_FL_1__c  + '\n' +
			'DROP_FL_2: ' + cpsm.PO_Case_Collegamento__r.PO_Drop_FL_2__c  + '\n' +
			'LUNGHEZZA_DROP_FL_LEASE: ' + PO_FATT_WS_PSM_Notify_Utils.getLungDropFlLease(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
			'POSA_1_NUOVO_CAVO: ' + cpsm.PO_Case_Collegamento__r.PO_Posa_1_via_nuovo_Drop__c  + '\n' +
			'POSA_2_NUOVO_CAVO: ' + cpsm.PO_Case_Collegamento__r.PO_Posa_2_via_nuovo_Drop__c + '\n' +
			'TEMPI_DI_ATTIVAZIONE_MESI: ' + cpsm.PO_Case_Collegamento__r.PO_Tempi_di_attivazione_mesi__c  + '\n' +
			'CAVO_TRATTA_PRIMA_VIA: ' + string.valueof(cpsm.PO_Case_Collegamento__r.PO_BB_1_via_interessato__c)  + '\n' +
			'LUNGHEZZA_DROP_FL: ' + cpsm.PO_Case_Collegamento__r.PO_Lunghezza_m__c  + '\n' +
			'LUNGHEZZA_DROP_FL_2: ' + cpsm.PO_Case_Collegamento__r.PO_Lunghezza_m2__c + '\n' +
			'NOTE_FATTIBILITA: ' + cpsm.PO_Case_Collegamento__r.PO_Note_fattibilit__c + '\n' +
			'NOTE: ' + cpsm.PO_Case_Collegamento__r.PO_Note_Network_Creation__c  + '\n' +
			'DATA_ATTIVAZIONE_RICHIESTA_CLIENTE: ' + string.valueof(PO_FATT_WS_PSM_Notify_Utils.stringToDateNoTime(cpsm.PO_Data_Attivazione_Richiesta__c))  + '\n' +
			'NOTE_COLLEGAMENTO: ' + 'Note Fattibilità: ' + cpsm.PO_Case_Collegamento__r.PO_Note_fattibilit__c + 'Note: ' + cpsm.PO_Case_Collegamento__r.PO_Note_Network_Creation__c + '\n' +
			'DATA_ORDINE_COMPLETATO: ' + PO_FATT_WS_PSM_Notify_Utils.getDataOrdineCompletato(iPSM.Caso__c) + '\n' +
			'ID_COLLEGAMENTO: ' + cpsm.PO_Case_Collegamento__r.CaseNumber + '\n';
		insert slA;

		List<Attachment> attachList = [Select id, ParentId, Name, ContentType, BodyLength, Body, OwnerId, CreatedDate, CreatedById,
									   CreatedBy.Name, LastModifiedDate,LastModifiedById,LastModifiedBy.Name, Description
									   from Attachment where ParentId=:cpsm.PO_Case_Collegamento__c];
		system.debug('insert attach');
		//Allego il file al Log
		if ((attachList != null) && (attachList.size() > 0)) {insert PO_FATT_WS_PSM_Notify_Utils.attachingFileOutbound(attachList,slA.id);}
		system.debug('dopo attach');
	}
	// 16/04/2018 MM : fine aggiunta

	public void inviaDOM() {
		
	}
}
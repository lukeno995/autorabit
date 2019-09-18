public class PO_ServiziFattibilita_Controller {
	public Case originalCase {get; set;}
	public String title {get; set;}
	public String CaseId {get; set;}
	public String idNotify {get; set;}
	public String urlRedir {get; set;}
	public String perform {get; set;}
	public final Case c {get; set;}
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
	public boolean viewErrorFilePopUpPSM {get; set;}
	public Boolean UserInQueue {get; set;}
	public boolean queueIng {get; set;} //2018 - 09 - 28
	public boolean p2pAttivabool {get; set;}
	public boolean p2pAttSuppVenditeUserCheck {get; set;} //EC 2018 - 09 - 10 aggiungiamo un boolean per verificare se l'utente è un utente con il profilo supporto vendite
	public boolean p2pAttRefFattCheck {get; set;}
	public boolean p2pAttTecFattCheck {get; set;}
	public boolean p2pOrdDelFattCheck {get; set;} //27-12-2018 V1 BUGFIX P2PATTIVA
	public boolean p2pNetCreFattCheck {get; set;} //27-12-2018 V1 BUGFIX P2PATTIVA
	public boolean kitP2PAttiva {get; set;}
	public boolean kitOK {get; set;} //EC 2018 - 10 - 09
	public List<case> CaseKit {get; set;} // MM 09-10-2018}
	public User usr {get; set;} //EC 2018 - 11 - 05
	public Boolean mostraFattComplButton {get; set;}//EC 2018 - 11 - 07
	//DN - cr 2019-002 (cr06 - editabilità campi)
	public Boolean editabileDaVendite {get; set;}

	public PO_ServiziFattibilita_Controller(ApexPages.StandardController stdController) {
		originalCase = (Case)stdController.getRecord();

		//CRM Modifica 31_08_2017 Aggiunta dei due campi 1.PO_BB_1_interessato__c 2.PO_Posa_1_nuovo_Drop__c nella query
		//AS modifica aggiunti campi Owner.Id,Owner.Type
		system.debug('CRM 03_08_2017 PO_ServiziFattibilita_Controller originalCase:' + originalCase);

		originalCase=[select Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
					  EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c, PO_Tipologia_Offerta__c,
					  PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, 
					  PO_Esito_collegamento__c, PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
					  PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
					  PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
					  EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
					  OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
					  OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
					  EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
					  PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, 
					  PO_P2P_Attiva__c, isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,
					  PO_Costi_aggiuntivi_collegamento__c, PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,
					  PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId, OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, 
					  PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, 
					  PO_Tipologia_Offerta_ordine__c, PO_Offerta__c, PO_Posa_2_nuovo_Drop__c, PO_BB_2_interessato__c  // RDG
					  ,Previous_Status__c, Previous_Fase__c, PO_Comune__c, PO_Nome_Comune__c, PO_Comune2__c, PO_Comune2__r.OF_Provincia__c, 
					  PO_Comune2__r.OF_Comune__c, EOF_Istat_Provincia__c, PO_Indirizzo_collegamento__c, PO_Civico__c, NS_Rif__c, PO_PP_NomeKit__c,
					  tipologia_sede__c 
					  from Case where Id=: ApexPages.currentPage().getParameters().get('Id')];

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
		p2pAttTecFattCheck=false;
		p2pAttSuppVenditeUserCheck=false;
		p2pAttRefFattCheck=false;
		p2pOrdDelFattCheck=false; //27-12-2018 V1 BUGFIX P2PATTIVA
		p2pNetCreFattCheck=false; //27-12-2018 V1 BUGFIX P2PATTIVA
		kitP2PAttiva=false; // 2018 - 09 - 28
		queueIng=false; //2018 - 09 - 28
		mostraFattComplButton= false;//EC 2018 - 11 - 07


		User u =  [Select Id, ProfileId,UserRoleId, Profile.Name From User Where Id =:System.UserInfo.getUserId()];
		System.debug('##### profile.name: ' + u.Profile.Name);
		editabileDaVendite = (u.Profile.Name == 'PO Supporto Vendite' 
			&& (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Referente Fattibilità' 
			|| originalCase.EOF_Fase__c ==  'In Attesa Presa In Carico Tecnico Fattibilità'));
			
		if (u.Profile.Name == 'PO Supporto Vendite') {
			p2pAttSuppVenditeUserCheck = true;
		}
		else if (u.Profile.Name == 'PO Referente Fattibilità') {
			p2pAttRefFattCheck = true;
		}
		else if (u.Profile.Name == 'PO Tecnico fattibilità') {
			p2pAttTecFattCheck=true;
		}
		//27-12-2018 V1 BUGFIX P2PATTIVA -start
		else if (u.Profile.Name == 'PO Ordini Delivery') {
			p2pOrdDelFattCheck=true;
		}
		else if (u.Profile.Name == 'PO Network Creation') {
			p2pNetCreFattCheck=true;
		}
		//27-12-2018 V1 BUGFIX P2PATTIVA -end
		//p2pAttSuppVenditeUserCheck=u.Profile.Name=='PO Supporto Vendite'?true:false;
		if (originalCase.Owner.Type == 'Queue') { // se owner è una queue
			Set<id> UserIdSet = new Set<Id>();
			if (u.Profile.Name == 'System Administrator') {
				UserInQueue= true;
                queueIng= true;
			}
			if (u.Profile.Name == 'PO Ingegneria P2PAttiva') {
				queueIng= true;
			}
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

							UserInQueue= true;  break;
						}
					}
					if (findObjectNameFromRecordIdPrefix(gmId) == 'Group') {
						Group testgroup = mapIdGroup.get(gmId);
						if ((testgroup != null) && (testgroup.RelatedId == u.UserRoleId)) { //se sono tra i membri della coda allora posso predenre in carico
							UserInQueue= true;  break;
						}
					}
				}
			}
		}
		//faccio i controlli per il prendi in carico di P2P Attiva (non valido per la richiesta padre in quanto vale l'altro bottone
		//relativo a tutto cio che non è ordine P2PAtt o collegamento P2PAtt
		if (UserInQueue && !originalCase.isPsm__c && !originalCase.isClosed && originalCase.recordtype.developername != 'PO_Case_P2P_Attiva_KIT') {
			system.debug('#### UserInQueue:' +UserInQueue + ' originalCase.isPsm__c: ' + originalCase.isPsm__c + ' originalCase.isClosed: ' + originalCase.isClosed + ' p2pAttRefFattCheck : ' + p2pAttRefFattCheck + ' p2pAttTecFattCheck : ' + p2pAttTecFattCheck  );
			if (p2pAttSuppVenditeUserCheck || p2pOrdDelFattCheck || p2pNetCreFattCheck) { //27-12-2018 V1 BUGFIX P2PATTIVA){
				if (originalCase.recordtype.developername == 'PO_Ordine_P2P_Attiva') {
					prendiInCaricoP2PAttiva=true;
				}
			}
			else if (p2pAttRefFattCheck || p2pAttTecFattCheck || u.Profile.Name == 'System Administrator') {
				if (originalCase.recordtype.developername == 'PO_Collegamento_P2P_Attiva' ) {
					prendiInCaricoP2PAttiva=true;
				}
			}
			//27-12-2018 V1 BUGFIX P2PATTIVA - start
            system.debug('##### originalCase.recordtype.developername: '+ originalCase.recordtype.developername  + ' queueIng: ' +queueIng + ' originalCase.isPsm__c ' + originalCase.isPsm__c + ' originalCase.isClosed ' + originalCase.isClosed   );
		} else if ( (queueIng || u.Profile.Name == 'PO Tecnico fattibilità' )&& originalCase.recordtype.developername == 'PO_Case_P2P_Attiva_KIT'   && !originalCase.isClosed && originalCase.status == 'Acquisito') { //FD 27-12-2018
            system.debug('##### sono qui 002'  );
            prendiInCaricoP2PAttiva=true;
		}
		
		system.debug('ILPERRINO: queueIng: ' + queueIng + ' originalCase.recordtype.developername: ' + originalCase.recordtype.developername + ' originalCase.isClosed: ' + originalCase.isClosed);
		//27-12-2018 V1 BUGFIX P2PATTIVA - end
		richiestaFattibilita=(originalCase.recordType.DeveloperName == 'PO_Richiesta_a_servizio_a_fattibilit') ? true : false;//EC 2018 - 11 - 08
		if (originalCase.recordType.DeveloperName.contains('Collegamento')) {
			System.debug('PO_ServiziFattibilita_Controller DeveloperName contains Collegamento');
			collegamentoFattibilita=true;

			//EC start 2018 - 11 - 07 aggiungiamo un controllo per alleggerire il controllo del rendered sulla pagina per il bottone Fattibilità Completata

			//'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb' =PO Collegamento Evento Temporaneo
			system.debug('@@@Sergio ' + 'originalCase.ownerId ' + originalCase.ownerId + ' originalCase.isClosed ' + originalCase.isClosed +
						 ' originalCase.EOF_Fase__c ' + originalCase.EOF_Fase__c + ' u.Profile.Name ' + u.Profile.Name +
						 ' originalCase.Recordtype.DeveloperName ' + originalCase.Recordtype.DeveloperName +
						 ' originalCase.isPSM__c ' + originalCase.isPSM__c);
			if ((originalCase.ownerId == u.Id) && (originalCase.isClosed == false)) {
				if (((originalCase.EOF_Fase__c == 'In Lavorazione Tecnico Fattibilità') && (u.Profile.Name == 'PO Tecnico fattibilità')) || ((originalCase.EOF_Fase__c == 'In Lavorazione Referente Fattibilità') && (u.Profile.Name == 'PO Referente Fattibilità'))) {
					if ((originalCase.Recordtype.DeveloperName == 'PO_Collegamento_P2P') || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb')) {
						mostraFattComplButton = true;
					}
					if ((originalCase.isPSM__c == false) && ((originalCase.Recordtype.DeveloperName == 'PO_Collegamento_IRU') || (originalCase.Recordtype.DeveloperName == 'PO_Collegamento_Fiber_link') || (originalCase.Recordtype.DeveloperName == 'PO_Collegamento_Fiber_Lease') || (originalCase.Recordtype.DeveloperName == 'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'))) {
						mostraFattComplButton = true;
					}
				}
			}

			//EC end 2018 - 11 - 07

			//'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb' =PO Collegamento Evento Temporaneo
			if ((originalCase.ownerId == u.Id) && (originalCase.isClosed == false)) {
				if (((originalCase.EOF_Fase__c == 'In Lavorazione Tecnico Fattibilità') && (u.Profile.Name == 'PO Tecnico fattibilità')) || ((originalCase.EOF_Fase__c == 'In Lavorazione Referente Fattibilità') && (u.Profile.Name == 'PO Referente Fattibilità'))) {
					if ((originalCase.Recordtype.DeveloperName == 'PO_Collegamento_P2P') || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb')) {
						mostraFattComplButton = true;
					}
					if (originalCase.isPSM__c=false && ((originalCase.Recordtype.DeveloperName == 'PO_Collegamento_IRU') || (originalCase.Recordtype.DeveloperName == 'PO_Collegamento_Fiber_link') || (originalCase.Recordtype.DeveloperName == 'PO_Collegamento_Fiber_Lease') || (originalCase.Recordtype.DeveloperName == 'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'))) {
						mostraFattComplButton = true;
					}
				}
			}

			//EC end 2018 - 11 - 07


			if (originalCase.EOF_FAse__c == 'In Lavorazione Network Creation') {
				System.debug('PO_ServiziFattibilita_Controller EOF_FAse__c In Lavorazione Network Creation');
				if (ApexPages.currentPage().getParameters().get('Oper') == 'NetCreToTecFat') {
					mostraNoteNetCreToTecFat=true;
				}

				mostraNoteInterneNetworkCreation=true;

			}
			//AS start SOSPESO
			if (originalCase.Status == 'Acquisito') { //
				System.debug('PO_ServiziFattibilita_Controller Status Acquisito PER SOSPESO');
				if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {
					mostraNoteOperatore=true;
				}
			}
			//AS STOP
			//2018-09-05 MM : aggiunta check status per desospensione
			if (originalCase.Status == 'Sospeso') { //
				System.debug('PO_ServiziFattibilita_Controller Status SOSPESO per DESOSPENSIONE');
				if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {
					desospensione=true;
				}
			}
			// 2018-09-05 MM : fine
			if (originalCase.EOF_FAse__c == 'In Lavorazione Supporto Vendite') {
				System.debug('PO_ServiziFattibilita_Controller EOF_FAse__c In Lavorazione Supporto Vendite');
				if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {
					mostraNoteOperatore=true;
				}

				if (ApexPages.currentPage().getParameters().get('Oper') == 'SupVenToRefFat') {
					mostraNoteSupVenToRefFat=true;

				}

			}
			if (originalCase.EOF_FAse__c == 'In Lavorazione Tecnico Fattibilità') {
				System.debug('PO_ServiziFattibilita_Controller EOF_FAse__c In Lavorazione Tecnico Fattibilità');
				if (ApexPages.currentPage().getParameters().get('Oper') == 'TecFatToRefFat') {
					mostraNoteTecFatToRefFat=true;
				}
				if (ApexPages.currentPage().getParameters().get('Oper') == 'TecFatToNetCre') {
					mostraNoteTecFatToNetCre=true;
				}
			}
			if (originalCase.EOF_FAse__c == 'In Lavorazione Referente Fattibilità') {
				System.debug('PO_ServiziFattibilita_Controller EOF_FAse__c In Lavorazione Referente Fattibilità');
				if (ApexPages.currentPage().getParameters().get('Oper') == 'RefFatToSupVen') {
					mostraNoteRefFatToSupVen=true;
				}
				if (ApexPages.currentPage().getParameters().get('Oper') == 'RefFatToTecFat') {
					mostraNoteRefFatToTecFat=true;
				}
			}
		}
		else if (originalCase.recordType.DeveloperName.contains('Ordine')) {
			ordineFattibilita=true;
			mostraNoteInterneOrdine=true;
			if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {
				mostraNotePerOLO=true;
			}



		}
		//EC Start p2pAttivaKit 2018 - 09 - 28
		else if (originalCase.recordType.DeveloperName == 'PO_Case_P2P_Attiva_KIT') {
			kitP2PAttiva=true;
			if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {
				mostraNotePerOLO=true;
			}
		}
		//EC End p2pAttivaKit 2018 - 09 - 28
		else{
			richiestaFattibilita=true;
		}
		this.setViewPopUpPSM();
		this.setViewErrorFilePopUpPSM();
		system.debug('CRM 03_08_2017 PO_ServiziFattibilita_Controller originalCase:' + originalCase);

		p2pAttivabool=(originalCase.recordType.DeveloperName.contains('P2P_Attiva') ) ? true : false;//EC 2018 - 08 - 31 //FD 2019-02-28
		system.debug('@@@@@@@@@@@@EC p2pAttivabool è ' + p2pAttivabool);

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
		}catch (Exception e) {
			System.debug(e);
		}
		return objectName;
	}
	//AS END

	public void P2PAttiva_esitiCompletati() {
		if (String.isBlank(originalCase.PO_Esito_collegamento__c)) {
			checkEsiti='NO';
			return;
		}
		else if (originalCase.PO_Esito_collegamento__c == 'KO') {
			originalCase.Status='Completato KO';
			originalCase.EOF_Fase__c='Completato KO';
			update originalCase;
			return;
		}
		List<Case> CaseKit = [select id, status, PO_Case_Collegamento__c from case where recordtype.developername ='PO_Case_P2P_Attiva_KIT' AND PO_Case_Collegamento__c =: originalCase.id];
		if (CaseKit.size() > 0) {
			if ((CaseKIT[0].status != null) && (CaseKIT[0].status != 'Verificato')) {
				checkEsiti='KIT';
				return;
			}
		}
		List<Case> caseToUpdate = new List<Case>();
		originalCase.Status='Completato';
		originalCase.EOF_Fase__c='Completato';
		caseToUpdate.add(originalCase);
		boolean casePadreCheck=false;
		Case casePadre;
		// 08/10/2018 MM : aggiunto checkesiti
		string checkesiti;
		List<Case> tuttiIFigli = [select Id,EOF_Fase__C,PO_Drop_FL_1__c,status from Case where PO_Richiesta_a_fattibilit__c=:originalCase.PO_Richiesta_a_fattibilit__c];
		system.debug('@@@@ tuttiIFigli.size(): ' + tuttiIFigli.size());
		if (tuttiIFigli.size() == 1) {
			//figlio  unico
			casePadre = new Case(); casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c; casePadre.PO_Offerta__c = originalCase.PO_Richiesta_a_fattibilit__r.PO_Offerta__c; casePadre.EOF_Fase__c='Offerta Creata'; casePadre.AccountId=originalCase.AccountId; caseToUpdate.add(CasePadre); casePadreCheck=true;

		}
		else if (tuttiIFigli.size() > 1) {
			system.debug('@@@@ tuttiIFigli.size()>1');
			//parto da 1 in quanto considero l'attuale come completato
			Integer contaFigli=1;
			for (Case c : tuttiIFigli) {
				//28/09/2017 CRM Modifica - per creare l'offerta totale si considerano anche i case in annullato
				if ((c.EOF_Fase__C == 'Completato') || (c.status == 'Annullato')) {
					contaFigli=contaFigli + 1;
				}
			}
			system.debug('@@@@ contaFigli: ' + contaFigli);
			if (tuttiIFigli.size() == contaFigli) {
				//i case figli sono tutti completati o annullati
				casePadre = new Case(); casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c; casePadre.PO_Offerta__c = originalCase.PO_Richiesta_a_fattibilit__r.PO_Offerta__c; casePadre.EOF_Fase__c='Offerta Creata';casePadre.AccountId=originalCase.AccountId; caseToUpdate.add(CasePadre); casePadreCheck=true;
			}
		}

		update caseToUpdate;
		updateLog(originalCase.Id);
		// RDG 2019-02-07
		Opportunity oc = PO_ServFatt_OpportunityHandler.createOppChild(originalCase);
		//PO_P2PAtt_OpportunityHandler.createOppChild(originalCase);

		system.debug('@@@@ casePadreCheck: ' + casePadreCheck);

		if (casePadreCheck) {
			// RDG 2019-02-07
			system.debug('@@@@EC casePadre: ' + casePadre + ', casePadre.AccountID: ' + casePadre.AccountId);
			PO_ServFatt_OpportunityHandler.createOppParent(CasePadre, tuttiIFigli, oc);
			// PO_P2PAtt_OpportunityHandler.createOppParent(CasePadre, tuttiIFigli);
		}
	}


	public void esitiCompletati() {
		system.debug('Siamo nella classe PO_ServiziFattibilita_Controller stiamo chiamando il metodo esitiCompletati');
		List<Case> tuttiIFigli = [select Id,EOF_Fase__C,PO_Drop_FL_1__c,status from Case where PO_Richiesta_a_fattibilit__c=:originalCase.PO_Richiesta_a_fattibilit__c];
		system.debug('@@@@Siamo nel metodo esitiCompletati tutti i figli sono: ' + tuttiIFigli.size() + ' @@@@@ ' + tuttiIFigli);
		//controllo se il campo esiti è valorizzato
		system.debug('@@@@Siamo nel metodo esitiCompletati originalCase.PO_Esito_collegamento__c è: ' + originalCase.PO_Esito_collegamento__c + ' il recordtype.developerName è: ' + originalCase.recordType.DeveloperName);
		if (String.isBlank(originalCase.PO_Esito_collegamento__c)) {
			system.debug('@@@@nel metodo esiti esitiCompletati, nell\'if che verifica se PO_Esito_Collegamento isBlank, in caso positivo checkEsiti viene settato a NO');
			checkEsiti='NO';
			return;
		}

		//CRM Modifica 31_08_2017 Controllo se i due campi 1.PO_BB_1_interessato__c 2.PO_Posa_1_nuovo_Drop__c sono valorizzati ( Solo per FiberLease )
		if (originalCase.recordType.DeveloperName == 'PO_Collegamento_Fiber_Lease')
		{
			system.debug('@@@ il recordtype.DeveloperName è PO_Collegamento_Fiber_Lease? verifichiamo: ' +  originalCase.recordType.DeveloperName);
			if (originalCase.PO_BB_1_interessato__c == null)
			{
				checkEsiti = 'FL_1FieldEmpty';
				return;
			}
			//14/09/2017 CRM Commentato perchè non va più fatto questo controllo
			//19/09/2017 CRM decommentato
			if ((originalCase.PO_Drop_FL_1__c == false) && (originalCase.PO_Posa_1_nuovo_Drop__c == null))
			{
				checkEsiti = 'FL_2FieldEmpty';
				return;
			}
			if ((originalCase.PO_Drop_FL_1__c == true) && (originalCase.PO_Lunghezza_m__c == null))
			{
				checkEsiti = 'LunghFieldEmpty';
				return;
			}

		}
		system.debug('@@@siamo fuori dall\'if dell\'rt PO_Collegamento_Fiber_Lease, quindi il recordtype.DeveloperName NON è PO_Collegamento_Fiber_Lease. verifichiamo: ' +  originalCase.recordType.DeveloperName);
		//CRM Fine Modifica

		//controllo se ci sono altri case figli
		if (tuttiIFigli.size() > 1) {
			system.debug('@@@siamo nell\'if relativo a un lista di figli > 1. verifichiamo: ' +  tuttiIFigli.size());
			//parto da 1 in quanto considero l'attuale come completato
			Integer contaFigli=1;
			//20/09/2017 Modifica CRM
			boolean checkFibLeasMista = false;
			//20/09/2017 END CRM
			for (Case c : tuttiIFigli) {
				system.debug('@@@@ entro nel ciclo figlio ' + contafigli);
				//28/09/2017 CRM Modifica - per creare l'offerta totale si considerano anche i case in annullato
				//if(c.EOF_Fase__C=='Completato'){
				if ((c.EOF_Fase__C == 'Completato') || (c.status == 'Annullato')) {
					system.debug('@@@@ entro nel ciclo completati/annullati figlio ' + contafigli);
					contaFigli=contaFigli + 1;
					//20/09/2017 Modifica CRM
					if ((originalCase.PO_Drop_FL_1__c == true) || (c.PO_Drop_FL_1__c == true))
					{
						checkFibLeasMista = true;
					}
					//20/09/2017 END CRM
				}
			}
			if (tuttiIFigli.size() == contaFigli) {
				system.debug('@@@@ tuttiIFIgli e contafigli coincidono ' + tuttiIFigli + ':' + contafigli);
				//i case figli sono tutti completati
				List<Case> caseToUpdate = new List<Case>();
				originalCase.Status='Completato';
				originalCase.EOF_Fase__c='Completato';
				Case casePadre = new Case();
				casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c;
				casePadre.EOF_Fase__c='Offerta Creata';
				//20/09/2017 Modifica CRM - Se si tratta di fiber lease mista allora il campo PO_Durata_affitto__c sul case padre deve essere = 3
				if (checkFibLeasMista == true)
				{
					casePadre.PO_Durata_affitto__c = 3;
				}
				//20/09/2017 END CRM

				caseToUpdate.add(originalCase);

				update caseToUpdate;
				update CasePadre;
				//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
				if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva')) {
					system.debug('@@@siamo nell\'if relativo a originalCase.PO_P2P_Attiva__c. verifichiamo: ' +  originalCase.PO_P2P_Attiva__c + ' quindi richiamiamo il metodo updateLog passandogli 2 parametri');
					// updateLog(casePadre.Id,originalCase.Id);
					updateLog(originalCase.Id);
				}
				//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
				return;
			}
			else{
				system.debug('@@@@ non coincidono');
				//non tutti i figli sono completati;
				originalCase.Status='Completato';
				originalCase.EOF_Fase__c='Completato';
				update originalCase;
				//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
				if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva')) {
					// updateLog(casePadre.Id,originalCase.Id);
					system.debug('@@@siamo nell\'if relativo a originalCase.PO_P2P_Attiva__c. verifichiamo: ' +  originalCase.PO_P2P_Attiva__c + ' quindi richiamiamo il metodo updateLog passandogli 1 parametro');
					updateLog(originalCase.Id);//aggiorniamo solo il child EC
				}
				//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
				return;
			}
		}
		system.debug('@@@@ ha solo un figlio');
		//qui significa che ha solo un figlio
		List<Case> caseToUpdate = new List<Case>();
		originalCase.Status='Completato';
		originalCase.EOF_Fase__c='Completato';
		Case casePadre = new Case();
		casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c;
		casePadre.EOF_Fase__c='Offerta Creata';
		caseToUpdate.add(originalCase);
		//20/09/2017 Modifica CRM - Se si tratta di fiber lease mista allora il campo PO_Durata_affitto__c sul case padre deve essere = 3
		if (originalCase.PO_Drop_FL_1__c == true)
		{
			casePadre.PO_Durata_affitto__c = 3;
		}
		//20/09/2017 END CRM
		update caseToUpdate;
		update CasePadre;
		System.debug('****AA SOLO UN FIGLIO, DOPO GLI UPDATE VALORE orginalCase.PO_P2P_Attiva__c = ' + originalCase.PO_P2P_Attiva__c);
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva')) {
			system.debug('@@@ci troviamo alla fine del metodo esitiCompletati, fuori da tutti gli altri if. Siamo nell\'if relativo a originalCase.PO_P2P_Attiva__c, verifichiamo: ' +  originalCase.PO_P2P_Attiva__c + ' quindi richiamiamo il metodo updateLog passandogli 2 parametri');
			updateLog(originalCase.Id);
			//  PO_P2P_Attiva_Utils.creaP2PAttOpportunity(CasePadre,originalCase);//EC 2018 - 08 - 13 //commentiamo il metodo dopo aver aggiornato il process builder PO Crea Oppty da Collegamento  2018 - 08 -16
			//updateLog(originalCase.Id);//aggiorniamo solo il child EC
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
	}

	public void presentaOfferta() {
		system.debug('PO_ServiziFattibilita_Controller presentaOfferta');
		originalCase.EOF_Fase__c='Offerta Presentata';
		update originalCase;
	}

	public void accettaOfferta() {
		system.debug('PO_ServiziFattibilita_Controller accettaOfferta');
		originalCase.Status='Accettato';
		originalCase.EOF_Fase__c='Offerta Accettata';
		update originalCase;
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c) {
			//commentiamo    updateLog(casePadre.Id,originalCase.Id);
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog

	}

	public String getCheckEspletamento() {
		system.debug('PO_ServiziFattibilita_Controller getCheckEspletamento');
		if (originalCase.PO_Data_Attivazione_Ordine__c == null) {
			return 'Data Attivazione Ordine';
		}
		else if (String.isBlank(originalCase.EOF_Id_Risorsa__c)) {
			return 'ID Risorsa';
		}
		else{
			return 'Espletamento OK';
		}
	}

	public void espletamento() {
		system.debug('@@@@@@@@@@EC chiamiamo il metodo espletamento()');
		originalCase.Status='Espletato';
		originalCase.EOF_Fase__c='Espletato';
		originalCase.OF_AggiornoOrdine__c = true;
		//gestione nuova P2P Attiva
		System.debug('originalCase.recordtypeid'+originalCase.recordtypeid);
		// RDG 2019-02-07
		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE)) {
			PO_ServFatt_CRMHandler_P2PAttiva crmh = new PO_ServFatt_CRMHandler_P2PAttiva(originalCase.RecordType.DeveloperName);
			crmh.espletamento(originalCase, true);
			return; 
		} 
		if (originalCase.RecordType.DeveloperName == RTypeServFattibilita.CASE_P2P_ORDINE_ELINE) {
			PO_ServFatt_CRMHandler handler = new PO_ServFatt_CRMHandler(RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE);
			handler.espletamento(originalCase, true);
			return;
		}
		/*if(originalCase.PO_P2P_Attiva__c || originalCase.RecordType.DeveloperName=='PO_Ordine_P2P_Attiva'){
		    List<Case> caseToUpdate = new List<Case>();
		    List<Order> oList=PO_P2PAtt_CRMHandler.aggiornaOrdine(originalCase);
		    List<Asset> aList=PO_P2PAtt_CRMHandler.createAsset();
		    Asset a=aList[0];
		    originalCase.assetId=a.Id;
		    PO_P2PAtt_CRMHandler.createCEI(originalCase,aList);
		    PO_P2PAtt_CRMHandler.createPBE(originalCase,aList); //per ora vuoto da rivedere
		    caseToUpdate.add(originalCase);
		    if(PO_P2PAtt_CRMHandler.checkKIT){
		        caseToUpdate.add(PO_P2PAtt_CRMHandler.caseKit);
		    }
		    update caseToUpdate;
		    return;
		   }*/


		//update originalCase;
		Map <string, OF_CaseOrderStateModelCS__c> mapCaseOrder = OF_CaseOrderStateModelCS__c.getAll();
		System.debug('mapCaseOrder@@'+mapCaseOrder);
		System.debug('@@ Stato case: ' + originalCase.status);
		OF_CaseOrderStateModelCS__c CustSett;
		for (String CaseOrderCS : mapCaseOrder.Keyset()) {
			if ( (originalCase.status == mapCaseOrder.get(CaseOrderCS).OF_StatoCase__c) &&
				(  (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2PELine__c).left(15))
				|| (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineIRU__c).left(15)) 
				|| (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLease__c).left(15)) 
				|| (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLink__c).left(15)) 
				|| (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2P__c).left(15)) 
				|| (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineEventoTemporaneo__c).left(15)) 
				|| (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2PAttiva__c).left(15)))) {
				CustSett = mapCaseOrder.get(CaseOrderCS);
				break;
			}
		}
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
		List<Order> o1List=[Select Id, OwnerId, ContractId, AccountId, Pricebook2Id, OriginalOrderId, OpportunityId, QuoteId, RecordTypeId,
							EffectiveDate, EndDate, IsReductionOrder, Status, Description, Type, Name, PoDate, PoNumber, OrderReferenceNumber, BillToContactId,
							ShipToContactId, ActivatedDate, ActivatedById, StatusCode, OrderNumber, TotalAmount, CreatedDate, CreatedById, LastModifiedDate,
							LastModifiedById, IsDeleted, SystemModstamp, LastViewedDate, LastReferencedDate, OF_Esito__c, OF_Apparato__c, OF_AreaGeografica__c,
							OF_Asset__c, OF_CaseID__c, OF_CaseNome__c, OF_Case__c, OF_Civico__c, OF_CodiceKO__c, OF_Comune__c, OF_Contratto__c, OF_DataEsito__c,
							OF_Datarichiesta__c, OF_DescrizioneKO__c, OF_EsitoConsegnaApparato__c, OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDContratto__c,
							OF_IDOrdineEOF__c, OF_IDOrdineOLO__c, OF_IDRisorsa__c, OF_IDSegnalazione__c, OF_IDSplitterSecondario__c, OF_IdNetworkInventory__c,
							OF_IdentificativoDelPOP__c, OF_Indirizzo__c, OF_IsFromAsset__c, OF_MotivazioneEsito__c, OF_POP__c, OF_ParticellaToponomastica__c,
							OF_PosizioneSplitterSecondario__c, OF_Provincia__c, OF_Regione__c, OF_ScalaPalazzina__c, OF_SlaPremiumAssurance__c, OF_TipologiaDiServizio__c,
							OF_Type__c, OF_Data_Cessazione__c, OF_TipologiaDiSegnalazione__c, OF_ClusterPromozione__c, OF_CodiceProgettoSpeciale__c, OF_IDCaso__c,
							OF_IDServizio__c, OF_PasswordApparato__c, OF_Profilo__c, OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c,
							OF_ProfiloOpenStream__c, PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_DataEspletamentoOrdine__c, PO_IsFromOpportunity__c,
							PO_LunghezzaOttica__c, PO_Opportunity__c, PO_PosizioneRilascioCircuitoOSU__c, isFiberLease__c, isFiberLink__c
							FROM Order Where Id = :originalCase.OF_Order__c];
		
		System.debug('#### PO_ServiziFattibilita_Controller.espletamento - o1List.size / originalCase.OF_Order__c: ' + 
			o1List.size() + ' / ' + originalCase.OF_Order__c);
			
		OF_UtilitiesManageOrderFromCase.AggiornoOrdine(originalCase, o1List[0], CustSett, mapCodifica);
		PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
		String proc = 'Portalino';
		if (o1List[0].isFiberLink__c == true) {
			proc = 'FiberLink';
		}
		else if (o1List[0].isFiberLease__c == true) {
			proc = 'FiberLease';
		}
		else if (originalCase.PO_P2P_Attiva__c) {
			proc = 'P2PAttiva';
			system.debug('@@@@@@@@@@@EC proc per p2p attiva è ' + proc);
		}
		if(!Test.isRunningTest()) {
			costruttore.PO_CreatePBE_Portalino( o1List, proc);
		}
		
		if (PO_ServiziFattibilita_Controller.createAssetId != null) {
			system.debug('@@@@@@@EC verifichiamo che  PO_ServiziFattibilita_Controller.createAssetId!=null, infatti è: ' + PO_ServiziFattibilita_Controller.createAssetId);
			originalCase.assetId=PO_ServiziFattibilita_Controller.createAssetId;
			o1List[0].OF_Asset__c=PO_ServiziFattibilita_Controller.createAssetId;
		}
		update o1List[0];
		update originalCase;

		system.debug('@@@@@@@@@@EC abbiamo appena fatto un update per o1List[0] che è ' + o1List[0] + ' e di originalCase, che è ' + originalCase);
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		//      if(originalCase.PO_P2P_Attiva__c || originalCase.RecordType.DeveloperName=='PO_Collegamento_P2P_Attiva'){
		//commentiamo  updateLog(originalCase.id);
		//   }
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog

	}
	public void Espletamento_KO() {
		originalCase.Status='Espletato KO';
		originalCase.EOF_Fase__c='Espletato KO';
		originalCase.OF_AggiornoOrdine__c = true;
		//update originalCase;

		// RDG 2019-02-07
		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
			PO_ServFatt_CRMHandler_P2PAttiva crmh = new PO_ServFatt_CRMHandler_P2PAttiva(originalCase.RecordType.DeveloperName);
			crmh.espletamento(originalCase, false);
			return;
		}
		/*
		   if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
		    system.debug('@@@@@@@EC if originalCase.PO_P2P_Attiva__c true o originalCase.RecordType.DeveloperName==PO_Ordine_P2P_Attiva: originalCase.PO_P2P_Attiva__c' + originalCase.PO_P2P_Attiva__c + ', oppure originalCase.RecordType.DeveloperName: ' + originalCase.RecordType.DeveloperName);
		    List<Case> caseToUpdate = new List<Case>();
		    List<Order> oList=PO_P2PAtt_CRMHandler.aggiornaOrdine(originalCase);
		    system.debug('@@@@@@@@EC Classe PO_ServiziFattibilita_Controller, direttamente nel metodo espletamento, dopo aver chiamato =PO_P2PAtt_CRMHandler.aggiornaOrdine, abbiamo generato oList: ' + oList);
		    caseToUpdate.add(originalCase);
		    update caseToUpdate;
		    return;
		   }
		 */


		Map <string, OF_CaseOrderStateModelCS__c> mapCaseOrder = OF_CaseOrderStateModelCS__c.getAll();
		OF_CaseOrderStateModelCS__c CustSett;
		for (String CaseOrderCS : mapCaseOrder.Keyset()) {
			if ( (originalCase.status == mapCaseOrder.get(CaseOrderCS).OF_StatoCase__c) &&
				 ( (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2PELine__c).left(15)) 
				 || (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineIRU__c).left(15)) 
				 || (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLease__c).left(15)) 
				 || (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLink__c).left(15)) 
				 || (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2P__c).left(15)) 
				 || (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineEventoTemporaneo__c).left(15)) 
				 || (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2PAttiva__c).left(15)))) {
				CustSett = mapCaseOrder.get(CaseOrderCS);
				break;
			}
		}
		Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
		List<Order> o1List=[Select Id, OwnerId, ContractId, AccountId, Pricebook2Id, OriginalOrderId, OpportunityId, QuoteId, RecordTypeId,
							EffectiveDate, EndDate, IsReductionOrder, Status, Description, Type, Name, PoDate, PoNumber, OrderReferenceNumber, BillToContactId,
							ShipToContactId, ActivatedDate, ActivatedById, StatusCode, OrderNumber, TotalAmount, CreatedDate, CreatedById, LastModifiedDate,
							LastModifiedById, IsDeleted, SystemModstamp, LastViewedDate, LastReferencedDate, OF_Esito__c, OF_Apparato__c, OF_AreaGeografica__c,
							OF_Asset__c, OF_CaseID__c, OF_CaseNome__c, OF_Case__c, OF_Civico__c, OF_CodiceKO__c, OF_Comune__c, OF_Contratto__c, OF_DataEsito__c,
							OF_Datarichiesta__c, OF_DescrizioneKO__c, OF_EsitoConsegnaApparato__c, OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDContratto__c,
							OF_IDOrdineEOF__c, OF_IDOrdineOLO__c, OF_IDRisorsa__c, OF_IDSegnalazione__c, OF_IDSplitterSecondario__c, OF_IdNetworkInventory__c,
							OF_IdentificativoDelPOP__c, OF_Indirizzo__c, OF_IsFromAsset__c, OF_MotivazioneEsito__c, OF_POP__c, OF_ParticellaToponomastica__c,
							OF_PosizioneSplitterSecondario__c, OF_Provincia__c, OF_Regione__c, OF_ScalaPalazzina__c, OF_SlaPremiumAssurance__c, OF_TipologiaDiServizio__c,
							OF_Type__c, OF_Data_Cessazione__c, OF_TipologiaDiSegnalazione__c, OF_ClusterPromozione__c, OF_CodiceProgettoSpeciale__c, OF_IDCaso__c,
							OF_IDServizio__c, OF_PasswordApparato__c, OF_Profilo__c, OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c,
							OF_ProfiloOpenStream__c, PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_DataEspletamentoOrdine__c, PO_IsFromOpportunity__c,
							PO_LunghezzaOttica__c, PO_Opportunity__c, PO_PosizioneRilascioCircuitoOSU__c, isFiberLease__c, isFiberLink__c
							FROM Order Where Id = :originalCase.OF_Order__c];
		OF_UtilitiesManageOrderFromCase.AggiornoOrdine(originalCase, o1List[0], CustSett, mapCodifica);
		update o1List[0];
		update originalCase;
	}

	/*EC 2018 - 12 - 17 commentiamo e riscriviamo il metodo replicando il comportamento di espletamento OK perché altrimenti non funziona l'espletamento KO per P2P Attiva.
	   public void Espletamento_KO(){
	    originalCase.Status='Espletato KO';
	    originalCase.EOF_Fase__c='Espletato KO';
	    originalCase.OF_AggiornoOrdine__c = true;
	    //update originalCase;
	    Map <string, OF_CaseOrderStateModelCS__c> mapCaseOrder = OF_CaseOrderStateModelCS__c.getAll();
	    OF_CaseOrderStateModelCS__c CustSett;
	    for(String CaseOrderCS : mapCaseOrder.Keyset()){
	        if( (originalCase.status == mapCaseOrder.get(CaseOrderCS).OF_StatoCase__c) &&
	           ((String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineIRU__c).left(15)) ||
	            (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLease__c).left(15)) ||
	            (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLink__c).left(15)) ||
	            (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2P__c).left(15)) ||
	            (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineEventoTemporaneo__c).left(15)) ||
	            (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2PAttiva__c).left(15))
	           )){
	               CustSett = mapCaseOrder.get(CaseOrderCS);
	               break;
	           }
	    }
	    Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
	    List<Order> o1List=[Select Id, OwnerId, ContractId, AccountId, Pricebook2Id, OriginalOrderId, OpportunityId, QuoteId, RecordTypeId,
	                        EffectiveDate, EndDate, IsReductionOrder, Status, Description, Type, Name, PoDate, PoNumber, OrderReferenceNumber, BillToContactId,
	                        ShipToContactId, ActivatedDate, ActivatedById, StatusCode, OrderNumber, TotalAmount, CreatedDate, CreatedById, LastModifiedDate,
	                        LastModifiedById, IsDeleted, SystemModstamp, LastViewedDate, LastReferencedDate, OF_Esito__c, OF_Apparato__c, OF_AreaGeografica__c,
	                        OF_Asset__c, OF_CaseID__c, OF_CaseNome__c, OF_Case__c, OF_Civico__c, OF_CodiceKO__c, OF_Comune__c, OF_Contratto__c, OF_DataEsito__c,
	                        OF_Datarichiesta__c, OF_DescrizioneKO__c, OF_EsitoConsegnaApparato__c, OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDContratto__c,
	                        OF_IDOrdineEOF__c, OF_IDOrdineOLO__c, OF_IDRisorsa__c, OF_IDSegnalazione__c, OF_IDSplitterSecondario__c, OF_IdNetworkInventory__c,
	                        OF_IdentificativoDelPOP__c, OF_Indirizzo__c, OF_IsFromAsset__c, OF_MotivazioneEsito__c, OF_POP__c, OF_ParticellaToponomastica__c,
	                        OF_PosizioneSplitterSecondario__c, OF_Provincia__c, OF_Regione__c, OF_ScalaPalazzina__c, OF_SlaPremiumAssurance__c, OF_TipologiaDiServizio__c,
	                        OF_Type__c, OF_Data_Cessazione__c, OF_TipologiaDiSegnalazione__c, OF_ClusterPromozione__c, OF_CodiceProgettoSpeciale__c, OF_IDCaso__c,
	                        OF_IDServizio__c, OF_PasswordApparato__c, OF_Profilo__c, OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c,
	                        OF_ProfiloOpenStream__c, PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_DataEspletamentoOrdine__c, PO_IsFromOpportunity__c,
	                        PO_LunghezzaOttica__c, PO_Opportunity__c, PO_PosizioneRilascioCircuitoOSU__c, isFiberLease__c, isFiberLink__c
	                        FROM Order Where Id = :originalCase.OF_Order__c];
	    OF_UtilitiesManageOrderFromCase.AggiornoOrdine(originalCase, o1List[0], CustSett, mapCodifica);
	    update o1List[0];
	    update originalCase;
	    //EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
	    if(originalCase.PO_P2P_Attiva__c || originalCase.RecordType.DeveloperName=='PO_Collegamento_P2P_Attiva'){
	        //commentiamo    updateLog(casePadre.Id,originalCase.Id);
	    }
	    //EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog

	   }
	 */
	public void sospendi() {
		system.debug('PO_ServiziFattibilita_Controller sospendi');
		if (ordineFattibilita) {
			originalCase.EOF_Data_Ora_Sospensione__c=system.now();
			originalCase.Status='Sospeso';
			originalCase.EOF_Fase__c='Sospeso';

			if (originalCase.eof_comunicazioni_con_olo__c != null) {
				originalCase.eof_comunicazioni_con_olo__c = originalCase.EOF_COmunicazioni_con_OLO__C + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Sospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;

			}else{
				originalCase.eof_comunicazioni_con_olo__c = OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Sospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;
			}
		}
		if (collegamentoFattibilita) {
			originalCase.EOF_Data_Ora_Sospensione__c=system.now();
			originalCase.Status='Sospeso';
			originalCase.EOF_Fase__c='Sospeso OF';

			if (originalCase.EOF_COmunicazioni_con_OLO__c != null) {
				originalCase.EOF_COmunicazioni_con_OLO__c =originalCase.EOF_COmunicazioni_con_OLO__C + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Sospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;
			}else{
				originalCase.EOF_COmunicazioni_con_OLO__c = OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Sospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;
			}
		}
		update originalCase;
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva')) {
			updateLog(originalCase.Id);
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog

	}

	public void inviaAlRefFat() {
		system.debug('PO_ServiziFattibilita_Controller inviaAlRefFat');
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
		system.debug('PO_ServiziFattibilita_Controller inviaAlTecFat');
		if (originalCase.EOF_Fase__c == 'In Lavorazione Network Creation') {
			ruoloDiPartenza='NetCreToTecFat';
		}
		if (originalCase.EOF_Fase__c == 'In Lavorazione Referente Fattibilità') {
			ruoloDiPartenza='RefFatToTecFat';
		}
	}

	public void desospendi() {
		system.debug('PO_ServiziFattibilita_Controller desospendi');
		//da rivedere il priorValue
		//System.debug('PO_ServiziFattibilita_Controller desospendi');
		originalCase.EOF_Data_Ora_Desospensione__c=system.now();
		originalCase.Status='Acquisito';
		originalCase.EOF_Fase__c='NA';
		if (originalCase.EOF_COmunicazioni_con_OLO__c != null) {
			originalCase.EOF_COmunicazioni_con_OLO__c =originalCase.EOF_COmunicazioni_con_OLO__C + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;

		}else{
			originalCase.EOF_COmunicazioni_con_OLO__c = OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + originalCase.Note_Sospensione_Operatore__c;

		}
		update originalCase;
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c || (originalCase.recordType.DeveloperName == 'PO_Collegamento_P2P_Attiva')) {
			updateLog(originalCase.Id);
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog

	}

	public void annulla() {
		System.debug('PO_ServiziFattibilita_Controller annulla');
		originalCase.Status='Annullato';
		originalCase.EOF_Fase__c='Annullato';
		update originalCase;
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c) {
			//commentiamo    updateLog(casePadre.Id,originalCase.Id);
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
	}

	public void PrendiInCarico() {
		//system.debug('CRM 02_08 userinfo.getUserId():'+userinfo.getUserId());
		//system.debug('CRM 02_08 collegamentoFattibilita:'+collegamentoFattibilita);
		system.debug('PO_ServiziFattibilita_Controller PrendiInCarico');
		if (collegamentoFattibilita) {
			system.debug('@@@@@@EC nell\'if collegamentoFattibilita');
			List<Case> caseToUpdate = new List<Case>();
			originalCase.Status='In Lavorazione';
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Referente Fattibilità') {
				originalCase.EOF_Fase__c='In Lavorazione Referente Fattibilità';
			}
			else if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Tecnico Fattibilità') {
				originalCase.EOF_Fase__c='In Lavorazione Tecnico Fattibilità';
			}
			else if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Network Creation') {
				originalCase.EOF_Fase__c='In Lavorazione Network Creation';
			}
			else if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Supporto Vendite') {
				originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';
			}
			else{

			}
			Case casePadre = new Case();
			casePadre.Id=originalCase.PO_Richiesta_a_fattibilit__c;
			casePadre.PO_P2P_Attiva__c= [SELECT PO_P2P_Attiva__c
										 FROM Case
										 WHERE Id = :originalCase.PO_Richiesta_a_fattibilit__c].PO_P2P_Attiva__c;//EC 2018 - 08 - 08 p2p Attiva

			casePadre.status='In Lavorazione';
			casePadre.EOF_Fase__c='In Lavorazione';
			originalCase.OwnerId=userinfo.getUserId();
			caseToUpdate.add(originalCase);
			caseToUpdate.add(casePadre);
			system.debug(caseToUpdate);
			update caseToUpdate;
			System.debug('****AA Valore id originalCase = ' + originalCase.Id);
			System.debug('****AA Valore id casePadre = ' + casePadre.Id);
			system.debug('@@@@@@EC casePadre.PO_P2P_Attiva__c è' + casePadre.PO_P2P_Attiva__c);//EC 2018 - 08 - 08 p2p Attiva

			if (casePadre.PO_P2P_Attiva__c) {
				system.debug('@@@@@@EC dal metodo PrendiInCarico chiamiamo il metodo future updateLog');
				updateLog(casePadre.Id,originalCase.Id);
			}
			return;
		}
		if (richiestaFattibilita) {
			system.debug('@@@@@@EC nell\'if richiestaFattibilita');
			originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';
			List<Case> caseToAssign = [select Id from Case where PO_Richiesta_a_fattibilit__c=:originalCase.Id];
			for (Case c : caseToAssign) {
				c.OwnerId=userinfo.getUserId();
			}
			originalCase.OwnerId=userinfo.getUserId();
			caseToAssign.add(originalCase);
			update caseToAssign;
			return;
		}
		//AS ordinefattibilita
		if (ordineFattibilita) {
			system.debug('@@@@@@EC nell\'if ordineFattibilita');
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Supporto Vendite') {
				originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';
			}
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Delivery') {
				originalCase.EOF_Fase__c='In Lavorazione Delivery';
			}
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Network Creation') {
				originalCase.EOF_Fase__c='In Lavorazione Network Creation';
			}
			/*
			   List<Case> caseToAssign = [select Id from Case where PO_Richiesta_a_fattibilit__c=:originalCase.Id];
			   for(Case c : caseToAssign){
			   c.OwnerId=userinfo.getUserId();
			   }*/
			originalCase.OwnerId=userinfo.getUserId();
			//caseToAssign.add(originalCase);
			update originalCase;
			//27-12-2018 V1 BUGFIX P2PATTIVA -- start
			if (originalCase.PO_P2P_Attiva__c || (originalCase.recordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
				updateLog(originalCase.Id);
			}
			//27-12-2018 V1 BUGFIX P2PATTIVA -- end
			return;
		}
		//EC Start kit p2p attiva prendi in carico per ingegneria 2018 - 09 - 28
		if (kitP2PAttiva) {
			system.debug('@@@@@@EC nell\'if kitP2PAttiva');
			originalCase.Status='In Lavorazione';
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Supporto Vendite') {
				originalCase.EOF_Fase__c='In Lavorazione Supporto Vendite';
			}
			if (originalCase.EOF_Fase__c == 'In Attesa Presa In Carico Ingegneria') {
				originalCase.EOF_Fase__c='In Lavorazione Ingegneria';
			}

			/*
			   List<Case> caseToAssign = [select Id from Case where PO_Richiesta_a_fattibilit__c=:originalCase.Id];
			   for(Case c : caseToAssign){
			   c.OwnerId=userinfo.getUserId();
			   }*/
			originalCase.OwnerId=userinfo.getUserId();
			//caseToAssign.add(originalCase);
			update originalCase;
			return;
		}

		//EC End kit p2p attiva prendi in carico per ingegneria 2018 - 09 - 28

		originalCase.OwnerId=userinfo.getUserId();
		system.debug('@@@@@@EC fuori dagli if');
		update originalCase;

	}

	public void kitVerificaOK() {
		system.debug('@@@@@@@EC Nel metodo kitVerificaOK');
		if (kitP2PAttiva) {
			originalCase.Status='Verificato';
			originalCase.EOF_Fase__c='Verificato OK';
			kitOK=true;
			update originalCase;

		}

	}

	public void kitVerificaKO() {
		system.debug('@@@@@@@EC Nel metodo kitVerificaKO');
		if (kitP2PAttiva) {
			originalCase.Status='Verificato KO';
			originalCase.EOF_Fase__c='Verificato KO';

			update originalCase;
		}

	}

	/*EC 2018 - 08 - 08 P2P Attiva
	   Metodo future per update stato Service Log  prendiamo in ingresso il parametro dell'id del parentCase
	 */
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
		Case childCase = [Select id, Status from Case where id=: idChildCase];

		EOF_EAI_Service_Log__c ChildLog = [SELECT id, EOF_Stato_Richiesta__c, EOF_STATO_ORDINE__c, Caso__c, eof_comunicazioni_con_olo__c, caso__r.Note_Sospensione_Operatore__c, EOF_NOTE__c
										   FROM EOF_EAI_Service_Log__c
										   WHERE Caso__c = :idChildCase
											   LIMIT 1];
		system.debug('@@@@EC chiamiamo nel metodo updateLog creiamo e popoliamo serviceLog, ChildLog i cui valori sono: ' + ChildLog + ', dovrebbe essere un solo ChildLog');
		ChildLog.EOF_STATO_ORDINE__c = childCase.Status;
		// faccio l'update del campo comunicazioni con OLO sul log
		if (ChildLog.eof_comunicazioni_con_olo__c != null) {
			ChildLog.eof_comunicazioni_con_olo__c = ChildLog.eof_comunicazioni_con_olo__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + ChildLog.caso__r.Note_Sospensione_Operatore__c;

		}else{
			ChildLog.eof_comunicazioni_con_olo__c =  OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + ChildLog.caso__r.Note_Sospensione_Operatore__c;

		}
		// finisce qui
		update ChildLog;
		system.debug('abbiamo appena terminato l\'update dello stato ChildLog, che adesso è: ' + ChildLog.EOF_STATO_ORDINE__c);
	}

	public void InviaAlNetworkCreation() {
		system.debug('@@@@@@@@EC PO_ServiziFattibilita_Controller InviaAlNetworkCreation');
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

		if (originalCase.RecordType.DeveloperName.contains('P2P_Attiva')) {
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
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva') || (originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
			updateLog(originalCase.id); //EC 2018 - 12 - 17
			//commentiamo    updateLog(casePadre.Id,originalCase.Id);
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog

	}
	public void InviaAlDelivery() {
		system.debug('PO_ServiziFattibilita_Controller InviaAlDelivery');
		if (originalCase.EOF_Fase__c == 'In Lavorazione Supporto Vendite') {
			originalCase.PO_Owner_Originario__c=userinfo.getUserId();
		}
		originalCase.Status='In Lavorazione';
		originalCase.EOF_Fase__c='In Attesa Presa In Carico Delivery';  // AS campbiato da In Lavorazione Delivery a In Attesa Presa In Carico Delivery

		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva') || (originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
			Group g1 = [select Id from Group where Type = 'Queue' AND DeveloperNAME = 'PO_Coda_Ordini_Delivery'];
			originalCase.ownerId=g1.Id;
			//commentiamo    updateLog(casePadre.Id,originalCase.Id);
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		else{
			Database.DMLOptions dmo = new Database.DMLOptions();
			dmo.assignmentRuleHeader.useDefaultRule = true;
			originalCase.setOptions(dmo);
		}
		update originalCase;

		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva') || (originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
			updateLog(originalCase.id); //EC 2018 - 12 - 17
			//commentiamo    updateLog(casePadre.Id,originalCase.Id);
		}

	}

	/* EC 2018 - 12 - 17 commentiamo inserendo un metodo qui sopra che faccia la stessa cosa, ma con un comportamento diverso per P2P Attiva.
	   public void InviaAlDelivery(){
	     system.debug('PO_ServiziFattibilita_Controller InviaAlDelivery');
	     if(originalCase.EOF_Fase__c=='In Lavorazione Supporto Vendite'){
	         originalCase.PO_Owner_Originario__c=userinfo.getUserId();
	     }
	     originalCase.Status='In Lavorazione';
	     originalCase.EOF_Fase__c='In Attesa Presa In Carico Delivery';  // AS campbiato da In Lavorazione Delivery a In Attesa Presa In Carico Delivery



	     Database.DMLOptions dmo = new Database.DMLOptions();
	     dmo.assignmentRuleHeader.useDefaultRule = true;
	     originalCase.setOptions(dmo);
	     update originalCase;
	     //EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
	     if(originalCase.PO_P2P_Attiva__c || originalCase.RecordType.DeveloperName=='PO_Collegamento_P2P_Attiva'){
	         //commentiamo    updateLog(casePadre.Id,originalCase.Id);
	     }
	     //EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
	   }
	 */
	public void InviaAlSupportoVendite() {
		system.debug('PO_ServiziFattibilita_Controller InviaAlSupportoVendite');
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
		//EC start 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog
		if (originalCase.PO_P2P_Attiva__c || ( originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva') || ( originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva') ) {
			updateLog(originalCase.id); //EC 2018 - 12 - 17
			//commentiamo    updateLog(casePadre.Id,originalCase.Id);
		}
		//EC end 2018 - 08 - 08 P2P Attiva richiamo metodo updateLog

	}

	public void assegnaAlTecnico() {
		system.debug('PO_ServiziFattibilita_Controller assegnaAlTecnico');
		List<Group> gList = [select Id,DeveloperName from Group where Type = 'Queue'];
		Map<String,Id> gMap = new Map<String,Id>();
		for (Group g : gList) {
			gMap.put(g.DeveloperName,g.Id);
		}
		originalCase.EOF_Fase__C='In Attesa Presa In Carico Tecnico Fattibilità';
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
		update originalCase;
	}

	public void confermaAssegnazione() {

		system.debug('@@@@@@@@@@@EC PO_ServiziFattibilita_Controller confermaAssegnazione');
		List<Case> caseFigli = new List<Case>();
		Map<String,Id> gMap = new Map<String,Id>();
		boolean check=true;

		for (Group g : [select Id,DeveloperName from Group where Type = 'Queue']) {
			gMap.put(g.DeveloperName,g.Id);
		}


		for (Case cf: [select Id, PO_Assegnazione_Area_Geografica__c, RecordType.DeveloperName from case where (PO_Richiesta_a_fattibilit__c=: originalCase.Id OR PO_Richiesta_a_fattibilit_KIT__c=:originalCase.Id) and PO_Incluso_nell_offerta__c=true]) {
			system.debug('@@@@@@@@@EC nel for cf ha il seguente rt ' + cf.RecordType.DeveloperName);

			if (cf.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva') {
				system.debug('@@@@@@@@@@@@@@@@EC rt di case figlio cf ' + cf.RecordType.DeveloperName);
				caseFigli.add(cf);

				if (String.isBlank(cf.PO_Assegnazione_Area_Geografica__c)) {
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
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Nord Est') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Nord Ovest') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Centro') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Sud') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Isole') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
					}

				}

			}
			else if (cf.RecordType.DeveloperName == 'PO_Case_P2P_Attiva_KIT') {
				system.debug('@@@@@@@@@@@@@@@@EC dentro else if relativo al recordtype. rt di case figlio cf ' + cf.RecordType.DeveloperName);
				caseFigli.add(cf);

				cf.status='Acquisito';
				cf.EOF_Fase__c='In Attesa Presa In Carico Ingegneria';    //Add 2018 - 09 - 28
				cf.ownerId=gMap.get('Coda_Ingegneria_P2PAttiva');       //Add 2018 - 09 - 28
				erroreAssegnazione=false;
			}
			else if (cf.RecordType.DeveloperName == 'PO Collegamento Backhauling') {
				caseFigli.add(cf);
				if (String.isBlank(cf.PO_Assegnazione_Area_Geografica__c)) {
					check=false;
					erroreAssegnazione=true;
					return;
				}
				else{
					originalCase.EOF_Fase__c='Assegnazione Confermata';
					cf.status='Acquisito';
					cf.EOF_Fase__c='In Attesa Presa In Carico Referente Fattibilità';
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Nord Est') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Nord Ovest') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Centro') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Sud') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Isole') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
					}
				}
			}
			else {

				system.debug('MM : dentro else per serevizi fattibilità diversi da P2P Attiva');

				if (String.isBlank(cf.PO_Assegnazione_Area_Geografica__c)) {
					system.debug('@@@@@@@@@@@@@@@@EC cf.PO_Assegnazione_Area_Geografica__c di case figlio cf ' + cf.PO_Assegnazione_Area_Geografica__c);
					check=false;
					erroreAssegnazione=true;
					return;
				}

				if (check) {

					system.debug('MM: dentro if per boolean check = true');

					originalCase.EOF_Fase__c='Assegnazione Confermata';

					cf.status='Acquisito';
					cf.EOF_Fase__c='In Attesa Presa In Carico Referente Fattibilità';
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Nord Est') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Est');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Nord Ovest') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Nord_Ovest');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Centro') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Centro');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Sud') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Sud');
					}
					if (cf.PO_Assegnazione_Area_Geografica__c == 'Isole') {
						cf.ownerId=gMap.get('PO_Coda_Ref_Fattibilit_Isole');
					}

					caseFigli.add(cf);

				}

			}
		}

		caseFigli.add(originalCase);

		update caseFigli;

		if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva') || (originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
			updateLog(originalCase.id); //EC 2018 - 12 - 17
			//commentiamo    updateLog(casePadre.Id,originalCase.Id);
		}

	}

	public void inserisciNote() {
		system.debug('PO_ServiziFattibilita_Controller inserisciNote');
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
			if (originalCase.PO_P2P_Attiva__c || (originalCase.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva') || (originalCase.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva')) {
				updateLog(originalCase.id); //EC 2018 - 12 - 17
				//commentiamo    updateLog(casePadre.Id,originalCase.Id);
			}
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
		if (ApexPages.currentPage().getParameters().get('Oper') == 'EspOK') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento OK - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento OK - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento OK - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento OK - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			espletamento();
		}
		if (ApexPages.currentPage().getParameters().get('Oper') == 'EspKO') {
			if (!String.isBlank(originalCase.EOF_Note_Operatore__c)) {
				if (String.isBlank(originalCase.EOF_Note_Interne__c)) {
					originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento KO - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				else{
					originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento KO - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note_Operatore__c;
				}
				originalCase.EOF_Note_Operatore__c='';
			}
			if (!String.isBlank(originalCase.EOF_Note__c)) {
				if (String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)) {
					originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento KO - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				else{
					originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - Espletamento KO - ' + userinfo.getName() + ':\n' + originalCase.EOF_Note__c;
				}
				originalCase.EOF_Note__c='';
			}
			Espletamento_KO();
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
		//27-12-2018 V1 BUGFIX P2PATTIVA -- start
		if (originalCase.recordType.DeveloperName == 'PO_Ordine_P2P_Attiva') {
			updateLog(originalCase.Id);
		}
		//27-12-2018 V1 BUGFIX P2PATTIVA --end
		return;
	}

	public static List<Case>  OrderCreation (List<Case> CaseFromPortal) {
		system.debug('PO_ServiziFattibilita_Controller OrderCreation');
		list<RecordType> RList =[select id, developerName from recordType];
		MAp<String,String> checkRType = new MAp<String,String>();
		for (recordType RT : RList) {
			checkRType.Put( rt.Id,rt.developerName);
		}
		if (checkRType.get(CaseFromPortal[0].recordtypeId).contains('Collegamento')) {
			list<Case> CaseToOrder =[select status, EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
									 PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
									 PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
									 recordtype.id,recordtype.developerName from case where id IN: CaseFromPortal];

			List<Case> caseToInsert = new List<Case>();
			MAp<String,String> rtMap = new MAp<String,String>();
			for (recordType RT : RList) {
				rtMap.Put(rt.developerName, rt.Id);
			}
			for (case cOld: CaseToOrder) {
			case c= new case ();
				c.status='Accettato';
				c.EOF_Fase__c='Bozza';
				c.PO_Case_Collegamento__c=cOld.Id;
				c.PO_Tipo_di_collegamento__c=cOld.PO_Tipo_di_collegamento__c;
				c.PO_Numero_fibre_richieste__c=cOld.PO_Numero_fibre_richieste__c;
				c.AccountId=cOld.AccountId;
				c.PO_Prime_Contractor__c=cOld.PO_Prime_Contractor__c;
				c.PO_Nome_sito__c=cOld.PO_Nome_sito__c;
				c.PO_Comune__c=cOld.PO_Comune__c;
				c.PO_Indirizzo_sito__c=cOld.PO_Indirizzo_sito__c;
				c.PO_Tipo_percorso__c=cOld.PO_Tipo_percorso__c;
				c.PO_Note_collegamento__c=cOld.PO_Note_collegamento__c;
				c.PO_Sito__c=cOld.PO_Sito__c;
				c.PO_Nota_sito__c=cOld.PO_Nota_sito__c;
				c.PO_Indirizzo_collegamento__c=cOld.PO_Indirizzo_collegamento__c;

				if (cOld.RecordType.developerName == 'PO_Collegamento_Fiber_link') {
					c.recordTypeid=rtMap.get('PO_Ordine_Fiber_link');
				}

				if (cOld.RecordType.developerName == 'PO_Collegamento_Fiber_lease') {
					c.recordTypeid=rtMap.get('PO_Ordine_Fiber_Lease');
				}

				if (cOld.RecordType.developerName == 'PO_Collegamento_IRU') {
					c.recordTypeid=rtMap.get('PO_Ordine_IRU');
				}

				if (cOld.RecordType.developerName == 'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb') {
					c.recordTypeid=rtMap.get('PO_Ordine_Misto_Fiber_Lease_Link_per_Fastweb');
				}

				if (cOld.RecordType.developerName == 'PO_Collegamento_P2P') {
					c.recordTypeid=rtMap.get('PO_Ordine_P2P');
				}
				caseToInsert.add(c);
			}
			try {
				insert caseToInsert;
			}
			catch (System.DmlException e) {

				return null;
			}
			return caseToInsert;
		}
		else{

			Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita'];
			for (case c: CaseFromPortal) {
				c.EOF_fase__c='In Attesa Presa In Carico Supporto Vendite';
				c.OwnerId=codaSupportoVendite.Id;
			}
			update CaseFromPortal;
			return null;
		}

	}

	public String urlRedir() {
		system.debug('PO_ServiziFattibilita_Controller urlRedir');
		return 'OK';
	}

	public void creaOrdine() {
		system.debug('PO_ServiziFattibilita_Controller creaOrdine');
		list<Case> CaseToOrder =[select status, EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
								 PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
								 PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
								 recordtype.id,recordtype.developerName from case where PO_Richiesta_a_fattibilit__c =: originalCase.Id];
		List<Case> caseToInsert = new List<Case>();
		list<RecordType> RList =[select id, developerName from recordType];
		MAp<String,String> rtMap = new MAp<String,String>();
		for (recordType RT : RList) {
			rtMap.Put(rt.developerName, rt.Id);
		}
		Group codaOrdiniFattiblita = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita'];
		for (case cOld: CaseToOrder) {
		case c= new case ();
			c.status='Accettato';
			c.EOF_Fase__c='Bozza';
			c.PO_Case_Collegamento__c=cOld.Id;
			c.PO_Tipo_di_collegamento__c=cOld.PO_Tipo_di_collegamento__c;
			c.PO_Numero_fibre_richieste__c=cOld.PO_Numero_fibre_richieste__c;
			c.AccountId=cOld.AccountId;
			c.PO_Prime_Contractor__c=cOld.PO_Prime_Contractor__c;
			c.PO_Nome_sito__c=cOld.PO_Nome_sito__c;
			c.PO_Comune__c=cOld.PO_Comune__c;
			c.PO_Indirizzo_sito__c=cOld.PO_Indirizzo_sito__c;
			c.PO_Tipo_percorso__c=cOld.PO_Tipo_percorso__c;
			c.PO_Note_collegamento__c=cOld.PO_Note_collegamento__c;
			c.PO_Sito__c=cOld.PO_Sito__c;
			c.PO_Nota_sito__c=cOld.PO_Nota_sito__c;
			c.PO_Indirizzo_collegamento__c=cOld.PO_Indirizzo_collegamento__c;

			if (cOld.RecordType.developerName == 'PO_Collegamento_Fiber_link') {
				c.recordTypeid=rtMap.get('PO_Ordine_Fiber_link');
			}

			if (cOld.RecordType.developerName == 'PO_Collegamento_Fiber_lease') {
				c.recordTypeid=rtMap.get('PO_Ordine_Fiber_Lease');
			}

			if (cOld.RecordType.developerName == 'PO_Collegamento_IRU') {
				c.recordTypeid=rtMap.get('PO_Ordine_IRU');
			}

			if (cOld.RecordType.developerName == 'PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb') {
				c.recordTypeid=rtMap.get('PO_Ordine_Misto_Fiber_Lease_Link_per_Fastweb');
			}

			if (cOld.RecordType.developerName == 'PO_Collegamento_P2P') {
				c.recordTypeid=rtMap.get('PO_Ordine_P2P');
			}

			c.EOF_fase__c='In Attesa Presa In Carico Supporto Vendite';
			c.OwnerId=codaOrdiniFattiblita.Id;
			caseToInsert.add(c);
		}
		originalCase.EOF_Fase__c='Ordini Creati';
		caseToInsert.add(originalCase);
		insert caseToInsert;
		for (Case c1: caseToInsert) {
			if (c1.RecordType.DeveloperName == 'PO_Ordine_P2P_Attiva') {
				updateLog(c.id); //EC 2018 - 12 - 17
				//commentiamo    updateLog(casePadre.Id,originalCase.Id);
			}
		}
	}

	public void setViewPopUpPSM () {
		if (originalCase.view_PopUp_PSM__c) {
			viewPopUpPSM=true;
		}
		else{
			viewPopUpPSM=false;
		}
	}

	public void setViewErrorFilePopUpPSM() {
		if (originalCase.view_error_file_PSM__c) {
			viewErrorFilePopUpPSM=true;
		}
		else{
			ViewErrorFilePopUpPSM=false;
		}
	}

	// 16/04/2018 MM : aggiunta metodo per pulsante InvioPSM.
	public void InvioPSM() {
		System.debug('PO_ServiziFattibilita_Controller - dentro InvioPSM');
		// qui aggiorno il case con le stesse azioni effettuate dal pulsante Invia A PSM.
		originalCase.Status ='In Lavorazione';                           //todo aspetto email di marianna
		originalCase.EOF_Fase__c= 'In Lavorazione Network Creation';
		originalCase.PO_FATT_History_Owner__c = UserInfo.getUserId();

		update originalCase;

		eof_notify__c iPSM = new eof_notify__c();
		iPSM.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM Notifica di Attivazione').getRecordTypeId();
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
		system.debug('eccolo');
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
		if ((attachList != null) && (attachList.size() > 0)) {
			insert PO_FATT_WS_PSM_Notify_Utils.attachingFileOutbound(attachList,slA.id);
		}
		system.debug('dopo attach');
	}
	// 16/04/2018 MM : fine aggiunta

	// 16/04/2018 MM : aggiunta metodo per pulsante AnnullaPSM.
	public void AnnullaPSM() {
		System.debug('PO_ServiziFattibilita_Controller - dentro AnnullaPSM');

		eof_notify__c aPSM = new eof_notify__c();
		aPSM.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM Notifica di Annullamento').getRecordTypeId();
		aPSM.EOF_Data_Notifica__c = system.now();
		aPSM.Caso__c = originalCase.id;
		//aPSM.EOF_ID_Notifica__c = aPSM.id;
		aPSM.motivo_rifiuto_sospensione_Annullamento__c ='test';
		insert aPSM;

		Case cpsmAn =[Select id, EOF_Note_Interne__c, EOF_Account_OLO__r.Name, casenumber,Account.Name from Case where ID =:aPSM.Caso__c];


		EOF_EAI_Service_Log__c slAN = new EOF_EAI_Service_Log__c();
		slAN.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_log__c.getRecordTypeInfosByName().get('PSM WS OUT Annullamento').getRecordtypeid();
		slAN.Caso__c = originalCase.id;
		slAN.Notify__c = aPSM.id;
		slAN.EOF_ID_Notifica__c = aPSM.Name;
		slAN.OF_SA_Azione__c =PO_FATT_WS_PSM_Notify_Utils.AZIONE_ANNULLAMENTO;
		slAN.EOF_Data_Notifica__c = aPSM.EOF_Data_notifica__c;
		slAN.EOF_Richiesta_Notifica__c=
			'NOTE_ORDINE: ' + cpsmAn.EOF_Note_Interne__c  + '\n' +
			//'PM_DI_RIFERIMENTO: '+ iPSM.caso__r.PO_Nome_E_Cognome_PM__c  + '\n' +
			//'ESITO_FATTIBILITA: '+ iPSM.Caso__r.PO_Case_Collegamento__r.PO_Esito_collegamento__c  + '\n' +
			//'ACCOUNT: '+ cpsmAn.EOF_Account_OLO__r.Name  + '\n' +
			'ACCOUNT: ' + PO_FATT_WS_PSM_Notify_Utils.getAccount(new EOF_Notify__c(Caso__r=cpsmAn)) + '\n' +  //fix del 01.06
			//'TIPO_DI_CONTRATTO: '+ iPSM.Caso__r.PO_Tipologia_Offerta_ordine__c  + '\n' +
			//'TIPO_xDI_PERCORSO: '+ iPSM.Caso__r.PO_Tipo_percorso__c + '\n' +
			//'TIPO_xDI_COLLEGAMENTO: '+ iPSM.Caso__r.PO_Tipo_di_collegamento__c  + '\n' +
			//'PRIME_CONTRACTOR: '+ iPSM.Caso__r.PO_Prime_Contractor__c  + '\n' +
			// 'ID_RISORSA: '+ cpsmAn.PO_Case_Collegamento__r.EOF_ID_Risorsa__c  + '\n' +
			//'FIBRE_RICHIESTE: '+ iPSM.Caso__r.PO_Numero_fibre_richieste__c + '\n' +
			//'RICHIEDENTE: '+ iPSM.Caso__r.Contact.Name  + '\n' +
			//'LUNGHEZZA_DROP_FL_2_LEASE: '+ iPSM.Caso__r.PO_Case_Collegamento__r.PO_Posa_2_nuovo_Drop__c + '\n' +
			//'PO_BB_2_via_interessato: '+ iPSM.Caso__r.PO_BB_2_via_interessato__c  + '\n' +
			'CODICE_ORDINE: ' + cpsmAn.casenumber  + '\n' +
			'ID_NOTIFICA: ' + aPSM.id  + '\n' +
			'DATA NOTIFICA: ' + string.valueof(aPSM.EOF_Data_notifica__c)  + '\n' +
			'AZIONE: ' + PO_FATT_WS_PSM_Notify_Utils.AZIONE_ANNULLAMENTO  + '\n';
		//'FATTIBILITA_CREATA_DA: '+ aPSM.Caso__r.PO_Case_Collegamento__r.LastModifiedBy.Name  + '\n' +
		//'DATA_ATTIVAZIONE_RICHIESTA_CLIENTE: '+ string.valueof(aPSM.Caso__r.PO_Data_Attivazione_Richiesta__c)  + '\n' +
		//'DATA_ORDINE: '+ string.valueof(aPSM.Caso__r.PO_Case_Collegamento__r.OF_Order__r.CreatedDate)  + '\n' +
		//'SUBINPUT: '+ iPSM.  + '\n' +
		//'DISPONIBILITA_RETE: '+ string.valueof(aPSM.Caso__r.PO_Disponibilit_della_rete_a_partire_da__c) + '\n' +
		//'PO_BB_1_INTERESSATO: '+ aPSM.Caso__r.PO_BB_1_interessato__c  + '\n' +
		//'PO_BB_2_INTERESSATO: '+ aPSM.Caso__r.PO_BB_2_interessato__c  + '\n' +
		//'POP_1_DI_RIFERIMENTO: '+ string.valueof(aPSM.Caso__r.PO_Pop_1_di_riferimento2__c)  + '\n' +
		//'POP_2_DI_RIFERIMENTO: '+ string.valueof(aPSM.Caso__r.PO_Pop_2_di_riferimento2__c) + '\n' +
		//'DROP_FL_1: '+ aPSM.Caso__r.PO_Drop_FL_1__c  + '\n' +
		//'DROP_FL_2: '+ aPSM.Caso__r.PO_Drop_FL_2__c  + '\n' +
		//'LUNGHEZZA DROP_LF_LEASE: '+ aPSM.Caso__r.PO_Posa_1_nuovo_Drop__c  + '\n' +
		//'POSA_1_NUOVO_CAVO: '+ aPSM.Caso__r.PO_Posa_1_via_nuovo_Drop__c  + '\n' +
		//'POSA_2__NUOVO_CAVO: '+ aPSM.Caso__r.PO_Posa_2_via_nuovo_Drop__c + '\n'+
		//'TEMPI_DI_ATTIVAZIONE_xMESI: '+ aPSM.Caso__r.PO_Tempi_di_attivazione_mesi__c  + '\n' +
		//'CAVO_ESISTENTE_1_VIA: '+ string.valueof(aPSM.Caso__r.PO_BB_1_via_interessato__c)  + '\n' +
		//'LUNGHEZZA_DROP_FL_1: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Lunghezza_m__c  + '\n' +
		//'LUNGHEZZA_DROP_FL_2: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Lunghezza_m2__c + '\n' +
		//'ID_CIRCUITO_TRATTA_2: '+ aPSM.ID_CIRCUITO_SECONDA_TRATTA__c + '\n' +
		//'NOTE_FATTIBILITA: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Note_fattibilit__c + '\n' +
		//'NOTE: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Note_Network_Creation__c  + '\n' +
		//'ID_COLLEGAMENTO: '+ aPSM.Caso__r.PO_Case_Collegamento__r.CaseNumber + '\n' +
		//'DATA_ORA_COMPLETAMENTO: '+ string.valueof(PO_FATT_WS_PSM_Notify_Utils.CaseHistoryTime(aPSM.Caso__c)) + '\n'

		insert slAN;

	}
	// 16/04/2018 MM : fine aggiunta

	// 17/04/2018 MM : aggiunta metodo per pulsante Cessazione.
	public void CessazionePSM() {
		System.debug('PO_ServiziFattibilita_Controller - dentro CssPSM');

		eof_notify__c cPSM = new eof_notify__c();
		cPSM.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM Notifica di Cessazione').getRecordTypeId();
		cPSM.EOF_Data_Notifica__c = system.now();
		cPSM.Caso__c = originalCase.id;
		//cPSM.Motivo_Rifiuto_Sospensione_Annullamento__c=''; da capire come popolarlo.
		//cPSM.EOF_Id_Notifica__c= cPSM.id;
		insert cPSM;


		Case cpsmcE =[Select id, EOF_Note_Interne__c, EOF_Account_OLO__r.Name, PO_Case_Collegamento__r.EOF_ID_Risorsa__c, casenumber,Account.Name from Case where ID =:cPSM.Caso__c];
		EOF_EAI_Service_Log__c slC = new EOF_EAI_Service_Log__c();
		slC.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_log__c.getRecordTypeInfosByName().get('PSM WS OUT Cessazione').getRecordtypeid();
		slC.Caso__c = originalCase.id;
		slC.Notify__c = cPSM.id;
		//slC.EOF_ID_Notifica__c = cPSM.Name;   //nella classe utility viene utilizzato questo campo, decidere se usare ancora questo ma cancellare notify o cosa // MM 11/05 nella utils viene utilizzato il campo EOF_ID_NOTIFICA della notify. Qui avevo pensato di usare il Name.
		slC.OF_SA_Azione__c =PO_FATT_WS_PSM_Notify_Utils.AZIONE_CESSAZIONE;
		slC.EOF_Data_Notifica__c = cPSM.EOF_Data_notifica__c;
		slC.EOF_Richiesta_Notifica__c=
			'NOTE_ORDINE: ' + cpsmcE.EOF_Note_Interne__c  + '\n' +
			//'PM_DI_RIFERIMENTO: '+ iPSM.caso__r.PO_Nome_E_Cognome_PM__c  + '\n' +
			//'ESITO_FATTIBILITA: '+ iPSM.Caso__r.PO_Case_Collegamento__r.PO_Esito_collegamento__c  + '\n' +
			//'ACCOUNT: '+ cpsmcE.EOF_Account_OLO__r.Name  + '\n' +
			'ACCOUNT: ' + PO_FATT_WS_PSM_Notify_Utils.getAccount(new EOF_Notify__c(Caso__r=cpsmcE)) + '\n' +  //fix del 01.06
			//'TIPO_DI_CONTRATTO: '+ iPSM.Caso__r.PO_Tipologia_Offerta_ordine__c  + '\n' +
			//'TIPO_xDI_PERCORSO: '+ iPSM.Caso__r.PO_Tipo_percorso__c + '\n' +
			//'TIPO_xDI_COLLEGAMENTO: '+ iPSM.Caso__r.PO_Tipo_di_collegamento__c  + '\n' +
			//'PRIME_CONTRACTOR: '+ iPSM.Caso__r.PO_Prime_Contractor__c  + '\n' +
			'ID_RISORSA: ' + cpsmcE.PO_Case_Collegamento__r.EOF_ID_Risorsa__c  + '\n' +
			//'FIBRE_RICHIESTE: '+ iPSM.Caso__r.PO_Numero_fibre_richieste__c + '\n' +
			//'RICHIEDENTE: '+ iPSM.Caso__r.Contact.Name  + '\n' +
			//'LUNGHEZZA_DROP_FL_2_LEASE: '+ iPSM.Caso__r.PO_Case_Collegamento__r.PO_Posa_2_nuovo_Drop__c + '\n' +
			//'PO_BB_2_via_interessato: '+ iPSM.Caso__r.PO_BB_2_via_interessato__c  + '\n' +
			'CODICE_ORDINE: ' + cpsmcE.casenumber  + '\n' +
			'ID_NOTIFICA: ' + cPSM.id  + '\n' +
			'DATA NOTIFICA: ' + string.valueof(cPSM.EOF_Data_notifica__c)  + '\n' +
			'AZIONE: ' + PO_FATT_WS_PSM_Notify_Utils.AZIONE_ANNULLAMENTO  + '\n' +
			'MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO:' + cPSM.Motivo_Rifiuto_Sospensione_Annullamento__c + '\n' +
			//'FATTIBILITA_CREATA_DA: '+ aPSM.Caso__r.PO_Case_Collegamento__r.LastModifiedBy.Name  + '\n' +
			//'DATA_ATTIVAZIONE_RICHIESTA_CLIENTE: '+ string.valueof(aPSM.Caso__r.PO_Data_Attivazione_Richiesta__c)  + '\n' +
			//'DATA_ORDINE: '+ string.valueof(aPSM.Caso__r.PO_Case_Collegamento__r.OF_Order__r.CreatedDate)  + '\n' +
			//'SUBINPUT: '+ iPSM.  + '\n' +
			//'DISPONIBILITA_RETE: '+ string.valueof(aPSM.Caso__r.PO_Disponibilit_della_rete_a_partire_da__c) + '\n' +
			//'PO_BB_1_INTERESSATO: '+ aPSM.Caso__r.PO_BB_1_interessato__c  + '\n' +
			//'PO_BB_2_INTERESSATO: '+ aPSM.Caso__r.PO_BB_2_interessato__c  + '\n' +
			//'POP_1_DI_RIFERIMENTO: '+ string.valueof(aPSM.Caso__r.PO_Pop_1_di_riferimento2__c)  + '\n' +
			//'POP_2_DI_RIFERIMENTO: '+ string.valueof(aPSM.Caso__r.PO_Pop_2_di_riferimento2__c) + '\n' +
			//'DROP_FL_1: '+ aPSM.Caso__r.PO_Drop_FL_1__c  + '\n' +
			//'DROP_FL_2: '+ aPSM.Caso__r.PO_Drop_FL_2__c  + '\n' +
			//'LUNGHEZZA DROP_LF_LEASE: '+ aPSM.Caso__r.PO_Posa_1_nuovo_Drop__c  + '\n' +
			//'POSA_1_NUOVO_CAVO: '+ aPSM.Caso__r.PO_Posa_1_via_nuovo_Drop__c  + '\n' +
			//'POSA_2__NUOVO_CAVO: '+ aPSM.Caso__r.PO_Posa_2_via_nuovo_Drop__c + '\n'+
			//'TEMPI_DI_ATTIVAZIONE_xMESI: '+ aPSM.Caso__r.PO_Tempi_di_attivazione_mesi__c  + '\n' +
			//'CAVO_ESISTENTE_1_VIA: '+ string.valueof(aPSM.Caso__r.PO_BB_1_via_interessato__c)  + '\n' +
			//'LUNGHEZZA_DROP_FL_1: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Lunghezza_m__c  + '\n' +
			//'LUNGHEZZA_DROP_FL_2: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Lunghezza_m2__c + '\n' +
			//'ID_CIRCUITO_TRATTA_2: '+ aPSM.ID_CIRCUITO_SECONDA_TRATTA__c + '\n' +
			//'NOTE_FATTIBILITA: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Note_fattibilit__c + '\n' +
			//'NOTE: '+ aPSM.Caso__r.PO_Case_Collegamento__r.PO_Note_Network_Creation__c  + '\n' +
			//'ID_COLLEGAMENTO: '+ aPSM.Caso__r.PO_Case_Collegamento__r.CaseNumber + '\n' +
			//GB 12.05 Start
			'DATA_ORDINE_COMPLETATO: ' + PO_FATT_WS_PSM_Notify_Utils.getDataOrdineCompletato(cPSM.Caso__c);
		//GB 12.05 End
		insert slC;
	}
	// 17/04/2018 MM : fine aggiunta.

	// DN
	public void inviaDOM() {
		
	}
}
public without sharing class PO_Serv_BTS_Riepilogo_Controller
{
	public static final String srvName = 'BTS';
	public String recordOfferta {get; set;}
	public boolean Ricerca {get; set;}
	public boolean searchCaseboolean {get; set;}
	public String OffertaSelected {get; set;}
	public String OffertaCheck {get; set;}
	public string profiloCommerciale {get; set;}
	public boolean viewError {get; set;}
	public boolean viewProfilo {get; set;}
	public List<Case> sortCases {get; set;}
	public List<EOF_EAI_Service_Log__c> sortLogs {get; set;} //2018 - 07 - 31 to substitute sortCases
	public String retUrl;
	public list<case> currentUserCases {get; set;}
	public list<EOF_EAI_Service_Log__c> currentUserLogs {get; set;}  //2018 - 07 - 31 to substitute currentUserCases
	public list<attachment> newAtt {get; set;}
	public list<attachment> attlst {get; set;}
	public list<attachment> attxlxs {get; set;}
	public String sortField {get; set;}
	public String myOrder {get; set;}
	public boolean StageName {get; set;}
	public Case caseObj {get; set;}
	public EOF_EAI_Service_Log__c logObj {get; set;}  //2018 - 07 - 31 to substitute caseObj
	public EOF_EAI_Service_Log__c kLogObj {get; set;}  //EC 2018 - 09 - 26 kLogObj
	public Case parentCaseObj {get; set;}
	public EOF_EAI_Service_Log__c parentLogObj {get; set;}   //2018 - 07 - 31 to substitute parentCaseObj
	public Case childCaseObj {get; set;}
	public EOF_EAI_Service_Log__c childLogObj {get; set;}    //2018 - 07 - 31 to substitute childCaseObj
	public boolean ordine {get; set;}
	public Case childCase {get; set;}
	public Case parentCase {get; set;}
	public case displayCase {get; set;}
	public EOF_EAI_Service_Log__c displayLog {get; set;} //2018 - 07 - 31 to substitute displayCase
	public list<opportunity> opp {get; set;}
	public boolean parentfile {get; set;}
	public EOF_EAI_Service_Log__c BTSLog {get; set;}
	public EOF_EAI_Service_Log__c BTSLogPadre {get; set;}
	public List<EOF_EAI_Service_Log__c>  BTSLogList {get; set;}
	public String searchTerm {get; set;}
	public String selectedIdComune {get; set;}
	public String selectedIdComune1 {get; set;}
	public String selectedIdComune2 {get; set;}
	public string comune {get; set;}
	public boolean caseobjbuttoncheck {get; set;}
	public boolean searchLogBoolean {get; set;}
	public list<case> ChildCases {get; set;}
	public list<case> ordercaselst {get; set;}
	public list<EOF_EAI_Service_Log__c> orderLoglst {get; set;} //2018 - 07 - 31 to substitute ordercaselst
	public string childDate {set; get;}
	public string CaseDetail {get; set;}
	public String ordLogDetail {get; set;}
	public string logDetail {get; set;}   //2018 - 07 - 31 to substitute CaseDetail
	public string offertEvento {get; set;}
	public string cliente {get; set;}
	public string cliente1 {get; set;}
	public string cliente2 {get; set;}
	public list<Attachment> orderAtt {get; set;}
	public string ordercasedispayordinedate {get; set;}
	public string orderLogdispayordinedate {get; set;}    //2018 - 07 - 31 to substitute ordercasedispayordinedate
	public string stringdate_In_PO_ModalController {get; set;}
	public case ordercasedit {get; set;}
	public EOF_EAI_Service_Log__c orderLogEdit {get; set;}   //2018 - 07 - 31 to substitute ordercasedit
	public boolean inlineshow {get; set;}
	public string textarea1 {get; set;}
	public date childrecdate {get; set;}
	public boolean showEdit {get; set;}
	public boolean childcheck {get; set;}
	public boolean orderline {get; set;}
	public List<Case> orderCases {get; set;}
	public List<EOF_EAI_Service_Log__c> orderLogs {get; set;}//2018 - 07 - 31 to substitute orderCases //cntrl ok
	public boolean invia {get; set;}
	public Id accId;
	public String Nome {get; set;}
	public case testcase {get; set;}
	public List<EOF_EAI_Service_Log__c> testlog {get; set;}
	public String PrntCaseID;
	public String PrntLogID;
	public String ParentDate {get; set;}
	public id childcasedisplayid {get; set;}
	public id childlogdisplayid {get; set;}
	public id ordLogId {get; set;}
	public id collOrdLogID {get; set;}//EC 2018 - 11 - 18 variabile per pescare l'id del collegamento che è il log di riferimento del logOrdine. da ripassare come parametro.
	//public id kitLogId{get;set;}	//EC 2018 - 09 - 26
	public case childcasedisplayobj {get; set;}
	public EOF_EAI_Service_Log__c childlogdisplayobj {get; set;}
	public opportunity childoppobj {get; set;}
	public string IndirizzoCliente {get; set;}
	public List<attachment> childlogdisplayattlist {get; set;}
	//public boolean VlanCollegamentiOK{get;set;}
	//public List<EOF_EAI_Service_Log__c> vLanList {get;set;} //rt OF_SA_VLAN
	public Opportunity parentOppty {get; set;}    //EC 2018 - 08 - 16
	public Opportunity childOppty {get; set;} //EC 2018 - 08 - 16
	public List<Opportunity> opptylst {get; set;} //EC 2018 - 08 - 16
	public List<Opportunity> parentOpptylst {get; set;} //EC 2018 - 08 - 16
	public Id orderId {get; set;}
	//public List<EOF_EAI_Service_Log__c>  listVLAN{get;set;}
	public Set<Id> setIdCollegamenti {get; set;}
	public EOF_EAI_Service_Log__c sl {get; set;}
	//public String kitId {get;set;} //EC 2018 - 09 - 24
	//public List<EOF_EAI_Service_Log__c> kitList {get;set;}  //EC 2018 - 09 - 24
	//public Static List<EOF_EAI_Service_Log__c> kitListToDelete {get;set;}  //EC 2018 - 09 - 24
	//public boolean checkKitSenzaVlan{get;set;}
	public map<String,String> rtMap;
	public List<EOF_EAI_Service_Log__c> slListToDelete;
	//public List<EOF_EAI_Service_Log__c> ListKitToSend;
	List<Attachment> attToDelete {get; set;} //EC 2018 - 10 - 12
	List<Attachment> attToInsert {get; set;}//EC 2018 - 10 - 15
	public boolean checkListColl {get; set;}
	public String pLogIdS {get; set;} //EC 2018 - 11 - 17
	public String OffUploadedId {get; set;}//EC 2018 - 11 - 17 variabile per aver l'id dell'attach dell'offerta allegata.
	public List<attachment> offUploadedList {get; set;} //EC 2018 - 11 - 17 variabile per aver l'attach dell'offerta allegata.
	public Boolean showOffUploadedAccepted {get; set;}

	public User usr {get; set;} //EC 2018 - 11 - 11

	public PO_Serv_BTS_Riepilogo_Controller () {
		returl=ApexPages.currentPage().getUrl();
		ChildCases = new List<Case>();
		BTSLogList = new List<EOF_EAI_Service_Log__c>(); //2018 - 07 - 31 to substitute  ChildCases
		parentLogObj = new EOF_EAI_Service_Log__c();
		attlst = new List<Attachment>();
		newAtt = new List<Attachment>();
		attxlxs = new List<Attachment>();
		orderCases = new List<Case>();
		orderLogs = new List<EOF_EAI_Service_Log__c>(); //2018 - 07 - 31 to substitute  orderCases
		//vLanList= new List<EOF_EAI_Service_Log__c>();
		opptylst= new List<Opportunity>(); //EC  2018 - 08 -16
		parentOpptylst= new List<Opportunity>();   //EC  2018 - 08 -16
		sortField = 'CreatedDate';
		myOrder = 'DESC';
		StageName = false;
		caseobjbuttoncheck=false;
		invia=false;
		checkListColl=false;
		offUploadedList = new List<Attachment>(); //EC 2018 - 11 - 17
		showOffUploadedAccepted=false;//EC 2018 - 11 - 17
		usr = [select Id,AccountId,Account.EOF_Codice_Operatore__c,ContactId,Contact.AccountId from user where Id=: userinfo.getUserId()];

		accId = usr.Contact.AccountId;
		// accId = [select id from account where type='OLO' AND name='OLOOF'].id;

		//kitList = new List<EOF_EAI_Service_Log__c>();
		//checkKitSenzaVlan=false;
		Set<Id> checkCollegamenti= new Set<Id>();
		//VlanCollegamentiOK = true;
		rtMap=OF_Utility.getRT_DevNameId_Map();
		setIdCollegamenti = new Set<Id>();
		set<Id> setidCaseCollegamenti = new Set<Id>(); //EC 2018 08 28
		//List<EOF_EAI_Service_Log__c> allVLAN = new List<EOF_EAI_Service_Log__c>();
		//faccio un set con gli id dei kit per verificare se tutti i kit hanno vlan associate
		//Set<Id> KitConVlan = new Set<Id>();
		//listVlan= new List<EOF_EAI_Service_Log__c>();
		if ((ApexPages.currentPage().getParameters().get('parentId') != null) && String.isNotBlank(ApexPages.currentPage().getParameters().get('parentId') )) {
			pLogIdS=ApexPages.currentPage().getParameters().get('parentId');//EC 2018 - 11 - 17
			parentLogObj = [SELECT Id,Name, Caso__c, Caso__r.Status,Caso__r.Createddate,Caso__r.Closeddate, PO_Offerta__c,
							PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c,
							EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c, PO_Note_Modifica_Offerta__c,
							PO_Offerta_Caricata__c, PO_Offerta_Inoltrata__c, EOF_ID_Pop__c, PO_Accordo_Quadro_Number__c,
			                //PO_P2PAttiva_Optical_Rate_Limiting__c,
			                //PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
			                //PO_P2PAttiva_Nome_del_KIT__c,
							caso__r.PO_Data_Espletamento_Ordine__c //FD 2019-03-08

							FROM EOF_EAI_Service_Log__c
							WHERE Id = :ApexPages.currentPage().getParameters().get('parentId')];

			slListToDelete = new List<EOF_EAI_Service_Log__c>();
			for (EOF_EAI_Service_Log__c log:[SELECT Id, Caso__c, Caso__r.Status, Caso__r.Parent.Status, Caso__r.casenumber, EOF_Codice_Ordine_OLO__c, Name,
				PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, EOF_Stato_Richiesta__c,PO_Offerta__c,
				EOF_Codice_Operatore__c, PO_Nome_Progetto__c, PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c,
				PO_Incluso_nell_offerta__c,PO_Numero_fibre_richieste__c, EOF_PROFILO__c, PO_Sito__c, PO_Civico__c, OF_PP_KIT_Log__c,
				PO_Nota_sito__c,EOF_STATO_ORDINE__c, OF_Id_Comune__c,Caso__r.ParentId,
				PO_Log_IdComune2__c,PO_Log_Comune_2__c, caso__r.PO_Tipo_percorso__c,

				//Modifica Toponomastica
				Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,

				EOF_INDIRIZZO__c,EOF_SITO__c,EOF_NUMERO_CIVICO__c,EOF_NOTA_SITO__c,

				//PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
				(SELECT Id, EOF_SL_Riferimento__c, OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_USER_VLAN__C, OF_SA_SERVICE_VLAN__C,
				OF_SA_PROFILO_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c,OF_PP_KIT_Log__c
				FROM EAI_Service_Logs__r)
				FROM EOF_EAI_Service_Log__c
				WHERE EOF_SL_Riferimento__c = :parentLogObj.Id
					//AND RecordType.DeveloperName = 'P2P_Attiva_Collegamento']){
					AND RecordType.DeveloperName = 'PO_Log_BTS_Collegamento']) {
				if (String.isBlank(log.EOF_Codice_Ordine_OLO__c)) {
					slListToDelete.add(log);
				}
				else{
					BTSLogList.add(log);
					setIdCollegamenti.add(log.Id);
					setidCaseCollegamenti.add(log.Caso__c); //EC 2018 08 28
					checkCollegamenti.add(log.Id);
					/*
					   List<EOF_EAI_Service_Log__c> vlanPerSingoloCollegamento = new List<EOF_EAI_Service_Log__c>();
					   for(EOF_EAI_Service_Log__c vlan : log.EAI_Service_Logs__r){
					    allVLAN.add(vlan);
					    if(!String.isBlank(vlan.OF_SA_KIT_CONSEGNA_VLAN__c)){
					        vlanPerSingoloCollegamento.add(vlan);
					        KitConVlan.add(vlan.OF_PP_KIT_Log__c);
					        listVlan.add(vlan);
					    }
					    else{
					        slListToDelete.add(vlan);
					    }
					   }
					 */
					/*
					   if(vlanPerSingoloCollegamento.isEmpty()){
					    VlanCollegamentiOK = false;
					   }
					 */
				}
			}
		}
		//EC start 2018 - 11 - 16
		checkListColl=(setIdCollegamenti.isEmpty()) ? true : false;

		//EC end 2018 - 11 - 16
		//EC start allegatiList dell'offerta accettata allegata 2018 - 11 - 17
		OffUploadedId=ApexPages.currentPage().getParameters().get('OffUploaded');
		if ((OffUploadedId != null) && (OffUploadedId != '')) {
			showOffUploadedAccepted=true;
			offUploadedList=[SELECT id,name,parentid,IsPrivate,createddate, Body
							 FROM attachment
							 WHERE Id =:OffUploadedId
								 OR (Name Like '%OffertaAccettata%' AND ParentId=:parentLogObj.id)];
		}
		offUploadedList=[SELECT id,name,parentid,IsPrivate,createddate, Body
						 FROM attachment
						 WHERE Name Like '%OffertaAccettata%'
						 AND ParentId=:parentLogObj.id];
		if (!offUploadedList.isEmpty()) {
			showOffUploadedAccepted=true;
		}


		//EC end allegatiList dell'offerta accettata allegata 2018 - 11 - 17


		if ((BTSLogList != null) && !BTSLogList.isEmpty()) {
			StageName = ( (BTSLogList[0].Caso__r.Status == 'In approvazione Cliente') ? true : false);
			/* AA 29/08/2018 IN SOSTITUZIONE TODO CONTROLLARE */


			//system.debug('il setIdCollegamenti è:'+ setIdCollegamenti);
			orderLogs = [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,
				CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c,
				EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate, caso__r.ClosedDate,
				Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c,
				Caso__r.PO_Data_Attivazione_Richiesta__c, Caso__r.PO_Numero_Telefonico_PM__c,
				NS_Rif__c,
				Particella_Toponomastica_1__c,
				PO_Indirizzo_collegamento__c, EOF_Comune__c,PO_Log_IdComune2__c,PO_Log_Comune_2__c,
				Caso__r.PO_Data_Espletamento_Ordine__c, PO_Civico__c,  //FD 2019-03-07
				caso__r.po_case_collegamento__r.PO_Tipo_percorso__c
				FROM EOF_EAI_Service_Log__c
				WHERE EOF_SL_Riferimento__c IN :setIdCollegamenti
				AND RecordType.DeveloperName = 'PO_Log_BTS_Ordine'];
			//PO_P2PAttiva_KIT_Indirizzo_Consegna__c
			//AND RecordType.DeveloperName = 'PO_P2P_Attiva_Ordine'];

			for (EOF_EAI_Service_Log__c esl : orderLogs) {
				if (((esl.Caso__r.PO_Nome_E_Cognome_PM__c != null) && (esl.Caso__r.PO_Nome_E_Cognome_PM__c != '')) && ((esl.Caso__r.PO_Data_Attivazione_Richiesta__c != null) && (esl.Caso__r.PO_Data_Attivazione_Richiesta__c != '')) && ((esl.Caso__r.PO_Numero_Telefonico_PM__c != null) && (esl.Caso__r.PO_Numero_Telefonico_PM__c != ''))) {
					parentFile=true;
				}else{
					parentFile=false;
					break;
				}
			}


			//system.debug('la lista di log è:'+ orderLogs);
			//Recupero la lista attachment
			list<attachment> newlst = [SELECT id,name,parentid,IsPrivate,createddate
									   FROM attachment
									   WHERE parentid =: parentLogObj.Caso__c
										   AND IsPrivate = false
										   AND Name LIKE '%PDF%'
										   ORDER BY createddate DESC limit 1];

			for (attachment att : newlst) {
				String attnamenew = att.Name;
				if (attnamenew.contains('.pdf')) {
					newAtt.add(att);
				}
			}

			list<attachment> attlstnew = [SELECT id,name,parentid,createddate
										  FROM attachment
										  WHERE parentid =: parentLogObj.Caso__c
											  ORDER BY createddate DESC];

			for (attachment att : attlstnew) {
				string attname = att.Name;
				if (attname.containsIgnoreCase('.pdf')) {
					attlst.add(att);
				}
			}

			if (attlst.size() > 1) {
				attlst.remove(0);
			}

			list<attachment> newlstxlxs = [SELECT id,name,parentid,IsPrivate,createddate
										   FROM attachment
										   WHERE parentid =: parentLogObj.Caso__c
											   AND IsPrivate = false
											   ORDER BY createddate DESC];

			for (attachment att : newlstxlxs) {
				String attnamexlxs = att.Name;
				if (attnamexlxs.contains('.xlsx')) {
					attxlxs.add(att);
				}
			}

			//EC Start 2018 - 09 - 24 KitList
			string ploId = parentLogObj.Id;
			/*
			   kitList = [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,
			           EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,
			           EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate,
			           caso__r.ClosedDate,Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c,
			           Caso__r.PO_Data_Attivazione_Richiesta__c,
			           Caso__r.PO_Numero_Telefonico_PM__c,PO_Indirizzo_collegamento__c, EOF_Comune__c,EOF_ID_Pop__c,
			           //PO_P2PAttiva_Optical_Rate_Limiting__c,
			           //PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
			           //PO_P2PAttiva_Nome_del_KIT__c
			           FROM EOF_EAI_Service_Log__c
			           WHERE RecordType.DeveloperName = 'PO_Log_P2P_Attiva_KIT' AND
			           EOF_SL_Riferimento__c =:ApexPages.currentPage().getParameters().get('parentId')];
			   //controllo se ci sono kit senza vlan
			   ListKitToSend = new List<EOF_EAI_Service_Log__c>();
			   if(!kitList.isEmpty())
			   {
			    for(EOF_EAI_Service_Log__c kit : kitList)
			    {
			        if(KitConVlan.add(kit.id)){
			            checkKitSenzaVlan=true;
			            slListToDelete.add(kit);
			            break;
			        }
			        else{
			            ListKitToSend.add(kit);
			        }
			    }
			   }
			 */
		}
	}

	public PageReference ParentDataOrderUpdation() {
		Set<Id> setIdOrderCases = new Set<Id>();
		Set<Id> seIdCollCases = new Set<Id>();//EC 2018 - 09 - 11

		Map<Id,Id> mapCollOrd = new Map<Id,Id>();


		for (EOF_EAI_Service_Log__c sLog : orderLogs) {
			setIdOrderCases.add(sLog.Caso__c);
			seIdCollCases.add(sLog.Caso__r.ParentId);//EC 2018 - 09 - 11

			mapCollOrd.put(sLog.Caso__r.ParentId,sLog.id);     //EC start 2018 - 10 - 12
		}

		//EC start 2018 - 10 - 12
		List<attachment> attList = [SELECT id,name,parentid,IsPrivate,createddate FROM attachment WHERE parentid IN : seIdCollCases];

		//EC end 2018 - 10 - 12

		List<Case> listOrderCases = [SELECT Id, Status, OwnerId
									 FROM Case
									 WHERE Id IN : setIdOrderCases
									 AND PO_Data_Attivazione_Richiesta__c != null
									 AND PO_Nome_E_Cognome_PM__c != null
									 AND PO_Numero_Telefonico_PM__c != null
									 AND Status = 'Accettato'];
		Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita'];
		for (Case caseToUpdate : listOrderCases) {
			caseToUpdate.OwnerId = codaSupportoVendite.Id;
		}
		//EC start 2018 - 10 - 12
		/* Commentiamo perché l'attach lo manteniamo legato al case di collegamento.
		   for(Id cId: seIdCollCases){

		   if(attList!=null && !attList.isEmpty()){
		   attToDelete = new List<Attachment>();
		   attToInsert = new List<Attachment>();

		   for(attachment a : attList){
		     attachment aClone= a.clone(false,false,false,false);
		     aClone.parentId=mapCollOrd.get(cId);
		     attToDelete.add(a);
		     attToInsert.add(aClone);
		   }
		   }
		   }
		   if(!attToInsert.isEmpty()){
		   insert attToInsert;
		   if(!attToDelete.isEmpty()){
		   //  delete attToDelete;
		   }
		   }
		 */
		//EC end 2018 - 10 - 12

		update listOrderCases;
		parentLogObj.PO_Offerta_Inoltrata__c = true;
		update parentLogObj;



		//Pagereference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
		Pagereference pg = new PageReference('/PO_Serv_BTS_Riepilogo');

		pg.getParameters().put('parentId',parentLogObj.Id);
		return pg;

	}



	public PageReference SearchLog() {
		Ricerca= true;
		searchLogboolean=true;
		offertaSelected='';
		OffertaCheck='';

		// EOFOpenStream=new List<EOF_EAI_Service_Log__c>();
		//EOFTroubleTicket=new List<EOF_EAI_Service_Log__c>();
		return new PageReference ('/apex/PO_SearchRequest');
	}

	public PageReference runSearchProfilo() {

		String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo');
		OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
		If(objListino != null) {
			profiloCommerciale=(string)objListino.OF_ProfiloCommerciale__c;
		}else{
			profiloCommerciale= 'N/A';
		}
		//profiloCommerciale ='TEST 2 TEST';
		viewError=false;
		viewProfilo=true;
		return null;
	}
//to delete?
	public pagereference currentUserParentCases()
	{
		newAtt.clear();
		//attxlxs.clear();
		attlst.clear();
		//system.debug('recordOfferta==>'+recordOfferta) ;

		set<id> parentcases = new set<id>();
		for (case cas: [select id from case where ContactId =: usr.contact.id AND PO_Offerta__c=:recordOfferta and recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit'])
		{
			parentcases.add(cas.id);
		}

		currentUserCases = [select id,PO_Tipologia_Offerta__c,casenumber,CreatedDate,PO_Offerta__c,Status,PO_Nome_Progetto__c,
							PO_Comune2__c from case
							where id IN: parentcases
							order by CreatedDate desc];
		//system.debug('currentUserCases====='+currentUserCases);
		sortCases =getsortingCases();
		//system.debug('currentUserCases====='+sortCases);
		return new pagereference ('/apex/Po_FeasibilityServicesRequest?recordOfferta=' + recordOfferta);

	}

/*
   public pagereference currentUserParentLogs()
   {
    newAtt.clear();
    //attxlxs.clear();
    attlst.clear();
    //system.debug('recordOfferta==>'+recordOfferta) ;

    set<id> parentLogs = new set<id>();
    //for(EOF_EAI_Service_Log__c lo : [select id from EOF_EAI_Service_Log__c where recordtype.developername = 'PO_P2PAttiva_Request'])
    for(EOF_EAI_Service_Log__c lo : [select id from EOF_EAI_Service_Log__c where recordtype.developername = 'PO_Log_BTS_Request'])
    {
        parentLogs.add(lo.id);
    }

    currentUserLogs = [select id,Name,CreatedDate,PO_Tipo_di_collegamento__c, PO_Tipo_percorso__c,
                       EOF_STATO_ORDINE__c,EOF_Stato_Richiesta__c,PO_Nome_Progetto__c, EOF_Codice_Ordine_OLO__c, PO_Nota_sito__c ,
                       PO_Log_IdComune2__c,PO_Log_Comune_2__c,EOF_Comune__c,OF_Id_Comune__c
                       from EOF_EAI_Service_Log__c
                       where id IN :parentLogs
                       order by CreatedDate desc];
    //system.debug('currentUserLogs====='+ currentUserLogs);
    sortLogs =getsortingLogs(); //to change getsortingCases con getsortingLogs
    //system.debug('currentUserLogs====='+ sortLogs);
    //return new pagereference ('/apex/Po_FeasibilityServicesRequest?recordOfferta='+recordOfferta);
    return new pagereference ('/PO_P2P_Attivo_DisplayRequest');
   }
 */

/*EC 2018 - 11 - 11
   public user usr {
    get{
        return [
            Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
            contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
            contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
            contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,contact.PO_Servizio_Incident_Management__c,
            contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c,Contact.Account.EOF_Codice_Operatore__c
            From User
            Where Id =:System.UserInfo.getUserId()
        ];
    }
   }
 */
//to delete?
	public list<case> getsortingCases()
	{ //system.debug('insideSortigCases'+sortCases) ;
		//system.debug('recordOfferta==>'+recordOfferta) ;
		String recOff=ApexPages.currentPage().getParameters().get('recordOfferta');
		//system.debug('pageparameter'+recOff) ;
		if (recordOfferta == null)
		{
			recordOfferta=recOff;
		}

		if (recordOfferta != null) {
			set<id> parentcases = new set<id>();

			for (case cas: [select id,parentid,PO_Nome_Progetto__c,parent.PO_Offerta__c,PO_Tipologia_Offerta__c,OwnerId from case where ContactId =: usr.contact.id AND PO_Tipologia_Offerta__c=:recordOfferta])
			{
				//if(cas.parent.PO_Offerta__c == 'P2P Base')
				parentcases.add(cas.parentid);
			}
			for (case cas: [select id from case where ContactId =: usr.contact.id AND PO_Offerta__c=:recordOfferta and recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit'])
			{
				parentcases.add(cas.id);
				//system.debug('case==='+cas);
			}

			string query = 'select id,casenumber,CreatedDate,PO_Offerta__c,PO_Nome_Progetto__c,Status from case where id IN :parentcases ';
			query += ' Order by ' +  String.escapeSingleQuotes(sortField) + ' ' + myOrder;

			return Database.query(query);
			//currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status from case where id IN :parentcases order by CreatedDate desc];
		}
		return SortCases;
	}

/*
   public list<EOF_EAI_Service_Log__c> getsortingLogs(){
    //system.debug('insideSortigLogs'+sortLogs) ;
    //system.debug('recordOfferta==>'+recordOfferta) ;
    String recOff=ApexPages.currentPage().getParameters().get('recordOfferta');
    //system.debug('pageparameter'+recOff) ;
    if(recordOfferta==null)
    {
        recordOfferta=recOff;
    }

    if(recordOfferta!= null){
        set<id> parentLogs = new set<id>();

        for(EOF_EAI_Service_Log__c lo : [select id,EOF_SL_Riferimento__c, EOF_Codice_Ordine_OLO__c, EOF_Stato_Richiesta__c,OwnerId,CreatedDate,PO_Nota_sito__c  from EOF_EAI_Service_Log__c  where PO_Contact__c =:usr.contact.id])
        {
            //if(cas.parent.PO_Offerta__c == 'P2P Base')
            parentLogs.add(lo.EOF_SL_Riferimento__c);
        }
        for(EOF_EAI_Service_Log__c lo : [select id from EOF_EAI_Service_Log__c where PO_Contact__c =:usr.contact.id and
                                         //recordtype.developername = 'PO_P2PAttiva_Request'])
                                         recordtype.developername = 'PO_Log_BTS_Request'])
        {
            parentLogs.add(lo.id);

        }

        string query = 'select id,casenumber,CreatedDate,PO_Offerta__c,PO_Nome_Progetto__c,Status from case where id IN :parentcases ';
        query += ' Order by ' +  String.escapeSingleQuotes(sortField) + ' ' + myOrder ;

        return Database.query(query);
        //currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status from case where id IN :parentcases order by CreatedDate desc];
    }
    return SortLogs;
   }
 */


	/**
	 * @returns TRUE if there is at lease one Case order linked to the main request, FALSE otherwise.
	 */
	private boolean isThereAnyCaseOrder(Case caseRichiesta) {
		List<Case> caseOrdini = [SELECT Id FROM Case WHERE PO_Richiesta_a_fattibilit_ordine__c = :caseRichiesta.Id];
		return !caseOrdini.isEmpty();
	}

	public pagereference OpportunityStageNameUpdate() {
		System.debug('@@@@@@@@@ Abbiamo cliccato sul bottone Accetta Offerta, che richiama il metodo OpportunityStageNameUpdate');
		String sId= ApexPages.currentPage().getParameters().get('parentId');
		System.debug('@@@@@@@@@ Abbiamo cliccato sul bottone Accetta Offerta, che richiama il metodo OpportunityStageNameUpdate, stiamo per querare i case a cui è legato il service log con questo id: ' + sId);
		parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, Id,EOF_Fase__c,ParentId, OF_Order__c, OF_Order__r.ContractId,

		                 //giovanni 29012018 inizio
						 PO_Comune2__c,
						 PO_Comune2__r.OF_Comune__c,
						 PO_Comune3__c,
						 PO_Comune3__r.OF_Comune__c,
						 PO_Comune4__c,
						 PO_Comune4__r.OF_Comune__c,
		                 //giovanni 29012018 fine

						 PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c,
						 Subject, Status, Priority, CreatedDate, CreatedById,PO_Offerta__c,
						 ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId
						 from case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=: sId) Limit 1];

		if (srvName.equalsIgnoreCase(parentcaseobj.PO_Offerta__c) && !isThereAnyCaseOrder(parentCaseObj)) //EC  2018 - 11 - 12 modificato il valore del campo offerta invece di P2P Attiva
		{
			ordine = true;
			//parentfile = false;

			opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Numero_Anni__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,
				   (SELECT Id,Name,ParentId,ContentType from Attachments)
				   from opportunity where PO_Richiesta_fattibilit__r.id =: parentLogObj.Caso__c and PO_Collegamento__c = null limit 1];


			list<opportunity> opplst = [select id,name,PO_Prezzo_totale_scontato__c,stagename,PO_Richiesta_fattibilit__c from opportunity
										where id in : opp limit 1
			];


			if (( opplst.size() > 0) && !opplst.isEmpty())
			{

				if (opplst[0].stagename == 'Offerta presentata')
				{
					opplst[0].StageName = 'Offerta accettata';
					update opplst[0];
				}

			}
			if (parentCaseObj != null)
			{
				// RDG 2019-01-31
				if (String.isNotBlank(parentCaseObj.OF_Order__c) && String.isNotBlank(parentCaseObj.OF_Order__r.ContractId)) {
					parentCaseObj.OF_IDContratto__c = parentCaseObj.OF_Order__r.ContractId;
					System.debug('Contratto [' + parentCaseObj.OF_IDContratto__c + '] - Case: ' + parentCaseObj.Id);
				}

				if (opplst[0].StageName != null)
				{
					parentCaseObj.Status = 'Accettato';

					parentCaseObj.Accordo_Operativo__c = 'Identificativo della richiesta di Fattibilità';

					parentCaseObj.OwnerId = UserInfo.getUserId();
					parentLogObj.EOF_STATO_ORDINE__c = parentCaseObj.Status;

					//Popolo i campi Accordo Quadro e Accordo Operativo
					parentLogObj.Accordo_Operativo__c = parentCaseObj.CaseNumber;
					parentCaseObj.Accordo_Operativo__c = parentCaseObj.CaseNumber;

					parentCaseObj.PO_Accordo_Quadro_Number__c = parentLogObj.PO_Accordo_Quadro_Number__c;

					//giovanni 28012019 inizio
					//Modifica ContractId
					//parentCaseObj.PO_Accordo_Quadro__c = parentLogObj.PO_Accordo_Quadro_Number__c;
					if (String.isNotBlank(parentLogObj.PO_Accordo_Quadro_Number__c))
					{
						List<Contract> theContractList = [SELECT Id FROM Contract WHERE OF_IdContratto__c = :parentLogObj.PO_Accordo_Quadro_Number__c AND Status = 'Attivo'];
						if (( theContractList != null) && ( theContractList.size() > 0) )
						{
							parentCaseObj.PO_Accordo_Quadro__c = theContractList[0].Id;
							// RDG 2019-01-31
							parentCaseObj.OF_IDContratto__c = theContractList[0].Id;
						}
					}
					//giovanni 28012019 fine
				}
				update parentLogObj;
				update parentCaseObj;
				list<case> childcaselst = [select id,PO_IndrizoCal__c,PO_Incluso_nell_offerta__c,
										   PO_Comune2__c,
										   PO_Comune2__r.OF_Comune__c, //giovanni 29012018
										   status,casenumber,
										   PO_Nome_Comune__c,CreatedDate,ClosedDate,parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,
										   PO_Tipo_di_collegamento__c,PO_Numero_fibre_richieste__c,AccountId,PO_Prime_Contractor__c,PO_Nome_sito__c,
										   PO_Comune__c,PO_Indirizzo_sito__c,PO_Tipo_percorso__c,PO_Note_collegamento__c,PO_Sito__c,PO_Nota_sito__c,
										   PO_Indirizzo_collegamento__c,recordtype.id,recordtype.developerName,OwnerId,PO_Case_Collegamento__r.PO_Incluso_nell_offerta__c,
										   PO_Comune3__c,
										   PO_Comune3__r.OF_Comune__c, //giovanni 29012018
										   PO_sito_3__c,PO_Nota_sito_3__c,

				                           //Modifica Toponomastica
										   Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,

										   PO_Comune4__c,
										   PO_Comune4__r.OF_Comune__c, //giovanni 29012018
										   PO_indirizzo_collegamento_3__C,PO_civico_3__c,
										   PO_Drop_FL_1__c,PO_Sito_partenza__c,PO_Civico_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Nota_sito_partenza__c,
										   PO_Civico__c,PO_Richiesta_a_fattibilit__c,EOF_Codice_Operatore_WS__c, (Select Id,Caso__c from EAI_Service_Logs1__r where RecordType.DeveloperName='PO_Log_BTS_Collegamento')
										   from case where parentid=: parentCaseObj.id and PO_Incluso_nell_offerta__c = true];
				//EC  2018 - 11 - 12 modificato il recordtype developername PO_Log_BTS_Collegamento invece di quello usato per il collegamento di p2pattiva
				//system.debug('childcaselst======='+parentCaseObj.PO_Durata_affitto__c);
				system.debug('@@@@@@@@EC chiamando il metodo OpportunityStageNameUpdate abbiamo popolato una lista di collegamenti stampiamo la dimensione: ' + childcaselst.size());

				if (childcaselst.size() > 0) {
					system.debug('@@@@@@@@EC siamo in nell\'if relativo a lista di collegamenti con dimensione > di 0, infatti conta: ' + childcaselst.size() + ' collegamenti. Stiamo per chiamare il metodo di creazione degli ordini.');
					parentfile = true;
					stagename = false;

					OrderCreation(childcaselst);

					// PO_ServiziFattibilita_Controller. childcaselst);
				}

			}
		}

		//Pagereference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
		Pagereference pg = new PageReference('/PO_Serv_BTS_Riepilogo');
		pg.getParameters().put('parentId',sId);
		return pg;
	}


	public Pagereference SaveParentChildCaseInfo()
	{
		BTSLog = new EOF_EAI_Service_Log__c();
		searchCaseBoolean=false;
		searchLogBoolean=false;
		stageName=false;
		parentfile=false;
		Ordine = false;
		newAtt.clear();
		attxlxs.clear();
		attlst.clear();
		string parentid = '';
		String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');
		//system.debug('testParentIdSave'+testParentIdSave);
		try {
			OF_ElencoComuniItaliani__c ag = new OF_ElencoComuniItaliani__c();
			OF_ElencoComuniItaliani__c ag1 = new OF_ElencoComuniItaliani__c();
			OF_ElencoComuniItaliani__c ag2 = new OF_ElencoComuniItaliani__c();
			//system.debug('selectedIdComune====='+selectedIdComune);
			if (( selectedIdComune != null) && ( selectedIdComune != '') && ( selectedIdComune != 'Inserisci qui il nome comune') )
			{
				ag = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune limit 1];
				//system.debug('Commune Name--->'+ag.OF_Comune__c);
			}
			if (( selectedIdComune1 != null) && ( selectedIdComune1 != '') && ( selectedIdComune1 != 'Inserisci qui il nome comune') )
			{
				ag1 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune1 limit 1];
				//system.debug('Commune Name--->'+ag1.OF_Comune__c);
			}

			if (( selectedIdComune2 != null) && ( selectedIdComune2 != '') && ( selectedIdComune2 != 'Inserisci qui il nome comune') )
			{
				ag2 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune2 limit 1];
				//system.debug('Commune Name--->'+ag2.OF_Comune__c);
			}
			if (ag != null)
			{
				if (ChildCase.PO_Comune2__c == null)
				{
					try
					{
						ChildCase.PO_Comune2__c = ag.id;
					}
					catch (exception e)
					{
						//system.debug('error==='+e.getStackTraceString());
					}
				}
			}
			if (ag1 != null)
			{
				if (ChildCase.PO_Comune3__c == null)
				{
					try
					{
						ChildCase.PO_Comune3__c = ag1.id;
					}
					catch (exception e)
					{
						//system.debug('error==='+e.getStackTraceString());
					}
				}
			}

			if (ag2 != null)
			{
				if (ChildCase.PO_Comune4__c == null)
				{
					try
					{
						ChildCase.PO_Comune4__c= ag2.id;
						//system.debug('Commune Name--->'+ ChildCase.PO_Comune4__c);
					}
					catch (exception e)
					{
						//system.debug('error==='+e.getStackTraceString());
					}
				}
			}
			string caseid = '';

			if (( parentCase != null) && ( parentCase.id != null) )
			{
				// parentid  = parentCase.id;
				parentid  = testParentIdSave;
				//system.debug('Saving ChildCase'+ParentCase.id);

			}
			if (( parentcaseobj != null) && ( parentcaseobj.id != null) )
			{
				parentid  = parentcaseobj.id;
			}
			if (childCase.id != null)
			{
				update childCase;
				//system.debug('Commune Name--->'+ ChildCase.PO_Comune4__c);
				caseid = childCase.id;
				parentid  = childCase.parentid;
			}
			if (childCaseObj.id != null)
			{
				//if(childCaseObj.PO_Comune2__c == null)
				childCaseObj.PO_Comune2__c =selectedIdComune;
				if (selectedIdComune1 != '') {
					if (selectedIdComune1.contains('a0D')) {
						childCaseObj.PO_Comune3__c =selectedIdComune1;
					}
				}
				if (selectedIdComune2 != '') {
					if (selectedIdComune1.contains('a0D')) {
						childCaseObj.PO_Comune4__c =selectedIdComune2;
					}
				}
				update childCaseObj;
				caseid = childCaseObj.id;
				parentid  = childCaseObj.parentid;
			}

			displayCase = [select id, casenumber,parentid,PO_Comune2__c,PO_Durata_mesi__c,PO_Comune2__r.id,PO_Comune2__r.OF_Comune__c from case where id =: caseid];
			//system.debug('Updated ChildCase--->'+ChildCase);
			comune = displayCase.PO_Comune2__r.OF_Comune__c;

		}
		catch (exception e) {
			//system.debug('Error Message-->'+e.getStackTraceString());
		}

		parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById,
						 PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=: parentid Limit 1];

		list<Case> childcaseList = [SELECT Case.Parent.casenumber,PO_Durata_mesi__c,PO_IndrizoCal__c,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
									CaseNumber,PO_Nome_Comune__c, po_comune2__c,PO_Comune2__r.OF_Comune__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Richiesta_a_fattibilit__r.casenumber,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c, Priority,Previous_Status__c, CreatedDate, CreatedById, PO_Offerta__c,OwnerId
									from case where parentId=: parentCaseObj.id
									order by casenumber ASC];

		parentcase = parentCaseObj;
		if (parentcaseobj.status == 'Bozza')
		{

			caseobjbuttoncheck=true;

		}

		ChildCases = childcaseList;
		// ChildCases.sort();
		return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id=' + parentCaseObj.id);
	}

//EC end 2018 08 29

	public List<Case> OrderCreation (List<Case> CaseFromPortal) {
		System.debug('@@@@@@@@EC ci troviamo ora nel metodo di creazione degli ordini, OrderCreation, gli abbiamo appena passato come parametro una lista di Case: ' + CaseFromPortal);

		OF_UtilitiesManageOrderFromCase obju = new OF_UtilitiesManageOrderFromCase();
		//List<EOF_EAI_Service_Log__c> vLanToUpdate = new  List<EOF_EAI_Service_Log__c>();/*EC 2018 - 09 - 11 bisogna legare le vlan agli ordini,
		//sia ai Case Ordine sia ai Log Ordine, ma mantenendo anche la relazione
		//con i case di Collegamento, abbiamo quindi creato dei nuovi campi di lookup
		// su EOF_EAI_Service_Log__c*/
		List<Case> caseToInsert = new List<Case>();

		//EC Start 2018 - 08 - 29 CaseToOrder già contiene i case di collegamento
		//
		//		vLanToUpdate=[];
		List<Case> CaseToOrder =[SELECT Id, OF_IDContratto__c, status, CaseNumber, PO_IndrizoCal__c,PO_Case_Collegamento__r.PO_Incluso_nell_offerta__c, EOF_fase__c,
								 PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,PO_Numero_fibre_richieste__c,
								 PO_Comune3__c, PO_Comune3__r.OF_Comune__c, //giovanni 29012018
								 PO_sito_3__c, PO_Nota_sito_3__c, PO_Comune4__c, Account.EOF_Codice_Operatore__c,
								 PO_Comune4__r.OF_Comune__c, //giovanni 29012018
								 PO_indirizzo_collegamento_3__C,PO_civico_3__c,PO_Drop_FL_1__c, AccountId,
								 PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,PO_Tipo_percorso__c,
								 PO_Comune2__c, PO_Comune2__r.OF_Comune__c, //giovanni 29012018
								 PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,PO_Sito_partenza__c,
								 PO_Civico_partenza__c, PO_Indirizzo_collegamento_partenza__c, PO_Nota_sito_partenza__c, PO_Civico__c,

		                         //Modifica Toponomastica
								 Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,

								 recordtype.id,recordtype.developerName,PO_Richiesta_a_fattibilit__c,OwnerId,EOF_Codice_Operatore_WS__c,
								 PO_KIT_Consegna_VLAN__c,
								 (SELECT Id,Caso__c from EAI_Service_Logs1__r where RecordType.DeveloperName='PO_Log_BTS_Collegamento')
								 FROM case where id IN: CaseFromPortal];
		//EC  2018 - 11 - 12 modificato il recordtype developername PO_Log_BTS_Collegamento invece di quello usato per il collegamento di p2pattiva   (P2P_Attiva_Collegamento)
		//system.debug('La lista di case di clg è:'+CaseToOrder.size());


		List<Case> caseOrderToUpdate = new List<Case>(); //EC 2018 - 08 - 29
		System.debug('@@@@@@@EC abbiamo appena creato la lista di CaseOrdine di cui fare l\'update caseOrderToUpdate, mentre si è popolata la lista di Case da cui verrà creato l\'ordine CaseToOrder ' + CaseToOrder);

		List<Contract> theContractList = null;
		if (String.isNotBlank(parentCaseObj.PO_Accordo_Quadro_Number__c)) {
			theContractList = [SELECT Id, OF_IDContratto__c FROM Contract WHERE OF_IdContratto__c = :parentCaseObj.PO_Accordo_Quadro_Number__c AND Status = 'Attivo'];
		}

		Set<Id> caseParentIds = new Set<Id>();

		for (Case c : CaseToOrder) {
			system.debug('@@@@@@@@EC per ogni Case appartenente alla lista di CaseToOrder creaiamo un nuovo Case con questo RecordType: PO_Ordine_BTS');
			//system.debug('EOF_Codice_Operatore_WS__c: ' + c.EOF_Codice_Operatore_WS__c);

			caseParentIds.add(c.Id);
			Case cs = new case ();
				cs.status='Accettato';
				cs.ParentId=c.Id;
				String codiceOlo = String.isNotBlank(c.EOF_Codice_Operatore_WS__c) ? c.EOF_Codice_Operatore_WS__c : c.Account.EOF_Codice_Operatore__c;
				cs.EOF_Codice_Operatore_WS__c = codiceOlo;
				cs.EOF_Fase__c='In lavorazione supporto vendite';
				cs.PO_Case_Collegamento__c=c.Id;
				// RDG 2019-01-31
				cs.OF_IDContratto__c=c.OF_IDContratto__c;
				cs.PO_Tipo_di_collegamento__c=c.PO_Tipo_di_collegamento__c;
				cs.PO_Numero_fibre_richieste__c=c.PO_Numero_fibre_richieste__c;
				//cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-26 EOF_Codice_Ordine_OLO__c su case ordine
				//Modifica Toponomastica
				cs.Particella_Toponomastica_1__c = c.Particella_Toponomastica_1__c;
				cs.Particella_Toponomastica_2__c = c.Particella_Toponomastica_2__c;
				cs.Particella_Toponomastica_3__c = c.Particella_Toponomastica_3__c;

				cs.AccountId=c.AccountId;
				cs.PO_Prime_Contractor__c=c.PO_Prime_Contractor__c;
				cs.PO_Nome_sito__c=c.PO_Nome_sito__c;
				cs.PO_KIT_Consegna_VLAN__c=c.PO_KIT_Consegna_VLAN__c;
				//cs.PO_Comune2__c =c.PO_Comune2__c;
				//cs.PO_Indirizzo_sito__c=c.PO_Indirizzo_sito__c;
				cs.PO_Tipo_percorso__c=c.PO_Tipo_percorso__c;
				//cs.PO_Note_collegamento__c=c.PO_Note_collegamento__c;
				cs.PO_Sito__c=c.PO_Sito__c;
				cs.PO_Nota_sito__c=c.PO_Nota_sito__c;
				cs.PO_Indirizzo_collegamento__c=c.PO_Indirizzo_collegamento__c;

				cs.PO_Sito_partenza__c= c.PO_Sito_partenza__c;
				cs.PO_Civico_partenza__c= c.PO_Civico_partenza__c;
				cs.PO_Indirizzo_collegamento_partenza__c= c.PO_Indirizzo_collegamento_partenza__c;
				cs.PO_Nota_sito_partenza__c= c.PO_Nota_sito_partenza__c;

				//giovanni 29012018 inizio
				cs.PO_Comune__c = c.PO_Comune__c;
				cs.PO_Comune2__c = c.PO_Comune2__c;
				cs.PO_Comune3__c = c.PO_Comune3__c;
				cs.PO_Comune4__c = c.PO_Comune4__c;
				//giovanni 29012018 fine

				cs.PO_Civico__c= c.PO_Civico__c;
				//28/09/2017 CRM Modifica
				cs.PO_Richiesta_a_fattibilit_ordine__c = c.PO_Richiesta_a_fattibilit__c;
				//28/09/2017 END CRM
				cs.recordtypeid = rtMap.get('PO_Ordine_BTS');
				// cs.OwnerId=codaSupportoVendite.Id;
				//EC  2018 - 11 - 12 modificato il recordtype developername PO_Ordine_BTS  invece di quello usato per il collegamento di p2pattiva   (PO_Ordine_P2P_Attiva)

				if (parentCaseObj.Accordo_Operativo__c != null) {
					cs.Accordo_Operativo__c = parentCaseObj.Accordo_Operativo__c;
				}
				if (String.isNotBlank(parentCaseObj.PO_Accordo_Quadro_Number__c)) {
					cs.PO_Accordo_Quadro_Number__c = parentCaseObj.PO_Accordo_Quadro_Number__c;

					//giovanni 28012019 inizio
					//Modifica ContractId
					//cs.PO_Accordo_Quadro__c = parentCaseObj.PO_Accordo_Quadro_Number__c;
					if (( theContractList != null) && !theContractList.isEmpty()) {
						cs.PO_Accordo_Quadro__c = theContractList[0].Id;
						// RDG 2019-01-31
						cs.OF_IDContratto__c = theContractList[0].Id;
					}
					//giovanni 28012019 fine
				}
				caseToInsert.add(cs);
		}

		insert caseToInsert;
		System.debug('@@@@@@@@EC per ogni Case appartenente alla lista di CaseToOrder abbiamo inserito una nuova lista di Case con questo RecordType: PO_Ordine_BTS, stampiamo il primo per conoscere lo stato e la fase con cui è stato inserito: Stato: ' + caseToInsert.get(0).Status + ', con fase: ' + caseToInsert.get(0).EOF_Fase__c + ', dovrebbe essere stato accettato fase In lavorazione supporto vendite.');

		List<EOF_EAI_Service_Log__c> SlogToInsert = new List<EOF_EAI_Service_Log__c>();

		Map<Id, EOF_EAI_Service_Log__c> mapParentCaseIdServiceLog = new Map<Id, EOF_EAI_Service_Log__c>();
		for (EOF_EAI_Service_Log__c sl: [SELECT Id, Caso__c, Caso__r.CaseNumber, EOF_Comune__c FROM EOF_EAI_Service_Log__c WHERE Caso__c IN :caseParentIds and RecordType.DeveloperName='PO_Log_BTS_Collegamento']) { //FD 2019-02-13 aggiunta Caso__r.CaseNumber
			mapParentCaseIdServiceLog.put(sl.Caso__c, sl);
		}

		Map<Id, Case> mapIdCaseOrdine = new Map<Id, Case>();
		for (Case c1 : caseToInsert) {
			System.debug('@@@@@@@@EC per ogni Case appartenente alla lista di CaseToInsert appena inserita creaiamo un nuovo ServiceLog di tipo PO_Log_BTS_Ordine');
			EOF_EAI_Service_Log__c slo = new EOF_EAI_Service_Log__c();
			slo.recordtypeid = rtMap.get('PO_Log_BTS_Ordine');
			slo.Caso__c = c1.id;
			mapIdCaseOrdine.put(c1.Id, c1);

			//slo.EOF_SL_Riferimento__c=[Select Id,Caso__c from EOF_EAI_Service_Log__c where Caso__c=:c1.Parentid and recordtype.developername='PO_Log_BTS_Collegamento'].id;
			EOF_EAI_Service_Log__c sloParent = mapParentCaseIdServiceLog.get(c1.ParentId);
			if (sloParent != null) {
				slo.EOF_SL_Riferimento__c = sloParent.Id;
				//slo.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Operatore_WS__c + '_' + sloParent.Caso__r.CaseNumber;
				slo.EOF_Comune__c = sloParent.EOF_Comune__c;
			} else {
				slo.EOF_SL_Riferimento__c = null;
			}


			//EC  2018 - 11 - 12 modificato il recordtype developername PO_Ordine_BTS PO_Log_BTS_Collegamento invece di quello usato per il collegamento di p2pattiva   (P2P_Attiva_Collegamento)
			slo.EOF_Codice_Operatore__c=c1.EOF_Codice_Operatore_WS__c;
			slo.EOF_STATO_ORDINE__c='Accettato';
			//slo.EOF_SL_Riferimento__c ='';
			//slo.AccountId = c.AccountId;
			slo.PO_Prime_Contractor__c = c1.PO_Prime_Contractor__c;
			slo.PO_Numero_fibre_richieste__c = c1.PO_Numero_fibre_richieste__c;
			slo.PO_Tipo_di_collegamento__c =c1.PO_Tipo_di_collegamento__c;
			//slo.PO_Nome_sito__c = c1.PO_Nome_sito__c;

			//Modifica Comune
			//slo.EOF_Comune__c = c1.PO_Nome_Comune__c;
			slo.EOF_Comune__c = c1.PO_Comune__c;


			//slo.PO_Indirizzo_sito__c = c1.PO_Indirizzo_sito__c;
			slo.PO_Tipo_percorso__c = c1.PO_Tipo_percorso__c;
			//slo.PO_Note_collegamento__c = c1.PO_Note_collegamento__c;
			slo.PO_Sito__c = c1.PO_Sito__c;
			slo.PO_Nota_sito__c = c1.PO_Nota_sito__c;
			slo.PO_Indirizzo_collegamento__c = c1.PO_Indirizzo_collegamento__c;

			slo.EOF_SITO__c = c1.PO_Sito_partenza__c;
			slo.EOF_NUMERO_CIVICO__c = c1.PO_Civico_partenza__c;
			slo.EOF_INDIRIZZO__c = c1.PO_Indirizzo_collegamento_partenza__c;
			slo.EOF_NOTA_SITO__c = c1.PO_Nota_sito_partenza__c;

			//Modifica Toponomastica
			slo.Particella_Toponomastica_1__c = c1.Particella_Toponomastica_1__c;
			slo.Particella_Toponomastica_2__c = c1.Particella_Toponomastica_2__c;
			slo.Particella_Toponomastica_3__c = c1.Particella_Toponomastica_3__c;

			slo.PO_Civico__c = c1.PO_Civico__c;
			//slo.PO_Richiesta_a_fattibilit_ordine__c = c1.PO_Richiesta_a_fattibilit__c;
			slo.PO_Offerta__c = c1.PO_Offerta__c;
			slo.PO_Nome_Progetto__c = c1.PO_Nome_Progetto__c;

			//slo.EOF_PROFILO__c = '';

			if (parentCaseObj.Accordo_Operativo__c != null)  {
				slo.Accordo_Operativo__c = parentCaseObj.Accordo_Operativo__c;
			}
			if (String.isNotBlank(parentCaseObj.PO_Accordo_Quadro_Number__c)) {
				slo.PO_Accordo_Quadro_Number__c = parentCaseObj.PO_Accordo_Quadro_Number__c;

				//giovanni 28012019 inizio
				//Modifica ContractId
				//slo.PO_Accordo_Quadro__c = parentCaseObj.PO_Accordo_Quadro_Number__c;
				if ((theContractList != null) && !theContractList.isEmpty()) {
					slo.PO_Accordo_Quadro__c = theContractList[0].Id;
				}
				//giovanni 28012019 fine
			}

			SlogToInsert.add(slo);
			//  c1.OwnerId=codaSupportoVendite.Id;
			// caseOrderToUpdate.add(c1);
			//system.debug('il service log che leghiamo come SL di riferimento è: ' +slo.EOF_SL_Riferimento__c);
		}
		insert SlogToInsert;

		PO_Serv_FiberLink_Riepilogo_Controller.setCodiceOrdineOlo(mapIdCaseOrdine);

		// EC 2018 - 11 - 12 non dobbiamo creare VLAN per BTS
		// List<OF_CommercialElementIstanziato__c> VlanToBind = [select id,recordtype.id, OF_KITCONSEGNAVLAN__C, OF_USERVLAN__C,OF_SERVICEVLAN__C,OF_PROFILOVLAN__C,OF_CUSTOMERVLAN__C,
		//                                                    OF_MODELLODISERVIZIOVLAN__C, OF_INFORMAZIONIVLAN__C,OF_Case__c, OF_SA_VLAN__c, OF_CommercialElement__c from OF_CommercialElementIstanziato__c
		//                                                    where OF_Case__c IN : CaseToOrder];

		//system.debug('La lista di Vlan da legare è:'+VlanToBind.size());


		map<id,id> mapCollOrd = new map<id,id>();

		for (case cord: caseToInsert) {
			mapCollOrd.put(cord.PO_Case_Collegamento__c, cord.id);
		}

		//system.debug('mappa di id:'+ mapCollOrd);

		// for (OF_CommercialElementIstanziato__c Vlan : VlanToBind) {
		//  vlan.PO_Case_ordine__c = mapCollOrd.get(Vlan.OF_SA_VLAN__c);

		// }

		// update VlanToBind;
		// 2018-09-12 MM : lego le vlan anche al case e al log ordine di P2P Attiva


		//Chenges Alessandro
		map<id, set<id>> IdMapNew = new map<id, set<id>>();
		map<id, case> CaseMap = new map<id, case>();
		//List<OF_CommercialElementIstanziato__c> CEIToInsert = new List<OF_CommercialElementIstanziato__c>();
		Map<Id,Case> caseFormula = new Map<Id,Case>([select id, casenumber,Codice_Ordine_EOF__c from case where id in: caseToInsert]);
		for (Case c : caseToInsert) {

			//system.debug('DG_OF_ManageOrderFromCase - c.status: ' + c.status + '---c.PO_Case_Collegamento__c: ' + c.PO_Case_Collegamento__c);

			IdMapNew.put(c.PO_Case_Collegamento__c,new Set<ID> {c.Id});
			CaseMap.put(c.id, c);

			//creazione CEI
			// if (( c.PO_Tipo_percorso__c != null) && ( c.PO_Tipo_percorso__c.toUpperCase() == 'DOPPIA VIA DIVERSIFICATA') ) {
			//  OF_CommercialElementIstanziato__c partenza = new OF_CommercialElementIstanziato__c();
			//  partenza.recordtypeId=rtMap.get('Tratte');
			//  partenza.OF_CaseTratta__c=c.Id;
			//  CEIToInsert.add(partenza);
			//  OF_CommercialElementIstanziato__c destinazione = new OF_CommercialElementIstanziato__c();
			//  destinazione.recordtypeId=rtMap.get('Tratte');
			//  destinazione.OF_CaseTratta__c=c.Id;
			//  CEIToInsert.add(destinazione);
			// }
			// else{
			//  OF_CommercialElementIstanziato__c unico = new OF_CommercialElementIstanziato__c();
			//  unico.recordtypeId=rtMap.get('Tratte');
			//  unico.OF_CaseTratta__c=c.Id;
			//  CEIToInsert.add(unico);
			// }
		}
		// if (!CEIToInsert.isEmpty()) {
		//  //   Insert CEIToInsert; //EC 2018 - 11 - 12 commentiamo intanto l'insert poi è proprio da togliere tutta la parte relativa dai CEI.
		// }
		//system.debug('@@@@@ IdMapNew= '+IdMapNew);
		map<id, list<opportunity>> mappaOpp = objU.CreateMap(IdMapNew);
		//system.debug('@@@@@ mappaOpp= '+mappaOpp);
		map<id, order> mappaCase = new map<id, order>();
		list<Order> orders = new list<Order>();
		//OSCRM 30_08_2017 INIZIO
		map<id,case> caseCollegamento = objU.getCaseCollegamentoFields( CaseMap );
		//FINE
		for (id ix: mappaOpp.keyset()) {
			opportunity opp = objU.FindOpportunity(ix,mappaOpp);
			//system.debug('DG_OF_ManageOrderFromCase - opp: ' + opp);
			if (opp != null) {
				order o = objU.CreateOrderPO(ix, CaseMap, opp, caseCollegamento );
				o.OF_CaseNome__c = caseFormula.get(o.OF_CaseID__c).casenumber;
				o.OF_IDOrdineEOF__c = caseFormula.get(o.OF_CaseID__c).Codice_Ordine_EOF__c;
				orders.add(o);
				mappaCase.put(ix, o);
			}
		}
		//system.debug('@@@@@ orders= '+orders);
		//system.debug('@@@@@ mappaCase= '+mappaCase);
		if (orders.size() > 0) {
			insert orders;
		}

		for (Case c : caseToInsert) {
			if (( mappaCase != null) && ( mappaCase.get(c.id) != null) ) {
				c.Of_order__c=mappaCase.get(c.id).id;
			}
		}
		update caseToInsert;
		//chenges END
		// EC AV commentiamo tutto
		// if(!caseOrderToUpdate.isEmpty() && caseOrderToUpdate.size()>0){
		//  dmlOperation(caseOrderToUpdate);
		// }

		return caseToInsert;
		//}else{
		//  codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita'];
		//  for(case c : CaseFromPortal){
		//  c.EOF_fase__c='In Lavorazione Supporto Vendite';
		//  c.OwnerId=codaSupportoVendite.Id;
		// }
		// update CaseFromPortal;
		// return null;
		// }

	}

//EC start 2018 - 09 - 26

/*
   public list<EOF_EAI_Service_Log__c> getkitLogList()  {

    string parentId= Apexpages.currentPage().getParameters().get('parentId');

    List<EOF_EAI_Service_Log__c> kitList = [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,
                                            EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,
                                            EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate,
                                            caso__r.ClosedDate,Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c, Caso__r.PO_Data_Attivazione_Richiesta__c,
                                            Caso__r.PO_Numero_Telefonico_PM__c,PO_Indirizzo_collegamento__c, EOF_Comune__c,EOF_ID_Pop__c,PO_P2PAttiva_Optical_Rate_Limiting__c,
                                            PO_P2PAttiva_KIT_Indirizzo_Consegna__c,PO_P2PAttiva_Nome_del_KIT__c
                                            FROM EOF_EAI_Service_Log__c
                                            WHERE EOF_SL_Riferimento__c =: parentId
                                            AND RecordType.DeveloperName = 'PO_Log_P2P_Attiva_KIT'];

    //system.debug('parentId======='+parentId);
    //system.debug('kitList======='+kitList);


    return kitList;
   }
 */

//EC end 2018 - 09 - 26

	public list<case> getorderCases() {
		try {
			if (ChildCases.size() > 0) {
				ordercaselst = [select id,status,PO_Comune2__c,EOF_Comunicazioni_con_OLO__c,Note_Sospensione_Operatore__c,PO_Durata_mesi__c,PO_Case_Collegamento__r.PO_IndrizoCal__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
								PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
								PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Case_Collegamento__r.parent.PO_isDataOrder__c, PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c,
								NS_Rif__c,
								PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
								recordtype.id,recordtype.developerName,OwnerId from case where PO_Case_Collegamento__c IN: ChildCases];
			}

			//system.debug('ordercaselst======='+ordercaselst);
			//system.debug('ChildCases======='+ChildCases);
		} catch (exception e) {
			//system.debug('error======='+e.getStackTraceString());
		}
		return ordercaselst;
	}


	public pagereference EditOrderInfo() {
		Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
		String orderLogId=[Select id from EOF_EAI_Service_Log__c where id=: caseId].Id;

		system.debug('@@@@@@@EC il caseId è: ' + caseId + ', mentre la stringa orderLogId è: ' + orderLogId);

		if (caseId != NULL) {
			childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Data_Attivazione_Ordine__c,PO_Tipologia_Offerta_ordine__c,EOF_Comunicazioni_con_OLO__c,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
							PO_Prime_Contractor__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,
							NS_Rif__c,

			                //Modifica Toponomastica
							Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,

							PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById,
							PO_Offerta__c,PO_Area_Geografica__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c,PO_Richiesta_a_fattibilit__r.PO_Tipologia_Offerta__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
							from case where Id=: CaseDetail Limit 1];

			//system.debug('childCaseObj====='+childCaseObj.PO_Offerta__c);
			offertEvento =  childCaseObj.PO_Tipologia_Offerta__c;
			cliente = childCaseObj.PO_Indirizzo_collegamento__c + ',' + childCaseObj.PO_Civico__c + ',' + childCaseObj.PO_Nome_Comune__c;
			if (childCaseObj.PO_Nome_Comune3__c != null) {
				cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c + ' ' + childCaseObj.PO_Civico_partenza__c + ',' + childCaseObj.PO_Nome_Comune3__c;
			}
			if (childCaseObj.PO_Nome_Comune3__c == null) {
				cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c + ' ' + childCaseObj.PO_Civico_partenza__c;
			}
			String collegamento = childCaseObj.PO_indirizzo_collegamento_3__c;
			string civico = childCaseObj.PO_Civico_3__c;
			string comune = childCaseObj.PO_Nome_Comune4__c;
			if (childCaseObj.PO_indirizzo_collegamento_3__c == null)
			{
				collegamento ='';
			}
			if (childCaseObj.PO_Civico_3__c == null)
			{
				civico ='';
			}
			if (childCaseObj.PO_Nome_Comune4__c == null)
			{
				comune ='';
			}

			cliente2 = collegamento + ' ' + civico + ',' + comune;

			if (childCaseObj.PO_Nome_Comune4__c == null)
			{
				cliente2 = collegamento + ' ' + civico;
			}

			if (childcaseobj.PO_Data_Attivazione_Ordine__c != null)
			{
				Integer d = childcaseobj.PO_Data_Attivazione_Ordine__c.day();
				Integer mo = childcaseobj.PO_Data_Attivazione_Ordine__c.month();
				Integer yr = childcaseobj.PO_Data_Attivazione_Ordine__c.year();

				DateTime DT = DateTime.newInstance(yr, mo, d);
				//DateTime dtt =  datetime.newInstanace(childDate.Year(),childDate.month().childDate.day()) ;
				//system.debug('childDate====='+DT);
				ordercasedispayordinedate = DT.format('dd/MM/yyyy');
				//system.debug('childDate====='+childDate);
			}
		}
		orderatt = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId AND IsPrivate = false
						ORDER BY createddate DESC];

		//PageReference pg = new PageReference('/PO_P2PAttiva_OverviewOrder');
		PageReference pg = new PageReference('/PO_Serv_BTS_OverviewOrder');

		pg.getParameters().put('id', caseId);
		pg.getParameters().put('orderLogId', orderLogId);

		return pg;

	}

	public pagereference collegmentaDate() {
		//ordine = true;
		String orderId = apexpages.currentPage().getParameters().get('recid');
		ordercasedit = [SELECT id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,
						NS_Rif__c,
						PO_Nome_E_Cognome_PM__c,
						PO_Case_Collegamento__c,PO_Case_Collegamento__r.id,PO_Tempi_di_attivazione_mesi__c
						FROM Case
						WHERE Id = :[SELECT Caso__c FROM EOF_EAI_Service_Log__c WHERE Id = :orderId].Caso__c ];
		Date d = date.today();
		if (ordercasedit.PO_Tempi_di_attivazione_mesi__c != null) {
			Integer intConvertedValue = ordercasedit.PO_Tempi_di_attivazione_mesi__c.intValue();

			date checkdate_In_PO_ModalController = d.addmonths(intConvertedValue );
			stringdate_In_PO_ModalController =  string.valueOf(checkdate_In_PO_ModalController );
		}else{
			stringdate_In_PO_ModalController =  string.valueOf(d );
		}
		PageReference pg = new PageREference('/PO_Serv_BTS_CompletaOrdine');
		pg.getParameters().put('ordercaseditId', ordercasedit.id);
		return pg;
	}
	public pagereference collegmentaDateEdit() {
		//ordine = true;
		string id =apexpages.currentPage().getParameters().get('editid');
		//system.debug('id========'+id);

		ordercasedit = [select id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,
						NS_Rif__c,
						PO_Nome_E_Cognome_PM__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.id,PO_Tempi_di_attivazione_mesi__c from case where id=: id];

		//system.debug('@@@ordercasedit'+ ordercasedit);
		//return new pagereference('/PO_P2PAtt_CompletaOrdine?id'+ordercasedit.id);
		//
		PageReference pg = new PageREference('/PO_Serv_BTS_CompletaOrdine');
		pg.getParameters().put('ordercaseditId', ordercasedit.id);
		return pg;
	}

	public pagereference OpportunityStageNameUpdate2() {
		//P2PAttivaLogList --> Lista di log figli, da questa recupero i case di collegamento
		Set<Id> setidCaseCollegamenti = new Set<Id>(); //EC 2018 08 28
		for (EOF_EAI_Service_Log__c log : BTSLogList) {
			setIdCaseCollegamenti.add(log.Caso__c); //EC 2018 08 28
		}
		Map<ID, Case> mapCaseCollegamenti = new Map<ID, Case>([SELECT Id, Status
															   FROM Case
															   WHERE Id IN: setIdCaseCollegamenti]);

		List<Opportunity> opplst = [SELECT Id, Name, Createdby.Id, Stagename, PO_Richiesta_fattibilit__c
									FROM Opportunity
									WHERE PO_Richiesta_fattibilit__r.id = :parentLogObj.Caso__c
										AND Stagename = 'Offerta presentata'
										LIMIT 1];
		inlineshow = true;

		if (( opplst != null) && ( opplst.size() > 0) && !opplst.isEmpty()) {
			if (opplst[0].stagename == 'Offerta presentata') {
				opplst[0].StageName = 'Richiesta nuova proposta';
				update opplst[0];
			}
		}
		parentCaseObj = [SELECT Id, CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, EOF_Fase__c,ParentId,
						 PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c,
						 Subject, Status, Priority, CreatedDate, CreatedById,PO_Offerta__c,
						 ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId
						 FROM Case
						 WHERE Id = :parentLogObj.Caso__c Limit 1];

		if (parentCaseObj != null) {
			if (opplst[0].StageName != null) {
				parentCaseObj.Status = 'In lavorazione';
				parentCaseObj.EOF_Fase__c = 'Richiesta modifica offerta da Cliente';
				parentCaseObj.OwnerId = opplst[0].createdby.id;
				parentCaseObj.PO_Note_Modifica_Offerta__c = parentLogObj.PO_Note_Modifica_Offerta__c;
				//Aggiorno il log
				parentLogObj.EOF_STATO_ORDINE__c = 'In lavorazione';
			}
			update parentCaseObj;
			update parentLogObj;
		}

		if (BTSLogList.size() > 0) {
			list<case> mylist = new list<case>();

			for (EOF_EAI_Service_Log__c log: BTSLogList) {
				Case tempCase = new Case();
				//Recupero il case legato al log
				tempCase = mapCaseCollegamenti.get(log.Caso__c);

				if (log.PO_Incluso_nell_offerta__c == true) {
					tempCase.Status = 'Completato';
                    log.EOF_STATO_ORDINE__c = tempCase.Status;
				}else{
					tempCase.Status = 'Annullato';
                    tempCase.PO_Incluso_nell_offerta__c = false;
                    log.EOF_STATO_ORDINE__c = tempCase.Status; 
				}
				mylist.add(tempCase);
			}
			if (mylist.size() > 0) {
				update mylist;
				update BTSLogList;
			}
			parentfile=true;//EC 2018 - 08 - 30
		}
		//PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
		PageReference pg = new PageReference('/PO_Serv_BTS_Riepilogo');

		pg.getParameters().put('parentId', parentLogObj.Id);/*/ precedentemente la chiave era id. essendo parentLogObj.id abbiamo sostituito con parentId,
		                                                       //se fosse stato un childlog avremmo sostituito id con cLogId*/
		return pg;
	}

	public pagereference Annulla()
	{
		PageReference pg = new PageReference('/partnercommunity');
		//pg.getParameters().put('parentId', parentLogObj.Id);
		return pg;
	}

	public pagereference OpportunityStageNameUpdate3a()
	{
		inlineshow = true;
		list<opportunity> opplst = [select id,name,stagename,PO_Richiesta_fattibilit__c from opportunity
									where id in : opp limit 1];
	case parentcase = [select id,casenumber,PO_Note_rifiuto_offerta__c,OwnerId from case where id=: parentCaseObj.id];
		parentcase.PO_Note_rifiuto_offerta__c = textarea1;
		update parentcase;
		//system.debug('Parent textarea===='+parentcase.PO_Note_rifiuto_offerta__c);

		//system.debug('parentCaseObj===='+parentcase);
		if (( opplst.size() > 0) && !opplst.isEmpty())
		{

			if (opplst[0].stagename == 'Offerta presentata')
			{
				opplst[0].StageName = 'Offerta rifiutata';
				update opplst[0];
			}
		}
		stagename = false;
		return null;
	}

	public pagereference OpportunityStageNameUpdate3() {
		List<Opportunity> opplst = [SELECT Id, Name, Createdby.Id, Stagename, PO_Richiesta_fattibilit__c
									FROM Opportunity
									WHERE PO_Richiesta_fattibilit__r.id = :parentLogObj.Caso__c
										AND Stagename = 'Offerta presentata'
										LIMIT 1];
		if (( opplst != null) && ( opplst.size() > 0) && !opplst.isEmpty()) {
			if (opplst[0].stagename == 'Offerta presentata') {
				opplst[0].StageName = 'Offerta rifiutata';
				update opplst[0];
			}
		}
		parentCaseObj = [SELECT Id, CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, EOF_Fase__c,ParentId,
						 PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c,
						 Subject, Status, Priority, CreatedDate, CreatedById,PO_Offerta__c,
						 ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId, PO_Accordo_Quadro_Number__c
						 FROM Case
						 WHERE Id = :parentLogObj.Caso__c Limit 1];

		if (parentCaseObj != null) {
			if (opplst[0].StageName != null) {
				parentCaseObj.Status = opplst[0].StageName;
				parentCaseObj.OwnerId = UserInfo.getUserId();
				//Aggiorno il log
				parentLogObj.EOF_STATO_ORDINE__c = parentCaseObj.Status;
			}
			update parentCaseObj;
			update parentLogObj;
		}
		stagename = false;
		return null;
	}

	public pagereference DisplayCaseInfo()
	{
		childcaseobj = new case ();
			Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
			//system.debug('CaseObj====='+caseId);
			if (caseId != NULL) {
				childCaseObj = [SELECT CaseNumber,PO_Sito__c,PO_IndrizoCal__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Civico__c,PO_Nota_sito__c,PO_Indirizzo_collegamento__c,PO_Nome_Comune__c,PO_Incluso_nell_offerta__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,
								NS_Rif__c,

				                //Modifica Toponomastica
								Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,

								PO_Comune2__c,PO_Richiesta_a_fattibilit__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById,
								PO_Offerta__c,PO_Area_Geografica__c,PO_Prime_Contractor__c,PO_Note_Sospensione_OF__c,Note_Sospensione_Operatore__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,OwnerId

								from case where Id=: caseId Limit 1];
				//system.debug('childCaseObj====='+childCaseObj.PO_Nota_sito__c);
				//system.debug('childCaseObj====='+childCaseObj.PO_Incluso_nell_offerta__c);
				showedit=false;
				childcheck = false;
				//system.debug('Status====='+childCaseObj.Status);

				if (( childCaseObj.Status == 'Acquisito') || ( childCaseObj.Status == 'Sospesa') || ( childCaseObj.Status == 'Bozza') || ( childCaseObj.Status == 'In carico al Cliente') )
				{
					showedit= true;
					//system.debug('showedit======'+showedit);
				}
				if (childCaseObj.Status == 'Completo')
				{
					orderline= true;
					//system.debug('childcheck======'+childcheck);
				}
			}
			//system.debug('showedit2======'+showedit);
			return new pagereference ('/apex/Po_FeasibilityServicesRequest3?id' + caseId);
	}

	public PageReference DeleteParentChildCase()
	{
		Boolean isChild=False;
		Case ParentCaseToshow = new Case();
		String parentCasetoDelID = apexpages.currentPage().getparameters().get('parentId');
		//system.debug('Eliminia'+parentCasetoDelID);

		List<Case> ChildCasetoDel = new List<Case>();
		if (String.isNotBlank(parentCasetoDelID)) {
			ChildCasetoDel=[Select id from Case where parentid=:ParentCasetoDelID];
			if (ChildCasetoDel.size() > 0)
			{
				//system.debug('Eliminia Inside Child'+ChildCasetoDel);
				isChild=true;
				Database.delete(ChildCasetoDel,False);
			}
			if (!isChild) {
				ParentCasetoShow=[Select Id,ParentID from Case where Id=:parentCasetoDelID];
			}
			Database.delete(parentCasetoDelID,False);

		}

		return new pagereference('/apex/PO_index');

	}


	public PageReference DeleteParentChildLog() {
		Boolean isChild=False;
		EOF_EAI_Service_Log__c ParentLogToshow = new EOF_EAI_Service_Log__c();
		String parentLogtoDelID = apexpages.currentPage().getparameters().get('parentId');
		//system.debug('Eliminia'+parentLogtoDelID);

		List<EOF_EAI_Service_Log__c> ChildLogtoDel = new List<EOF_EAI_Service_Log__c>();
		if (String.isNotBlank(parentLogtoDelID)) {
			ChildLogtoDel=[Select id from EOF_EAI_Service_Log__c where EOF_SL_Riferimento__c=:ParentLogtoDelID];
			if (ChildLogtoDel.size() > 0) {
				//system.debug('Elimina Inside Child'+ChildLogtoDel);
				isChild=true;
				Database.delete(ChildLogtoDel,False);
			}
			if (!isChild) {
				ParentLogtoShow=[Select Id,EOF_SL_Riferimento__c,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c, PO_Nota_sito__c from EOF_EAI_Service_Log__c where Id=:parentLogtoDelID];
			}
			Database.delete(parentLogtoDelID,False);
		}

		return new pagereference('/apex/PO_index');
	}

/*
   private Id getIdContratto(Id theAccountId)
   {
    String rtAccordoQuadroId = rtMap.get('Accordo_Quadro');

    List<Contract> listContratto = [SELECT Id FROM Contract WHERE AccountId = :theAccountId AND RecordTypeId = :rtAccordoQuadroId];
    if(listContratto != null && listContratto.size() > 0)
    {
        return listContratto[0].Id;
    }
    return null;
   }
 */

	public pagereference InviaRichiesta() {

		/*
		   Map<String,String> ownerMap = new Map<String,String>();
		   for(group g:[select id,developername from Group]){
		    ownerMap.put(g.developername,g.Id);
		   }
		   //Case per richiesta fattibilità
		   Case parentCase = new Case();
		   parentCase.RecordTypeId = rtMap.get('PO_Richiesta_a_servizio_a_fattibilit');
		   parentCase.Status = 'Acquisito';
		   parentCase.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
		   parentCase.accountId = accId;

		   //Assegno il contratto al case
		   //parentCase.PO_Accordo_Quadro__c = getIdContratto(accId);

		   parentCase.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit');
		   parentCase.PO_Offerta__c = parentLogObj.PO_Offerta__c;
		   parentCase.EOF_Codice_Operatore_WS__c = parentLogObj.EOF_Codice_Operatore__c;
		   parentCase.PO_Nome_Progetto__c = parentLogObj.PO_Nome_Progetto__c;
		   parentCase.Subject = parentLogObj.EOF_Tipo_Comunicazione_String__c;
		   parentCase.EOF_Codice_Ordine_OLO__c = parentLogObj.EOF_Codice_Ordine_OLO__c;
		   parentCase.PO_P2P_Attiva__c = true;
		   parentCase.PO_SA_Portale__c = true;//EC 2018 - 08 - 08
		   //Dopo aver popolato il parent case, aggiorno anche il parent log
		   parentLogObj.EOF_Stato_Richiesta__c = 'Inserita Portale';
		   parentLogObj.EOF_STATO_ORDINE__c = 'Acquisito';
		   insert parentCase;
		   parentLogObj.Caso__c = parentCase.Id;
		   update parentLogObj;
		   //Set di id che utilizzerò per recuperare gli allegati e le vlan
		   Set<Id> childLogsCollegamentoId = new Set<Id>();
		   for(EOF_EAI_Service_Log__c childLog : BTSLogList){
		    childLogsCollegamentoId.add(childLog.Id);
		   }
		   //Vado a recuperare la map ParentId - List<Attachment>che utilizzerò dopo nella creazione del case di collegamento
		   Map<Id, List<Attachment>> mapParentIdListAttach = getChildLogAttachment(childLogsCollegamentoId);
		   //Vado a recuperare la map SL_Riferimento - List<LOGVLAN> che utilizzerò dopo nella creazioen del case di collegamento
		   Map<Id, List<EOF_EAI_Service_Log__c>> mapSLRifLog = getVLANLog(childLogsCollegamentoId);
		   //Lista case per gli n collegamenti
		   List<Case> childCasesCollegamento = new List<Case>();
		   //Lista di n VLAN per gli n case di collegamento
		   List<OF_CommercialElementIstanziato__c> nephewVLAN = new List<OF_CommercialElementIstanziato__c>();
		   //Lista di attachmente che andrò ad aggioranre
		   List<Attachment> listAttachToUpdate;
		   //Lista di VLAN che andrò ad aggioranre
		   List<EOF_EAI_Service_Log__c> listVLANToUpdate = new List<EOF_EAI_Service_Log__c>();
		   //Lista di Kit per gli n kit
		   List<Case> kitCases = new List<Case>();
		   //RECUPERO L'Id del Commercial Element relativo alle VLAN
		   Id vlanCEId = [SELECT Id
		               FROM OF_CommercialElement__c
		               WHERE OF_Servizio__r.Name='Open Stream'
		               AND Name='VLAN' LIMIT 1].Id;
		   //Ciclo tutti i log figli per crearne i case
		   for(EOF_EAI_Service_Log__c childLog : BTSLogList){
		    Case tempChild = new Case();

		    //tempChild.RecordTypeId = rtMap.get('PO_Collegamento_P2P_Attiva');
		    tempChild.RecordTypeId = rtMap.get('PO_Log_BTS_Collegamento');

		    tempChild.Status = 'Acquisito';
		    tempChild.EOF_Fase__c = 'NA';
		    tempChild.accountId = accId;
		    tempChild.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit');
		    tempChild.PO_Offerta__c = childLog.PO_Offerta__c;
		    tempChild.EOF_Codice_Operatore_WS__c = childLog.EOF_Codice_Operatore__c;
		    tempChild.PO_Nome_Progetto__c = childLog.PO_Nome_Progetto__c;
		    tempChild.EOF_Codice_Ordine_OLO__c = childLog.EOF_Codice_Ordine_OLO__c;
		    tempChild.ParentId = parentCase.Id;
		    tempChild.PO_Comune__c = childLog.EOF_Comune__c;
		    tempChild.PO_Comune2__c = childLog.OF_Id_Comune__c;
		    tempChild.PO_Tipo_di_collegamento__c = childLog.PO_Tipo_di_collegamento__c;
		    tempChild.PO_Prime_Contractor__c = childLog.PO_Prime_Contractor__c;
		    tempChild.PO_Tipo_percorso__c = childLog.PO_Tipo_percorso__c;
		    tempChild.PO_Numero_fibre_richieste__c = childLog.PO_Numero_fibre_richieste__c;
		    tempChild.OF_SA_Profilo__c = childLog.EOF_PROFILO__c;
		    tempChild.PO_Sito__c = childLog.PO_Sito__c;
		    tempChild.PO_Indirizzo_collegamento__c = childLog.PO_Indirizzo_collegamento__c;
		    tempChild.PO_Civico__c = childLog.PO_Civico__c;
		    tempChild.PO_Nota_sito__c = childLog.PO_Nota_sito__c;
		    tempChild.PO_Richiesta_a_fattibilit__c = parentCase.Id;
		    tempChild.PO_P2P_Attiva__c = true;
		    childLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
		    childLog.EOF_STATO_ORDINE__c = 'Acquisito';
		    insert tempChild;
		    childLog.Caso__c = tempChild.Id;
		    childCasesCollegamento.add(tempChild);





		    //Recupero la lista di attachment, in modo da poter aggiornare il parentID
		    List<Attachment> tempList = mapParentIdListAttach.get(childLog.Id);
		    system.debug('@@@@@@@@@@@@@@@@@@EC tempList di Attachment è così popolata: ' + tempList);
		    //Ciclo sulla lista di attachment e setto il nuovo parent id
		    if(tempList != null && !tempList.isEmpty()){
		     listAttachToUpdate = new List<Attachment>();
		        for(Attachment a : tempList){
		            Attachment tempAttach = new Attachment();
		            tempAttach.OwnerId = a.OwnerId;
		            tempAttach.ParentId = tempChild.Id;
		            tempAttach.IsPrivate = a.IsPrivate;
		            tempAttach.name = a.name;
		            tempAttach.body = a.body;
		            listAttachToUpdate.add(tempAttach);
		        }
		    }
		    //Recupero la lista dei log delle vlan e le aggiungo alla lista
		    List<EOF_EAI_Service_Log__c> listVLAN = mapSLRifLog.get(childLog.Id);
		    //Ciclo sulla lista di log delle vlan e ne creo i CEI
		    for(EOF_EAI_Service_Log__c slog : listVLAN){
		        //CEI che aggiungerò alla lista da restituire
		        OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
		        cei.recordtypeid = rtMap.get('OF_VLAN');
		        cei.OF_KITCONSEGNAVLAN__C = sLog.OF_SA_KIT_CONSEGNA_VLAN__c;
		        cei.OF_USERVLAN__C = sLog.OF_SA_USER_VLAN__C;
		        cei.OF_SERVICEVLAN__C = sLog.OF_SA_SERVICE_VLAN__C;
		        cei.OF_PROFILOVLAN__C = sLog.OF_SA_PROFILO_VLAN__c;
		        cei.OF_CUSTOMERVLAN__C = sLog.OF_SA_CUSTOMER_VLAN__c;
		        cei.OF_MODELLODISERVIZIOVLAN__C = sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
		        cei.OF_INFORMAZIONIVLAN__C = sLog.OF_SA_INFORMAZIONI_VLAN__c;
		        //Lego le VLAN al Case
		        cei.OF_Case__c = tempChild.Id;
		        cei.OF_SA_VLAN__c = tempChild.Id;
		        //Imposto il CEI di tipologia VLAN
		        cei.OF_CommercialElement__c = vlanCEId;

		        nephewVLAN.add(cei);
		        //Dopo aver popolato la vlan, aggiorno anche il vlan log
		        slog.EOF_Stato_Richiesta__c = 'Inserita Portale';
		        slog.EOF_STATO_ORDINE__c = 'Acquisito';
		        slog.Caso__c = tempChild.Id;
		        listVLANToUpdate.add(slog);
		    }
		   }
		   //Aggiorno gli attachment
		   if(listAttachToUpdate != null && !listAttachToUpdate.isEmpty()){
		    insert listAttachToUpdate;
		    system.debug('@@@@@@@@@@@@@@EC abbiamo inserito la lista di attach, che ora è ' + listAttachToUpdate);
		   }
		   if(listVLANToUpdate != null && !listVLANToUpdate.isEmpty()){
		    update listVLANToUpdate;
		   }
		   //Inserisco le vlan
		   if(nephewVLAN != null && !nephewVLAN.isEmpty()){
		    insert nephewVLAN;
		   }
		   //Update per gestire i nuovi stati
		   update BTSLogList;
		 */
		return null;
	}

	private Contract getContratto(Id theAccountId, String theOfferta)
	{
		List<OF_Servizio__c> servizi = [SELECT Id, Name FROM OF_Servizio__c WHERE Name = :theOfferta];
		Id idServizio;
		if (( servizi != null) && ( servizi.size() > 0) )
		{
			idServizio = servizi[0].Id;
		}

		Contract contratto;
		Date oggi = Date.Today();
		List<Contract> contratti = [SELECT Id, StartDate, EndDate, OF_IdContratto__c, (SELECT Id, Name, OF_Servizio__c FROM Contratti_Servizi__r) FROM Contract where
									AccountId = :theAccountId AND
										Status = 'Attivo' AND
										StartDate <= :oggi AND
										EndDate >= :oggi];

		system.debug('giovanni contratti: ' + contratti);

		if (( contratti != null) && ( contratti.size() > 0) )
		{
			for (Contract c : contratti)
			{
				system.debug('giovanni c.Contratti_Servizi__r: ' + c.Contratti_Servizi__r);
				for (OF_ContrattoServizio__c serv : c.Contratti_Servizi__r)
				{
					if (serv.OF_Servizio__c == idServizio)
					{
						contratto = c;
					}
				}
			}
		}

		return contratto;
	}

	@TestVisible
	private String checkVendibilitaRichiesta(Id theAccountId, String theOfferta)
	{
		String errore = null;

		Contract contratto = getContratto(theAccountId, theOfferta);

		//Controllo se esiste un contratto per questo account
		if (contratto == null)
		{
			errore = 'Non esiste un contratto per questo account';
			return errore;
		}

		system.debug('giovanni contratto: ' + contratto);

		List<OF_Servizio__c> serviziDelContratto = [SELECT Id, Name FROM OF_Servizio__c WHERE Id IN (SELECT OF_Servizio__c FROM OF_ContrattoServizio__c WHERE OF_Contract__c = :contratto.Id)];

		system.debug('giovanni serviziDelContratto: ' + serviziDelContratto);

		//if(contratto.Contratti_Servizi__r != null && contratto.Contratti_Servizi__r.size() > 0)
		if (( serviziDelContratto != null) && ( serviziDelContratto.size() > 0) )
		{
			Boolean isOffertaCopertaDalContratto = false;
			//for(OF_Servizio__c servizio : contratto.Contratti_Servizi__r)
			for (OF_Servizio__c servizio : serviziDelContratto)
			{
				if (servizio.Name == theOfferta)
				{
					isOffertaCopertaDalContratto = true;
					break;
				}
			}

			if (!isOffertaCopertaDalContratto)
			{
				errore = 'Servizio non presente nel contratto per questo account';
				return errore;
			}
		}
		else
		{
			errore = 'Il contratto per questo account non ha servizi';
			return errore;
		}

		//Controllo se il contratto è attivo
		/*
		   if(Date.Today() < contratto.StartDate || Date.Today() > contratto.EndDate)
		   {
		    errore = 'Il contratto per questo account non è attivo al momento';
		    return errore;
		   }
		 */

		//theContract.Contratti_Servizi__r
		//List<OF_Servizio__c> theServices = [SELECT Id FROM OF_Servizio__c WHERE Contratti_Servizi__r = :theContract.Id];

		//Creo una lista dei comuni dei collegamenti
		List<String> listaComuniDeiCollegamenti = new List<String>();

		system.debug('giovanni BTSLogList: ' + BTSLogList);

		for (EOF_EAI_Service_Log__c collegamento : BTSLogList)
		{
			listaComuniDeiCollegamenti.add(collegamento.EOF_Comune__c);
		}

		system.debug('giovanni listaComuniDeiCollegamenti: ' + listaComuniDeiCollegamenti);
		system.debug('giovanni contratto.Id: ' + contratto.Id);

		//List<OF_AreaGeograficaJunction__c> areeGeografichePerDebug = [SELECT Id, OF_Contratto__c FROM OF_AreaGeograficaJunction__c];
		//system.debug('giovanni areeGeografichePerDebug: ' + areeGeografichePerDebug);

		//for(OF_AreaGeograficaJunction__c cdebug : areeGeografichePerDebug)
		//{
		//	system.debug('giovanni cdebug.OF_Contratto__c: ' + cdebug.OF_Contratto__c);
		//}

	/*	List<OF_AreaGeograficaJunction__c> areeGeografiche = [SELECT Id, OF_Comune__c FROM OF_AreaGeograficaJunction__c WHERE OF_Contratto__c = :contratto.Id];

		Boolean isComuneCopertoDalContratto;

		system.debug('giovanni areeGeografiche: ' + areeGeografiche);

		if (( areeGeografiche != null) && ( areeGeografiche.size() > 0) )
		{
			for (String comuneNeiCollegamenti : listaComuniDeiCollegamenti)
			{
				isComuneCopertoDalContratto = false;
				for (OF_AreaGeograficaJunction__c ag : areeGeografiche)
				{
					if (comuneNeiCollegamenti == ag.OF_Comune__c)
					{
						isComuneCopertoDalContratto = true;
					}
				}
				if (!isComuneCopertoDalContratto)
				{
					errore = 'Uno dei comuni non è coperto dal contratto';
					return errore;
				}
			}
		}
		else
		{
			errore = 'Il contratto non ha aree geografiche';
			return errore;
		}
*/
		system.debug('giovanni fine');

		//Il controllo di vendibilità è stato superato con successo
		errore = null;
		return errore;
	}

	public pagereference InviaRichiesta_2()
	{
		String erroreVendibilita = checkVendibilitaRichiesta(accId, parentLogObj.PO_Offerta__c);
		if (erroreVendibilita != null)
		{
			system.debug('giovanni risultato errore: ' + erroreVendibilita);
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, erroreVendibilita));
			return null;
		}

		Map<String,String> ownerMap = new Map<String,String>();
		for (group g:[select id,developername from Group]) {
			ownerMap.put(g.developername,g.Id);
		}
		Contract contratto = getContratto(accId, parentLogObj.PO_Offerta__c);
		//Case per richiesta fattibilità
		Case parentCase = new Case();
		parentCase.RecordTypeId = rtMap.get('PO_Richiesta_a_servizio_a_fattibilit'); parentCase.Status = 'Acquisito'; parentCase.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite'; parentCase.accountId = accId;   parentCase.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit'); parentCase.PO_Offerta__c = parentLogObj.PO_Offerta__c; parentCase.EOF_Codice_Operatore_WS__c = parentLogObj.EOF_Codice_Operatore__c; parentCase.PO_Nome_Progetto__c = parentLogObj.PO_Nome_Progetto__c;  parentCase.Subject = parentLogObj.EOF_Tipo_Comunicazione_String__c; parentCase.EOF_Codice_Ordine_OLO__c = parentLogObj.EOF_Codice_Ordine_OLO__c; parentCase.PO_BTS__c = true; parentCase.PO_SA_Portale__c = true;
		if (contratto != null) {
			//parentLogObj.PO_Accordo_Quadro__c = contratto.OF_IdContratto__c;
			parentLogObj.PO_Accordo_Quadro_Number__c = contratto.OF_IdContratto__c; parentCase.OF_IDContratto__c = contratto.Id;
			parentCase.PO_Accordo_Quadro__c = contratto.Id;
		}

		insert parentCase;

		List<EOF_EAI_Service_Log__c> logToUpdate = new List<EOF_EAI_Service_Log__c>();
		//Dopo aver popolato il parent case, aggiorno anche il parent log
		parentLogObj.EOF_Stato_Richiesta__c = 'Inserita Portale'; parentLogObj.EOF_STATO_ORDINE__c = 'Acquisito'; parentLogObj.Caso__c = parentCase.Id;

		logToUpdate.add(parentLogObj);

		//inserisco i collegamenti come case e mi faccio una mappa di id del log e case per riassociarli dopo l'inserimento
		List<Case> listaCaseCollegamentoToInsert = new List<Case>();
		map<String,case> map_IdLog_Case = new map<String,case>();
		Set<Id> childLogsCollegamentoId = new Set<Id>();
		//mi faccio una mappa id del kit del log  nuovo (se presente) e case collegamento cosi dopo l'inserimento posso associarli
		map<String,Case> mapKitLogCaseCollegamento = new map<String,Case>();
		Map<String,String> MapLogCollLogKIT = new Map<String,String>();
		for (EOF_EAI_Service_Log__c childLog: BTSLogList) {
			Case caseCollegamento = new Case();

			//caseCollegamento.RecordTypeId = rtMap.get('PO_Collegamento_P2P_Attiva');
			caseCollegamento.RecordTypeId = rtMap.get('PO_Collegamento_BTS'); caseCollegamento.Status = 'Acquisito'; caseCollegamento.EOF_Fase__c = 'NA'; caseCollegamento.accountId = accId; caseCollegamento.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit'); caseCollegamento.PO_Offerta__c = childLog.PO_Offerta__c; caseCollegamento.EOF_Codice_Operatore_WS__c = childLog.EOF_Codice_Operatore__c; caseCollegamento.PO_Nome_Progetto__c = childLog.PO_Nome_Progetto__c;
			caseCollegamento.EOF_Codice_Ordine_OLO__c = childLog.EOF_Codice_Ordine_OLO__c; caseCollegamento.ParentId = parentCase.Id; caseCollegamento.OF_IDContratto__c = parentCase.OF_IDContratto__c; caseCollegamento.PO_Comune__c = childLog.EOF_Comune__c;  caseCollegamento.PO_Comune2__c = childLog.OF_Id_Comune__c; caseCollegamento.PO_Comune3__c= childLog.PO_Log_IdComune2__c; caseCollegamento.PO_Tipo_di_collegamento__c = childLog.PO_Tipo_di_collegamento__c;
			caseCollegamento.PO_Prime_Contractor__c = childLog.PO_Prime_Contractor__c; caseCollegamento.PO_Tipo_percorso__c = childLog.PO_Tipo_percorso__c; caseCollegamento.PO_Numero_fibre_richieste__c = childLog.PO_Numero_fibre_richieste__c;
			caseCollegamento.PO_Sito__c = childLog.PO_Sito__c; caseCollegamento.PO_Indirizzo_collegamento__c = childLog.PO_Indirizzo_collegamento__c; caseCollegamento.PO_Civico__c = childLog.PO_Civico__c; caseCollegamento.PO_Nota_sito__c = childLog.PO_Nota_sito__c;        caseCollegamento.PO_Richiesta_a_fattibilit__c = parentCase.Id;//caseCollegamento.PO_P2P_Attiva__c = true; //FD 2019-02-28 Bugfix

			//Modifica Toponomastica
			caseCollegamento.Particella_Toponomastica_1__c = childLog.Particella_Toponomastica_1__c;
			caseCollegamento.Particella_Toponomastica_2__c = childLog.Particella_Toponomastica_2__c;
			caseCollegamento.Particella_Toponomastica_3__c = childLog.Particella_Toponomastica_3__c;

			/*
			   caseCollegamento.PO_indirizzo_collegamento_3__c = childLog.EOF_INDIRIZZO__c;
			   caseCollegamento.PO_Sito_3__c = childLog.EOF_SITO__c;
			   caseCollegamento.PO_Civico_3__c = childLog.EOF_NUMERO_CIVICO__c;
			   caseCollegamento.PO_Nota_sito_3__c = childLog.EOF_NOTA_SITO__c;
			 */

			//giovanni 03/12/2018 inizio
			caseCollegamento.PO_Sito_partenza__c= childLog.EOF_SITO__c; caseCollegamento.PO_Indirizzo_collegamento_partenza__c =childLog.EOF_INDIRIZZO__c; caseCollegamento.PO_Civico_partenza__c =childLog.EOF_NUMERO_CIVICO__c; caseCollegamento.PO_Nota_sito_partenza__c = childLog.EOF_NOTA_SITO__c;
			//giovanni 03/12/2018 fine

			listaCaseCollegamentoToInsert.add(caseCollegamento);
			map_IdLog_Case.put(childLog.id,caseCollegamento);
			childLogsCollegamentoId.add(childLog.id);
			//system.debug('@@@@ childLog.OF_PP_KIT_Log__c: '+childLog.OF_PP_KIT_Log__c);
			//controllo se sono legate a kit da creare cosi poi mi prendo il case da agganciarci successivamente
			if (!String.isBlank(childLog.OF_PP_KIT_Log__c)) {
				mapKitLogCaseCollegamento.put(childLog.OF_PP_KIT_Log__c,caseCollegamento);
				MapLogCollLogKIT.put(childLog.id,childLog.OF_PP_KIT_Log__c);
			}
		}
		//system.debug('@@@@ mapKitLogCaseCollegamento: '+mapKitLogCaseCollegamento);
		insert listaCaseCollegamentoToInsert;
		//mi faccio una mappa id del kit log nuovo (se presente) e case KIT cosi dopo l'inserimento posso associarli
		/*
		   map<String,Case> mapKitLogCaseKIT = new map<String,Case>();
		   List<Case> listaCaseKITToInsert = new List<Case>();


		   for(EOF_EAI_Service_Log__c kitLog:ListKitToSend){
		    //system.debug('@@@@ kitLog: '+kitLog);
		    Case caseKIT = new Case();
		    caseKIT.recordTypeId= rtMap.get('PO_Case_P2P_Attiva_KIT');
		    caseKIT.EOF_Identificativo_del_POP__c=kitLog.EOF_ID_Pop__c;
		    caseKIT.PO_Case_Collegamento__c=mapKitLogCaseCollegamento.get(kitLog.Id).Id;
		    caseKIT.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = kitLog.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
		    caseKIT.PO_PP_NomeKit__c=kitLog.PO_P2PAttiva_Nome_del_KIT__c;
		    caseKIT.PO_P2PAttiva_KIT_OpticalRateLimiting__c=kitLog.PO_P2PAttiva_Optical_Rate_Limiting__c;
		   // caseKIT.OwnerId = ownerCodaFattId; //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato ed eliminato questo pensato!
		    caseKIT.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit');
		    //caseKIT.ParentId=childLog.Caso__c;		//EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
		    caseKIT.PO_Richiesta_a_fattibilit_KIT__c=parentCase.id;
		    caseKIT.Status = 'Acquisito';
		    listaCaseKITToInsert.add(caseKIT);
		    mapKitLogCaseKIT.put(kitLog.Id,caseKIT);
		   }
		   insert listaCaseKITToInsert;
		 */
		//system.debug('@@@@@@ listaCaseKITToInsert: '+listaCaseKITToInsert);
		//rifaccio il ciclo per legarci il case
		/*
		   for(EOF_EAI_Service_Log__c kitLog:ListKitToSend){
		    kitLog.Caso__c=mapKitLogCaseKIT.get(kitLog.Id).Id;
		    kitLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
		    kitLog.EOF_STATO_ORDINE__c = 'Acquisito';
		    logToUpdate.add(kitLog);
		   }
		 */

		//rifaccio il ciclo sui collegamenti per legarci i kit
		//system.debug('@@@@ Ale mapKitLogCaseKIT: '+mapKitLogCaseKIT);
		//system.debug('@@@@ Ale MapLogCollLogKIT: '+MapLogCollLogKIT);
		/*
		   IF(!MapLogCollLogKIT.isEmpty()){
		    List<Case> CaseCollToUpdate = new List<Case>();
		    for(String LOgCollId:MapLogCollLogKIT.keyset()){
		        Case collegamento= map_IdLog_Case.get(LOgCollId);
		        //system.debug('@@@@ Ale collegamento: '+collegamento);
		        String id = mapKitLogCaseKIT.get(MapLogCollLogKIT.get(LOgCollId)).Id;
		        collegamento.PO_KIT_Consegna_VLAN__c=mapKitLogCaseKIT.get(MapLogCollLogKIT.get(LOgCollId)).Id;
		        CaseCollToUpdate.add(collegamento);
		    }
		    update CaseCollToUpdate;
		   }
		 */

		//mi tiro fuori gli allegati per legarli ai nuovi case
		Map<Id, List<Attachment>> mapParentIdListAttach = getChildLogAttachment(childLogsCollegamentoId);
		List<Attachment> attachmentToUpdate = new List<Attachment>();
		//mi tiro fuori le vlan per creare i CEI e legarli ai nuovi case
		Map<Id, List<EOF_EAI_Service_Log__c>> mapSLRifLog = getVLANLog(childLogsCollegamentoId);
		List<OF_CommercialElementIstanziato__c> ListCEIToInsert = new List<OF_CommercialElementIstanziato__c>();

		/*
		   Id vlanCEId = [SELECT Id
		               FROM OF_CommercialElement__c
		               WHERE OF_Servizio__r.Name='Open Stream'
		               AND Name='VLAN' LIMIT 1].Id;
		 */

		for (EOF_EAI_Service_Log__c childLog : BTSLogList) {
			childLog.EOF_Stato_Richiesta__c = 'Inserita Portale';       childLog.EOF_STATO_ORDINE__c = 'Acquisito';      childLog.Caso__c = map_IdLog_Case.get(childLog.Id).Id;
			logToUpdate.add(childLog);
			//vedo se il log di collegamento (childlog) ha allegati che in caso sposto sul nuovo case creato
			/*Al momento lo commentiamo mantenendo l'attach legato al log e non lo leghiamo al case in un secondo momento dovremo clonare l'allegato e assegnargli come parentiid quello del case. poi andare a ripescare gli allegati dal case se lo stato è diverso da bozza/bozza portale.
			   if(mapParentIdListAttach.get(childlog.id)!=null && !mapParentIdListAttach.get(childlog.id).isEmpty()){
			     for(attachment a:mapParentIdListAttach.get(childlog.id)){
			         a.parentId=map_IdLog_Case.get(childLog.Id).Id;
			     }
			     attachmentToUpdate.addAll(mapParentIdListAttach.get(childlog.id));
			   }
			 */
			//EC 2018 - 10 - 12 se il log collegamento ha allegati, li clono e copio sul nuovo case creato
			if (( mapParentIdListAttach.get(childlog.id) != null) && !mapParentIdListAttach.get(childlog.id).isEmpty()) {
				attToDelete = new List<Attachment>();
				attToInsert = new List<Attachment>();
				for (attachment a:mapParentIdListAttach.get(childlog.id)) {

					attachment aClone= a.clone(false,false,false,false);
					aClone.parentId=map_IdLog_Case.get(childLog.Id).Id;
					//delete a;
					attToDelete.add(a);
					attToInsert.add(aClone);
				}
				attachmentToUpdate.addAll(mapParentIdListAttach.get(childlog.id));

			}

			/*
			   for(EOF_EAI_Service_Log__c vlanLog : mapSLRifLog.get(childLog.Id)){
			    OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
			    cei.recordtypeid = rtMap.get('OF_VLAN');
			    cei.OF_KITCONSEGNAVLAN__C = vlanLog.OF_SA_KIT_CONSEGNA_VLAN__c;
			    cei.OF_USERVLAN__C = vlanLog.OF_SA_USER_VLAN__C;
			    cei.OF_SERVICEVLAN__C = vlanLog.OF_SA_SERVICE_VLAN__C;
			    cei.OF_PROFILOVLAN__C = vlanLog.OF_SA_PROFILO_VLAN__c;
			    cei.OF_CUSTOMERVLAN__C = vlanLog.OF_SA_CUSTOMER_VLAN__c;
			    cei.OF_MODELLODISERVIZIOVLAN__C = vlanLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
			    cei.OF_INFORMAZIONIVLAN__C = vlanLog.OF_SA_INFORMAZIONI_VLAN__c;
			    //Lego le VLAN al Case
			    cei.OF_Case__c = map_IdLog_Case.get(childLog.Id).Id;
			    cei.OF_SA_VLAN__c = map_IdLog_Case.get(childLog.Id).Id;
			    //Imposto il CEI di tipologia VLAN
			    cei.OF_CommercialElement__c = vlanCEId;
			    ListCEIToInsert.add(cei);
			    vlanLog.Caso__c = map_IdLog_Case.get(childLog.Id).Id;
			    logToUpdate.add(vlanLog);
			   }
			 */
		}

		if (!attachmentToUpdate.isEmpty()) {
			update attachmentToUpdate;
			if (!attToInsert.isEmpty()) {
				insert attToInsert;
			}
			if (!attToDelete.isEmpty()) {//EC start 2018 - 11 - 12
				//  delete attToDelete;
			}//EC end 2018 - 11 - 12
		}
		insert ListCEIToInsert;
		if (!slListToDelete.isEmpty()) {
			delete slListToDelete;
		}
		update logToUpdate;

		//pagereference pg = new pagereference('/PO_P2PAtt_RiepReq_ElCo');
		pagereference pg = new pagereference('/PO_Serv_BTS_Riepilogo');

		pg.getParameters().put('parentId', parentLogObj.Id);
		pg.setRedirect(true);
		return pg;
	}
	//START AA 07/08/2018
	private Map<Id, List<Attachment>> getChildLogAttachment(Set<Id> childLogsId) {
		//Istanzio la mappa avente come key ParentId e come value l'attachment
		Map<Id,List<Attachment>> mapParentIdAttach = new Map<Id,List<Attachment>>();
		//Recupero tutti gli attachment
		List<Attachment> listAttach = [SELECT Id, ParentId, OwnerId, IsPrivate, name, body FROM Attachment WHERE ParentId IN :childLogsId];
		//Controllo se ci sono attachment
		if ((listAttach != null) && !listAttach.isEmpty()) {
			//Ciclo sulla lista di attachment
			for (Attachment a : listAttach) {
				//Qui controllerò la presenza del parentId all'interno del map, se esiste, aggiorno la lista, viceversa la istanzio
				List<Attachment> tempList;
				if (mapParentIdAttach.get(a.ParentId) != null) {//Il parent id è già presente all'interno della map
					tempList = mapParentIdAttach.get(a.ParentId);
				}else{//Il parentId non è presente, quindi aggiungo una nuova lista
					tempList = new List<Attachment>();
				}
				//Che sia una nuova lista o un aggiunta alla lista, devo aggiungere il nuovo attach
				tempList.add(a);
				//Che sia una nuova lista o un aggiunta alla lista, devo settare la nuova lista
				mapParentIdAttach.put(a.ParentId, tempList);
			}
		}
		return mapParentIdAttach;
	}


	private Map<Id, List<EOF_EAI_Service_Log__c>> getVLANLog(Set<Id> childLogsId) {

		//Istanzio la mappa avente come key SL_Riferimento(ParentLog) e come value la lista di log delle vlan
		Map<Id, List<EOF_EAI_Service_Log__c>> mapSLRifLog = new Map<Id, List<EOF_EAI_Service_Log__c>>();
		/*
		   //In teoria ci sarà sempre almeno 1 VLAN
		   if(listVLAN != null && !listVLAN.isEmpty()){
		    //Ciclo sulla lista di VLAN
		    for(EOF_EAI_Service_Log__c vlan : listVLAN){
		        //Qui controllerò la presenza del SL_Riferminto all'interno del map, se esiste, aggiorno la lista, viceversa la istanzio
		        List<EOF_EAI_Service_Log__c> tempList;
		        if(mapSLRifLog.get(vlan.EOF_SL_Riferimento__c) != null ){//Il SL_Riferimento è già presente all'interno della map
		            tempList = mapSLRifLog.get(vlan.EOF_SL_Riferimento__c);
		        }else{//Il SL_Riferimento non è presente, quindi aggiungo una nuova lista
		            tempList = new List<EOF_EAI_Service_Log__c>();
		        }
		        //Che sia una nuova lista o un aggiunta alla lista, devo aggiungere il nuovo log
		        tempList.add(vlan);
		        //Che sia una nuova lista o un aggiunta alla lista, devo settare la nuova lista
		        mapSLRifLog.put(vlan.EOF_SL_Riferimento__c, tempList);
		    }
		   }
		 */
		return mapSLRifLog;

	}


	//FINE AA 07/08/2018
	//collegamento diventerà ordine fino allo step 19
	public void ParentCaseRecord() {
		Nome='';
		parentCase = new Case();
		PrntCaseID='';
		//system.debug('accId===='+accId);
		//AA ------parentCase.accountid = accId;
		//AA----parentCase.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
		invia = true;
		recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];
		//AA --------parentCase.OwnerId = [select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
		//AA --------parentCase.RecordTypeId = rt.id;

		//system.debug('recordOfferta===='+recordOfferta);

		//parentCase.PO_Offerta__c = recordOfferta;
		parentCase.PO_Offerta__c = srvName;

		insert parentCase;
		prntCaseID=parentCase.Id;
	}

	public void childCase() {
		newAtt.clear();
		attxlxs.clear();
		attlst.clear();
		//system.debug('recid====='+parentCase);
		//system.debug('recid====='+parentcaseobj);
		//   Attachment.clear();
		string recid = '';
		ID rectypeId=[select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
		Case testParent=new Case();
		////system.debug('parentcase inside childcase method'+parentcase.id);
		String testParentId= apexpages.currentpage().getparameters().get('id');
		//system.debug('ParentChild'+testParentId);
		if (TestParentID != null) {
			testParent=[select Id,PO_Nome_Progetto__c,ownerId from Case where id=:testparentID];

		}

		if ((parentCase != null) && (parentCase.id != null))
		{
			if ((parentCase.PO_Nome_Progetto__c == '') || (parentCase.PO_Nome_Progetto__c == null)) {
				parentCase.PO_Nome_Progetto__c =Nome;
				offertEvento = parentCase.PO_Offerta__c;
			}
			//system.debug('inside the childcase condiytion'+parentCase.PO_Nome_Progetto__c);

			//system.debug('inside the childcase condiytion'+testParentId);
			recid =  parentCase.id;
			if (parentcase.OwnerId != rectypeID) {
				parentCase.OwnerId = UserInfo.getUserId();
				update parentCase;
			}
		}
		else if ((parentcaseobj != null) && (parentcaseobj.id != null))
		{
			recid =  parentcaseobj.id;
			offertEvento = parentcaseobj.PO_Offerta__c;
			if (parentcaseobj.OwnerId != rectypeID) {
				parentcaseobj.OwnerId = UserInfo.getUserId();

				update parentcaseobj;
			}
		}
		else if ((testcase != null) && (testcase.id != null))
		{
			if ((testcase.PO_Nome_Progetto__c == '') || (testcase.PO_Nome_Progetto__c == null)) {
				testcase.PO_Nome_Progetto__c =Nome;

			}
			recid =  testcase.id;
			testcase.OwnerId = UserInfo.getUserId();
			update testcase;
			Nome = '';
			//system.debug('testcase'+testcase);
		}

		if ((testParent != null) && (testParent.id != null))
		{
			if ((testParent.PO_Nome_Progetto__c == '') || (testParent.PO_Nome_Progetto__c == null)) {
				testParent.PO_Nome_Progetto__c =Nome;
				offertEvento = testcase.PO_Offerta__c;
			}
			recid =  testParent.id;
			update testParent;
			Nome = '';
			//system.debug('testParent '+testParent );
		}
	//system.debug('recid====='+recid);
	case caseupdate = [select id,casenumber,PO_Offerta__c,PO_Nome_Progetto__c,OwnerId from case where id=: recid];

		recordtype rt6 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_BTS'];

	case pcase = [select id,PO_Offerta__c,PO_Nome_Progetto__c,ownerId from case where id=: caseupdate.id limit 1];
		//system.debug('Parent Case--------->'+pcase);
		string serviceType = pcase.PO_Offerta__c;
		//system.debug('serviceType--------->'+serviceType);
		if (pcase != null) {
			update pcase;
		}
		selectedIdComune = '';
		selectedIdComune1 = '';
		selectedIdComune2 = '';
		ChildCase = new Case();
		ChildCase.ParentId = pcase.id;
		ChildCase.accountid = accId;
		ChildCase.PO_Richiesta_a_fattibilit__c =recid;
		childCase.RecordTypeId = rt6.id;
		ChildCase.Status = 'Inserito';

		insert childCase;
		//system.debug('ChildCase--->'+ChildCase);
	}

	public void createChildLog() {
		newAtt.clear();
		attxlxs.clear();
		attlst.clear();
		//system.debug('recid====='+P2PAttivaLogPadre);
		//system.debug('recid====='+parentLogObj);
		//   Attachment.clear();
		string recid = '';
		ID rectypeId=[select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
		List<EOF_EAI_Service_Log__c> testParent=new List<EOF_EAI_Service_Log__c>();
		////system.debug('P2PAttivaLogPadre inside childLog method'+P2PAttivaLogPadre.id);
		String testParentId= apexpages.currentpage().getparameters().get('cLogId');
		//system.debug('ParentChild'+testParentId);
		if (TestParentID != null) {
			testParent=[select Id,PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c from EOF_EAI_Service_Log__c where id=:testparentID];

		}

		if ((BTSLogPadre != null) && (BTSLogPadre.id != null))
		{
			if ((BTSLogPadre.PO_Nome_Progetto__c == '') || (BTSLogPadre.PO_Nome_Progetto__c == null)) {
				BTSLogPadre.PO_Nome_Progetto__c =Nome;
				//offertEvento ='P2P Attiva';
				offertEvento = srvName;
			}
			//system.debug('inside the childLog condition'+P2PAttivaLogPadre.PO_Nome_Progetto__c);

			//system.debug('inside the childlog condition'+testParentId);
			recid =  BTSLogPadre.id;
			if (BTSLogPadre.OwnerId != rectypeID) {
				BTSLogPadre.OwnerId = UserInfo.getUserId();
				update BTSLogPadre;
			}
		}
		else if ((parentLogObj != null) && (parentLogObj.id != null))
		{
			recid =  parentLogObj.id;
			offertEvento = srvName;

			if (parentLogObj.OwnerId != rectypeID) {
				parentLogObj.OwnerId = UserInfo.getUserId();

				update parentLogObj;
			}
		}
		else if ((testlog != null) && (testlog.size() > 0))
		{
			if ((testlog.get(0).PO_Nome_Progetto__c == '') || (testlog.get(0).PO_Nome_Progetto__c == null)) {
				testlog.get(0).PO_Nome_Progetto__c =Nome;

			}
			recid =  testlog.get(0).id;
			testlog.get(0).OwnerId = UserInfo.getUserId();
			update testlog;
			Nome = '';
			//system.debug('testlog'+testlog);
		}

		if ((testParent != null) && (testParent.size() > 0))
		{
			if ((testParent.get(0).PO_Nome_Progetto__c == '') || (testParent.get(0).PO_Nome_Progetto__c == null)) {
				testParent.get(0).PO_Nome_Progetto__c =Nome;
				offertEvento = srvName;
			}
			recid =  testParent.get(0).id;
			update testParent;
			Nome = '';
			//system.debug('testParent '+testParent );
		}
		//system.debug('recid====='+recid);
		List<EOF_EAI_Service_Log__c> slUpdate = [select id,name,PO_Offerta__c,PO_Nome_Progetto__c,OwnerId,
												 EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,
												 CreatedDate,PO_Nota_sito__c
												 from EOF_EAI_Service_Log__c
												 where id=:recid];

		//recordtype rt6 = [select id from recordtype where sobjectType ='EOF_EAI_Service_Log__c' and developername='PO_Collegamento_P2P_Attiva'];
		recordtype rt6 = [select id from recordtype where sobjectType ='EOF_EAI_Service_Log__c' and developername='PO_Log_BTS_Collegamento'];


		List<EOF_EAI_Service_Log__c> pSL = [select id,PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,
											EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c
											from EOF_EAI_Service_Log__c
											where id=:slUpdate.get(0).id
												limit 1];
		//system.debug('Parent EOF_EAI_Service_Log__c--------->'+pSL);
		string serviceType = pSL.get(0).PO_Offerta__c;
		//system.debug('serviceType--------->'+serviceType);
		if (pSL != null) {
			update pSL;
		}
		selectedIdComune = '';
		selectedIdComune1 = '';
		selectedIdComune2 = '';
		BTSLog = new EOF_EAI_Service_Log__c();
		BTSLog.EOF_SL_Riferimento__c = pSL.get(0).id;
		BTSLog.RecordTypeId = rt6.id;
		BTSLog.EOF_Stato_Richiesta__c = 'Inserito';

		insert BTSLog;

	}

	public pagereference AddParentAttachment() {
		//AA Modifica 31-08-18

		//PageReference pg = new PageReference('/PO_P2PAttiva_AddAttachment');
		PageReference pg = new PageReference('/PO_BTS_AddAttachment');

		pg.getParameters().put('parentId', parentLogObj.Id);
		return pg;
	}

	public pagereference inserisciNuovoCollegamento() {
		String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');

		PageReference pg = new PageReference('/PO_Serv_BTS_EditLogInfo');

		pg.getParameters().put('parentId',PrntLogID);
		pg.getParameters().put('Mode','edit');
		return pg;
	}
	//EC start 2018 - 09 - 21
	/*
	   public pagereference inserisciNuovoKit(){

	    String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');
	    String cLogId = ApexPages.currentPage().getParameters().get('cLogId');
	    id rtP2PattKitId = rtMap.get('PO_Log_P2P_Attiva_KIT');
	    sl = new EOF_EAI_Service_Log__c();
	    sl.EOF_SL_Riferimento__c=PrntLogID;
	    sl.recordtypeId = rtP2PattKitId;
	    sl.EOF_Stato_Richiesta__c='NA';
	    sl.EOF_CODICE_OPERATORE__c=usr.Contact.Account.EOF_Codice_Operatore__c;
	    sl.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
	    sl.Nome_del_KIT__c='';//nomeAzienda + s1.replace('LOG-', '_KIT_');//nomekit;
	    sl.Modello_di_Servizio__c='';//ModelloServizio;
	    insert sl;
	    PageReference pg = new PageReference('/apex/PO_P2PAttiva_InserimentoKit');
	    pg.getParameters().put('parentId',PrntLogID);
	    pg.getParameters().put('cLogId',cLogId);
	    pg.getParameters().put('kitId',sl.id);
	    pg.getParameters().put('from','RiepReq');
	    pg.getParameters().put('op','ins');
	    pg.getParameters().put('retUrl',retUrl);
	    return pg;
	   }

	   public pagereference goToKITpage(){
	    String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');
	    String cLogId = ApexPages.currentPage().getParameters().get('cLogId');
	    PageReference pg ;
	    if(parentLogObj.EOF_Stato_Richiesta__c=='Bozza Portale'){
	        pg = new PageReference('/apex/PO_P2PAttiva_InserimentoKIT');
	        pg.getParameters().put('parentId',PrntLogID);
	        pg.getParameters().put('kitId',kitLogId);
	        pg.getParameters().put('from','RiepReq');
	        pg.getParameters().put('retUrl',retUrl);
	    }
	    else{
	        pg = new PageReference('/apex/PO_P2PAttiva_viewKIT');
	        pg.getParameters().put('parentId',PrntLogID);
	        pg.getParameters().put('kitId',kitLogId);
	        pg.getParameters().put('from','RiepReq');
	    }
	     pg.getParameters().put('retUrl',retUrl);
	    return pg;
	   }

	   public pageReference eliminaKit(){
	    String parentId = ApexPages.currentPage().getParameters().get('parentId');
	    String cLogId = ApexPages.currentPage().getParameters().get('cLogId');
	    kitId = ApexPages.currentPage().getParameters().get('kitId');

	    EOF_EAI_Service_Log__c sl = [select id from EOF_EAI_Service_Log__c where Id=:kitId];

	    Pagereference pg =  new PageReference('/PO_P2PAtt_RiepReq_ElCo');
	    pg.getParameters().put('parentId',parentId);
	    pg.getParameters().put('cLogId',cLogId);
	    pg.setRedirect(true);

	    delete sl;


	    return pg;
	   }
	 */

	public pagereference  redirectparentlogdetail() {
		//ParentDate=string.valueof(parentLogObj.CreatedDate);

		//PageReference pg = new PageReference('/PO_P2PAttiva_OverviewRequest');
		PageReference pg = new PageReference('/PO_Serv_BTS_Dettaglio');
		pg.getParameters().put('parentId', parentLogObj.Id);
		return pg;
	}

	public pagereference EditLogInfo() {

		//PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
		PageReference pg = new PageReference('/PO_Serv_BTS_EditLogInfo');

		pg.getParameters().put('cLogId', childlogdisplayid);
		return pg;
	}

	public pagereference  redirectchildlogdetail() {

		//PageReference pg = new PageReference('/PO_P2PAttiva_OverviewchildLogReq');

		PageReference pg = new PageReference('/PO_BTS_OverviewchildLogReq');

		//PageReference pg = new PageReference('/PO_Serv_BTS_EditLogInfo');

		pg.getParameters().put('childId', childlogdisplayid);
		return pg;
	}

	//EC start 2018 - 11 - 17

	public pagereference  redirectToOrdLogDetail() {
		system.debug('@@@@@@@@@@@EC abbiamo appena chiamato il metodo per andare a vedere il dettaglio di un ordine.passiamo come parametro ordLogId, che è ' + ordLogId + 'pLogIdS è: ' + pLogIdS);

		//campi nuovi
		//PageReference pg = new PageReference('/PO_BTS_OverviewchildLogReq');
		PageReference pg = new PageReference('/PO_BTS_OverviewchildLogOrd');

		pg.getParameters().put('childId', ordLogId);
		pg.getParameters().put('parentId', pLogIdS);
		return pg;
	}

	//EC end 2018 - 11 - 17

	public pagereference deleteLog() {

		try {

			List<String> listChildsId = new List<String>();
			List<EOF_EAI_Service_Log__c> listVlan =  new List<EOF_EAI_Service_Log__c>();
			List<Attachment> listAttachment = new List<Attachment>();

			if (!BTSLogList.isEmpty()) {
				for (EOF_EAI_Service_Log__c log : BTSLogList) {
					listChildsId.add(log.Id);
				}
			}
			//system.debug('la lista di collegamenti contiene questi elementi:'+listChildsId.size());
			if (!listChildsId.isEmpty()) {
				listVlan = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE EOF_SL_Riferimento__c IN :listChildsId];
				listAttachment = [SELECT Id FROM Attachment WHERE ParentId IN :listChildsId];
			}
			//system.debug('la lista di Vlan contiene questi elementi:'+listVlan.size());
			//system.debug('la lista di Attachment contiene questi elementi:'+listAttachment.size());

			delete listAttachment;
			delete listVlan;
			delete BTSLogList;
			delete parentLogObj;


		}catch (exception e) {
			//system.debug('exception'+e);
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
			return null;
		}

		//PageReference pg = new PageReference('/PO_P2P_Attivo_DisplayRequest');
		PageReference pg = new PageReference('/PO_Serv_BTS_Richieste');
		return pg;

	}
	public list<Opportunity> getparentOppty() {
		try {
			String id=apexpages.currentpage().getparameters().get('id');
			if ((id != '') || (id != null)) {
				parentOpptylst = [select id,PO_Totale_contributi_attivazione__c,PO_Sconto_contributi_attivazione__c from Opportunity where PO_Richiesta_fattibilit__c =:id];
			}
		}
		catch (exception e) {
			//system.debug('error======='+e.getStackTraceString());
		}
		return parentOpptylst;
	}

	public boolean checkStageName() {
		String parentId=apexpages.currentpage().getparameters().get('id');  //modificare il parametro 'id' con 'parentId'
		if (String.isNotBlank(parentId)) {
			parentOpptylst = [select id,PO_Totale_contributi_attivazione__c,PO_Sconto_contributi_attivazione__c from Opportunity where PO_Richiesta_fattibilit__c =:parentId];

			StageName=(parentOpptylst != null && parentOpptylst.size() > 0) ? true : false;
		}
		return StageName;
	}

	public pagereference DetailPage() {

		pagereference pg = new pagereference('/PO_P2PAtt_RiepReq_ElCo');
		pg.getParameters().put('parentId',parentLogObj.Id);
		pg.getParameters().put('cLogId',childLogObj.id);
		return pg;
	}

	//EC start 2018 - 09 - 26

	public void creaCaseKit(List<EOF_EAI_Service_Log__c> kitLogList) {
		/*

		   //  String idCaseKit= [select Id, CaseNumber from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=:kitLog.id)].id;
		   String ownerCodaFattId = [select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
		   List<Case> caseKitList = new List<Case>();
		   List<EOF_EAI_Service_Log__c> kitLogListToUpdate = new List<EOF_EAI_Service_Log__c>();

		   For(EOF_EAI_Service_Log__c kitLog : kitLogList){
		    Case caseKit = new Case();
		    caseKit.recordTypeId= rtMap.get('PO_Case_P2P_Attiva_KIT');
		    caseKit.EOF_Identificativo_del_POP__c=kitLog.EOF_ID_Pop__c;
		    // caseKit.PO_Case_Collegamento__c= [select Id from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=:kitLog.id)].id;
		    caseKit.PO_Case_Collegamento__c = [select Id from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where EOF_SL_Riferimento__c=:kitLog.id)].id;
		    caseKit.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = kitLog.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
		    caseKit.PO_PP_NomeKit__c=kitLog.PO_P2PAttiva_Nome_del_KIT__c;
		    caseKit.PO_P2PAttiva_KIT_OpticalRateLimiting__c=kitLog.PO_P2PAttiva_Optical_Rate_Limiting__c;
		    caseKit.OwnerId = ownerCodaFattId;
		    caseKitList.add(caseKit);
		    kitLog.Caso__c=CaseKit.Id;
		    kitLog.EOF_Stato_Richiesta__c='Acquisito';

		    kitLogListToUpdate.add(kitLog);
		   }
		   insert caseKitList;

		   update kitLogListToUpdate;
		 */
	}

	//EC end 2018 - 09 - 26
	//
	public void deleteVoidKitLog() {

		/*
		   kitListToDelete=[SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,
		                 EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,
		                 EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate,
		                 caso__r.ClosedDate,Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c, Caso__r.PO_Data_Attivazione_Richiesta__c,
		                 Caso__r.PO_Numero_Telefonico_PM__c,PO_Indirizzo_collegamento__c, EOF_Comune__c,EOF_ID_Pop__c
		                 //PO_P2PAttiva_Optical_Rate_Limiting__c,
		                 //PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
		                 //PO_P2PAttiva_Nome_del_KIT__c
		                 FROM EOF_EAI_Service_Log__c
		                 WHERE RecordType.DeveloperName = 'PO_Log_P2P_Attiva_KIT' AND (PO_P2PAttiva_Nome_del_KIT__c=null OR PO_P2PAttiva_Nome_del_KIT__c='') AND
		                 ((EOF_SL_Riferimento__c IN :setIdCollegamenti) OR (EOF_SL_Riferimento__c=null OR EOF_SL_Riferimento__c='') OR (EOF_SL_Riferimento__c =:(ApexPages.currentPage().getParameters().get('parentId')))) ];


		   delete kitListToDelete;
		 */

	}


}
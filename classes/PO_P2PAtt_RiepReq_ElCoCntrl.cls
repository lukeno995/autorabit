public class PO_P2PAtt_RiepReq_ElCoCntrl {
    private static final String SEDE_MASTER = 'Master';
    private static final String SEDE_SATELLITE = 'Satellite';
    
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
    public EOF_EAI_Service_Log__c logObj {get; set;}     //2018 - 07 - 31 to substitute caseObj
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
    public EOF_EAI_Service_Log__c P2PAttivaLog {get; set;} //EC 2018 - 07 - 20 P2PAttiva
    public EOF_EAI_Service_Log__c P2PAttivaLogPadre {get; set;} //EC 2018 - 07 - 20 P2PAttiva
    public EOF_EAI_Service_Log__c childLog {get;set;}
    public List<EOF_EAI_Service_Log__c>  P2PAttivaLogList {get; set;} //EC 2018 - 07 - 20 P2PAttiva
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
    public id kitLogId {get; set;}    //EC 2018 - 09 - 26
    public case childcasedisplayobj {get; set;}
    public EOF_EAI_Service_Log__c childlogdisplayobj {get; set;}
    public opportunity childoppobj {get; set;}
    public string IndirizzoCliente {get; set;}
    public List<attachment> childlogdisplayattlist {get; set;}
    public boolean VlanCollegamentiOK {get; set;}
    public List<EOF_EAI_Service_Log__c> vLanList {get; set;} //rt OF_SA_VLAN
    public Opportunity parentOppty {get; set;}    //EC 2018 - 08 - 16
    public Opportunity childOppty {get; set;} //EC 2018 - 08 - 16
    public List<Opportunity> opptylst {get; set;} //EC 2018 - 08 - 16
    public List<Opportunity> parentOpptylst {get; set;} //EC 2018 - 08 - 16
    public Id orderId {get; set;}
    public List<EOF_EAI_Service_Log__c>  listVLAN {get; set;}
    public Set<Id> setIdCollegamenti {get; set;}
    public EOF_EAI_Service_Log__c sl {get; set;}
    public String kitId {get; set;} //EC 2018 - 09 - 24
    public List<EOF_EAI_Service_Log__c> kitList {get; set;}  //EC 2018 - 09 - 24
    public Static List<EOF_EAI_Service_Log__c> kitListToDelete {get; set;}  //EC 2018 - 09 - 24
    public boolean checkKitSenzaVlan {get; set;} 
    public Map<String, Id> rtMap;
    public List<EOF_EAI_Service_Log__c> slListToDelete;
    public List<EOF_EAI_Service_Log__c> ListKitToSend;
    public EOF_EAI_Service_Log__c sLogKit {get; set;}
    public List<EOF_EAI_Service_Log__c> sLogKitList {get; set;}
    public EOF_EAI_Service_Log__c sLogVlan {get; set;}
    public List<EOF_EAI_Service_Log__c> sLogVlanList {get; set;}
    public List<EOF_EAI_Service_Log__c> sLogCollSatell {get; set;}
    @TestVisible List<Attachment> attToDelete {get; set;} //EC 2018 - 10 - 12
    @TestVisible List<Attachment> attToInsert {get; set;}//EC 2018 - 10 - 15
    public user usr {get; set;}
    public boolean checkProfilo {get;set;} //EC 2019 05 15
    public boolean checkCollKit {get;set;} //EC 2019 05 15
    public String cLogId {get;set;}
    public ServiceLogWrapper slWrapObj {get;set;}
    public List<ServiceLogWrapper> slWrapList {get;set;}
    public String tipoP2PAttiva {get;set;} //LM 
    public boolean checkP2PAttivaEAccess {get;set;} //EC 2019 06 12
    public boolean checkP2PAttivaELine {get;set;} //EC 2019 06 12
    public List<EOF_EAI_Service_Log__c> slCollSatelliteList {get;set;} //EC 2019 06 17 
    public Boolean existsMaster {get;set;} // DN
    public Boolean existsOneMaster {get;set;} // DN
    public class ServiceLogWrapper {
        public EOF_EAI_Service_Log__c sLogColl {get; set;}
        public String profilosVlan {get; set;}
        public String nomeKit {get; set;}
        
        public ServiceLogWrapper() {           
        }    
        
    }
    
    
    public PO_P2PAtt_RiepReq_ElCoCntrl() {
        
        tipoP2PAttiva=ApexPages.currentPage().getParameters().get('tipoP2Patt');
        System.debug('@@EC ApexPages.currentPage()'+ApexPages.currentPage());
        System.debug('@@EC A tipoP2PAttiva'+tipoP2PAttiva);
        System.debug('@@EC ApexPages.currentPage()'+ApexPages.currentPage().getURL());
        returl=ApexPages.currentPage().getUrl();
        ChildCases = new List<Case>();
        P2PAttivaLogList = new List<EOF_EAI_Service_Log__c>(); //2018 - 07 - 31 to substitute  ChildCases
        parentLogObj = new EOF_EAI_Service_Log__c();
        attlst = new List<Attachment>();
        newAtt = new List<Attachment>();
        attxlxs = new List<Attachment>();
        orderCases = new List<Case>();
        orderLogs = new List<EOF_EAI_Service_Log__c>(); //2018 - 07 - 31 to substitute  orderCases
        vLanList= new List<EOF_EAI_Service_Log__c>();
        opptylst= new List<Opportunity>(); //EC  2018 - 08 -16
        parentOpptylst= new List<Opportunity>();   //EC  2018 - 08 -16
        sortField = 'CreatedDate';
        myOrder = 'DESC';
        StageName = false;
        caseobjbuttoncheck=false;
        invia=false;
        //accId = [select id from account where type='OLO' AND name='OLOOF'].id;
        kitList = new List<EOF_EAI_Service_Log__c>();
        checkKitSenzaVlan=false;
        Set<Id> checkCollegamenti= new Set<Id>();
        VlanCollegamentiOK = true;
        rtMap=PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
        setIdCollegamenti = new Set<Id>();
        set<Id> setidCaseCollegamenti = new Set<Id>(); //EC 2018 08 28
        List<EOF_EAI_Service_Log__c> allVLAN = new List<EOF_EAI_Service_Log__c>();
        //faccio un set con gli id dei kit per verificare se tutti i kit hanno vlan associate
        Set<Id> KitConVlan = new Set<Id>();
        listVlan= new List<EOF_EAI_Service_Log__c>();
        usr=[Select Name,Profile.Name,IsActive,Contact.Account.Id,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
             contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
             contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
             contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,contact.PO_Servizio_Incident_Management__c,
             contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c,Contact.Account.EOF_Codice_Operatore__c
             From User
             Where Id =: System.UserInfo.getUserId()];
        accId = usr.Contact.Account.Id;
        sLogKit = new EOF_EAI_Service_Log__c();
        sLogVlan = new EOF_EAI_Service_Log__c();
        sLogVlanList  = new List<EOF_EAI_Service_Log__c>();
        sLogCollSatell =  new List<EOF_EAI_Service_Log__c>();
        sLogKitList  = new List<EOF_EAI_Service_Log__c>();
        List<Id> kitIds = new List<Id>(); 
        Set<Id> logIds = new Set<Id>();
        List<Id> logSateIds = new List<Id>();
        checkP2PAttivaEAccess=false;//EC 2019 06 12
        checkP2PAttivaELine=false;//EC 2019 06 12
        slCollSatelliteList = new List<EOF_EAI_Service_Log__c>(); //EC 2019 06 17
        Integer count = 0;
        slWrapList =  new List<ServiceLogWrapper>();
        if ((ApexPages.currentPage().getParameters().get('parentId') != null) && String.isNotBlank(ApexPages.currentPage().getParameters().get('parentId') )) {
            /*childLog = [SELECT Id, EOF_Codice_Ordine_OLO__c
FROM EOF_EAI_Service_Log__c
WHERE EOF_SL_Riferimento__c = : ApexPages.currentPage().getParameters().get('parentId')  AND RecordType.DeveloperName = 'P2P_Attiva_Collegamento'];
if(childLog.id !=null){
cLogId = childLog.id;
}*/
            parentLogObj = [SELECT Id,Name, Caso__c, Caso__r.Status,Caso__r.Createddate,Caso__r.Closeddate, PO_Offerta__c,
                            PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c,
                            EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c, PO_Note_Modifica_Offerta__c,
                            PO_Offerta_Caricata__c, PO_Offerta_Inoltrata__c, EOF_ID_Pop__c,PO_P2PAttiva_Optical_Rate_Limiting__c,
                            PO_P2PAttiva_KIT_Indirizzo_Consegna__c,PO_P2PAttiva_Nome_del_KIT__c,
                            PO_Accordo_Quadro_Number__c,
                            caso__r.PO_Data_Espletamento_Ordine__c //FD 2019-03-08
                            FROM EOF_EAI_Service_Log__c
                            WHERE Id = :ApexPages.currentPage().getParameters().get('parentId')];
            
            slListToDelete = new List<EOF_EAI_Service_Log__c>();
            //  if(tipoP2PAttiva !='eLine'){
            if(!'eLine'.equalsIgnoreCase(tipoP2PAttiva)){
                System.debug('sono nell if di e-access');
                for (EOF_EAI_Service_Log__c log:[SELECT Id, Caso__c, Caso__r.Status, Caso__r.Parent.Status, Caso__r.casenumber, EOF_Codice_Ordine_OLO__c, Name,
                                                 PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, EOF_Stato_Richiesta__c,PO_Offerta__c,
                                                 EOF_Codice_Operatore__c, PO_Nome_Progetto__c, PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c,
                                                 PO_Incluso_nell_offerta__c,PO_Numero_fibre_richieste__c, EOF_PROFILO__c, PO_Sito__c, PO_Civico__c, OF_PP_KIT_Log__c,
                                                 ID_Sede__c,Tipologia_CPE__c,Tipologia_Alimentazione__c ,Interfaccia_CPE__c,TrafficLoadBalancing__c,
                                                 kit_in_condivisione__c,OF_SA_PROFILO_VLAN__c,PO_P2PAttiva_Nome_del_KIT__c,PO_P2PAttiva_Optical_Rate_Limiting__c,
                                                 PO_Nota_sito__c,EOF_STATO_ORDINE__c, OF_Id_Comune__c,Caso__r.ParentId,PO_P2PAttiva_KIT_Indirizzo_Consegna__c, Particella_Toponomastica_1__c,
                                                 Service_attribute__c,Tipologia_Sede__c,ID_Sede_Master__c,
                                                 (SELECT Id,PO_PP_cos_class__c ,PO_PP_cos_remarking__c ,PO_PP_dhcp_Option82__c
                                                  ,PO_P2PAttiva_Kit_Consegna_VLan__c,PO_P2PAttiva_Opzione__c ,EOF_PROFILO__c ,PO_PP_User_VLAN__c,COS5_PIR__c, COS5_CIR__c,
                                                  COS3_PIR__c, COS3_CIR__c, COS1_PIR__c, COS1_CIR__c, EOF_SL_Riferimento__c, OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_USER_VLAN__C, OF_SA_SERVICE_VLAN__C,
                                                  OF_SA_PROFILO_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c,OF_PP_KIT_Log__c
                                                  
                                                  FROM EAI_Service_Logs__r)
                                                 FROM EOF_EAI_Service_Log__c
                                                 WHERE EOF_SL_Riferimento__c = :parentLogObj.Id
                                                 AND RecordType.DeveloperName = 'P2P_Attiva_Collegamento']) {
													                                   
                                                     if (String.isBlank(log.EOF_Codice_Ordine_OLO__c)) {
                                                         slListToDelete.add(log);
                                                     } else {
														if(log.OF_PP_KIT_Log__c != null || log.kit_in_condivisione__c != null) {
															kitIds.add(log.OF_PP_KIT_Log__c);
															kitIds.add(log.kit_in_condivisione__c);
														}

                                                        P2PAttivaLogList.add(log);	
														logIds.add(log.id);													 
                                                         System.debug('@@@P2PAttivaLogList'+P2PAttivaLogList.size());
													
                                                         setIdCollegamenti.add(log.Id);                                                         
                                                         
                                                         setidCaseCollegamenti.add(log.Caso__c);                                 //EC 2018 08 28
                                                         checkCollegamenti.add(log.Id);
                                                         List<EOF_EAI_Service_Log__c> vlanPerSingoloCollegamento = new List<EOF_EAI_Service_Log__c>();
                                                         for (EOF_EAI_Service_Log__c vlan : log.EAI_Service_Logs__r) {
                                                             System.debug('@@@vlan'+vlan);
                                                             System.debug('@@@OF_SA_KIT_CONSEGNA_VLAN__c'+vlan.OF_SA_KIT_CONSEGNA_VLAN__c);
                                                             allVLAN.add(vlan);
                                                             if (!String.isBlank(vlan.OF_SA_KIT_CONSEGNA_VLAN__c)) {
                                                                 vlanPerSingoloCollegamento.add(vlan);
                                                                 KitConVlan.add(vlan.OF_PP_KIT_Log__c);
                                                                 listVlan.add(vlan);
                                                             }
                                                             else{
                                                                 slListToDelete.add(vlan);
                                                             }
                                                         }
                                                         if (vlanPerSingoloCollegamento.isEmpty()) {
                                                             VlanCollegamentiOK = false;
                                                         }
                                                     }
                                                 } // END for e-access
				sLogKitList = [SELECT PO_P2PAttiva_Nome_del_KIT__c,OF_PP_KIT_Log__r.PO_P2PAttiva_Nome_del_KIT__c,kit_in_condivisione__c,EOF_Codice_Ordine_OLO__c   
								FROM EOF_EAI_Service_Log__c 
								WHERE Id IN: kitIds AND RecordType.DeveloperName =: RTypeServFattibilita.LOG_P2P_ATTIVA_KIT];
                checkP2PAttivaEAccess=true; //EC 2019 06 12
            }
            else{
                System.debug('sono nell else, collegamento E-Line.');
                for (EOF_EAI_Service_Log__c log:[SELECT Id, Caso__c, Caso__r.Status, Caso__r.Parent.Status, Caso__r.casenumber, EOF_Codice_Ordine_OLO__c, Name,
                                                 PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, EOF_Stato_Richiesta__c,PO_Offerta__c,
                                                 EOF_Codice_Operatore__c, PO_Nome_Progetto__c, PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c,
                                                 PO_Incluso_nell_offerta__c,PO_Numero_fibre_richieste__c, EOF_PROFILO__c, PO_Sito__c, PO_Civico__c, OF_PP_KIT_Log__c,
                                                 ID_Sede__c,Tipologia_CPE__c,Tipologia_Alimentazione__c ,Interfaccia_CPE__c,
                                                 kit_in_condivisione__c,OF_SA_PROFILO_VLAN__c,PO_P2PAttiva_Nome_del_KIT__c,PO_P2PAttiva_Optical_Rate_Limiting__c,  
                                                 PO_Nota_sito__c,EOF_STATO_ORDINE__c, OF_Id_Comune__c,Caso__r.ParentId,PO_P2PAttiva_KIT_Indirizzo_Consegna__c, 
                                                 Particella_Toponomastica_1__c, Service_attribute__c,Tipologia_Sede__c ,ID_Sede_Master__c, TrafficLoadBalancing__c, 
                                                 (SELECT Id,PO_PP_cos_class__c ,PO_PP_cos_remarking__c ,PO_PP_dhcp_Option82__c,
                                                  PO_P2PAttiva_Kit_Consegna_VLan__c,PO_P2PAttiva_Opzione__c ,EOF_PROFILO__c ,
                                                  PO_PP_User_VLAN__c,COS5_PIR__c, COS5_CIR__c, COS3_PIR__c, COS3_CIR__c, 
                                                  COS1_PIR__c, COS1_CIR__c, EOF_SL_Riferimento__c, OF_SA_KIT_CONSEGNA_VLAN__c, 
                                                  OF_SA_USER_VLAN__C, OF_SA_SERVICE_VLAN__C, OF_SA_PROFILO_VLAN__c, OF_SA_CUSTOMER_VLAN__c, 
                                                  OF_SA_MODELLO_DI_SERVIZIO_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c,OF_PP_KIT_Log__c                                                  
                                                FROM EAI_Service_Logs__r)
                                                FROM EOF_EAI_Service_Log__c
                                                WHERE EOF_SL_Riferimento__c = :parentLogObj.Id
                                                AND RecordType.DeveloperName = 'P2P_Attiva_Collegamento_ELine']) {

                                                     if (String.isBlank(log.EOF_Codice_Ordine_OLO__c)) {
                                                         slListToDelete.add(log);
                                                     } else {
                                                         /*if(!SEDE_MASTER.equals(log.Tipologia_Sede__c)){ //EC 2019 0 aggiunto check su tipologia sede, da considerare solo i collegamenti satellite start
system.debug('@@@@EC log.Tipologia Sede != da SEDE_MASTER!!! quindi aggiungiamo il log alla lista slCollSatelliteList!');
slCollSatelliteList.add(log);
}*/ //EC 2019 0 aggiunto check su tipologia sede, da considerare solo i collegamenti satellite end
                                                        P2PAttivaLogList.add(log);
                                                        System.debug('@@@EC P2PAttivaLogList'+P2PAttivaLogList.size());
                                                         
														if(SEDE_SATELLITE.equals(log.Tipologia_Sede__c)) {
															logIds.add(log.id);                                                         
                                                         	slCollSatelliteList.add(log);
														 }
                                                         
                                                         setIdCollegamenti.add(log.Id);                                                         
                                                         
                                                         setidCaseCollegamenti.add(log.Caso__c);                                 //EC 2018 08 28
                                                         checkCollegamenti.add(log.Id);
                                                         List<EOF_EAI_Service_Log__c> vlanPerSingoloCollegamento = new List<EOF_EAI_Service_Log__c>();
                                                         for (EOF_EAI_Service_Log__c vlan : log.EAI_Service_Logs__r) {
                                                             allVLAN.add(vlan);
                                                             
                                                             if (!String.isBlank(vlan.EOF_SL_Riferimento__c)) {
                                                                 vlanPerSingoloCollegamento.add(vlan);
                                                                 listVlan.add(vlan);
                                                             }
                                                             else{
                                                                 slListToDelete.add(vlan);
                                                             }
                                                         }
                                                         // verificare controllo collegamento Vlan!!! da fareeeeee 
                                                         //EC 2019 06 17 start
                                                         /*     if (vlanPerSingoloCollegamento.isEmpty()) {
VlanCollegamentiOK = false;
}*/
                                                         //EC 2019 06 17 end
                                                     }
                                                     //EC end if sede satellite 2019 06 17
                                                     if(SEDE_SATELLITE.equals(log.tipologia_sede__c) && log.ID_Sede_Master__c == null) {
                                                         existsMaster = false;
                                                         System.debug('####1 ');                            
                                                     }else{
                                                         existsMaster = true;
                                                         System.debug('####3 '); 
                                                     }
                                                     System.debug('#### existsMaster: ' + existsMaster);
                                                 }
                if(P2PAttivaLogList.size()==1 && SEDE_MASTER.equals(P2PAttivaLogList[0].tipologia_sede__c)) {
                    existsOneMaster = false;
                }else{
                    existsOneMaster = true;
                }
                checkP2PAttivaELine = true; //EC 2019 06 12
            }
        }

		String devName = checkP2PAttivaEAccess ? RTypeServFattibilita.LOG_VLAN : RTypeServFattibilita.LOG_VLAN_ELINE;
		// cerco le vlan per info tabella collegamenti nel riepilogo
		sLogVlanList = [SELECT OF_SA_PROFILO_VLAN__c,EOF_SL_Riferimento__c,EOF_SL_Riferimento__r.Tipologia_Sede__c
						FROM EOF_EAI_Service_Log__c
						WHERE EOF_SL_Riferimento__c  IN : logIds
						AND RecordType.DeveloperName =: devName];

		// controllo per eaccess già presente
		if(checkP2PAttivaELine) {
			VlanCollegamentiOK = checkVlanEline(logIds, sLogVlanList);
		}
		
		slWrapList = buildLogWrapper(sLogVlanList, sLogKitList);

        if ((P2PAttivaLogList != null) && !P2PAttivaLogList.isEmpty()) {
            StageName = ( (P2PAttivaLogList[0].Caso__r.Status == 'In approvazione Cliente') ? true : false);
            /* AA 29/08/2018 IN SOSTITUZIONE TODO CONTROLLARE */
            
            if(tipoP2PAttiva=='eLine'){
                //system.debug('il setIdCollegamenti è:'+ setIdCollegamenti);
                orderLogs = [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,
                             CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c,
                             EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate, caso__r.ClosedDate,
                             Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c, Caso__r.PO_Data_Attivazione_Richiesta__c, Caso__r.PO_Numero_Telefonico_PM__c,
                             PO_Indirizzo_collegamento__c, EOF_Comune__c,PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
                             Particella_Toponomastica_1__c,Caso__r.PO_Case_Collegamento__c, 
                             Caso__r.PO_Data_Espletamento_Ordine__c, PO_Civico__c  //FD 2019-03-07
                             FROM EOF_EAI_Service_Log__c
                             WHERE EOF_SL_Riferimento__c IN :setIdCollegamenti  
                             AND RecordType.DeveloperName = 'P2P_Attiva_Ordine_ELine'];
            }else{
                orderLogs = [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,
                             CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c,
                             EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate, caso__r.ClosedDate,
                             Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c, Caso__r.PO_Data_Attivazione_Richiesta__c, Caso__r.PO_Numero_Telefonico_PM__c,
                             PO_Indirizzo_collegamento__c, EOF_Comune__c,PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
                             Particella_Toponomastica_1__c,Caso__r.PO_Case_Collegamento__c, 
                             Caso__r.PO_Data_Espletamento_Ordine__c, PO_Civico__c  //FD 2019-03-07
                             FROM EOF_EAI_Service_Log__c
                             WHERE EOF_SL_Riferimento__c IN :setIdCollegamenti  
                             AND RecordType.DeveloperName = 'PO_P2P_Attiva_Ordine']; 
            } 
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
            kitList = [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,
                       EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,
                       EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate,
                       caso__r.ClosedDate,Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c, Caso__r.PO_Data_Attivazione_Richiesta__c,
                       Caso__r.PO_Numero_Telefonico_PM__c,PO_Indirizzo_collegamento__c, EOF_Comune__c,EOF_ID_Pop__c,PO_P2PAttiva_Optical_Rate_Limiting__c,
                       PO_P2PAttiva_KIT_Indirizzo_Consegna__c,PO_P2PAttiva_Nome_del_KIT__c,Service_Attribute__c
                       FROM EOF_EAI_Service_Log__c
                       WHERE RecordType.DeveloperName = 'PO_Log_P2P_Attiva_KIT' AND
                       EOF_SL_Riferimento__c =:ApexPages.currentPage().getParameters().get('parentId')];
            //controllo se ci sono kit senza vlan
            ListKitToSend = new List<EOF_EAI_Service_Log__c>();
            if (!kitList.isEmpty()) {
                for (EOF_EAI_Service_Log__c kit : kitList) {
                    if (KitConVlan.add(kit.id)) {
                        checkKitSenzaVlan=true;
                        slListToDelete.add(kit);
                        break;
                    }
                    else{
                        ListKitToSend.add(kit);
                    }
                }
            }
        }
    }

	@testVisible
	private Boolean checkVlanEline(Set<Id> logIds, List<EOF_EAI_Service_Log__c> sLogVlanList) {
		Set<Id> collegOnVlan = new Set<Id>();
		for(EOF_EAI_Service_Log__c l : sLogVlanList) {
			collegOnVlan.add(l.EOF_SL_Riferimento__c);
		}

		if(!logIds.containsAll(collegOnVlan)) {
			return false;			
		} else {
			return true;
		}
	}

	// wrapper per info sui collegamenti nel riepologo richiesta
	@testVisible
	private List<ServiceLogWrapper> buildLogWrapper(List<EOF_EAI_Service_Log__c> sLogVlanList, List<EOF_EAI_Service_Log__c> sLogKitList) {
		// PARTE ELINE

		for(EOF_EAI_Service_Log__c log : P2PAttivaLogList) {
			System.debug('@@@ log id' + log.id);
			slWrapObj =  new ServiceLogWrapper();
			slWrapObj.sLogColl = log;
		
			for(EOF_EAI_Service_Log__c vlan : sLogVlanList) {
				System.debug('@@@ vlan id' + vlan.id);
				if(vlan.EOF_SL_Riferimento__c == log.Id) {
					slWrapObj.profilosVlan = vlan.OF_SA_PROFILO_VLAN__c;
				}
			}

			for(EOF_EAI_Service_Log__c kit : sLogKitList) {
				System.debug('@@@ kit id' + kit.id);
				if(kit.id == log.OF_PP_KIT_Log__c || kit.id == log.kit_in_condivisione__c ){
					slWrapObj.nomeKit = kit.PO_P2PAttiva_Nome_del_KIT__c; 
				}
			}

			slWrapList.add(slWrapObj);
		}
		System.debug('@@@SIZE ' + slWrapList.size());
		return slWrapList;
	}
    
    public PageReference ParentDataOrderUpdation() {
        Set<Id> setIdOrderCases = new Set<Id>();
        Set<Id> seIdCollCases = new Set<Id>();//EC 2018 - 09 - 11
        
        Map<Id,Id> mapCollOrd = new Map<Id,Id>();
        // DN - after integrazione dom
        Map<Id,Id> map_IdCollIdOrdine = new Map<Id,Id>();
        
        system.debug('@@@EC ParentDataOrderUpdation method.');
        for (EOF_EAI_Service_Log__c sLog : orderLogs) {
            system.debug('@@@EC sLog è un slOrdine. il Caso__c dovrebbe essere un case ordine legato al relativo collegamento il parentId del caso ordine è cmq la fattibilità non il collegamento!');
            system.debug('@@@EC sLog rtName: ' + sLog.RecordtypeId);
            system.debug('@@@EC sLog.Caso__c: ' + sLog.Caso__c);
            system.debug('@@@EC sLog.Caso__c RT: ' + sLog.Caso__r.RecordtypeId);
            system.debug('@@@EC sLog.Caso__r.ParentId: ' + sLog.Caso__r.ParentId);
            system.debug('@@@EC sLog.Caso__r.ParentId: ' + sLog.Caso__r.ParentId);
            system.debug('@@@EC sLog.Caso__r.PO_Case_Collegamento__c: ' + sLog.Caso__r.PO_Case_Collegamento__c);
            
            setIdOrderCases.add(sLog.Caso__c);
            seIdCollCases.add(sLog.Caso__r.ParentId);//EC 2018 - 09 - 11
            
            mapCollOrd.put(sLog.Caso__r.ParentId,sLog.id);     //EC start 2018 - 10 - 12
            map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
            
            System.debug('##### ParentDataOrderUpdation collegamento id: ' + sLog.Caso__r.ParentId);
            System.debug('##### ParentDataOrderUpdation ordine id: ' + sLog.Caso__c);
        }
        
        //EC start 2018 - 10 - 12
        List<attachment> attList = [SELECT id,name,parentid,IsPrivate,createddate FROM attachment WHERE parentid IN : seIdCollCases];
        
        //EC end 2018 - 10 - 12
        
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
//	delete attToDelete;
}
}
*/
        //EC end 2018 - 10 - 12
        
        parentLogObj.PO_Offerta_Inoltrata__c = true;
        update parentLogObj;
        
        // DN - make callout
        System.debug('##### PO_P2PAtt_RiepReq_ElCoCntrl.ParentDataOrderUpdation -- parent case id: ' + parentLogObj.Caso__c);
        System.debug('##### PO_P2PAtt_RiepReq_ElCoCntrl.ParentDataOrderUpdation -- map collegamenti ordini: ' + map_IdCollIdOrdine);
        List<Case> lParentCase = [SELECT Id, Status, EOF_Fase__c, isDOM__c FROM Case 
                                  WHERE Id =: parentLogObj.Caso__c];
        if(!lParentCase.isEmpty()) {
            if(lParentCase[0].isDOM__c) { 
                System.debug('##### PO_P2PAtt_RiepReq_ElCoCntrl.ParentDataOrderUpdation parentCase.isDOM: ' + lParentCase[0].isDOM__c);
                OLO_ActivationP2PManager.sendToDOM(map_IdCollIdOrdine, parentLogObj.Caso__c);
            } else {
                List<Case> listOrderCases = [SELECT Id, Status, OwnerId
                                             FROM Case
                                             WHERE Id IN : setIdOrderCases
                                             AND PO_Data_Attivazione_Richiesta__c != null
                                             AND PO_Nome_E_Cognome_PM__c != null
                                             AND PO_Numero_Telefonico_PM__c != null
                                             AND Status = 'Accettato'];		
                
                System.debug('PO_P2PAtt_RiepReq_ElCoCntrl.ParentDataOrderUpdation -- listOrderCases: ' + listOrderCases);						
                
                Group codaSupportoVendite = [Select Id,DeveloperName from Group where DeveloperName='PO_Coda_Ordini_Fattibilita' limit 1];
                
                for (Case caseToUpdate : listOrderCases) {
                    caseToUpdate.OwnerId = codaSupportoVendite.Id;                    
                }
                update listOrderCases;	
                System.debug('##### ParentDataOrderUpdation - owner id updated, is ' + codaSupportoVendite.DeveloperName);
            }
        } 
        
        
        
        Pagereference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('parentId',parentLogObj.Id);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
        
    }
    
    
    
    
    /*EC start commento 2019 05 29
//FD 06-12-2018 CR Check Vendibilità - START

@TestVisible
private Contract getContratto(Id theAccountId, String theOfferta) {
system.debug('#### theOfferta ' + theOfferta);
List<OF_Servizio__c> servizi = [SELECT Id, Name FROM OF_Servizio__c WHERE Name = :theOfferta];
Id idServizio;
if ((servizi != null) && (servizi.size() > 0)) {
idServizio = servizi[0].Id;
}
Contract contratto = null;
Date oggi = Date.Today();
system.debug('#### theAccountId ' + theAccountId + ' ##### : ' + oggi) ;
List<Contract> contratti = [SELECT Id, StartDate, EndDate, OF_IdContratto__c, (SELECT Id, Name, OF_Servizio__c FROM Contratti_Servizi__r) FROM Contract where
AccountId = :theAccountId AND
Status = 'Attivo' AND
StartDate <= :oggi AND
EndDate > :oggi];
system.debug('giovanni contratti: ' + contratti);
if ((contratti != null) && (contratti.size() > 0)) {
for (Contract c : contratti) {
//system.debug('giovanni c.Contratti_Servizi__r: ' + c.Contratti_Servizi__r);
for (OF_ContrattoServizio__c serv : c.Contratti_Servizi__r) {
system.debug('#### idServizio: ' + idServizio);
if (serv.OF_Servizio__c == idServizio) {
contratto = c;
break;
}
}
if (contratto != null) {
break;
}
}
}
system.debug('##### contratto.OF_IdContratto__c: ' + contratto.OF_IdContratto__c);
return contratto;
}
EC end commento 2019 05 29   */
    
    @TestVisible
    private Contract getContratto(Id theAccountId, String theOfferta) {
        system.debug('#### theOfferta ' + theOfferta);
        Contract contratto = null;
        Date oggi = Date.Today();
        
        Set<Id> contractIdSet = new Set<Id>();
        
        for(OF_ContrattoServizio__c contrServ: [select id, OF_Contract__c, OF_Servizio__c,
                                                OF_Contract__r.StartDate, OF_Contract__r.EndDate,
                                                OF_Contract__r.Status, OF_Contract__r.AccountId
                                                from OF_ContrattoServizio__c
                                                where OF_Contract__r.AccountId=:theAccountId
                                                AND OF_Servizio__r.Name= :theOfferta
                                                AND OF_Contract__r.Status ='Attivo'
                                                AND OF_Contract__r.StartDate <=: oggi
                                                And OF_Contract__r.EndDate >: oggi]){
                                                    contractIdSet.add(contrServ.OF_Contract__c);                      
                                                }
        
        List<Contract> contratti = [SELECT Id, StartDate, EndDate, OF_IdContratto__c,
                                    (SELECT Id, Name, OF_Servizio__c FROM Contratti_Servizi__r) 
                                    FROM Contract 
                                    where ID =:contractIdSet];
        if(!contratti.isEmpty()){
            contratto= contratti.get(0);
        }
        //system.debug('##### contratto.OF_IdContratto__c: ' + contratto.OF_IdContratto__c);
        return contratto;
    }
    
    @TestVisible
    private String checkVendibilitaRichiesta(Id theAccountId, String theOfferta) {
        String errore = null;
        Contract contratto = getContratto(theAccountId, theOfferta);
        //Controllo se esiste un contratto per questo account
        if (contratto == null) {
            errore = 'Non esiste un contratto per questo account';
            return errore;
        }
        system.debug('giovanni contratto: ' + contratto);
        List<OF_Servizio__c> serviziDelContratto = [SELECT Id, Name FROM OF_Servizio__c WHERE Id IN (SELECT OF_Servizio__c FROM OF_ContrattoServizio__c WHERE OF_Contract__c = :contratto.Id)];
        system.debug('giovanni serviziDelContratto: ' + serviziDelContratto);
        if ((serviziDelContratto != null) && (serviziDelContratto.size() > 0)) {
            Boolean isOffertaCopertaDalContratto = false;
            for (OF_Servizio__c servizio : serviziDelContratto) {
                if (servizio.Name == theOfferta) {
                    isOffertaCopertaDalContratto = true;
                    break;
                }
            }
            if (!isOffertaCopertaDalContratto) {
                errore = 'Servizio non presente nel contratto per questo account';
                return errore;
            }
        }
        else{
            errore = 'Il contratto per questo account non ha servizi';
            return errore;
        }
        //Creo una lista dei comuni dei collegamenti
        List<String> listaComuniDeiCollegamenti = new List<String>();
        system.debug('giovanni P2PAttivaLogList: ' + P2PAttivaLogList);
        for (EOF_EAI_Service_Log__c collegamento : P2PAttivaLogList) {
            listaComuniDeiCollegamenti.add(collegamento.EOF_Comune__c);
        }
        
        system.debug('giovanni listaComuniDeiCollegamenti: ' + listaComuniDeiCollegamenti);
        system.debug('giovanni contratto.Id: ' + contratto.Id);
        
        /*	List<OF_AreaGeograficaJunction__c> areeGeografiche = [SELECT Id, OF_Comune__c FROM OF_AreaGeograficaJunction__c WHERE OF_Contratto__c = :contratto.Id];

system.debug('giovanni areeGeografiche: ' + areeGeografiche);
if ((areeGeografiche != null) && (areeGeografiche.size() > 0)) {
Boolean isComuneCopertoDalContratto = false;
for (String comuneNeiCollegamenti : listaComuniDeiCollegamenti) {
for (OF_AreaGeograficaJunction__c ag : areeGeografiche) {
if (comuneNeiCollegamenti == ag.OF_Comune__c) {
isComuneCopertoDalContratto = true;
break;
}
}
if (isComuneCopertoDalContratto) {
break;
}
}
if (!isComuneCopertoDalContratto) {
errore = 'Uno dei comuni non è coperto dal contratto';
return errore;
}
}
else{
errore = 'Il contratto non ha aree geografiche';
return errore;
}
system.debug('giovanni fine');
*/
        //Il controllo di vendibilità è stato superato con successo
        errore = null;
        return errore;
    }
    //FD 06-12-2018 CR Check Vendibilità - END
    
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
    
    public pagereference currentUserParentLogs()
    {
        newAtt.clear();
        //attxlxs.clear();
        attlst.clear();
        //system.debug('recordOfferta==>'+recordOfferta) ;
        
        set<id> parentLogs = new set<id>();
        for (EOF_EAI_Service_Log__c lo : [select id from EOF_EAI_Service_Log__c where /*ContactId =:usr.contact.id  AND PO_Offerta__c=:recordOfferta and*/ recordtype.developername = 'PO_P2PAttiva_Request'])
        {
            parentLogs.add(lo.id);
        }
        
        currentUserLogs = [select id,/*PO_Tipologia_Offerta__c,*/ Name,CreatedDate,PO_Tipo_di_collegamento__c, PO_Tipo_percorso__c,/*PO_Offerta__c,*/
                           EOF_STATO_ORDINE__c,EOF_Stato_Richiesta__c,PO_Nome_Progetto__c, EOF_Codice_Ordine_OLO__c, PO_Nota_sito__c,
                           EOF_Comune__c from EOF_EAI_Service_Log__c
                           where id IN :parentLogs
                           order by CreatedDate desc];
        //system.debug('currentUserLogs====='+ currentUserLogs);
        sortLogs =getsortingLogs(); //to change getsortingCases con getsortingLogs
        //system.debug('currentUserLogs====='+ sortLogs);
        //return new pagereference ('/apex/Po_FeasibilityServicesRequest?recordOfferta='+recordOfferta);
        return new pagereference ('/PO_P2P_Attivo_DisplayRequest');
    }
    
    
    
    //to delete?
    public list<case> getsortingCases()
    {   //system.debug('insideSortigCases'+sortCases) ;
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
    
    public list<EOF_EAI_Service_Log__c> getsortingLogs() {
        //system.debug('insideSortigLogs'+sortLogs) ;
        //system.debug('recordOfferta==>'+recordOfferta) ;
        String recOff=ApexPages.currentPage().getParameters().get('recordOfferta');
        //system.debug('pageparameter'+recOff) ;
        if (recordOfferta == null) {
            recordOfferta=recOff;
        }
        
        if (recordOfferta != null) {
            set<id> parentLogs = new set<id>();
            
            for (EOF_EAI_Service_Log__c lo : [select id,EOF_SL_Riferimento__c, EOF_Codice_Ordine_OLO__c, EOF_Stato_Richiesta__c,/*PO_Nome_Progetto__c,parent.PO_Offerta__c,PO_Tipologia_Offerta__c,*/ OwnerId,CreatedDate,PO_Nota_sito__c from EOF_EAI_Service_Log__c where PO_Contact__c =:usr.contact.id /* AND PO_Tipologia_Offerta__c=:recordOfferta*/])
            {
                //if(cas.parent.PO_Offerta__c == 'P2P Base')
                parentLogs.add(lo.EOF_SL_Riferimento__c);
            }
            for (EOF_EAI_Service_Log__c lo : [select id from EOF_EAI_Service_Log__c where PO_Contact__c =:usr.contact.id /* AND PO_Offerta__c=:recordOfferta*/ and recordtype.developername = 'PO_P2PAttiva_Request' /*'PO_Richiesta_a_servizio_a_fattibilit'*/ ])
            {
                parentLogs.add(lo.id);
                //system.debug('case==='+lo);
            }
            
            string query = 'select id,casenumber,CreatedDate,PO_Offerta__c,PO_Nome_Progetto__c,Status from case where id IN :parentcases ';
            query += ' Order by ' +  String.escapeSingleQuotes(sortField) + ' ' + myOrder;
            
            return Database.query(query);
            //currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status from case where id IN :parentcases order by CreatedDate desc];
        }
        return SortLogs;
    }
    
    /**
* @returns TRUE if there is at lease one Case order linked to the main request, FALSE otherwise.
*/
    private boolean isThereAnyCaseOrder(Case caseRichiesta) {
        List<Case> caseOrdini = [SELECT Id FROM Case WHERE PO_Richiesta_a_fattibilit_ordine__c = :caseRichiesta.Id];
        return !caseOrdini.isEmpty();
    }
    
    public pagereference OpportunityStageNameUpdate()
    {
        String sId= ApexPages.currentPage().getParameters().get('parentId');
        parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, Id,EOF_Fase__c,ParentId, OF_Order__c, OF_Order__r.ContractId,
                         PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c,
                         Subject, Status, Priority, CreatedDate, CreatedById,PO_Offerta__c,
                         ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId, isDOM__c,
                         EOF_Codice_Operatore_WS__c, OF_Servizio__c, EOF_Data_Notifica__c
                         FROM Case WHERE Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=: sId) LIMIT 1];
        
        if (parentcaseobj.PO_Offerta__c == 'P2P Attiva' && !isThereAnyCaseOrder(parentcaseobj))
        {
            ordine = true;
            //parentfile = false;
            
            opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Numero_Anni__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,
                   (SELECT Id,Name,ParentId,ContentType from Attachments)
                   from opportunity where PO_Richiesta_fattibilit__r.id =: parentLogObj.Caso__c and PO_Collegamento__c = null limit 1];
            
            
            List<Opportunity> opplst = [select id,name,PO_Prezzo_totale_scontato__c,stagename,PO_Richiesta_fattibilit__c from opportunity
                                        where id in : opp limit 1 ];
            
            
            if ((opplst.size() > 0) && !opplst.isEmpty()) {
                if (opplst[0].stagename == 'Offerta presentata') {
                    opplst[0].StageName = 'Offerta accettata';
                    update opplst[0];
                }
                
            }
            if (parentCaseObj != null) {
                System.debug('@@@ FD OpportunityStageNameUpdate');
                // RDG 2019-02-08
                if (String.isNotBlank(parentCaseObj.OF_Order__c) && String.isNotBlank(parentCaseObj.OF_Order__r.ContractId)) {
                    parentCaseObj.OF_IDContratto__c = parentCaseObj.OF_Order__r.ContractId;
                    System.debug('Contratto [' + parentCaseObj.OF_IDContratto__c + '] - Case: ' + parentCaseObj.Id);
                }
                if (opplst[0].StageName != null) {
                    parentCaseObj.Status = 'Accettato';
                    
                    parentCaseObj.Accordo_Operativo__c = 'Identificativo della richiesta di Fattibilità';
                    
                    // L'owner continua ad essere l'utente che ha presentato l'offerta non quello
                    // che l'ha accettata
                    //parentCaseObj.OwnerId = UserInfo.getUserId();
                    parentLogObj.EOF_STATO_ORDINE__c = parentCaseObj.Status;
                    
                    //Popolo i campi Accordo Quadro e Accordo Operativo
                    parentLogObj.Accordo_Operativo__c = parentCaseObj.CaseNumber;
                    parentCaseObj.Accordo_Operativo__c = parentCaseObj.CaseNumber;
                    
                    parentCaseObj.PO_Accordo_Quadro_Number__c = parentLogObj.PO_Accordo_Quadro_Number__c;
                }
                update parentLogObj;
                update parentCaseObj;
                list<case> childcaselst = [select id,PO_IndrizoCal__c,PO_Incluso_nell_offerta__c,PO_Comune2__c,status,casenumber,
                                           PO_Nome_Comune__c,CreatedDate,ClosedDate,parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,
                                           PO_Tipo_di_collegamento__c,PO_Numero_fibre_richieste__c,AccountId,PO_Prime_Contractor__c,PO_Nome_sito__c,
                                           PO_Comune__c,PO_Indirizzo_sito__c,PO_Tipo_percorso__c,PO_Note_collegamento__c,PO_Sito__c,PO_Nota_sito__c,
                                           PO_Indirizzo_collegamento__c,recordtype.id,recordtype.developerName,OwnerId,PO_Case_Collegamento__r.PO_Incluso_nell_offerta__c,
                                           PO_Comune3__c,PO_sito_3__c,PO_Nota_sito_3__c,PO_Comune4__c,PO_indirizzo_collegamento_3__C,PO_civico_3__c,
                                           PO_Drop_FL_1__c,PO_Sito_partenza__c,PO_Civico_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Nota_sito_partenza__c,
                                           PO_Civico__c,PO_Richiesta_a_fattibilit__c,EOF_Codice_Operatore_WS__c, (Select Id,Caso__c from EAI_Service_Logs1__r where RecordType.DeveloperName='P2P_Attiva_Collegamento')
                                           from case where parentid=: parentCaseObj.id and PO_Incluso_nell_offerta__c = true];
                
                //system.debug('childcaselst======='+parentCaseObj.PO_Durata_affitto__c);
                
                if (childcaselst.size() > 0) {
                    
                    parentfile = true;
                    stagename = false;
                    
                    
                    
                    List<Case> createdCaseOrdine = OrderCreation(childcaselst);
                    
                    // DN -- for check isDom
                    Datetime createdDate = null;
                    if(!createdCaseOrdine.isEmpty()) {
                        createdDate = [SELECT createdDate FROM Case WHERE Id =: createdCaseOrdine[0].Id].createdDate;
                    }					
                    // DN - check isDom
                    System.debug('##### PO_P2PAtt_RiepReq_ElCoCntrl.OpportunityStageNameUpdate -- before verifica dom -- parentCaseObj: ' + parentCaseObj);
                    if(OF_Utils_P2P.checkIsDOM(parentCaseObj, createdDate)) {
                        for(Case c : createdCaseOrdine) {
                            c.EOF_Fase__c = 'Bozza';
                            c.isPSM__c = false;
                            c.view_PopUp_PSM__c = false;
                        }
                        update createdCaseOrdine;
                    } else if (createdCaseOrdine[0].recordType.developerName == RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE
                        || createdCaseOrdine[0].recordType.developerName == RTypeServFattibilita.CASE_P2P_ORDINE_ELINE) {
                        for(Case c : createdCaseOrdine) {
                            c.isPSM__c = false;
                            c.view_PopUp_PSM__c = false;
                        }
                        update createdCaseOrdine; 
                    } else if (createdCaseOrdine[0].recordType.developerName == RTypeServFattibilita.CASE_P2P_BASE_ORDINE) {
                        for(Case c : createdCaseOrdine) {
                            c.isPSM__c = true;
                            c.view_PopUp_PSM__c = true;
                        }
                        update createdCaseOrdine; 
                    }
                    
                    // PO_ServiziFattibilita_Controller. childcaselst);
                }
                
            }
        }
        //system.debug('la variabile  booleana parentfile è: ' + parentfile);
        // return null;
        Pagereference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('parentId',sId);
        pg.getParameters().put('tipoP2Patt', tipoP2PAttiva);
        return pg;
    }
     
    
    public Pagereference SaveParentChildCaseInfo()
    {
        P2PAttivaLog = new EOF_EAI_Service_Log__c();
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
            if ((selectedIdComune != null) && (selectedIdComune != '') && (selectedIdComune != 'Inserisci qui il nome comune'))
            {
                ag = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune limit 1];
                //system.debug('Commune Name--->'+ag.OF_Comune__c);
            }
            if ((selectedIdComune1 != null) && (selectedIdComune1 != '') && (selectedIdComune1 != 'Inserisci qui il nome comune'))
            {
                ag1 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune1 limit 1];
                //system.debug('Commune Name--->'+ag1.OF_Comune__c);
            }
            
            if ((selectedIdComune2 != null) && (selectedIdComune2 != '') && (selectedIdComune2 != 'Inserisci qui il nome comune'))
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
            
            if ((parentCase != null) && (parentCase.id != null))
            {
                // parentid  = parentCase.id;
                parentid  = testParentIdSave;
                //system.debug('Saving ChildCase'+ParentCase.id);
                
            }
            if ((parentcaseobj != null) && (parentcaseobj.id != null))
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
        System.debug('@@@ FD OrderCreation nel controller');
        OF_UtilitiesManageOrderFromCase obju = new OF_UtilitiesManageOrderFromCase();
        //List<EOF_EAI_Service_Log__c> vLanToUpdate = new  List<EOF_EAI_Service_Log__c>();/*EC 2018 - 09 - 11 bisogna legare le vlan agli ordini,
        //sia ai Case Ordine sia ai Log Ordine, ma mantenendo anche la relazione
        //con i case di Collegamento, abbiamo quindi creato dei nuovi campi di lookup
        // su EOF_EAI_Service_Log__c*/
        List<Case> caseToInsert = new List<Case>();
        
        //EC Start 2018 - 08 - 29 CaseToOrder già contiene i case di collegamento
        //
        //		vLanToUpdate=[];
        List<Case> CaseToOrder =[select Id, OF_IDContratto__c, status, CaseNumber, PO_IndrizoCal__c,PO_Case_Collegamento__r.PO_Incluso_nell_offerta__c, EOF_fase__c,
                                 PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,PO_Numero_fibre_richieste__c,PO_Comune3__c,PO_sito_3__c,
                                 PO_Nota_sito_3__c, PO_Comune4__c,PO_indirizzo_collegamento_3__C,PO_civico_3__c,PO_Drop_FL_1__c, AccountId,
                                 PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,PO_Tipo_percorso__c,PO_Comune2__c,
                                 PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,PO_Sito_partenza__c,
                                 PO_Civico_partenza__c, PO_Indirizzo_collegamento_partenza__c, PO_Nota_sito_partenza__c, PO_Civico__c,
                                 recordtype.id,recordtype.developerName,PO_Richiesta_a_fattibilit__c,OwnerId,EOF_Codice_Operatore_WS__c,
                                 PO_KIT_Consegna_VLAN__c, Account.EOF_Codice_Operatore__c,
                                 //Modifica Toponomastica
                                 Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,
                                 (Select Id,Caso__c from EAI_Service_Logs1__r where RecordType.DeveloperName='P2P_Attiva_Collegamento')
                                 from case where id IN: CaseFromPortal];
        
        //system.debug('La lista di case di clg è:'+CaseToOrder.size());
        
        List<Case> caseOrderToUpdate = new List<Case>(); //EC 2018 - 08 - 29
        
        List<Contract> theContractList = null;
        if (String.isNotBlank(parentCaseObj.PO_Accordo_Quadro_Number__c)) {
            theContractList = [SELECT Id, OF_IDContratto__c FROM Contract WHERE OF_IdContratto__c = :parentCaseObj.PO_Accordo_Quadro_Number__c AND Status = 'Attivo'];
        }
        
        Set<Id> caseParentIds = new Set<Id>();
        
        for (Case c : CaseToOrder) {
            //system.debug('EOF_Codice_Operatore_WS__c: ' + c.EOF_Codice_Operatore_WS__c);
            caseParentIds.add(c.Id);
            Case cs = new Case();
            cs.status='Accettato';
            cs.ParentId=c.Id;
            cs.EOF_Codice_Operatore_WS__c = String.isNotBlank(c.EOF_Codice_Operatore_WS__c) ? c.EOF_Codice_Operatore_WS__c : c.Account.EOF_Codice_Operatore__c;
            cs.EOF_Fase__c='In lavorazione supporto vendite';
            cs.PO_Case_Collegamento__c=c.Id;
            cs.PO_Tipo_di_collegamento__c=c.PO_Tipo_di_collegamento__c;
            cs.PO_Numero_fibre_richieste__c=c.PO_Numero_fibre_richieste__c;
            cs.AccountId=c.AccountId;
            
            cs.OF_IDContratto__c=c.OF_IDContratto__c;// RDG 2019-02-08
            cs.PO_Prime_Contractor__c=c.PO_Prime_Contractor__c;
            cs.PO_Nome_sito__c=c.PO_Nome_sito__c;
            cs.PO_KIT_Consegna_VLAN__c=c.PO_KIT_Consegna_VLAN__c;
            cs.PO_Comune2__c =c.PO_Comune2__c;
            //cs.PO_Indirizzo_sito__c=c.PO_Indirizzo_sito__c;
            cs.PO_Tipo_percorso__c=c.PO_Tipo_percorso__c;
            //cs.PO_Note_collegamento__c=c.PO_Note_collegamento__c;
            cs.PO_Sito__c=c.PO_Sito__c;
            cs.PO_Nota_sito__c=c.PO_Nota_sito__c;
            cs.PO_Indirizzo_collegamento__c=c.PO_Indirizzo_collegamento__c;
            //cs.PO_Sito_partenza__c= c.PO_Sito_partenza__c;
            //cs.PO_Civico_partenza__c= c.PO_Civico_partenza__c;
            //cs.PO_Indirizzo_collegamento_partenza__c= c.PO_Indirizzo_collegamento_partenza__c;
            //cs.PO_Nota_sito_partenza__c= c.PO_Nota_sito_partenza__c;
            cs.PO_Civico__c= c.PO_Civico__c;
            //28/09/2017 CRM Modifica
            cs.PO_Richiesta_a_fattibilit_ordine__c = c.PO_Richiesta_a_fattibilit__c;
            //28/09/2017 END CRM
            if(tipoP2PAttiva =='eLine'){
                cs.recordtypeid = rtMap.get('P2P_Attiva_COrdine_ELine');
            }else{
                cs.recordtypeid = rtMap.get('PO_Ordine_P2P_Attiva');
            }
            //cs.OwnerId=codaSupportoVendite.Id;
            // cs.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Operatore_WS__c + '_' + c.CaseNumber; //FD 2019-02-28 EOF_Codice_Ordine_OLO__c su case ordine
            //Modifica Toponomastica
            cs.Particella_Toponomastica_1__c = c.Particella_Toponomastica_1__c;
            cs.Particella_Toponomastica_2__c = c.Particella_Toponomastica_2__c;
            cs.Particella_Toponomastica_3__c = c.Particella_Toponomastica_3__c;
            if (parentCaseObj.Accordo_Operativo__c != null) {
                cs.Accordo_Operativo__c = parentCaseObj.Accordo_Operativo__c;
            }
            if (String.isNotBlank(parentCaseObj.PO_Accordo_Quadro_Number__c)) {
                cs.PO_Accordo_Quadro_Number__c = parentCaseObj.PO_Accordo_Quadro_Number__c;
                
                //giovanni 28012019 inizio
                //Modifica ContractId
                //cs.PO_Accordo_Quadro__c = parentCaseObj.PO_Accordo_Quadro_Number__c;
                if ((theContractList != null) && !theContractList.isEmpty()) {
                    cs.PO_Accordo_Quadro__c = theContractList[0].Id;
                    // RDG 2019-01-31
                    cs.OF_IDContratto__c = theContractList[0].Id;
                }
                //giovanni 28012019 fine
            }
            caseToInsert.add(cs);
        }
        
        insert caseToInsert;
        //27-12-2018 V1 BUGFIX P2PATTIVA -start
        List<Id> IdCase = new List <Id>();
        for (Case c2 : caseToInsert) {IdCase.add(c2.Id);}
        List<Case> nomiComuni = [SELECT PO_Comune2__r.OF_Comune__c FROM Case WHERE Id =: IdCase];
        Map<Id, String> IdCaseXNomeComune = new Map<Id, String>();
        for (Case c3 : nomiComuni) {IdCaseXNomeComune.put(c3.Id, c3.PO_Comune2__r.OF_Comune__c);}
        //27-12-2018 V1 BUGFIX P2PATTIVA -end
        
        List<EOF_EAI_Service_Log__c> SlogToInsert = new List<EOF_EAI_Service_Log__c>();
        
        Map<Id, EOF_EAI_Service_Log__c> mapParentCaseIdServiceLog = new Map<Id, EOF_EAI_Service_Log__c>();
        if(tipoP2PAttiva =='eLine'){
            for (EOF_EAI_Service_Log__c sl: [SELECT Id, Caso__c, Caso__r.CaseNumber, EOF_Comune__c FROM EOF_EAI_Service_Log__c WHERE Caso__c IN :caseParentIds and RecordType.DeveloperName='P2P_Attiva_Collegamento_ELine' ]) { //FD 2019-02-13 aggiunta Caso__r.CaseNumber
                mapParentCaseIdServiceLog.put(sl.Caso__c, sl);
            }
        }
        
        else{
            for (EOF_EAI_Service_Log__c sl: [SELECT Id, Caso__c, Caso__r.CaseNumber, EOF_Comune__c FROM EOF_EAI_Service_Log__c WHERE Caso__c IN :caseParentIds and RecordType.DeveloperName='P2P_Attiva_Collegamento' ]) { //FD 2019-02-13 aggiunta Caso__r.CaseNumber
                mapParentCaseIdServiceLog.put(sl.Caso__c, sl);
            }
        }
        Map<Id, Case> mapIdCaseOrdine = new Map<Id, Case>();
        for (Case c1 : caseToInsert) {
            EOF_EAI_Service_Log__c slo = new EOF_EAI_Service_Log__c();
            if(tipoP2PAttiva =='eLine'){
                slo.recordtypeid = rtMap.get('P2P_Attiva_Ordine_ELine');
            }else{
                slo.recordtypeid = rtMap.get('PO_P2P_Attiva_Ordine');
            }
            slo.Caso__c = c1.id;
            mapIdCaseOrdine.put(c1.Id, c1);
            EOF_EAI_Service_Log__c sloParent = mapParentCaseIdServiceLog.get(c1.ParentId);
            if (sloParent != null) {
                slo.EOF_SL_Riferimento__c = sloParent.Id;
                //slo.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Operatore_WS__c + '_' + sloParent.Caso__r.CaseNumber;
                slo.EOF_Comune__c = sloParent.EOF_Comune__c;
            } else {
                slo.EOF_SL_Riferimento__c = null;
            }
            slo.EOF_Codice_Operatore__c=c1.EOF_Codice_Operatore_WS__c;
            //slo.EOF_SL_Riferimento__c ='';
            //slo.AccountId = c.AccountId;
            slo.PO_Prime_Contractor__c = c1.PO_Prime_Contractor__c;
            slo.PO_Numero_fibre_richieste__c = c1.PO_Numero_fibre_richieste__c;
            slo.PO_Tipo_di_collegamento__c =c1.PO_Tipo_di_collegamento__c;
            //slo.PO_Nome_sito__c = c1.PO_Nome_sito__c;
            System.debug('@@@ FD PO_Nome_Comune__c ' + c1.PO_Nome_Comune__c);
            System.debug('@@@ FD PO_Nome_Comune2__c ' + c1.PO_Comune2__c);
            System.debug('@@@ FD Formula ' + c1.PO_Comune2__r.OF_Comune__c);
            System.debug('@@@ FD Id Case ' + c1.id);
            slo.EOF_Comune__c = IdCaseXNomeComune.get(c1.Id); //27-12-2018 V1 BUGFIX P2PATTIVA
            //slo.PO_Indirizzo_sito__c = c1.PO_Indirizzo_sito__c;
            slo.PO_Tipo_percorso__c = c1.PO_Tipo_percorso__c;
            //slo.PO_Note_collegamento__c = c1.PO_Note_collegamento__c;
            slo.PO_Sito__c = c1.PO_Sito__c;
            slo.PO_Nota_sito__c = c1.PO_Nota_sito__c;
            slo.PO_Indirizzo_collegamento__c = c1.PO_Indirizzo_collegamento__c;
            //slo.PO_Sito_partenza__c = c1.PO_Sito_partenza__c;
            //slo.PO_Civico_partenza__c = c1.PO_Civico_partenza__c;
            //slo.PO_Indirizzo_collegamento_partenza__c = c1.PO_Indirizzo_collegamento_partenza__c;
            //slo.PO_Nota_sito_partenza__c = c1.PO_Nota_sito_partenza__c;
            slo.PO_Civico__c = c1.PO_Civico__c; //27-12-2018 V1 BUGFIX P2PATTIVA
            //slo.PO_Richiesta_a_fattibilit_ordine__c = c1.PO_Richiesta_a_fattibilit__c;
            slo.PO_Offerta__c = c1.PO_Offerta__c;
            slo.PO_Nome_Progetto__c = c1.PO_Nome_Progetto__c;
            
            //giovanni 24/12/2018
            slo.EOF_STATO_ORDINE__c = 'Accettato';//27-12-2018 V1 BUGFIX P2PATTIVA
            
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
        
        List<OF_CommercialElementIstanziato__c> VlanToBind = [select id,recordtype.id, OF_KITCONSEGNAVLAN__C, OF_USERVLAN__C,OF_SERVICEVLAN__C,OF_PROFILOVLAN__C,OF_CUSTOMERVLAN__C,
                                                              OF_MODELLODISERVIZIOVLAN__C, OF_INFORMAZIONIVLAN__C,OF_Case__c, OF_SA_VLAN__c, OF_CommercialElement__c from OF_CommercialElementIstanziato__c
                                                              where OF_Case__c IN : CaseToOrder];
        
        //system.debug('La lista di Vlan da legare è:'+VlanToBind.size());
        
        
        map<id,id> mapCollOrd = new map<id,id>();
        
        for (case cord: caseToInsert) {
            mapCollOrd.put(cord.PO_Case_Collegamento__c, cord.id);
        }
        
        //system.debug('mappa di id:'+ mapCollOrd);
        
        for (OF_CommercialElementIstanziato__c Vlan : VlanToBind) {
            vlan.PO_Case_ordine__c = mapCollOrd.get(Vlan.OF_SA_VLAN__c);
            
        }
        
        update VlanToBind;
        // 2018-09-12 MM : lego le vlan anche al case e al log ordine di P2P Attiva
        
        
        //Chenges Alessandro
        map<id, set<id>> IdMapNew = new map<id, set<id>>();
        map<id, case> CaseMap = new map<id, case>();
        List<OF_CommercialElementIstanziato__c> CEIToInsert = new List<OF_CommercialElementIstanziato__c>();
        Map<Id,Case> caseFormula = new Map<Id,Case>([select id, casenumber,Codice_Ordine_EOF__c from case where id in: caseToInsert]);
        for (Case c : caseToInsert) {
            
            //system.debug('DG_OF_ManageOrderFromCase - c.status: ' + c.status + '---c.PO_Case_Collegamento__c: ' + c.PO_Case_Collegamento__c);
            
            IdMapNew.put(c.PO_Case_Collegamento__c,new Set<ID> {c.Id});
            CaseMap.put(c.id, c);
            
            //creazione CEI
            /* 
EC start 2019 05  31 commentiamo poiché da HLD il tipo percorso doppia via diversificata non è tra i valori ammessi per P2P Attiva (sia eAccess sia eLine)
if (c.PO_Tipo_percorso__c.toUpperCase() == 'DOPPIA VIA DIVERSIFICATA') {
OF_CommercialElementIstanziato__c partenza = new OF_CommercialElementIstanziato__c();
partenza.recordtypeId=rtMap.get('Tratte');
partenza.OF_CaseTratta__c=c.Id;
CEIToInsert.add(partenza);
OF_CommercialElementIstanziato__c destinazione = new OF_CommercialElementIstanziato__c();
destinazione.recordtypeId=rtMap.get('Tratte');
destinazione.OF_CaseTratta__c=c.Id;
CEIToInsert.add(destinazione);
/*      }
else{ */
            OF_CommercialElementIstanziato__c unico = new OF_CommercialElementIstanziato__c();
            unico.recordtypeId=rtMap.get('Tratte');
            unico.OF_CaseTratta__c=c.Id;
            CEIToInsert.add(unico);
            //  EC end 2019 05 31 commento di if else per tipo percorso doppia via diversificata    }
        } if (!CEIToInsert.isEmpty()) {
            Insert CEIToInsert;
        }
        //system.debug('@@@@@ IdMapNew= '+IdMapNew);
        map<id, list<opportunity>> mappaOpp = objU.CreateMap(IdMapNew);
        //system.debug('@@@@@ mappaOpp= '+mappaOpp);
        map<id, order> mappaCase = new map<id, order>();
        list<Order> orders = new list<Order>();
        //OSCRM 30_08_2017 INIZIO
        map<id,case> caseCollegamento = objU.getCaseCollegamentoFields( CaseMap );
        //FINE
        for (id ix: mappaOpp.keyset())
        {
            opportunity opp = objU.FindOpportunity(ix,mappaOpp);
            //system.debug('DG_OF_ManageOrderFromCase - opp: ' + opp);
            if (opp != null) {
                System.debug('@@@ FD chiamata a Utilities');
                order o = objU.CreateOrderPO(ix, CaseMap, opp, caseCollegamento );
                o.OF_CaseNome__c = caseFormula.get(o.OF_CaseID__c).casenumber;
                o.OF_IDOrdineEOF__c = caseFormula.get(o.OF_CaseID__c).Codice_Ordine_EOF__c;
                orders.add(o);
                mappaCase.put(ix, o);
            }
        }
        //system.debug('@@@@@ orders= '+orders);
        //system.debug('@@@@@ mappaCase= '+mappaCase);
        if (orders.size() > 0) {insert orders;}
        
        
        for (Case c : caseToInsert) {
            c.Of_order__c=mappaCase.get(c.id).id;
            //system.debug('@@@@@ case= '+c.id+' @@@@ ordine= '+c.Of_order__c);
        }
        update caseToInsert;
        //chenges END
        /*EC AV commentiamo tutto
if(!caseOrderToUpdate.isEmpty() && caseOrderToUpdate.size()>0){
dmlOperation(caseOrderToUpdate);
}
*/
        return caseToInsert;
        //}else{
        /*   codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita'];
for(case c : CaseFromPortal){
c.EOF_fase__c='In Lavorazione Supporto Vendite';
c.OwnerId=codaSupportoVendite.Id;
}
update CaseFromPortal;
return null;
// }*/
        
    }
    
    //EC start 2018 - 09 - 26
    
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
    
    //EC end 2018 - 09 - 26
    
    public list<case> getorderCases()
    {
        try
        {
            if (ChildCases.size() > 0) {
                ordercaselst = [select id,status,PO_Comune2__c,EOF_Comunicazioni_con_OLO__c,Note_Sospensione_Operatore__c,PO_Durata_mesi__c,PO_Case_Collegamento__r.PO_IndrizoCal__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
                                PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Case_Collegamento__r.parent.PO_isDataOrder__c, PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                recordtype.id,recordtype.developerName,OwnerId from case where PO_Case_Collegamento__c IN: ChildCases];
            }
            
            //system.debug('ordercaselst======='+ordercaselst);
            //system.debug('ChildCases======='+ChildCases);
        }
        catch (exception e)
        {
            //system.debug('error======='+e.getStackTraceString());
        }
        return ordercaselst;
    }
    
    public pagereference EditOrderInfo()
    {
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        String orderLogId=[Select id from EOF_EAI_Service_Log__c where Caso__c=: caseId].Id;
        
        //system.debug('@@@@@@@EC il caseId è: ' + caseId + ', mentre la stringa orderLogId è: ' + orderLogId);
        
        if (caseId != NULL) {
            childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Data_Attivazione_Ordine__c,PO_Tipologia_Offerta_ordine__c,EOF_Comunicazioni_con_OLO__c,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
                            PO_Prime_Contractor__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById,
                            PO_Offerta__c,PO_Area_Geografica__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c,PO_Richiesta_a_fattibilit__r.PO_Tipologia_Offerta__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId,
                            //Modifica Toponomastica
                            Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c
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
        //   return new pagereference ('/apex/PO_P2PAttiva_OverviewOrder?id='+caseId);
        PageReference pg = new PageReference('/PO_P2PAttiva_OverviewOrder');
        pg.getParameters().put('id', caseId);
        pg.getParameters().put('orderLogId', orderLogId);
        //g.getParameters().put('parentLogId', ApexPages.currentPage().getParameters().get('id'));
        return pg;
        
    }
    
    public pagereference collegmentaDate() {
        //ordine = true;
        String orderId = apexpages.currentPage().getParameters().get('recid');
        ordercasedit = [SELECT id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,PO_Nome_E_Cognome_PM__c,
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
        PageReference pg = new PageREference('/PO_P2PAtt_CompletaOrdine');
        pg.getParameters().put('ordercaseditId', ordercasedit.id);
        pg.getParameters().put('tipoP2Patt', tipoP2PAttiva);
        return pg;
    }
    public pagereference collegmentaDateEdit() {
        //ordine = true;
        string id =apexpages.currentPage().getParameters().get('editid');
        //system.debug('id========'+id);
        
        ordercasedit = [select id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,PO_Nome_E_Cognome_PM__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.id,PO_Tempi_di_attivazione_mesi__c from case where id=: id];
        
        //system.debug('@@@ordercasedit'+ ordercasedit);
        //return new pagereference('/PO_P2PAtt_CompletaOrdine?id'+ordercasedit.id);
        //
        PageReference pg = new PageREference('/PO_P2PAtt_CompletaOrdine');
        pg.getParameters().put('ordercaseditId', ordercasedit.id);
        return pg;
    }
    
    public pagereference OpportunityStageNameUpdate2() {
        //P2PAttivaLogList --> Lista di log figli, da questa recupero i case di collegamento
        Set<Id> setidCaseCollegamenti = new Set<Id>(); //EC 2018 08 28
        for (EOF_EAI_Service_Log__c log : P2PAttivaLogList) {
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
        
        if ((opplst != null) && (opplst.size() > 0) && !opplst.isEmpty()) {
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
                
                //V1 BUGFIX P2PATTIVA inizio
                //parentCaseObj.OwnerId = opplst[0].createdby.id;
                parentCaseObj.OwnerId = opplst[0].CreatedById;
                //V1 BUGFIX P2PATTIVA fine
                
                parentCaseObj.PO_Note_Modifica_Offerta__c = parentLogObj.PO_Note_Modifica_Offerta__c;
                //Aggiorno il log
                parentLogObj.EOF_STATO_ORDINE__c = 'In lavorazione';
            }
            update parentCaseObj;
            update parentLogObj;
        }
        
        if (P2PAttivaLogList.size() > 0) {
            list<case> mylist = new list<case>();
            
            for (EOF_EAI_Service_Log__c log: P2PAttivaLogList) {
                Case tempCase = new Case();
                //Recupero il case legato al log
                tempCase = mapCaseCollegamenti.get(log.Caso__c);
                
                if (log.PO_Incluso_nell_offerta__c == true) {
                    tempCase.Status = 'Completato';
                }else{
                    tempCase.Status = 'Annullato';
                }
                log.EOF_STATO_ORDINE__c = tempCase.Status;
                mylist.add(tempCase);
            }
            if (mylist.size() > 0) {
                update mylist;
                update P2PAttivaLogList;
            }
            parentfile=true;//EC 2018 - 08 - 30
        }
        PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('tipoP2Patt', tipoP2PAttiva);
        pg.getParameters().put('parentId', parentLogObj.Id);/*/ precedentemente la chiave era id. essendo parentLogObj.id abbiamo sostituito con parentId,
//se fosse stato un childlog avremmo sostituito id con cLogId*/
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
        if ((opplst.size() > 0) && !opplst.isEmpty())
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
        if ((opplst != null) && (opplst.size() > 0) && !opplst.isEmpty()) {
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
            childCaseObj = [SELECT CaseNumber,PO_Sito__c,PO_IndrizoCal__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Civico__c,PO_Nota_sito__c,PO_Indirizzo_collegamento__c,PO_Nome_Comune__c,PO_Incluso_nell_offerta__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Comune2__c,PO_Richiesta_a_fattibilit__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById,
                            PO_Offerta__c,PO_Area_Geografica__c,PO_Prime_Contractor__c,PO_Note_Sospensione_OF__c,Note_Sospensione_Operatore__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,OwnerId,
                            //Modifica Toponomastica
                            Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c
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
        if ((parentCasetoDelID != null) && (parentCasetoDelID != '')) {
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
    
    
    public PageReference DeleteParentChildLog()
    {
        Boolean isChild=False;
        EOF_EAI_Service_Log__c ParentLogToshow = new EOF_EAI_Service_Log__c();
        String parentLogtoDelID = apexpages.currentPage().getparameters().get('parentId');
        //system.debug('Eliminia'+parentLogtoDelID);
        
        List<EOF_EAI_Service_Log__c> ChildLogtoDel = new List<EOF_EAI_Service_Log__c>();
        if ((parentLogtoDelID != null) && (parentLogtoDelID != '')) {
            ChildLogtoDel=[Select id from EOF_EAI_Service_Log__c where EOF_SL_Riferimento__c=:ParentLogtoDelID];
            if (ChildLogtoDel.size() > 0)
            {
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
    //EC 2019 05 15 commentiamo il vecchio metodo InviaRichiesta per modificare la logica e inserire la logica di creazione dell'oggetto VLAN invece della creazione del CEI.
    
    
    //EC 2019 05 15 vecchio metodo ----- 
    /*	public pagereference InviaRichiesta() {
Map<String,String> ownerMap = new Map<String,String>();
for (group g:[select id,developername from Group]) {
ownerMap.put(g.developername,g.Id);
}
//Case per richiesta fattibilità
Case parentCase = new Case();
parentCase.RecordTypeId = rtMap.get('PO_Richiesta_a_servizio_a_fattibilit');
parentCase.Status = 'Acquisito';
parentCase.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
parentCase.accountId = accId;
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
for (EOF_EAI_Service_Log__c childLog : P2PAttivaLogList) {
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
for (EOF_EAI_Service_Log__c childLog : P2PAttivaLogList) {
Case tempChild = new Case();
tempChild.RecordTypeId = rtMap.get('PO_Collegamento_P2P_Attiva');
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
if (kitList.size() > 0) {
List<EOF_EAI_Service_Log__c> kitLogToUpdate = new List<EOF_EAI_Service_Log__c>();
for (EOF_EAI_Service_Log__c kitLog : kitList) {
Case tempKitCase = new Case();
tempKitCase.recordTypeId= rtMap.get('PO_Case_P2P_Attiva_KIT');
tempKitCase.EOF_Identificativo_del_POP__c=kitLog.EOF_ID_Pop__c;
// caseKit.PO_Case_Collegamento__c= [select Id from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=:kitLog.id)].id;
// tempKitCase.PO_Case_Collegamento__c= [select Id from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=:childLog.id)].id;
tempKitCase.PO_Case_Collegamento__c=childLog.Caso__c;
//tempKitCase.PO_Case_Collegamento__c = [select Id from Case where Id =:tempChild.id].id;
tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = kitLog.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
tempKitCase.PO_PP_NomeKit__c=kitLog.PO_P2PAttiva_Nome_del_KIT__c;
tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=kitLog.PO_P2PAttiva_Optical_Rate_Limiting__c;
// tempKitCase.OwnerId = ownerCodaFattId; //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato ed eliminato questo pensato!
tempKitCase.OwnerId = ownerMap.get('Coda_Ingegneria_P2PAttiva');
tempKitCase.ParentId=childLog.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
//tempKitCase.PO_Richiesta_a_fattibilit__c=parentCase.id; //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
tempKitCase.Status = 'Acquisito';
kitCases.add(tempKitCase);
kitLog.Caso__c=tempKitCase.Id;
kitLog.EOF_Stato_Richiesta__c='Acquisito';
//Dopo aver popolato il childcase, aggiorno anche il kitLog
kitLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
kitLog.EOF_STATO_ORDINE__c = 'Acquisito';

insert tempKitCase;
kitLog.Caso__c = tempKitCase.Id;
kitCases.add(tempKitCase);

kitLogToUpdate.add(kitLog);
}
update kitLogToUpdate;
}




//Recupero la lista di attachment, in modo da poter aggiornare il parentID
List<Attachment> tempList = mapParentIdListAttach.get(childLog.Id);
system.debug('@@@@@@@@@@@@@@@@@@EC tempList di Attachment è così popolata: ' + tempList);
//Ciclo sulla lista di attachment e setto il nuovo parent id
if ((tempList != null) && !tempList.isEmpty()) {
listAttachToUpdate = new List<Attachment>();
for (Attachment a : tempList) {
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
for (EOF_EAI_Service_Log__c slog : listVLAN) {
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
if ((listAttachToUpdate != null) && !listAttachToUpdate.isEmpty()) {
insert listAttachToUpdate;
system.debug('@@@@@@@@@@@@@@EC abbiamo inserito la lista di attach, che ora è ' + listAttachToUpdate);
}
if ((listVLANToUpdate != null) && !listVLANToUpdate.isEmpty()) {
update listVLANToUpdate;
}
//Inserisco le vlan
if ((nephewVLAN != null) && !nephewVLAN.isEmpty()) {
insert nephewVLAN;
}
//Update per gestire i nuovi stati
update P2PAttivaLogList;
return null;
}


*/
    //EC 2019 05 15 nuovo metodo da verificare che venga effettivamente chiamato da qualche parte!
    public pagereference InviaRichiesta() {
        Map<String,String> ownerMap = new Map<String,String>();
        for (group g:[select id,developername from Group]) {
            ownerMap.put(g.developername,g.Id);
        }
        //Case per richiesta fattibilità
        Case parentCase = new Case();
        parentCase.RecordTypeId = rtMap.get('PO_Richiesta_a_servizio_a_fattibilit');
        parentCase.Status = 'Acquisito';
        parentCase.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
        parentCase.accountId = accId;
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
        for (EOF_EAI_Service_Log__c childLog : P2PAttivaLogList) {
            childLogsCollegamentoId.add(childLog.Id);
            System.debug('@@childLog'+childLog);
        }
        
        //Vado a recuperare la map ParentId - List<Attachment>che utilizzerò dopo nella creazione del case di collegamento
        Map<Id, List<Attachment>> mapParentIdListAttach = getChildLogAttachment(childLogsCollegamentoId);
        //Vado a recuperare la map SL_Riferimento - List<LOGVLAN> che utilizzerò dopo nella creazioen del case di collegamento
        Map<Id, List<EOF_EAI_Service_Log__c>> mapSLRifLog = getVLANLog(childLogsCollegamentoId);
        //Lista case per gli n collegamenti
        List<Case> childCasesCollegamento = new List<Case>();
        //Lista di n VLAN per gli n case di collegamento //EC 2019 05 15 prima CEI ora VLAN
        //List<OF_CommercialElementIstanziato__c> nephewVLAN = new List<OF_CommercialElementIstanziato__c>();
        List<EOF_VLAN__c> nephewVLAN = new List<EOF_VLAN__c>();
        //Lista di attachmente che andrò ad aggioranre
        List<Attachment> listAttachToUpdate;
        //Lista di VLAN che andrò ad aggioranre
        List<EOF_EAI_Service_Log__c> listVLANToUpdate = new List<EOF_EAI_Service_Log__c>();
        //Lista di Kit per gli n kit
        List<Case> kitCases = new List<Case>();
        //RECUPERO L'Id del Commercial Element relativo alle VLAN //EC 2019 05 15 prima CEI ora non essendoci alcun legame con il servizio leghiamo solo al CASE
        //Id vlanObjId = [select id from EOF_VLAN__c where ]
        /*Id vlanCEId = [SELECT Id
FROM OF_CommercialElement__c
WHERE OF_Servizio__r.Name='Open Stream'
AND Name='VLAN' LIMIT 1].Id;
*/
        //Ciclo tutti i log figli per crearne i case
        for (EOF_EAI_Service_Log__c childLog : P2PAttivaLogList) {
            Case tempChild = new Case();
            tempChild.RecordTypeId = rtMap.get('PO_Collegamento_P2P_Attiva');
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
            if (kitList.size() > 0) {
                List<EOF_EAI_Service_Log__c> kitLogToUpdate = new List<EOF_EAI_Service_Log__c>();
                for (EOF_EAI_Service_Log__c kitLog : kitList) {
                    Case tempKitCase = new Case();
                    tempKitCase.recordTypeId= rtMap.get('PO_Case_P2P_Attiva_KIT');
                    tempKitCase.EOF_Identificativo_del_POP__c=kitLog.EOF_ID_Pop__c;
                    // caseKit.PO_Case_Collegamento__c= [select Id from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=:kitLog.id)].id;
                    // tempKitCase.PO_Case_Collegamento__c= [select Id from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=:childLog.id)].id;
                    tempKitCase.PO_Case_Collegamento__c=childLog.Caso__c;
                    //tempKitCase.PO_Case_Collegamento__c = [select Id from Case where Id =:tempChild.id].id;
                    tempKitCase.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = kitLog.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
                    tempKitCase.PO_PP_NomeKit__c=kitLog.PO_P2PAttiva_Nome_del_KIT__c;
                    tempKitCase.PO_P2PAttiva_KIT_OpticalRateLimiting__c=kitLog.PO_P2PAttiva_Optical_Rate_Limiting__c;
                    // tempKitCase.OwnerId = ownerCodaFattId; //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato ed eliminato questo pensato!
                    tempKitCase.OwnerId = ownerMap.get('Coda_Ingegneria_P2PAttiva');
                    tempKitCase.ParentId=childLog.Caso__c;      //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
                    //tempKitCase.PO_Richiesta_a_fattibilit__c=parentCase.id; //EC VC 2018 - 09 - 28 abbiamo commentato il campo ma va decommentato!
                    tempKitCase.Status = 'Acquisito';
                    kitCases.add(tempKitCase);
                    kitLog.Caso__c=tempKitCase.Id;
                    kitLog.EOF_Stato_Richiesta__c='Acquisito';
                    //Dopo aver popolato il childcase, aggiorno anche il kitLog
                    kitLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
                    kitLog.EOF_STATO_ORDINE__c = 'Acquisito';
                    
                    insert tempKitCase;
                    kitLog.Caso__c = tempKitCase.Id;
                    kitCases.add(tempKitCase);
                    
                    kitLogToUpdate.add(kitLog);
                }
                update kitLogToUpdate;
            }
            
            
            
            
            //Recupero la lista di attachment, in modo da poter aggiornare il parentID
            List<Attachment> tempList = mapParentIdListAttach.get(childLog.Id);
            system.debug('@@@@@@@@@@@@@@@@@@EC tempList di Attachment è così popolata: ' + tempList);
            //Ciclo sulla lista di attachment e setto il nuovo parent id
            if ((tempList != null) && !tempList.isEmpty()) {
                listAttachToUpdate = new List<Attachment>();
                for (Attachment a : tempList) {
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
            //Ciclo sulla lista di log delle vlan e ne creo i CEI //EC 2019 05 15 Non si creano più i cei ma direttamente i record dell'oggetto EOF_VLAN__c!
            for (EOF_EAI_Service_Log__c slog : listVLAN) {
                //EC 2019 05 15 - VLAN che verranno aggiunti alla lista da inserire.
                EOF_VLAN__c vlanObj = new EOF_VLAN__c();
                
                vlanObj.Caso__c = tempChild.Id ;
                vlanObj.PO_COS1_CIR__c = 0;//TBD
                vlanObj.PO_COS1_PIR__c = 0;//TBD
                vlanObj.PO_COS3_CIR__c = 0;//TBD
                vlanObj.PO_COS3_PIR__c = 0;//TBD
                vlanObj.PO_COS5_CIR__c = 0;//TBD
                vlanObj.PO_COS5_PIR__c = 0;//TBD
                vlanObj.PO_COS_Class__c = 'TBD?';//TBD
                vlanObj.PO_COS_Remarking__c = 'TBD?';//TBD
                vlanObj.PO_DHCP_Option82__c = 'TBD?';//TBD
                vlanObj.PO_KIT_di_consegna_VLAN__c = sLog.OF_SA_KIT_CONSEGNA_VLAN__c;
                vlanObj.PO_Modello_di_Servizio__c = sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c; 
                vlanObj.PO_Opzione__c = 'Standard';
                vlanObj.PO_Profilo__c = '3Play';//??sLog.OF_SA_PROFILO_VLAN__c; //OF_SA_PROFILO_VLAN_PL__c ??? //OF_SA_PROFILO_VLAN__c
                vlanObj.PO_SVLAN_Traslation__c = 'TBD' ; //OF_SA_INFORMAZIONI_VLAN__c forse serviceVLAN??? cei.OF_SERVICEVLAN__C = sLog.OF_SA_SERVICE_VLAN__C;
                vlanObj.PO_User_VLAN__c = 0; //sLog.OF_SA_USER_VLAN__C; //EC 2019 05 15 Il campo non sarà popolato per le VLAN di P2P Attiva e non sarà inviato alcun valore al DOM (campo opz dell’interfaccia)
                
                //CEI che aggiungerò alla lista da restituire
                /*OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
cei.recordtypeid = rtMap.get('OF_VLAN');
cei.OF_KITCONSEGNAVLAN__C = sLog.OF_SA_KIT_CONSEGNA_VLAN__c;
cei.OF_USERVLAN__C = sLog.OF_SA_USER_VLAN__C; //EC 2019 05 15 Il campo non sarà popolato per le VLAN di P2P Attiva e non sarà inviato alcun valore al DOM (campo opz dell’interfaccia)
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
*/
                nephewVLAN.add(vlanObj);
                //Dopo aver popolato la vlan, aggiorno anche il vlan log
                slog.EOF_Stato_Richiesta__c = 'Inserita Portale';
                slog.EOF_STATO_ORDINE__c = 'Acquisito';
                slog.Caso__c = tempChild.Id;
                listVLANToUpdate.add(slog);
            }
        }
        //Aggiorno gli attachment
        if ((listAttachToUpdate != null) && !listAttachToUpdate.isEmpty()) {
            insert listAttachToUpdate;
            system.debug('@@@@@@@@@@@@@@EC abbiamo inserito la lista di attach, che ora è ' + listAttachToUpdate);
        }
        if ((listVLANToUpdate != null) && !listVLANToUpdate.isEmpty()) {
            update listVLANToUpdate;
        }
        //Inserisco le vlan
        if ((nephewVLAN != null) && !nephewVLAN.isEmpty()) {
            insert nephewVLAN;
        }
        //Update per gestire i nuovi stati
        update P2PAttivaLogList;
        return null;
    }
    
    //EC 2019 05 15 end commenti e nuovo metodo
    //EC 2019 05 15 ORE 18:34 
    //Nuovo metodo sostituito il vecchio metodo richiamato nella page a riga 644! (quello precedente da verificare se venga effettivamente richiamato da qualche parte!)
    //Nuovi controlli da aggiungere
    /*Nuovi controlli.
ii.	Nuovo check Profilo: non potrà essere inviata una richiesta se non è stato scelto un Profilo per anche solo un Collegamento. 
iii.	Nuovo check KIT: non potrà essere inviata una richiesta se esiste almeno un Collegamento per il quale non è stato selezionato un KIT.


*/
    
    //EC 2019 05 20 start
    /*EC 2019 05 30 start commento metodo riscritto senza fare 2 query

public String checkProfiloKitCollegamento(id slFattibilitaId){
system.debug('@@@@@EC nel metodo checkProfiloKitCollegamento1 -> slFattibilitaId: ' + slFattibilitaId);	
//Id slFattibilitaIdL= slFattibilitaId;
String errString= null;
boolean profiloOK;
Map<Id,List<Id>> fattCollIdList = new Map<Id,List<Id>>();
List<Id> collIdList = new List<Id>();
List<Id> kitList = new List<Id>();
Map<Id,Id> collVlanIdMap = new Map<Id,Id>();
//il profilo è diventato la vlan
//kit ha look up vs fattibilità
//check esiste un kit legato alla fattibilità?
//Check ogni collegamento ha almeno una vlan? 
//sotto i collegamenti c'è vlan è legata lla vlan
for(EOF_EAI_Service_Log__c slLoc:[select id, EOF_SL_Riferimento__c, PO_Offerta__c, EOF_Codice_Operatore__c, PO_Nome_Progetto__c,
EOF_Codice_Ordine_OLO__c, EOF_Comune__c, OF_Id_Comune__c,
PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, PO_Tipo_percorso__c,
PO_Numero_fibre_richieste__c, PO_Sito__c, PO_Indirizzo_collegamento__c,
PO_Civico__c, PO_Nota_sito__c, OF_SA_KIT_CONSEGNA_VLAN__c,
EOF_PROFILO__c, PO_P2PAttiva_Opzione__c, COS5_PIR__c, COS5_CIR__c,
COS3_PIR__c, COS3_CIR__c, COS1_PIR__c, COS1_CIR__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
PO_PP_User_VLAN__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c,
PO_PP_cos_class__c, PO_P2PAttiva_Kit_Consegna_VLan__c ,Recordtype.developerName
from EOF_EAI_Service_Log__c
where EOF_SL_Riferimento__c =: slFattibilitaId
and Recordtype.developerName IN ('P2P_Attiva_Collegamento','PO_Log_P2P_Attiva_KIT')]){
if('PO_Log_P2P_Attiva_KIT'.equals(slLoc.Recordtype.DeveloperName)){

kitList.add(slLoc.id);
}
else if('P2P_Attiva_Collegamento'.equals(slLoc.Recordtype.DeveloperName)){

collIdList.add(slLoc.id);
}
}
for(EOF_EAI_Service_Log__c slVlan: [select id, EOF_Codice_Ordine_OLO__c, RecordtypeId, Recordtype.DeveloperName,
COS1_CIR__c,COS1_PIR__c,COS3_CIR__c,COS3_PIR__c,COS5_CIR__c,COS5_PIR__c,
PO_PP_cos_class__c,PO_PP_cos_remarking__c,PO_PP_dhcp_Option82__c,
PO_P2PAttiva_Kit_Consegna_VLan__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
PO_P2PAttiva_Opzione__c,EOF_PROFILO__c,PO_PP_User_VLAN__c,
PO_PP_ID_VLAN__c,PO_PP_ID_RichiestaVLAN__c,OF_PP_KIT_Log__c,OF_SA_VLan_Log__c, EOF_SL_Riferimento__c 
from EOF_EAI_Service_Log__c 
where EOF_SL_Riferimento__c IN: collIdList 
and Recordtype.developerName ='OF_SA_Vlan']){
collVlanIdMap.put(slVlan.EOF_SL_Riferimento__c, slVlan.id);			
}
collVlanIdMap.remove(null);

List<Id> keySCollVlanIdMap =   new List<Id>();
keySCollVlanIdMap.addAll(collVlanIdMap.keySet());
keySCollVlanIdMap.sort();
collIdList.sort();
if(!keySCollVlanIdMap.equals(collIdList)){
errString='Non è possibile inviare una richiesta se anche solo per un Collegamento non è stato selezionato un Profilo.'; //Selezionarlo per ' + slLoc.EOF_Codice_Ordine_OLO__c + '. ';
if(kitList.isEmpty()){
system.debug('@@@EC check kitconsegna vlan. 1 errString  ' + errString);
errString+=' Bisogna inoltre selezionare un KIT!';
system.debug('@@@EC check kitconsegna vlan. 2 errString ' + errString);
//return errString;
}
system.debug('@@@EC check kitconsegna vlan. 3 errString ' + errString);
return errString;
}
EC 2019 05 30 end commento metodo riscritto senza fare 2 query */
    /*if(collVlanIdMap.keySet().size() < collIdList.size()){
errString='Non è possibile inviare una richiesta se anche solo per un Collegamento non è stato selezionato un Profilo.'; /*Selezionarlo per ' + slLoc.EOF_Codice_Ordine_OLO__c + '. ';*/
    /*	if(kitList.isEmpty()){
system.debug('@@@EC check kitconsegna vlan. 1 errString  ' + errString);
errString+=' Bisogna inoltre selezionare un KIT!';
system.debug('@@@EC check kitconsegna vlan. 2 errString ' + errString);
//return errString;
}
system.debug('@@@EC check kitconsegna vlan. 3 errString ' + errString);
return errString;
}*/
    /*EC 2019 05 30 start commento metodo riscritto senza fare 2 query
else if(kitList.isEmpty()){
errString='Non è possibile inviare una richiesta se non è stato selezionato un KIT!';
system.debug('@@@EC check kitconsegna vlan. errString ' + errString);
return errString;
}

errString= null;
system.debug('@@@@EC la lista di vlan non ha una dimensione minore di quella dei collegamenti ed esiste almeno un kit legato alla fattibilità, infatti errString è ' + errString);												
return errString;


}

*/
    
    /*
public String checkProfiloKitCollegamento(id slFattibilitaId){
system.debug('@@@@@EC nel metodo checkProfiloKitCollegamento1 -> slFattibilitaId: ' + slFattibilitaId);	
//Id slFattibilitaIdL= slFattibilitaId;
String errString= null;
boolean profiloOK;
Map<Id,List<Id>> fattCollIdList = new Map<Id,List<Id>>();
List<Id> collIdList = new List<Id>();
List<Id> kitList = new List<Id>();
Map<Id,Id> collVlanIdMap = new Map<Id,Id>();
//il profilo è diventato la vlan
//kit ha look up vs fattibilità
//check esiste un kit legato alla fattibilità?
//Check ogni collegamento ha almeno una vlan? 
//sotto i collegamenti c'è vlan è legata lla vlan
for(EOF_EAI_Service_Log__c slLoc:[select id, EOF_SL_Riferimento__c, PO_Offerta__c, EOF_Codice_Operatore__c, PO_Nome_Progetto__c,
EOF_Codice_Ordine_OLO__c, EOF_Comune__c, OF_Id_Comune__c,
PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, PO_Tipo_percorso__c,
PO_Numero_fibre_richieste__c, PO_Sito__c, PO_Indirizzo_collegamento__c,
PO_Civico__c, PO_Nota_sito__c, OF_SA_KIT_CONSEGNA_VLAN__c,
EOF_PROFILO__c, PO_P2PAttiva_Opzione__c, COS5_PIR__c, COS5_CIR__c,
COS3_PIR__c, COS3_CIR__c, COS1_PIR__c, COS1_CIR__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
PO_PP_User_VLAN__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c,
PO_PP_cos_class__c, PO_P2PAttiva_Kit_Consegna_VLan__c ,Recordtype.developerName
from EOF_EAI_Service_Log__c
where EOF_SL_Riferimento__c =: slFattibilitaId
and Recordtype.developerName IN ('P2P_Attiva_Collegamento','PO_Log_P2P_Attiva_KIT')]){
if('PO_Log_P2P_Attiva_KIT'.equals(slLoc.Recordtype.DeveloperName)){

kitList.add(slLoc.id);
}
else if('P2P_Attiva_Collegamento'.equals(slLoc.Recordtype.DeveloperName)){

collIdList.add(slLoc.id);
}
}
for(EOF_EAI_Service_Log__c slVlan: [select id, EOF_Codice_Ordine_OLO__c, RecordtypeId, Recordtype.DeveloperName,
COS1_CIR__c,COS1_PIR__c,COS3_CIR__c,COS3_PIR__c,COS5_CIR__c,COS5_PIR__c,
PO_PP_cos_class__c,PO_PP_cos_remarking__c,PO_PP_dhcp_Option82__c,
PO_P2PAttiva_Kit_Consegna_VLan__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
PO_P2PAttiva_Opzione__c,EOF_PROFILO__c,PO_PP_User_VLAN__c,
PO_PP_ID_VLAN__c,PO_PP_ID_RichiestaVLAN__c,OF_PP_KIT_Log__c,OF_SA_VLan_Log__c, EOF_SL_Riferimento__c 
from EOF_EAI_Service_Log__c 
where EOF_SL_Riferimento__c IN: collIdList 
and Recordtype.developerName ='OF_SA_Vlan']){
collVlanIdMap.put(slVlan.EOF_SL_Riferimento__c, slVlan.id);			
}
collVlanIdMap.remove(null);

List<Id> keySCollVlanIdMap =   new List<Id>();
keySCollVlanIdMap.addAll(collVlanIdMap.keySet());
keySCollVlanIdMap.sort();
collIdList.sort();
if(!keySCollVlanIdMap.equals(collIdList)){
errString='Non è possibile inviare una richiesta se anche solo per un Collegamento non è stato selezionato un Profilo.' //Selezionarlo per ' + slLoc.EOF_Codice_Ordine_OLO__c + '. '/;
if(kitList.isEmpty()){
system.debug('@@@EC check kitconsegna vlan. 1 errString  ' + errString);
errString+=' Bisogna inoltre selezionare un KIT!';
system.debug('@@@EC check kitconsegna vlan. 2 errString ' + errString);
//return errString;
}
system.debug('@@@EC check kitconsegna vlan. 3 errString ' + errString);
return errString;
}

else if(kitList.isEmpty()){
errString='Non è possibile inviare una richiesta se non è stato selezionato un KIT!';
system.debug('@@@EC check kitconsegna vlan. errString ' + errString);
return errString;
}

errString= null;
system.debug('@@@@EC la lista di vlan non ha una dimensione minore di quella dei collegamenti ed esiste almeno un kit legato alla fattibilità, infatti errString è ' + errString);												
return errString;


}
*/
    
    //EC 2019 05 20 end 
    
    //EC 2019 05 15 metodo che ritorni una stringa che riporti un messaggio di errore in caso di collegamento senza profilo o kit indicato.
    /*
public String checkProfiloKitCollegamento(id slFattibilitaId){
system.debug('@@@@@EC nel metodo checkProfiloKitCollegamento1 -> slFattibilitaId: ' + slFattibilitaId);	
//Id slFattibilitaIdL= slFattibilitaId;
String errString= null;
for(EOF_EAI_Service_Log__c slLoc:[select id, EOF_SL_Riferimento__c, PO_Offerta__c, EOF_Codice_Operatore__c, PO_Nome_Progetto__c, 
EOF_Codice_Ordine_OLO__c, EOF_Comune__c, OF_Id_Comune__c,
PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, PO_Tipo_percorso__c, 
PO_Numero_fibre_richieste__c, PO_Sito__c, PO_Indirizzo_collegamento__c, 
PO_Civico__c, PO_Nota_sito__c, EOF_PROFILO__c, OF_SA_KIT_CONSEGNA_VLAN__c 
from EOF_EAI_Service_Log__c 
where EOF_SL_Riferimento__c =: slFattibilitaId
and Recordtype.developerName='P2P_Attiva_Collegamento']){

if(String.isBlank(slLoc.EOF_PROFILO__c)){
errString='Non è possibile inviare una richiesta se anche solo per un Collegamento non è stato selezionato un Profilo.'; /*Selezionarlo per ' + slLoc.EOF_Codice_Ordine_OLO__c + '. ';*/
    /*								if(String.isBlank(slLoc.OF_SA_KIT_CONSEGNA_VLAN__c)){
errString+=' Per lo stesso Collegamento si deve inoltre selezionare anche un Kit';
}
system.debug('@@@EC check profilo e kitconsegna vlan. errString ' + errString);
return errString;
}
else if(String.isBlank(slLoc.OF_SA_KIT_CONSEGNA_VLAN__c)){
errString='Non è possibile inviare una richiesta se anche solo per un Collegamento non è stato selezionato un KIT!';
system.debug('@@@EC check kitconsegna vlan. errString ' + errString);
return errString;
}
}				

errString= null;
system.debug('@@@@EC la lista di collegamenti senza profilo o kit consegna non ha alcun elemento, infatti errString è ' + errString);												
return errString;

}
*/
    //EC 2019 05 15 end metodo per errore in caso di collegamento senza profilo indicato.
    
    /*EC start 2019 05 30 
//il profilo è diventato la vlan
//kit ha look up vs fattibilità
//check esiste un kit legato alla fattibilità?
//Check ogni collegamento ha almeno una vlan? 
//sotto i collegamenti c'è vlan è legata lla vlan

//PO_P2PAttiva_Kit_Consegna_VLan__c dovrebbe venire popolato con il nome del kit anche del kit in condivisione, 
se quindi è blank vuol dire che non c'è il kit
//Tutte le vlan devono puntare al kit.
*/
    public Set<Id> addElineColl(List<EOF_EAI_Service_Log__c> P2PAttivaLogList){
        Set<Id> collIdMap = new Set<Id>();
        for(Integer i = 0 ; i < P2PAttivaLogList.size();i++){
            if(P2PAttivaLogList[i].Tipologia_Sede__c =='Satellite'){
                collIdMap.add(P2PAttivaLogList[i].id);
            }
        }
        return collIdMap;
    }
    
    
    
    public String checkProfiloKitCollegamento(){
        system.debug('@@@@@EC nel metodo checkProfiloKitCollegamento1 ');	
        String errString= null;
        Set<Id> kitList = new Set<Id>();
        Set<Id> idLogCollSet = (new Map<Id,EOF_EAI_Service_Log__c>(P2PAttivaLogList)).keySet();
        Set<Id> idLogCollSet_ELine =addElineColl(P2PAttivaLogList);
        
        system.debug('@@@@EC nel metodo checkProfiloKitCollegamento2 idLogCollSet.size(): ' + idLogCollSet.size());
        Map<Id,Id> collVlanIdMap = new Map<Id,Id>();
        if(tipoP2PAttiva!='eLine'){	
            for(EOF_EAI_Service_Log__c slVlan: [select id, EOF_Codice_Ordine_OLO__c, RecordtypeId, Recordtype.DeveloperName,
                                                COS1_CIR__c,COS1_PIR__c,COS3_CIR__c,COS3_PIR__c,COS5_CIR__c,COS5_PIR__c,
                                                PO_PP_cos_class__c,PO_PP_cos_remarking__c,PO_PP_dhcp_Option82__c,
                                                PO_P2PAttiva_Kit_Consegna_VLan__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
                                                PO_P2PAttiva_Opzione__c,EOF_PROFILO__c,PO_PP_User_VLAN__c,
                                                PO_PP_ID_VLAN__c,PO_PP_ID_RichiestaVLAN__c,OF_PP_KIT_Log__c,OF_SA_VLan_Log__c, EOF_SL_Riferimento__c 
                                                from EOF_EAI_Service_Log__c 
                                                where EOF_SL_Riferimento__c IN: idLogCollSet 
                                                and Recordtype.developerName ='OF_SA_Vlan']){
                                                    if(String.isBlank(slVlan.PO_P2PAttiva_Kit_Consegna_VLan__c)){
                                                        errString='Non è possibile inviare una richiesta se non è stato selezionato un KIT!';
                                                        system.debug('@@@EC check kitconsegna vlan. errString ' + errString);
                                                        return errString;
                                                    }
                                                    //kitList.add(slVlan.PO_P2PAttiva_Kit_Consegna_VLan__c);
                                                    collVlanIdMap.put(slVlan.EOF_SL_Riferimento__c, slVlan.id);			
                                                }
        }else{
            for(EOF_EAI_Service_Log__c slVlan: [select id, EOF_Codice_Ordine_OLO__c, RecordtypeId, Recordtype.DeveloperName,
                                                COS1_CIR__c,COS1_PIR__c,COS3_CIR__c,COS3_PIR__c,COS5_CIR__c,COS5_PIR__c,
                                                PO_PP_cos_class__c,PO_PP_cos_remarking__c,PO_PP_dhcp_Option82__c,
                                                PO_P2PAttiva_Kit_Consegna_VLan__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
                                                PO_P2PAttiva_Opzione__c,EOF_PROFILO__c,PO_PP_User_VLAN__c,
                                                PO_PP_ID_VLAN__c,PO_PP_ID_RichiestaVLAN__c,OF_PP_KIT_Log__c,OF_SA_VLan_Log__c, EOF_SL_Riferimento__c 
                                                from EOF_EAI_Service_Log__c 
                                                where EOF_SL_Riferimento__c IN: idLogCollSet 
                                                and Recordtype.developerName ='OF_SA_Vlan_ELine']){
                                                    /*if(String.isBlank(slVlan.PO_P2PAttiva_Kit_Consegna_VLan__c)){
errString='Non è possibile inviare una richiesta se non è stato selezionato un KIT!';
system.debug('@@@EC check kitconsegna vlan. errString ' + errString);
return errString;
}*/
                                                    //kitList.add(slVlan.PO_P2PAttiva_Kit_Consegna_VLan__c);
                                                    collVlanIdMap.put(slVlan.EOF_SL_Riferimento__c, slVlan.id);			
                                                }
        }
        collVlanIdMap.remove(null);
        
        Set<Id> keySCollVlanIdMap =   new Set<Id>();
        keySCollVlanIdMap.addAll(collVlanIdMap.keySet());
        system.debug('@@@@@@EC keySCollVlanIdMap è un set di id la size() è: ' + keySCollVlanIdMap.size());
        /*  keySCollVlanIdMap.sort();
idLogCollSet.sort();
if(!keySCollVlanIdMap.equals(idLogCollSet)){*/
        if(tipoP2PAttiva =='eLine'){
            if(!(keySCollVlanIdMap.containsAll(idLogCollSet_ELine) && idLogCollSet_ELine.containsAll(keySCollVlanIdMap))){
                errString='Per almeno uno dei Collegamenti non è stato selezionato un Profilo' /*Selezionarlo per ' + slLoc.EOF_Codice_Ordine_OLO__c + '. '*/;
                system.debug('@@@EC check kitconsegna vlan. 3 errString ' + errString);
                return errString;
            }
            
        }else{
            if(!(keySCollVlanIdMap.containsAll(idLogCollSet) && idLogCollSet.containsAll(keySCollVlanIdMap))){
                errString='Non è possibile inviare una richiesta se anche solo per un Collegamento non è stato selezionato un Profilo.' /*Selezionarlo per ' + slLoc.EOF_Codice_Ordine_OLO__c + '. '*/;
                system.debug('@@@EC check kitconsegna vlan. 3 errString ' + errString);
                return errString;
            }
        }
        errString= null;
        system.debug('@@@@EC la lista di vlan non ha una dimensione minore di quella dei collegamenti ed esiste almeno un kit legato alla fattibilità, infatti errString è ' + errString);												
        return errString;
    }
    
    public pagereference InviaRichiesta_2() {
        String erroreVendibilita = checkVendibilitaRichiesta(accId, parentLogObj.PO_Offerta__c);
        //  set<Id> idLogCollSet = (new Map<Id,EOF_EAI_Service_Log__c>(P2PAttivaLogList)).keySet();
        /*
List<SObject> results = Database.query(someSOQL);
Set<Id> resultIds = (new Map<Id,SObject>(results)).keySet();
*/
        // idLogCollSet.addAll(P2PAttivaLogList[].id);
        string erroreCheckProfilo =  checkProfiloKitCollegamento();
        // string erroreCheckProfilo =  checkProfiloKitCollegamento(parentLogObj.id);
        
        
        
        if (erroreVendibilita != null)
        {
            system.debug('giovanni risultato errore: ' + erroreVendibilita);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, erroreVendibilita));
            return null;
        }
        
        if(erroreCheckProfilo!=null){
            system.debug('errore: ' + erroreCheckProfilo);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, erroreCheckProfilo));
            return null;
            
        }
        
        Map<String,String> ownerMap = new Map<String,String>();
        for (group g:[select id,developername from Group]) {
            ownerMap.put(g.developername,g.Id);
        }
        Contract contratto = getContratto(accId, parentLogObj.PO_Offerta__c);
        //Case per richiesta fattibilità
        Case parentCase = new Case();
        parentCase.RecordTypeId = rtMap.get('PO_Richiesta_a_servizio_a_fattibilit');
        parentCase.Status = 'Acquisito';
        parentCase.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
        parentCase.accountId = accId;
        parentCase.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit');
        parentCase.PO_Offerta__c = parentLogObj.PO_Offerta__c;
        parentCase.EOF_Codice_Operatore_WS__c = parentLogObj.EOF_Codice_Operatore__c;
        parentCase.PO_Nome_Progetto__c = parentLogObj.PO_Nome_Progetto__c;
        parentCase.Subject = parentLogObj.EOF_Tipo_Comunicazione_String__c;
        parentCase.EOF_Codice_Ordine_OLO__c = parentLogObj.EOF_Codice_Ordine_OLO__c;
        parentCase.PO_P2P_Attiva__c = true;
        parentCase.PO_SA_Portale__c = true;//EC 2018 - 08 - 08
        if (contratto != null) {
            parentLogObj.PO_Accordo_Quadro_Number__c = contratto.OF_IdContratto__c;
            // RDG 2019-02-08
            parentCase.OF_IDContratto__c = contratto.Id;
            parentCase.PO_Accordo_Quadro__c = contratto.Id;
        }
        insert parentCase;
        
        List<EOF_EAI_Service_Log__c> logToUpdate = new List<EOF_EAI_Service_Log__c>();
        //Dopo aver popolato il parent case, aggiorno anche il parent log
        parentLogObj.EOF_Stato_Richiesta__c = 'Inserita Portale';
        parentLogObj.EOF_STATO_ORDINE__c = 'Acquisito';
        parentLogObj.Caso__c = parentCase.Id;
        
        logToUpdate.add(parentLogObj);
        
        //inserisco i collegamenti come case e mi faccio una mappa di id del log e case per riassociarli dopo l'inserimento
        List<Case> listaCaseCollegamentoToInsert = new List<Case>();
        map<String,case> map_IdLog_Case = new map<String,case>();
        Set<Id> childLogsCollegamentoId = new Set<Id>();
        //mi faccio una mappa id del kit del log  nuovo (se presente) e case collegamento cosi dopo l'inserimento posso associarli
        map<String,Case> mapKitLogCaseCollegamento = new map<String,Case>();
        Map<String,String> MapLogCollLogKIT = new Map<String,String>();
        
        // DN - per cercare sede master se non presente sotto la richiesta
        Id sLogIdMaster = null;
        // DN - per associare case collegamento a case kit (in condivisione)
        // ci stanno solo i collegamenti con kit in condivsione
        Map<EOF_EAI_Service_Log__c, Case> map_logColleg_caseColleg = new Map<EOF_EAI_Service_Log__c, Case>();
        for (EOF_EAI_Service_Log__c childLog: P2PAttivaLogList) {
            system.debug('@@@@EC nel for childLog.PO_Tipo_di_collegamento__c: ' + childLog.PO_Tipo_di_collegamento__c);
            Case caseCollegamento = new Case();
            if(tipoP2PAttiva=='eLine'){
                caseCollegamento.RecordTypeId = rtMap.get('PO_Collegamento_P2P_Attiva_ELine');
                caseCollegamento.Tipologia_Sede__c= childLog.Tipologia_Sede__c;
                if(SEDE_SATELLITE.equals(childLog.tipologia_sede__c)) {
                    sLogIdMaster = childLog.id_sede_master__c;
                }
                
            }else if(tipoP2PAttiva=='eAccess'){
                caseCollegamento.RecordTypeId = rtMap.get('PO_Collegamento_P2P_Attiva');
            }
            caseCollegamento.Status = 'Acquisito';
            caseCollegamento.EOF_Fase__c = 'NA';
            caseCollegamento.accountId = accId;
            caseCollegamento.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit');
            caseCollegamento.PO_Offerta__c = childLog.PO_Offerta__c;
            caseCollegamento.EOF_Codice_Operatore_WS__c = childLog.EOF_Codice_Operatore__c;
            caseCollegamento.PO_Nome_Progetto__c = childLog.PO_Nome_Progetto__c;
            caseCollegamento.EOF_Codice_Ordine_OLO__c = childLog.EOF_Codice_Ordine_OLO__c;
            caseCollegamento.ParentId = parentCase.Id;
            // RDG 2019-02-08
            caseCollegamento.OF_IDContratto__c = parentCase.OF_IDContratto__c;
            caseCollegamento.PO_Comune__c = childLog.EOF_Comune__c;
            caseCollegamento.PO_Comune2__c = childLog.OF_Id_Comune__c;
            caseCollegamento.PO_Tipo_di_collegamento__c = childLog.PO_Tipo_di_collegamento__c;
            caseCollegamento.PO_Prime_Contractor__c = childLog.PO_Prime_Contractor__c;
            caseCollegamento.PO_Tipo_percorso__c = childLog.PO_Tipo_percorso__c;
            caseCollegamento.PO_Numero_fibre_richieste__c = childLog.PO_Numero_fibre_richieste__c;
            caseCollegamento.OF_SA_Profilo__c = childLog.EOF_PROFILO__c;
            caseCollegamento.PO_Sito__c = childLog.PO_Sito__c;
            caseCollegamento.PO_Indirizzo_collegamento__c = childLog.PO_Indirizzo_collegamento__c;
            caseCollegamento.PO_Civico__c = childLog.PO_Civico__c;
            caseCollegamento.PO_Nota_sito__c = childLog.PO_Nota_sito__c;
            caseCollegamento.PO_Richiesta_a_fattibilit__c = parentCase.Id;
            caseCollegamento.PO_P2P_Attiva__c = true;
            caseCollegamento.PO_Indirizzo_collegamento__c = childLog.PO_Indirizzo_collegamento__c;
            caseCollegamento.SF_Ccoll_ID_Sede__c= childLog.ID_Sede__c; //EC 2019 06 06 popolamento campo ID Sede su CaseCollegamento
            caseCollegamento.Traffic_Load_Balancing__c = childLog.TrafficLoadBalancing__c;
            caseCollegamento.PO_P2PAttiva_KIT_OpticalRateLimiting__c  = childLog.PO_P2PAttiva_Optical_Rate_Limiting__c;
            if (childLog.PO_Tipo_percorso__c == 'Singola Via')
                caseCollegamento.Traffic_Load_Balancing__c='';
            
            //LM campi CPE
            caseCollegamento.Tipologia_CPE__c = childLog.Tipologia_CPE__c;
            caseCollegamento.Tipologia_Alimentazione__c  = childLog.Tipologia_Alimentazione__c;
            caseCollegamento.Interfaccia_CPE__c = childLog.Interfaccia_CPE__c;
            //LM campi CPE end
            //DN campi e-line
            // tipologia sede
            // id_sede_master
            //  caseCollegamento.Tipologia_Sede__c = childLog.Tipologia_Sede__c; EC 2019 06 17 Tipologia sede valida per E-Line
            
            caseCollegamento.Service_attribute__c = childLog.Service_attribute__c;
            
            listaCaseCollegamentoToInsert.add(caseCollegamento);
            map_IdLog_Case.put(childLog.id,caseCollegamento);
            childLogsCollegamentoId.add(childLog.id);
            //system.debug('@@@@ childLog.OF_PP_KIT_Log__c: '+childLog.OF_PP_KIT_Log__c);
            //controllo se sono legate a kit da creare cosi poi mi prendo il case da agganciarci successivamente
            if (!String.isBlank(childLog.OF_PP_KIT_Log__c)) {
                mapKitLogCaseCollegamento.put(childLog.OF_PP_KIT_Log__c,caseCollegamento);
                MapLogCollLogKIT.put(childLog.id,childLog.OF_PP_KIT_Log__c);
            }
            
            // DN 
            if(childLog.kit_in_condivisione__c != null) {
                map_logColleg_caseColleg.put(childLog, caseCollegamento);
            }
        }
        //system.debug('@@@@ mapKitLogCaseCollegamento: '+mapKitLogCaseCollegamento);
        insert listaCaseCollegamentoToInsert;
        
        // DN        
        if(tipoP2PAttiva=='eLine') {
            updateSatellites(listaCaseCollegamentoToInsert, sLogIdMaster);
        }
        
        //mi faccio una mappa id del kit log nuovo (se presente) e case KIT cosi dopo l'inserimento posso associarli
        map<String,Case> mapKitLogCaseKIT = new map<String,Case>();
        List<Case> listaCaseKITToInsert = new List<Case>();
        
        for (EOF_EAI_Service_Log__c kitLog:ListKitToSend) {
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
            // DN
            caseKIT.service_attribute__c = kitLog.service_attribute__c;
            caseKIT.EOF_Codice_Ordine_OLO__c = kitLog.EOF_Codice_Operatore__c + kitLog.Name.replace('LOG-', '_');
            listaCaseKITToInsert.add(caseKIT);
            mapKitLogCaseKIT.put(kitLog.Id,caseKIT);
        }
        insert listaCaseKITToInsert;
        //system.debug('@@@@@@ listaCaseKITToInsert: '+listaCaseKITToInsert);
        //rifaccio il ciclo per legarci il case
        for (EOF_EAI_Service_Log__c kitLog:ListKitToSend) {
            kitLog.Caso__c=mapKitLogCaseKIT.get(kitLog.Id).Id;
            kitLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
            kitLog.EOF_STATO_ORDINE__c = 'Acquisito';
            logToUpdate.add(kitLog);
        }
        
        // DN
        if(!map_logColleg_caseColleg.isEmpty()) {
            updateKitInCondivisione(map_logColleg_caseColleg, mapKitLogCaseKIT);
        }        
        
        //rifaccio il ciclo sui collegamenti per legarci i kit
        //system.debug('@@@@ Ale mapKitLogCaseKIT: '+mapKitLogCaseKIT);
        //system.debug('@@@@ Ale MapLogCollLogKIT: '+MapLogCollLogKIT);
        IF(!MapLogCollLogKIT.isEmpty()) {
            List<Case> CaseCollToUpdate = new List<Case>();
            for (String LOgCollId:MapLogCollLogKIT.keyset()) {
                Case collegamento= map_IdLog_Case.get(LOgCollId);
                //system.debug('@@@@ Ale collegamento: '+collegamento);
                String id = mapKitLogCaseKIT.get(MapLogCollLogKIT.get(LOgCollId)).Id;
                collegamento.PO_KIT_Consegna_VLAN__c=mapKitLogCaseKIT.get(MapLogCollLogKIT.get(LOgCollId)).Id;
                CaseCollToUpdate.add(collegamento);
            }
            update CaseCollToUpdate;
        }
        
        //mi tiro fuori gli allegati per legarli ai nuovi case
        Map<Id, List<Attachment>> mapParentIdListAttach = getChildLogAttachment(childLogsCollegamentoId);
        List<Attachment> attachmentToUpdate = new List<Attachment>();
        //mi tiro fuori le vlan per creare i CEI e legarli ai nuovi case
        System.debug('@@childLogsCollegamentoId'+childLogsCollegamentoId);
        Map<Id, List<EOF_EAI_Service_Log__c>> mapSLRifLog = getVLANLog(childLogsCollegamentoId);
        //EC 2019 05 15
        List<EOF_VLAN__c> ListVlanObjToInsert = new List<EOF_VLAN__c>();
        //EC commentiamo! List<OF_CommercialElementIstanziato__c> ListCEIToInsert = new List<OF_CommercialElementIstanziato__c>();
        
        /* EC start commenti 2019 05 15
Id vlanCEId = [SELECT Id
FROM OF_CommercialElement__c
WHERE OF_Servizio__r.Name='Open Stream'
AND Name='VLAN' LIMIT 1].Id;
EC end commenti 2019 05 15	*/
        System.debug('@@P2PAttivaLogList'+P2PAttivaLogList);
        for (EOF_EAI_Service_Log__c childLog : P2PAttivaLogList) {
            childLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
            childLog.EOF_STATO_ORDINE__c = 'Acquisito';
            childLog.Caso__c = map_IdLog_Case.get(childLog.Id).Id;
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
            if ((mapParentIdListAttach.get(childlog.id) != null) && !mapParentIdListAttach.get(childlog.id).isEmpty()) {
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
            System.debug('@@here vlan OBJ');
            
            List<EOF_EAI_Service_Log__c> vlanLogList = mapSLRifLog.get(childLog.Id);
            System.debug('@@@@11entro insert VLAN');
            if (vlanLogList != null) {
                for (EOF_EAI_Service_Log__c vlanLog : vlanLogList) {
                    System.debug('@@@entro insert VLAN');
                    //EC 2019 05 15 - VLAN che verranno aggiunti alla lista da inserire.
                    EOF_VLAN__c vlanObj = new EOF_VLAN__c();
                    
                    vlanObj.Caso__c =  map_IdLog_Case.get(childLog.Id).Id;
                    if(vlanLog.RecordTypeId == rtMap.get('OF_SA_Vlan_ELine')){
                        vlanObj.RecordTypeId = rtMap.get('OF_VLAN_ELine');
                        System.debug('@@OF_VLAN_ELine'+vlanLog.RecordTypeId);
                    }
                    else if(childLog.RecordTypeId == rtMap.get('OF_SA_Vlan')){
                        vlanObj.RecordTypeId = rtMap.get('OF_VLAN_EAccess');
                        System.debug('@@OF_VLAN_EAccess'+vlanLog.RecordTypeId);
                    }
                    vlanObj.PO_COS1_CIR__c = Decimal.valueOf(setNullToZ(vlanLog.COS1_CIR__c));
                    vlanObj.PO_COS1_PIR__c = Decimal.valueOf(setNullToZ(vlanLog.COS1_PIR__c));
                    vlanObj.PO_COS3_CIR__c = Decimal.valueOf(setNullToZ(vlanLog.COS3_CIR__c));
                    vlanObj.PO_COS3_PIR__c = Decimal.valueOf(setNullToZ(vlanLog.COS3_PIR__c));
                    vlanObj.PO_COS5_CIR__c = Decimal.valueOf(setNullToZ(vlanLog.COS5_CIR__c));
                    vlanObj.PO_COS5_PIR__c = Decimal.valueOf(setNullToZ(vlanLog.COS5_PIR__c));
                    vlanObj.PO_COS_Class__c = vlanLog.PO_PP_cos_class__c;//TBD
                    vlanObj.PO_COS_Remarking__c = vlanLog.PO_PP_cos_remarking__c;//TBD
                    vlanObj.PO_DHCP_Option82__c = vlanLog.PO_PP_dhcp_Option82__c;//TBD
                    vlanObj.PO_KIT_di_consegna_VLAN__c = vlanLog.PO_P2PAttiva_Kit_Consegna_VLan__c; // vlanLog.OF_SA_KIT_CONSEGNA_VLAN__c; // sLog.OF_SA_KIT_CONSEGNA_VLAN__c;
                    vlanObj.PO_Modello_di_Servizio__c = vlanLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c; //sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c; 
                    vlanObj.PO_Opzione__c = vlanLog.PO_P2PAttiva_Opzione__c;//'Standard';
                    vlanObj.PO_Profilo__c =vlanLog.OF_SA_PROFILO_VLAN__c;  //'3Play';//??sLog.EOF_PROFILO__c; //OF_SA_PROFILO_VLAN_PL__c ??? //OF_SA_PROFILO_VLAN__c
                    vlanObj.PO_SVLAN_Traslation__c = 'TBD' ; //OF_SA_INFORMAZIONI_VLAN__c forse serviceVLAN??? cei.OF_SERVICEVLAN__C = sLog.OF_SA_SERVICE_VLAN__C;
                    //vlanObj.PO_User_VLAN__c = Decimal.valueOf(vlanLog.PO_PP_User_VLAN__c); //vlanLog.OF_SA_USER_VLAN__C; //EC 2019 05 15 Il campo non sarà popolato per le VLAN di P2P Attiva
                    //e non sarà inviato alcun valore al DOM (campo opz dell’interfaccia)
                    
                    ListVlanObjToInsert.add(vlanObj);
                    /*
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
*/
                    
                    vlanLog.Caso__c = map_IdLog_Case.get(childLog.Id).Id;
                    logToUpdate.add(vlanLog);
                    
                    
                }
            }
        }
        
        if (!attachmentToUpdate.isEmpty()) {
            update attachmentToUpdate;
            if (!attToInsert.isEmpty()) {
                insert attToInsert;
            }
            if (!attToDelete.isEmpty()) {//EC start 2018 - 11 - 12
                //	delete attToDelete;
            }//EC end 2018 - 11 - 12
        }
        insert ListVlanObjToInsert;
        System.debug('@@ListVlanObjToInsert'+ListVlanObjToInsert);
        //insert ListCEIToInsert;
        if (!slListToDelete.isEmpty()) {
            delete slListToDelete;
        }
        update logToUpdate;
        pagereference pg = new pagereference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('parentId', parentLogObj.Id);
        pg.getParameters().put('tipoP2Patt', tipoP2PAttiva);
        pg.setRedirect(true);
        return pg;
    }
    
    // DN
    @testVisible
    private void updateKitInCondivisione(Map<EOF_EAI_Service_Log__c, Case> map_logColleg_caseColleg, 
        Map<String, Case> map_idLogKit_caseKit) {
            
        System.debug('##### updateKitInCondivisione: keyset 1st param / keyset 2nd param: '+ 
                    map_logColleg_caseColleg.keySet() + ' / ' +  map_idLogKit_caseKit.keySet());
        List<Case> toUpdate = new List<Case>();
        for(EOF_EAI_Service_Log__c log : map_logColleg_caseColleg.keySet()) {
            Id sharedKitLog = log.kit_in_condivisione__c;
            Case kit = map_idLogKit_caseKit.get(sharedKitLog);
            if(kit != null) {
                System.debug('##### kit in condivisione sotto stessa richiesta: ' + kit.Id);
                Case colleg = map_logColleg_caseColleg.get(log);
                colleg.kit_in_condivisione__c = kit.Id;
                toUpdate.add(colleg);
                map_logColleg_caseColleg.remove(log);
            }
        }
        
        // se la mappa è vuota non ci sono più collegamenti da aggiornare 
        // (i kit in condivisione non sono esterni alla richiesta)
        if(map_logColleg_caseColleg.isEmpty()) {
            update toUpdate;
        } else {
            List<Id> sharedKitLogs = new List<Id>();
            for(EOF_EAI_Service_Log__c l : map_logColleg_caseColleg.keyset()) {
                sharedKitLogs.add(l.kit_in_condivisione__c);
            }
            List<EOF_EAI_Service_Log__c> externalKit = [SELECT caso__c FROM EOF_EAI_Service_Log__c 
                                                        WHERE id IN: sharedKitLogs];
            
            for(EOF_EAI_Service_Log__c log : map_logColleg_caseColleg.keySet()) {
                Case colleg = map_logColleg_caseColleg.get(log);
                
                for(EOF_EAI_Service_Log__c extKit : externalKit) {
                    System.debug('##### kit in condivisione esterno richiesta: ' + log.caso__c);
                    if(log.kit_in_condivisione__c == extKit.Id) {
                        colleg.kit_in_condivisione__c = extKit.caso__c;
                        toUpdate.add(colleg); 
                    }                                   
                }
            }         
            update toUpdate;
        }
     }
    
    //da Commentare!
    /*EC 2019 05 15
metodo precedente che genera CEI invece di VLAN

public pagereference InviaRichiesta_2() {
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
parentCase.RecordTypeId = rtMap.get('PO_Richiesta_a_servizio_a_fattibilit');
parentCase.Status = 'Acquisito';
parentCase.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
parentCase.accountId = accId;
parentCase.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit');
parentCase.PO_Offerta__c = parentLogObj.PO_Offerta__c;
parentCase.EOF_Codice_Operatore_WS__c = parentLogObj.EOF_Codice_Operatore__c;
parentCase.PO_Nome_Progetto__c = parentLogObj.PO_Nome_Progetto__c;
parentCase.Subject = parentLogObj.EOF_Tipo_Comunicazione_String__c;
parentCase.EOF_Codice_Ordine_OLO__c = parentLogObj.EOF_Codice_Ordine_OLO__c;
parentCase.PO_P2P_Attiva__c = true;
parentCase.PO_SA_Portale__c = true;//EC 2018 - 08 - 08
if (contratto != null) {
parentLogObj.PO_Accordo_Quadro_Number__c = contratto.OF_IdContratto__c;
// RDG 2019-02-08
parentCase.OF_IDContratto__c = contratto.Id;
parentCase.PO_Accordo_Quadro__c = contratto.Id;
}
insert parentCase;

List<EOF_EAI_Service_Log__c> logToUpdate = new List<EOF_EAI_Service_Log__c>();
//Dopo aver popolato il parent case, aggiorno anche il parent log
parentLogObj.EOF_Stato_Richiesta__c = 'Inserita Portale';
parentLogObj.EOF_STATO_ORDINE__c = 'Acquisito';
parentLogObj.Caso__c = parentCase.Id;

logToUpdate.add(parentLogObj);

//inserisco i collegamenti come case e mi faccio una mappa di id del log e case per riassociarli dopo l'inserimento
List<Case> listaCaseCollegamentoToInsert = new List<Case>();
map<String,case> map_IdLog_Case = new map<String,case>();
Set<Id> childLogsCollegamentoId = new Set<Id>();
//mi faccio una mappa id del kit del log  nuovo (se presente) e case collegamento cosi dopo l'inserimento posso associarli
map<String,Case> mapKitLogCaseCollegamento = new map<String,Case>();
Map<String,String> MapLogCollLogKIT = new Map<String,String>();
for (EOF_EAI_Service_Log__c childLog: P2PAttivaLogList) {
Case caseCollegamento = new Case();
caseCollegamento.RecordTypeId = rtMap.get('PO_Collegamento_P2P_Attiva');
caseCollegamento.Status = 'Acquisito';
caseCollegamento.EOF_Fase__c = 'NA';
caseCollegamento.accountId = accId;
caseCollegamento.OwnerId = ownerMap.get('PO_Coda_Servizi_a_fattibilit');
caseCollegamento.PO_Offerta__c = childLog.PO_Offerta__c;
caseCollegamento.EOF_Codice_Operatore_WS__c = childLog.EOF_Codice_Operatore__c;
caseCollegamento.PO_Nome_Progetto__c = childLog.PO_Nome_Progetto__c;
caseCollegamento.EOF_Codice_Ordine_OLO__c = childLog.EOF_Codice_Ordine_OLO__c;
caseCollegamento.ParentId = parentCase.Id;
// RDG 2019-02-08
caseCollegamento.OF_IDContratto__c = parentCase.OF_IDContratto__c;
caseCollegamento.PO_Comune__c = childLog.EOF_Comune__c;
caseCollegamento.PO_Comune2__c = childLog.OF_Id_Comune__c;
caseCollegamento.PO_Tipo_di_collegamento__c = childLog.PO_Tipo_di_collegamento__c;
caseCollegamento.PO_Prime_Contractor__c = childLog.PO_Prime_Contractor__c;
caseCollegamento.PO_Tipo_percorso__c = childLog.PO_Tipo_percorso__c;
caseCollegamento.PO_Numero_fibre_richieste__c = childLog.PO_Numero_fibre_richieste__c;
caseCollegamento.OF_SA_Profilo__c = childLog.EOF_PROFILO__c;
caseCollegamento.PO_Sito__c = childLog.PO_Sito__c;
caseCollegamento.PO_Indirizzo_collegamento__c = childLog.PO_Indirizzo_collegamento__c;
caseCollegamento.PO_Civico__c = childLog.PO_Civico__c;
caseCollegamento.PO_Nota_sito__c = childLog.PO_Nota_sito__c;
caseCollegamento.PO_Richiesta_a_fattibilit__c = parentCase.Id;
caseCollegamento.PO_P2P_Attiva__c = true;
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
map<String,Case> mapKitLogCaseKIT = new map<String,Case>();
List<Case> listaCaseKITToInsert = new List<Case>();

for (EOF_EAI_Service_Log__c kitLog:ListKitToSend) {
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
//system.debug('@@@@@@ listaCaseKITToInsert: '+listaCaseKITToInsert);
//rifaccio il ciclo per legarci il case
for (EOF_EAI_Service_Log__c kitLog:ListKitToSend) {
kitLog.Caso__c=mapKitLogCaseKIT.get(kitLog.Id).Id;
kitLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
kitLog.EOF_STATO_ORDINE__c = 'Acquisito';
logToUpdate.add(kitLog);
}

//rifaccio il ciclo sui collegamenti per legarci i kit
//system.debug('@@@@ Ale mapKitLogCaseKIT: '+mapKitLogCaseKIT);
//system.debug('@@@@ Ale MapLogCollLogKIT: '+MapLogCollLogKIT);
IF(!MapLogCollLogKIT.isEmpty()) {
List<Case> CaseCollToUpdate = new List<Case>();
for (String LOgCollId:MapLogCollLogKIT.keyset()) {
Case collegamento= map_IdLog_Case.get(LOgCollId);
//system.debug('@@@@ Ale collegamento: '+collegamento);
String id = mapKitLogCaseKIT.get(MapLogCollLogKIT.get(LOgCollId)).Id;
collegamento.PO_KIT_Consegna_VLAN__c=mapKitLogCaseKIT.get(MapLogCollLogKIT.get(LOgCollId)).Id;
CaseCollToUpdate.add(collegamento);
}
update CaseCollToUpdate;
}

//mi tiro fuori gli allegati per legarli ai nuovi case
Map<Id, List<Attachment>> mapParentIdListAttach = getChildLogAttachment(childLogsCollegamentoId);
List<Attachment> attachmentToUpdate = new List<Attachment>();
//mi tiro fuori le vlan per creare i CEI e legarli ai nuovi case
Map<Id, List<EOF_EAI_Service_Log__c>> mapSLRifLog = getVLANLog(childLogsCollegamentoId);
List<OF_CommercialElementIstanziato__c> ListCEIToInsert = new List<OF_CommercialElementIstanziato__c>();
Id vlanCEId = [SELECT Id
FROM OF_CommercialElement__c
WHERE OF_Servizio__r.Name='Open Stream'
AND Name='VLAN' LIMIT 1].Id;

for (EOF_EAI_Service_Log__c childLog : P2PAttivaLogList) {
childLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
childLog.EOF_STATO_ORDINE__c = 'Acquisito';
childLog.Caso__c = map_IdLog_Case.get(childLog.Id).Id;
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
    /*			if ((mapParentIdListAttach.get(childlog.id) != null) && !mapParentIdListAttach.get(childlog.id).isEmpty()) {
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

List<EOF_EAI_Service_Log__c> vlanLogList = mapSLRifLog.get(childLog.Id);
if (vlanLogList != null) {
for (EOF_EAI_Service_Log__c vlanLog : vlanLogList) {
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
}
}

if (!attachmentToUpdate.isEmpty()) {
update attachmentToUpdate;
if (!attToInsert.isEmpty()) {
insert attToInsert;
}
if (!attToDelete.isEmpty()) {//EC start 2018 - 11 - 12
//	delete attToDelete;
}//EC end 2018 - 11 - 12
}
insert ListCEIToInsert;
if (!slListToDelete.isEmpty()) {
delete slListToDelete;
}
update logToUpdate;
pagereference pg = new pagereference('/PO_P2PAtt_RiepReq_ElCo');
pg.getParameters().put('parentId', parentLogObj.Id);
pg.setRedirect(true);
return pg;
}
*/
    // EC 2019 05 15 END commento 
    
    // DN
    @testVisible
    private void updateSatellites(List<Case> collegamenti, Id sLogIdMaster) {
        System.debug('##### updateSatellites - collegamenti.size / id_sede_master: ' + 
                     collegamenti.size() + ' / ' + sLogIdMaster);
        Id idMaster = null;
        for(Case c : collegamenti) {
            if(SEDE_MASTER.equals(c.Tipologia_Sede__c)) {
                idMaster = c.Id;
                System.debug('##### updateSatellites - sede master sotto la richiesta, id_sede_master: ' + idMaster);            
                break;
            }
        }
        
        List<Case> master = new List<Case>();
        if(idMaster == null) {
            // sede master non si trova sotto la stessa dei satelliti ma esterna.
            // sede master uguale su tutti i satelliti
            master = [SELECT Id FROM Case WHERE Id IN
                      (SELECT caso__c FROM EOF_EAI_Service_Log__c WHERE Id =: sLogIdMaster)];
            
            if(!master.isEmpty()) {
                idMaster = master[0].Id;
                System.debug('##### updateSatellites - sede master esterna alla richiesta, id_sede_master: ' + idMaster); 
            }
        }
        if(idMaster != null) {
            for (Case c : collegamenti) {
                if(SEDE_SATELLITE.equals(c.Tipologia_Sede__c)) {
                    c.id_sede_master__c = idMaster;
                }   
            }
            update collegamenti;
        }
        System.debug('##### updateSatellites - satelliti senza sede master, id_sede_master: ' + idMaster); 
        
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
        System.debug('@@listVLAN'+listVLAN);
        //In teoria ci sarà sempre almeno 1 VLAN
        if ((listVLAN != null) && !listVLAN.isEmpty()) {
            //Ciclo sulla lista di VLAN
            for (EOF_EAI_Service_Log__c vlan : listVLAN) {
                //Qui controllerò la presenza del SL_Riferminto all'interno del map, se esiste, aggiorno la lista, viceversa la istanzio
                List<EOF_EAI_Service_Log__c> tempList;
                if (mapSLRifLog.get(vlan.EOF_SL_Riferimento__c) != null) {//Il SL_Riferimento è già presente all'interno della map
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
        parentCase.PO_Offerta__c = 'P2P Attiva';
        
        
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
        
        recordtype rt6 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P_Attiva'];
        
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
        
        if ((P2PAttivaLogPadre != null) && (P2PAttivaLogPadre.id != null))
        {
            if ((P2PAttivaLogPadre.PO_Nome_Progetto__c == '') || (P2PAttivaLogPadre.PO_Nome_Progetto__c == null)) {
                P2PAttivaLogPadre.PO_Nome_Progetto__c =Nome;
                offertEvento ='P2P Attiva';
                //offertEvento = P2PAttivaLogPadre.PO_Offerta__c;
            }
            //system.debug('inside the childLog condition'+P2PAttivaLogPadre.PO_Nome_Progetto__c);
            
            //system.debug('inside the childlog condition'+testParentId);
            recid =  P2PAttivaLogPadre.id;
            if (P2PAttivaLogPadre.OwnerId != rectypeID) {
                P2PAttivaLogPadre.OwnerId = UserInfo.getUserId();
                update P2PAttivaLogPadre;
            }
        }
        else if ((parentLogObj != null) && (parentLogObj.id != null))
        {
            recid =  parentLogObj.id;
            offertEvento ='P2P Attiva';
            //offertEvento = P2PAttivaLogPadre.PO_Offerta__c;
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
                offertEvento ='P2P Attiva';
                //offertEvento = P2PAttivaLogPadre.PO_Offerta__c;
            }
            recid =  testParent.get(0).id;
            update testParent;
            Nome = '';
            //system.debug('testParent '+testParent );
        }
        //system.debug('recid====='+recid);
        List<EOF_EAI_Service_Log__c> slUpdate = [select id,name,PO_Offerta__c,PO_Nome_Progetto__c,OwnerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c from EOF_EAI_Service_Log__c where id=:recid];
        
        recordtype rt6 = [select id from recordtype where sobjectType ='EOF_EAI_Service_Log__c' and DeveloperName ='P2P_Attiva_Collegamento']; //EC 2019 05 27 il developer name del collegamento di p2p attiva è P2P_Attiva_Collegamento non PO_Collegamento_P2P_Attiva. commentata la condizione precedente and developername='PO_Collegamento_P2P_Attiva'];
        
        List<EOF_EAI_Service_Log__c> pSL = [select id,PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c from EOF_EAI_Service_Log__c where id=:slUpdate.get(0).id limit 1];
        //system.debug('Parent EOF_EAI_Service_Log__c--------->'+pSL);
        string serviceType = pSL.get(0).PO_Offerta__c;
        //system.debug('serviceType--------->'+serviceType);
        if (pSL != null) {
            update pSL;
        }
        selectedIdComune = '';
        selectedIdComune1 = '';
        selectedIdComune2 = '';
        P2PAttivaLog = new EOF_EAI_Service_Log__c();
        P2PAttivaLog.EOF_SL_Riferimento__c = pSL.get(0).id;
        P2PAttivaLog.RecordTypeId = rt6.id;
        P2PAttivaLog.EOF_Stato_Richiesta__c = 'Inserito';
        
        insert P2PAttivaLog;
        //system.debug('P2PAttivaLog--->'+P2PAttivaLog);
    }
    
    public pagereference AddParentAttachment() {
        //AA Modifica 31-08-18
        PageReference pg = new PageReference('/PO_P2PAttiva_AddAttachment');
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        pg.getParameters().put('parentId', parentLogObj.Id);
        return pg;
    }
    
    public pagereference inserisciNuovoCollegamento() {
        String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');
        PageReference pg;
        if(tipoP2PAttiva =='eLine'){
            pg = new PageReference('/PO_P2PAttiva_EditLogInfoELine');
        }else{
            pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
        }
        pg.getParameters().put('parentId',PrntLogID);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    //EC start 2018 - 09 - 21
    public pagereference inserisciNuovoKit() {
        
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
        //pg.getParameters().put('cLogId',cLogId);
        pg.getParameters().put('kitId',sl.id);
        pg.getParameters().put('from','RiepReq');
        pg.getParameters().put('op','ins');
        pg.getParameters().put('retUrl',retUrl);
        return pg;
    }
    
    public pagereference goToKITpage() {
        String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');
        String cLogId = findChildLogByKit(kitLogId);
        System.debug('@@@kitLog id ' + kitLogId);
        PageReference pg;
        if (parentLogObj.EOF_Stato_Richiesta__c == 'Bozza Portale') {
            pg = new PageReference('/apex/PO_P2PAttiva_InserimentoKIT');
            pg.getParameters().put('parentId',PrntLogID);
            pg.getParameters().put('cLogId',cLogId);
            pg.getParameters().put('kitId',kitLogId);
            pg.getParameters().put('from','RiepReq');
            pg.getParameters().put('retUrl',retUrl);
            pg.getParameters().put('op','mod');
        }
        else{
            pg = new PageReference('/apex/PO_P2PAttiva_viewKIT');
            pg.getParameters().put('parentId',PrntLogID);
            pg.getParameters().put('kitId',kitLogId);
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            pg.getParameters().put('from','RiepReq');
        }
        pg.getParameters().put('retUrl',retUrl);
        return pg;
    }
    
    private String findChildLogByKit(String kitId) {
        system.debug('@@@EC rtMap: ' + rtMap);
        List<EOF_EAI_Service_Log__c> childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE OF_PP_KIT_Log__c =: kitId 
            AND RecordTypeId =: rtMap.get(RTypeServFattibilita.LOG_P2P_ATTIVA_COLLEGAMENTO)];
        if(!childLog.isEmpty()) {
            return childLog[0].Id;
        }       
        return ''; 
    }
    
    public pageReference eliminaKit() {
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
    
    public pagereference  redirectparentlogdetail() {
        //ParentDate=string.valueof(parentLogObj.CreatedDate);
        
        PageReference pg = new PageReference('/PO_P2PAttiva_OverviewRequest');
        pg.getParameters().put('parentId', parentLogObj.Id);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    
    public pagereference EditLogInfo() { 
        if(tipoP2PAttiva == 'eLine'){
            PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfoELine');
            pg.getParameters().put('cLogId', childlogdisplayid);
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            pg.getParameters().put('parentId', parentLogObj.Id); 
            return pg;
        }else{
            PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
            pg.getParameters().put('cLogId', childlogdisplayid);
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            pg.getParameters().put('parentId', parentLogObj.Id); 
            return pg; 
        }
    }
    
    public pagereference  redirectchildlogdetail() {
        
        PageReference pg = new PageReference('/PO_P2PAttiva_OverviewchildLogReq');
        pg.getParameters().put('childId', childlogdisplayid);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    
    public pagereference deleteLog() {
        
        try {
            
            List<String> listChildsId = new List<String>();
            List<EOF_EAI_Service_Log__c> listVlan =  new List<EOF_EAI_Service_Log__c>();
            List<Attachment> listAttachment = new List<Attachment>();
            
            if (!P2PAttivaLogList.isEmpty()) {
                for (EOF_EAI_Service_Log__c log : P2PAttivaLogList) {
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
            delete P2PAttivaLogList;
            delete parentLogObj;
            
            
        }catch (exception e) {
            //system.debug('exception'+e);
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
        PageReference pg;
        if(tipoP2PAttiva == 'eLine'){
            pg = new PageReference('/PO_P2P_Attivo_DisplayRequestELine');
        }else{
            pg = new PageReference('/PO_P2P_Attivo_DisplayRequest');
        }
        
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
        
    }
    
    public list<Opportunity> getparentOppty() {
        try {
            String id=apexpages.currentpage().getparameters().get('id');
            if (String.isNotBlank(id)) {
                parentOpptylst = [select id,PO_Totale_contributi_attivazione__c,PO_Sconto_contributi_attivazione__c from Opportunity where PO_Richiesta_fattibilit__c =:id];
            }
        } catch (exception e) {
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
        
        //  String idCaseKit= [select Id, CaseNumber from Case where Id in (Select Caso__c from EOF_EAI_Service_Log__c where Id=:kitLog.id)].id;
        Id ownerCodaFattId = [select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
        List<Case> caseKitList = new List<Case>();
        List<EOF_EAI_Service_Log__c> kitLogListToUpdate = new List<EOF_EAI_Service_Log__c>();
        
        For(EOF_EAI_Service_Log__c kitLog: kitLogList) {
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
        
    }
    //EC end 2018 - 09 - 26
    
    public void deleteVoidKitLog() {
        
        kitListToDelete=[SELECT id FROM EOF_EAI_Service_Log__c
                         WHERE RecordType.DeveloperName = 'PO_Log_P2P_Attiva_KIT' AND (PO_P2PAttiva_Nome_del_KIT__c=null OR PO_P2PAttiva_Nome_del_KIT__c='') AND
                         ((EOF_SL_Riferimento__c IN :setIdCollegamenti)OR (EOF_SL_Riferimento__c=null OR EOF_SL_Riferimento__c='') OR (EOF_SL_Riferimento__c =:(ApexPages.currentPage().getParameters().get('parentId')))) ];
        
        
        delete kitListToDelete;
    }
    
    //27-12-2018 V1 BUGFIX P2PATTIVA - start
    public pagereference Annulla() {
        PageReference pg;
        //PageReference pg = new PageReference('/partnercommunity');
        if(tipoP2PAttiva =='eLine'){
            pg = new PageReference('/PO_P2P_Attivo_DisplayRequestELine');
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        }else{
            pg = new PageReference('/PO_P2P_Attivo_DisplayRequest');
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        }
        return pg;
        
    }
    //27-12-2018 V1 BUGFIX P2PATTIVA - end
    
    @TestVisible private string setNullToZ(String myVal) {
        
        if (String.isBlank(myVal)||  myVal == '' )
            return '0';
        
        return myVal;
    }
    
}
public class PO_RegistrationController {
    
    //public PO_AddressMatchingWebservice addressmatch{get;set;}
    public boolean showRichiesteInserite {get; set;} //EC 2018 - 11 - 10
    public case testcase{get;set;}
    public static String comunename {get;set;} //Abhishek Anand 22112018 CR34
    public static String IdEgonStrada {get;set;} //Abhishek Anand 22112018 CR34
    public String IdEgoncivico {get;set;}//Abhishek Anand 22112018 CR34
    public string AttivoFlag{get;set;}//Abhishek Anand 21112018 CR34
    public string PassivoFlag{get;set;}//Abhishek Anand 21112018 CR34
    public boolean DetailVisible{get;set;}//Abhishek Anand 21112018 CR34  
    // public String Chatterpor {get;set;}//Abhishek Anand 21112018 CR34
    public static String showCivicoId{get;set;} //Abhishek Anand 27112018 CR34
    public static String result3{get;set;}//Abhishek Anand 27112018 CR34
    public static String result4{get;set;}//Abhishek Anand 27112018 CR34
    public String showCivico{get;set;}//Abhishek Anand 27112018 CR34 
    
    public boolean showServizia4new_SOC{get;set;} //For Segnalazione Provisioning SOC
    
    
    /*public case testcase{
get{

string recid = '';

String id=apexpages.currentpage().getparameters().get('id') ;

if(id != null && id != '')
{
recid = id;
}

else if(parentcaseobj != null)
{
recid = parentcaseobj.id;
}
system.debug('recid ====='+recid );
if (recid!='' ){
testcase = new case();
testcase  =[select id,PO_Offerta__c,accountid,PO_Nome_Progetto__c,ownerId from case where id=:recid];

}
system.debug('the value in the testcase'+testcase);
return testcase  ;
}
set;}
*/
    // public AddressmatchingIntegration__c wrapAccounts {get;set;} //Abhishek 18112018
    public String selectedValueIdPop{get;set;}
    public String Duratta{get;set;}
    public String selectedStato{get;set;}
    public EOF_EAI_Service_Log__c  P2PAttivaLog {get;set;} //EC 2018 - 07 - 20 P2PAttiva
    public EOF_EAI_Service_Log__c  P2PAttivaLogPadre {get;set;} //EC 2018 - 07 - 20 P2PAttiva
    public List<EOF_EAI_Service_Log__c>  P2PAttivaLogList {get;set;} //EC 2018 - 07 - 20 P2PAttiva
    public List<EOF_EAI_Service_Log__c > EOFOpenStream{get;set;}
    public List<EOF_EAI_Service_Log__c > EOFTroubleTicket{get;set;}
    public List<Case> list_caseTP {get;set;} //PG - 10/04
    public ApexPages.StandardSetController setConP2PAttiva {get;set;} //EC 2018 - 07 - 20 P2PAttiva
    public ApexPages.StandardSetController setConOpen {get;set;}
    public ApexPages.StandardSetController setConTT {get;set;}
    public ApexPages.StandardSetController setTicketProv {get;set;}   //PG - 5/04
    public decimal CostiAttivazione{get;set;}
    public decimal durataaff{get;set;}
    public List<Case> sortCases{get;set;}
    public String recordOfferta {get;set;}
    public id childcasedisplayid{get;set;}
    public String selectedValueTipo{get;set;}
    public String selectedValueStato{get;set;}
    public String selectedValueIdStatoOrdine{get;set;}
    public String selectedCasuale{get;set;}
    public String OffertaSelected{get;set;}
    // public Boolean childcaseRedirect=false;
    public String StatoSelected{get;set;}
    public String OffertaCheck{get;set;}
    public boolean searchCaseBoolean{get;set;}
    public boolean Ricerca{get;set;}
    public boolean ShowIndietro{get;set;}
    public opportunity childoppobj{get;set;}
    public String ParentDate{get;set;}
    public string IndirizzoCliente{get;set;}
    public string IndirizzoSede1diTerminazione{get;set;}
    public string IndirizzoSede2diTerminazione{get;set;}
    public case childcasedisplayobj{get;set;}
    public List<attachment> childcasedisplayattlist{get;set;}
    public String Nome{get;set;}
    Public String PrntCaseID;
    public string offertEvento {get;set;}
    public boolean showPage{get{system.debug('ShowPage==='+showPage); return showPage;}set;}
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
        public string childDate {set;get;}
    public string ordercasedispayordinedate{get;set;}
    public List<Case> casestoupload {get;set;}
    public  string str{get;set;}
    public string date4{get;set;}
    public case editchildparentCaseObj{get;set;}
    public OF_ElencoComuniItaliani__c OF_ElencoComuniItalianiobj{get;set;}
    public OF_ElencoComuniItaliani__c OF_ElencoComuniItalianiobj1{get;set;}
    public OF_ElencoComuniItaliani__c OF_ElencoComuniItalianiobj2{get;set;}
    public boolean caseobjbuttoncheck{get;set;}
    public Case caseObj {get;set;}
    public String Status;
    public string stringdate_In_PO_ModalController{get;set;}
    public Id PO_RegistrazioneRecordTypeId;
    public Id accId;
    public list<case> childcserec {get;set;}
    public list<case> orderCaselist {get;set;}
    public List<Contact> conList{get;set;}
    public list<case> ordercaselst {get;set;}
    public boolean secA{get;set;}
    
    public boolean secB{get;set;}
    public boolean secC{get;set;}
    public boolean secD{get;set;}
    public boolean secE{get;set;}
    public boolean secF{get;set;}
    public string conId{get;set;}
    public boolean invia {get;set;}
    public contact contactObj {get;set;}
    public boolean showcon{get;set;}
    public Case parentCase { get; set;}
    
    public Case openstreamcase{get;set;}
    public Case parentCaseNew {get;set;}
    public Case ChildCase{get;set;}
    public String AccName {get;set;}
    public case displayCase {get;set;}
    public boolean showServizia {get;set;}
    public boolean showServizia2 {get;set;}
    public boolean showServizia3 {get;set;}//AS
    public boolean showServizia4 {get;set;}//AM
    public boolean showIncidentManagement {get;set;} //Add by PG - 09-05
    public boolean show1 {get;set;}
    public boolean show2 {get;set;}
    public boolean show3 {get;set;}
    public boolean show4 {get;set;}
    public boolean show5 {get;set;}
    public boolean show6 {get;set;}
    public boolean showCirc{get;set;}
    public boolean show7 {get;set;} //rerender per sezione kit
    //EC 2018 - 07 - 05 
    public boolean showP2PAtt{get;set;}
    public boolean showProdAvail{get;set;} //AbhishekAnand 14122018 For - CR34 Improvement Extension II 
    
    //Start - Add by PG - C&D - 22-11
    public boolean showOpenStreamCeD{get;set;}
    public boolean showGPONCeD{get;set;}
    
    //End - Add by PG - C&D - 22-11
    
    //giovanni 31102018 inizio
    public boolean showDarkFiber {get;set;}
    public boolean showCircDir{get;set;}
    public boolean showBackhauling {get;set;}
    public boolean showBTS {get;set;}
    //giovanni 31102018 fine
    
    public boolean showChangeOrder{get;set;}
    //end EC 2018-07-05
    public boolean showEdit{get;set;}
    public list<case> currentUserCases {get;set;}
    public list<case> ChildCases {get;set;}
    public String SelParent {get;set;}
    public string CaseDetail{get;set;}
    public Case parentCaseObj {get;set;}
    public String urlPage {get; set;}
    
    public User userIstance;
    
    public Case ParentCaseDisplay{get{ Id caseId = ApexPages.currentPage().getParameters().get('id');
                                      if (caseId != null){
                                          ParentCaseDisplay=new case();
                                          ParentCaseDisplay= [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                                              PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,ownerId from case where Id=:caseId];
                                          system.debug('ParentCaseDsiplay'+SearchCaseBoolean);
                                          ParentDate=ParentCaseDisplay.CreatedDate.format('dd/MM/yyyy HH:mm:ss');
                                          //return ParentCaseDisplay;
                                      }
                                      return ParentCaseDisplay;
                                     }set;}
    
    public Case childCaseObj {get;set;}
    
    public String sortField {get;set;}
    public String myOrder {get;set;}
    public boolean inlineshow {get;set;}
    public case ordercasedit {get;set;}
    @TestVisible public List<addAdressClass> listValueOfTextBox { get;set;}
    
    public List<User> contactUserList {get;set;}
    Public string accountname{get;set;}
    public string comune {get;set;}
    public Attachment myAttachment{get;set;}
    public string fileName{get;set;}
    public transient Blob fileBody{get;set;}
    public string fileName1{get;set;}
    public transient Blob fileBody1{get;set;}
    public Map<Id,String> uploadMap {get;set;}
    public boolean fileRender {get;set;}
    public boolean stagename {get;set;}
    public date childrecdate {get;set;}
    public List<QuoteDocument>  quoteDoc{get;set;}
    public boolean childcheck {get;set;}
    public boolean ordercheck{get;set;}
    public Id  quoteDocid {get;set;}
    public boolean orderline {get;set;}
    public String  quoteName {get;set;}
    public String Prezzototale{get;set;}
    public String ContDocId {get;set;}
    public boolean ParentOrderCheck {get;set;}
    public String baseURL {get;set;}
    public list<opportunity> opp{get;set;}
    public list<attachment> attlst {get;set;}
    public list<attachment> newAtt {get;set;}
    public list<attachment> attxlxs {get;set;}
    public list<Attachment> orderAtt {get;set;}
    public list<string> commune {get;set;}
    //public opportunity oppty{get;set;}
    public string parentrec {get;set;}
    public boolean parentfile {get;set;}
    public boolean ordine{get;set;}
    public list<case> displayUploadedCases {get;set;}
    public list<opportunity> parentOpptylst {get;set;}
    public ApexPages.StandardController myAccountController {get; set;}
    @TestVisible private String soql {get;set;}
    public List<Case> Cases{get;set;}
    public List<OF_CommercialElementIstanziato__c> ceiViewList {get;set;}  //ADD by EC 2018 - 05 - 22
    public ApexPages.StandardSetController setCon {get;set;}
    public String sortDir
    {
        get
        {
            if (sortDir == null)
            {
                sortDir = 'asc';
            }
            return sortDir;
        }
        set;
    }
    
    //EC start searchProfile as OpenStream method 2018 - 07 - 13
    
    public string profiloCommerciale{get;set;}
    public boolean verifyProfilo{get;set;}
    public boolean viewError{get;set;}
    public boolean viewProfilo{get;set;}
    
    //EC end  searchProfile as OpenStream method 2018 - 07 - 13
    //
    //EC start 2018 - 07 - 23
    
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public EOF_EAI_Service_Log__c sl{get;set;}
    public boolean modifyMode{get;set;}
    public boolean insertMode{get;set;}
    public boolean Apparati{get;set;}
    public String DATA_PREVISTA_ATTIVAZIONE{get;set;}
    public Map<String,Id> rtMap;
    //EC end 2018 - 07 - 23
    
    //EC start 2018 - 07 - 16 
    //  public String AccountName{get;set;}
    public String requestSelected{get;set;}
    public List<SelectOption> requestOptions{get;set;}
    public List<String> tipiReq{get; set;}
    public string apageCkey {get;set;}
    public String offertaP2PAttiva{get;set;}
    //EC end 2018 - 07 - 16
    
    //EC start 2018 - 11 - 06
    String sParentId{get;set;}
    
    //EC end 2018 - 11 - 06
    
    /*EC 2018 - 07 - 16  copiato da PO_COMP_SceltaRequest_Controller

public String AccountName{get;set;}
public String requestSelected{get;set;}
public List<SelectOption> requestOptions{get;set;}

public PO_COMP_SceltaRequest_Controller(){
User attuale=[select Id,Account.name from user where Id=:userinfo.getUserId()];
AccountName=attuale.account.name;

requestOptions = new List<SelectOption>();
requestOptions.add(new SelectOption('ATT','Ordine di Attivazione'));
requestOptions.add(new SelectOption('CESS','Ordine di Cessazione'));
//EC - 2018 - 05 - 21 ChangeOrder START  
//  requestOptions.add(new SelectOption('CHANORD','Ordine di Variazione'));
//EC - 2018 - 05 -21 ChangeOrder END
}

public pagereference annullaScelta(){
Pagereference pg = new PageReference('/PO_Index');
return pg;
}
public pagereference inserisciRequest(){
Pagereference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
pg.getParameters().put('proc','InserimentoRichiesta'+requestSelected);
return pg;
}


*/
    
    
    
    
    
    public PO_RegistrationController(ApexPages.StandardController Controller){
        
        showCivicoId='';//Abhishek Anand 27112018 CR34
        showCivico = '';//Abhishek Anand 27112018 CR34
        IdEgoncivico='';//Abhishek Anand 27112018 CR34
        AttivoFlag='';//Abhishek Anand 27112018 CR34
        PassivoFlag='';//Abhishek Anand 27112018 CR34
        result3 ='';//Abhishek Anand 27112018 CR34
        result4 ='';//Abhishek Anand 27112018 CR34
        showRichiesteInserite =false;//EC 2018 - 11 - 10
        // Chatterpor='';//Abhishek Anand CR34 21112018
        
        
        
        //EC Start searchProfilo as OpenStream Method 2018 - 07 - 13
        profiloCommerciale='';
        
        verifyProfilo = true;
        viewError=false;
        viewProfilo=false;
        
        //EC End searchProfilo as OpenStream Method 2018 - 07 -13
        offertaSelected='';
        offertaCheck='';
        searchCaseBoolean=false;
        childoppobj = new opportunity();
        //testvar ='testfirst';
        //   PrntCaseID= apexpages.currentpage().getparameters().get('id');
        PO_RegistrazioneRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.PO_Registrazione).getRecordTypeId();
        displayUploadedCases = new list<case>();
        // showPage = true;
        Status = 'Nuovo';
        caseObj = new Case();
        StatoSelected = '';
        accId = usr.Contact.Account.Id;
        soql = 'select Casenumber, Status, CreatedDate,PO_Tipo_di_collegamento__c,PO_Prime_Contractor__c,PO_Tipologia_Offerta_ordine__c,PO_Tipologia_Offerta__c ,PO_Offerta__c,PO_CreatedDate__c,PO_Case_Type_Formula__c,PO_Nome_Comune__c,PO_Nome_Progetto__c,OwnerId from Case where CaseNumber != null and PO_Case_Type_Formula__c != null and accountid=:accId';
        childcasedisplayattlist = new list <Attachment>();  
        
        attlst = new list<attachment>();
        newAtt = new list<attachment>();
        attxlxs = new list<attachment>();
        orderAtt = new list<attachment>();
        attachment = new attachment();
        parentfile = false;
        ChildCase = new Case();
        parentrec = '';
        ordine = false;
        Prezzototale = '';
        accountname=usr.Contact.Account.Name;
        inlineshow = false;
        secA=true;
        secB=false;
        showcon = false;
        secC = false;
        ordercheck = false;
        secD = false;
        secE = false;
        secF = false;
        childcheck = false;
        orderline = false;
        sortField = 'CreatedDate';
        myOrder = 'DESC';
        testcase = new Case();
        //oppty = new opportunity();
        ordercaselst = new list<case>();
        parentOpptylst = new list<opportunity>();
        showServizia = usr.contact.PO_Servizi_a_fattibilit__c;
        showServizia2 = usr.contact.PO_Servizio_Open_Stream__c;
        
        showServizia3 = usr.contact.PO_Servizio_Trouble_Ticket__c;
        showServizia4 = usr.contact.PO_Servizio_Ticket_Provisioning__c;
        showIncidentManagement = usr.contact.PO_Servizio_Incident_Management__c; //Add by PG - 09-05
        showOpenStreamCeD = usr.contact.PO_Servizio_Open_Stream_CeD__c; //Add by PG - C&D - 22-11
        showGPONCeD = usr.contact.PO_Servizio_GPON_Passiva_CeD__c; //Add by PG - C&D - 22-11
        
        //giovanni 31102018 inizio
        showDarkFiber = usr.contact.PO_Servizio_DarkFiber__c;
        showCircDir = usr.contact.PO_Servizio_Circuiti_Diretti__c;
        showBackhauling = usr.contact.PO_Servizio_Backhauling__c;
        showBTS = usr.contact.PO_Servizio_BTS__c;
        //giovanni 31102018 fine
        
        show1=usr.contact.PO_P2P_Base__c;
        //EC 2018 - 07 - 05
        showP2PAtt= usr.contact.PO_P2P_Attiva__c;
        showChangeOrder= usr.contact.PO_Change_Order__c;
        //end EC 2018 - 07 - 05
        show2=usr.contact.PO_Fiber_Lease__c;
        show3 = usr.contact.PO_Fiber_Link__c;
        showCirc = usr.contact.PO_Servizio_Circuiti_Diretti__c;
        
        showProdAvail=usr.contact.Product_Availability__c; //AbhishekAnand 14122018 For - CR34 Improvement Extension II 
        showServizia4new_SOC=usr.contact.Segnalazione_Provisioning_SOC__c; //For Segnalazione Provisioning SOC
        
        show4=usr.contact.PO_IRU__c;
        orderCaselist = new list<case>();
        show5=usr.contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c;
        show6 = usr.contact.PO_Servizio_Open_Stream__c;
        show7 = usr.contact.PO_Servizio_KIT__c; //setto il valore per il rerendere della szione KIT sul menu
        ParentOrderCheck = false;
        showEdit = false;
        invia = false;
        fileRender = false;
        caseobjbuttoncheck = false;
        listvalueOfTextBox = new List<addAdressClass>();
        String recordTypeName = 'PO Partner';
        stagename = false;
        commune = new list<string>();
        // comune = '';
        childcserec = new list<case>();
        ChildCases = new list<case>();
        List<User> cUserList = [Select Profile.Name,IsActive,Contact.Account.Id ,Contact.Id,Contact.Name,Contact.Email,
                                Contact.RecordType.Name,contact.PO_Servizio_Open_Stream__c, Contact.PO_Servizio_Open_Stream_CeD__c,
                                contact.PO_Servizio_Backhauling__c,
                                contact.PO_Servizio_BTS__c,
                                contact.PO_Servizio_DarkFiber__c,
                                contact.PO_Servizio_Circuiti_Diretti__c,
                                contact.PO_Servizi_a_fattibilit__c,
                                contact.PO_Servizio_Ticket_Provisioning__c, contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c,
                                contact.Product_Availability__c,  //Added for CR34 Extension II Abhishek Anand 14122018
                                contact.Segnalazione_Provisioning_SOC__c //For Segnalazione Provisioning SOC
                                From User
                                Where  Contact.Account.Id =:accId AND Contact.RecordType.Name = : recordTypeName ] ;
        
        System.Debug('Check User List'+ cUserList);
        if(cUserList.size()>0){
            contactUserList = cUserList;
        }
        system.debug('Inside Constructor');
        idquote = ApexPages.currentPage().getParameters().get('id');
        if(idquote==null && idquote==''){ //da eliminare appena si uniformano i parameter.
            idquote=ApexPages.currentPage().getParameters().get('parentId');
        }
        sParentId =ApexPages.currentPage().getParameters().get('parentId');/*EC 2018 - 11 - 06 il parametro passato per i case è o idBozza o parentId volendo uniformare ricorda di modificare anche i seguenti controller 
PO_COMP_ListaRichiesteInBoz_Feasib_Ctrl
PO_COMP_ListaRichiesteIns_Feasib_Ctrl*/
        system.debug('DG_PDF_idquote:' + idquote);
        system.debug('@@@@@@EC parentId valorizza la stringa sParentId: ' + sParentId);
        //Start-Added by Sasya on 29-11-2017
        //  if(idQuote!= null && idQuote.contains('500')) //EC commentiamo perché per uniformare agli altri servizi il parametro passato per il parentId di un case o di un log usiamo 'parentId'
        if(sParentId!= null /* && sParentId.contains('500')*/) //
        {
            parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,
                             PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, 
                             PO_Note_Modifica_Offerta__c, Subject, Status, Priority, 
                             CreatedDate, CreatedById,PO_Offerta__c,ClosedDate,
                             PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId,
                             accountid
                             from case 
                             where Id=:sParentId Limit 1];
            system.debug('parentCaseObj========'+parentCaseObj);
            if(parentCaseObj != null)
            {
                ChildCases = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                              CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                              Priority,Previous_Status__c,PO_IndrizoCal__c,OwnerId,PO_Durata_affitto__c, CreatedDate, CreatedById , PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                              from case where parentId=:parentCaseObj.id
                              order by CreatedDate ASC];
                opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Numero_Anni__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentCaseObj.id and PO_Collegamento__c = null limit 1];
                //AA FIX 12/06/18
                //  oppty = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Numero_Anni__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentCaseObj.id and PO_Collegamento__c = null limit 1];
                //   system.debug('value========'+oppty.PO_Numero_Anni__c);
                if(ChildCases.size()>0)
                {
                    ordercaselst = [select id,status,PO_Comune2__c,EOF_Comunicazioni_con_OLO__c,Note_Sospensione_Operatore__c,PO_Durata_mesi__c,PO_Case_Collegamento__r.PO_IndrizoCal__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
                                    PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                    PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Case_Collegamento__r.parent.PO_isDataOrder__c, PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                    recordtype.id,recordtype.developerName,OwnerId from case where PO_Case_Collegamento__c IN : ChildCases];
                    
                }
                list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentCaseObj.id AND IsPrivate = false AND Name LIKE '%PDF%'
                                           ORDER BY createddate DESC limit 1];
                system.debug('newlst---'+newlst);
                for(attachment att : newlst )
                {
                    String attnamenew = att.Name;
                    
                    if(attnamenew.contains('.pdf'))
                    {
                        newAtt.add(att);
                        system.debug('Attachment==='+newAtt);
                    }
                }
                
                list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentCaseObj.id
                                               ORDER BY createddate DESC];
                for(attachment att : attlstnew )
                {
                    
                    string attname = att.Name;
                    system.debug('Attachment==='+att.Name);
                    // if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))
                    
                    if(attname.containsIgnoreCase('.pdf'))
                    {
                        
                        attlst.add(att);
                        
                        system.debug('Attachment==='+attlst);
                        
                    }
                    
                }
                if(attlst.size()>1)
                {
                    attlst.remove(0);
                }
                
                list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentCaseObj.id AND IsPrivate = false
                                               ORDER BY createddate DESC];
                for(attachment att : newlstxlxs )
                {
                    String attnamexlxs = att.Name;
                    
                    if(attnamexlxs.contains('.xlsx'))
                    {
                        attxlxs.add(att);
                        system.debug('Attachment==='+attxlxs);
                    }
                }
                
            }
        }
        //End-Added by Sasya on 29-11-2017
        if(idQuote!= null && idQuote.contains('0Q0')){
            q = [select id, name, Opportunity.name, account.name,
                 Account.BillingStreet,Account.BillingCity,
                 Account.BillingState,Account.BillingPostalCode,
                 PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,Opportunity.PO_Durata_affitto__c,
                 PO_ContaPDF__c
                 from Quote
                 where id = :idquote];
            
            RichiestaFattibil = q.Opportunity.PO_Richiesta_fattibilit__c;
            system.debug('DG_PDF_q: ' + q);
            //CRM 24_08 INIZIO
            FindAnnoFiberLink();
            //FINE
            
            opp1 = getOpportunity();
            system.debug('DG_PDF_opp: ' + opp1);
            
            
            finalstr = 'Ns. Rif.:' + opp1.PO_Richiesta_fattibilit__r.casenumber + '<br/>' + 'Dettagli Collegamento e Offerta';
            
            /**PRIMA TABELLA**/
            
            string str;
            //Fiber Link
            if(checkFibLink == true)
                str = Tabella1FiberLink(opp1);
            //P2P
            if(checkP2P == true)
                str = Tabella1P2P(opp1);
            //IRU
            str = Tabella1IRU(opp1);
            if(checkIRU == true)
                //Fiber Lease
                if(checkFibLease == true)
                str = Tabella1FiberLease(opp1);
            //Fiber Lease Misto
            if(checkFibLeaseMisto == true)
                str = Tabella1FiberLeaseMisto(opp1);
            //Evento Temporaneo
            if(checkEventoTemp == true)
                str = Tabella1P2P(opp1);
            
            system.debug('DG_OF_CreateQuoteXLS_Controller str: ' + str);
            finalstr = finalstr + str ;
            
            /**END PRIMA TABELLA**/
            
            /**MESSAGGI**/
            if(str == null)
            {
                checkEmpty = true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Non ci sono dati disponibili per questa quote! Non puoi creare l\'xls.');
                ApexPages.addMessage(myMsg);
                return;
            }else
            {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Puoi creare l\'xls. <br/> L\'xls si troverà nella sezione Notes & Attachments della quote');
                ApexPages.addMessage(myMsg);
            }
            /**END MESSAGGI**/
            
            /**TABELLA DATI TOPONOMASTICI**/
            string str1 = '<br/><br/>Dati toponomastici<br/>' + TabellaDatiToponomastici(opp1);
            system.debug('DG_OF_CreateQuoteXLS_Controller str1: ' + str1);
            finalstr = finalstr + str1;
            /**END TABELLA DATI TOPONOMASTICI**/
            
            
            /**TABELLA DATI METRICI**/
            string str2 = '<br/>Dati metrici<br/>' + TabellaDatiMetrici(opp1);
            finalstr = finalstr + str2;
            /**END TABELLA DATI METRICI**/
            
            
            /**TABELLA DETTAGLIO OFFERTA**/
            if(!checkFibLease && !checkFibLeaseMisto)
            {
                string str3 = '<br/>Dettaglio offerta<br/>' + TabellaDettaglioOfferta(opp1);
                finalstr = finalstr + str3;
            }
            /**END TABELLA DETTAGLIO OFFERTA**/
            
            system.debug('DG_OF_CreateQuoteXLS_Controller finalstr: ' + finalstr);
            xlsxBlob = Blob.valueOf(finalstr);
            xlsxname= q.Name + '.xls';
            
            //myAttachment =new Attachment();
        }
        
        //EC start 2018 - 07 - 16
        //User attuale=[select Id,Account.name from user where Id=:userinfo.getUserId()];
        //  AccountName=attuale.account.name;
        apageCkey = ApexPages.CurrentPage().getUrl();
        System.debug('il valore di apageCkey è ' + apageCkey);
        if(apageCkey.contains('/PO_P2PAttiva_InsertNewRequest')){
            offertaP2PAttiva='P2P Attiva';
            scegliTipoReq();
            
            System.debug('@@@EC   ....siamo dentro l\'if del P2PAttiva');
        }
        
        //EC - 2018 - 05 - 21 ChangeOrder START  
        //  requestOptions.add(new SelectOption('CHANORD','Ordine di Variazione'));
        //EC end 2018 - 07 - 16
        //
        //
        //EC start 2018 - 07 - 23
        if(slOrig!=null){
            sl=slOrig;
            modifyMode=true;
            if(ApexPages.currentPage().getParameters().get('app') =='true'){
                Apparati=true;
            }
        }
        else{
            insertMode=true;
            User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
            sl = new EOF_EAI_Service_Log__c();
            List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
            rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                rtMap.put(rt.developerName, rt.Id); 
            } 
            
            sl.recordtypeId=rtMap.get('PO_SA_FiberRequest');
            sl.EOF_Stato_Richiesta__c='Bozza Portale';
            sl.EOF_CODICE_OPERATORE__c=attuale.Account.EOF_Codice_Operatore__c;
            sl.EOF_Tipo_Comunicazione_String__c='Attivazione';
        }
        
        //EC end 2018 - 07 - 23       
    }
    
    public PO_RegistrationController(){
        childcasedisplayattlist = new list <Attachment>();  
        showCivicoId='';//Abhishek Anand 27112018 CR34
        AttivoFlag='';//Abhishek Anand 27112018 CR34
        PassivoFlag='';//Abhishek Anand 27112018 CR34
        result3 ='';//Abhishek Anand 27112018 CR34
        result4 ='';//Abhishek Anand 27112018 CR34
        IdEgoncivico='';//Abhishek Anand 27112018 CR34
        showCivico='';//Abhishek Anand 27112018 CR34
        StatoSelected = '';
        childoppobj = new opportunity();
        // cases.clear();
        system.debug('inside second constructor');
        //testvar ='testsecond';
        PrntCaseID=apexpages.currentpage().getparameters().get('id');
        searchCaseBoolean=false;
        system.debug('the value in the show2'+ParentCase);
        
        PO_RegistrazioneRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(Label.PO_Registrazione).getRecordTypeId();
        // testcase = new Case();
        //showPage = true;
        Status = 'Nuovo';
        caseObj = new Case();
        accId = usr.Contact.Account.Id;
        attlst = new list<attachment>();
        newAtt = new list<attachment>();
        attachment = new attachment();
        parentOpptylst = new list<opportunity>();
        parentfile = false;
        ChildCase = new Case();
        parentrec = '';
        ordine = false;
        attlst = new list<attachment>();
        newAtt = new list<attachment>();
        attxlxs = new list<attachment>();
        orderAtt = new list<attachment>();
        Prezzototale = '';
        accountname=usr.Contact.Account.Name;
        inlineshow = false;
        secA=true;
        secB=false;
        showcon = false;
        secC = false;
        ordercheck = false;
        secD = false;
        secE = false;
        secF = false;
        childcheck = false;
        orderline = false;
        sortField = 'CreatedDate';
        myOrder = 'DESC';
        
        parentCase = new Case();
        
        
        ordercaselst = new list<case>();
        showServizia = usr.contact.PO_Servizi_a_fattibilit__c;
        showServizia2 = usr.contact.PO_Servizio_Open_Stream__c;
        showServizia3 = usr.contact.PO_Servizio_Trouble_Ticket__c; //AS
        showServizia4 = usr.contact.PO_Servizio_Ticket_Provisioning__c; //AM
        showIncidentManagement = usr.contact.PO_Servizio_Incident_Management__c; //Add by PG - 09-05
        show1=usr.contact.PO_P2P_Base__c;
        
        showOpenStreamCeD = usr.contact.PO_Servizio_Open_Stream_CeD__c; //Add by PG - C&D - 22-11
        showGPONCeD = usr.contact.PO_Servizio_GPON_Passiva_CeD__c; //Add by PG - C&D - 22-11
        
        //giovanni 31102018 inizio
        showDarkFiber = usr.contact.PO_Servizio_DarkFiber__c;
        showCircDir = usr.contact.PO_Servizio_Circuiti_Diretti__c;
        showBackhauling = usr.contact.PO_Servizio_Backhauling__c;
        showBTS = usr.contact.PO_Servizio_BTS__c;
        //giovanni 31102018 fine
        
        //EC 2018 - 07 - 05
        showP2PAtt= usr.contact.PO_P2P_Attiva__c;
        showChangeOrder= usr.contact.PO_Change_Order__c;
        //end EC 2018 - 07 - 05
        show2=usr.contact.PO_Fiber_Lease__c;
        show3 = usr.contact.PO_Fiber_Link__c;
        show7 = usr.contact.PO_Servizio_KIT__C;
        showProdAvail=usr.contact.Product_Availability__c; //AbhishekAnand 14122018 For - CR34 Improvement Extension II 
        showServizia4new_SOC=usr.contact.Segnalazione_Provisioning_SOC__c; //For Segnalazione Provisioning SOC
        show4=usr.contact.PO_IRU__c;
        orderCaselist = new list<case>();
        show5=usr.contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c;
        show6 = usr.contact.PO_Servizio_Open_Stream__c;
        ParentOrderCheck = false;
        showEdit = false;
        invia = false;
        fileRender = false;
        caseobjbuttoncheck = false;
        listvalueOfTextBox = new List<addAdressClass>();
        String recordTypeName = 'PO Partner';
        stagename = false;
        commune = new list<string>();
        // comune = '';
        childcserec = new list<case>();
        ChildCases = new list<case>();
        
        showRichiesteInserite =false;//EC 2018 - 11 - 10
        
        //giovanni 31102018 aggiunte le checkboxes per i nuovi servizi a fattibilita        
        List<User> cUserList = [Select Profile.Name,IsActive,Contact.Account.Id ,Contact.Id,Contact.Name,Contact.Email,
                                Contact.RecordType.Name,contact.PO_Servizio_Open_Stream__c,
                                contact.PO_Servizio_Backhauling__c,
                                contact.PO_Servizio_BTS__c,
                                contact.PO_Servizio_DarkFiber__c,
                                contact.PO_Servizio_Circuiti_Diretti__c,
                                contact.PO_Servizi_a_fattibilit__c,contact.PO_Servizio_Trouble_Ticket__c,
                                contact.PO_Servizio_Ticket_Provisioning__c, contact.PO_Servizio_Incident_Management__c,
                                contact.PO_Servizio_KIT__c, Contact.PO_P2P_Attiva__c, Contact.PO_Change_Order__c
                                From User
                                Where  Contact.Account.Id =:accId AND Contact.RecordType.Name = : recordTypeName ] ;
        
        if(cUserList.size()>0){
            contactUserList = cUserList;
        }
        idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + idquote);
        //Start-Added by Sasya on 29-11-2017
        if(idQuote!= null && idQuote.contains('500'))
        {
            System.debug('@@@@hi');
            try{
                parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                 PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:idQuote Limit 1];
            }catch(exception e){
            }
            system.debug('parentCaseObj========'+parentCaseObj);
            if(parentCaseObj != null)
            {
                ChildCases = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                              CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                              Priority,Previous_Status__c,PO_IndrizoCal__c,OwnerId,PO_Durata_affitto__c, CreatedDate, CreatedById , PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                              from case where parentId=:parentCaseObj.id
                              order by CreatedDate ASC];
                opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Numero_Anni__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentCaseObj.id and PO_Collegamento__c = null limit 1];
                //   oppty = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Numero_Anni__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentCaseObj.id and PO_Collegamento__c = null limit 1];
                //  system.debug('value========'+oppty.PO_Numero_Anni__c);
                if(ChildCases.size()>0)
                {
                    ordercaselst = [select id,status,PO_Comune2__c,EOF_Comunicazioni_con_OLO__c,Note_Sospensione_Operatore__c,PO_Durata_mesi__c,PO_Case_Collegamento__r.PO_IndrizoCal__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
                                    PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                    PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Case_Collegamento__r.parent.PO_isDataOrder__c, PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                    recordtype.id,recordtype.developerName,OwnerId from case where PO_Case_Collegamento__c IN : ChildCases];
                    
                }
                list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentCaseObj.id AND IsPrivate = false AND Name LIKE '%PDF%'
                                           ORDER BY createddate DESC limit 1];
                system.debug('newlst---'+newlst);
                for(attachment att : newlst )
                {
                    String attnamenew = att.Name;
                    
                    if(attnamenew.contains('.pdf'))
                    {
                        newAtt.add(att);
                        system.debug('Attachment==='+newAtt);
                    }
                }
                
                list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentCaseObj.id
                                               ORDER BY createddate DESC];
                for(attachment att : attlstnew )
                {
                    
                    string attname = att.Name;
                    system.debug('Attachment==='+att.Name);
                    // if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))
                    
                    if(attname.containsIgnoreCase('.pdf'))
                    {
                        
                        attlst.add(att);
                        
                        system.debug('Attachment==='+attlst);
                        
                    }
                    
                }
                if(attlst.size()>1)
                {
                    attlst.remove(0);
                }
                
                list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentCaseObj.id AND IsPrivate = false
                                               ORDER BY createddate DESC];
                for(attachment att : newlstxlxs )
                {
                    String attnamexlxs = att.Name;
                    
                    if(attnamexlxs.contains('.xlsx'))
                    {
                        attxlxs.add(att);
                        system.debug('Attachment==='+attxlxs);
                    }
                }
                
            }
        }
        idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + idquote);
        if(idQuote!= null && idQuote.contains('0Q0')){
            q = [select id, name, Opportunity.name, account.name,
                 Account.BillingStreet,Account.BillingCity,
                 Account.BillingState,Account.BillingPostalCode,
                 PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,Opportunity.PO_Durata_affitto__c,
                 PO_ContaPDF__c
                 from Quote
                 where id = :idquote];
            
            RichiestaFattibil = q.Opportunity.PO_Richiesta_fattibilit__c;
            system.debug('DG_PDF_q: ' + q);
            //CRM 24_08 INIZIO
            FindAnnoFiberLink();
            //FINE
            
            opp1 = getOpportunity();
            system.debug('DG_PDF_opp: ' + opp1);
            
            
            finalstr = 'Ns. Rif.:' + opp1.PO_Richiesta_fattibilit__r.casenumber + '<br/>' + 'Dettagli Collegamento e Offerta';
            
            /**PRIMA TABELLA**/
            
            string str;
            //Fiber Link
            if(checkFibLink == true)
                str = Tabella1FiberLink(opp1);
            
            
            system.debug('DG_OF_CreateQuoteXLS_Controller str: ' + str);
            finalstr = finalstr + str ;
            
            /**END PRIMA TABELLA**/
            
            /**MESSAGGI**/
            if(str == null)
            {
                checkEmpty = true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Non ci sono dati disponibili per questa quote! Non puoi creare l\'xls.');
                ApexPages.addMessage(myMsg);
                return;
            }else
            {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Puoi creare l\'xls. <br/> L\'xls si troverà nella sezione Notes & Attachments della quote');
                ApexPages.addMessage(myMsg);
            }
            /**END MESSAGGI**/
            
            /**TABELLA DATI TOPONOMASTICI**/
            string str1 = '<br/><br/>Dati toponomastici<br/>' + TabellaDatiToponomastici(opp1);
            system.debug('DG_OF_CreateQuoteXLS_Controller str1: ' + str1);
            finalstr = finalstr + str1;
            /**END TABELLA DATI TOPONOMASTICI**/
            
            
            /**TABELLA DATI METRICI**/
            string str2 = '<br/>Dati metrici<br/>' + TabellaDatiMetrici(opp1);
            finalstr = finalstr + str2;
            /**END TABELLA DATI METRICI**/
            
            
            /**TABELLA DETTAGLIO OFFERTA**/
            if(!checkFibLease && !checkFibLeaseMisto)
            {
                string str3 = '<br/>Dettaglio offerta<br/>' + TabellaDettaglioOfferta(opp1);
                finalstr = finalstr + str3;
            }
            /**END TABELLA DETTAGLIO OFFERTA**/
            
            system.debug('DG_OF_CreateQuoteXLS_Controller finalstr: ' + finalstr);
            xlsxBlob = Blob.valueOf(finalstr);
            xlsxname= q.Name + '.xls';
        }
        
    }
    //Strat-Added by Sasya on 05-10-2017
    public String sortField1
    {
        get
        {
            if (sortField1 == null)
            {
                sortField1 = 'CaseNumber';
            }
            return sortField1;
        }
        set;
    }
    
    public String sortField2
    {
        get
        {
            if (sortField2 == null)
            {
                sortField2 = 'EOF_Codice_Ordine_OLO__c ';
            }
            return sortField2;
        }
        set;
    }
    
    
    
    public String sortField3
    {
        get
        {
            if (sortField3 == null)
            {
                sortField3 = 'EOF_Codice_Comunicazione_OLO__c';
            }
            return sortField3;
        }
        set;
    }
    
    //PG - 5/04 - START
    public String CodiceOrdTP
    {
        get
        {
            if (CodiceOrdTP == null)
            {
                CodiceOrdTP = 'PO_TP_Codice_Ordine_Ticket_Provisioning__c';
            }
            return CodiceOrdTP;
        }
        set;
    }
    //PG - END
    
    // format the soql for display on the visualforce page
    //   public String debugSoql
    //  {
    //   get
    //   {
    //       return soql + ' order by ' + sortField1 + ' ' + sortDir + 'Limit 20';
    //   }
    //   set;
    //}
    
    public void runQuery()
    {
        try {
            setCon=new ApexPages.StandardSetController( Database.query(soql + ' order by ' + sortField1 + ' ' + sortDir+ ' limit 49999'));
            //Cases = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 49999');
            setCon.setpageSize(25);
            Cases=setCon.getRecords();
            system.debug('CaseQuery======'+Cases);
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    
    public void runQueryOpenStream()
    {
        
        try {
            setConOpen=new ApexPages.StandardSetController( Database.query(soql + ' order by ' + sortField2 + ' ' + sortDir+ ' limit 49999'));
            //Cases = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 49999');
            setConOpen.setpageSize(25);
            EOFOpenStream=setConOpen.getRecords();
            system.debug('OpenStreamQuery'+EOFOpenStream);
            
        } catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
        
    }
    
    //EC 2018 - 07 - 20 start  runQueryP2PAttiva as is runQueryOpenStream //EC TO DO verifica sortField2 e sortDir
    public void runQueryP2PAttiva(){
        try {
            setConP2PAttiva=new ApexPages.StandardSetController( Database.query(soql + ' order by ' + sortField2 + ' ' + sortDir+ ' limit 49999'));
            //Cases = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 49999');
            setConP2PAttiva.setpageSize(25);
            P2PAttivaLogList=setConP2PAttiva.getRecords();
            system.debug('OpenStreamQuery'+P2PAttivaLogList);
        } 
        catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    //EC 2018 - 07 - 20 end  runQueryP2PAttiva
    
    public void runQueryTroubleTicket()
    {
        try {
            setConTT=new ApexPages.StandardSetController( Database.query(soql + ' order by ' + sortField3 + ' ' + sortDir+ ' limit 49999'));
            //Cases = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 49999');
            setConTT.setpageSize(25);
            EOFTroubleTicket=setConTT.getRecords();
            system.debug('OpenStreamQuery'+EOFTroubleTicket);
            
        } catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    
    //PG - 5/04 - START
    public void runQueryTicketProv()
    {
        //System.debug('***RunQueryTicketProv - PRIMA DEL TRY**');
        try {
            setCon = new ApexPages.StandardSetController( Database.query(soql + ' order by '
                                                                         + CodiceOrdTP + ' ' + sortDir+ ' limit 49999'));
            setCon.setpageSize(25);
            Cases = setCon.getRecords();
            system.debug('@@@list_caseTP'+Cases);
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    //PG - END
    
    public String transformDate(String dateToFormat)
    {
        if (!dateToFormat.equals(''))
        {
            string formattedDate;
            List<string> holder = dateToFormat.split('/');
            // handles alternate ('-') date divider
            if (holder.size() == 1) { holder = dateToFormat.split('-'); }
            // allows date parts to be entered without leading '0'
            if (holder[0].length() == 1) { holder[0] = '0' + holder[0]; }
            if (holder[1].length() == 1) { holder[1] = '0' + holder[1]; }
            formattedDate = holder[0] + '-' + holder[1] + '-' + holder[2];
            return formattedDate;
        }
        return '';
    }
    
    
    // 2018-09-18 MM : aggiunta metodo per fare il check sul formato della Date
    /* public static boolean checkDate(String S){
if(String.isBlank(s)){
return false;
}

Date.valueOf(s);
if(s.split('-').get(0).isNumeric() && Integer.valueOf(s.split('-').get(0))<2016){
return false;
}

return true;
} */   
    
    public void Offertaselect(){
        String Offerta1= Apexpages.currentPage().getParameters().get('Offerta');
        //if(Offerta1==null && Offerta1==''){
        //     Offerta1= Apexpages.currentPage().getParameters().get('off');
        // }
        system.debug('l\'offerta del metodo Offertaselected è ' + Offerta1);
        offertaSelected=Offerta1;
        // Cases=[select Casenumber, Status,OwnerId, CreatedDate,PO_Tipo_di_collegamento__c,PO_Prime_Contractor__c,PO_Tipologia_Offerta_ordine__c,PO_Tipologia_Offerta__c ,PO_Offerta__c,PO_CreatedDate__c,PO_Case_Type_Formula__c,PO_Nome_Comune__c,PO_Nome_Progetto__c from Case where PO_Case_Type_Formula__c = null ];
        soql = 'select Casenumber,contact.accountid,Status,PO_Case_Type_Formula__c,PO_Tipo_di_collegamento__c,PO_Tipologia_Offerta_ordine__c,PO_Tipologia_Offerta__c ,PO_CreatedDate__c,PO_Offerta__c, CreatedDate,PO_Prime_Contractor__c,PO_Nome_Comune__c,PO_Nome_Progetto__c,OwnerId from Case where PO_Case_Type_Formula__c = null ';
        StatoSelected = '';
        runQuery();
        system.debug('Selected Offerta '+OffertaSelected);
        // return null;
    }
    
    // runs the search with parameters passed via Javascript
    public PageReference runSearch()
    {   // EOFTroubleTicket=new List<EOF_EAI_Service_Log__c>();
        // EOFOpenStream=new List<EOF_EAI_Service_Log__c>();
        String Offerta1= Apexpages.currentPage().getParameters().get('Offerta');
        offertaSelected=Offerta1;
        
        system.debug('giovanni offertaselcted: ' + OffertaSelected);
        
        if(OffertaSelected!= 'OpenStream')
        {
            Id usrid=userinfo.getuserid();
            system.debug('Testing++++'+ Apexpages.currentPage().getParameters().get('CaseNumber'));
            String Casenumber= Apexpages.currentPage().getParameters().get('Casenumber');
            String Status= Apexpages.currentPage().getParameters().get('Status');
            
            String CreatedDate=  Apexpages.currentPage().getParameters().get('DataInizioCreazione');
            String CreatedDate1=  Apexpages.currentPage().getParameters().get('DataFineCreazione');
            system.debug('CreatedDate======'+Apexpages.currentPage().getParameters().get('DataInizioCreazione'));
            system.debug('DatePicker'+CreatedDate.split('T')[0]);
            system.debug('DatePicker'+CreatedDate1);
            String Commune= Apexpages.currentPage().getParameters().get('Commune');
            String Nome= Apexpages.currentPage().getParameters().get('Nome');
            String Tipodicollegamento = Apexpages.currentPage().getParameters().get('Tipodicollegamento');
            String PrimeContractor = Apexpages.currentPage().getParameters().get('PrimeContractor');
            
            String Indirizzo1 = Apexpages.currentPage().getParameters().get('Indirizzo1');
            
            String tipodi= Apexpages.currentPage().getParameters().get('tipodi');
            String tipodi1= Apexpages.currentPage().getParameters().get('tipodi1');
            offertaSelected=Offerta1;
            
            StatoSelected = Tipodicollegamento;
            getStatoilist();
            system.debug('CreatedDate======'+offertaSelected);
            
            soql = 'select Casenumber,contact.accountid,Status,PO_Case_Type_Formula__c,PO_Tipo_di_collegamento__c,PO_Tipologia_Offerta_ordine__c,PO_Tipologia_Offerta__c ,PO_CreatedDate__c,PO_Offerta__c, CreatedDate,PO_Prime_Contractor__c,PO_Nome_Comune__c,PO_Nome_Progetto__c,OwnerId from Case where CaseNumber != null ';
            soql += ' and accountid =\''+ usr.contact.accountid+'\'';
            
            if (!Casenumber.equals(''))
                soql += ' and Casenumber LIKE \''+String.escapeSingleQuotes(Casenumber)+'%\'';
            if (!Status.equals('')&&!Status.equals('--Select--'))
                soql += ' and Status LIKE \''+String.escapeSingleQuotes(Status)+'%\'';
            
            if (!CreatedDate.equals(''))
                soql += ' and PO_CreatedDate__c  >=\''+ String.escapeSingleQuotes(CreatedDate )+'\'';
            //soql += ' and EOF_CreatedDate_FORMULA__c >=\''+ String.escapeSingleQuotes(CreatedDate )+'\'';
            if (!CreatedDate1.equals(''))
                soql += ' and PO_CreatedDate__c  <=\''+ String.escapeSingleQuotes(CreatedDate1 )+'\'';
            if (!Commune.equals(''))
                soql += ' and PO_Nome_Comune__c LIKE \''+String.escapeSingleQuotes(Commune)+'%\'';
            if (!Nome.equals(''))
                soql += ' and PO_Nome_Progetto__c LIKE \''+String.escapeSingleQuotes(Nome)+'%\'';
            if (!Tipodicollegamento.equals('')&& !Tipodicollegamento.equals('--Select--'))
            {
                soql += ' and PO_Case_Type_Formula__c LIKE \''+String.escapeSingleQuotes(Tipodicollegamento)+'%\'';
                offertaCheck = Tipodicollegamento;
                if(Tipodicollegamento.equals('Richieste')){
                    tipodi1='';
                    // offertaSelected='';
                    if (!Offerta1.equals('') && !offerta1.equals('--Select--')){
                        soql += ' and PO_Offerta__c = \''+String.escapeSingleQuotes(Offerta1)+'\'';
                    }
                }
                if(Tipodicollegamento.equals('Collegamento')){
                    if (!Offerta1.equals('') && !offerta1.equals('--Select--'))
                        soql += ' and PO_Tipologia_Offerta__c LIKE \''+String.escapeSingleQuotes(Offerta1)+'%\'';
                }
                if(Tipodicollegamento.equals('Ordine')){
                    
                    if (!Offerta1.equals('') && !offerta1.equals('--Select--'))
                        soql += ' and PO_Tipologia_Offerta_ordine__c LIKE \''+String.escapeSingleQuotes(Offerta1)+'%\'';
                }
                
            }
            if (!PrimeContractor.equals(''))
                soql += ' and PO_Prime_Contractor__c LIKE \''+String.escapeSingleQuotes(PrimeContractor)+'%\'';
            
            if (!Indirizzo1.equals(''))
                soql += ' and PO_Indirizzo_collegamento__c LIKE \''+String.escapeSingleQuotes(Indirizzo1)+'%\'';
            
            
            if (!tipodi1.equals('')&& !tipodi1.equals('--Select--')){
                soql += ' and PO_Tipo_di_collegamento__c = \''+String.escapeSingleQuotes(tipodi1)+'\'';
            }
            
            if(Casenumber.equals('') &&(Status.equals('')||Status.equals('--Select--'))&&CreatedDate.equals('')&&Commune.equals('')&&CreatedDate1.equals('')
               && Nome.equals('')&&(Tipodicollegamento.equals('')||Tipodicollegamento.equals('--Select--'))&&(Offerta1.equals('') || offerta1.equals('--Select--'))
               && PrimeContractor.equals('')&&Indirizzo1.equals('')&&(tipodi1.equals('')||tipodi1.equals('--Select--')))
            {
                soql += ' and Casenumber LIKE \''+null+'%\'';
            }
            
            // run the query again
            runQuery();
        }
        return null;
        
    }
    //EC P2P Attiva Search Request 2018 - 08 - 07
    Public PageReference runSearchP2PATT(){
        // EOFTroubleTicket=new List<EOF_EAI_Service_Log__c>();
        
        string Codice=Apexpages.currentPage().getParameters().get('Codice');
        system.debug('CreatedDate123======'+Codice);
        string TipoRichiesta=Apexpages.currentPage().getParameters().get('TipoRichiesta');
        string StatoRichiesta=Apexpages.currentPage().getParameters().get('StatoRichiesta');
        string idPop=Apexpages.currentPage().getParameters().get('idPop');
        string idRisorsa= Apexpages.currentPage().getParameters().get('idRisorsa');
        string NotifiedDate1=  Apexpages.currentPage().getParameters().get('DataInizioFilter');
        string NotifiedDate2=  Apexpages.currentPage().getParameters().get('DataFineFilter');
        String CreatedDate1=   Apexpages.currentPage().getParameters().get('DataInizioP2PAtt');
        String CreatedDate2 =  Apexpages.currentPage().getParameters().get('DataFineP2PAtt');
        system.debug('StatoRichiesta======'+StatoRichiesta);
        //EC commentiamo per SearchRequest verificare la query. al momento non estrae e non mostra i dati a video 2018 - 08 - 07     
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        soql = 'select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,'
            +'EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
            +'EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,'
            +'EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,'
            +'EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,'
            +'OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,'
            +'OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,'
            +'EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c '
            +' from EOF_EAI_Service_Log__c where recordType.developerName=\'PO_P2PAttiva_Request\'AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
            +' and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\'  ';
        
        if (!Codice.equals(''))
        {
            soql += ' and EOF_Codice_Ordine_OLO__c LIKE \''+String.escapeSingleQuotes(Codice)+'%\' ';
        }
        if (!TipoRichiesta.equals('')&& !TipoRichiesta.equals('--Select--'))
        {
            soql += ' and EOF_Tipo_Comunicazione_String__c =\''+String.escapeSingleQuotes(TipoRichiesta)+'\' ';
        }
        if (!StatoRichiesta.equals('')&& !StatoRichiesta.equals('--Select--'))
        {
            soql += ' and EOF_STATO_ORDINE__c =\''+String.escapeSingleQuotes(StatoRichiesta)+'\' ';
        }
        if (!idPop.equals('')&& !idPop.equals('--Select--'))
        {
            soql += ' and EOF_ID_Pop__c LIKE\''+String.escapeSingleQuotes(idPop)+'%\' ';
        }
        if (!idRisorsa.equals(''))
        {
            soql += ' and EOF_ID_Risorsa__c LIKE\''+String.escapeSingleQuotes(idRisorsa)+'%\' ';
        }
        if (!NotifiedDate1.equals('')){
            soql += ' and EOF_Data_Notifica__c  >='+ NotifiedDate1;
        }
        if (!NotifiedDate2.equals(''))
        {
            soql += ' and EOF_Data_Notifica__c  <='+ NotifiedDate2;
        }
        if (!CreatedDate1.equals(''))
        {
            soql += ' and PO_SA_Data_Inserimento_Ordine__c  >=' +CreatedDate1 ;
        }
        if (!CreatedDate2.equals(''))
        {
            soql += ' and PO_SA_Data_Inserimento_Ordine__c  <='+ CreatedDate2;
        }
        
        System.debug('SOQL Error'  + soql);
        runQueryP2PAttiva();
        
        return null;
        
    }
    // End EC P2P Attiva Search Request 2018 - 08 - 07 
    
    Public PageReference runSearchOpenStream(){
        // EOFTroubleTicket=new List<EOF_EAI_Service_Log__c>();
        
        string Codice=Apexpages.currentPage().getParameters().get('Codice');
        system.debug('CreatedDate123======'+Codice);
        string TipoRichiesta=Apexpages.currentPage().getParameters().get('TipoRichiesta');
        string StatoRichiesta=Apexpages.currentPage().getParameters().get('StatoRichiesta');
        string idPop=Apexpages.currentPage().getParameters().get('idPop');
        string idRisorsa= Apexpages.currentPage().getParameters().get('idRisorsa');
        string NotifiedDate1=  Apexpages.currentPage().getParameters().get('DataInizioFilter');
        string NotifiedDate2=  Apexpages.currentPage().getParameters().get('DataFineFilter');
        String CreatedDate1=   Apexpages.currentPage().getParameters().get('DataInizioOStream');
        String CreatedDate2 =  Apexpages.currentPage().getParameters().get('DataFineOstream');
        system.debug('StatoRichiesta======'+StatoRichiesta);
        
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        soql = 'select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,'
            +'EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
            +'EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,'
            +'EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,'
            +'EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,'
            +'OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,'
            +'OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,'
            +'EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c '
            +' from EOF_EAI_Service_Log__c where ( recordType.developerName=\'PO_SA_FiberRequest\' OR recordType.developerName=\'PO_CO_FiberRequest\') AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
            +' and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\'  ';
        
        if (!Codice.equals(''))
        {
            soql += ' and EOF_Codice_Ordine_OLO__c LIKE \''+String.escapeSingleQuotes(Codice)+'%\' ';
        }
        if (!TipoRichiesta.equals('')&& !TipoRichiesta.equals('--Select--'))
        {
            soql += ' and EOF_Tipo_Comunicazione_String__c =\''+String.escapeSingleQuotes(TipoRichiesta)+'\' ';
        }
        if (!StatoRichiesta.equals('')&& !StatoRichiesta.equals('--Select--'))
        {
            soql += ' and EOF_STATO_ORDINE__c =\''+String.escapeSingleQuotes(StatoRichiesta)+'\' ';
        }
        if (!idPop.equals('')&& !idPop.equals('--Select--'))
        {
            soql += ' and EOF_ID_Pop__c LIKE\''+String.escapeSingleQuotes(idPop)+'%\' ';
        }
        if (!idRisorsa.equals(''))
        {
            soql += ' and EOF_ID_Risorsa__c LIKE\''+String.escapeSingleQuotes(idRisorsa)+'%\' ';
        }
        if (!NotifiedDate1.equals('')){
            soql += ' and EOF_Data_Notifica__c  >='+ NotifiedDate1;
        }
        if (!NotifiedDate2.equals(''))
        {
            soql += ' and EOF_Data_Notifica__c  <='+ NotifiedDate2;
        }
        if (!CreatedDate1.equals(''))
        {
            soql += ' and PO_SA_Data_Inserimento_Ordine__c  >=' +CreatedDate1 ;
        }
        if (!CreatedDate2.equals(''))
        {
            soql += ' and PO_SA_Data_Inserimento_Ordine__c  <='+ CreatedDate2;
        }
        
        System.debug('SOQL Error'  + soql);
        runQueryOpenStream();
        
        return null;
        
    }
    
    
    Public PageReference runSearchTroubleTicket(){
        
        string Comunicazione=Apexpages.currentPage().getParameters().get('Comunicazione');
        system.debug('CreatedDate123======'+Comunicazione);
        string Causale=Apexpages.currentPage().getParameters().get('Causale');
        string Stato=Apexpages.currentPage().getParameters().get('Stato');
        String DataInizio = Apexpages.currentPage().getParameters().get('DataInizioTT');
        String DataFine = Apexpages.currentPage().getParameters().get('DataFineTT');
        /* String CreatedDate1=   Apexpages.currentPage().getParameters().get('DataInizioOStream');
String CreatedDate2 =  Apexpages.currentPage().getParameters().get('DataFineOstream');*/
        system.debug('CreatedDate123TT======'+DataInizio );
        
        soql = 'Select id,RecordType.name,EOF_Codice_Comunicazione_OLO__c,EOF_Causale_Apertura__c,EOF_Stato_Richiesta__c, EOF_Data_Notifica__c, EOF_Codice_Ordine_OLO__c,EOF_STATO_ORDINE__c, CreatedDate from EOF_EAI_Service_Log__c where recordtype.DeveloperName = \'PO_TT_TroubleTicketRequest\' and EOF_Stato_Richiesta__c != \'Bozza\'';
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        soql += 'and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c  + '\' ';
        
        if (!Comunicazione.equals(''))
        {
            soql += ' and EOF_Codice_Comunicazione_OLO__c LIKE \''+String.escapeSingleQuotes(Comunicazione)+'%\' ';
        }
        if (!Causale.equals('')&& !Causale.equals('--Select--'))
        {
            soql += ' and EOF_Causale_Apertura__c  =\''+String.escapeSingleQuotes(Causale)+'\' ';
        }
        if (!Stato.equals('') && !Stato.equals('--Select--'))
        {
            soql += ' and EOF_STATO_ORDINE__c Like \''+String.escapeSingleQuotes(Stato)+'%\' ';
        }
        if (!DataInizio.equals(''))
        {
            soql += ' and CreatedDate >='+DataInizio;
        }
        if (!DataFine.equals(''))
        {
            soql += ' and CreatedDate <='+DataFine;
        }
        
        runQueryTroubleTicket();
        return null;
    }
    
    //ADD FIX PG 3-05 - START
    public PageReference runSearchTicketProv()
    {
        System.debug('***RunSearchTicketProv***');
        
        RecordType rtNameTP = [SELECT Id,name
                               FROM RecordType
                               WHERE Name = 'PO - TP - TicketProvisioning Case' limit 1];
        
        String causale_apertura = Apexpages.currentPage().getParameters().get('causale_apertura');
        String descr_causale = Apexpages.currentPage().getParameters().get('descr_causale');
        String codice_ordine = Apexpages.currentPage().getParameters().get('codice_ordine');
        String stato_ordine = Apexpages.currentPage().getParameters().get('stato_ordine');
        String escalation = Apexpages.currentPage().getParameters().get('escalation');
        String DataInizio = Apexpages.currentPage().getParameters().get('DataInizioTP');
        String DataFine = Apexpages.currentPage().getParameters().get('DataFineTP');
        
        soql = 'Select id,casenumber,RecordType.name, EOF_Codice_Operatore_WS__c,CreatedDate, PO_TP_Codice_Ordine_Ticket_Provisioning__c,PO_TP_Causale_Apertura_Segnalazione__c, PO_TP_Descrizione_Causale__c, PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Escalation__c'
            + ' from Case where RecordType.id =\'' + rtNameTP.id + '\'  ';
        
        User current_user =[select Id,Account.EOF_Codice_Operatore__c, contact.account.name
                            from user
                            where Id=:userinfo.getUserId()];
        
        soql += 'and EOF_Codice_Operatore_WS__c = \'' + current_user.Account.EOF_Codice_Operatore__c  + '\' ';
        
        System.debug('**CAUSALE APERTURA SEGNALAZIONE***:'+causale_apertura);
        
        if (!causale_apertura.equals('')&& !causale_apertura.equals('--Select--'))
        {
            soql += ' and PO_TP_Causale_Apertura_Segnalazione__c  =\''+String.escapeSingleQuotes(causale_apertura)+'\' ';
        }
        
        if(causale_apertura.equalsIgnoreCase('Segnalazione Provisioning'))
        {
            if (!codice_ordine.equals('') && !codice_ordine.equals('--Select--'))
            {
                soql += ' and PO_TP_Codice_Ordine_Ticket_Provisioning__c = \''+String.escapeSingleQuotes(codice_ordine)+'\' ';
            }
            if (!stato_ordine.equals('') && !stato_ordine.equals('--Select--'))
            {
                soql += ' and PO_TP_Stato_Ordine_Ticket_Provisioning__c = \''+String.escapeSingleQuotes(stato_ordine)+'\' ';
            }
        }
        if(causale_apertura.equalsIgnoreCase('Problema tecnico/applicativo'))
        {
            soql += ' and TP_Codice_Operatore_Esteso__c = \'' +current_user.contact.account.name + '\' ';
        }
        System.debug('***Stato Ordine***: '+stato_ordine);
        
        if (!descr_causale.equals('') && !descr_causale.equals('--Select--'))
        {
            soql += ' and PO_TP_Descrizione_Causale__c = \''+String.escapeSingleQuotes(descr_causale)+'\' ';
        }
        System.debug('@@@_ESCALATION_@@@ '+escalation);
        if (escalation.equals('true') && escalation!=null) // se la checkbox è flaggata
        {
            soql += ' and PO_TP_Escalation__c = '+escalation;
        }
        if (!DataInizio.equals(''))
        {
            soql += ' and CreatedDate >='+DataInizio;
        }
        if (!DataFine.equals(''))
        {
            soql += ' and CreatedDate <='+DataFine;
        }
        
        runQueryTicketProv();
        return null;
    }
    //PG - FIX - 3-05 - END
    public List<String> listaOption{get;set;}
    public boolean showList {get;set;}
    public List<SelectOption> getOpenStatolist()
    { 
        showList=false;
        listaOption = new List<String>();               
        string TipoRichiesta=Apexpages.currentPage().getParameters().get('TipoRichiesta');
        
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        List<EOF_EAI_Service_Log__c> selList= new List<EOF_EAI_Service_Log__c>();
        List<SelectOption> options = new List<SelectOption>();
        selList=[select id,EOF_STATO_ORDINE__c from EOF_EAI_Service_Log__c where  recordType.developerName='PO_SA_FiberRequest' AND EOF_Stato_Richiesta__c='Inserita Portale' and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c];
        Set<String> sl=new Set<String>();
        options.add(new SelectOption('--Select--','--Select--'));
        if('Change Order'.equals(TipoRichiesta)){
            showList=true; 
            system.debug('siamo dentro');
            listaOption.add('--Select--');
            listaOption.add('Modificato OK');
            listaOption.add('Modificato KO');
            
            options.add(new SelectOption('Modificato OK','Modificato OK'));
            options.add(new SelectOption('Modificato KO','Modificato KO'));
        }
        
        
        
        for(EOF_EAI_Service_Log__c ef:selList)
        {
            
            if(ef.EOF_STATO_ORDINE__c != null && ef.EOF_STATO_ORDINE__c != '')
            {
                sl.add(ef.EOF_STATO_ORDINE__c );
                
            }
            
            
        }
        for(string st:sl)
        {
            options.add(new SelectOption(st,st));
            
        }
        system.debug('Options******' + options);
        return options;
    }
    
    public List<SelectOption> getIDPoplist()
    {
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        List<EOF_EAI_Service_Log__c> selList= new List<EOF_EAI_Service_Log__c>();
        List<SelectOption> options = new List<SelectOption>();
        selList=[select id,EOF_ID_Pop__c from EOF_EAI_Service_Log__c where  recordType.developerName='PO_SA_FiberRequest' AND EOF_Stato_Richiesta__c='Inserita Portale' and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c];
        Set<String> sl=new Set<String>();
        options.add(new SelectOption('--Select--','--Select--'));
        for(EOF_EAI_Service_Log__c ef:selList)
        {
            if(ef.EOF_ID_Pop__c != null && ef.EOF_ID_Pop__c != '')
            {
                sl.add(ef.EOF_ID_Pop__c);
            }
        }
        for(string st:sl)
        {
            options.add(new SelectOption(st,st));
        }
        
        return options;
    }
    
    public List<SelectOption> getStatoOrdinelist()
    {
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        List<EOF_EAI_Service_Log__c> selList= new List<EOF_EAI_Service_Log__c>();
        List<SelectOption> options = new List<SelectOption>();
        selList=[select id,EOF_STATO_ORDINE__c from EOF_EAI_Service_Log__c where  recordType.developerName='PO_TT_TroubleTicketRequest' AND EOF_Stato_Richiesta__c!='Bozza' and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c];
        Set<String> sl=new Set<String>();
        options.add(new SelectOption('--Select--','--Select--'));
        for(EOF_EAI_Service_Log__c ef:selList)
        {
            if(ef.EOF_STATO_ORDINE__c != null && ef.EOF_STATO_ORDINE__c != '')
            {
                sl.add(ef.EOF_STATO_ORDINE__c );
            }
        }
        for(string st:sl)
        {
            options.add(new SelectOption(st,st));
        }
        
        return options;
    }
    
    public List<SelectOption> getCasualelist()
    {
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        List<EOF_EAI_Service_Log__c> selList= new List<EOF_EAI_Service_Log__c>();
        List<SelectOption> options = new List<SelectOption>();
        selList=[select id,EOF_Causale_Apertura__c from EOF_EAI_Service_Log__c where  recordType.developerName='PO_TT_TroubleTicketRequest' AND EOF_Stato_Richiesta__c!='Bozza' and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c];
        Set<String> sl=new Set<String>();
        String str;
        options.add(new SelectOption('--Select--','--Select--'));
        for(EOF_EAI_Service_Log__c ef:selList)
        {
            if(ef.EOF_Causale_Apertura__c!= null && ef.EOF_Causale_Apertura__c!= '')
            {
                sl.add(ef.EOF_Causale_Apertura__c);
            }
        }
        for(string st:sl)
        {
            if(st=='1')
            {
                str='Connettività non disponibile';
            }
            if(st=='2')
            {
                str='Connessione instabile';
            }
            if(st=='3')
            {
                str='Lentezza di navigazione';
            }
            if(st=='4')
            {
                str='Mai Navigato';
            }
            options.add(new SelectOption(st,str));
        }
        
        return options;
    }
    
    //PG 5-04 - START
    public List<SelectOption> getCausaleAperturaItems() {
        
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('--Select--','--Select--'));
        if(offertaSelected=='Segnalazione Provisioning'){
            options.add(new SelectOption('Segnalazione Provisioning','Segnalazione Provisioning'));
        }
        if(offertaSelected=='Problema tecnico/applicativo'){
            options.add(new SelectOption('Problema tecnico/applicativo','Problema tecnico/applicativo'));
        }
        return options;
    }
    //END
    
    //PG 5-04 - START
    public List<SelectOption> getDescrCausaleItems() {
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--Select--','--Select--'));
        if(offertaSelected=='Segnalazione Provisioning')
        {
            options.add(new SelectOption('Sollecito','Sollecito'));
            //options.add(new SelectOption('Richiesta Informazioni','Richiesta Informazioni'));
        }
        if(offertaSelected=='Problema tecnico/applicativo')
        {
            //options.add(new SelectOption('Richiesta Informazioni','Richiesta Informazioni'));
            options.add(new SelectOption('Nuova Segnalazione','Nuova Segnalazione'));
        }
        return options;
    }
    //END
    
    //FIX PG 03-05 - START
    public List<SelectOption> getStatoOrdineTP_items() {
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--Select--','--Select--'));
        options.add(new SelectOption('Acquisito','Acquisito'));
        options.add(new SelectOption('Accettato','Accettato'));
        options.add(new SelectOption('Sospeso','Sospeso'));
        return options;
    }
    //FIX PG 03-05 - END
    
    public List<SelectOption> getStatoilist()
    {
        system.debug('StatoSelected'+StatoSelected);
        if(StatoSelected.equals('')||StatoSelected.equals('--Select--')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            return options;
        }
        if(StatoSelected.equals('Richieste')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Bozza','Bozza'));
            options.add(new SelectOption('Acquisito','Acquisito'));
            options.add(new SelectOption('In Lavorazione','In Lavorazione'));
            options.add(new SelectOption('In approvazione Cliente','In approvazione Cliente'));
            options.add(new SelectOption('Accettato','Accettato'));
            return options;
        }
        if(StatoSelected.equals('Collegamento')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Bozza','Bozza'));
            options.add(new SelectOption('Acquisito','Acquisito'));
            options.add(new SelectOption('In Lavorazione','In Lavorazione'));
            options.add(new SelectOption('Annullato','Annullato'));
            options.add(new SelectOption('Sospeso','Sospeso'));
            options.add(new SelectOption('Completato','Completato'));
            return options;
        }
        if(StatoSelected.equals('Ordine')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Accettato','Accettato'));
            options.add(new SelectOption('In Lavorazione','In Lavorazione'));
            options.add(new SelectOption('Annullato','Annullato'));
            options.add(new SelectOption('Sospeso','Sospeso'));
            options.add(new SelectOption('Espletato','Espletato'));
            options.add(new SelectOption('Espletato KO','Espletato KO'));
            return options;
        }
        return null;
    }
    public List<SelectOption> getTipodilist() {
        if(offertaSelected.equals('')||offertaSelected.equals('--Select--')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            return options;
        }
        if(offertaSelected.equals('P2P Base')){
            
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Point-to-Point','Point-to-Point'));
            return options;
        }
        //EC start 2018 - 07 - 17 
        if(offertaSelected.equals('P2P Attiva')){
            System.debug('@@@@@@EC ....siamo nell\'if della P2P Attiva di offertaSelected ');
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Singola Via','Singola Via'));
            options.add(new SelectOption('Doppia via','Doppia via'));
            return options;
        }
        //EC end 2018 - 07 - 17
        
        if(offertaSelected.equals('IRU')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Backhauling','Backhauling'));
            options.add(new SelectOption('BTS','BTS'));
            options.add(new SelectOption('P2P – Cliente','P2P – Cliente'));
            options.add(new SelectOption('Dark Fiber','Dark Fiber'));
            return options;
        }
        if(offertaSelected.equals('Fiber Link')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Backhauling','Backhauling'));
            options.add(new SelectOption('BTS','BTS'));
            options.add(new SelectOption('Point-to-Point','Point-to-Point'));
            options.add(new SelectOption('Housing','Housing'));
            options.add(new SelectOption('Anello','Anello'));
            return options;
        }
        if(offertaSelected.equals('Fiber Lease')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('SDH','SDH'));
            options.add(new SelectOption('DWDM','DWDM'));
            options.add(new SelectOption('IP','IP'));
            options.add(new SelectOption('Layer 2','Layer 2'));
            options.add(new SelectOption('NGN','NGN'));
            options.add(new SelectOption('MSAN','MSAN'));
            return options;
        }
        if(offertaSelected.equals('Evento Temporaneo')){
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--Select--','--Select--'));
            options.add(new SelectOption('Backhauling','Backhauling'));
            options.add(new SelectOption('BTS','BTS'));
            options.add(new SelectOption('Point-to-Point','Point-to-Point'));
            options.add(new SelectOption('Housing','Housing'));
            options.add(new SelectOption('Anello','Anello'));
            return options;
        }
        
        return null ;
    }
    
    
    
    public void next()
    {
        if(Cases!= null){
            setCon.next();
            Cases=setCon.getRecords();
        }
    }
    public void first()
    {
        setCon.first();
        Cases=setCon.getRecords();
    }
    public void last()
    { if(Cases!= null){
        Cases=setCon.getRecords();
        setCon.last();
        
    }
    }
    public void previous()
    {
        setCon.previous();
        Cases=setCon.getRecords();
    }
    
    public pagereference searchcases(){
        pagereference redirectparentcasedetailpgref;
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        system.debug('caseId ====='+caseId );
        case caseObj = [SELECT ID,CaseNumber,Status,CreatedDate,PO_CreatedDate__c,PO_Offerta__c,ClosedDate,PO_Note_rifiuto_offerta__c,PO_Note_Modifica_Offerta__c,PO_Nome_Comune__c,PO_Nome_Progetto__c,PO_Case_Type_Formula__c,ownerid  FROM case WHERE ID =: caseId ];
        system.debug('case number======'+caseObj.CaseNumber);
        system.debug('case Type======'+caseObj.PO_Case_Type_Formula__c  );
        
        if(caseObj.PO_Case_Type_Formula__c == 'Richieste')
        {    searchCaseBoolean=true;
         parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                          PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:caseObj.id Limit 1];
         
         
         ParentDate=caseObj.CreatedDate.format('dd/MM/yyyy HH:mm:ss');
         system.debug('CreatedDate====='+ParentDate);
         system.debug('parentCaseObj====='+parentCaseObj);
         return redirectparentcasedetail();
         //return new pagereference('/apex/Po_FeasibilityServicesRequest6?id'+parentCaseObj.id);
         
         
        }
        if(caseObj.PO_Case_Type_Formula__c == 'Collegamento')
        {
            childcasedisplayid = caseObj.id;
            
            return   redirectchildcasedetail();
        }
        if(caseObj.PO_Case_Type_Formula__c == 'Ordine')
        {
            
            return  EditOrderInfo();
        }
        return null;
    }
    //End-Added by Sasya on 05-10-2017
    // toggles the sorting of query from asc<-->desc
    public void toggleSort()
    {
        // simply toggle the direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        // run the query again
        runQuery();
    }
    
    /*
giovanni
public user usr {
get{
return [
Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,
contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c
From User
Where Id =:System.UserInfo.getUserId()
];
}
}
*/
    public user usr {
        get{
            
            if(userIstance == null)
            {
                userIstance = [
                    Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
                    contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
                    contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
                    contact.PO_Servizio_Backhauling__c,Contact.PO_Servizio_Open_Stream_CeD__c, contact.PO_Servizio_GPON_Passiva_CeD__c,
                    contact.PO_Servizio_BTS__c,
                    contact.PO_Servizio_DarkFiber__c,
                    contact.PO_Servizio_Circuiti_Diretti__c,
                    contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,
                    contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c,
                    contact.Product_Availability__c, // Added for CR34 Extension II Abhishek Anand 14122018
                    contact.Segnalazione_Provisioning_SOC__c //For Segnalazione Provisioning SOC
                    From User
                    Where Id =:System.UserInfo.getUserId()];
            }     
            return userIstance;                                    
        }
    }
    
    public boolean isSuperUser {
        get{
            User u =  [Select Contact.PO_Super_User__c From User Where Id =:System.UserInfo.getUserId()];
            return u.Contact.PO_Super_User__c;
            //return false;
        }
    }
    
    public pageReference enbleE(){
        secA = false;
        secB = false;
        secC = false;
        secE = true;
        return null;
    }
    public pageReference enbleF(){
        secA = false;
        secB = false;
        secC = false;
        secF = true;
        return null;
    }
    public pageReference enbleB(){
        secA = false;
        secB = true;
        secC = false;
        secD = false;
        secF  = false;
        secE = false;
        showPage = false;
        //system.debug('Page reg'+ showPage );
        //PageReference pageRef = new PageReference('/apex/PO_Index');
        // pageRef.setRedirect(true);
        //pageRef;
        return null;
    }
    
    public pageReference enbleC(){
        secA = false;
        secB = false;
        secC = true;
        secD = false;
        secF  = false;
        secE = false;
        //TEST AA
        // return new pageReference('/apex/PO_EditContactPage');
        return null;
        //Fine TEST AA
    }
    
    public pageReference enbleD(){
        secA = false;
        secB = false;
        secC = false;
        secD = true;
        return null;
    }
    
    Public PageReference saveCasesFromWeb(){
        try{
            caseObj.Status = Status;
            caseObj.RecordTypeId = PO_RegistrazioneRecordTypeId;
            insert caseObj;
            system.debug('caseObj====='+caseObj);
            // ApexPages.addMessage(
            //     new ApexPages.Message(ApexPages.Severity.Confirm,'Registration process completed'));
            
        }Catch(Exception e){
            System.debug('ERROR:' + e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        
        PageReference regPage = new PageReference('/apex/PO_Index');
        //regPage.getParameters().put('message', 'Registration process completed');
        regPage.setRedirect(true);
        return regPage;
    }
    public pageReference redirectToRegPage(){
        showPage=true;
        system.debug('Page reg Redirect'+ showPage );
        return Page.PO_Registration;
    }
    
    public Pagereference contactInformation(){
        showcon = true;
        System.debug('###'+conId);
        
        contactObj = [Select FirstName,LastName,Name, Email  ,PO_Super_User__c,PO_Servizi_a_fattibilit__c,
                      PO_Servizio_Open_Stream__c,Contact.PO_Servizio_Open_Stream_CeD__c,PO_Servizio_GPON_Passiva_CeD__c,
                      PO_Servizio_Backhauling__c,
                      PO_Servizio_BTS__c,
                      PO_Servizio_DarkFiber__c,
                      PO_Servizio_Circuiti_Diretti__c,
                      PO_Fiber_Lease__c  ,PO_Fiber_Link__c ,PO_IRU__c,
                      PO_Misto_Fiber_Lease_Link_per_Fastweb__c ,PO_P2P_Base__c,PO_Servizio_Trouble_Ticket__c,
                      PO_Servizio_Ticket_Provisioning__c, Po_Servizio_Incident_Management__c, PO_Servizio_KIT__c, PO_P2P_Attiva__c, PO_Change_Order__c
                      From Contact
                      Where Id =:conId Limit 1
                     ];
        
        
        return null;
    }
    
    public pageReference deleteUserContact(){
        System.debug('###'+conId);
        try{
            User Usr = [Select Profile.Name,IsActive,IsPortalEnabled,Contact.Account.Id ,Contact.Id,Contact.Name,Contact.Email,
                        Contact.RecordType.Name,contact.PO_Servizio_Open_Stream__c,Contact.PO_Servizio_Open_Stream_CeD__c, contact.PO_Servizio_GPON_Passiva_CeD__c,
                        contact.PO_Servizio_Backhauling__c,
                        contact.PO_Servizio_BTS__c,
                        contact.PO_Servizio_DarkFiber__c,
                        contact.PO_Servizio_Circuiti_Diretti__c,
                        contact.PO_Servizi_a_fattibilit__c,
                        contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c, 
                        contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c
                        From User
                        Where  Contact.Id =:conId];
            
            if(Usr.IsActive){
                Usr.IsActive = false;
                //u.IsPortalEnabled = false;
            }
            
            Update Usr ;
            
            String recordTypeName = 'PO Partner';
            List<User> cUserList = [Select Profile.Name,IsActive,Contact.Account.Id ,Contact.Id,Contact.Name,Contact.Email,
                                    Contact.RecordType.Name,contact.PO_Servizi_a_fattibilit__c,contact.PO_Servizio_Open_Stream__c,
                                    contact.PO_Servizio_Backhauling__c, Contact.PO_Servizio_Open_Stream_CeD__c, contact.PO_Servizio_GPON_Passiva_CeD__c,
                                    contact.PO_Servizio_BTS__c,
                                    contact.PO_Servizio_DarkFiber__c,
                                    contact.PO_Servizio_Circuiti_Diretti__c,
                                    contact.PO_Servizio_Trouble_Ticket__c,
                                    Contact.PO_Servizio_Ticket_Provisioning__c, contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c
                                    
                                    From User
                                    Where  Contact.Account.Id =:accId AND  Contact.RecordType.Name = : recordTypeName ] ;
            System.debug('cUserList---->'+cUserList);
            
            if(cUserList.size()>0){
                contactUserList = cUserList;
            }
            
            
        }catch(Exception e){
            
            System.debug('error has occured while updating the user'+e.getMessage());
            
        }
        
        return null;
    }
    
    
    public contact enableFeasibilityService
    {
        get
        {
            contactObj = [Select FirstName,LastName,Name, Email  ,PO_Super_User__c,PO_Servizi_a_fattibilit__c,
                          PO_Servizio_Backhauling__c,
                          PO_Servizio_BTS__c,
                          PO_Servizio_DarkFiber__c,
                          PO_Servizio_Circuiti_Diretti__c,
                          PO_Servizio_Trouble_Ticket__c,PO_Servizio_Ticket_Provisioning__c,PO_P2P_Attiva__c, PO_Change_Order__c
                          From Contact Where Id =:usr.contact.id limit 1];
            system.debug('booelan value------->'+contactObj);
            
            return contactObj;
        }
        
    }
    public OF_AreaGeograficaJunction__c getComune()
    {
        system.debug('gecomunefunctionvalue: '+selectedIdComune);
        OF_AreaGeograficaJunction__c ag = [SELECT Id,Name,OF_Comune__c FROM OF_AreaGeograficaJunction__c where id =: selectedIdComune limit 1];
        //OF_AreaGeograficaJunction__c ag = [SELECT Id,Name,OF_Comune__c FROM OF_AreaGeograficaJunction__c where id =: 'selectedIdComune' limit 1];
        return ag;
    }
    public string offerta {get;set;}
    public pagereference ParentCaseRecord(){
        system.debug('@@@@@@@@@EC siamo nel metodo ParentCaseRecord chiamato da PO_RegistrationController, Nome è ' + Nome);   
        //   Nome=''; //EC proviamo a commentare 2018 - 11 - 09
        parentCase = new Case();
        PrntCaseID='';
        system.debug('accId===='+accId);
        parentCase.accountid = accId;
        parentCase.Status = 'Bozza';
        invia = true;
        recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];
        
        parentCase.RecordTypeId = rt.id;
        system.debug('show1===='+show1);
        system.debug('recordOfferta===='+recordOfferta);
        if(show1 == true)
        {
            parentCase.PO_Offerta__c = recordOfferta;
            //parentCase.PO_Offerta__c = 'P2P Base';  //EC  2018 - 11 - 09 commento di prova
        }
        parentCase.OF_canBeDeleted__c=true;
        parentCase.PO_Nome_Progetto__c=Nome;
        insert parentCase;
        prntCaseID=parentCase.Id;
        parentCase.PO_Offerta__c = recordOfferta;//EC 2018 - 11 - 09 prova.
        system.debug('P2PParent===='+PrntCaseID);
        // AA - 23/10/18 Commentato il page reference e aggiunto il nuovo route
        /*pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id );
//pr.setRedirect(true);
return pr;*/
        PageReference pg = new PageReference('/PO_Servizi_Fattibilita_Routing');
        pg.getParameters().put('parentId', ParentCase.id);
        pg.getParameters().put('off',parentCase.PO_Offerta__c); //EC  2018 - 11 - 09
        pg.getParameters().put('Nome',Nome); //EC  2018 - 11 - 09
        //    pg.getParameters().put('off', 'P2PBase');
        system.debug('@@@@@@@@@EC siamo nel metodo ParentCaseRecord chiamato da PO_RegistrationController la pg è ' + pg);
        return pg;
        
        //FINE AA - 23/10/18
    }
    //EC -start 2018 - 07 - 05
    //EC start 2019 05 23 modifica e duplicazione del metodo per indicare il tipo di p2p Attiva da inserire
    public pagereference ServizioP2PAttiva(){
        pagereference pr = new pagereference('/apex/PO_P2PAttiva_InsertNewRequest');
        pr.getParameters().put('tipoP2Patt','eAccess');
        pr.setRedirect(true);
        return pr;
    }
    
    public pagereference ServizioP2PAttivaELine(){
        pagereference pr = new pagereference('/apex/PO_P2PAttiva_InsertNewRequest');
        pr.getParameters().put('tipoP2Patt','eLine');
        pr.setRedirect(true);
        return pr;
    }
    
    //EC end 2019 05 23 mo
    //EC start 2018 - 11 - 10 backhauling
    
    
    public pagereference ServizioBackhauling(){
        
        pagereference pr  = new PageReference('/PO_Serv_Backhauling_NuovaRichiesta');
        //pr.getParameters().put('off',recordOfferta);//??? capire se la stringa è effettivamente questa.
        //pr.getParameters().put('parentId', parentCaseId);
        pr.getParameters().put('off','Backhauling');
        pr.getParameters().put('Mode','insert');
        pr.setRedirect(true);
        return pr;  
        
    }
    
    public pagereference backhaulingList(){
        PageReference pr = new PageReference('/PO_Serv_Backhauling_Richieste');
        pr.getParameters().put('off','Backhauling');
        //   pr.getParameters().put('off',recordOfferta);
        //    pr.getParameters().put('parentId', parentCaseId);
        //    pr.getParameters().put('Nome', Nome);
        pr.setRedirect(true);
        system.debug('@@@@@@@@@@òEC stiamo chiamando un metodo di redirect backhaulingList per arrivare alla pagina delle richieste di backhauling, dopo il set redirect saremo dirottati qui: ' + pr);
        return pr;      
        
    }
    //EC end 2018 - 11 - 10 Backhauling
    
    public pagereference ServizioBTS()
    {        
        pagereference pr  = new PageReference('/PO_Serv_BTS_NuovaRichiesta');
        pr.getParameters().put('off','BTS');
        pr.getParameters().put('Mode','insert');
        pr.setRedirect(true);
        return pr;          
    }
    
    public pagereference BTSList(){
        PageReference pr = new PageReference('/PO_Serv_BTS_Richieste');
        pr.getParameters().put('off','BTS');         
        pr.setRedirect(true);        
        return pr;              
    }    
    
    /*
public PageReference ServizioP2PAttiva(){
system.debug('the value the showP2PAtt ' + showP2PAtt);
parentCase= new Case();
prntCaseID='';
parentCase.AccountId = accId;
parentCase.Status = 'Bozza';
invia = true;
recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];

parentCase.RecordTypeId = rt.id;
if(showP2PAtt == true){
parentCase.PO_Offerta__c = 'P2P Attiva';
}

insert parentCase;

prntCaseID=parentCase.Id;
//      system.debug('the value of parentcase in 'P2P Attiva'+parentCase.PO_Offerta__c );

//pagereference pr = new pagereference('/apex/PO_P2P_Attivo_DisplayRequest?id='+ParentCase.id);
pagereference pr= new pagereference('/apex/PO_P2PAttiva_InsertNewRequest');
return pr;
}
*/
    //EC start 2019 05 23 modifica e duplicazione del metodo per indicare il tipo di p2p Attiva
    public pagereference P2PAttivaList(){
        pagereference pr = new pageReference('/PO_P2P_Attivo_DisplayRequest');
        pr.getParameters().put('tipoP2Patt','eAccess');
        pr.setRedirect(true);
        return pr;
    }
    
    public pagereference P2PAttivaListELine(){
        pagereference pr = new pageReference('/PO_P2P_Attivo_DisplayRequestELine');
        pr.getParameters().put('tipoP2Patt','eLine'); 
        pr.setRedirect(true);
        return pr;
    }
    //EC end 2019 05 23 modifica e duplicazione del metodo per indicare il tipo di p2p Attiva da inserire   
    
    
    // END EC 2018-07-05
    
    //PREPROV
    public pagereference ServizioKit()
    {   
        /*
Nome='';
parentCase = new Case();
PrntCaseID='';
system.debug('accId===='+accId);
parentCase.accountid = accId;
parentCase.Status = 'Bozza';
invia = true;

recordtype rt = [select id from recordtype 
where sobjectType ='case' 
and developername='OF_PP_PreProvisioning_KITConsegna'];

parentCase.RecordTypeId = rt.id;
system.debug('show7===='+show7);
system.debug('recordOfferta===='+recordOfferta);
if(show7 == true)
{
//parentCase.PO_Offerta__c = recordOfferta;
parentCase.PO_Offerta__c = 'KIT';
}

insert parentCase;
prntCaseID=parentCase.Id;
//system.debug('KitParent===='+PrntCaseID);
*/
        pagereference pr = new pagereference('/apex/PO_PP_InserimentoKit');
        //pr.setRedirect(true);
        return pr;
    }
    
    
    public pagereference Fiberlease()
    {
        system.debug('the value the show2'+show2);
        /*** Commentato da Sergio 14-01-2019***/
        parentCase = new Case();
        PrntCaseID='';
        parentCase.accountid = accId;
        parentCase.Status = 'Bozza';
        invia = true;
        recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];
        
        parentCase.RecordTypeId = rt.id;
        if(show2 == true)
        {
            parentCase.PO_Offerta__c = 'Fiber Lease';
        }
        parentCase.OF_canBeDeleted__c=true;
        parentCase.PO_Nome_Progetto__c=Nome;
        insert parentCase;
        
        prntCaseID=parentCase.Id;
        system.debug('the value of parentcase in fiberlease'+parentCase.PO_Offerta__c );
        
        // AA - 23/10/18 Commentato il page reference e aggiunto il nuovo route
        /*pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id );
//pr.setRedirect(true);
return pr;*/
        
        /*** Commentato da Sergio 14-01-2019 ***/
        /*PageReference pg = new PageReference('/PO_Servizi_Fattibilita_Routing');
pg.getParameters().put('parentId', ParentCase.id);
pg.getParameters().put('off', 'FiberLease');*/
        
        PageReference pg = new PageReference('/PO_FiberLeaseInsRich');
        pg.getParameters().put('accountId', accId);
        
        return pg;
        //FINE AA - 23/10/18
    }
    public pagereference Fiberlink()
    {
        PrntCaseID='';
        parentCase = new Case();
        parentCase.accountid = accId;
        parentCase.Status = 'Bozza';
        invia = true;
        recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];
        parentCase.RecordTypeId = rt.id;
        if(show3 == true)
        {
            parentCase.PO_Offerta__c = 'Fiber Link';
        }
        parentCase.OF_canBeDeleted__c=true;
        parentCase.PO_Nome_Progetto__c=Nome;
        insert parentCase;
        prntCaseID=parentCase.Id;
        system.debug('Fibrelink===='+PrntCaseID);
        
        // AA - 23/10/18 Commentato il page reference e aggiunto il nuovo route
        /*pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id );
//pr.setRedirect(true);
return pr;*/
        PageReference pg = new PageReference('/PO_Servizi_Fattibilita_Routing');
        pg.getParameters().put('parentId', ParentCase.id);
        pg.getParameters().put('off', 'FiberLink');
        return pg;
        //FINE AA - 23/10/18
    }
    public pagereference IRU()
    {
        
        parentCase = new Case();
        parentCase.accountid = accId;
        parentCase.Status = 'Bozza';
        invia = true;
        recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];
        
        parentCase.RecordTypeId = rt.id;
        if(show4 == true)
        {
            parentCase.PO_Offerta__c = 'IRU';
        }
        parentCase.OF_canBeDeleted__c=true;
        parentCase.PO_Nome_Progetto__c=Nome;
        insert parentCase;
        
        // AA - 23/10/18 Commentato il page reference e aggiunto il nuovo route
        /*pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id );
//pr.setRedirect(true);
return pr;*/
        PageReference pg = new PageReference('/PO_Servizi_Fattibilita_Routing');
        pg.getParameters().put('parentId', ParentCase.id);
        pg.getParameters().put('off', 'IRU');
        return pg;
        //FINE AA - 23/10/18
    }
    public pagereference MistoFiber()
    {
        
        parentCase = new Case();
        parentCase.accountid = accId;
        parentCase.Status = 'Bozza';
        invia = true;
        recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];
        
        parentCase.RecordTypeId = rt.id;
        if(show5 == true)
        {
            parentCase.PO_Offerta__c = 'Evento Temporaneo';
        }
        parentCase.OF_canBeDeleted__c=true;
        parentCase.PO_Nome_Progetto__c=Nome;
        insert parentCase;
        System.debug('parentCase'+parentCase);
        
        // AA - 23/10/18 Commentato il page reference e aggiunto il nuovo route
        /*pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id );
//pr.setRedirect(true);
return pr;*/
        PageReference pg = new PageReference('/PO_Servizi_Fattibilita_Routing');
        pg.getParameters().put('parentId', ParentCase.id);
        pg.getParameters().put('off', 'MistoFiber');
        return pg;
        //FINE AA - 23/10/18
    }
    
    public pagereference ServizioOpenStream(){
        pagereference pr = new pagereference('/apex/PO_OpenStreamService_InsertNewRequest');
        pr.setRedirect(true);
        return pr;
    }
    
    //Add by PG - C&D - 22-11
    public pagereference ServizioOpenStreamCeD(){
        pagereference pr = new pagereference('/apex/PO_OpenStreamCeD_InsertNewReq');
        pr.setRedirect(true);
        return pr;
    }
    
    //Add by PG - C&D - 26-11
    public pagereference ServizioGPonPassivaCeD(){
        pagereference pr = new pagereference('/apex/PO_GPON_Passiva_CeD_InsertNewReq');
        pr.setRedirect(true);
        return pr;
    }
    
    // AS START
    public pagereference ServizioTT(){
        return new pagereference('/PO_TT_InsertNewRequest');
    }
    
    public pagereference TTList(){
        return new pageReference('/PO_TT_DisplayRequest');
    }
    
    // AS END
    
    // AM START
    //Azione='Provisioning'
    //FIX PG - 19-04
    public pagereference ServizioTP(){
        
        PageReference ref = new pagereference('/PO_TP_InsertNewRequest');
        ref.getParameters().put('azione', 'Provisioning');
        return ref;
    }
    
    //Azione='Provisioning'
    public pagereference TPList(){
        
        PageReference ref = new pageReference('/PO_TP_DisplayRequest');
        ref.getParameters().put('azione', 'Provisioning');
        return ref;
    }
    
    
    
    
    
    
    // AM END
    // AM START
    
    //Azione='Incident'
    public pagereference Incident(){
        
        PageReference ref = new pagereference('/PO_TP_InsertNewRequest');
        ref.getParameters().put('azione', 'Incident');
        return ref;
    }
    
    //Azione='Incident'
    public pagereference IncidentList(){
        
        PageReference ref = new pageReference('/PO_TP_DisplayRequest');
        ref.getParameters().put('azione', 'Incident');
        return ref;
    }
    
    
    // AM END
    
    public pagereference saveparentCaseNew()
    {
        parentCaseNew = new Case();
        
        
        recordtype rt = [select id from recordtype where sobjectType ='case' and developername='OF_SA_Attivazione'];
        
        parentCaseNew.RecordTypeId = rt.id;
        parentCaseNew.Status = 'Bozza';
        parentCaseNew.Origin = 'Portalino';
        
        insert parentCaseNew;
        openstreamcase = [SELECT ID, Casenumber FROM case WHERE ID =: parentcaseNew.Id];
        System.debug('parentCaseNew'+parentCaseNew);
        
        pagereference pgref = new pagereference('/apex/PO_Index');
        return pgref;
        
    }
    public Attachment attachment
    {
        get
        {
            if(attachment==null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }
    
    public pagereference childCase()
    {
        system.debug('@@@@@@@@@@@EC siamo in PO_RegistrationController, abbiamo appena chiamato il metodo childCase.apexpages.currentpage().getparameters().get(\'id\'); è ' + apexpages.currentpage().getparameters().get('id')+', mentre apexpages.currentpage().getparameters().get(\'parentid\'); è ' + apexpages.currentpage().getparameters().get('parentId'));
        system.debug('@@@@@@@@@@EC siamo in PO_RegistrationController, abbiamo appena chiamato il metodo childCase e verificato il parametro usato. ora consideriamo il Nome del progetto che viene passato: ' + Nome +', che valorizza il parentCase');
        newAtt.clear();
        attxlxs.clear();
        attlst.clear();
        system.debug('recid====='+parentCase);
        system.debug('recid====='+parentcaseobj);
        Attachment.clear();
        string recid = '';
        ID rectypeId=[select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
        Case testParent=new Case();
        //system.debug('parentcase inside childcase method'+parentcase.id);
        String testParentId= apexpages.currentpage().getparameters().get('id');
        //if(testParentId==null && testParentId==''){
        //       testParentId= apexpages.currentpage().getparameters().get('parentId');
        //}
        system.debug('@@@@@@@ ParentChild'+testParentId);
        if(TestParentID!= null){
            testParent=[select Id,PO_Nome_Progetto__c,ownerId  from Case where id=:testparentID];
            system.debug('@@@@@@@@@@EC siamo in PO_RegistrationController, abbiamo appena chiamato il metodo childCase e verificato il parametro usato. ora consideriamo il Nome del progetto che viene passato: ' + Nome +', che valorizza il case così: ' + testParent.PO_Nome_Progetto__c);
        }
        
        
        
        if(parentCase != null && parentCase.id != null)
        {
            if(parentCase.PO_Nome_Progetto__c ==null||parentCase.PO_Nome_Progetto__c == ''){
                parentCase.PO_Nome_Progetto__c =Nome ;
                offertEvento = parentCase.PO_Offerta__c;
                system.debug('@@@@@@@@@@EC siamo in PO_RegistrationController, abbiamo appena chiamato il metodo childCase e verificato il parametro usato. ora consideriamo il Nome del progetto che viene passato: ' + Nome +', che valorizza il case così: ' + parentCase.PO_Nome_Progetto__c + ', offertEvento è : ' + offertEvento );
                update parentCase; 
            }
            system.debug('inside the childcase condiytion'+parentCase.PO_Nome_Progetto__c);
            
            system.debug('inside the childcase condiytion'+testParentId);
            recid =  parentCase.id;
            if(parentcase.OwnerId!=rectypeID){
                parentCase.OwnerId = UserInfo.getUserId();
                update parentCase;
                system.debug('@@@@@@@@@@EC siamo in PO_RegistrationController, abbiamo appena chiamato il metodo childCase e verificato il parametro usato. ora consideriamo il Nome del progetto che viene passato: ' + Nome +', che valorizza il case così: ' + parentCase.PO_Nome_Progetto__c);
            }
        }
        else if(parentcaseobj != null && parentcaseobj.id != null)
        {
            recid =  parentcaseobj.id;
            offertEvento = parentcaseobj.PO_Offerta__c;
            if(parentcaseobj.OwnerId!=rectypeID){
                parentcaseobj.OwnerId = UserInfo.getUserId();
                
                update parentcaseobj;
            }
        }
        else if(testcase != null && testcase.id != null)
        {
            if( testcase.PO_Nome_Progetto__c == null||  testcase.PO_Nome_Progetto__c == ''){
                testcase.PO_Nome_Progetto__c =Nome ;
                
            }
            recid =  testcase.id;
            testcase.OwnerId = UserInfo.getUserId();
            update testcase;
            Nome = '';
            system.debug('testcase'+testcase);
        }
        
        if(testParent != null && testParent .id != null)
        {
            if( testParent.PO_Nome_Progetto__c== null ||testParent.PO_Nome_Progetto__c==''){
                testParent.PO_Nome_Progetto__c =Nome ;
                offertEvento = testcase.PO_Offerta__c;
            }
            recid =  testParent.id;
            update testParent ;
            Nome = '';
            system.debug('testParent '+testParent );
        }
        system.debug('recid====='+recid);
        case caseupdate = [select id,casenumber,PO_Offerta__c,PO_Nome_Progetto__c,OwnerId from case where id=:recid];
        // caseupdate.PO_Nome_Progetto__c = testCase.PO_Nome_Progetto__c;
        // update caseupdate;
        
        
        
        recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_Lease'];
        recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_link'];
        recordtype rt3 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P'];
        recordtype rt4 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_IRU'];
        recordtype rt5 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'];
        recordtype rt6 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P_Attiva']; // EC add recordType 'PO_Collegamento_P2P_Attiva' 2018 - 07 - 13
        // selectedIdComune
        
        case pcase = [select id,PO_Offerta__c,PO_Nome_Progetto__c,ownerId from case where id=:caseupdate.id limit 1];
        system.debug('Parent Case--------->'+pcase);
        string serviceType = pcase.PO_Offerta__c;
        system.debug('serviceType-------->'+serviceType);
        
        //if P2P Attiva ed è ancora una bozza creare un Log, altrimenti quando in 
        
        
        if(serviceType == 'Fiber Link')
        {
            if(pcase != null)
            {
                update pcase;
            }
            selectedIdComune = '';
            selectedIdComune1 = '';
            selectedIdComune2 = '';
            ChildCase = new Case();
            ChildCase.ParentId = pcase.id;
            ChildCase.accountid = accId;
            ChildCase.PO_Richiesta_a_fattibilit__c = recid;
            ChildCase.RecordTypeId = rt2.id;
            ChildCase.Status = 'Bozza';
            ChildCase.PO_Nome_Progetto__c=Nome;
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            //  pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
            pagereference pr = new pagereference('/PO_Fiberlink_Evento_ChildCase');
            pr.getParameters().put('parentid',pcase.id);
            pr.getParameters().put('Nome',Nome);
            pr.getParameters().put('off',offertEvento);
            /*
PageReference pg = new PageReference('/Po_FeasibilityServicesRequest2');
pg.getParameters().put('parentId', parentId);
pg.getParameters().put('off',recordOfferta);
*/
            return pr;
            
        }
        
        if(serviceType == 'Fiber Lease')
        {  system.debug('serviceType22-------->'+serviceType);
         if(pcase != null)
         {
             update pcase;
         }
         selectedIdComune = '';
         selectedIdComune1 = '';
         selectedIdComune2 = '';
         ChildCase = new Case();
         ChildCase.ParentId =  pcase.id;
         ChildCase.accountid = accId;
         ChildCase.PO_Richiesta_a_fattibilit__c =  recid ;
         childCase.RecordTypeId = rt1.id;
         ChildCase.Status = 'Bozza';
         ChildCase.PO_Nome_Progetto__c=Nome;
         //ChildCase.Contact.id = usr.Contact.id;
         insert childCase;
         // pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
         pagereference pr = new pagereference('/PO_IRU_FiberLease_Child');
         pr.getParameters().put('parentid',pcase.id);
         pr.getParameters().put('Nome',Nome);
         pr.getParameters().put('off',offertEvento);
         
         return pr;
         
         
        }
        if(serviceType == 'P2P Base')
        {   system.debug('serviceType33-------->'+serviceType);
         if(pcase != null)
         {
             update pcase;
         }
         selectedIdComune = '';
         selectedIdComune1 = '';
         selectedIdComune2 = '';
         ChildCase = new Case();
         ChildCase.ParentId = pcase.id;
         ChildCase.accountid = accId;
         ChildCase.PO_Richiesta_a_fattibilit__c =recid ;
         childCase.RecordTypeId = rt3.id;
         ChildCase.Status = 'Bozza';
         ChildCase.PO_Nome_Progetto__c=Nome;
         //ChildCase.Contact.id = usr.Contact.id;
         insert childCase;
         // pagereference pr = new pagereference('/apex/PO_P2PBaseNew?parentid='+pcase.id);
         pagereference pr = new pagereference('/PO_P2PBaseNew');
         pr.getParameters().put('parentid',pcase.id);
         pr.getParameters().put('Nome',Nome);
         pr.getParameters().put('off',offertEvento);
         return pr;
         
         return pr;
        }
        if(serviceType == 'IRU')
        {
            //update parentCase;
            if(pcase != null)
            {
                update pcase;
            }
            selectedIdComune = '';
            selectedIdComune1 = '';
            selectedIdComune2 = '';
            ChildCase = new Case();
            ChildCase.ParentId = recid;
            ChildCase.accountid = accId;
            ChildCase.PO_Richiesta_a_fattibilit__c = recid;
            childCase.RecordTypeId = rt4.id;
            ChildCase.Status = 'Bozza';
            ChildCase.PO_Nome_Progetto__c=Nome;
            
            insert childCase;
            // pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
            pagereference pr = new pagereference('/PO_IRU_FiberLease_Child');
            pr.getParameters().put('parentid',pcase.id);
            pr.getParameters().put('Nome',Nome);
            pr.getParameters().put('off',offertEvento);
            return pr;
            //ChildCase.Contact.id = PO_IRU_FiberLease_Childusr.Contact.id;
            
        }
        if(serviceType == 'Evento Temporaneo')
        {
            //update parentCase;
            if(pcase != null)
            {
                update pcase;
            }
            selectedIdComune = '';
            selectedIdComune1 = '';
            selectedIdComune2 = '';
            ChildCase = new Case();
            ChildCase.ParentId = recid;
            ChildCase.accountid = accId;
            ChildCase.PO_Richiesta_a_fattibilit__c = recid;
            childCase.RecordTypeId = rt5.id;
            ChildCase.Status = 'Bozza';
            ChildCase.PO_Nome_Progetto__c=Nome;
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            //pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
            pagereference pr = new pagereference('/PO_Fiberlink_Evento_ChildCase');
            pr.getParameters().put('parentid',pcase.id);
            pr.getParameters().put('Nome',Nome);
            pr.getParameters().put('off',offertEvento);
            return pr;
            
            
        }
        
        try{
            ChildCase.Status = 'Bozza';
            ChildCase.PO_Nome_Progetto__c=Nome;
            insert ChildCase;
        }catch(exception e){
            system.debug('getMessage error==>'+ e.getMessage() +'getStackTraceString error'+ e.getStackTraceString());
            
        }
        system.debug('Service Type--->'+serviceType);
        system.debug('ChildCase--->'+ChildCase);
        //pagereference pr = new pagereference('/apex/OF_ChildCase?parentid='+pcase.id);
        pagereference pr = new pagereference('/OF_ChildCase');
        pr.getParameters().put('parentid',pcase.id);
        pr.getParameters().put('Nome',Nome);
        pr.getParameters().put('off',offertEvento);
        
        return pr;
    }
    
    //DA FIXARE - PG
    public Pagereference SaveParentChildCaseInfo()
    {
        searchCaseBoolean=false;
        stageName=false;
        parentfile=false;
        Ordine = false;
        Nome=apexpages.currentpage().getparameters().get('Nome');
        newAtt.clear();
        attxlxs.clear();
        attlst.clear();
        string parentid = '';
        String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');
        system.debug('testParentIdSave'+testParentIdSave);
        try{
            OF_ElencoComuniItaliani__c ag = new OF_ElencoComuniItaliani__c();
            OF_ElencoComuniItaliani__c ag1 = new OF_ElencoComuniItaliani__c();
            OF_ElencoComuniItaliani__c ag2 = new OF_ElencoComuniItaliani__c();
            system.debug('selectedIdComune====='+selectedIdComune);
            system.debug('searchTerm====='+searchTerm);
            if(selectedIdComune != null && selectedIdComune != '' &&  selectedIdComune != 'Inserisci qui il nome comune' )
            {
                ag = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune limit 1];
                System.debug('Commune Name1--->'+ag.OF_Comune__c);
            }
            if(selectedIdComune1 != null && selectedIdComune1 != '' &&  selectedIdComune1 != 'Inserisci qui il nome comune' )
            {
                ag1 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune1 limit 1];
                System.debug('Commune Name2--->'+ag1.OF_Comune__c);
            }
            
            if(selectedIdComune2 != null && selectedIdComune2 != '' &&  selectedIdComune2 != 'Inserisci qui il nome comune' )
            {
                ag2 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune2 limit 1];
                System.debug('Commune Name3--->'+ag2.OF_Comune__c);
            }
            if(ag != null)
            {
                if(ChildCase.PO_Comune2__c == null )
                {
                    System.debug('*****ChildCase.PO_Comune2__c*****:'+ChildCase.PO_Comune2__r.OF_Comune__c);
                    try
                    {
                        ChildCase.PO_Comune2__c = ag.id;
                    }
                    catch(exception e)
                    {
                        system.debug('error==='+e.getStackTraceString());
                    }
                }
            }
            if(ag1 != null)
            {
                if(ChildCase.PO_Comune3__c == null )
                {
                    System.debug('*****ChildCase.PO_Comune3__c*****:'+ChildCase.PO_Comune3__r.OF_Comune__c);
                    try
                    {
                        ChildCase.PO_Comune3__c = ag1.id;
                    }
                    catch(exception e)
                    {
                        system.debug('error==='+e.getStackTraceString());
                    }
                }
            }
            
            if(ag2 != null)
            {
                if(ChildCase.PO_Comune4__c== null )
                {
                    System.debug('*****ChildCase.PO_Comune4__r.name*****:'+ChildCase.PO_Comune4__r.OF_Comune__c);
                    try
                    {
                        ChildCase.PO_Comune4__c= ag2.id;
                        System.debug('ChildCase.PO_Comune4__c--->'+ ChildCase.PO_Comune4__c);
                    }
                    catch(exception e)
                    {
                        system.debug('error==='+e.getStackTraceString());
                    }
                }
            }
            string caseid = '';
            
            if(parentCase != null && parentCase.id != null)
            {
                // parentid  = parentCase.id;
                parentid  = testParentIdSave;
                system.debug('Saving ChildCase'+ParentCase.id);
                
            }
            if(parentcaseobj != null && parentcaseobj.id != null)
            {
                parentid  = parentcaseobj.id;
            }
            if(childCase.id != null)
            {
                update childCase;
                System.debug('Commune Name--->'+ ChildCase.PO_Comune4__c);
                caseid = childCase.id;
                parentid  = childCase.parentid;
            }
            if(childCaseObj.id != null)
            {
                //if(childCaseObj.PO_Comune2__c == null)
                System.debug('*******selectedIdComune*****:'+selectedIdComune);
                System.debug('*******selectedIdComune1*****:'+selectedIdComune1);
                System.debug('*******selectedIdComune2*****:'+selectedIdComune2);
                
                childCaseObj.PO_Comune2__c =selectedIdComune;
                if( selectedIdComune1 != ''){
                    if(selectedIdComune1.contains('a0D')){
                        childCaseObj.PO_Comune3__c =selectedIdComune1;
                    }
                }
                if( selectedIdComune2 != ''){
                    if(selectedIdComune1.contains('a0D')){
                        childCaseObj.PO_Comune4__c =selectedIdComune2;
                    }
                }
                update childCaseObj;
                caseid = childCaseObj.id;
                parentid  = childCaseObj.parentid;
            }
            
            displayCase = [select id, casenumber ,parentid,PO_Comune2__c,PO_Durata_mesi__c,PO_Comune2__r.id,PO_Comune2__r.OF_Comune__c from case where id =:caseid];
            system.debug('Updated ChildCase--->'+ChildCase);
            comune = displayCase.PO_Comune2__r.OF_Comune__c;
            
        }
        catch(exception e){
            system.debug('Error Message-->'+e.getStackTraceString());
        }
        
        parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, Id,EOF_Fase__c,ParentId,
                         PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c,
                         Subject, Status, Priority, CreatedDate, CreatedById, PO_Offerta__c,ClosedDate,
                         PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId 
                         from case 
                         where Id=:parentid Limit 1];
        
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,PO_Durata_mesi__c,PO_IndrizoCal__c,Case.parent.PO_Offerta__c,
                                    Case.parent.CreatedDate, Case.parent.Status,CaseNumber,PO_Nome_Comune__c, po_comune2__c,
                                    PO_Comune2__r.OF_Comune__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,
                                    PO_Richiesta_a_fattibilit__r.casenumber,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c, CreatedDate, CreatedById , PO_Offerta__c,OwnerId, Parent.PO_Nome_Progetto__c
                                    from case
                                    where parentId=:parentCaseObj.id
                                    order by casenumber ASC];
        
        parentcase = parentCaseObj;
        if(parentcaseobj.status=='Bozza')
        {
            
            caseobjbuttoncheck=true;
            
        }
        
        
        ChildCases = childcaseList;
        // ChildCases.sort();
        //AA - 231018 Fix prod - Commentato pagereference
        //return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
        PageReference pg = new PageReference('/PO_Servizi_Fattibilita_Routing');
        pg.getParameters().put('parentId', parentCaseObj.id);
        pg.getParameters().put('Nome', Nome);
        pg.getParameters().put('method', 'save');
        system.debug('@@@@@@@@@@@@@Stiamo chiamando il metodo SaveParentChildCaseInfo, la pagereference è la seguente: ' + pg);
        return pg;
        
        //FINE AA - 231018
        
    }
    public Pagereference AddAttachment()
    {
        return new pagereference ('/apex/Po_AddAttachment?id='+ChildCase.id);
    }
    public PageReference upload() {
        // fileRender = true;
        system.debug('selectedIdComune value'+selectedIdComune);
        if(childCase.id != null && selectedIdComune != null && selectedIdComune != '')
        {
            childCase.PO_Comune2__c = selectedIdComune;
            update childCase;
        }
        if(childCase.id != null && selectedIdComune1 != null && selectedIdComune1 != '')
        {
            childCase.PO_Comune3__c = selectedIdComune1;
            update childCase;
        }
        if(childCase.id != null && selectedIdComune2 != null && selectedIdComune2 != '')
        {
            childCase.PO_Comune4__c = selectedIdComune2;
            update childCase;
        }
        if(selectedIdComune != null && selectedIdComune != '')
        {
            
            OF_ElencoComuniItalianiobj  =[select id,OF_Provincia__c from  OF_ElencoComuniItaliani__c where id=:selectedIdComune];
            system.debug('value of OF_ElencoComuniItalianiobj  '+OF_ElencoComuniItalianiobj.OF_Provincia__c );
            
        }
        if(selectedIdComune1 != null && selectedIdComune1 != '')
        {
            
            OF_ElencoComuniItalianiobj1  =[select id,OF_Provincia__c from  OF_ElencoComuniItaliani__c where id=:selectedIdComune1];
            system.debug('value of OF_ElencoComuniItalianiobj  '+OF_ElencoComuniItalianiobj1.OF_Provincia__c );
            
        }
        if(selectedIdComune2 != null && selectedIdComune2 != '')
        {
            
            OF_ElencoComuniItalianiobj2  =[select id,OF_Provincia__c from  OF_ElencoComuniItaliani__c where id=:selectedIdComune2];
            system.debug('value of OF_ElencoComuniItalianiobj  '+OF_ElencoComuniItalianiobj2.OF_Provincia__c );
            
        }
        attachment.OwnerId = UserInfo.getUserId();
        system.debug('Error Message-->'+childCase);
        if(ChildCase != null)
        {
            attachment.ParentId = ChildCase.id; // the record the file is attached to
        }
        if(ChildCaseobj != null)
        {
            attachment.ParentId = ChildCaseobj.id; // the record the file is attached to
        }
        attachment.IsPrivate = true;
        attachment.name = fileName;
        attachment.body = fileBody;
        
        try {
            insert attachment;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            system.debug('error======'+e.getStackTraceString());
            return null;
        } finally {
            attachment = new Attachment();
        }
        system.debug('attachment==='+attachment);
        system.debug('attachment==='+attachment);
        system.debug('childcase====='+childCase);
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
        //return new pagereference ('/apex/OF_ChildCase?id='+ChildCase.id);
        return null;
    }
    public pagereference DeleteParentCase()
    {
        system.debug('deleted parentCase=========='+parentCase);
        
        if(parentCase != null){
            delete parentCase;
        }
        else if(testCase != null){
            delete testCase;
        }
        /* if(childCaseObj != null)
{
delete childCaseObj;
}*/
        return new pagereference('/apex/po_index');
    }
    public list<case> getsortingCases()
    {   
        //giovanni ultima ora
        User usr = [Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
                    contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c, contact.PO_Servizio_GPON_Passiva_CeD__c,
                    contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c, contact.PO_Servizio_Open_Stream_CeD__c,
                    contact.PO_Servizio_Backhauling__c,
                    contact.PO_Servizio_BTS__c,
                    contact.PO_Servizio_Circuiti_Diretti__c,
                    contact.PO_Servizio_DarkFiber__c,
                    contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,
                    contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c
                    From User
                    Where Id =:System.UserInfo.getUserId()];
        
        
        
        System.debug('insideSortigCases'+sortCases) ;
        System.debug('recordOfferta==>'+recordOfferta) ;
        String recOff=ApexPages.currentPage().getParameters().get('recordOfferta');
        System.debug('pageparameter'+recOff) ;
        if(recordOfferta==null)
        {
            recordOfferta=recOff;
        }
        
        if(recordOfferta!= null){
            set<id> parentcases = new set<id>();
            
            system.debug('giovanni usr=== '+usr);
            system.debug('giovanni usr=== '+usr.contact);
            system.debug('giovanni recordOffertabc=== '+recordOfferta);                  
            
            //giovanni 26/10
            //
            recordOfferta = recordOfferta.remove('"');
            //
            String queryDaEliminare = 'select id,parentid,PO_Nome_Progetto__c,parent.PO_Offerta__c,PO_Tipologia_Offerta__c,OwnerId from case where ContactId =\''+ usr.contact.id + '\'' +'  AND PO_Tipologia_Offerta__c= ' + '\'' + recordOfferta + '\'';                      
            system.debug('giovanni queryDaEliminare=== '+queryDaEliminare);
            
            for(case cas : [select id,parentid,PO_Nome_Progetto__c,parent.PO_Offerta__c,PO_Tipologia_Offerta__c,OwnerId 
                            from case where ContactId =:usr.contact.id AND PO_Tipologia_Offerta__c=:recordOfferta])                  
            {
                //if(cas.parent.PO_Offerta__c == 'P2P Base')
                parentcases.add(cas.parentid);
                system.debug('parent id1=== '+cas.parentid);
            }
            for(case cas : [select id from case where ContactId =:usr.contact.id  AND PO_Offerta__c=:recordOfferta and recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit'])
            {
                parentcases.add(cas.id);
                system.debug('parent id2=== '+cas.id);
            }
            string query = 'select id,casenumber,CreatedDate,PO_Offerta__c,PO_Nome_Progetto__c,Status,OF_canBeDeleted__c from case where id IN :parentcases';
            query += ' Order by ' +  String.escapeSingleQuotes(sortField) + ' ' + myOrder ;
            List<Case> caseTodelete = new List<Case>();
            List<Case> caseToReturn = new List<Case>();
            try{
                
                system.debug('giovanni parentcases=== '+parentcases);
                system.debug('giovanni query2=== '+query);
                
                for (Case c : Database.query(query)){
                    if(String.isBlank(c.PO_Nome_Progetto__c)){
                        if(c.OF_canBeDeleted__c){
                            caseTodelete.add(c);
                        }
                    }
                    else{
                        caseToReturn.add(c);
                    }
                }
                if(caseTodelete!=null && !caseTodelete.isEmpty()){
                    delete caseTodelete;
                }
                return caseToReturn;
            }
            catch(exception e){
                
                system.debug('giovanni query exception==='+query);
                
                OF_Utility.logMessageNew2('Fattibilità','E','PO_RegistrationController', 'getsortingCases', null,e);
                return Database.query(query);
            }
            //currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status from case where id IN :parentcases order by CreatedDate desc];
        }
        return SortCases;
    }
    
    public list<case> getsortingCasesFiltered()
    {   System.debug('insideSortigCases'+sortCases) ;
     System.debug('recordOfferta==>'+recordOfferta) ;
     String recOff=ApexPages.currentPage().getParameters().get('recordOfferta');
     System.debug('pageparameter'+recOff) ;
     if(recordOfferta==null)
     {
         recordOfferta=recOff;
     }
     
     if(recordOfferta!= null){
         set<id> parentcases = new set<id>();
         
         for(case cas : [select id,parentid,PO_Nome_Progetto__c,parent.PO_Offerta__c,PO_Tipologia_Offerta__c,OwnerId 
                         from case where ContactId =:usr.contact.id AND PO_Tipologia_Offerta__c=:recordOfferta])
         {
             //if(cas.parent.PO_Offerta__c == 'P2P Base')
             parentcases.add(cas.parentid);
         }
         for(case cas : [select id from case where ContactId =:usr.contact.id  AND PO_Offerta__c=:recordOfferta and recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit'])
         {
             parentcases.add(cas.id);
             system.debug('case==='+cas);
         }
         string query = 'select id,casenumber,CreatedDate,PO_Offerta__c,PO_Nome_Progetto__c,Status,OF_canBeDeleted__c from case where id IN :parentcases';
         query += ' Order by ' +  String.escapeSingleQuotes(sortField) + ' ' + myOrder ;
         List<Case> caseTodelete = new List<Case>();
         List<Case> caseToReturn = new List<Case>();
         try{
             
             system.debug('giovanni parentcases=== '+parentcases);
             system.debug('giovanni query=== '+query);
             
             for (Case c : Database.query(query)){
                 if(String.isBlank(c.PO_Nome_Progetto__c)){
                     if(c.OF_canBeDeleted__c){
                         caseTodelete.add(c);
                     }
                 }
                 else{
                     caseToReturn.add(c);
                 }
             }
             if(caseTodelete!=null && !caseTodelete.isEmpty()){
                 delete caseTodelete;
             }
             return caseToReturn;
         }
         catch(exception e){
             
             system.debug('giovanni query exception==='+query);
             
             OF_Utility.logMessageNew2('Fattibilità','E','PO_RegistrationController', 'getsortingCases', null,e);
             return Database.query(query);
         }
         //currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status from case where id IN :parentcases order by CreatedDate desc];
     }
     return SortCases;
    }
    
    public pagereference currentUserParentCases()
    {
        newAtt.clear();
        //attxlxs.clear();
        attlst.clear();
        System.debug('recordOfferta==>'+recordOfferta) ;
        
        set<id> parentcases = new set<id>();
        for(case cas : [select id from case where ContactId =:usr.contact.id  AND PO_Offerta__c=:recordOfferta and recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit'])
        {
            parentcases.add(cas.id);
        }
        
        currentUserCases = [select id,PO_Tipologia_Offerta__c,casenumber,CreatedDate,PO_Offerta__c,Status,PO_Nome_Progetto__c,
                            PO_Comune2__c from case
                            where id IN :parentcases
                            order by CreatedDate desc];
        system.debug('currentUserCases====='+currentUserCases);
        sortCases =getsortingCases();
        system.debug('currentUserCases====='+sortCases);
        //return new pagereference ('/apex/Po_FeasibilityServicesRequest?recordOfferta='+recordOfferta);//2018 - 11 - 09 commento per uniformare con off
        if(recordOfferta == 'Fiber Lease'){
            return new pagereference ('/apex/PO_Serv_FiberLease_Richieste');
        }
        
        return new pagereference ('/apex/Po_FeasibilityServicesRequest?off='+recordOfferta);
        
    }
    
    //PREPROVISIONIG ---- INIZIO
    
    public pagereference currentUserParentCases_PP()
    {
        return new pageReference('/PO_PP_DisplayRequest');
    }
    
    public pagereference kitConsegnaAttivi()
    {
        return new pageReference('/PO_PP_KitConsegnaAttivi');
    }
    
    //PREPROVISIONING ---- FINE
    
    
    public pagereference currentUserParentCases_P2P()
    {
        set<id> parentcases = new set<id>();
        for(case cas : [select id,parentid,parent.PO_Offerta__c from case where ContactId =:usr.contact.id])
        {
            if(cas.parent.PO_Offerta__c == 'P2P Base')
            {
                parentcases.add(cas.parentid);
            }
        }
        currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status,PO_Comune2__c from case where id IN :parentcases order by CreatedDate desc];
        return new pagereference ('/apex/Po_FeasibilityServicesRequest?id='+usr.id);
    }
    public List<Attachment> attLink {get;set;}
    
    public pagereference displayChildCases() {
        selectedIdComune = '';
        selectedIdComune1 = '';
        selectedIdComune2 = '';
        string attNamenew='';
        string attname='';
        newAtt.clear();
        attxlxs.clear();
        searchCaseBoolean=false;
        attlst.clear();
        parentfile = false;
        Ordine = false;
        stagename = false;
        Id parentId = ApexPages.currentPage().getParameters().get('selparent');
        string prid = parentId;
        system.debug('prid===='+prid);
        system.debug('parentId===='+parentId);
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                    CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                                    from case where (parentId=:parentId OR parentId=:prid)
                                    order by CreatedDate ASC];
        if(childcaseList.size()>0)
            ChildCases = childcaseList;
        //system.debug('ChildCases====='+ChildCases);
        if(childcaseList.size()>0){
            if(parentId !=NULL) {
                parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                 PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
                opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];
                
                // oppty = [select id,stagename,PO_Numero_Anni__c,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];
                
                if(opp.size()>0 && !opp.isEmpty())
                {
                    if(opp[0].PO_Prezzo_totale_scontato__c != null)
                    {
                        Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
                    }
                    
                    if(opp[0].stagename=='Offerta presentata')
                    {
                        stagename = true;
                    }
                }
                
                if(parentid != null)
                {
                    
                    // attlst = attlstnew;
                    list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false AND Name LIKE '%PDF%'
                                               ORDER BY createddate DESC limit 1];
                    for(attachment att : newlst )
                    {
                        attnamenew = att.Name;
                        
                        if(attnamenew.contains('.pdf'))
                        {
                            newAtt.add(att);
                            system.debug('Attachment==='+newAtt);
                        }
                    }
                    list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
                                                   ORDER BY createddate DESC];
                    for(attachment att : attlstnew )
                    {
                        
                        attname = att.Name;
                        system.debug('Attachment==='+att.Name);
                        // if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))
                        
                        if(attname.containsIgnoreCase('.pdf'))
                        {
                            attlst.add(att);
                            system.debug('Attachment==='+attlst);
                        }
                        if(attname.containsIgnoreCase('.jpg'))
                        {
                            attlst.add(att);
                            system.debug('Attachment==='+attlst);
                        }
                        
                    }
                    if(attlst.size()>1 && attlst[0].name.containsIgnoreCase('.pdf'))
                    {
                        attlst.remove(0);
                    }
                    
                    list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                                   ORDER BY createddate DESC];
                    for(attachment att : newlstxlxs )
                    {
                        String attnamexlxs = att.Name;
                        
                        if(attnamexlxs.contains('.xlsx'))
                        {
                            attxlxs.add(att);
                            system.debug('Attachment==='+attxlxs);
                        }
                    }
                    
                }
                if(parentCaseObj.Status == 'Accettato')
                {
                    System.debug('testdate---');
                    Datetime fieldDate;
                    Datetime attachDate;
                    List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
                    List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                           ORDER BY createddate DESC Limit 1];
                    for(CaseHistory ch:csh)
                    {
                        System.debug('testdate---1');
                        
                        fieldDate=ch.createdDate;
                    }
                    
                    for(Attachment ah:ash)
                    {
                        System.debug('testdate---2');
                        attachDate=ah.createdDate;
                    }
                    If(fieldDate<attachDate) {
                        System.debug('testdate---3'+fieldDate);
                        System.debug('testdate---3'+attachDate);
                        ordine=true;
                    }
                }
                if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
                {
                    parentfile = true;
                }
                if( parentCaseObj.PO_isDataOrder__c ==true)
                {
                    ordine =false;
                }
            }
            
        }
        if(parentId !=NULL && childcaseList.size()==0) {
            
            parentCaseObj = [SELECT CaseNumber, PO_Numero_Anni__c,  PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                             PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
            system.debug('entering========'+parentCaseObj);
            ChildCases = childcaseList;
            return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
        }
        
        system.debug('ChildCases===='+parentCaseObj.status);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);
        
    }
    
    public pagereference displayChildCases(Id theSelParent) {
        selectedIdComune = '';
        selectedIdComune1 = '';
        selectedIdComune2 = '';
        string attNamenew='';
        string attname='';
        newAtt.clear();
        attxlxs.clear();
        searchCaseBoolean=false;
        attlst.clear();
        parentfile = false;
        Ordine = false;
        stagename = false;
        
        //Id parentId = ApexPages.currentPage().getParameters().get('selparent');
        Id parentId = theSelParent;        
        
        string prid = parentId;
        system.debug('prid===='+prid);
        system.debug('parentId===='+parentId);
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                    CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                                    from case where (parentId=:parentId OR parentId=:prid)
                                    order by CreatedDate ASC];
        if(childcaseList.size()>0)
            ChildCases = childcaseList;
        //system.debug('ChildCases====='+ChildCases);
        if(childcaseList.size()>0){
            if(parentId !=NULL) {
                parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                 PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
                opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];
                
                // oppty = [select id,stagename,PO_Numero_Anni__c,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];
                
                if(opp.size()>0 && !opp.isEmpty())
                {
                    if(opp[0].PO_Prezzo_totale_scontato__c != null)
                    {
                        Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
                    }
                    
                    if(opp[0].stagename=='Offerta presentata')
                    {
                        stagename = true;
                    }
                }
                
                if(parentid != null)
                {
                    
                    // attlst = attlstnew;
                    list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false AND Name LIKE '%PDF%'
                                               ORDER BY createddate DESC limit 1];
                    for(attachment att : newlst )
                    {
                        attnamenew = att.Name;
                        
                        if(attnamenew.contains('.pdf'))
                        {
                            newAtt.add(att);
                            system.debug('Attachment==='+newAtt);
                        }
                    }
                    list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
                                                   ORDER BY createddate DESC];
                    for(attachment att : attlstnew )
                    {
                        
                        attname = att.Name;
                        system.debug('Attachment==='+att.Name);
                        // if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))
                        
                        if(attname.containsIgnoreCase('.pdf'))
                        {
                            attlst.add(att);
                            system.debug('Attachment==='+attlst);
                        }
                        if(attname.containsIgnoreCase('.jpg'))
                        {
                            attlst.add(att);
                            system.debug('Attachment==='+attlst);
                        }
                        
                    }
                    if(attlst.size()>1 && attlst[0].name.containsIgnoreCase('.pdf'))
                    {
                        attlst.remove(0);
                    }
                    
                    list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                                   ORDER BY createddate DESC];
                    for(attachment att : newlstxlxs )
                    {
                        String attnamexlxs = att.Name;
                        
                        if(attnamexlxs.contains('.xlsx'))
                        {
                            attxlxs.add(att);
                            system.debug('Attachment==='+attxlxs);
                        }
                    }
                    
                }
                if(parentCaseObj.Status == 'Accettato')
                {
                    System.debug('testdate---');
                    Datetime fieldDate;
                    Datetime attachDate;
                    List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
                    List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                           ORDER BY createddate DESC Limit 1];
                    for(CaseHistory ch:csh)
                    {
                        System.debug('testdate---1');
                        
                        fieldDate=ch.createdDate;
                    }
                    
                    for(Attachment ah:ash)
                    {
                        System.debug('testdate---2');
                        attachDate=ah.createdDate;
                    }
                    If(fieldDate<attachDate) {
                        System.debug('testdate---3'+fieldDate);
                        System.debug('testdate---3'+attachDate);
                        ordine=true;
                    }
                }
                if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
                {
                    parentfile = true;
                }
                if( parentCaseObj.PO_isDataOrder__c ==true)
                {
                    ordine =false;
                }
            }
            
        }
        if(parentId !=NULL && childcaseList.size()==0) {
            
            parentCaseObj = [SELECT CaseNumber, PO_Numero_Anni__c,  PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                             PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
            system.debug('entering========'+parentCaseObj);
            ChildCases = childcaseList;
            return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
        }
        
        system.debug('ChildCases===='+parentCaseObj.status);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);
        
    }    
    
    public string Indirizzo{get;set;}
    public pagereference DisplayCaseInfo()
    {
        childcaseobj = new case();
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        system.debug('CaseObj====='+caseId);
        if(caseId !=NULL) {
            childCaseObj = [SELECT CaseNumber,PO_Sito__c,PO_IndrizoCal__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Civico__c,PO_Nota_sito__c,PO_Indirizzo_collegamento__c,PO_Nome_Comune__c,PO_Incluso_nell_offerta__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Comune2__c,PO_Richiesta_a_fattibilit__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
                            PO_Offerta__c,PO_Area_Geografica__c,PO_Prime_Contractor__c,PO_Note_Sospensione_OF__c,Note_Sospensione_Operatore__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,OwnerId
                            
                            from case where Id=:caseId Limit 1];
            system.debug('childCaseObj====='+childCaseObj.PO_Nota_sito__c);
            system.debug('childCaseObj====='+childCaseObj.PO_Incluso_nell_offerta__c);
            showedit=false;
            childcheck = false;
            system.debug('Status====='+childCaseObj.Status);
            
            if(childCaseObj.Status == 'Acquisito' || childCaseObj.Status == 'Sospesa'  || childCaseObj.Status == 'Bozza' || childCaseObj.Status == 'In carico al Cliente')
            {
                showedit= true;
                system.debug('showedit======'+showedit);
            }
            if(childCaseObj.Status == 'Completo')
            {
                orderline= true;
                system.debug('childcheck======'+childcheck);
            }
        }
        system.debug('showedit2======'+showedit);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest3?id'+caseId);
    }
    public pagereference Annula()
    {
        Id caseId = childCaseObj.parentid;
        id newid = ApexPages.currentPage().getParameters().get('id');
        system.debug('caseId====='+newid);
        system.debug('caseId====='+caseId);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+caseId);
        
    }
    public pagereference ParentAnnula()
    {
        update ParentCaseObj;
        Id caseId = ParentCaseObj.id;
        system.debug('caseId====='+caseId);
        return new pagereference ('/apex/PO_FeasibilityService1?id'+ParentCaseObj.id);
    }
    
    public pagereference InviaRichiesta()
    {
        parentCaseObj.Status = 'Acquisito';
        //parentCaseObj.EOF_Fase__c = 'In Lavorazione Supporto Vendite'; //AS patch inizial Phase
        parentCaseObj.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
        parentCaseObj.OwnerId = [select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
        update parentCaseObj;
        list<case> statusupdate = new list<case>();
        for(case cs : ChildCases)
        {
            cs.status = 'Acquisito';
            statusupdate.add(cs);
        }
        update statusupdate;
        /*//EC 2018 - 07 - 13 aggiungiamo l'if relativo a se il servizio di fattibilità è P2P Attiva (bisogna infatti creare il case solo in questo momento)

if(ApexPages.CurrentPage().getParameters().containsKey('/apex/PO_P2PAttiva')){

}
*/
        invia = false;
        return null;
    }
    
    public pagereference EditCaseInfo()
    {    selectedIdComune = '';
     selectedIdComune1 = '';
     selectedIdComune2 = '';
     Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
     system.debug('CaseObj====='+caseId);
     if(caseId !=NULL) {
         childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
                         PO_Prime_Contractor__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
                         PO_Offerta__c,parent.PO_Offerta__c,PO_Area_Geografica__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c ,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
                         from case where Id=:CaseDetail Limit 1];
         
         system.debug('childCaseObj====='+childCaseObj.PO_Offerta__c);
         offertEvento =  childCaseObj.PO_Tipologia_Offerta__c;
         // ordercasedisplaydatePO_Data_Attivazione_Ordine_date = childCaseObj.PO_Data_Attivazione_Ordine__c;
         
     }
     if(childCaseObj.parent.PO_Offerta__c == 'Fiber Link' || childCaseObj.parent.PO_Offerta__c == 'Evento Temporaneo')
     {
         return new pagereference ('/apex/PO_Fiberlink_Evento_EditCase?id='+caseId);
     }
     if(childCaseObj.parent.PO_Offerta__c == 'IRU' || childCaseObj.parent.PO_Offerta__c == 'Fiber Lease')
     {
         return new pagereference ('/apex/PO_IRU_FiberLease_Edit?id='+caseId);
     }
     return new pagereference ('/apex/Po_FeasibilityServicesRequest4?id='+caseId);
     
    }
    public string cliente {get;set;}
    public string cliente1 {get;set;}
    public string cliente2 {get;set;}
    public pagereference EditOrderInfo()
    {
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        system.debug('CaseObj====='+caseId);
        if(caseId !=NULL) {
            childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Data_Attivazione_Ordine__c,PO_Tipologia_Offerta_ordine__c,EOF_Comunicazioni_con_OLO__c,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
                            PO_Prime_Contractor__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
                            PO_Offerta__c,PO_Area_Geografica__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c,PO_Richiesta_a_fattibilit__r.PO_Tipologia_Offerta__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c ,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
                            from case where Id=:CaseDetail Limit 1];
            
            system.debug('childCaseObj====='+childCaseObj.PO_Offerta__c);
            offertEvento =  childCaseObj.PO_Tipologia_Offerta__c;
            cliente = childCaseObj.PO_Indirizzo_collegamento__c + ','+ childCaseObj.PO_Civico__c + ',' +childCaseObj.PO_Nome_Comune__c;
            if(childCaseObj.PO_Nome_Comune3__c != null){
                cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c+' '+childCaseObj.PO_Civico_partenza__c +','+ childCaseObj.PO_Nome_Comune3__c ;
            }
            if(childCaseObj.PO_Nome_Comune3__c == null){
                cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c+' '+childCaseObj.PO_Civico_partenza__c ;
            }
            String collegamento = childCaseObj.PO_indirizzo_collegamento_3__c;
            string civico = childCaseObj.PO_Civico_3__c;
            string comune = childCaseObj.PO_Nome_Comune4__c ;
            if(childCaseObj.PO_indirizzo_collegamento_3__c== null)
            {
                collegamento ='';
            }
            if(childCaseObj.PO_Civico_3__c== null)
            {
                civico ='';
            }
            if(childCaseObj.PO_Nome_Comune4__c == null)
            {
                comune ='';
            }
            
            cliente2 = collegamento +' '+civico +','+comune ;
            
            if(childCaseObj.PO_Nome_Comune4__c == null)
            {
                cliente2 = collegamento +' '+civico ;
            }
            
            if(childcaseobj.PO_Data_Attivazione_Ordine__c!= null)
            {
                Integer d = childcaseobj.PO_Data_Attivazione_Ordine__c.day();
                Integer mo = childcaseobj.PO_Data_Attivazione_Ordine__c.month();
                Integer yr = childcaseobj.PO_Data_Attivazione_Ordine__c.year();
                
                DateTime DT = DateTime.newInstance(yr, mo, d);
                //DateTime dtt =  datetime.newInstanace(childDate.Year(),childDate.month().childDate.day()) ;
                system.debug('childDate====='+DT);
                ordercasedispayordinedate = DT.format('dd/MM/yyyy');
                system.debug('childDate====='+childDate);
            }
        }
        orderatt = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId AND IsPrivate = false
                    ORDER BY createddate DESC];
        return new pagereference ('/apex/Po_FeasibilityServicesRequest8?id='+caseId);
    }
    public pagereference DetailPage()
    {
        
        if(searchCaseboolean==false){
            
            return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+childCaseObj.PO_Case_Collegamento__r.parentid);
        }
        else
        {
            system.debug('Boolean'+searchCaseBoolean);
            return new PageReference ('/apex/PO_Index');
        }
    }
    public pagereference SaveCaseInfo()
    {
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        if(caseId != null)
        {
            childCaseObj = [SELECT CaseNumber,PO_Sito__c,PO_Case_Collegamento__r.parentid,PO_Case_Collegamento__c,PO_Indirizzo_collegamento__c,PO_Civico__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,
                            PO_Data_Attivazione_Richiesta__c,PO_Prime_Contractor__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,PO_Richiesta_a_fattibilit__r.PO_Offerta__c,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
                            PO_Offerta__c,PO_Area_Geografica__c,PO_Incluso_nell_offerta__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
                            from case where Id=:caseid Limit 1];
            
            // system.debug(' childCaseObj.status========>'+ childCaseObj.status);
        }
        //system.debug(' childCaseObj.status========>'+ childCaseObj.status);
        // system.debug(' childCaseObj.status========>'+ childCaseObj.Previous_Status__c);
        update childCaseObj;
        if(childCaseObj.Previous_Status__c != null)
        {
            childCaseObj.status = childCaseObj.Previous_Status__c;
        }
        update childCaseObj;
        showedit = false;
        // system.debug('Case to be updated new======'+childCaseObj);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+childCaseObj.parentid);
    }
    
    public pagereference OpportunityStageNameUpdate()
    {
        if(parentcaseobj.PO_Offerta__c =='Fiber Lease')
        {
            ordine = true;
            //parentfile = false;
        }
        
        list<opportunity> opplst = [select id,name,PO_Prezzo_totale_scontato__c,stagename,PO_Richiesta_fattibilit__c from opportunity
                                    where id in : opp limit 1
                                   ];
        
        
        if(opplst.size()>0 && !opplst.isEmpty())
        {
            
            if(opplst[0].stagename == 'Offerta presentata')
            {
                opplst[0].StageName = 'Offerta accettata';
                update opplst[0];
            }
            
        }
        if(parentCaseObj != null)
        {
            if( opplst[0].StageName != null)
            {
                parentCaseObj.Status = 'Accettato';
                parentCaseObj.OwnerId = UserInfo.getUserId();
            }
            
            update parentCaseObj;
            list<case> childcaselst = [select id,PO_IndrizoCal__c,PO_Incluso_nell_offerta__c,PO_Comune2__c,status,casenumber,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
                                       PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                       PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                       recordtype.id,recordtype.developerName,OwnerId from case where parentid=:parentCaseObj.id and PO_Incluso_nell_offerta__c = true];
            
            system.debug('childcaselst======='+parentCaseObj.PO_Durata_affitto__c);
            if(parentCaseObj.PO_Durata_affitto__c == null && parentCaseObj.PO_Offerta__c == 'Fiber Link')
            {
                ApexPages.addMessage(
                    new ApexPages.Message(ApexPages.Severity.error,'Inserire il numero di anni di affitto di interesse, cliccando su Modifica.'));
                
            }
            
            else
            {
                if(childcaselst.size()>0)
                {
                    OrderCreation(childcaselst);
                    parentfile = true;
                    stagename = false;
                    
                    // PO_ServiziFattibilita_Controller.OrderCreation(childcaselst);
                }
            }
            
        }
        return null;
    }
    public list<case> getorderCases()
    {
        try
        {
            if(ChildCases.size()>0)
                ordercaselst = [select id,status,PO_Comune2__c,EOF_Comunicazioni_con_OLO__c,Note_Sospensione_Operatore__c,PO_Durata_mesi__c,PO_Case_Collegamento__r.PO_IndrizoCal__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
                                PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Case_Collegamento__r.parent.PO_isDataOrder__c, PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                recordtype.id,recordtype.developerName,OwnerId from case where PO_Case_Collegamento__c IN : ChildCases];
            
            system.debug('ordercaselst======='+ordercaselst);
            system.debug('ChildCases======='+ChildCases);
        }
        catch(exception e)
        {
            system.debug('error======='+e.getStackTraceString());
        }
        return ordercaselst;
    }
    
    public list<Opportunity> getparentOppty()
    {
        try
        {
            String id=apexpages.currentpage().getparameters().get('id') ;
            if(id!='' || id!=null){
                parentOpptylst = [select id,PO_Totale_contributi_attivazione__c,PO_Sconto_contributi_attivazione__c from Opportunity where PO_Richiesta_fattibilit__c =:id];
            }
        }
        catch(exception e)
        {
            system.debug('error======='+e.getStackTraceString());
        }
        return parentOpptylst ;
    }
    
    public string recid {get;set;}
    public pagereference collegmentaDate()
    {
        //ordine = true;
        system.debug('i am in method collegmentaDate');
        string id =apexpages.currentPage().getParameters().get('recid');
        system.debug('id========'+id);
        ordercasedit = [select id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,PO_Nome_E_Cognome_PM__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.id,PO_Tempi_di_attivazione_mesi__c  from case where id=:id];
        date d = date.today();
        if(ordercasedit.PO_Tempi_di_attivazione_mesi__c != null)
        {
            Integer intConvertedValue = ordercasedit.PO_Tempi_di_attivazione_mesi__c.intValue();
            
            date checkdate_In_PO_ModalController = d.addmonths(intConvertedValue );
            stringdate_In_PO_ModalController =  string.valueOf(checkdate_In_PO_ModalController );
        }
        else
        {
            stringdate_In_PO_ModalController =  string.valueOf(d );
        }
        return new pagereference('/apex/PO_ModalController?id'+ordercasedit.id);
    }
    public pagereference collegmentaDateEdit()
    {
        //ordine = true;
        string id =apexpages.currentPage().getParameters().get('editid');
        system.debug('id========'+id);
        
        ordercasedit = [select id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,PO_Nome_E_Cognome_PM__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.id,PO_Tempi_di_attivazione_mesi__c  from case where id=:id];
        
        System.debug('@@@ordercasedit'+ ordercasedit);
        return new pagereference('/apex/PO_ModalController?id'+ordercasedit.id);
    }
    public pagereference SaveOrderCase()
    {
        //Ordine=true;
        system.debug('htmldate===='+date4);
        str = date4;
        if(str.contains('/')){
            str = str.replace('/','-');
            str = str.left(10).right(4)+'-'+str.left(5).right(2)+'-'+str.left(2);
        }
        
        //checkDate(str);
        
        //if(checkDate(str)){
        
        try
        {
            //ordercasedit.PO_Data_Attivazione_Richiesta__c = date4;
            ordercasedit.PO_Data_Attivazione_Richiesta__c = str;
            update ordercasedit;
        }
        catch(exception e)
        {
            system.debug('error date fiels======>'+e.getStackTraceString());
        }
        //}else{
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Il formato della Data inserita non è corretto. Inserire la Data in formato gg/mm/aaaa'));
        //return null;
        //}
        
        //   update ordercaselst;
        case parencs = [select id,parentid,OwnerId from case where id=:ordercasedit.PO_Case_Collegamento__c];
        system.debug('parentid========'+parencs.parentid);
        return new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+parencs.parentid);
    }
    
    public pagereference orderAnnula()
    {
        case parencs = [select id,parentid,OwnerId from case where id=:ordercasedit.PO_Case_Collegamento__c];
        system.debug('parentid========'+parencs.parentid);
        return new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+parencs.parentid);
    }
    public string textarea {get;set;}
    public pagereference OpportunityStageNameUpdate2()
    {
        
        inlineshow = true;
        list<opportunity> opplst = [select id,name,createdby.id,stagename,PO_Richiesta_fattibilit__c from opportunity
                                    where id in : opp limit 1];
        system.debug('entering============'+opplst[0].stagename);
        if(opplst.size()>0 && !opplst.isEmpty())
        {
            
            if(opplst[0].stagename == 'Offerta presentata')
            {
                opplst[0].StageName = 'Richiesta nuova proposta';
                update opplst[0];
            }
            
        }
        if(parentCaseObj != null)
        {
            if( opplst[0].StageName != null)
            {
                parentCaseObj.Status = 'In lavorazione';
                parentCaseObj.EOF_Fase__c = 'Richiesta modifica offerta da Cliente';
                parentCaseObj.OwnerId = opplst[0].createdby.id;
            }
            update parentCaseObj;
            
            
        }
        
        
        if(ChildCases.size()>0)
        {
            update ChildCases;
            list<case> mylist = new list<case>();
            list<case> ChildCaseslist =  [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                          CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                          Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.id,PO_Nome_Comune__c
                                          from case where id In :ChildCases ];
            for(case cs : ChildCaseslist)
            {
                if(cs.PO_Incluso_nell_offerta__c == true)
                {
                    cs.Status = 'Completato';
                    mylist.add(cs);
                }
                else
                {
                    cs.Status = 'Annullato';
                    mylist.add(cs);
                }
            }
            if(mylist.size()>0)
            {
                update mylist;
                ChildCases = mylist;
                
            }
            
        }
        //  stagename = false;
        //ChildcaseRedirect =true;
        
        // return null;
        //return ApexPages.currentPage();
        
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
    }
    
    
    public pagereference OpportunityStageNameUpdate4()
    {
        inlineshow = false;
        update ChildCases;
        stagename = false;
        return null;
    }
    
    public pagereference OpportunityStageNameUpdate3()
    {
        list<opportunity> opplst = [select id,name,stagename,PO_Richiesta_fattibilit__c from opportunity
                                    where id in : opp limit 1
                                   ];
        if(opplst.size()>0 && !opplst.isEmpty())
        {
            
            if(opplst[0].stagename == 'Offerta presentata')
            {
                opplst[0].StageName = 'Offerta rifiutata';
                update opplst[0];
            }
            
        }
        if(parentCaseObj != null)
        {
            if( opplst[0].StageName != null)
            {
                parentCaseObj.Status = opplst[0].StageName;
                parentCaseObj.OwnerId = UserInfo.getUserId();
            }
            update parentCaseObj;
        }
        stagename = false;
        return null;
    }
    
    public string textarea1 {get;set;}
    
    public pagereference OpportunityStageNameUpdate3a()
    {
        inlineshow = true;
        list<opportunity> opplst = [select id,name,stagename,PO_Richiesta_fattibilit__c from opportunity
                                    where id in : opp limit 1];
        case parentcase = [select id,casenumber,PO_Note_rifiuto_offerta__c,OwnerId from case where id=:parentCaseObj.id];
        parentcase.PO_Note_rifiuto_offerta__c = textarea1;
        update parentcase;
        system.debug('Parent textarea===='+parentcase.PO_Note_rifiuto_offerta__c);
        
        system.debug('parentCaseObj===='+parentcase);
        if(opplst.size()>0 && !opplst.isEmpty())
        {
            
            if(opplst[0].stagename == 'Offerta presentata')
            {
                opplst[0].StageName = 'Offerta rifiutata';
                update opplst[0];
            }
        }
        stagename = false;
        return null;
    }
    
    
    public pageReference StausUpdate()
    {
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        
        if(caseId != null)
        {
            childCaseObj = [SELECT CaseNumber,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
                            PO_Offerta__c,PO_Area_Geografica__c,PO_Prime_Contractor__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
                            from case where Id=:caseid Limit 1];
            childCaseObj.status = childCaseObj.Previous_Status__c;
            showedit = true;
            system.debug('Old Status========>'+ childCaseObj.status);
        }
        
        update childCaseObj;
        return null;
    }
    public pageReference Home(){
        return new pagereference('https://servattivi-servattivi.cs84.force.com/partnercommunity');
    }
    public Pagereference saveContactInformation(){
        try
        {
            update contactObj;
            pagereference pr = new pagereference('/');
            pr.setRedirect(true);
            return pr;
        }
        catch(exception e)
        {
            system.debug('Error Message======'+e.getStackTraceString());
        }
        return null;
    }
    
    public void ParentDataOrderUpdation()
    {
        childcserec = [select id,status,PO_Comune2__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
                       PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                       PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                       recordtype.id,recordtype.developerName,PO_Case_Collegamento__r.parent.PO_isDataOrder__c,OwnerId from case where id IN : ordercaselst
                       and PO_Data_Attivazione_Richiesta__c != null and PO_Nome_E_Cognome_PM__c != null and
                       PO_Numero_Telefonico_PM__c != null ];
        system.debug('order lsist size===='+ordercaselst.size());
        system.debug('childcserec size===='+childcserec.size());
        if(ordercaselst.size() == childcserec.size())
        {
            parentCaseObj.PO_isDataOrder__c = true;
            update parentCaseObj;
            ParentOrderCheck = true;
            if(childcserec.size()>0)
            {
                OrderCreation(childcserec);
            }
            ordine = false;
        }
        else
        {
            string msg1 = 'Cliccare su “Completa Ordine” per ciascun ordine in elenco, per inserire i dati necessari \n';
            string msg2 = 'L’ordine sarà lavorato solo se saranno inseriti i dati richiesti per tutti gli ordini \n';
            string message = msg1 + msg2 ;
            ApexPages.addMessage(
                new ApexPages.Message(ApexPages.Severity.info,message));
        }
    }
    
    @TestVisible public class addAdressClass{
        public string ContactNamelable{get;set;}
        public string ContactNameValue{get;set;}
        public string ContactNamelable1{get;set;}
        public string ContactNameValue1{get;set;}
        
        public addAdressClass(String ContactNamelable,String ContactNamelable1){
            this.ContactNamelable = ContactNamelable;
            this.ContactNamelable1 = ContactNamelable1;
        }
    }
    // Instance fields
    public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
    public String searchTerm1 {get; set;}
    public String selectedIdComune1 {get; set;}
    public String searchTerm2 {get; set;}
    public String selectedIdComune2 {get; set;}
    
    
    
    //Rajani -Start 13-11-2018
    public pagereference AddAddressMethod(){
        pagereference pr = new pagereference('/apex/PO_AddressMatching_New');
        pr.setRedirect(true);
        return pr;
    }
    
    
    // Product availability
    public pagereference ProductAvailabilityMethod(){
        pagereference pr = new pagereference('/apex/PO_ProductAvailability');
        pr.setRedirect(true);
        return pr;
    }
    
    @RemoteAction // COde modified for CR34 abhishek anand 21112018
    public static List<PO_AMResponseWrapper> searchComuneAdd(String searchTerm) {
        System.debug('Comune Name is: '+ comunename );
        
        /*   List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
// System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
return AreaGeograficaJunction;
*/
        List<PO_AMResponseWrapper> accountWrappers = new List<PO_AMResponseWrapper> ();
        system.debug('all values for searchString in vf component controller: '+ searchTerm);
        
        PO_AddressMatchingJSONtoData  chec = new PO_AddressMatchingJSONtoData ();
        
        accountWrappers =chec.PO_AddressMatchingJSONtoData(searchTerm);
        
        
        //system.debug('all values for accountWrappers in vf component controller: '+ accountWrappers);
        return accountWrappers;
    }
    
    @Remoteaction // COde added for CR34 abhishek anand 21112018
    public static List<PO_AMResponseWrapper> getviastring(String searchTerm, String ComuneId)
    {
        List<PO_AMResponseWrapper> accountWrappers = new List<PO_AMResponseWrapper> ();
        system.debug('all values for searchString in vf component controller: '+ searchTerm+' '+ComuneId);
        
        PO_AddressMatchingJSONtoData  chec = new PO_AddressMatchingJSONtoData ();
        
        accountWrappers =chec.getVia(searchTerm,ComuneId);
        
        
        //system.debug('all values for accountWrappers in vf component controller: '+ accountWrappers);
        return accountWrappers;
    }
    
    @Remoteaction // COde added for CR34 abhishek anand 21112018
    public static List<PO_AMResponseWrapper> getcivicostring(String searchTerm, String civicoId)
    {
        List<PO_AMResponseWrapper> accountWrappers = new List<PO_AMResponseWrapper> ();
        system.debug('all values for searchString in vf component controller: '+ searchTerm+civicoId);
        
        PO_AddressMatchingJSONtoData  chec = new PO_AddressMatchingJSONtoData ();
        
        accountWrappers =chec.getcivico(searchTerm,civicoId);
        // IdEgoncivico = civicoId ;
        // System.debug('Civico is: '+ IdEgoncivico);
        
        //system.debug('all values for accountWrappers in vf component controller: '+ accountWrappers);
        return accountWrappers;
    }
    
    // COde added for CR34 abhishek anand 21112018
    public void Addaddress()
    {
        System.debug('Comune Name is: '+ searchTerm);
        System.debug('IdEgoncivico is: '+ IdEgoncivico);
        // showCivico = IdEgoncivico;
        System.debug('IdEgoncivico is: '+ showCivico);
        
        
    }
    
    public  Void  getProductAvail() //Priyanka B  27112018 CR34
    {
        //String civicoId =showCivicoId;
        //showCivico = IdEgoncivico;
        String civicoId =IdEgoncivico;
        List<PO_AMResponseWrapper> accountWrappers = new List<PO_AMResponseWrapper> ();
        system.debug('all values for searchString in vf component controller: '+civicoId);
        String result1,result2;
        PO_AddressMatchingJSONtoData  chec = new PO_AddressMatchingJSONtoData();
        accountWrappers =chec.getProductAvaiResp(civicoId);
        
        for ( PO_AMResponseWrapper amacc:accountWrappers )
        {
            result1= amacc.label;
            result2= amacc.value;
        }
        
        
        system.debug('all values for accountWrappers in vf component controller: '+ accountWrappers );
        system.debug('all values for result1 in vf component controller: '+ result1 );
        system.debug('all values for result2 in vf component controller: '+ result2 );
        result3 =result1;
        result4 =result2;
        //Edited on 21122018 by Priyanka and Nikita
        if(result1=='Disponibilità Rete Open Fiber Soggetta a Studio di fattibilità preventivo')
            AttivoFlag='IconsCR34/rejecticonresized.jpg';//Abhishek Anand 27112018 CR34
        else if(result1=='Rete Open Fiber Disponibile')
            AttivoFlag='IconsCR34/trustresized1.jpg';//Abhishek Anand 27112018 CR34
        /*  if(result2=='Non Disponibile')
PassivoFlag='IconsCR34/rejecticonresized.jpg';//Abhishek Anand 27112018 CR34
else if(result1=='Disponibile')
PassivoFlag='IconsCR34/trustresized1.jpg';//Abhishek Anand 27112018 CR34*/
        
        system.debug('all values for AttivoFlag in vf component controller: '+ AttivoFlag );	
        system.debug('all values for PassivoFlag in vf component controller: '+ PassivoFlag );	
        //return result;
    }
    
    
    //Rajani -End 13-11-2018
    // JS Remoting action called when searching
    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c> searchComune(String searchTerm) {
        // System.debug('Comune Name is: '+searchTerm );
        
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        // System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
        return AreaGeograficaJunction;
        
    }
    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c> searchComune1(String searchTerm1) {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm1) + '%\'  order by OF_Comune__c ASC ' );
        // System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
        return AreaGeograficaJunction;
    }
    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c> searchComune2(String searchTerm2) {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm2) + '%\'  order by OF_Comune__c ASC ' );
        // System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
        return AreaGeograficaJunction;
        
    }
    
    public PageReference backtochild() {
        id parentid = apexpages.currentPage().getparameters().get('id');
        if (parentid == null && parentid ==''){
            parentid = apexpages.currentPage().getparameters().get('parentId');
        }
        system.debug('@@@@@@@@ nel metodo backtochild parentid è ' + parentid);
        
        pagereference pr = new pagereference('/Po_FeasibilityServicesRequest2');
        pr.getParameters().put('parentid',parentid);
        return pr;
        
        //return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);
    }
    public static List<Case>  OrderCreation (List<Case> CaseFromPortal){
        
        list<RecordType> RList =[select id, developerName from recordType];
        MAp<String,String> checkRType = new MAp<String,String>();
        for(recordType RT : RList){
            checkRType.Put( rt.Id,rt.developerName);
        }
        if(checkRType.get(CaseFromPortal[0].recordtypeId).contains('Collegamento')){
            system.debug('@@@@@ 01');
            OF_UtilitiesManageOrderFromCase obju = new OF_UtilitiesManageOrderFromCase();
            list<Case> CaseToOrder =[select status,PO_IndrizoCal__c,PO_Case_Collegamento__r.PO_Incluso_nell_offerta__c, EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
                                     PO_Numero_fibre_richieste__c,PO_Comune3__c,PO_sito_3__c ,PO_Nota_sito_3__c ,PO_Comune4__c,PO_indirizzo_collegamento_3__C ,PO_civico_3__c ,PO_Drop_FL_1__c, AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                     PO_Tipo_percorso__c,PO_Comune2__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,PO_Sito_partenza__c,PO_Civico_partenza__c, PO_Indirizzo_collegamento_partenza__c, PO_Nota_sito_partenza__c, PO_Civico__c,
                                     recordtype.id,recordtype.developerName,PO_Richiesta_a_fattibilit__c,OwnerId from case where id IN: CaseFromPortal];
            
            List<Case> caseToInsert = new List<Case>();
            MAp<String,String> rtMap = new MAp<String,String>();
            for(recordType RT : RList){
                rtMap.Put(rt.developerName, rt.Id);
            }
            for( case cOld : CaseToOrder){
                system.debug('@@@@@ 02');
                case c= new case();
                c.status='Accettato';
                c.EOF_Fase__c='Bozza';
                c.PO_Case_Collegamento__c=cOld.Id;
                c.PO_Tipo_di_collegamento__c=cOld.PO_Tipo_di_collegamento__c;
                c.PO_Numero_fibre_richieste__c=cOld.PO_Numero_fibre_richieste__c;
                c.AccountId=cOld.AccountId;
                c.PO_Prime_Contractor__c=cOld.PO_Prime_Contractor__c;
                c.PO_Nome_sito__c=cOld.PO_Nome_sito__c;
                c.PO_Comune2__c =cOld.PO_Comune2__c;
                c.PO_Indirizzo_sito__c=cOld.PO_Indirizzo_sito__c;
                c.PO_Tipo_percorso__c=cOld.PO_Tipo_percorso__c;
                c.PO_Note_collegamento__c=cOld.PO_Note_collegamento__c;
                c.PO_Sito__c=cOld.PO_Sito__c;
                c.PO_Nota_sito__c=cOld.PO_Nota_sito__c;
                c.PO_Indirizzo_collegamento__c=cOld.PO_Indirizzo_collegamento__c;
                c.PO_Sito_partenza__c= cOld.PO_Sito_partenza__c;
                c.PO_Civico_partenza__c= cOld.PO_Civico_partenza__c;
                c.PO_Indirizzo_collegamento_partenza__c= cOld.PO_Indirizzo_collegamento_partenza__c;
                c.PO_Nota_sito_partenza__c= cOld.PO_Nota_sito_partenza__c;
                c.PO_Civico__c= cOld.PO_Civico__c;
                //28/09/2017 CRM Modifica
                c.PO_Richiesta_a_fattibilit_ordine__c = cOld.PO_Richiesta_a_fattibilit__c;
                //28/09/2017 END CRM
                
                system.debug('ComuneTest==='+cOld.PO_Comune3__c );
                if(cOld.RecordType.developerName=='PO_Collegamento_Fiber_link'){
                    if(cOld.PO_Comune3__c != null){
                        c.PO_Comune3__c=cOld.PO_Comune3__c;
                    }
                    if(cOld.PO_Comune4__c != null){
                        c.PO_Comune4__c=cOld.PO_Comune4__c;
                    }
                    c.PO_indirizzo_collegamento_3__C = COld.PO_indirizzo_collegamento_3__c;
                    c.PO_civico_3__c = cOld.PO_civico_3__c;
                    c.PO_sito_3__c = cOld.PO_sito_3__c;
                    c.PO_Nota_sito_3__c = cOld.PO_Nota_sito_3__c;
                    c.recordTypeid=rtMap.get('PO_Ordine_Fiber_Link');
                }
                
                if(cOld.RecordType.developerName=='PO_Collegamento_Fiber_lease'){
                    if(cOld.PO_Comune3__c != null){
                        c.PO_Comune3__c=cOld.PO_Comune3__c;
                    }
                    c.recordTypeid=rtMap.get('PO_Ordine_Fiber_Lease');
                    
                    /* FiberLink Creation when DropFL checkbox is Checked in FiberLease*/
                    if(cOld.PO_Drop_FL_1__c == true){
                        case cFlink= new case();
                        cFlink.status='Accettato';
                        cFlink.EOF_Fase__c='Bozza';
                        cFlink.PO_Case_Collegamento__c=cOld.Id;
                        cFlink.PO_Tipo_di_collegamento__c='None';
                        cFlink.PO_Numero_fibre_richieste__c=cOld.PO_Numero_fibre_richieste__c;
                        cFlink.AccountId=cOld.AccountId;
                        cFlink.PO_Prime_Contractor__c=cOld.PO_Prime_Contractor__c;
                        cFlink.PO_Nome_sito__c=cOld.PO_Nome_sito__c;
                        cFlink.PO_Comune2__c =cOld.PO_Comune2__c;
                        cFlink.PO_Indirizzo_sito__c=cOld.PO_Indirizzo_sito__c;
                        cFlink.PO_Tipo_percorso__c=cOld.PO_Tipo_percorso__c;
                        cFlink.PO_Note_collegamento__c=cOld.PO_Note_collegamento__c;
                        cFlink.PO_Sito__c=cOld.PO_Sito__c;
                        cFlink.PO_Nota_sito__c=cOld.PO_Nota_sito__c;
                        cFlink.PO_Indirizzo_collegamento__c=cOld.PO_Indirizzo_collegamento__c;
                        cFlink.PO_Sito_partenza__c= cOld.PO_Sito_partenza__c;
                        cFlink.PO_Civico_partenza__c= cOld.PO_Civico_partenza__c;
                        cFlink.PO_Indirizzo_collegamento_partenza__c= cOld.PO_Indirizzo_collegamento_partenza__c;
                        cFlink.PO_Nota_sito_partenza__c= cOld.PO_Nota_sito_partenza__c;
                        cFlink.PO_Civico__c= cOld.PO_Civico__c;
                        cFlink.PO_Richiesta_a_fattibilit_ordine__c = cOld.PO_Richiesta_a_fattibilit__c;
                        cFlink.recordTypeid=rtMap.get('PO_Ordine_Fiber_Link');
                        
                        caseToInsert.add(cFlink);
                    }
                }
                
                if(cOld.RecordType.developerName=='PO_Collegamento_IRU'){
                    if(cOld.PO_Comune3__c != null){
                        c.PO_Comune3__c=cOld.PO_Comune3__c;
                    }
                    c.recordTypeid=rtMap.get('PO_Ordine_IRU');
                }
                
                if(cOld.RecordType.developerName=='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'){
                    if(cOld.PO_Comune3__c != null){
                        c.PO_Comune3__c=cOld.PO_Comune3__c;
                    }
                    if(cOld.PO_Comune4__c != null){
                        c.PO_Comune4__c=cOld.PO_Comune4__c;
                    }
                    c.PO_indirizzo_collegamento_3__C = COld.PO_indirizzo_collegamento_3__c;
                    c.PO_civico_3__c = cOld.PO_civico_3__c;
                    c.PO_sito_3__c = cOld.PO_sito_3__c;
                    c.PO_Nota_sito_3__c = cOld.PO_Nota_sito_3__c;
                    c.recordTypeid=rtMap.get('PO_Ordine_Misto_Fiber_Lease_Link_per_Fastweb');
                    
                }
                
                if(cOld.RecordType.developerName=='PO_Collegamento_P2P'){
                    c.recordTypeid=rtMap.get('PO_Ordine_P2P');
                }
                
                caseToInsert.add(c);
            }
            insert caseToInsert;
            //Chenges Alessandro
            map<id, set<id>> IdMapNew = new map<id, set<id>>();
            map<id, case> CaseMap = new map<id, case>();
            List<OF_CommercialElementIstanziato__c> CEIToInsert = new List<OF_CommercialElementIstanziato__c>();
            Map<Id,Case> caseFormula = new Map<Id,Case>([select id, casenumber,Codice_Ordine_EOF__c from case where id in: caseToInsert]);
            for(Case c : caseToInsert){
                
                system.debug('DG_OF_ManageOrderFromCase - c.status: ' + c.status + '---c.PO_Case_Collegamento__c: ' + c.PO_Case_Collegamento__c);
                
                Set<Id> setCaseId = IdMapNew.get(c.PO_Case_Collegamento__c);
                if (setCaseId == null) {
                    setCaseId = new Set<Id>();
                    IdMapNew.put(c.PO_Case_Collegamento__c, setCaseId);
                }
                setCaseId.add(c.Id);
                //IdMapNew.put(c.PO_Case_Collegamento__c,new Set<ID>{c.Id});
                CaseMap.put(c.id, c);
                
                //creazione CEI
                if(c.PO_Tipo_percorso__c.toUpperCase()=='DOPPIA VIA DIVERSIFICATA'){
                    OF_CommercialElementIstanziato__c partenza = new OF_CommercialElementIstanziato__c();
                    partenza.recordtypeId=rtMap.get('Tratte');
                    partenza.OF_CaseTratta__c=c.Id;
                    CEIToInsert.add(partenza);
                    OF_CommercialElementIstanziato__c destinazione = new OF_CommercialElementIstanziato__c();
                    destinazione.recordtypeId=rtMap.get('Tratte');
                    destinazione.OF_CaseTratta__c=c.Id;
                    CEIToInsert.add(destinazione);
                }
                else{
                    OF_CommercialElementIstanziato__c unico = new OF_CommercialElementIstanziato__c();
                    unico.recordtypeId=rtMap.get('Tratte');
                    unico.OF_CaseTratta__c=c.Id;
                    CEIToInsert.add(unico);
                }
            }if(!CEIToInsert.isEmpty()){
                Insert CEIToInsert;
            }
            system.debug('@@@@@ IdMapNew= '+IdMapNew);
            map<id, list<opportunity>> mappaOpp = objU.CreateMap(IdMapNew);
            system.debug('@@@@@ mappaOpp= '+mappaOpp);
            map<id, order> mappaCase = new map<id, order>();
            list<Order> orders = new list<Order>();
            //OSCRM 30_08_2017 INIZIO
            map<id,case> caseCollegamento = objU.getCaseCollegamentoFields( CaseMap );
            //FINE
            for(id ix : mappaOpp.keyset())
            {
                opportunity opp = objU.FindOpportunity(ix,mappaOpp);
                system.debug('DG_OF_ManageOrderFromCase - opp: ' + opp);
                if(opp != null){
                    order o = objU.CreateOrderPO(ix, CaseMap, opp , caseCollegamento );
                    o.OF_CaseNome__c = caseFormula.get(o.OF_CaseID__c).casenumber;
                    o.OF_IDOrdineEOF__c = caseFormula.get(o.OF_CaseID__c).Codice_Ordine_EOF__c;
                    orders.add(o);
                    mappaCase.put(ix, o);
                }
            }
            system.debug('@@@@@ orders= '+orders);
            system.debug('@@@@@ mappaCase= '+mappaCase);
            if(orders.size() > 0) insert orders;
            
            
            for(Case c : caseToInsert){
                c.Of_order__c=mappaCase.get(c.id).id;
                system.debug('@@@@@ case= '+c.id+' @@@@ ordine= '+c.Of_order__c);
            }
            update caseToInsert;
            //chenges END
            
            return caseToInsert;
        }
        else{
            
            Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita'];
            for(case c : CaseFromPortal){
                c.EOF_fase__c='In Lavorazione Supporto Vendite';
                c.OwnerId=codaSupportoVendite.Id;
            }
            update CaseFromPortal;
            return null;
        }
    }
    
    public Pagereference UpdateChildcaseInfo()
    {
        editchildparentCaseObj = new case();
        
        editchildparentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                  PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:childcaseobj.parentid Limit 1];
        
        if(childcaseobj!=null)
        {
            update childcaseobj;
        }
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+editchildparentCaseObj.id);
        
    }
    // public attachement parentAttachment{get;set;}
    public pagereference AddParentAttachment()
    {
        return new pagereference('/apex/PO_AddAttachment?id'+parentCaseObj.id);
    }
    public pagereference parentupload() {
        attachment.clear();
        attachment.OwnerId = UserInfo.getUserId();
        attachment.ParentId = parentCaseObj.id;
        //attachment.IsPrivate = true;
        attachment.name = fileName;
        attachment.body = fileBody;
        
        try {
            system.debug('Comming here in try==>'+attachment);
            insert attachment;
            ordine = true;
            if(attachment.id != null)
            {
                newAtt = [select id,name,createddate,parentid,ownerid from attachment where id =:attachment.id];
            }
            system.debug('newAtt========='+newAtt);
        } catch (DMLException e) {
            system.debug('error======'+e.getStackTraceString());
            system.debug('Comming here in catch==>'+attachment);
            
        } finally {
            system.debug('Comming here in finally==>'+attachment);
            attachment.body = null;
            attachment = new Attachment();
        }
        parentfile = false;
        system.debug('attachment========='+attachment);
        return new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
    }
    public pagereference uploadCSV()
    {
        testcase.PO_Nome_Progetto__c = Nome;
        update testcase;
        system.debug('Nome======='+Nome);
        system.debug('testcase======='+testcase);
        
        try
        {
            parentCaseObj = [select id,PO_Numero_Anni__c,PO_Note_Modifica_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Offerta__c,casenumber,status,CreatedDate,PO_Durata_Affitto__c,OwnerId from case where id=:testcase.id];
            parentCaseObj.PO_Nome_Progetto__c = Nome;
            update parentCaseObj;
            Nome = '';
            system.debug('parentCaeObj======='+parentCaseObj);
        }
        catch(exception e)
        {
            system.debug('error message====='+e.getStackTraceString());
        }
        return new pagereference ('/apex/po_Uploadcsv?id'+parentCaseObj.id);
    }
    public Pagereference ReadFile(){
        if(contentFile== null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da importare'));
            return null;
        }else{
            if(parentCaseObj.PO_Offerta__c == 'IRU'){
                String rtnValue = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(contentFile, accId, parentCaseObj,'iru');
                System.debug('******* Parent offer = IRU && rtnValue = ' + rtnValue);
                List<String> rtnValueEsito = rtnValue.split('-');
                System.debug('******* Parent offer = IRU && rtnValueSplitted = ' + rtnValueEsito);
                if(rtnValueEsito.size() > 1){
                    if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'SYNC'){
                        return IRU();
                    }else if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'BATCH' ){
                        PageReference pg = new PageReference('/apex/PO_Result_Import');
                        return pg;
                    }else if(rtnValueEsito[0] =='File' && rtnValueEsito[1] == 'Error'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'File non valido!'));
                        return null;
                    }else{
                        PageReference pg = new PageReference('/apex/PO_JunkCases');
                        pg.getParameters().put('id', rtnValueEsito[1]);
                        pg.getParameters().put('parentId', parentCaseObj.Id);
                        return pg;
                    }
                }
            }
            if(parentCaseObj.PO_Offerta__c == 'Fiber Link'){
                String rtnValue = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(contentFile, accId, parentCaseObj,'fiberlink');
                System.debug('******* Parent offer = FiberLink && rtnValue = ' + rtnValue);
                List<String> rtnValueEsito = rtnValue.split('-');
                System.debug('******* Parent offer = FiberLink && rtnValueSplitted = ' + rtnValueEsito);
                if(rtnValueEsito.size() > 1){
                    if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'SYNC'){
                        return Fiberlink();
                    }else if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'BATCH' ){
                        PageReference pg = new PageReference('/apex/PO_Result_Import');
                        return pg;
                    }else if(rtnValueEsito[0] =='File' && rtnValueEsito[1] == 'Error'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'File non valido!'));
                        return null;
                    }else{
                        PageReference pg = new PageReference('/apex/PO_JunkCases');
                        pg.getParameters().put('id', rtnValueEsito[1]);
                        pg.getParameters().put('parentId', parentCaseObj.Id);
                        return pg;
                    }
                }
            }
            if(parentCaseObj.PO_Offerta__c == 'Fiber Lease'){
                String rtnValue = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(contentFile, accId, parentCaseObj,'fiberlease');
                System.debug('******* Parent offer = FiberLease && rtnValue = ' + rtnValue);
                List<String> rtnValueEsito = rtnValue.split('-');
                System.debug('******* Parent offer = FiberLease && rtnValueSplitted = ' + rtnValueEsito);
                if(rtnValueEsito.size() > 1){
                    if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'SYNC'){
                        return Fiberlease();
                    }else if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'BATCH' ){
                        PageReference pg = new PageReference('/apex/PO_Result_Import');
                        return pg;
                    }else if(rtnValueEsito[0] =='File' && rtnValueEsito[1] == 'Error'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'File non valido!'));
                        return null;
                    }else{
                        PageReference pg = new PageReference('/apex/PO_JunkCases');
                        pg.getParameters().put('id', rtnValueEsito[1]);
                        pg.getParameters().put('parentId', parentCaseObj.Id);
                        return pg;
                    }
                }
            }
            if(parentCaseObj.PO_Offerta__c == 'Evento Temporaneo'){
                String rtnValue = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(contentFile, accId, parentCaseObj,'temporaneo');
                System.debug('******* Parent offer = Evento Temporaneo && rtnValue = ' + rtnValue);
                List<String> rtnValueEsito = rtnValue.split('-');
                System.debug('******* Parent offer = Evento Temporaneo && rtnValueSplitted = ' + rtnValueEsito);
                if(rtnValueEsito.size() > 1){
                    if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'SYNC'){
                        return MistoFiber();
                    }else if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'BATCH' ){
                        PageReference pg = new PageReference('/apex/PO_Result_Import');
                        return pg;
                    }else if(rtnValueEsito[0] =='File' && rtnValueEsito[1] == 'Error'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'File non valido!'));
                        return null;
                    }else{
                        PageReference pg = new PageReference('/apex/PO_JunkCases');
                        pg.getParameters().put('id', rtnValueEsito[1]);
                        pg.getParameters().put('parentId', parentCaseObj.Id);
                        return pg;
                    }
                }
            }
            if(parentCaseObj.PO_Offerta__c == 'P2P Base'){
                String rtnValue = PO_ImportaCollegamentiMassivo.ReadP2PBase(contentFile, accId, parentCaseObj,'p2pbase');
                System.debug('******* Parent offer = P2PBase && rtnValue = ' + rtnValue);
                List<String> rtnValueEsito = rtnValue.split('-');
                System.debug('******* Parent offer = P2PBase && rtnValueSplitted = ' + rtnValueEsito);
                if(rtnValueEsito.size() > 1){
                    if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'SYNC'){
                        PageReference pg = new PageReference('/apex/PO_Index');
                        return pg;
                    }else if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'BATCH' ){
                        PageReference pg = new PageReference('/apex/PO_Result_Import');
                        return pg;
                    }else if(rtnValueEsito[0] =='File' && rtnValueEsito[1] == 'Error'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'File non valido!'));
                        return null;
                    }else{
                        PageReference pg = new PageReference('/apex/PO_JunkCases');
                        pg.getParameters().put('id', rtnValueEsito[1]);
                        pg.getParameters().put('parentId', parentCaseObj.Id);
                        return pg;
                    }
                }
            }
            
            
            //update parentcase;
            //Convert the uploaded file which is in BLOB format into a string
            searchCaseBoolean=false;
            nameFile =blobToString( contentFile,'ISO-8859-1');
            
            //Now sepatate every row of the excel file
            filelines = nameFile.split('\n');
            
            //parentCaseObj = [select id,PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Note_Modifica_Offerta__c,casenumber,status,CreatedDate from case where id=:testcase.id];
            //Iterate through every line and create a Case record for each row
            recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_Lease'];
            recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_link'];
            recordtype rt3 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P'];
            recordtype rt4 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_IRU'];
            recordtype rt5 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'];
            recordtype rt6 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P_Attiva']; //EC add new recordType PO_Collegamento_P2P_Attiva
            casestoupload = new List<Case>();
            for (Integer i=1;i<filelines.size();i++)
            {
                String[] inputvalues = new String[]{};
                    inputvalues = filelines[i].split(',');
                OF_ElencoComuniItaliani__c comune = [select id,OF_Comune__c from OF_ElencoComuniItaliani__c where OF_Comune__c =:inputvalues[0] limit 1];
                system.debug('comune name==='+inputvalues[0] );
                system.debug('comune==='+comune);
                Case c = new Case();
                c.parentid = parentCaseObj.id;
                if(parentCaseObj.PO_Offerta__c == 'P2P Base')
                {
                    c.RecordTypeId = rt3.id;
                }
                //EC inseriamo la parte relativa a P2P Attiva 2018 - 07 -13
                
                if(parentCaseObj.PO_Offerta__c == 'P2P Attiva')
                {
                    c.RecordTypeId = rt6.id;
                }
                //EC end
                c.Status = 'Bozza';
                c.accountid = accId;
                c.PO_Richiesta_a_fattibilit__c = parentCaseobj.id;
                c.PO_Comune2__c = comune.id;
                c.PO_Prime_Contractor__c = inputvalues[1];
                c.PO_Tipo_di_collegamento__c = inputvalues[2];
                c.PO_Numero_fibre_richieste__c = inputvalues[3];
                c.PO_Tipo_percorso__c = inputvalues[4];
                c.PO_Sito__c = inputvalues[5];
                c.PO_Indirizzo_collegamento__c = inputvalues[6];
                c.PO_Civico__c = inputvalues[7];
                c.PO_Nota_sito__c = inputvalues[8];
                c.PO_Sito_partenza__c = inputvalues[9];
                c.PO_Indirizzo_collegamento_partenza__c = inputvalues[10];
                c.PO_Civico_partenza__c = inputvalues[11];
                c.PO_Nota_sito_partenza__c = inputvalues[12];
                casestoupload.add(c);
            }
            try
            {
                insert casestoupload;
                ChildCases = [SELECT Case.Parent.casenumber,PO_IndrizoCal__c,Case.parent.PO_Offerta__c,
                              Case.parent.CreatedDate, Case.parent.Status, CaseNumber,
                              PO_Nome_Comune__c,PO_Durata_mesi__c, po_comune2__c,PO_Comune2__r.OF_Comune__c, 
                              Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Richiesta_a_fattibilit__r.casenumber,
                              PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c, Priority,Previous_Status__c, CreatedDate, 
                              CreatedById , PO_Offerta__c,OwnerId
                              from case where id IN :casestoupload
                              order by casenumber ASC ];
                
                update ChildCases;
                
                return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
            }
            catch(exception e)
            {
                ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured reading the CSV file'+e.getMessage());
                ApexPages.addMessage(errormsg);
            }
            return null;
        }
    }
    public List<Case> getuploadedCases()
    {
        if (casestoupload!= NULL)
            if (casestoupload.size() > 0)
            return casestoupload;
        else
            return null;
        else
            return null;
    }
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }
    
    public PageReference DeleteParentChildCase()
    {
        Boolean isChild=False;
        Case ParentCaseToshow = new Case();
        String parentCasetoDelID = apexpages.currentPage().getparameters().get('id');
        system.debug('Eliminia'+parentCasetoDelID);
        
        List<Case> ChildCasetoDel = new List<Case>();
        if(parentCasetoDelID!= null && parentCasetoDelID!= ''){
            ChildCasetoDel=[Select id from Case where parentid=:ParentCasetoDelID];
            if(ChildCasetoDel.size()>0)
            {
                system.debug('Eliminia Inside Child'+ChildCasetoDel);
                isChild=true;
                Database.delete(ChildCasetoDel,False);
            }
            if(!isChild){
                ParentCasetoShow=[Select Id,ParentID from Case where Id=:parentCasetoDelID];
            }
            Database.delete(parentCasetoDelID,False);
            
        }
        
        return new pagereference('/apex/PO_index');
        
    }
    public  pagereference deleteChildAlone()
    {
        string parentCasetoDelID = '';
        id idrec = apexpages.currentPage().getparameters().get('id');
        
        if(idrec != null)
        {
            parentCasetoDelID = idrec;
        }
        else if(ChildCase != null)
        {
            parentCasetoDelID = ChildCase.id;
        }
        else if(ChildCaseobj != null)
        {
            parentCasetoDelID = ChildCaseobj.id;
        }
        system.debug('parentCasetoDelID==='+idrec);
        case rectoDel = [select id,parentid from case where id=:parentCasetoDelID];
        string parentrec = rectoDel.parentid;
        parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                         PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:parentrec Limit 1];
        
        system.debug('rectoDel==='+rectoDel);
        Delete rectoDel;
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                    CaseNumber,PO_Comune2__c,PO_Civico__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c,PO_IndrizoCal__c,PO_Durata_mesi__c,OwnerId, CreatedDate, CreatedById , PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                                    from case where parentId=:parentCaseObj.id
                                    order by CreatedDate ASC];
        //system.debug('ChildCases====='+ChildCases);
        if(childcaseList.size()>0){
            ChildCases = childcaseList;
        }
        if(childcaseList.size()==0 && parentCaseObj != null)
        {
            system.debug('entering======'+ChildCases);
            ChildCases = childcaseList;
            return new pageReference('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
        }
        return new pageReference('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
        
    }
    
    Public pagereference contList()
    {
        showcon = false;
        return new pageReference('/apex/PO_ContactListPage');
    }
    
    Public pagereference EditContact()
    {
        return new pageReference('/apex/PO_EditContactPage');
    }
    //added by Alessandro 2017_09_01
    public pagereference OpenStreamList(){
        return new pageReference('/PO_OpenStream_DisplayRequest');
    }
    
    //Add by PG - C&D - 22-11
    public pagereference OpenStreamCeDList(){
        return new pageReference('/PO_OpenStream_CeD_DisplayRequest');
    }
    
    //Add by PG - C&D - 26-11
    public pagereference GponPassivaCeDList(){
        return new pageReference('/PO_GPON_Passiva_CeD_DisplayRequest');
    }
    
    //added by Antonio A.(STEP SRL) 2018_05_25
    public pagereference LineeAttive(){
        return new pageReference('/LineeAttive');
    }     
    
    //Add by PG - C&D - 22-11
    public pagereference LineeAttiveCeD(){
        return new pageReference('/PO_OpenStream_CeD_LineeAttive');
    }  
    
    //Add by PG - C&D - 26-11
    public pagereference LineeAttiveGPON_PassivaCeD(){
        return new pageReference('/PO_GPON_Passiva_CeD_LineeAttive');
    }  
    
    public pagereference  redirectparentcasedetail()
    {
        //ParentDate=string.valueof(parentCaseobj.CreatedDate);
        searchCaseBoolean=true;
        //Id caseid = ApexPages.currentPage().getParameters().get('CaseDetail');
        string attNamenew='';
        string attname='';
        selectedIdComune = '';
        selectedIdComune1 = '';
        selectedIdComune2 = '';
        newAtt.clear();
        attxlxs.clear();
        searchCaseBoolean=false;
        attlst.clear();
        parentfile = false;
        Ordine = false;
        stagename = false;
        Id parentId =  ApexPages.currentPage().getParameters().get('CaseDetail');
        string prid = parentId;
        system.debug('prid===='+prid);
        system.debug('parentId===='+parentId);
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                    CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.id,PO_Nome_Comune__c
                                    from case where (parentId=:parentId OR parentId=:prid)
                                    order by CreatedDate ASC];
        system.debug('ChildCases====='+childcaseList);
        if(childcaseList.size()>0)
            ChildCases = childcaseList;
        system.debug('ChildCases====='+ChildCases);
        if(childcaseList.size()>0){
            
            
            system.debug('parentId====='+parentId);
            if(parentId !=NULL) {
                parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                 PO_Offerta__c,ClosedDate,OwnerId,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c from case where id =:parentId Limit 1];
                
                
                system.debug('parentCaseObj======'+parentCaseObj);
                opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];
                
                
                if(opp.size()>0 && !opp.isEmpty())
                {
                    if(opp[0].PO_Prezzo_totale_scontato__c != null)
                    {
                        Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
                    }
                    
                    if(opp[0].stagename=='Offerta presentata')
                    {
                        stagename = true;
                    }
                }
                
                if(parentid != null)
                {
                    // attlst = attlstnew;
                    list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                               ORDER BY createddate DESC limit 1];
                    for(attachment att : newlst )
                    {
                        attnamenew = att.Name;
                        
                        if(attnamenew.contains('.pdf'))
                        {
                            newAtt.add(att);
                            system.debug('Attachment==='+newAtt);
                        }
                    }
                    list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
                                                   ORDER BY createddate DESC];
                    for(attachment att : attlstnew )
                    {
                        attname = att.Name;
                        system.debug('Attachment==='+att.Name);
                        
                        if(attname.containsIgnoreCase('.pdf'))
                        {
                            attlst.add(att);
                            system.debug('Attachment==='+attlst);
                        }
                        
                    }
                    if(attlst.size()>1)
                    {
                        attlst.remove(0);
                    }
                    
                    list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                                   ORDER BY createddate DESC];
                    for(attachment att : newlstxlxs )
                    {
                        String attnamexlxs = att.Name;
                        
                        if(attnamexlxs.contains('.xlsx'))
                        {
                            attxlxs.add(att);
                            system.debug('Attachment==='+attxlxs);
                        }
                    }
                    
                }
                if(parentCaseObj.Status == 'Accettato')
                {
                    System.debug('testdate---');
                    Datetime fieldDate;
                    Datetime attachDate;
                    List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
                    List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                           ORDER BY createddate DESC Limit 1];
                    for(CaseHistory ch:csh)
                    {
                        System.debug('testdate---1');
                        fieldDate=ch.createdDate;
                    }
                    
                    for(Attachment ah:ash)
                    {
                        System.debug('testdate---2');
                        attachDate=ah.createdDate;
                    }
                    If(fieldDate<attachDate) {
                        System.debug('testdate---3'+fieldDate);
                        System.debug('testdate---3'+attachDate);
                        ordine=true;
                    }
                }
                if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
                {
                    parentfile = true;
                }
                if( parentCaseObj.PO_isDataOrder__c ==true)
                {
                    ordine =false;
                }
            }
        }
        if(parentId !=NULL && childcaseList.size()==0) {
            
            parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                             PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
            system.debug('entering========'+parentCaseObj);
            ChildCases = childcaseList;
            return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
        }
        
        system.debug('ChildCases===='+parentCaseObj.status);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);
        
        //  ParentDate=parentCaseobj.CreatedDate.format('dd/MM/yyyy HH:mm:ss');
        //  system.debug('CreatedDate====='+ParentDate);
        //   system.debug('parentCaseObj====='+parentCaseObj);
        //   pagereference redirectparentcasedetailpgref = new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+caseid );
        //   return  redirectparentcasedetailpgref;
        
    }
    public pagereference  redirectparentcasedetailNew()
    {
        //ParentDate=string.valueof(parentCaseobj.CreatedDate);
        searchCaseBoolean=false;
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                         PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:caseId Limit 1];
        
        ParentDate=parentCaseobj.CreatedDate.format('dd/MM/yyyy HH:mm:ss');
        pagereference redirectparentcasedetailpgref = new pagereference('/apex/Po_FeasibilityServicesRequest6?id='+parentCaseObj.id );
        return  redirectparentcasedetailpgref;
    }
    
    public  pagereference  redirectchildcasedetail()
    {
        
        
        Id caseid = ApexPages.currentPage().getParameters().get('CaseDetail');
        childcasedisplayobj = new case();
        childoppobj = new opportunity();
        
        childcasedisplayobj = [select id,parent.id,parent.PO_Offerta__c,PO_Sito__c,PO_Indirizzo_collegamento__c,PO_Civico__c,PO_Nome_Comune__c,PO_Sito_partenza__c ,PO_Indirizzo_collegamento_partenza__c,
                               PO_Civico_partenza__c,PO_Tipo_percorso__c,PO_Tipo_di_collegamento__c,PO_Numero_fibre_richieste__c,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratta_seconda_via__c ,
                               PO_Pop_1_di_riferimento2__c,PO_Pop_1_di_riferimento2__r.name,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c ,PO_Pop_2_di_riferimento2__c,PO_Pop_2_di_riferimento2__r.name,casenumber,Status,PO_Prime_Contractor__c,PO_Tempi_di_attivazione_mesi__c,
                               PO_Disponibilit_della_rete_a_partire_da__c,Note_Sospensione_Operatore__c,PO_Offerta__c,parent.status,OwnerId      from case  where id=:childcasedisplayid];
        //childDate=childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.format('dd/MM/yyyy HH:mm:ss');
        //  childDate=childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c;
        if(childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c != null)
        {
            Integer d = childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.day();
            Integer mo = childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.month();
            Integer yr = childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.year();
            
            DateTime DT = DateTime.newInstance(yr, mo, d);
            //DateTime dtt =  datetime.newInstanace(childDate.Year(),childDate.month().childDate.day()) ;
            system.debug('childDate====='+DT);
            childDate = DT.format('dd/MM/yyyy');
            system.debug('childDate====='+childDate);
        }
        childcasedisplayattlist = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId
                                   ORDER BY createddate DESC];
        
        System.debug('@@@@ childcasedisplayattlist' + childcasedisplayattlist );
        
        IndirizzoCliente =childcasedisplayobj.PO_Indirizzo_collegamento__c+' '+childcasedisplayobj.PO_Civico__c+', '+childcasedisplayobj.PO_Nome_Comune__c;
        
        if(childcasedisplayobj.PO_Nome_Comune3__c != null){
            IndirizzoSede1diTerminazione = childcasedisplayobj.PO_Indirizzo_collegamento_partenza__c+' '+childcasedisplayobj.PO_Civico_partenza__c +','+ childcasedisplayobj.PO_Nome_Comune3__c ;
        }
        if(childcasedisplayobj.PO_Nome_Comune3__c == null){
            IndirizzoSede1diTerminazione = childcasedisplayobj.PO_Indirizzo_collegamento_partenza__c+' '+childcasedisplayobj.PO_Civico_partenza__c ;
        }
        
        String collegamento = childcasedisplayobj.PO_indirizzo_collegamento_3__c;
        string civico = childcasedisplayobj.PO_Civico_3__c;
        string comune = childcasedisplayobj.PO_Nome_Comune4__c ;
        if(childcasedisplayobj.PO_indirizzo_collegamento_3__c== null)
        {
            collegamento ='';
        }
        if(childcasedisplayobj.PO_Civico_3__c== null)
        {
            civico ='';
        }
        if(childcasedisplayobj.PO_Nome_Comune4__c == null)
        {
            comune ='';
        }
        
        IndirizzoSede2diTerminazione = collegamento +' '+civico +','+comune ;
        
        if(childcasedisplayobj.PO_Nome_Comune4__c == null)
        {
            IndirizzoSede2diTerminazione = collegamento +' '+civico ;
        }
        
        
        if(childcasedisplayobj.id!=null && (childcasedisplayobj.parent.status=='In approvazione Cliente' ||childcasedisplayobj.parent.status=='Accettato' )){
            try{
                childoppobj= [select id,PO_Totale_contributi_attivazione__c,PO_Sconto_contributi_attivazione__c,PO_Totale_contributi_attivazione_scontat__c, PO_CanoneCollegamentoScontato__c,PO_ContributoAttivazCollegamScontato__c
                              ,PO_Costi_aggiuntivi_collegamento_scontat__c,PO_CanoneManutenzioneCollegScontato__c,PO_CorrispettivoIRUCollegamentoScontato__c
                              from Opportunity where PO_Collegamento__c=:childcasedisplayobj.id limit 1 ];
                system.debug('parentoppobj1====='+childoppobj.PO_CanoneCollegamentoScontato__c);
                /* if(parentoppobj!= null){
system.debug('parentoppobj====='+parentoppobj);
system.debug('parentoppobj1====='+parentoppobj.PO_CanoneCollegamentoScontato__c);
system.debug('parentoppobj2====='+parentoppobj.PO_ContributoAttivazCollegamScontato__c + parentoppobj.PO_Costi_aggiuntivi_collegamento_scontat__c);
}  */
            }
            catch(exception e)
            {
                
                system.debug('exception'+e);
            }
        }
        
        pagereference Po_FeasibilityServicesRequest7pgref = new pagereference('/apex/Po_FeasibilityServicesRequest7?id='+caseid);
        return  Po_FeasibilityServicesRequest7pgref;
    }
    
    public pagereference DetailPage1()
    {
        
        string attNamenew='';
        string attname='';
        
        
        parentcaseobj = [select id,status,CaseNumber,PO_Durata_affitto__c,OwnerId, PO_Nome_Progetto__c,PO_Offerta__c,CreatedDate,closedDate,PO_Note_Modifica_Offerta__c from case where id=:ParentCaseDisplay.id limit 1];
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                    CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c,PO_IndrizoCal__c,OwnerId,PO_Durata_affitto__c, CreatedDate, CreatedById , PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                                    from case where parentId=:parentcaseobj.id
                                    order by CreatedDate ASC];
        if(childcaseList.size()>0)
            ChildCases = childcaseList;
        list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =:  parentcaseobj.id AND IsPrivate = false
                                   ORDER BY createddate DESC limit 1];
        for(attachment att : newlst )
        {
            attnamenew = att.Name;
            
            if(attnamenew.contains('.pdf'))
            {
                newAtt.add(att);
                system.debug('Attachment==='+newAtt);
            }
        }
        list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentcaseobj.id
                                       ORDER BY createddate DESC];
        for(attachment att : attlstnew )
        {
            attname = att.Name;
            system.debug('Attachment==='+att.Name);
            
            system.debug('Attachment==='+attlst);
            if(attname.containsIgnoreCase('.pdf'))
            {
                attlst.add(att);
                
            }
            
        }
        if(attlst.size()>1)
        {
            attlst.remove(0);
        }
        
        list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =:  parentcaseobj.id AND IsPrivate = false
                                       ORDER BY createddate DESC];
        for(attachment att : newlstxlxs )
        {
            String attnamexlxs = att.Name;
            
            if(attnamexlxs.contains('.xlsx'))
            {
                attxlxs.add(att);
                system.debug('Attachment==='+attxlxs);
            }
        }
        system.debug('Boolean2'+searchCaseBoolean);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentcaseobj.id);
    }
    
    public pagereference detailparentcase()
    {
        if(searchCaseboolean==false){
            
            return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+childcasedisplayobj.parentid);
        }
        else
        {
            system.debug('Boolean1'+searchCaseBoolean);
            return new PageReference ('/apex/PO_index');
        }
    }
    
    public PageReference SearchCase()
    {
        Ricerca= true;
        searchCaseboolean=true;
        offertaSelected='';
        OffertaCheck='';
        /*
Cases=[select Casenumber, Status,OwnerId, CreatedDate,PO_Tipo_di_collegamento__c,PO_Prime_Contractor__c,PO_Tipologia_Offerta_ordine__c,PO_Tipologia_Offerta__c ,PO_Offerta__c,PO_CreatedDate__c,PO_Case_Type_Formula__c,PO_Nome_Comune__c,PO_Nome_Progetto__c from Case where PO_Case_Type_Formula__c = null ];
EOFOpenStream=[Select ID,EOF_Codice_Ordine_OLO__c,EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c,EOF_ID_Pop__c,EOF_Data_Notifica__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c from EOF_EAI_Service_Log__c where id=null];
EOFTroubleTicket=[Select Id from EOF_EAI_Service_Log__c where id=null];
*/
        // EOFOpenStream=new List<EOF_EAI_Service_Log__c>();
        //EOFTroubleTicket=new List<EOF_EAI_Service_Log__c>();
        return new PageReference ('/apex/PO_SearchRequest');
    }
    
    public PageReference homePageRef()
    {
        
        searchCaseboolean=true;
        // cases.clear();
        return new PageReference ('/apex/PO_Index');
        
    }
    
    public pagereference OpportunityStageNameUpdate5()
    {
        
        inlineshow = true;
        list<opportunity> opplst = [select id,name,PO_Prezzo_totale_scontato__c,stagename,PO_Richiesta_fattibilit__c from opportunity
                                    where id in : opp limit 1
                                   ];
        
        
        if(opplst.size()>0 && !opplst.isEmpty())
        {
            
            if(opplst[0].stagename == 'Offerta presentata')
            {
                opplst[0].StageName = 'Offerta accettata';
                update opplst[0];
            }
            
        }
        if(parentCaseObj != null)
        {
            // if( opplst[0].StageName != null)
            {
                // parentCaseObj.Status = 'Accettato';
                // parentCaseObj.OwnerId = UserInfo.getUserId();
                // parentCaseObj.PO_Durata_affitto__c=durataaff;
                //   system.debug('childcaselst======='+durataaff);
            }
            
            update parentCaseObj;
            list<case> childcaselst = [select id,PO_IndrizoCal__c,PO_Incluso_nell_offerta__c,PO_Comune2__c,status,casenumber,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
                                       PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                       PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                       recordtype.id,recordtype.developerName,OwnerId from case where parentid=:parentCaseObj.id and PO_Incluso_nell_offerta__c = true];
            
            system.debug('childcaselst======='+parentCaseObj.PO_Durata_affitto__c);
            if(parentCaseObj.PO_Durata_affitto__c == null && parentCaseObj.PO_Offerta__c == 'Fiber Link')
            {
                ApexPages.addMessage(
                    new ApexPages.Message(ApexPages.Severity.error,'Inserire il numero di anni di affitto di interesse, cliccando su Modifica.'));
                
            }
            
            else
            {
                if(childcaselst.size()>0)
                {
                    OrderCreation(childcaselst);
                    parentfile = true;
                    stagename = false;
                    
                    // PO_ServiziFattibilita_Controller.OrderCreation(childcaselst);
                }
            }
            
            
        }
        // return null;
        Quote qt = [select id,opportunity.PO_Richiesta_fattibilit__r.id from Quote where opportunity.PO_Richiesta_fattibilit__r.id =:parentCaseObj.id limit 1];
        
        return savePDF_FiberLinkPortal(qt.id,parentCaseObj.PO_Durata_affitto__c);
        
    }
    
    
    
    
    
    
    
    public boolean checkIRU {get; set;}
    public boolean checkP2P {get; set;}
    public boolean checkFibLink {get; set;}
    public boolean checkFibLease {get; set;}
    public boolean checkFibLeaseMisto {get;set;}
    public boolean checkEventoTemp {get; set;}
    
    //CRM 24_08 INIZIO
    public boolean check1Anno {get;set;}
    public boolean check2Anni {get;set;}
    public boolean check3Anni {get;set;}
    public boolean checkAltriAnni {get;set;}
    public boolean CheckNumAnni {get;set;}
    //FINE
    
    public string strMese {get;set;}
    
    public String idquote;
    public quote q {set;get;}
    public opportunity opp1 {get; set;}
    
    /**Parte di XLS**/
    public blob xlsxBlob;
    public string xlsxname;
    public string header;
    public string bod;
    public String finalstr{set;get;}
    public boolean checkEmpty {get; set;}
    public ID RichiestaFattibil {get;set;}
    /*****************/
    
    public string NameAttachmentXLSX{get;set;}
    
    //   public OF_PDF_OffSediController()
    //   {
    //
    //  }
    
    public Opportunity getOpportunity()
    {
        idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + idquote);
        
        q = [select id, name, Opportunity.name, account.name,
             Account.BillingStreet,Account.BillingCity,
             Account.BillingState,Account.BillingPostalCode,
             PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
             PO_ContaPDF__c
             from Quote
             where id = :idquote];
        opportunity opp1 = [select id, name, recordtype.name, PO_Numero_Anni__c, PO_Richiesta_fattibilit__r.casenumber,PO_Richiesta_fattibilit__r.PO_Nome_Progetto__c,
                            PO_Special_Terms__c,PO_oppty_validit_offerta__c,PO_Note__c,PO_Richiesta_fattibilit__r.PO_Durata_mesi__c,
                            PO_Totale_Canone_Anno1_Scontato__c,PO_TotaleContributiAttivaAnno1Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontat__c,
                            PO_Totale_Canone_Anno2_Scontato__c,PO_TotaleContributiAttivaAnno2Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontati__c,
                            PO_Totale_Canone_Anno3_Scontato__c,PO_TotaleContributiAttivaAnno3Scontati__c,PO_TotaleCostiAggiuntiviAnno3Scontat__c,
                            PO_Totale_Canone_Altri_Anni_Scontato__c,PO_TotContributiAttivaAltriAnniScontati__c,PO_TotaleCostiAggiuntiviAltriAnnoScontat__c,
                            PO_Totale_canoni_scontato__c,PO_Totale_canoni_manutenzione_scontato__c,PO_Totale_corrispettivi_IRU_scontati__c,
                            PO_Totale_contributi_attivazione_scontat__c,PO_Totale_costi_aggiuntivi_scontati__c,
                            PO_Totale_scontat_valori_medi_altre_cop__c,PO_Totale_valori_medi_annui_scontato__c,PO_Totale_valori_fino_2030_scontato__c,
                            (select id, name,
                             PO_SceltaAnno1__c,PO_SceltaAnno2__c,PO_SceltaAnno3__c,PO_SceltaAltriAnni__c,
                             PO_Costi_aggiuntivi_collegamento_scontat__c, PO_ContributoAttivazCollegamScontato__c, PO_CanoneCollegamentoScontato__c,
                             PO_CorrispettivoIRUCollegamentoScontato__c,PO_CanoneManutenzioneCollegScontato__c,
                             PO_Totale_costi_aggiuntivi_scontati__c, PO_Totale_contributi_attivazione_scontat__c, PO_Totale_canoni_scontato__c, PO_Totale_canoni_manutenzione_scontato__c,
                             PO_Canone_annuo_Collegamento1anno_Scont2__c,PO_Contributo_annuo_Colleg1anno_Scontat2__c,PO_Costi_Aggiuntivi_Anno1_Scontati__c,
                             PO_Canone_annuo_Collegamento2anno_Scont2__c,PO_Contributo_annuo_Colleg2anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno2_Scontati__c,
                             PO_Canone_annuo_Collegamento3anno_Scont2__c,PO_Contributo_annuo_Colleg3anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno3_Scontati__c,
                             PO_Canone_annuo_altri_anni_Scontato2__c ,PO_Contributo_Attivaz_altri_anni_Scont2__c,PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c,
                             PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c, PO_Collegamento__r.PO_Lunghezza_tratte_complessiva__c,
                             PO_Collegamento__r.PO_Numero_fibre_richieste__c, PO_Collegamento__r.PO_Civico__c, PO_Collegamento__r.PO_Indirizzo_collegamento__c,
                             PO_Collegamento__r.PO_Prime_Contractor__c, PO_Collegamento__r.PO_Nome_Comune__c,PO_Collegamento__r.PO_Sito__c,
                             PO_Collegamento__r.casenumber,PO_Durata_mesi__c,PO_Collegamento__r.PO_Tipo_percorso__c,
                             PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c,PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via__c,
                             PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name,PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.name,PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c,
                             PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.PO_Indirizzo__c,PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.PO_Indirizzo__c,
                             PO_Collegamento__r.PO_Nome_Comune3__c,PO_Collegamento__r.PO_Lunghezza_tratta_prima_via_FiberLink__c,
                             PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c,PO_Collegamento__r.PO_Civico_partenza__c,PO_Collegamento__r.PO_Sito_partenza__c,
                             PO_Valore_totale_coppia_fino_2030_sconta__c,PO_Valore_medio_annuo_altre_coppie_scont__c,PO_Valore_medio_annuo_totale_coll_scont__c,
                             PO_Collegamento__r.PO_Sito_3__c,PO_Collegamento__r.PO_indirizzo_collegamento_3__c,PO_Collegamento__r.PO_Nome_Comune4__c,PO_Collegamento__r.PO_Civico_3__c,
                             PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via_FiberLin__c
                             from Opportunities__r
                             where PO_Incluso_nell_offerta__c = true)
                            from Opportunity
                            where id =: q.OpportunityId];
        system.debug('DG_PDF_getOpportunity opp: ' + opp1);
        
        //TotPrezzi(opp);
        
        FindOppo(opp1);
        
        return opp1;
    }
    
    public date getdate()
    {
        return system.today();
    }
    
    public void FindOppo(opportunity opp)
    {
        checkIRU = false;
        checkP2P = false;
        checkFibLink = false;
        checkFibLease = false;
        checkEventoTemp = false;
        checkFibLeaseMisto = false;
        
        if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità IRU')
        {
            checkIRU = true;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità')
        {
            checkP2P = true;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Fiber Link')
        {
            checkFibLink = true;
            
            if(opp.PO_Numero_Anni__c != null)
                CheckNumAnni = true;
            else
                CheckNumAnni = false;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Evento Temporaneo')
        {
            checkEventoTemp = true;
            if(opp.PO_Richiesta_fattibilit__r.PO_Durata_mesi__c == 1)
                strMese = 'mese';
            else
                strMese = 'mesi';
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Fiber Lease')
        {
            system.debug('OF_PDF_OffSediController_FindOppo dentro fiber lease');
            checkFibLease = true;
        }else if(opp.RecordType.name == 'PO Oppty richiesta fattibilità Misto Lease-Link per FW')
        {
            system.debug('OF_PDF_OffSediController_FindOppo dentro fiber lease misto');
            checkFibLeaseMisto = true;
        }
    }
    //CRM 24_08 INIZIO
    public void FindAnnoFiberLink()
    {   system.debug('Quote Selected'+ApexPages.currentPage().getParameters().get('Duratta'));
     Integer duratta=Integer.valueOF(ApexPages.currentPage().getParameters().get('Duratta'));
     check1Anno = false;
     check2Anni = false;
     check3Anni = false;
     checkAltriAnni = false;
     
     
     if( duratta > 3 )
     {
         checkAltriAnni = true;
     }else{
         
         if( duratta == 1 )
         {
             check1Anno = true;
         }else if( duratta == 2 )
         {
             check2Anni = true;
         }else if( duratta == 3 )
         {
             check3Anni = true;
         }
     }
     system.debug('FindAnnoFiberLink check1Anno:'+check1Anno+'-check2Anni:'+check2Anni+'-check3Anni:'+check3Anni+'-checkAltriAnni:'+checkAltriAnni);
    }
    //FINE
    
    /**Bottoni*/
    public PageReference savePDF() {
        PageReference thePDF = Page.OF_PDF_OffSedi;
        thePDF.getParameters().put('id',q.Id);
        thePDF.setRedirect(true);
        
        quotedocument qd = new quotedocument();
        if( Test.isRunningTest())
        {
            qd.document = blob.toPdf('test');
        }else{
            qd.document = thePDF.getContentAsPDF();
        }
        qd.quoteId = q.Id;
        insert qd;
        
        if(q.PO_ContaPDF__c == null)
            q.PO_ContaPDF__c = 0;
        
        q.PO_ContaPDF__c ++;
        update q;
        
        //Modifico il file aggiungendo nel title l'estensione .pdf
        ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
        //ContDoc.Title = ContDoc.Title + '.pdf';
        ContDoc.Title = q.name + ' _ ' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '_' + q.PO_ContaPDF__c + '.pdf';
        update ContDoc;
        
        NameAttachmentXLSX = q.name + ' _ ' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '_' + q.PO_ContaPDF__c + '.xlsx';
        
        PageReference quotePage = new PageReference('/'+ q.Id);
        quotePage.setRedirect(true);
        return null;
    }
    
    public PageReference ToReturn() {
        PageReference quotePage = new PageReference('/'+ q.Id);
        quotePage.setRedirect(true);
        return quotePage;
    }
    
    //CRM 24/08/2017 INIZIO
    public PageReference savePDF_FiberLink()
    {
        idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + idquote);
        
        q = [select id, name, Opportunity.name, account.name,
             Account.BillingStreet,Account.BillingCity,
             Account.BillingState,Account.BillingPostalCode,
             PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
             PO_ContaPDF__c
             from Quote
             where id = :idquote];
        PageReference thePDF = Page.OF_PDF_FiberLink;
        thePDF.getParameters().put('id',q.Id);
        
        thePDF.setRedirect(true);
        
        quotedocument qd = new quotedocument();
        
        if( Test.isRunningTest())
        {
            qd.document = blob.toPdf('test');
        }else{
            qd.document = thePDF.getContentAsPDF();
        }
        //qd.document = thePDF.getContentAsPDF();
        qd.quoteId = q.Id;
        insert qd;
        
        //Modifico il file aggiungendo nel title l'estensione .pdf
        ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
        //ContDoc.Title = ContDoc.Title + '.pdf';
        ContDoc.Title = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.pdf';
        update ContDoc;
        
        NameAttachmentXLSX = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.xlsx';
        
        PageReference quotePage = new PageReference('/'+ q.Id);
        quotePage.setRedirect(true);
        return quotePage;
        // return new pagereference ('/apex/PO_SearchRequest');
        
        
    }
    //24/08/2017 FINE
    /**END Bottoni**/
    public PageReference savePDF_FiberLinkPortal(id idquote,Decimal Duratta)
    {
        //idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + idquote);
        List<quotedocument> qdList = new List<quotedocument>();
        Boolean qdInserted;
        q = [select id, name, Opportunity.name, account.name,
             Account.BillingStreet,Account.BillingCity,
             Account.BillingState,Account.BillingPostalCode,
             PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
             PO_ContaPDF__c
             from Quote
             where id = :idquote];
        
        check1Anno = false;
        check2Anni = false;
        check3Anni = false;
        checkAltriAnni = false;
        
        system.debug('Duratta Selected'+ q.PO_Durata_affitto__c);
        if( Duratta > 3 )
        {
            checkAltriAnni = true;
        }else{
            
            if( Duratta == 1 )
            {
                check1Anno = true;
            }else if(Duratta == 2 )
            {
                check2Anni = true;
            }else if( Duratta == 3 )
            {
                check3Anni = true;
            }
        }
        system.debug('FindAnnoFiberLink check1Anno:'+check1Anno+'-check2Anni:'+check2Anni+'-check3Anni:'+check3Anni+'-checkAltriAnni:'+checkAltriAnni);
        
        
        //PageReference thePDF = Page.OF_PDF_FiberLink;
        PageReference thePDF = Page.PO_FiberLinkPDF;
        thePDF.getParameters().put('id',q.id);
        thePDF.getParameters().put('duratta',string.valueOF(Duratta));
        thePDF.setRedirect(true);
        system.debug('Quoteid============='+q.id);
        
        
        quotedocument qd = new quotedocument();
        if( Test.isRunningTest())
        {
            qd.document = blob.toPdf('test');
        }else{
            try{
                qd.document = thePDF.getContent();
            }
            Catch(exception e)
            {
                system.debug('Exception'+e);
            }
        }
        // qd.document = thePDF.getContentAsPDF();
        //qd.document = blob.toPdf('test');
        qd.quoteId = q.Id;
        qdList.add(qd);
        Database.SaveResult[] srList = Database.insert(qdList, false);
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                qdInserted=true;
            }
        }
        system.debug('Quote Document============='+qd);
        PageReference thePDF1 = Page.PO_FiberLinkPDF;
        thePDF1.getParameters().put('id',q.Id);
        //Modifico il file aggiungendo nel title l'estensione .pdf
        ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
        //ContDoc.Title = ContDoc.Title + '.pdf';
        ContDoc.Title = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.pdf';
        update ContDoc;
        
        NameAttachmentXLSX = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.xlsx';
        Quote qt = [select id,opportunity.PO_Richiesta_fattibilit__r.id from Quote where id =:q.id limit 1];
        // PageReference quotePage = new PageReference('/apex/Po_FeasibilityServicesRequest2?id='+ qt.opportunity.PO_Richiesta_fattibilit__r.id);
        //return quotePage;
        parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                         PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:qt.opportunity.PO_Richiesta_fattibilit__r.id Limit 1];
        parentCaseObj.OwnerId = UserInfo.getUserId();
        update parentCaseObj;
        if(qdInserted==true){
            parentCaseObj.Status='Accettato';
            update parentCaseObj;
        }
        system.debug('parentCaseObj====='+parentCaseObj);
        return redirectparentcasedetailpdf(parentCaseObj.id,qd.id);
    }
    /**Parte di XLSX**/
    //Tabella dell'offerta totale della fiber link
    public string Tabella1FiberLink(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1FiberLink 1');
        
        
        if(CheckNumAnni == true)
        {
            header = '\tAffitto 1 anno\tAffitto 2 Anni\tAffitto 3 Anni\tAffitto '+ opp.PO_Numero_Anni__c + 'Anni<br/>';
            bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_Canone_Anno1_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno2_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno3_Scontato__c + '\t' + opp.PO_Totale_Canone_Altri_Anni_Scontato__c + '<br/>'
                + 'Contributo di attivazione' + '\t' + opp.PO_TotaleContributiAttivaAnno1Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno2Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno3Scontati__c + '\t' + opp.PO_TotContributiAttivaAltriAnniScontati__c + '<br/>'
                + 'Costi Aggiuntivi' + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontati__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno3Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAltriAnnoScontat__c + '<br/>';
        }
        else{
            header = '\tAffitto 1 anno\tAffitto 2 Anni\tAffitto 3 Anni <br/>';
            bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_Canone_Anno1_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno2_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno3_Scontato__c + '<br/>'
                + 'Contributo di attivazione' + '\t' + opp.PO_TotaleContributiAttivaAnno1Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno2Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno3Scontati__c + '<br/>'
                + 'Costi Aggiuntivi' + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontati__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno3Scontat__c + '<br/>';
        }
        
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1FiberLink 2 bod: ' + bod);
        return bod;
    }
    //Tabella dell'offerta totale dell'IRU
    public string Tabella1IRU(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Canone Manutenzione Annuo' + '\t' + opp.PO_Totale_canoni_manutenzione_scontato__c + '<br/>'
            + 'Corrispettivi IRU' + '\t' + opp.PO_Totale_corrispettivi_IRU_scontati__c + '<br/>'
            + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
            + 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';
        
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);
        
        return bod;
    }
    //Tabella dell'offerta totale della P2P e Evento Temporaneo
    public string Tabella1P2P(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>'
            + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
            + 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';
        
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);
        
        return bod;
    }
    //Tabella dell'offerta totale della Fiber Lease
    public string Tabella1FiberLease(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Totale costi aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>'
            + 'Totale valori medi altre coppie' + '\t' + opp.PO_Totale_scontat_valori_medi_altre_cop__c + '<br/>'
            + 'Totale valori medi annui' + '\t' + opp.PO_Totale_valori_medi_annui_scontato__c + '<br/>'
            + 'Totale valori fino 2030' + '\t' + opp.PO_Totale_valori_fino_2030_scontato__c + '<br/>';
        
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);
        
        return bod;
    }
    //Tabella dell'offerta totale della Fiber Lease Misto
    public string Tabella1FiberLeaseMisto(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Totale costi aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>'
            + 'Totale valori medi altre coppie' + '\t' + opp.PO_Totale_scontat_valori_medi_altre_cop__c + '<br/>'
            + 'Totale valori medi annui' + '\t' + opp.PO_Totale_valori_medi_annui_scontato__c + '<br/>'
            + 'Totale valori fino 2030' + '\t' + opp.PO_Totale_valori_fino_2030_scontato__c + '<br/>'
            + 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>'
            + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>';
        
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);
        
        return bod;
    }
    //Tabella dati toponomastici dei collegamenti
    public string TabellaDatiToponomastici(opportunity opp)
    {
        bod = null;
        header = null;
        list<opportunity> OppCollList = opp.Opportunities__r;
        
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        if(checkP2P || checkEventoTemp)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente <br/>';
        }else
            if(checkFibLink)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tSede 1 di terminazione\tIndirizzo Sede 1 di terminazione\tSede 2 di terminazione\tIndirizzo Sede 2 di terminazione <br/>';
        }else
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tSede 1 di terminazione\tIndirizzo Sede 1 di terminazione <br/>';
        }
        
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;
            
            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c;
            
            if(checkP2P || checkEventoTemp)
            {
                StringTopon =   StringTopon + '<br/>';
            }else
                if(checkFibLink)
            {
                StringTopon =   StringTopon + '\t' +
                    OppCol.PO_Collegamento__r.PO_Sito_partenza__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune3__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Sito_3__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_indirizzo_collegamento_3__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_3__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune4__c +
                    '<br/>';
            }else
            {
                StringTopon =   StringTopon + '\t' +
                    OppCol.PO_Collegamento__r.PO_Sito_partenza__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune3__c + '\t' +
                    '<br/>';
            }
            if(bod == null)
                bod = StringTopon;
            else
                bod = bod + StringTopon;
            
        }
        return header + bod;
    }
    //Tabella dati metrici dei collegamenti
    public string TabellaDatiMetrici(opportunity opp)
    {
        bod = null;
        header = null;
        list<opportunity> OppCollList = opp.Opportunities__r;
        
        system.debug('DG_OF_CreateQuoteXLS_Controller_TabellaDatiMetrici header: ' + header);
        
        if(checkP2P ||checkEventoTemp)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tPop 1 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';
            
        }else if(checkFibLink || checkIRU)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tLunghezza 2° via\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';
        }else
            if(checkFibLease || checkFibLeaseMisto)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tLunghezza 2° via\tPop 1 di riferimento\tPop 2 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';
        }
        
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;
            
            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Tipo_percorso__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Numero_fibre_richieste__c + '\t';
            
            if(checkP2P ||checkEventoTemp)
            {
                StringTopon =   StringTopon +
                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name + '\t' +
                    OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' +
                    string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) +
                    '<br/>';
            }else
                if(checkFibLink || checkIRU)
            {
                
                StringTopon =   StringTopon +
                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' +
                    string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) +
                    '<br/>';
            }else
                if(checkFibLease || checkFibLeaseMisto)
            {
                StringTopon =   StringTopon +
                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via_FiberLink__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via_FiberLin__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name + '\t' +
                    OppCol.PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.name + '\t' +
                    OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' +
                    string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) +
                    '<br/>';
            }
            if(bod == null)
                bod = StringTopon;
            else
                bod = bod + StringTopon;
            
        }
        return header + bod;
    }
    //Tabella Dettaglio offerta dei collegamenti
    public string TabellaDettaglioOfferta(opportunity opp)
    {
        bod = null;
        header = null;
        list<opportunity> OppCollList = opp.Opportunities__r;
        
        if(checkP2P ||checkEventoTemp)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone (euro) Anno\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
        }else
            if(checkIRU)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone Manutenzione (euro) Anno\tCorrispettivo IRU (euro)\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
        }else
            if(checkFibLink)
        {
            if(CheckNumAnni == true)
            {
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone affitto 1 anno (euro/anno)\tContributo di attivazione 1 anno (euro)\tContributo aggi. 1 anno (euro)\t'+
                    'Canone affitto 2 anni (euro/anno)\tContributo di attivazione 2 anni (euro)\tContributo aggi. 2 anni (euro)\t'+
                    'Canone affitto 3 anni (euro/anno)\tContributo di attivazione 3 anni (euro)\tContributo aggi. 3 anni (euro)\t'+
                    'Canone affitto '+opp.PO_Numero_Anni__c+' anni (euro/anno)\tContributo di attivazione '+opp.PO_Numero_Anni__c+' anni (euro)\tContributo aggi. '+opp.PO_Numero_Anni__c+' anni (euro)<br/>';
                
            }
            else{
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone affitto 1 anno (euro/anno)\tContributo di attivazione 1 anno (euro)\tContributo aggi. 1 anno (euro)\t'+
                    'Canone affitto 2 anni (euro/anno)\tContributo di attivazione 2 anni (euro)\tContributo aggi. 2 anni (euro)\t'+
                    'Canone affitto 3 anni (euro/anno)\tContributo di attivazione 3 anni (euro)\tContributo aggi. 3 anni (euro)<br/>';
            }
        }
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;
            
            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t';
            
            if(checkP2P ||checkEventoTemp)
            {
                StringTopon =   StringTopon +
                    OppCol.PO_CanoneCollegamentoScontato__c + '\t' +
                    OppCol.PO_ContributoAttivazCollegamScontato__c + '\t' +
                    OppCol.PO_Costi_aggiuntivi_collegamento_scontat__c +
                    '<br/>';
            }else
                if(checkFibLink)
            {
                if(CheckNumAnni == true)
                {
                    StringTopon =   StringTopon +
                        OppCol.PO_Canone_annuo_Collegamento1anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg1anno_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno1_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_Collegamento2anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg2anni_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno2_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_Collegamento3anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg3anni_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno3_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_altri_anni_Scontato2__c + '\t' +
                        OppCol.PO_Contributo_Attivaz_altri_anni_Scont2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c +
                        '<br/>';
                }else{
                    StringTopon =   StringTopon +
                        OppCol.PO_Canone_annuo_Collegamento1anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg1anno_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno1_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_Collegamento2anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg2anni_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno2_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_Collegamento3anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg3anni_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno3_Scontati__c +
                        '<br/>';
                }
            }else
                if(checkIRU)
            {
                StringTopon =   StringTopon +
                    OppCol.PO_CanoneManutenzioneCollegScontato__c + '\t' +
                    OppCol.PO_CorrispettivoIRUCollegamentoScontato__c + '\t' +
                    OppCol.PO_ContributoAttivazCollegamScontato__c + '\t' +
                    OppCol.PO_Costi_aggiuntivi_collegamento_scontat__c +
                    '<br/>';
            }
            if(bod == null)
                bod = StringTopon;
            else
                bod = bod + StringTopon;
            
        }
        return header + bod;
    }
    
    
    public pagereference  redirectparentcasedetailPDF(id caseID,ID qdId)
    {
        selectedIdComune = '';
        selectedIdComune1 = '';
        selectedIdComune2 = '';
        
        string attNamenew='';
        string attname='';
        
        newAtt.clear();
        attxlxs.clear();
        searchCaseBoolean=false;
        attlst.clear();
        parentfile = false;
        Ordine = false;
        stagename = false;
        Id parentId = CaseId;
        string prid = parentId;
        system.debug('prid===='+prid);
        system.debug('parentId===='+parentId);
        parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                         PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:caseID Limit 1];
        system.debug('parentCaseObj===='+parentCaseObj);
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                    CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                                    from case where (parentId=:parentId OR parentId=:prid)
                                    order by CreatedDate ASC];
        if(childcaseList.size()>0)
            ChildCases = childcaseList;
        system.debug('ChildCases====='+ChildCases);
        if(childcaseList.size()>0){
            
            
            if(parentId !=NULL) {
                parentCaseObj = [SELECT CaseNumber, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                 PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
                
                
                
                opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];
                
                
                if(opp.size()>0 && !opp.isEmpty())
                {
                    if(opp[0].PO_Prezzo_totale_scontato__c != null)
                    {
                        Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
                    }
                    
                    if(opp[0].stagename=='Offerta presentata')
                    {
                        stagename = true;
                    }
                }
                
                if(parentid != null)
                {
                    
                    
                    // attlst = attlstnew;
                    list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false AND Name LIKE '%PDF%'
                                               ORDER BY createddate DESC limit 1];
                    for(attachment att : newlst )
                    {
                        attnamenew = att.Name;
                        
                        if(attnamenew.contains('.pdf'))
                        {
                            newAtt.add(att);
                            system.debug('Attachment==='+newAtt);
                        }
                    }
                    list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
                                                   ORDER BY createddate DESC];
                    for(attachment att : attlstnew )
                    {
                        attname = att.Name;
                        system.debug('Attachment==='+att.Name);
                        // if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))
                        
                        if(attname.containsIgnoreCase('.pdf'))
                        {
                            attlst.add(att);
                            system.debug('Attachment==='+attlst);
                        }
                    }
                    if(attlst.size()>1)
                    {
                        attlst.remove(0);
                    }
                    
                    list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                                   ORDER BY createddate DESC];
                    for(attachment att : newlstxlxs )
                    {
                        String attnamexlxs = att.Name;
                        
                        if(attnamexlxs.contains('.xlsx'))
                        {
                            attxlxs.add(att);
                            system.debug('Attachment==='+attxlxs);
                        }
                    }
                    
                }
                if(parentCaseObj.Status == 'Accettato')
                {
                    System.debug('testdate---');
                    Datetime fieldDate;
                    Datetime attachDate;
                    datetime qdDate;
                    List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
                    List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                           ORDER BY createddate DESC Limit 1];
                    List<QuoteDocument> qdlist=[select id,createddate from QuoteDocument where id=:qdid ORDER BY createddate DESC Limit 1];
                    for(CaseHistory ch:csh)
                    {
                        System.debug('testdate---1');
                        fieldDate=ch.createdDate;
                    }
                    
                    for(Attachment ah:ash)
                    {
                        System.debug('testdate---2');
                        attachDate=ah.createdDate;
                    }
                    If(fieldDate<attachDate) {
                        System.debug('testdate---3'+fieldDate);
                        System.debug('testdate---3'+attachDate);
                        
                        // ordine=true;
                    }
                    
                    if(parentCaseObj.PO_Offerta__c == 'Fiber Link')
                    {
                        for(quoteDocument ah:qdList)
                        {
                            System.debug('testdate---2');
                            qdDate=ah.createdDate;
                        }
                        If(fieldDate>qdDate) {
                            System.debug('testdate---3'+fieldDate);
                            System.debug('testdate---3'+attachDate);
                            
                            ordine=true;
                        }
                    }
                }
                if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
                {
                    parentfile = true;
                }
                if( parentCaseObj.PO_isDataOrder__c ==true)
                {
                    ordine =false;
                }
            }
            
        }
        if(parentId !=NULL && childcaseList.size()==0) {
            parentCaseObj = [SELECT CaseNumber, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                             PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
            system.debug('entering========'+parentCaseObj);
            ChildCases = childcaseList;
            return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
        }
        
        system.debug('OutsideLoop===='+parentId);
        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);
    }
    public String IdScelta{get;set;}
    
    //PG - 11-04 - SEGNALAZIONE PROVISIONING - START
    public pageReference viewStatoOrdine()
    {
        PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
        pg.getParameters().put('proc','TPVisualizza');
        pg.getParameters().put('origId',IdScelta);
        return pg;
    }
    //PG - 11-04 - SEGNALAZIONE PROVISIONING - END
    
    //PG - 03-05 - INCIDENT MANAGEMENT - START
    public pageReference viewDettaglioIncident()
    {
        PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
        pg.getParameters().put('proc','TPVisualizzaIncident');
        pg.getParameters().put('origId',IdScelta);
        return pg;
    }
    //PG - 03-05 - INCIDENT MANAGEMENT - END
    
    public PageReference ViewCaseDettail()
    {
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('proc','TTVisualizza');
        pg.getParameters().put('origId',IdScelta);
        return pg;
    }
    
    public String tipoRichiestaOP{get;set;}
    public String IdInserita{get;set;}
    
    public pageReference vediReq(){
        //AA Modifica per gestione pagina dettaglio Change Order
        if(tipoRichiestaOP.equalsIgnoreCase('Change Order')){
            Pagereference pg = new Pagereference('/PO_CO_DetailChangeOrder');
            pg.getParameters().put('idRisorsa',IdInserita);
            return pg;
        }
        Pagereference pg = new Pagereference('/PO_OpenStreamService_InsertNewRequest');
        if(tipoRIchiestaOP=='Attivazione'){
            pg.getParameters().put('proc','attivazioneInoltrata');
        }
        if(tipoRIchiestaOP=='Cessazione'){
            pg.getParameters().put('proc','cessazioneInoltrata');
        }
        pg.getParameters().put('origID',IdInserita);
        return pg;
    }
    
    //EC - 2018 - 05 - 21 Start CHANGEORDER
    
    public pagereference ServizioChangeOrder(){
        pagereference pr = new pagereference('/apex/PO_ChangeOrder_InsertNewRequest');
        pr.setRedirect(true);
        return pr;
    }
    /*
public pagereference ServizioOpenStream(){
pagereference pr = new pagereference('/apex/PO_OpenStreamService_InsertNewRequest');
pr.setRedirect(true);
return pr;
}
*/
    
    //EC 2018 - 05 - 21 END
    //EC 2018 - 05 - 21
    //public string rtAsset{get;set;}
    //public List<Asset> assetViewList {get; set;}
    public List<OF_CommercialElementIstanziato__c> getInfoPort(string rtAsset){
        ceiViewList = [select Id, OF_Case__r.ID, OF_Case__r.EOF_CODICE_ORDINE_OLO__c,
                       OF_Case__r.CaseNumber, OF_Case__r.Status, OF_Case__r.EOF_Identificativo_del_POP__c,
                       OF_Case__r.EOF_GPON_Attestazione__c, OF_Case__r.EOF_Id_Risorsa__c, OF_Case__r.CreatedDate,
                       OF_Case__r.OF_SA_ID_Servizio__c, OF_Case__r.OF_SA_Profilo__c, OF_ProfiloVLAN__c,
                       OF_SA_CPE__c, OF_ServiceVLAN__c, OF_UserVLAN__c, OF_CustomerVLAN__c,
                       OF_Asset__c, OF_Asset__r.Name, OF_Asset__r.recordTypeId,
                       OF_Asset__r.recordtype.developerName, OF_Asset__r.OF_DataAttivazione2__c,
                       OF_Asset__r.OF_Stato__c, OF_Asset__r.OF_ProfiloOpenStream__c,
                       OF_Asset__r.OF_DataCessazione2__c
                       from OF_CommercialElementIstanziato__c WHERE OF_Asset__r.recordtype.developerName =: rtAsset];
        return ceiViewList;
    }
    //EC 2018 - 05 - 22 END
    
    //EC Start P2P Attiva as OpenStream searchProfile method
    public PageReference runSearchProfilo() {
        
        String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo');  
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
        If(objListino != null && objListino.IsPortalValid__c==true){
            profiloCommerciale=(string)objListino.OF_ProfiloCommerciale__c; 
        }else{
            profiloCommerciale= 'N/A';          
        }
        //profiloCommerciale ='TEST 2 TEST';
        viewError=false;
        viewProfilo=true;
        return null;
    }
    
    //EC end P2P attiva as OpenStream searchProfile method
    
    
    
    //EC Start metodo scegliTipoRichiesta P2PAttiva
    
    public void scegliTipoReq(){
        //tipiReq = new List<String>();    
        requestOptions= new List<SelectOption>();
        requestOptions.add(new SelectOption('ATT','Ordine di Attivazione'));
        requestOptions.add(new SelectOption('CESS','Ordine di Cessazione'));
        //  optScelta=SelectOption.getLabel();
    }
    
    //EC start 2018 - 07 - 17 
    //in base al tipo di richiesta selezionato  inserire un parameter
    
    public Pagereference toP2PAttiva(){
        //Add parameters getParameters().put('key', 'value') 
        PageReference pageRef = new PageReference('');
        
        System.debug('EC @@@@@@il valore di requestSelected è ' + requestSelected);
        if(requestSelected=='ATT'){
            pageRef = new PageReference('/apex/PO_P2PAttiva_Req');  
            pageref.getParameters().put('P2PattAttivazione','P2PattAttivazione');
            
            pageref.getParameters().put('Nome',Nome);
            system.debug('@@@@nel metodo toP2PAttiva nell\'if della richiesta di attivazione, pageRef vale ' + pageRef);
            
        }
        if(requestSelected=='CESS'){
            pageRef = new PageReference('/apex/PO_P2PAttiva_InserimentoIdRisorsa');
            pageref.getParameters().put('P2PattCessazione','P2PattCessazione');
            pageref.getParameters().put('Nome',Nome);
            system.debug('@@@@nel metodo toP2PAttiva nell\'if della richiesta di cessazione, pageRef vale ' + pageRef);
        }
        
        pageRef.setRedirect(true);
        system.debug('@@@@nel metodo toP2PAttiva, pageRef vale alla fine ' + pageRef);
        return pageref;
    }
    //EC end 2018 - 07 - 17
    
    //start EC 2018 - 07 - 20 P2P Attiva metodo per la creazione del Log
    public EOF_EAI_Service_Log__c creaSlP2PAttivaPadre(){
        P2PAttivaLogPadre = new EOF_EAI_Service_Log__c ();
        
        insert P2PAttivaLogPadre;
        return P2PAttivaLogPadre;
        
        
    }
    
    public EOF_EAI_Service_Log__c creaSlP2PAttivafiglio(EOF_EAI_Service_Log__c P2PAttivaLogPadre){
        
        P2PAttivaLog = new EOF_EAI_Service_Log__c ();
        
        insert P2PAttivaLog;
        return P2PAttivaLog;
        
    }
    
    //End EC 2018 - 07 - 20 P2P Attiva metodo per la creazione del Log
    //CR 7 26/06/2019 FOR Segnalazione Provisioning SOC
    public pagereference ServizioTP_SOC(){
        
        PageReference ref = new pagereference('/PO_TP_InsertNewRequest_SOC');
        ref.getParameters().put('azione', 'Provisioning');
        return ref;
    } 
     //Azione='Provisioning'
    public pagereference TPList_SOC(){
        
        PageReference ref = new pageReference('/PO_TP_DisplayRequest_SOC');
        ref.getParameters().put('azione', 'Provisioning');
        return ref;
    }
    
}
public with sharing class PO_KIT_Controller {

    public boolean secD{get;set;}
    public boolean showServizia2 {get;set;}
    public boolean showServizia3 {get;set;}//AS
    public boolean showServizia4 {get;set;}//AM
    public boolean showIncidentManagement {get;set;} //Add by PG - 09-05
    public boolean show2 {get;set;}
    public boolean show3 {get;set;}
    public boolean show5 {get;set;}
    public boolean show7 {get;set;} //rerender per sezione kit
    public boolean showEdit{get;set;}
    public list<case> currentUserCases {get;set;}

    //PP --------------------------PREPROV
    public boolean secC{get;set;}
    public String recordOfferta {get;set;}
    public boolean secB{get;set;}
    public String OffertaCheck{get;set;}
    public String OffertaSelected{get;set;}
    public boolean searchCaseBoolean{get;set;}
	public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public boolean Ricerca{get;set;}
    public EOF_EAI_Service_Log__c sl{get;set;}
    public boolean modifyMode{get;set;}
    public boolean insertMode{get;set;}
    public boolean Apparati{get;set;}
    public String DATA_PREVISTA_ATTIVAZIONE{get;set;}
    public Map<String,Id> rtMap;
    //public string profiloCommerciale{get;set;}
    //public string dataPrevistaAttivazione{get;set;}
    public boolean viewError{get;set;}
    public boolean viewProfilo{get;set;}
    public string Note{get;set;} 
    public string nomeAzienda {get;set;}
    //PP fine--------------------------PREPROV

    public List<User> contactUserList {get;set;}

    //private String soql {get;set;}
    //public List<Case> Cases{get;set;}
    //public List<OF_CommercialElementIstanziato__c> ceiViewList {get;set;}  //ADD by EC 2018 - 05 - 22
    //public ApexPages.StandardSetController setCon {get;set;}
    public string nomeOfferta {get;set;}
    public String nomekit {get;set;}
    public String ModelloServizio {get;set;}
    public String POP{get;set;}
    public String BandaInterfaccia {get;set;}
    public String PosizioneODF {get;set;}
    public String Traffico {get;set;}
    public String nomeTraffico {get;set;}
    //public String ServiziUtentiFinali {get;set;}
    public String interfaccia {get;set;}
    
    //costruttore    
    public PO_KIT_Controller(){
     	
        //modifyMode=false;
     	insertMode=false;
     	Apparati=false;

     	viewError=false;
        //nomeAzienda = 'Prova';
        //nomeOfferta = 'KIT';
         
       //EC 20181130 commentiamo valori precedenti.  String[] traffico = new String[]{'VULA Openstream Direct','VULA Openstream City Edge','BITSTREAM - Openstream Regional'};
		String[] traffico = new String[]{'VULA','VULA Direct','BITSTREAM'}; //EC nuovi valori. 20181130
		this.elencoTRAFFICO = new SelectOption[]{};
		
		for (String t: traffico) {
			this.elencoTRAFFICO.add(new SelectOption(t,t));
		}
		
		String[] interfaccia = new String[]{'None','1 Giga','10 Giga'};
		this.elencoInterfacce = new SelectOption[]{};
		
        for (String i: interfaccia) {
			this.elencoInterfacce.add(new SelectOption(i,i));
		}
         
        String[] offerte = new String[]{'KIT','VLAN'};
		this.elencoOfferte = new SelectOption[]{};
		
		for (String c: offerte) {
			this.elencoOfferte.add(new SelectOption(c,c));
		}
         
     	if(slOrig!=null){
     		sl=slOrig;
     		modifyMode=true;
     		if(ApexPages.currentPage().getParameters().get('app') =='true'){
     			Apparati=true;
     		}
     	}
     	else{
            
     		insertMode=true;
     		User attuale=[select Id,Account.EOF_Codice_Operatore__c ,Account.name from user where Id=:userinfo.getUserId()];
            nomeAzienda = attuale.Account.name;
	     	sl = new EOF_EAI_Service_Log__c();
	    	List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
	        rtMap = new Map<String,Id>(); 
	        
	        for(recordtype rt :rtList){
	            rtMap.put(rt.developerName, rt.Id); 
	        }
	    	sl.recordtypeId=rtMap.get('PO_PP_KIT');
	    	sl.EOF_Stato_Richiesta__c='Bozza Portale';
	    	sl.EOF_CODICE_OPERATORE__c=attuale.Account.EOF_Codice_Operatore__c;
	    	sl.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
     	}
    }

	public SelectOption[] elencoOfferte {
		public get;
		private set;
	}
	public SelectOption[] elencoTRAFFICO {
		public get;
		private set;
	}
	public SelectOption[] elencoInterfacce {
		public get;
		private set;
	}
	
	//SALVA
    public pageReference savesl(){
    	
        try{
            //AS MODIFICA CALENDARIO
            //System.debug('### mt string date'  +dataPrevistaAttivazione);
            //sl.EOF_DATA_PREVISTA_ATnomekitTIVAZIONE__c=date.parse(dataPrevistaAttivazione);
            
            sl.Nome_del_KIT__c='';//nomekit;
            sl.Modello_di_Servizio__c='';//ModelloServizio;
            sl.POP__c=POP;
            sl.Banda_Interfaccia__c = BandaInterfaccia;
            
            if(interfaccia.equalsIgnoreCase('None')){
                sl.PO_PP_Interfaccia__c = '';
            }
            else{
                sl.PO_PP_Interfaccia__c = interfaccia;
            }
            
            sl.Posizione_ODF__c='';//PosizioneODF;
            sl.Traffico__c = Traffico;
            sl.Servizi_per_utenti_finali__c='';//ServiziUtentiFinali;
            sl.EOF_Comunicazioni_con_OLO__c=Note;
            //sl.EOF_Codice_Ordine_OLO__c='Accettato';
            
            insert sl; 
		}
		catch(DMLexception e){
			ApexPages.addMessages(e); 
			return null;
		}
        PageReference pg = new PageReference('/PO_RiepilogoKit');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origId',sl.Id);
        return pg;        
    }
    
    //ELIMINA RICHIESTA
    public pagereference DeleteSL()
    {
        system.debug('deleted DeleteSL==========');
        //delete sl;
        return new pagereference('/apex/po_index');
    }

    public user usr {
        get{
            return [
                Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
                contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
                contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
                contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,
                contact.PO_Servizio_Incident_Management__c, Contact.PO_Servizio_KIT__c 
                From User
                Where Id =:System.UserInfo.getUserId()
            ];
        }
    }

    public boolean isSuperUser {
        get{
            User u =  [Select Contact.PO_Super_User__c From User Where Id =:System.UserInfo.getUserId()];
            return u.Contact.PO_Super_User__c;
            //return false;
        }
    }
    public pageReference redirectToRegPage(){
        return null;
    }

    public Pagereference contactInformation(){
        return null;
    }

    public pageReference deleteUserContact(){
        return null;
    }
    public pagereference ParentCaseRecord(){   
        return null;
    }
    public pagereference Fiberlease()
    {
        return null;
    }
    public pagereference Fiberlink()
    {
        return null;
    }
    public pagereference IRU()
    {
        return null;
    }
    public pagereference MistoFiber()
    {
        return null;
    }

    public pagereference ServizioOpenStream(){
        return null;
    }

    // AS START
    public pagereference ServizioTT(){
        return new pagereference('/PO_TT_InsertNewRequest');
    }

    public pagereference TTList(){
        return new pageReference('/PO_TT_DisplayRequest');
    }

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
    
    /*PREPROV 09-07*/
    public pagereference redirectServizioKIT(){
        pagereference pr = new pagereference('/apex/PO_PP_InfoKit');
        pr.setRedirect(true);
        return pr;
    } 
    
    public pagereference redirectFindKIT(){
        pagereference pr = new pagereference('/apex/PO_PP_FindKitPage');
        pr.setRedirect(true);
        return pr;
    } 

    public pagereference currentUserParentCases()
    {
        return null;
    }

    public  pagereference deleteChildAlone()
    {
        PageReference pg = new PageReference('/PO_PP_InserimentoKit');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origId',sl.Id);
        //richiestaAttivazione=false;
        //error=false;
        return pg;
    }

    public pagereference contList()
    {
        //showcon = false;
        return new pageReference('/apex/PO_ContactListPage');
    }

    public pagereference EditContact()
    {
        return new pageReference('/apex/PO_EditContactPage');
    }
    //added by Alessandro 2017_09_01
    public pagereference OpenStreamList(){
        return new pageReference('/PO_OpenStream_DisplayRequest');
    }
    //added by Antonio A.(STEP SRL) 2018_05_25
    public pagereference LineeAttive(){
        return new pageReference('/LineeAttive');
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
}
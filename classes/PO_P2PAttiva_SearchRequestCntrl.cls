public class PO_P2PAttiva_SearchRequestCntrl {
    public String soql {get;set;}
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
    public List<EOF_EAI_Service_Log__c>  P2PAttivaLogList {get;set;} //EC 2018 - 07 - 20 P2PAttiva
    public ApexPages.StandardSetController setConP2PAttiva {get;set;} //EC 2018 - 07 - 20 P2PAttiva
    public String OffertaSelected{get;set;}
    public String StatoSelected{get;set;}
    public String OffertaCheck{get;set;}
    public ApexPages.StandardSetController setCon {get;set;}
    public List<Case> Cases{get;set;}
    public Boolean searchCaseboolean{get;set;}
    public String selectedValueTipo{get;set;}
	public String selectedValueStato{get;set;}
    public String selectedValueIdPop{get;set;}
    public String selectedValueIdStatoOrdine{get;set;}
    public String ParentDate{get;set;}
    public Case parentCaseObj {get;set;}
	public id childcasedisplayid{get;set;}
    public list<attachment> newAtt {get;set;}
    public list<attachment> attlst {get;set;}
    public list<attachment> attxlxs {get;set;}
	public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
  //  public String searchTerm1 {get; set;}
    public String selectedIdComune1 {get; set;}
   // public String searchTerm2 {get; set;}
    public String selectedIdComune2 {get; set;}
    public string comune {get;set;}
    public boolean caseobjbuttoncheck{get;set;}
    public boolean searchLogBoolean{get;set;}
    public list<case> ChildCases {get;set;}
    public list<case> ordercaselst {get;set;}
    public list<opportunity> opp{get;set;}
    public boolean parentfile {get;set;}
    public boolean StageName{get;set;}
    public boolean Ordine{get;set;}
    public String Prezzototale{get;set;}
	public opportunity childoppobj{get;set;}
    public case childcasedisplayobj{get;set;}
    public List<attachment> childcasedisplayattlist{get;set;}
	public string IndirizzoCliente{get;set;}
    public string IndirizzoSede1diTerminazione{get;set;}
    public string IndirizzoSede2diTerminazione{get;set;}
    public string childDate {set;get;}
    public string CaseDetail{get;set;}
    public Case childCaseObj {get;set;}
    public string offertEvento {get;set;}
    public string cliente {get;set;}
    public string cliente1 {get;set;}
    public string cliente2 {get;set;}
	public list<Attachment> orderAtt {get;set;}
    public string ordercasedispayordinedate{get;set;}

    
    public PO_P2PAttiva_SearchRequestCntrl(){
        
    }
    
    public void runQueryP2PAttiva(){
        try {
            setConP2PAttiva=new ApexPages.StandardSetController( Database.query(soql + ' order by ' + sortField2 + ' ' + sortDir+ ' limit 49999'));
            //Cases = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 49999');
            setConP2PAttiva.setpageSize(25);
            P2PAttivaLogList=setConP2PAttiva.getRecords();
            system.debug('OpenStreamQuery'+P2PAttivaLogList);
        } 
        catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }
    }
    
    //runSearchTicketProv
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
    
    // runs the search with parameters passed via Javascript
    public PageReference runSearch()
    {   // EOFTroubleTicket=new List<EOF_EAI_Service_Log__c>();
        // EOFOpenStream=new List<EOF_EAI_Service_Log__c>();
        String Offerta1= Apexpages.currentPage().getParameters().get('Offerta');
        offertaSelected=Offerta1;
        
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
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }
    }
    
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
    
    public void Offertaselect(){
        String Offerta1= Apexpages.currentPage().getParameters().get('Offerta');
        system.debug('l\'offerta del metodo Offertaselected è ' + Offerta1);
        offertaSelected=Offerta1;
        // Cases=[select Casenumber, Status,OwnerId, CreatedDate,PO_Tipo_di_collegamento__c,PO_Prime_Contractor__c,PO_Tipologia_Offerta_ordine__c,PO_Tipologia_Offerta__c ,PO_Offerta__c,PO_CreatedDate__c,PO_Case_Type_Formula__c,PO_Nome_Comune__c,PO_Nome_Progetto__c from Case where PO_Case_Type_Formula__c = null ];
        soql = 'select Casenumber,contact.accountid,Status,PO_Case_Type_Formula__c,PO_Tipo_di_collegamento__c,PO_Tipologia_Offerta_ordine__c,PO_Tipologia_Offerta__c ,PO_CreatedDate__c,PO_Offerta__c, CreatedDate,PO_Prime_Contractor__c,PO_Nome_Comune__c,PO_Nome_Progetto__c,OwnerId from Case where PO_Case_Type_Formula__c = null ';
        StatoSelected = '';
        runQuery();
        system.debug('Selected Offerta '+OffertaSelected);
        // return null;
    }
    
    public PageReference homePageRef(){
        
        searchCaseboolean=true;
        // cases.clear();
        return new PageReference ('/apex/PO_Index');
        
    }
    
    public List<SelectOption> getTipodilist() {
        
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
        
        return null ;
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
    
    public void toggleSort()
    {
        // simply toggle the direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        // run the query again
        runQuery();
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

        return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);

        //  ParentDate=parentCaseobj.CreatedDate.format('dd/MM/yyyy HH:mm:ss');
        //  system.debug('CreatedDate====='+ParentDate);
        //   system.debug('parentCaseObj====='+parentCaseObj);
        //   pagereference redirectparentcasedetailpgref = new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+caseid );
        //   return  redirectparentcasedetailpgref;

    }
    
    /*metodo new... to delete?
     * public pagereference  redirectparentcasedetailNew()
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
    */
    
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
            }
            catch(exception e)
            {

                system.debug('exception'+e);
            }
        }

        pagereference Po_FeasibilityServicesRequest7pgref = new pagereference('/apex/Po_FeasibilityServicesRequest7?id='+caseid);
        return  Po_FeasibilityServicesRequest7pgref;
    }
    
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
    
    
    
}
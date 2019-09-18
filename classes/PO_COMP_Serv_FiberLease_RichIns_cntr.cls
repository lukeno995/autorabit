public class PO_COMP_Serv_FiberLease_RichIns_cntr 
{
    public boolean showRichiesteInserite {get; set;} 
    public User attuale {get; set;} 
    
    public Id accId;

    public List<EOF_EAI_Service_Log__c> listInserite{get;set;}
    
     
    public List<EOF_EAI_Service_Log__c> listInseriteDaEsportare{get;set;}
    //public boolean richieste{get;set;}
    public String IdInserita{get;set;}
    public String tipoRichiesta{get;set;}
    public Integer totalRecord{get;set;}    
    public Integer pageActual{get;set;}
    public Decimal totalpage{get;set;}
    
    
    
    //RUNSEARCH
    public String DataInizioCreazione{get;set;}
    public String DataFineCreazione{get;set;}
    public List<String> ListStatus{get;set;}
    public String selectValueL2{get;set;}

    public String valRich {get;set;}    //DA CAPIRE
    public String valOff {get;set;}
    public String valNomP {get;set;}
    
    public list<attachment> attlst {get;set;}
    public list<attachment> newAtt {get;set;}
    public list<attachment> attxlxs {get;set;}    
    
    public boolean showPag{get;set;}
    
    public Decimal pageRecord{get;set;}  
    
    public Integer totRec{get;set;}
    public Decimal totpg{get;set;}
    
    
    
    public Boolean filtered{get;set;}
    public String soql {get;set;}
    public String soqlCount {get;set;}
    public String listInseritestring {get;set;} 
    public boolean isPaginationRun {get;set;}
    public Case parentCaseObj {get;set;}
  //  public Case parentCase { get; set;}
  //  public Case ChildCase{get;set;}
    public string offertEvento {get;set;}
    
    //EC start 2018 - 11 - 10
    public String Nome{get;set;} 
    
    public Case parentCase{get;set;}    //Case di fattibilità
    public String parentCaseId {get;set;}//stringa per l'id del case di fattibilità
    public Case collCase{get;set;} //Case di collegamento FiberLease
    public Case orderCase {get;set;} //Case di ordine FiberLease
    
    public List<Case> fattCaseList {get;set;}
    public List<Case> collCaseList {get;set;}
    public List<Case> ordCaseList {get;set;}
    PageReference pg{get;set;}
   //EC end 2018 - 11 - 10 
   
   //EC start 2018 - 11 - 11
   
   
   
 //  public String recordOfferta{get;set;}
   
   //EC end 2018 - 11 - 11
   
    public case testcase {get;set;}
   
    
    
    public String optTipoRichiestaString {get;set;}
    public String optStatoRichiestaString  {get;set;}
    
    
    public PO_COMP_Serv_FiberLease_RichIns_cntr(){ 
        //richieste=false;
        showRichiesteInserite = false;
        totalRecord=0;
        pageActual=0;
        totalpage=0;
        
        
        
        Integer off=0;  
        pageRecord=5;
        showPag=false; 
        filtered=false;
        isPaginationRun=false;
        attlst = new list<attachment>();
        newAtt = new list<attachment>();
        attxlxs = new list<attachment>();
        
        attuale=[select Id,AccountId,Account.EOF_Codice_Operatore__c,ContactId,Contact.AccountId from user where Id=:userinfo.getUserId()];
      //attuale = [select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        //offertEvento = apexpages.currentpage().getparameters().get('off');
        //EC start 2018 - 11 - 11
        
        //giovanni 24/01/2019 inizio
        
        String offerta='Fiber Lease';
        //giovanni 24/01/2019 inizio
        
        system.debug('@@@@@@@@@@@@EC nel controller, nel costruttore appena entriamo offertEvento è ' + offertEvento);
        if(offertEvento==null && offertEvento==''){
          offertEvento=offerta;
        }
        
       
        //EC end 2018 - 11 - 11
        
        listInserite=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                                                    OF_SA_PROFILO_VLAN__c,
                                                    EOF_Codice_Ordine_OLO__c,
                                                    PO_Offerta__c,
                                                    PO_Nome_Progetto__c,
                                                    CreatedDate,
                                                    EOF_STATO_ORDINE__c,
                                                    OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                                                    OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,
                                                    EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c,EOF_SL_Riferimento__c
                                                    from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_FiberLease_Request') AND EOF_Stato_Richiesta__c!='Bozza'
                                                    and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                                                    order by CreatedDate DESC LIMIT :(integer)pageRecord OFFSET :off];
        listInseritestring=JSON.serialize(listInserite);
        totRec=[SELECT count()   from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_FiberLease_Request') AND EOF_Stato_Richiesta__c!='Bozza'
                                                    and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c  ];
        totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
        
        
        //EC Start 2018 - 11 - 10 
        parentCaseId =ApexPages.currentPage().getParameters().get('parentId');/*EC 2018 - 11 - 06 il parametro passato per i case è o idBozza o parentId volendo uniformare ricorda di modificare anche i seguenti controller 
                                                                            PO_COMP_ListaRichiesteInBoz_Feasib_Ctrl
                                                                            PO_COMP_ListaRichiesteIns_Feasib_Ctrl*/
     
         system.debug('@@@@@@EC parentId valorizza la stringa parentCaseId: ' + parentCaseId);
        
        //EC end 2018 - 11 - 10
                
        System.debug('@@@size'+listInserite);
        if(!listInserite.isEmpty()){
            //richieste=true; 
            showRichiesteInserite = true;
            showPag=true;
            Set<String> setTipoRichiesta =new Set<String>();
            Set<String> setStatoRichiesta =new Set<String>();
            List<optionApex>optTipoRichiesta = new List<optionApex>();
            List<optionApex>optStatoRichiesta = new List<optionApex>();
            
              list <EOF_EAI_Service_Log__c> listStato=[select id,EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c
                                                    from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_FiberLease_Request') AND EOF_Stato_Richiesta__c!='Bozza'
                                                    and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c  and EOF_STATO_ORDINE__c in ('In Lavorazione',
                                                                                                                                    'Accettato',
                                                                                                                                    'Acquisito',
                                                                                                                                    'In Approvazione Cliente')
                                                    ];
            
            for(EOF_EAI_Service_Log__c mySL:listStato ){
                    setTipoRichiesta.add(mySL.EOF_Tipo_Comunicazione_String__c);
                    setStatoRichiesta.add(mySL.EOF_STATO_ORDINE__c);    
            }
            for(String myString:setTipoRichiesta ){
                 optTipoRichiesta.add(new optionApex(myString,myString));
            }    
            for(String myString:setStatoRichiesta ){
                 optStatoRichiesta.add(new optionApex(myString,myString));
            }
            
            optTipoRichiestaString=JSON.serialize(optTipoRichiesta);
            optStatoRichiestaString=JSON.serialize(optStatoRichiesta);
            setPagination(null);
        }
        
        
        
        
        
    }   
    
 // Instance fields
    public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
    public String searchTerm1 {get; set;}
    public String selectedIdComune1 {get; set;}
    public String searchTerm2 {get; set;}
    public String selectedIdComune2 {get; set;}
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
    //TO DO. Non deve creare un case, ma deve creare un log. il case viene creato in un secondo momento, così come avviene per p2p Attiva.
      public pagereference childCase()
    {
        return null;
    }

      

    public PageReference pageUp(){
        setPagination(true);
        return null;
    }
    public PageReference pageDown(){
        setPagination(false);
        return null;
    }

    public void setPagination(boolean next){ 
        if(next==null){
            if (filtered){
                soql += ' offset 0';
                runQuery();
                try{
                totRec = ((List<EOF_EAI_Service_Log__c>)Database.query(soqlCount)).size();
                }catch(exception e){}
                System.debug('@@@totRec'+totRec);
                totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
                totalpage = totpg;
                totalRecord =totRec;
            }else{
                pageActual=1;
                totalpage = totpg; 
                totalRecord = totRec;
            }
        }else if(next){ 
            if(pageActual<totalpage){
                pageActual++;
                totalpage = totpg;
                totalRecord = totRec;
                preparePage();
            }
        }else{
            if(pageActual > 1){
                pageActual--;
                totalpage = totpg;
                totalRecord = totRec;
                preparePage();
            }
        }
    }
    
    
    
    public void preparePage(){  
        /*integer index=0;
        if(pageActual==totalpage||pageRecord>listInserite.size()){ 
            index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
        }else{ 
            index=(pageActual)*(integer)pageRecord; 
        }*/
        integer off=(pageActual-1)*((integer)pageRecord); 
        //User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
       // Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
        
        if(!filtered){
            listInserite = [select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                            EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                            EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                            EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                            EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                            EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                            OF_SA_PROFILO_VLAN__c,
                            EOF_Codice_Ordine_OLO__c,
                            PO_Offerta__c,
                            PO_Nome_Progetto__c,
                            CreatedDate,
                            EOF_STATO_ORDINE__c,
                            OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                            OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,
                            EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c,EOF_SL_Riferimento__c
                            from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_FiberLease_Request') AND EOF_Stato_Richiesta__c='Inserita Portale'
                            and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c order by CreatedDate desc LIMIT:(integer)pageRecord OFFSET :off ];
            ricalcolaOptionFiltri(listInserite);
        }else{
            isPaginationRun = true;
            runSearch();
            soql += ' offset '+off;
            runQuery();
        }
        
        
    }
    
       
    
    // wrapper per la generazione delle option delle selectlist
    public class optionApex {
        public string value {get; set;}
        public string text {get; set;}
        //This is the contructor method. 
        public optionApex(string s, string t) {
            value = s;
            text = t;
        }
    }
    
    public PageReference runSearch() 
    {  
        if (Apexpages.currentPage().getParameters().get('DataInizioCreazione') != null)
        {
            DataInizioCreazione = Apexpages.currentPage().getParameters().get('DataInizioCreazione');
        }
        if (Apexpages.currentPage().getParameters().get('DataFineCreazione') != null)
        {
            DataFineCreazione = Apexpages.currentPage().getParameters().get('DataFineCreazione');
        }
        selectValueL2 = Apexpages.currentPage().getParameters().get('selectValueL2');
        system.debug('giovanni bug ' + Apexpages.currentPage().getParameters().get('selectValueL2'));
        if (Apexpages.currentPage().getParameters().get('selectValueL2') != null)
        {
            ListStatus = (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL2'), List<String>.class);
        }
        
        if (Apexpages.currentPage().getParameters().get('valRich') != null)
        {
            valRich = Apexpages.currentPage().getParameters().get('valRich');
        }
        
        if (Apexpages.currentPage().getParameters().get('valOff') != null)
        {
            valOff = Apexpages.currentPage().getParameters().get('valOff');
        } 
        
        if (Apexpages.currentPage().getParameters().get('valNomP') != null)
        {
            valNomP = Apexpages.currentPage().getParameters().get('valNomP');
        }
        
        System.debug('valore filtro DataInizioCreazione: ' + DataInizioCreazione);
        System.debug('valore filtro DataInizioCreazione: ' + DataFineCreazione);
        System.debug('valore filtro DataInizioCreazione: ' + ListStatus);
        System.debug('valore filtro DataInizioCreazione: ' + valOff);
        System.debug('valore filtro DataInizioCreazione: ' + valOff);
        System.debug('valore filtro DataInizioCreazione: ' + valNomP);

        soql = 'select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,' 
                                                +'EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
                                                +'EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,'
                                                +'EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,'
                                                +'EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,'
            
                                                +'PO_Offerta__c, PO_Nome_Progetto__c, CreatedDate,'
            
                                                +'OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,'
                                                +'OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,'
                                                +'EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c,EOF_SL_Riferimento__c '
                                                +' from EOF_EAI_Service_Log__c where (recordType.developerName=\'PO_Log_FiberLease_Request\') AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
                                                +' and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\'  ';

        if (!DataInizioCreazione.equals('')){
            soql += ' and CreatedDate >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (!DataFineCreazione.equals('')){
            soql += ' and CreatedDate <='+String.escapeSingleQuotes(DataFineCreazione);
        }
        if(ListStatus!=null && !ListStatus.isEmpty()){
            soql += ' and EOF_STATO_ORDINE__c in (';
            for (string mystring:ListStatus){
            soql +='\'' + mystring + '\',';
            }
            soql = soql.removeEnd(',');
            soql += ')';  
        }
        if (!valRich.equals(''))
        {
            //soql += ' and EOF_Codice_Ordine_OLO__c =\''+String.escapeSingleQuotes(valRich)+'\' ';
            soql += ' and EOF_Codice_Ordine_OLO__c LIKE \'%' + String.escapeSingleQuotes(valRich) + '%\'';
        }
        if (!valOff.equals('')){
            soql += ' and PO_Offerta__c =\''+String.escapeSingleQuotes(valOff)+'\' ';
        }
        if (!valNomP.equals(''))
        {
            //soql += ' and PO_Nome_Progetto__c =\''+String.escapeSingleQuotes(valNomP)+'\' ';
            soql += ' and PO_Nome_Progetto__c LIKE \'%' + String.escapeSingleQuotes(valNomP) + '%\'';
        }
        soqlCount = soql;
        soql += 'order by CreatedDate desc LIMIT '+pageRecord;
        if(!isPaginationRun){
            filtered=true; 
            setPagination(null);
        }
        filtered = true;
        isPaginationRun = false;
        //runQuery();

        return null;
    }
    public void runQuery(){
        try{
            System.debug('**** soql ' + soql);
            listInserite = Database.query(soql);
            listInseritestring=JSON.serialize(listInserite);
            ricalcolaOptionFiltri(listInserite);
            
        }catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }
    }
  
    
    
    public pageReference vediReqInserita(){  
        //AA: Modifica 
                    
            //Pagereference pg1 = new Pagereference('/PO_P2PAtt_RiepReq_ElCo');
            Pagereference pg1 = new Pagereference('/PO_Serv_FiberLease_Riepilogo');            
            pg1.getParameters().put('parentId', IdInserita);
            System.debug('&&IdInserita ' + IdInserita);
            return pg1;
        

      /*Pagereference pg = new Pagereference('/PO_OpenStreamService_InsertNewRequest');
      if(tipoRIchiesta=='Attivazione'){
        pg.getParameters().put('proc','attivazioneInserita');
      }
      if(tipoRIchiesta=='Cessazione'){
        pg.getParameters().put('proc','cessazioneInserita');
      }
        pg.getParameters().put('origID',IdBozza);
      return pg;*/
    }    
    
    public Double offset{get{
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }}
    
    public void ricalcolaOptionFiltri(List<EOF_EAI_Service_Log__c> listInserite){
        // ricalcola tutti gli option per i filtri
        Set<String> setTipoRichiesta =new Set<String>();
        Set<String> setStatoRichiesta =new Set<String>();
        List<optionApex>optTipoRichiesta = new List<optionApex>();
        List<optionApex>optStatoRichiesta = new List<optionApex>();
        for(EOF_EAI_Service_Log__c mySL:listInserite ){
                setTipoRichiesta.add(mySL.EOF_Tipo_Comunicazione_String__c);
                setStatoRichiesta.add(mySL.EOF_STATO_ORDINE__c);    
        }
        for(String myString:setTipoRichiesta ){
                optTipoRichiesta.add(new optionApex(myString,myString));
        }    
        for(String myString:setStatoRichiesta ){
                optStatoRichiesta.add(new optionApex(myString,myString));
        }
        
        optTipoRichiestaString=JSON.serialize(optTipoRichiesta);
        optStatoRichiestaString=JSON.serialize(optStatoRichiesta); 
    }
    
    public PageReference fetchList()
    {                
    if (Apexpages.currentPage().getParameters().get('DataInizioCreazione') != null)
        {
            DataInizioCreazione = Apexpages.currentPage().getParameters().get('DataInizioCreazione');
        }
        
        if (Apexpages.currentPage().getParameters().get('DataFineCreazione') != null)
        {
            DataFineCreazione = Apexpages.currentPage().getParameters().get('DataFineCreazione');
        }
        
        if (Apexpages.currentPage().getParameters().get('selectValueL2') != null && Apexpages.currentPage().getParameters().get('selectValueL2') != '')
        {
            ListStatus = (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL2'), List<String>.class);
        }
        
        if (Apexpages.currentPage().getParameters().get('valRich') != null)
        {
            valRich = Apexpages.currentPage().getParameters().get('valRich');
        }
        
        if (Apexpages.currentPage().getParameters().get('valOff') != null)
        {
            valOff = Apexpages.currentPage().getParameters().get('valOff');
        } 
        
        if (Apexpages.currentPage().getParameters().get('valNomP') != null)
        {
            valNomP = Apexpages.currentPage().getParameters().get('valNomP');
        }
        
        System.debug('valore filtro DataInizioCreazione: ' + DataInizioCreazione);
        System.debug('valore filtro DataFineCreazione: ' + DataFineCreazione);
        System.debug('valore filtro ListStatus: ' + ListStatus);
        System.debug('valore filtro valOff: ' + valOff);
        System.debug('valore filtro valOff: ' + valOff);
        System.debug('valore filtro valNomP: ' + valNomP);       
        
        String theQuery = 'select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,' 
                                                +'EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
                                                +'EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,'
                                                +'EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,'
                                                +'EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,'
            
                                                +'PO_Offerta__c, PO_Nome_Progetto__c, CreatedDate,'
            
                                                +'OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,'
                                                +'OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,'
                                                +'EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c,EOF_SL_Riferimento__c '
                                                +' from EOF_EAI_Service_Log__c where (recordType.developerName=\'PO_Log_FiberLease_Request\') AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
                                                +' and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\'  ';

        //if (DataInizioCreazione != null && DataInizioCreazione.equals('')){
        if (String.isNotBlank(DataInizioCreazione)){
            DataInizioCreazione=DataInizioCreazione.replace(' ' ,'+');
            theQuery += ' and CreatedDate >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (String.isNotBlank(DataFineCreazione)){
            DataFineCreazione=DataFineCreazione.replace(' ' ,'+');
            theQuery += ' and CreatedDate <='+String.escapeSingleQuotes(DataFineCreazione);
        }
        if(ListStatus!=null && !ListStatus.isEmpty()){
            theQuery += ' and EOF_STATO_ORDINE__c in (';
            for (string mystring:ListStatus){
            theQuery +='\'' + mystring + '\',';
            }
            theQuery = theQuery.removeEnd(',');
            theQuery += ')';  
        }
        if (String.isNotBlank(valRich))
        {
            //soql += ' and EOF_Codice_Ordine_OLO__c =\''+String.escapeSingleQuotes(valRich)+'\' ';
            theQuery += ' and EOF_Codice_Ordine_OLO__c LIKE \'%' + String.escapeSingleQuotes(valRich) + '%\'';
        }
        if (String.isNotBlank(valOff)){
            theQuery += ' and PO_Offerta__c =\''+String.escapeSingleQuotes(valOff)+'\' ';
        }
        if (String.isNotBlank(valNomP))
        {
            //soql += ' and PO_Nome_Progetto__c =\''+String.escapeSingleQuotes(valNomP)+'\' ';
            theQuery += ' and PO_Nome_Progetto__c LIKE \'%' + String.escapeSingleQuotes(valNomP) + '%\'';
        }
        
        theQuery += 'order by CreatedDate desc '; 
        
        system.debug('giovanni the query: ' + theQuery);
        
        listInseriteDaEsportare = Database.query(theQuery);
        
        return null; 
    }
}
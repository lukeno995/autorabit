public class PO_Serv_BTS_Controller 
{
    public boolean showRichiesteInserite {get; set;} 
    public User attuale {get; set;} 
    
    public Id accId;

    public List<EOF_EAI_Service_Log__c> listInserite{get;set;}
    public List<EOF_EAI_Service_Log__c> listBozze{get;set;}
    public List<EOF_EAI_Service_Log__c> listRichiesteTP {get;set;} 
    public List<EOF_EAI_Service_Log__c> listInseriteDaEsportare{get;set;}
    //public boolean richieste{get;set;}
    public String IdInserita{get;set;}
    public String tipoRichiesta{get;set;}
    public Integer totalRecord{get;set;}    
    public Integer pageActual{get;set;}
    public Decimal totalpage{get;set;}
    public Integer totalRecordBozze{get;set;}    
    public Integer pageActualBozze{get;set;}
    public Decimal totalpageBozze{get;set;}
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
    public boolean showPagBozze{get;set;}
    public Decimal pageRecord{get;set;}  
    public Decimal pageRecordBozze{get;set;}  
    public Integer totRec{get;set;}
    public Decimal totpg{get;set;}
    public Integer totRecBozze{get;set;}
    public Decimal totpgBozze{get;set;}
    public String listRichiesteTPstring {get;set;}
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
    public Case collCase{get;set;} //Case di collegamento BTS
    public Case orderCase {get;set;} //Case di ordine BTS
    
    public List<Case> fattCaseList {get;set;}
    public List<Case> collCaseList {get;set;}
    public List<Case> ordCaseList {get;set;}
    PageReference pg{get;set;}
   //EC end 2018 - 11 - 10 
   
   //EC start 2018 - 11 - 11
   public EOF_EAI_Service_Log__c parentLog {get;set;} //Log di "fattibilità"
   public EOF_EAI_Service_Log__c collLog {get;set;}  //Log di collegamento
   public EOF_EAI_Service_Log__c ordLog {get;set;}      //Log di ordine
 //  public String recordOfferta{get;set;}
   
   //EC end 2018 - 11 - 11
   
    public case testcase {get;set;}
   /*  {
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
        set;
    }
    */
    // EC 2018 - 11 - 10
    public PageReference nuovaRichiesta()
    { 
        pagereference pr  = new PageReference('/PO_Serv_BTS_NuovaRichiesta');
            //pr.getParameters().put('off',recordOfferta);//??? capire se la stringa è effettivamente questa.
            //pr.getParameters().put('parentId', parentCaseId);
            pr.getParameters().put('off','BTS');
            pr.getParameters().put('Mode','insert');
            pr.setRedirect(true);
            return pr;  
        /*
            pg = new PageReference('/PO_Serv_BTS_NuovaRichiesta');
            pg.getParameters().put('off',valOff);//??? capire se la stringa è effettivamente questa.
            pg.getParameters().put('parentId', parentCaseId);
            pg.getParameters().put('Nome', Nome);
            pg.setRedirect(true);
          return pg;  
        //return new pageReference('/PO_Serv_BTS_NuovaRichiesta');   
        */  
    }
    
    public PageReference richiesteInserite()
    {
        PageReference pg = new PageReference('/PO_Serv_BTS_Richieste');
            pg.getParameters().put('off',valOff);
            //pg.getParameters().put('parentId', parentLog.id);
            pg.getParameters().put('Nome', Nome);
            pg.setRedirect(true);
          return pg;    
      //  return new pageReference('/PO_Serv_BTS_Richieste');        
    }
  //  */
    public String debugSoql {
        get { return soql;}
        set;
    }
    
    public String optTipoRichiestaString {get;set;}
    public String optStatoRichiestaString  {get;set;}
    
    
    public PO_Serv_BTS_Controller(){ 
        //richieste=false;
        showRichiesteInserite = false;
        totalRecord=0;
        pageActual=0;
        totalpage=0;
        totalRecordBozze=0;
        pageActualBozze=0;
        totalpageBozze=0;
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
        String offerta='BTS';
        system.debug('@@@@@@@@@@@@EC nel controller, nel costruttore appena entriamo offertEvento è ' + offertEvento);
        if(offertEvento==null && offertEvento==''){
          offertEvento=offerta;
        }
        listBozze=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,Name,
                OwnerId,CreatedDate,EOF_Stato_Richiesta__c,EOF_STATO_ORDINE__c,
                PO_Nome_Progetto__c, PO_Offerta__c,EOF_Codice_Operatore__c
                from EOF_EAI_Service_Log__c
                where recordType.developerName='PO_Log_BTS_Request'
                AND EOF_Stato_Richiesta__c='Bozza'
                AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c
                AND PO_Offerta__c=:offerta
                ORDER BY CreatedDate DESC];
       /* listBozze=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,Name,
                OwnerId,CreatedDate,EOF_Stato_Richiesta__c,EOF_STATO_ORDINE__c,
                PO_Nome_Progetto__c, PO_Offerta__c,EOF_Codice_Operatore__c
                from EOF_EAI_Service_Log__c
                where recordType.developerName='PO_Log_BTS_Request'
                AND EOF_Stato_Richiesta__c='Bozza'
                AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c
                AND PO_Offerta__c=:offerta
                LIMIT :(integer)pageRecord OFFSET :off];*/
       system.debug('@@@@@@@@@@@@EC nel controller, nel costruttore listBozze è ' + listBozze);     
       showPagBozze=(!listBozze.isEmpty())?true:false;      
       system.debug('@@@@@@@@@@@@EC nel controller, nel costruttore showPagBozze se la lista non è vuota dovrebbe essere true ed è ' + showPagBozze); 
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
                                                    from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_BTS_Request') AND EOF_Stato_Richiesta__c!='Bozza'
                                                    and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                                                    order by CreatedDate DESC LIMIT :(integer)pageRecord OFFSET :off];
        listInseritestring=JSON.serialize(listInserite);
        totRec=[SELECT count()   from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_BTS_Request') AND EOF_Stato_Richiesta__c!='Bozza'
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
                                                    from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_BTS_Request') AND EOF_Stato_Richiesta__c!='Bozza'
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
        
        //Bozze
        listBozze=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
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
                      from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_BTS_Request') AND EOF_Stato_Richiesta__c='Bozza Portale'
                      and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                      order by EOF_Data_Notifica__c desc LIMIT :(integer)pageRecord OFFSET :off];
        
        totRecBozze=[SELECT count()   from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_BTS_Request') AND EOF_Stato_Richiesta__c='Bozza Portale'
                                                    and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c  ];
        
        totpgBozze = (totRec /pageRecord).round(RoundingMode.CEILING);
        if(!listBozze.isEmpty())
        {
            showPagBozze=true;
            setPaginationBozze(null);
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
/*    
    public pagereference childCase()
    {
        newAtt.clear();  
        attxlxs.clear();
        attlst.clear();
        system.debug('recid====='+parentCase);
        system.debug('recid====='+parentcaseobj);
        //Attachment.clear(); non era commentato
        string recid = '';
        ID rectypeId=[select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
        Case testParent=new Case();
        //system.debug('parentcase inside childcase method'+parentcase.id);
        String testParentId= apexpages.currentpage().getparameters().get('id');
        system.debug('ParentChild'+testParentId);
        if(TestParentID!= null){
            testParent=[select Id,PO_Nome_Progetto__c,ownerId  from Case where id=:testparentID];

        }



        if(parentCase != null && parentCase.id != null)  
        {
            if(parentCase.PO_Nome_Progetto__c ==''||parentCase.PO_Nome_Progetto__c == null){
                parentCase.PO_Nome_Progetto__c =Nome ;
                offertEvento = parentCase.PO_Offerta__c;
            }
            system.debug('inside the childcase condiytion'+parentCase.PO_Nome_Progetto__c);

            system.debug('inside the childcase condiytion'+testParentId);
            recid =  parentCase.id;
            if(parentcase.OwnerId!=rectypeID){
                parentCase.OwnerId = UserInfo.getUserId();
                update parentCase;
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
            if( testcase.PO_Nome_Progetto__c == ''||  testcase.PO_Nome_Progetto__c == null){
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
            if( testParent .PO_Nome_Progetto__c== ''||testParent .PO_Nome_Progetto__c==null){
                testParent .PO_Nome_Progetto__c =Nome ;
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
    }
        
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
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
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
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
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
         //ChildCase.Contact.id = usr.Contact.id;
         insert childCase;
         pagereference pr = new pagereference('/apex/PO_P2PBaseNew?parentid='+pcase.id);
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

            insert childCase;
            pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
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
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
            return pr;

        }

        try{
            ChildCase.Status = 'Bozza';
            insert ChildCase;
        }catch(exception e){
            system.debug('getMessage error==>'+ e.getMessage() +'getStackTraceString error'+ e.getStackTraceString());

        }
        system.debug('Service Type--->'+serviceType);
        system.debug('ChildCase--->'+ChildCase);
        pagereference pr = new pagereference('/apex/OF_ChildCase?parentid='+pcase.id);
        return pr;
    }  
    */
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
    
    public void setPaginationBozze(boolean next){ 
        if(next==null){
            if (filtered){
                soql += ' offset 0';
                runQuery();
                try{
                totRecBozze = ((List<EOF_EAI_Service_Log__c>)Database.query(soqlCount)).size();
                }catch(exception e){}
                System.debug('@@@totRec'+totRec);
                totpgBozze = (totRecBozze /pageRecord).round(RoundingMode.CEILING);
                totalpageBozze = totpgBozze;
                totalRecordBozze =totRecBozze;
            }else{
                pageActualBozze=1;
                totalpageBozze = totpgBozze; 
                totalRecordBozze = totRecBozze;
            }
        }else if(next){ 
            if(pageActualBozze<totalpageBozze){
                pageActualBozze++;
                totalpageBozze = totpgBozze;
                totalRecordBozze = totRecBozze;
                preparePage();
            }
        }else{
            if(pageActualBozze > 1){
                pageActualBozze--;
                totalpageBozze = totpgBozze;
                totalRecordBozze = totRecBozze;
                preparePageBozze();
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
                            from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_BTS_Request') AND EOF_Stato_Richiesta__c='Inserita Portale'
                            and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c order by EOF_Data_Notifica__c desc LIMIT:(integer)pageRecord OFFSET :off ];
            ricalcolaOptionFiltri(listInserite);
        }else{
            isPaginationRun = true;
            runSearch();
            soql += ' offset '+off;
            runQuery();
        }
        
        
    }
    
    public void preparePageBozze(){  

        integer off=(pageActualBozze-1)*((integer)pageRecordBozze); 
        
        listBozze = [select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
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
                        from EOF_EAI_Service_Log__c where (recordType.developerName='PO_Log_BTS_Request') AND EOF_Stato_Richiesta__c='Bozza Portale'
                        and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c order by EOF_Data_Notifica__c desc LIMIT:(integer)pageRecordBozze OFFSET :off ];


                
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
                                                +' from EOF_EAI_Service_Log__c where (recordType.developerName=\'PO_Log_BTS_Request\') AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
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
        soql += 'order by EOF_Data_Notifica__c desc LIMIT '+pageRecord;
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
  
    public pageReference vediReqBozza(){
        //AA: Modifica 
        if(tipoRIchiesta.equalsIgnoreCase('Ordine di Cessazione')){
            Pagereference pg1 = new Pagereference('/PO_P2PAttiva_CessazioneDetails');
          //pg1.getParameters().put('viewMode', 'modify'); //EC, commento perché siamo nelle richieste inserite quindi non  è più possibile modificare nulla.
            pg1.getParameters().put('origId', IdInserita);
            return pg1;
        }else{
            Pagereference pg1 = new Pagereference('/PO_P2PAtt_RiepReq_ElCo');
            pg1.getParameters().put('parentId', IdInserita);
            return pg1;
        }

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
    
    public pageReference vediReqInserita(){  
        //AA: Modifica 
        if(tipoRIchiesta.equalsIgnoreCase('Ordine di Cessazione')){
            Pagereference pg1 = new Pagereference('/PO_P2PAttiva_CessazioneDetails');
          //pg1.getParameters().put('viewMode', 'modify'); //EC, commento perché siamo nelle richieste inserite quindi non  è più possibile modificare nulla.
            pg1.getParameters().put('origId', IdInserita);
            return pg1;
        }else{            
            //Pagereference pg1 = new Pagereference('/PO_P2PAtt_RiepReq_ElCo');
            Pagereference pg1 = new Pagereference('/PO_Serv_BTS_Riepilogo');            
            pg1.getParameters().put('parentId', IdInserita);
            System.debug('&&IdInserita ' + IdInserita);
            return pg1;
        }

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
                                                +' from EOF_EAI_Service_Log__c where (recordType.developerName=\'PO_Log_BTS_Request\') AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
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
        
        theQuery += 'order by EOF_Data_Notifica__c desc '; 
        
        system.debug('giovanni the query: ' + theQuery);
        
        listInseriteDaEsportare = Database.query(theQuery);
        
        return null; 
    }
}
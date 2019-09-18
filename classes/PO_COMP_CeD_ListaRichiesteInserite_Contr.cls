public class PO_COMP_CeD_ListaRichiesteInserite_Contr {
    
    public List<EOF_EAI_Service_Log__c> listInserite{get;set;}
    public List<EOF_EAI_Service_Log__c> listRichiesteTP {get;set;} 
    public boolean richieste{get;set;}
    public String IdInserita{get;set;}
    public String tipoRichiesta{get;set;}
    public Integer totalRecord{get;set;}    
    public Integer pageActual{get;set;}
    public Decimal totalpage{get;set;}
    //RUNSEARCH
    public String DataInizioNotifica{get;set;}
    public String DataFineNotifica{get;set;}
    public String DataInizioCreazione{get;set;}
    public String DataFineCreazione{get;set;}
    public List<String> ListTipo{get;set;}
    public List<String> ListStatus{get;set;}
    public String selectValueL1{get;set;}
    public String selectValueL2{get;set;}
    public String valPOP{get;set;}
    public String valCodOrdOLO{get;set;}
    public String valIDRisorsa{get;set;}
    public boolean showPag{get;set;}
    public Decimal pageRecord{get;set;}  
    public Integer totRec{get;set;}
    public Decimal totpg{get;set;}
    public String listRichiesteTPstring {get;set;}
    public Boolean filtered{get;set;}
    public String soql {get;set;}
    public String soqlCount {get;set;}
    public String listInseritestring {get;set;} 
    public boolean isPaginationRun {get;set;}
    public Set<ID> sl_Log_List{get;set;}
    
    public String debugSoql {
        get { return soql;}
        set;
    }
    
    public String optTipoRichiestaString {get;set;}
    public String optStatoRichiestaString  {get;set;}
    
    public PO_COMP_CeD_ListaRichiesteInserite_Contr(){
        
        richieste=false;
        totalRecord=0;
        pageActual=0;
        totalpage=0;
        Integer off=0;  
        pageRecord=5;
        showPag=false; 
        filtered=false;
        isPaginationRun=false;
        User attuale = [select Id,Account.EOF_Codice_Operatore__c 
                        from user 
                        where Id=:userinfo.getUserId()];
        
        listInserite=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                        EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                        EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                        EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                        EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                        EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                        OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                        OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,
                        EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c 
                        from EOF_EAI_Service_Log__c 
                        where (recordType.developerName='PO_SA_CD_Log_OpenStreamRequest' OR recordType.developerName='PO_SA_CD_Log_ChangeOrderRequest') 
                        AND EOF_Stato_Richiesta__c='Inserita Portale'
                        and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                        order by EOF_Data_Notifica__c desc 
                        LIMIT :(integer)pageRecord OFFSET :off];
        
        listInseritestring = JSON.serialize(listInserite);
        
        totRec=[SELECT count()   
                from EOF_EAI_Service_Log__c 
                where (recordType.developerName='PO_SA_CD_Log_OpenStreamRequest' OR recordType.developerName='PO_SA_CD_Log_ChangeOrderRequest') 
                AND EOF_Stato_Richiesta__c='Inserita Portale'
                and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c];
                
        totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
        System.debug('@@@size'+listInserite);
        
        if(!listInserite.isEmpty()){
            richieste=true; 
            showPag=true;
            Set<String> setTipoRichiesta = new Set<String>();
            Set<String> setStatoRichiesta = new Set<String>();
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
            setPagination(null);
        }
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
        User attuale=[select Id, Account.EOF_Codice_Operatore__c 
                      from user 
                      where Id=:userinfo.getUserId()];
       // Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
        
        if(!filtered){
            listInserite = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,
                            EOF_NOME_REFERENTE_TECNICO_OLO__c, EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                            EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                            EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                            EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                            EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                            OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                            OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,
                            EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c 
                            from EOF_EAI_Service_Log__c 
                            where (recordType.developerName = 'PO_SA_CD_Log_OpenStreamRequest' 
                                OR recordType.developerName = 'PO_SA_CD_Log_ChangeOrderRequest') 
                            AND EOF_Stato_Richiesta__c='Inserita Portale'
                            and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                            order by EOF_Data_Notifica__c desc 
                            LIMIT:(integer)pageRecord OFFSET :off ];
                            
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
    
    public PageReference runSearch() {  
        if (Apexpages.currentPage().getParameters().get('DataInizioNotifica') != null) {
            DataInizioNotifica = Apexpages.currentPage().getParameters().get('DataInizioNotifica');
        }
        if (Apexpages.currentPage().getParameters().get('DataFineNotifica') != null){
            DataFineNotifica = Apexpages.currentPage().getParameters().get('DataFineNotifica');
        }
        if (Apexpages.currentPage().getParameters().get('DataInizioCreazione') != null){
            DataInizioCreazione = Apexpages.currentPage().getParameters().get('DataInizioCreazione');
        }
        if (Apexpages.currentPage().getParameters().get('DataFineCreazione') != null){
            DataFineCreazione = Apexpages.currentPage().getParameters().get('DataFineCreazione');
        }
        if(!test.isRunningTest())
        {
            if (Apexpages.currentPage().getParameters().get('selectValueL1') != null){
                ListTipo= (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL1'), List<String>.class);
            }
            if (Apexpages.currentPage().getParameters().get('selectValueL2') != null){
                ListStatus = (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL2'), List<String>.class);
            }
        }
        if (Apexpages.currentPage().getParameters().get('valPOP') != null){
            valPOP = Apexpages.currentPage().getParameters().get('valPOP');
        }
        if (Apexpages.currentPage().getParameters().get('valCodOrdOLO') != null){
            valCodOrdOLO = Apexpages.currentPage().getParameters().get('valCodOrdOLO');
        }
        if (Apexpages.currentPage().getParameters().get('valIDRisorsa') != null){
            valIDRisorsa = Apexpages.currentPage().getParameters().get('valIDRisorsa');
        }
        
        User attuale = [select Id,Account.EOF_Codice_Operatore__c 
                        from user 
                        where Id=:userinfo.getUserId()];

        soql = 'select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,' 
                +'EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
                +'EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,'
                +'EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,'
                +'EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,'
                +'OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,'
                +'OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,'
                +'EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c '
                +' from EOF_EAI_Service_Log__c where (recordType.developerName=\'PO_SA_CD_Log_OpenStreamRequest\' OR recordType.developerName=\'PO_SA_CD_Log_ChangeOrderRequest\') '
                +' AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
                +' and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\'  ';
                
        if (!DataInizioNotifica.equals('')){
            soql += ' and EOF_Data_Notifica__c >='+String.escapeSingleQuotes(DataInizioNotifica);
        }
        if (!DataFineNotifica.equals('')){
            soql += ' and EOF_Data_Notifica__c <='+String.escapeSingleQuotes(DataFineNotifica);
        }
        if (!DataInizioCreazione.equals('')){
            soql += ' and PO_SA_Data_Inserimento_Ordine__c >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (!DataFineCreazione.equals('')){
            soql += ' and PO_SA_Data_Inserimento_Ordine__c <='+String.escapeSingleQuotes(DataFineCreazione);
        }
        if(ListTipo!=null && !ListTipo.isEmpty()){
            soql += ' and EOF_Tipo_Comunicazione_String__c in (';
            for (string mystring:ListTipo){
            soql +='\'' + mystring + '\',';
            }
            soql = soql.removeEnd(',');
            soql += ')';          
        }
        if(ListStatus!=null && !ListStatus.isEmpty()){
            soql += ' and EOF_STATO_ORDINE__c in (';
            for (string mystring:ListStatus){
            soql +='\'' + mystring + '\',';
            }
            soql = soql.removeEnd(',');
            soql += ')';  
        }
        if (!valPOP.equals('')){
            soql += ' and EOF_ID_Pop__c =\''+String.escapeSingleQuotes(valPOP)+'\' ';
        }
        if (!valCodOrdOLO.equals('')){
            soql += ' and EOF_Codice_Ordine_OLO__c =\''+String.escapeSingleQuotes(valCodOrdOLO)+'\' ';
        }
        if (!valIDRisorsa.equals('')){
            soql += ' and EOF_ID_Risorsa__c =\''+String.escapeSingleQuotes(valIDRisorsa)+'\' ';
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
        }
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }
    }
    
    public pageReference vediReq(){
        Pagereference pg = new Pagereference('/PO_OpenStreamCeD_InsertNewReq');
        if(tipoRIchiesta=='Attivazione'){
            pg.getParameters().put('proc','attivazioneInoltrata');
        }
        if(tipoRIchiesta=='Cessazione'){
            pg.getParameters().put('proc','cessazioneInoltrata');
        }
        if(tipoRIchiesta=='Change Order'){
            Pagereference pg1 = new Pagereference('/PO_CeD_DettaglioChangeOrder');
            pg1.getParameters().put('idRisorsa', IdInserita);
            return pg1;
        }
        pg.getParameters().put('origID',IdInserita);
        return pg;
    }
    
    public Double offset{get{
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }}
    
    public pageReference clonaRequest(){
        Pagereference pg = new Pagereference('/PO_OpenStreamCeD_InsertNewReq');
        //copio la req originale
        List<EOF_EAI_Service_Log__c> SlListToInsert = [select EOF_Codice_Operatore__c,EOF_Tipo_Comunicazione_String__c,recordtypeId,recordtype.developerName,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,
                                                        EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                                        EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_PROFILO_VLAN__c,
                                                        OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,EOF_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_ID_APPARATO__c,
                                                        OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c                           
                                                        from EOF_EAI_Service_Log__c 
                                                        where Id=:IdInserita 
                                                        OR OF_SA_Cpe_Log__c=:IdInserita  
                                                        OR OF_SA_VLAN_Log__c=:IdInserita  
                                                        OR OF_SA_Servizi_Aggiuntivi_Log__c=:IdInserita 
                                                        order by createdDate ASC];
        
        //la prima è la fiberrequest, la inserisco cosi poi posso dare la reference alle eventuali altre
        EOF_EAI_Service_Log__c slPrincipaleToInsert = SlListToInsert[0];
        //la rimuovo dalla lista
        SlListToInsert.remove(0);
        slPrincipaleToInsert.EOF_Stato_Richiesta__C='Bozza Portale';
        slPrincipaleToInsert.Id=null;
        //rimuovo id building e ID pop
        slPrincipaleToInsert.EOF_ID_BUILDING__c='';
        slPrincipaleToInsert.EOF_ID_Pop__c='';
        insert slPrincipaleToInsert;
        IdInserita=slPrincipaleToInsert.Id;
        if(!SlListToInsert.isEmpty()){
            for(EOF_EAI_Service_Log__c sl : SlListToInsert){
                sl.EOF_Stato_Richiesta__c='Bozza Portale';
                sl.Id=null;
                if(sl.recordtype.developerName=='OF_SA_Cpe'){
                    sl.OF_SA_Cpe_Log__c=IdInserita;
                }
                if(sl.recordtype.developerName=='OF_SA_Vlan'){
                    sl.OF_SA_VLan_Log__c=IdInserita;
                }
                if(sl.recordtype.developerName=='OF_SA_Servizi_Aggiuntivi'){
                    sl.OF_SA_Servizi_Aggiuntivi_Log__c=IdInserita;
                }
            }
            //inserisco la lista
            insert SlListToInsert;
        }                               
        if(tipoRIchiesta=='Attivazione'){
            pg.getParameters().put('proc','editAttivazione');
        }
        if(tipoRIchiesta=='Cessazione'){
            pg.getParameters().put('proc','editCessazione');
        }
        pg.getParameters().put('tipo','clona');
        pg.getParameters().put('origID',IdInserita);
        return pg;
    }
    
    public void ricalcolaOptionFiltri(List<EOF_EAI_Service_Log__c> listInserite){
        // ricalcola tutti gli option per i filtri
        Set<String> setTipoRichiesta = new Set<String>();
        Set<String> setStatoRichiesta = new Set<String>();
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
        optTipoRichiestaString = JSON.serialize(optTipoRichiesta);
        optStatoRichiestaString = JSON.serialize(optStatoRichiesta);
    }
}
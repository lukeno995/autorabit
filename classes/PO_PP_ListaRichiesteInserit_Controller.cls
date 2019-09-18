public class PO_PP_ListaRichiesteInserit_Controller {
    
    public List<EOF_EAI_Service_Log__c> listInserite{get;set;}
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
    
    public String valCodRichiesta{get;set;}
    public String valTipoRichiesta{get;set;}
    public String valStatoRichiesta{get;set;}
    
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
    
    public EOF_EAI_Service_Log__c log_richiestaVLAN{get;set;}
    public EOF_EAI_Service_Log__c log_VLAN{get;set;}
    
    public String debugSoql {
        get { return soql;}
        set;
    }
    
    public String optTipoRichiestaString {get;set;}
    public String optStatoOrdineString {get;set;}
    
    public PO_PP_ListaRichiesteInserit_Controller()
    {
        richieste=false;
        totalRecord=0;
        pageActual=0;
        totalpage=0;
        Integer off=0;  
        pageRecord=5;
        showPag=false; 
        filtered=false;
        isPaginationRun=false;

        User attuale=[select Id,Account.EOF_Codice_Operatore__c 
                     from user 
                     where Id=:userinfo.getUserId()];
        System.debug('****Attuale.Account.EOF_Codice_Operatore__c :*****'+attuale.Account.EOF_Codice_Operatore__c);
        
        listInserite=[select id,NAME, Caso__c, Caso__r.casenumber, recordtype.developername, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore__c,EOF_Data_Notifica__c, 
    	              EOF_ID_Notifica__c, EOF_Tipo_Comunicazione_String__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c, SVLAN__c, PO_PP_User_VLAN__c,
    	              POP__c, PO_PP_POP_raccolta__c, Nome_del_KIT__c, Traffico__c, Banda_Interfaccia__c, PO_PP_Interfaccia__c,OF_PP_NomeRichiesta__c,OF_PP_NomeRichiesta_Figlio__c,
    	              CreatedDate, Caso__r.closedDate
                      from EOF_EAI_Service_Log__c 
                      where recordType.developerName in('OF_PP_KIT_ActivationRequest','PO_PP_VLAN') 
                      AND EOF_Tipo_Comunicazione_String__c in ('KIT Consegna','VLAN')
                      AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                      AND EOF_Stato_Richiesta__c='Inserita Portale'
                      order by EOF_Data_Notifica__c desc 
                      LIMIT :(integer)pageRecord OFFSET :off];
                    
        listInseritestring=JSON.serialize(listInserite);
        
        totRec=[Select count()  
                from EOF_EAI_Service_Log__c 
                where recordType.developerName in('OF_PP_KIT_ActivationRequest','PO_PP_VLAN') 
                AND EOF_Stato_Richiesta__c='Inserita Portale' 
                AND EOF_Tipo_Comunicazione_String__c in ('KIT Consegna','VLAN')
                AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c];
        
        totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
        System.debug('@@@size'+listInserite);
        
        if(!listInserite.isEmpty())
        {
            richieste=true; 
            showPag=true;
            Set<String> setTipoRichiesta = new Set<String>();
            Set<String> setStatoOrdine = new Set<String>();
            List<optionApex>optTipoRichiesta = new List<optionApex>();
            List<optionApex>optStatoOrdine = new List<optionApex>();
            
            for(EOF_EAI_Service_Log__c mySL:listInserite)
            {
                setTipoRichiesta.add(mySL.EOF_Tipo_Comunicazione_String__c);
                setStatoOrdine.add(mySL.EOF_STATO_ORDINE__c);    
            }
            for(String myString:setTipoRichiesta){
                 optTipoRichiesta.add(new optionApex(myString,myString));
            }    
            for(String myString:setStatoOrdine){
                 optStatoOrdine.add(new optionApex(myString,myString));
            }
            optTipoRichiestaString=JSON.serialize(optTipoRichiesta);
            optStatoOrdineString=JSON.serialize(optStatoOrdine);
            setPagination(null);
        }
    }   

    //METODI PER LA PAGINAZIONE - INIZIO
    public PageReference pageUp()
    {
        setPagination(true);
        return null;
    }
    public PageReference pageDown()
    {
        setPagination(false);
        return null;
    }

    public void setPagination(boolean next)
    { 
        if(next==null)
        {
            if (filtered)
            {
                soql += ' offset 0';
                runQuery();
                try
                {
                    totRec = ((List<EOF_EAI_Service_Log__c>)Database.query(soqlCount)).size();
                }
                catch(exception e){}
                System.debug('@@@totRec'+totRec);
                totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
                totalpage = totpg;
                totalRecord =totRec;
            }
            else
            {
                pageActual=1;
                totalpage = totpg; 
                totalRecord = totRec;
            }
        }
        else if(next)
        { 
            if(pageActual<totalpage)
            {
                pageActual++;
                totalpage = totpg;
                totalRecord = totRec;
                preparePage();
            }
        }
        else
        {
            if(pageActual > 1)
            {
                pageActual--;
                totalpage = totpg;
                totalRecord = totRec;
                preparePage();
            }
        }
    }
    
    public void preparePage()
    {  
        /*integer index=0;
        if(pageActual==totalpage||pageRecord>listInserite.size()){ 
            index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
        }else{ 
            index=(pageActual)*(integer)pageRecord; 
        }*/
        integer off=(pageActual-1)*((integer)pageRecord); 
        
        User attuale=[select Id,Account.EOF_Codice_Operatore__c 
                     from user
                     where Id=:userinfo.getUserId()];
        // Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
        
        if(!filtered)
        {
            listInserite = [select id,NAME, Caso__c, Caso__r.casenumber,recordtype.developername, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore__c,EOF_Data_Notifica__c, 
        	                EOF_ID_Notifica__c, EOF_Tipo_Comunicazione_String__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c,PO_PP_POP_raccolta__c,SVLAN__c, PO_PP_User_VLAN__c,
        	                POP__c, Nome_del_KIT__c, Traffico__c, Banda_Interfaccia__c, PO_PP_Interfaccia__c, 
        	                CreatedDate,OF_PP_NomeRichiesta__c,OF_PP_NomeRichiesta_Figlio__c, Caso__r.closedDate
                            from EOF_EAI_Service_Log__c 
                            where recordType.developerName in('OF_PP_KIT_ActivationRequest','PO_PP_VLAN') 
                            AND EOF_Tipo_Comunicazione_String__c in ('KIT Consegna','VLAN')
                            AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                            AND EOF_Stato_Richiesta__c='Inserita Portale'
                            order by CreatedDate desc 
                            LIMIT :(integer)pageRecord OFFSET :off];
            
            ricalcolaOptionFiltri(listInserite);
        }
        else
        {
            isPaginationRun = true;
            runSearch();
            soql += ' offset '+off;
            runQuery();
        }
    }
    //METODI PER LA PAGINAZIONE - FINE
    
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
        if (Apexpages.currentPage().getParameters().get('DataInizioCreazione')!=null){
            DataInizioCreazione = Apexpages.currentPage().getParameters().get('DataInizioCreazione');
        }
        System.debug('***DataInizioCreazione***:'+DataInizioCreazione);
        
        if (Apexpages.currentPage().getParameters().get('DataFineCreazione')!=null){
            DataFineCreazione = Apexpages.currentPage().getParameters().get('DataFineCreazione');
        }
        System.debug('***DataFineCreazione***:'+DataFineCreazione);
        
        //if(!test.isRunningTest())
        //{   
            System.debug('****Sono qui****');
            
            //Tipo Richiesta    
            if (Apexpages.currentPage().getParameters().get('selectValueL1')!=null){
                ListTipo = (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL1'), List<String>.class);
            }
            System.debug('****ListTipo :****'+ListTipo);
            //Stato Richiesta
            if (Apexpages.currentPage().getParameters().get('selectValueL2')!=null){
                ListStatus = (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL2'), List<String>.class);
            }
            System.debug('****ListStatus :****'+ListStatus);
        //}
        if (Apexpages.currentPage().getParameters().get('valCodRichiesta')!=null){
            valCodRichiesta = Apexpages.currentPage().getParameters().get('valCodRichiesta');
        }
        System.debug('***valCodRichiesta***:'+valCodRichiesta);
        
        User attuale=[select Id,Account.EOF_Codice_Operatore__c 
                      from user 
                      where Id=:userinfo.getUserId()];

        soql = 'select id, Caso__c, Caso__r.casenumber, NAME,recordtype.developername, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore__c,EOF_Data_Notifica__c, ' 
    		  +'EOF_ID_Notifica__c, EOF_Tipo_Comunicazione_String__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c, SVLAN__c, PO_PP_User_VLAN__c,'
    		  +'POP__c, PO_PP_POP_raccolta__c, Nome_del_KIT__c, Traffico__c, Banda_Interfaccia__c, PO_PP_Interfaccia__c, CreatedDate, OF_PP_NomeRichiesta__c,OF_PP_NomeRichiesta_Figlio__c'
    		  +'from EOF_EAI_Service_Log__c '
    		  +'where (recordType.developerName=\'OF_PP_KIT_ActivationRequest\' OR recordType.developerName=\'PO_PP_VLAN\')'
    		  //+' AND (EOF_Tipo_Comunicazione_String__c =\'KIT Consegna\' OR EOF_Tipo_Comunicazione_String__c =\'VLAN\')'
    		  +' AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
    		  +' AND EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\' ';
        
        System.debug('***SOQL 1****:'+soql);

        if (!DataInizioCreazione.equals('')){
            soql += ' and createdDate >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (!DataFineCreazione.equals('')){
            soql += ' and createdDate <='+String.escapeSingleQuotes(DataFineCreazione);
        }
        if (!valCodRichiesta.equals('')){
            soql += ' and name =\''+String.escapeSingleQuotes(valCodRichiesta)+'\' ';
        }
        
        //Tipo richiesta
        if(ListTipo!=null && !ListTipo.isEmpty()){
            soql += ' and EOF_Tipo_Comunicazione_String__c in (';
            for (string mystring:ListTipo){
            soql +='\'' + mystring + '\',';
            }
            soql = soql.removeEnd(',');
            soql += ')';          
        }
        //Stato ordine
        if(ListStatus!=null && !ListStatus.isEmpty()){
            soql += ' and EOF_STATO_ORDINE__c in (';
            for (string mystring:ListStatus){
            soql +='\'' + mystring + '\',';
            }
            soql = soql.removeEnd(',');
            soql += ')';  
        }
        
        System.debug('***SOQL 2****:'+soql);

        soqlCount = soql;
        //soql += 'order by EOF_Data_Notifica__c desc LIMIT '+pageRecord;
        soql += 'order by createdDate desc LIMIT '+pageRecord;
        if(!isPaginationRun){
            filtered=true; 
            setPagination(null);
        }
        filtered = true;
        isPaginationRun = false;
        //runQuery();

        return null;
    }
    
    public void runQuery()
    {
        try
        {
            System.debug('**** soql ' + soql);
            listInserite = Database.query(soql);
            listInseritestring=JSON.serialize(listInserite);
            ricalcolaOptionFiltri(listInserite);
        }
        catch (Exception e) 
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }
    }
    
    
    public pageReference vediReq()
    {
        system.debug('########> RICHIAMO RIEPILOGO CON ID:IdInserita = '+IdInserita);
        
    	if(tipoRichiesta.equalsIgnoreCase('KIT Consegna'))
    	{
    	    Pagereference pageR = new Pagereference('/PO_RiepilogoKIT');
    		pageR.getParameters().put('origId',IdInserita);
	        pageR.getParameters().put('proc','successInsertATT');
	        pageR.getParameters().put('showInsVlan','NO');
	        
	        //showAnnullaBtn=true;
    		return pageR;
    	}
        if(tipoRichiesta.equalsIgnoreCase('VLAN'))
        {
            log_VLAN = [Select id, PO_PP_ID_RichiestaVLAN__c
                        from EOF_EAI_Service_Log__c
                        where id =: IdInserita
                        limit 1];

            log_richiestaVLAN = [Select id, OF_PP_KIT_Log__r.Nome_del_KIT__c
                                from EOF_EAI_Service_Log__c
                                where id =: log_VLAN.PO_PP_ID_RichiestaVLAN__c
                                limit 1];
                          
    	    Pagereference pg = new Pagereference('/PO_PP_RiepilogoSVLAN');
    		pg.getParameters().put('id_richVLAN',log_richiestaVLAN.id);
    		pg.getParameters().put('nameKit',log_richiestaVLAN.OF_PP_KIT_Log__r.Nome_del_KIT__c);
            pg.getParameters().put('show_buttons','false');
    		return pg;
    	}
    	return null;
    }
    
    // @@ Add by PG - 08-11 - CR PREPROV
    public pageReference vediDettaglioCodiceKitVlan()
    {
        system.debug('########> RICHIAMO RIEPILOGO CON ID:IdInserita = '+IdInserita);
        
    	if(tipoRichiesta.equalsIgnoreCase('KIT Consegna'))
    	{   
    	    /*
    	    Pagereference pageR = new Pagereference('/PO_PP_Dettaglio_VLAN_KIT');
    		pageR.getParameters().put('kit',IdInserita);
    		pageR.getParameters().put('tipo','kit');
	        return pageR;
    	    */
    	    
    	    Pagereference pageR = new Pagereference('/PO_RiepilogoKIT');
    		pageR.getParameters().put('origId',IdInserita);
	        pageR.getParameters().put('proc','successInsertATT');
	        pageR.getParameters().put('showInsVlan','NO');
	        
	        //showAnnullaBtn=true;
    		return pageR;
    	}
        if(tipoRichiesta.equalsIgnoreCase('VLAN'))
        {
            log_VLAN = [Select id
                        from EOF_EAI_Service_Log__c
                        where id =: IdInserita
                        limit 1];
            /*
            log_richiestaVLAN = [Select id, OF_PP_KIT_Log__r.Nome_del_KIT__c
                                from EOF_EAI_Service_Log__c
                                where id =: log_VLAN.PO_PP_ID_RichiestaVLAN__c
                                limit 1];
            */
    	    Pagereference pg = new Pagereference('/PO_PP_Dettaglio_VLAN_KIT');
    		pg.getParameters().put('vlan',log_VLAN.id);
    		pg.getParameters().put('tipo','vlan');
    		return pg;
    	}
    	return null;
    }
    // @@ End by PG - 08-11 - CR PREPROV
    
    public Double offset{get{
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }}
    
    
    public void ricalcolaOptionFiltri(List<EOF_EAI_Service_Log__c> listInserite)
    {
        // ricalcola tutti gli option per i filtri
        Set<String> setTipoRichiesta = new Set<String>();
        Set<String> setStatoOrdine = new Set<String>();
        List<optionApex>optTipoRichiesta = new List<optionApex>();
        List<optionApex>optStatoOrdine = new List<optionApex>();
        
        for(EOF_EAI_Service_Log__c mySL:listInserite)
        {
            setTipoRichiesta.add(mySL.EOF_Tipo_Comunicazione_String__c);
            setStatoOrdine.add(mySL.EOF_STATO_ORDINE__c);    
        }
        for(String myString:setTipoRichiesta){
            optTipoRichiesta.add(new optionApex(myString,myString));
        }    
        for(String myString:setStatoOrdine){
            optStatoOrdine.add(new optionApex(myString,myString));
        }
        optTipoRichiestaString=JSON.serialize(optTipoRichiesta);
        optStatoOrdineString=JSON.serialize(optStatoOrdine);
    }
}
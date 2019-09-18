public class PO_PP_COMP_KitConsegnaAttivi_Controller {
    
    public String titolare{get;set;}
    public boolean checkMessage{get;set;}
    public string message{get;set;}
    public boolean showRow{get;set;}
    public boolean richiesteTP{get;set;}
    public List<Asset> listRichiesteTP {get;set;}
    public String IdScelta{get;set;}
    public Integer totalRecord{get;set;}    
    public Integer pageActual{get;set;}
    public Decimal totalpage{get;set;}
    public boolean showPag{get;set;}
    public String DataInizio{get;set;}
    public String DataFine{get;set;} 
    public String soql {get;set;}
    public String listRichiesteKitString {get;set;}
    public Decimal pageRecord{get;set;}  
    public Integer totRec{get;set;}
    public Boolean filtered{get;set;}
    public Decimal totpg{get;set;}
    
    public List<OF_CommercialElementIstanziato__c> listakitAttivi {get;set;}
    public String codOP {get;set;}
    public boolean richiesteKit {get;set;}
    public List<KitWrapper> listRichiesteKitWr {get;set;}
    public List<KitWrapper> ActualPagination {get;set;}
    public String idkit{get;set;} //param
    public String nomeKit{get;set;}
    public String idRisorsa{get;set;}
    public String stato {get;set;}
    public String pop {get;set;}
    public String banda {get;set;}
    public String interfaccia {get;set;}
    public String servizioCommerciale {get;set;}
    public String nameKit{get;set;}
    public List<EOF_EAI_Service_Log__c> list_id_log_richiestaVLAN {get;set;}
    public String show_buttons {get;set;}
    public String id_log_Kit {get;set;}
    public String id_cei_Kit {get;set;} //EC 2018 - 11 - 28
    
    
    public PO_PP_COMP_KitConsegnaAttivi_Controller() 
    {
        totalRecord=0;
        pageActual=0;
        totalpage=0;
        pageRecord=5;
        richiesteTP=true;
        showRow=true;
        showPag=true;
        filtered=false;
        Integer off=0; 
        
        codOp = [SELECT Contact.account.name 
                FROM User 
                WHERE id = :userinfo.getuserid() 
                LIMIT 1].Contact.account.name;
        
        //System.debug('***codOp:***'+codOp);
        
        /*
        Id accId =  [SELECT AccountId FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
        System.debug('***** account id ' + accId);
        */
        
        //Lista dei KIT Attivi
        listakitAttivi = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Pop__c, PO_PP_InterfacciaKit__c, PO_PP_Banda_Interfaccia__c,
                          PO_PP_Servizio_Commerciale__c, OF_Stato__c, RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c, 
                          OF_Asset__r.EOF_ID_Risorsa__c, OF_DataAttivazione__c, OF_DataAttivazione_Calc__c
                          from OF_CommercialElementIstanziato__c
                          where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                          and OF_Asset__r.account.name =:codOp
                          and OF_Asset__r.status='Attivo'
                          order by CreatedDate DESC
                         ];

        System.debug('*****listakitAttivi :'+listakitAttivi);

        totRec = [Select Count()
                  from OF_CommercialElementIstanziato__c
                  where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                  and OF_Asset__r.account.name =:codOp
                  and OF_Asset__r.status='Attivo'];

        totpg = (totRec/pageRecord).round(RoundingMode.CEILING);

        if(listakitAttivi.size()>0)
        { 
            richiesteTP = true;
            listRichiesteKitWr = populateKitWrapper(listakitAttivi);
            listRichiesteKitString = JSON.serialize(listakitAttivi);
            setPagination(null);
        }
    }
    
    public PageReference ViewDetail()
    {
        System.debug('***nameKit***: '+nameKit);

		/*
		Select id, name, PO_PP_Nome_KIT__c, PO_PP_Pop__c, PO_PP_InterfacciaKit__c, PO_PP_Banda_Interfaccia__c,
                          PO_PP_Servizio_Commerciale__c, OF_Stato__c, RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c, 
                          OF_Asset__r.EOF_ID_Risorsa__c, OF_DataAttivazione__c, OF_DataAttivazione_Calc__c
                          from OF_CommercialElementIstanziato__c
                          where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                          and OF_Asset__r.account.name =:codOp
                          and OF_Asset__r.status='Attivo'
                          order by CreatedDate DESC
                         
		*/
		system.debug('@@@@EC stiamo per popolare id_cei_Kit');

        id_cei_Kit = [select id
                     from OF_CommercialElementIstanziato__c 
                     where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                     and PO_PP_Nome_KIT__c =:nameKit
                     limit 1
                    ].id;
        		system.debug('@@@@EC id_cei_Kit: ' + id_cei_Kit);
        
       for (EOF_EAI_Service_Log__c slfor: [select id
                     from EOF_EAI_Service_Log__c 
                     where recordType.developerName = 'OF_PP_KIT_ActivationRequest'
                     and EOF_Stato_Richiesta__c='Inserita Portale' 
                     and Nome_del_KIT__c =:nameKit
                     limit 1]){		
       id_log_Kit = slfor.id;		         
                    
        }
        Pagereference pageR = new Pagereference('/PO_Riepilogo_KITnew');
        system.debug('@@@@EC pageR(1): ' + pageR);
        pageR.getParameters().put('ceiId',id_cei_Kit);
        system.debug('@@@@EC pageR(2): ' + pageR);
     // pageR.getParameters().put('proc','successInsertATT'); 
        pageR.getParameters().put('showInsVlan','SI'); 
        system.debug('@@@@EC pageR(3): ' + pageR); 
        pageR.getParameters().put('isAvailable','True');
        system.debug('@@@@EC pageR(4): ' + pageR);
        pageR.getParameters().put('NomeKit', nameKit);
        system.debug('@@@@EC pageR(5): ' + pageR);
        if(id_log_Kit!=null && id_log_Kit!=''){
        pageR.getParameters().put('origId',id_log_Kit);    
        system.debug('@@@@EC pageR(6): ' + pageR);
        }
        
        return pageR;
    }

    public PageReference ViewDetailOLD()
    {
        System.debug('***nameKit***: '+nameKit);

        id_log_Kit = [select id
                     from EOF_EAI_Service_Log__c 
                     where recordType.developerName = 'OF_PP_KIT_ActivationRequest'
                     and EOF_Stato_Richiesta__c='Inserita Portale' 
                     and Nome_del_KIT__c =:nameKit
                     limit 1
                    ].id;
                    
        Pagereference pageR = new Pagereference('/PO_RiepilogoKIT');
        pageR.getParameters().put('origId',id_log_Kit);
        pageR.getParameters().put('proc','successInsertATT'); 
        pageR.getParameters().put('showInsVlan','SI'); 
                    //Added Rajani
            pageR.getParameters().put('isAvailable','True');
            pageR.getParameters().put('NomeKit','XXXX');
            //Ended Rajani
        
        return pageR;
    }

    public PageReference runSearch()
    {
        System.debug('NomeKit : '+nomeKit);
        System.debug('IDRisorsa : '+idRisorsa);
        System.debug('Stato : '+stato);
        System.debug('Banda : '+banda);
        System.debug('ServizioCommerciale : '+servizioCommerciale);
        System.debug('DataInizio :'+DataInizio);
        System.debug('Interfaccia :'+interfaccia);
        richiesteTP=true;
        showRow=true;
        showPag=true;
        filtered=true;
        totalRecord=0; 
        pageActual=0;
        totalpage=0;        
        listRichiesteKitWr = new List<KitWrapper>();
        listakitAttivi = new List<OF_CommercialElementIstanziato__c>();
        
        codOp = [SELECT Contact.account.name 
                FROM User 
                WHERE id = :userinfo.getuserid() 
                LIMIT 1].Contact.account.name;
        
        /*        
        Id accId =  [SELECT AccountId 
                    FROM User 
                    where id=:userinfo.getuserid() LIMIT 1].AccountId;
        */

        soql = 'Select id, name, PO_PP_Nome_KIT__c, PO_PP_Pop__c, PO_PP_Banda_Interfaccia__c, PO_PP_InterfacciaKit__c, PO_PP_Servizio_Commerciale__c, OF_Stato__c,'+
                ' RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c, OF_Asset__r.EOF_ID_Risorsa__c, OF_DataAttivazione__c, OF_DataAttivazione_Calc__c '+
                ' from OF_CommercialElementIstanziato__c '+
                ' where OF_CommercialElement__r.name=\'SERVIZIO KIT\''+
                ' and OF_Asset__r.account.name='+'\''+codOp+'\''+
                ' and OF_Asset__r.status=\'Attivo\'';
        
        system.debug('***QUERY SOQL: '+soql);
        
        if (nomeKit!=null&& !nomeKit.equals('')){
            soql += ' and PO_PP_Nome_KIT__c =\''+String.escapeSingleQuotes(nomeKit)+'\'';     
        }
        if (DataInizio!=null && !DataInizio.equals(''))
        {
            soql += ' and OF_DataAttivazione__c >='+String.escapeSingleQuotes(DataInizio); 
            System.debug('@@@Soql'+soql);
        }
        /*
        if (DataFine!=null && !DataFine.equals('')){
            soql += ' and OF_DataCessazione2__c <='+String.escapeSingleQuotes(DataFine);
        }
        */
        if (idRisorsa!=null && !idRisorsa.equals('')){
            soql += ' and OF_Asset__r.EOF_ID_Risorsa__c =\''+String.escapeSingleQuotes(idRisorsa)+'\'';     
        }
        if (pop!=null && !pop.equals('')){                       
            soql += ' and PO_PP_Pop__c =\''+String.escapeSingleQuotes(pop)+'\'';
        }
        if (banda!=null && !banda.equals('')){                       
            soql += ' and PO_PP_Banda_Interfaccia__c =\''+String.escapeSingleQuotes(banda)+'\'';
        }
        if(String.isNotBlank(interfaccia))
        {
            List<String> listInterfacce = (List<String>)System.JSON.deserialize(interfaccia, List<String>.class);
            if(listInterfacce!=null && !listInterfacce.isEmpty())
            {
                soql += ' and PO_PP_InterfacciaKit__c in (';
                
                for (string interfaccia : listInterfacce)
                {
                    soql +='\'' + interfaccia + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';  
            }
        }
        if(String.isNotBlank(servizioCommerciale))
        {
            List<String> listServizi = (List<String>)System.JSON.deserialize(servizioCommerciale, List<String>.class);
            if(listServizi!=null && !listServizi.isEmpty())
            {
                soql += ' and PO_PP_Servizio_Commerciale__c in (';
                
                for (string mystring:listServizi)
                {
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';  
            }
        }
        System.debug('QUERY FORMATTATA !!!! '+soql);
        
        listakitAttivi = Database.query(soql + ' LIMIT 5');
        System.debug('LISTA KIT DOPO QUERY'+listakitAttivi);

        if(listakitAttivi.size()>0)
        {
            showRow=true;
            System.debug('STO DENTRO SIZE >0');
            showPag=true;
            listRichiesteKitWr = populateKitWrapper(listakitAttivi);
            listRichiesteKitString = JSON.serialize(listRichiesteKitWr);
            System.debug('NEW :' + listRichiesteKitWr.size());
        }
        else
        {
            showPag=false;
            richiesteTP=true;          
            listRichiesteKitString='';
            listRichiesteKitWr = new List<KitWrapper>();
            listakitAttivi = new List<OF_CommercialElementIstanziato__c> ();            
            ActualPagination = new List<KitWrapper>();                
        }
        setPagination(null);
        return null;
    }

    public List<KitWrapper> populateKitWrapper(List<OF_CommercialElementIstanziato__c> lista)
    {
        List<KitWrapper> listKitWrp = new List<KitWrapper>();
        
        for(OF_CommercialElementIstanziato__c kit: lista)
        {
            KitWrapper elem = new KitWrapper();
            elem.nomeKit = kit.PO_PP_Nome_KIT__c;
            elem.idRisorsa = kit.OF_Asset__r.EOF_ID_Risorsa__c;
            elem.stato = kit.OF_Stato__c;
            elem.pop = kit.PO_PP_Pop__c;
            elem.banda = kit.PO_PP_Banda_Interfaccia__c;
            elem.interfaccia = kit.PO_PP_InterfacciaKit__c;
            elem.servizioCommerciale = kit.PO_PP_Servizio_Commerciale__c;
            elem.DataAttivazione = string.valueOfGmt(kit.OF_DataAttivazione_Calc__c);
            listKitWrp.add(elem);
        }
        return listKitWrp;
    }
    
    //Metodi per la paginazione
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
            pageActual=1;
            totalpage = totpg; 
            totalRecord = totRec;  
            ActualPagination = listRichiesteKitWr;
            
            if(filtered)
            { 
                listakitAttivi = Database.query(soql + ' order by CreatedDate DESC LIMIT 20');
                
                totRec=((List<OF_CommercialElementIstanziato__c>)Database.query(soql + ' order by CreatedDate DESC')).size();
                system.debug('TOT REC:' + totRec);
                totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
                system.debug(' totpg:' + totpg);
                totalpage = totpg;
                system.debug(' totalpage:' + totalpage);
                totalRecord =totRec; 
                system.debug(' totalRecord:' + totalRecord);
                showPag=totRec>0;
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
            System.debug('*** inside page down!!');
            System.debug('*** YAAY pageActual = ' + pageActual);
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
        integer index=0;
        if(pageActual==totalpage||pageRecord>listRichiesteKitWr.size())
        {
            index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
        }
        else
        {
            index=(pageActual)*(integer)pageRecord;
        }
        integer off=(pageActual-1)*((integer)pageRecord);
        System.debug('**** OFFSET!!! ' + off);
        Id accId = [SELECT AccountId FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
       
        listakitAttivi = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Pop__c, PO_PP_Banda_Interfaccia__c, PO_PP_InterfacciaKit__c, PO_PP_Servizio_Commerciale__c, OF_Stato__c, 
                          RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c, OF_Asset__r.EOF_ID_Risorsa__c, OF_DataAttivazione__c, OF_DataAttivazione_Calc__c 
                          from OF_CommercialElementIstanziato__c
                          where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                          and OF_Asset__r.account.name =:codOp
                          and OF_Asset__r.status='Attivo'
                          LIMIT :(integer)pageRecord
                          OFFSET :off
                         ];
        
        System.debug('*** size listakitAttivi in prepare page ' + listakitAttivi.size());
        
        if(listakitAttivi.size()>0)
        { 
            listRichiesteKitWr = populateKitWrapper(listakitAttivi);
            listRichiesteKitString = JSON.serialize(listakitAttivi);
        }
        ActualPagination = new List<KitWrapper>();
        ActualPagination = listRichiesteKitWr;
    }
    
    //KIT Wrapper
    public class KitWrapper{
        public string id{get;set;}
        public String nomeKit{get;set;}
        public string idRisorsa{get;set;}
        public String stato{get;set;}
        public String pop{get;set;}
        public String banda{get;set;}
        public String interfaccia{get;set;}
        public String servizioCommerciale{get;set;}
        public String DataCessazione{get;set;}
        public String DataAttivazione{get;set;}
        
        public KitWrapper(){}
    }
}
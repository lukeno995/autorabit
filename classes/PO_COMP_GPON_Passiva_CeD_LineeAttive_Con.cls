public class PO_COMP_GPON_Passiva_CeD_LineeAttive_Con{
    
    public String titolare{get;set;}
    public boolean checkMessage{get;set;}
    public string message{get;set;}
    public boolean showRow{get;set;}
    public boolean richiesteTP{get;set;}
    public List<Asset> listRichiesteTP {get;set;}
    public List<AssetWrapper> listRichiesteW {get;set;}
    public List<AssetWrapper> ActualPagination {get;set;}
    public String IdScelta{get;set;}
    public Integer totalRecord{get;set;}    
    public Integer pageActual{get;set;}
    public Decimal totalpage{get;set;}
    public boolean showPag{get;set;}
    public String DataInizio{get;set;}
    public String DataFine{get;set;}
    public String IDRisorsa{get;set;}
    //public String Profilo{get;set;}
    public String Listino{get;set;}
    public String soql {get;set;}
    public String statusJSON{get;set;}
    public String listRichiesteTPstring {get;set;}
    public Decimal pageRecord{get;set;} 
    public string idAsset{get;set;}
    public Integer totRec{get;set;}
    
    public Boolean filtered{get;set;}
    public Decimal totpg{get;set;}

    public PageReference ViewDetail(){
        PageReference pg = new PageReference('/PO_DetailChange');
        pg.getParameters().put('origId',idAsset);
        return pg;
    }

    public PageReference runSearch() 
    { 
        System.debug('DI : ' +DataInizio);
        System.debug('DF : ' +DataFine);
        System.debug('IDR : ' +IDRisorsa);
        //System.debug('PR : ' +Profilo);
        System.debug('LI : ' +Listino);
        richiesteTP = true;
        showRow = true;
        showPag = true;
        filtered = true;
        totalRecord = 0; 
        pageActual = 0;
        totalpage = 0;        
        listRichiesteW = new List<AssetWrapper>();
        listRichiesteTP = new List<Asset>();
        
        Id accId =  [SELECT AccountId 
                     FROM User 
                     where id=:userinfo.getuserid() 
                     LIMIT 1].AccountId;
        
        soql='SELECT Id,Name,ContactId,Product2id, EOF_ID_Risorsa__c, OF_DataAttivazione2__c,OF_DataCessazione2__c,'+
                'OF_ProfiloOpenStream__c,Status from ASSET where Id IN (SELECT OF_Asset__c FROM PricebookEntry WHERE isActive = true AND Name = \'Canone\') AND AccountId=\''+accId+'\''+
                'AND RecordType.DeveloperName=\'GPON_Passiva_CeD\'';
                //'(SELECT OF_Asset__c FROM PricebookEntry WHERE isActive = true AND Name = \'Canone\')';
        
        system.debug('***Soql value '+soql);
        if (DataInizio!=null && !DataInizio.equals('')){
            soql += ' and OF_DataAttivazione2__c >='+String.escapeSingleQuotes(DataInizio); 
            System.debug('@@@Soql'+soql);
        }
        if (DataFine!=null && !DataFine.equals('')){
            soql += ' and OF_DataCessazione2__c <='+String.escapeSingleQuotes(DataFine);
        }
        if (IDRisorsa!=null&& !IDRisorsa.equals('')){
            soql += ' and EOF_ID_Risorsa__c =\''+String.escapeSingleQuotes(IDRisorsa)+'\'';     
        }
        /*
        if (Profilo!=null&& !Profilo.equals('')){                       
            soql += ' and OF_ProfiloOpenStream__c =\''+String.escapeSingleQuotes(Profilo)+'\'';
        }
        */
        System.debug('QUERY FORMATTATA !!!! ' + soql);
        
        if(String.isNotBlank(statusJSON))
        {
            List<String> ListStatus = (List<String>)System.JSON.deserialize(statusJSON, List<String>.class);
            if(ListStatus!=null && !ListStatus.isEmpty()){
                soql += ' and Status in (';
                //soql +=' and in Case_Portale__r.Status  (';
                for (string mystring:ListStatus){
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';  
            }
        }
        listRichiesteTP = Database.query(soql + 'LIMIT 5');
        System.debug('LISTA ASSET DOPO QUERY'+listRichiesteTP);


        if(listRichiesteTP.size()>0)
        {
            showRow=true;
            System.debug('STO DENTRO SIZE >0');
            showPag=true;
            List<Id> assIdList = R.of(listRichiesteTP)
                .pluck('Id')
                .debug()
                .toStringList();
            
            List<PriceBook2> lsPb = new List<PriceBook2>();
            List<PricebookEntry> lsPbe=null;

            if (Listino!=null && !Listino.equals(''))
            {    
                lsPbe=[Select Pricebook2Id,Pricebook2.Name,OF_Asset__c 
                        from PricebookEntry 
                        where OF_Asset__c in: assIdList 
                        and  isActive = true 
                        AND Name = 'Canone' 
                        and Pricebook2.Name=:Listino];
            }
            else
            {
                lsPbe=[Select Pricebook2Id,Pricebook2.Name,OF_Asset__c 
                        from PricebookEntry 
                        where OF_Asset__c in: assIdList 
                        and  isActive = true 
                        AND Name = 'Canone'];
            }
            listRichiesteW=populateWrapper(listRichiesteTP,lsPbe);
            listRichiesteTPString = JSON.serialize(listRichiesteW);
            System.debug('NEW :' + listRichiesteW.size());   
        }
        else
        {
            showPag=false;
            richiesteTP=true;          
            listRichiesteTPString ='';
            listRichiesteW = new List<AssetWrapper>();
            listRichiesteTP = new List<Asset> ();            
            ActualPagination = new List<AssetWrapper>();                
        }
        setPagination(null);
        return null;
    }

    public List<AssetWrapper> populateWrapper(List<Asset> lista, List<PriceBookEntry> lspbe)
    {
        List<AssetWrapper>  lsWp=new List<AssetWrapper>();
        for (Asset ass: lista){
            
            PriceBookEntry c = (PriceBookEntry)R.of(lspbe).find(R.whereEq.apply(new Map<String, Object>{
                'OF_Asset__c' => ass.Id}))
                .toSObject();
            
            if (c!=null){
                AssetWrapper elem = new AssetWrapper();
                elem.Listino = c.Pricebook2.Name;
                elem.id = ass.id;
                elem.IDRisorsa = ass.Name;
                //elem.Profilo = ass.OF_ProfiloOpenStream__c;
                elem.Stato = ass.Status;
                elem.DataAttivazione = string.valueOfGmt(ass.OF_DataAttivazione2__c);
                elem.DataCessazione = string.valueOfGmt(ass.OF_DataCessazione2__c);
                lsWp.add(elem);
            }
        }
        return lsWp;
    }
    
    public PageReference pageUp(){
        setPagination(true);
        return null;
    }
    
    public PageReference pageDown(){
        setPagination(false);
        return null;
    }
    
    public void setPagination(boolean next)
    {
        if(next==null){
            pageActual=1;
            totalpage = totpg; 
            totalRecord = totRec;  
            ActualPagination=listRichiesteW;
            if(filtered)
            { 
                listRichiesteTP = Database.query(soql + ' order by CreatedDate DESC LIMIT 20');
                
                totRec=((List<Asset>)Database.query(soql + ' order by CreatedDate DESC')).size();
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
            if(pageActual<totalpage){
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
            if(pageActual > 1){
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
        if(pageActual==totalpage||pageRecord>listRichiesteW.size()){
            index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
        }
        else{
            index=(pageActual)*(integer)pageRecord;
        }
        integer off = (pageActual-1)*((integer)pageRecord);
        System.debug('**** OFFSET!!! ' + off);
        Id accId =  [SELECT AccountId 
                    FROM User 
                    where id=:userinfo.getuserid() LIMIT 1].AccountId;
       
            listRichiesteTP = [SELECT Id,Name,ContactId,Product2id, EOF_ID_Risorsa__c, OF_DataAttivazione2__c,OF_DataCessazione2__c,OF_ProfiloOpenStream__c,Status 
                                FROM ASSET 
                                WHERE AccountId=:accId 
                                AND RecordType.DeveloperName = 'OF_CD_Asset_GPON_Passiva' 
                                AND (Status='Attivo' or Status = 'In Modifica') 
                                AND Id IN 
                                        (SELECT OF_Asset__c 
                                            FROM PricebookEntry 
                                            WHERE isActive = true 
                                            AND Name = 'Canone' ) 
                                LIMIT :(integer)pageRecord
                                OFFSET :off
                                ];
        
        System.debug('*** size listrichiesta in prepare page ' + listRichiesteTP.size());
        // [SELECT Id,Name,ContactId,Product2id, EOF_ID_Risorsa__c, OF_DataAttivazione2__c,OF_DataCessazione2__c,OF_ProfiloOpenStream__c,Status from ASSET where AccountId=:accId and RecordType.DeveloperName = 'OF_OpenStream' and (Status='Attivo' or Status='In Modifica') Limit :(integer)pageRecord OFFSET:off];
        if(listRichiesteTP.size()>0)
        { 
            showPag=true; 
            List<Id> assIdList = R.of(listRichiesteTP)
                .pluck('Id')
                .debug()
                .toStringList();
            richiesteTP = true;
           
            List<PricebookEntry> lsPbe = [Select Pricebook2Id, Pricebook2.Name, OF_Asset__c 
                                          from PricebookEntry 
                                          where OF_Asset__c in: assIdList 
                                          and isActive = true 
                                          AND Name = 'Canone'];
            
            System.debug('**** list pbe size in prepare page ' + lsPbe.size());
            listRichiesteW=populateWrapper(listRichiesteTP,lsPbe);
            listRichiesteTPString = JSON.serialize(listRichiesteW);
        }
        ActualPagination= new List<AssetWrapper>();
        ActualPagination = listRichiesteW;

        /*for (integer i=(pageActual-1)*((integer)pageRecord);i<index;i++){
            ActualPagination.add(listRichiesteW.get(i));
        }*/
    }

    public PO_COMP_GPON_Passiva_CeD_LineeAttive_Con() 
    {
        totalRecord = 0;
        pageActual = 0;
        totalpage = 0;
        pageRecord = 5;
        richiesteTP = true;
        showRow = true;
        showPag = true;
        filtered = false;
        Integer off = 0; 
        //Id contId = [SELECT ContactId FROM User where id=:userinfo.getuserid() LIMIT 1].ContactId;
        Id accId =  [SELECT AccountId 
                     FROM User 
                     where id=:userinfo.getuserid() 
                     LIMIT 1].AccountId;
                     
        System.debug('***** account id ' + accId);
        listRichiesteTP = [SELECT Id,Name,ContactId,Product2id, EOF_ID_Risorsa__c, OF_DataAttivazione2__c,OF_DataCessazione2__c,OF_ProfiloOpenStream__c,Status 
                            FROM ASSET 
                            WHERE AccountId=:accId 
                            AND RecordType.DeveloperName = 'OF_CD_Asset_GPON_Passiva' 
                            AND (Status='Attivo' or Status = 'In Modifica') 
                            AND Id IN 
                                    (SELECT OF_Asset__c 
                                    FROM PricebookEntry 
                                    WHERE isActive = true 
                                    AND Name = 'Canone' ) 
                            LIMIT :(integer)
                            pageRecord OFFSET :off
                          ];
                            
        System.debug('***** listRichiesteTP ' + listRichiesteTP);
        
        totRec = [SELECT count() 
                  FROM ASSET 
                  WHERE AccountId = :accId 
                  AND RecordType.DeveloperName = 'OF_CD_Asset_GPON_Passiva'
                  AND (Status='Attivo' or Status = 'In Modifica') 
                  AND Id IN (SELECT OF_Asset__c 
                            FROM PricebookEntry 
                            WHERE isActive = true 
                            AND Name = 'Canone' )];

        totpg = (totRec/pageRecord).round(RoundingMode.CEILING);
            
        if(listRichiesteTP.size()>0)
        { 
            showPag=true; 
            List<Id> assIdList = R.of(listRichiesteTP)
                .pluck('Id')
                .debug()
                .toStringList();
            richiesteTP = true;

            List<PricebookEntry> lsPbe = [Select Pricebook2Id, Pricebook2.Name, OF_Asset__c 
                                          from PricebookEntry 
                                          where OF_Asset__c in: assIdList 
                                          and isActive = true 
                                          AND Name = 'Canone'];
                                            
            listRichiesteW = populateWrapper(listRichiesteTP,lsPbe);
            listRichiesteTPString = JSON.serialize(listRichiesteW);
            setPagination(null);
        }
    }
    
    public class ListinoAssetWrapper{
        public String NomeListino{get;set;}
        public String AssetId{get;set;}
        public ListinoAssetWrapper(){}
    }
    
    public class AssetWrapper{
        public String IDRisorsa{get;set;}
        public string id{get;set;}
        //public String Profilo{get;set;}
        public String Listino{get;set;}
        public String Stato{get;set;}
        public String DataCessazione{get;set;}
        public String DataAttivazione{get;set;}
        public AssetWrapper(){}
    }
}
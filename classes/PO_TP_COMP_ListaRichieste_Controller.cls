public class PO_TP_COMP_ListaRichieste_Controller {
    
    public String causApertuAtt{get;set;}
    public String titolare{get;set;}
    public List<Case> listRichiesteTP {get;set;}
    public boolean richiesteTP{get;set;}
    public String IdScelta{get;set;}
    public User attuale;
    public String DataInizio{get;set;}
    public String DataFine{get;set;}
    public String n; 
    public String casualeAperturaJSON{get;set;}
    public String descrizioneCasualeJSON{get;set;}
    public String statusJSON{get;set;}
    public String escalationJSON{get;set;} //Add by PG 08-05
    public boolean escalation{get;set;}
    public map<Id,Boolean> escalationMap{get;set;}
    public DateTime createdDateForEscalation{get;set;}
    public boolean checkMessage{get;set;}
    public string message{get;set;}
    public String soql {get;set;}
    public String listRichiesteTPstring {get;set;}
    public String listRichiesteSelezionateTPstring {get;set;} //Add by PG 16-05
    public Integer totalRecord{get;set;} //Add by PG 06-06
    public Integer pageActual{get;set;} //Add by PG 06-06
    public Decimal totalpage{get;set;} //Add by PG 06-06
    public boolean showPag{get;set;} //Add by PG 06-06
    public Decimal pageRecord{get;set;} //Add by PG 06-06 
    public Integer offset_page{get;set;} //Add by PG 06-06 
    public Decimal totpg{get;set;}
    public boolean showRow{get;set;}
    public Integer totRec{get;set;}
    public Boolean filtered{get;set;}
    public String debugSoql {
        get { return soql;}
        set;
    }
    
    /*
    public List<String> ListCasualeApertura {get;set;}
    
    public List<String> ListStatus {get;set;}
    
    public String DataFine {get;set;}
    
    public String DataInizio {get;set;}
    */
    
    public String optCausaleAperturaString {get;set;}
    public String optDescrizioneCausaleString {get;set;}
    public String optStatusString  {get;set;}
    public String optEscalationString {get;set;} //Add by PG 08-05  
    public Map<String,String> mapCausale = new Map<String,String>();                                               
  

    // wrapper per la generazione delle option delle selectlist
    public class optionApex {

        public string value {get; set;}
        public string text {get; set;}
        public boolean b1 {get; set;}
        public boolean b2 {get; set;}

        //This is the contructor method. 
        public optionApex(string s, string t) {
            value = s;
            text = t;
        }
        /* ADD by PG - 07-05*/
        public optionApex(boolean a, boolean b){
            b1= a;
            b2 = b;
        }
    } 
   
    //Costruttore
    public PO_TP_COMP_ListaRichieste_Controller()
    {
        totalRecord=0;
        pageActual=0;
        totalpage=0;    
        pageRecord=20;
        richiesteTP=true;
        showRow=true;
        filtered=false;
        showPag=true; 
        causApertuAtt=ApexPages.currentPage().getParameters().get('azione');
        system.debug('giovannnidddd'+causApertuAtt);

        if(causApertuAtt=='Provisioning'){
           causApertuAtt='Segnalazione Provisioning';
           titolare='Richieste su Linee in Attivazione';
        }else{
             causApertuAtt='Problema tecnico/applicativo';
             titolare='Richieste su Incident Management';
        }
        checkMessage=false;
        escalation=false;
        escalationMap = new  map<Id,Boolean>(); 
        //User utenteLoggato = [select id,Account.EOF_Codice_Operatore__c from User where id =: UserInfo.getUserId()];
        richiesteTP = false;
        attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
        listRichiesteTP = [Select id,RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Codice_Ordine_Ticket_Provisioning__c,
                            PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c, PO_TP_Dettaglio_Richiesta__c, status,
                            PO_TP_Escalation__c,CreatedDate, PO_TP_TicketNumber__c, PO_TP_Stato_Ticket__c, casenumber, PO_TP_Sottocausale__c
                            from Case 
                            where recordtype.DeveloperName = 'PO_TP_TicketProvisioning_Case' 
                            and /*PO_TP_Ordine_Di_Riferimento__r.*/EOF_Codice_Operatore_WS__c=:attuale.Account.EOF_Codice_Operatore__c 
                            and PO_TP_Causale_Apertura_Segnalazione__c =:causApertuAtt
                            order by CreatedDate DESC LIMIT 20];

         totRec     = [Select COUNT()
                        from Case 
                        where recordtype.DeveloperName = 'PO_TP_TicketProvisioning_Case' 
                        and /*PO_TP_Ordine_Di_Riferimento__r.*/EOF_Codice_Operatore_WS__c=:attuale.Account.EOF_Codice_Operatore__c 
                        and PO_TP_Causale_Apertura_Segnalazione__c =:causApertuAtt
                        ];
        
        totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
                        
        listRichiesteTPstring=JSON.serialize(listRichiesteTP);
        listRichiesteSelezionateTPstring = JSON.serialize(listRichiesteTP); //Add by PG 16-05

        if( listRichiesteTP.size()>0)
        {
            richiesteTP = true;
            
            Set<String> setCausaleApertura =new Set<String>();
            Set<String> setDescrizioneCausale =new Set<String>();
            Set<Boolean> setEscalation =new Set<Boolean>();
            Set<String> setStatus =new Set<String>();
            List<optionApex>optCausaleApertura = new List<optionApex>();
            List<optionApex>optDescrizioneCausale = new List<optionApex>();
            List<optionApex>optEscalation = new List<optionApex>();
            List<optionApex>optStatus = new List<optionApex>();
            
            //controllo qual è la createdDate di partenza per calcolare se il case puo andare in escalation o meno
            BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
            Integer countBusinessDays = 0;
            Integer giorniLineari = 0;

            do {
                giorniLineari--;
                system.debug('giorniLineari '+giorniLineari);
                createdDateForEscalation = Date.today().addDays(giorniLineari);
                if(BusinessHours.isWithin(bh_dac.Id, createdDateForEscalation) == true ){
                    countBusinessDays--;
                    system.debug(createdDateForEscalation +' conta nel countBusinessDays '+countBusinessDays);
                }                
            } 
            while (countBusinessDays > -4);   
            
            for(Case mySL:listRichiesteTP){
       
                if(!mySL.PO_TP_Escalation__c && mySL.createdDate<createdDateForEscalation){
                    escalation=true;
                    escalationMap.put(mySL.Id,true);
                }
                else{
                    escalationMap.put(mySL.Id,false);
                }
                if(setCausaleApertura.add(mySL.PO_TP_Causale_Apertura_Segnalazione__c)){
                    optCausaleApertura.add(new optionApex(mySL.PO_TP_Causale_Apertura_Segnalazione__c,mySL.PO_TP_Causale_Apertura_Segnalazione__c));
                }
                if(setDescrizioneCausale.add(mySL.PO_TP_Descrizione_Causale__c)){
                    optDescrizioneCausale.add(new optionApex(mySL.PO_TP_Descrizione_Causale__c,mySL.PO_TP_Descrizione_Causale__c));
                }
                if(setStatus.add(mySL.status)){
                    optStatus.add(new optionApex(mySL.status,mySL.status));
                }
                if(setEscalation.add(mySL.PO_TP_Escalation__c)){
                    optEscalation.add(new optionApex(mySL.PO_TP_Escalation__c,mySL.PO_TP_Escalation__c));
                }   
            }
            
            if(ApexPages.currentPage().getParameters().get('mess')=='escalated'){
                checkMessage=true;
                message='La richiesta è stata scalata correttamente';
            } 
            optCausaleAperturaString=JSON.serialize(optCausaleApertura);
            optDescrizioneCausaleString=JSON.serialize(optDescrizioneCausale);
            optStatusString=JSON.serialize(optStatus);
            optEscalationString = JSON.serialize(optEscalation);   
            setPagination(null);         
        }                            
    }
    
    public PageReference runSearch() { 
            
            //String DataInizio = Apexpages.currentPage().getParameters().get('DataInizio');
            //String DataFine = Apexpages.currentPage().getParameters().get('DataFine');
            filtered=true;
            //Add by PG - 16-05 - Aggiunti campi in query
            soql = 'Select id, casenumber, RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Codice_Ordine_Ticket_Provisioning__c, '+
                    'PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c, PO_TP_TicketNumber__c, PO_TP_Stato_Ticket__c, PO_TP_Dettaglio_Richiesta__c, status, CreatedDate, '+
                    ' PO_TP_Escalation__c from Case where recordtype.DeveloperName = \'PO_TP_TicketProvisioning_Case\'';
                    
            if (DataInizio!=null && !DataInizio.equals('')){
              soql += ' and CreatedDate >='+String.escapeSingleQuotes(DataInizio);
            }
            if (DataFine!=null && !DataFine.equals('')){
              soql += ' and CreatedDate <='+String.escapeSingleQuotes(DataFine);
            }
            
            /*
            if(String.isNotBlank(casualeAperturaJSON)){
                List<String> ListCasualeApertura = (List<String>)System.JSON.deserialize(casualeAperturaJSON, List<String>.class);
                if(ListCasualeApertura!=null && !ListCasualeApertura.isEmpty()){
                    soql += ' and PO_TP_Causale_Apertura_Segnalazione__c in (';
                      for (string mystring:ListCasualeApertura){
                        soql +='\'' + mystring + '\',';
                      }
                      soql = soql.removeEnd(',');
                      soql += ')';      
                }       
            }*/
            soql += ' and PO_TP_Causale_Apertura_Segnalazione__c = \'' + causApertuAtt + '\'' ;
        
            if(String.isNotBlank(descrizioneCasualeJSON)){
                List<String> ListDescrizioneCasuale = (List<String>)System.JSON.deserialize(descrizioneCasualeJSON, List<String>.class);
              if(ListDescrizioneCasuale!=null && !ListDescrizioneCasuale.isEmpty()){
                  soql += ' and PO_TP_Descrizione_Causale__c in (';
                  for (string mystring:ListDescrizioneCasuale){
                    soql +='\'' + mystring + '\',';
                  }
                  soql = soql.removeEnd(',');
                  soql += ')';  
              }     
            }
            if(String.isNotBlank(statusJSON)){
                List<String> ListStatus = (List<String>)System.JSON.deserialize(statusJSON, List<String>.class);
              if(ListStatus!=null && !ListStatus.isEmpty()){
                  soql += ' and status in (';
                  //soql +=' and in Case_Portale__r.Status  (';
                  for (string mystring:ListStatus){
                    soql +='\'' + mystring + '\',';
                  }
                  soql = soql.removeEnd(',');
                  soql += ')';  
              }
            }
            if(String.isNotBlank(escalationJSON)){

                List<String> ListEscalation = (List<String>)System.JSON.deserialize(escalationJSON, List<String>.class);
              
                if(ListEscalation!=null && !ListEscalation.isEmpty()){
                  soql += ' and PO_TP_Escalation__c in (';
                    for (string mystring:ListEscalation){
                        soql += +mystring+ ',';
                  }
                  soql = soql.removeEnd(',');
                  soql += ')';  
              }     
            }            
            //User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
           	soql += ' and EOF_Codice_Operatore_WS__c=\'' + attuale.Account.EOF_Codice_Operatore__c  + '\' '; 
          //  soql += ' and PO_TP_Ordine_Di_Riferimento__r.EOF_Codice_Operatore_WS__c=\'' + attuale.Account.EOF_Codice_Operatore__c  + '\' ';
            setPagination(null);
            return null;
    }

    public void runQuery()
    {
        system.debug('@@@@ soql: '+soql);
        escalation=false;
     
        //listRichiesteTPstring=JSON.serialize(listRichiesteTP);
        listRichiesteSelezionateTPstring = JSON.serialize(listRichiesteTP); //Add by PG 16-05
            
        Set<String> setCausaleApertura =new Set<String>();
        Set<String> setDescrizioneCausale =new Set<String>();
        Set<Boolean> setEscalation =new Set<Boolean>();
        Set<String> setStatus =new Set<String>();
        List<optionApex>optCausaleApertura = new List<optionApex>();
        List<optionApex>optDescrizioneCausale = new List<optionApex>();
        List<optionApex>optEscalation = new List<optionApex>();
        List<optionApex>optStatus = new List<optionApex>();
            
        for(Case mySL:listRichiesteTP  ){
            if(!mySL.PO_TP_Escalation__c && mySL.createdDate<createdDateForEscalation){
                escalation=true;
                escalationMap.put(mySL.Id,true);
            }
            else{
                escalationMap.put(mySL.Id,false);
            }
            if(setCausaleApertura.add(mySL.PO_TP_Causale_Apertura_Segnalazione__c)){
                optCausaleApertura.add(new optionApex(mySL.PO_TP_Causale_Apertura_Segnalazione__c,mySL.PO_TP_Causale_Apertura_Segnalazione__c));
            }
            if(setDescrizioneCausale.add(mySL.PO_TP_Descrizione_Causale__c)){
                optDescrizioneCausale.add(new optionApex(mySL.PO_TP_Descrizione_Causale__c,mySL.PO_TP_Descrizione_Causale__c));
            }
            if(setStatus.add(mySL.status)){
                optStatus.add(new optionApex(mySL.status,mySL.status));
            }
            if(setEscalation.add(mySL.PO_TP_Escalation__c)){
                optEscalation.add(new optionApex(mySL.PO_TP_Escalation__c,mySL.PO_TP_Escalation__c));
            }   
        }            
        optCausaleAperturaString=JSON.serialize(optCausaleApertura);
        optDescrizioneCausaleString=JSON.serialize(optDescrizioneCausale);
        optStatusString=JSON.serialize(optStatus);
        optEscalationString=JSON.serialize(optEscalation);
        system.debug('@@@@@@@@@ escalation: '+escalation);           
    }
    
    public void vaiInEscalation(){
        try{
            Case c = new Case();
            c.Id=IdScelta;
            c.PO_TP_Escalation__c=true;
            update c;
            system.debug('@@@@@@@@@@@@ aggiornato correttamente: '+IdScelta);
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);            
        }
    }


    //Funzione di View Dettagli del Case onclick
    public PageReference ViewCaseDettail()
    {
        PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
        pg.getParameters().put('proc','TPVisualizza');
        pg.getParameters().put('origId',IdScelta);
        return pg;
    }

    public Double offset{get{
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }}


    //START - Paginazione 6-06
    public PageReference pageUp(){
      
        System.debug('totalPage:'+totpg);
        System.debug('totalRecord:'+totalRecord);
        System.debug('pageActual:'+pageActual);
        setPagination(true);        
        return null;
    }

    public PageReference pageDown(){
       
        setPagination(false);
        return null;
    }

    public void setPagination(boolean next){
         
        if(next==null){
            pageActual=1;
            totalpage = totpg; 
            totalRecord =totRec;                 
            pageRecord=20;
            
            if (filtered){
                listRichiesteTP = Database.query(soql + ' order by CreatedDate DESC LIMIT 20');
                totRec=((List<Case>)Database.query(soql + ' order by CreatedDate DESC')).size();
                totpg = (totRec /pageRecord).round(RoundingMode.CEILING);
                totalpage = totpg; 
                totalRecord =totRec; 
                showPag=totRec>0;
                runQuery();
            } 
         
        }else if(next){ 
            if(pageActual<totalpage){
            pageActual++;
            totalpage = totpg;
            totalRecord = totRec;
            preparePage();
            }
        }else{
            if(pageActual>1){
            pageActual--;
            totalpage = totpg;
            totalRecord = totRec;
            preparePage();
            }
        }
    }

    public void preparePage(){    

        System.debug('preparepage: ');
        integer index=0;
        if(pageActual==totalpage||pageRecord>listRichiesteTP.size()){
            index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
        }else{
            index=(pageActual)*(integer)pageRecord;
        }
        integer  off=(pageActual-1)*((integer)pageRecord);
        System.debug('Off: '+off);

        if (!filtered)
        {
            listRichiesteTP = [Select id,RecordType.developername,PO_TP_Causale_Apertura_Segnalazione__c,PO_TP_Codice_Ordine_Ticket_Provisioning__c,
                                PO_TP_Stato_Ordine_Ticket_Provisioning__c,PO_TP_Descrizione_Causale__c, PO_TP_Dettaglio_Richiesta__c, status,
                                PO_TP_Escalation__c,CreatedDate, PO_TP_TicketNumber__c, PO_TP_Stato_Ticket__c, casenumber
                                from Case 
                                where recordtype.DeveloperName = 'PO_TP_TicketProvisioning_Case' 
                                and /*PO_TP_Ordine_Di_Riferimento__r.*/EOF_Codice_Operatore_WS__c=:attuale.Account.EOF_Codice_Operatore__c 
                                and PO_TP_Causale_Apertura_Segnalazione__c =:causApertuAtt
                                order by CreatedDate DESC LIMIT 20 OFFSET :off];
            System.debug('listRichiesteTP: '+listRichiesteTP);
        }
        else{
            listRichiesteTP = Database.query(soql + ' order by CreatedDate DESC LIMIT 20 OFFSET '+off);          
    
        }
        runQuery();
    }
}
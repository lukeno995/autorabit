public class CQS_EventiReport {
   
    public Date dateFrom {get; set;}
    public Date dateTo {get; set;}
    public string combotypeout{get;set;}
    public string tipoEvento {get;set;}
    public string tipoIspezione{get; set;}
    public string nomeProgetto{get; set;}
    List<OF_CQS_Ispezione__c> ispList {get; set;}
    List<OF_CQS_Evento__c> evList {get; set;}
    public List<SelectOption> cmbotype{get;set;}
    public List<SelectOption> optNomeProgetto {get; set;} 
    public String optScelta {get; set;}
    public map<String,Id> rtmap{get; set;}

    public OF_CQS_Ispezione__c isp{get; set;}
    public OF_CQS_Evento__c ev{get; set;}
    public List<OF_CQS_Evento__c> eventiList{get; set;}
     public List<OF_CQS_Ispezione__c> ispezioniList{get; set;}
    public boolean checkButton{get; set;}
    public boolean checkEventi{get; set;}
    public boolean checkIspezioni{get; set;}
    
    private integer count=1;   //to track the function calling?
    private integer counter=0;   //to keep track of offset
    private integer list_size=20; //to set the page size to show the rows/records
    public integer total_size; //used to show user the total size of the list   
  
    public id userId {get;set;}
    
    public CQS_EventiReport(){
        //definisciProgettiPl();
        checkButton=false;
        checkEventi=false;
        checkIspezioni=false;
    }
    
    
    /*
    public void definisciProgettiPl(){
            List<String> juncUserProg = new List<String>();
                        
            optNomeProgetto = new List<SelectOption>();
            for(Progetto_Utente_junction__c jpu:[select CQS_junc_progetto__r.Name,CQS_junc_progetto__c 
                                                 from Progetto_Utente_junction__c where CQS_junc_user__c =:userinfo.getUserId()]){
            optNomeProgetto.add(new SelectOption(jpu.CQS_junc_progetto__c,jpu.CQS_junc_progetto__r.Name));      
            } 
    }  
    
    public List<wrapperReport> getvlstWrapper(){   
//          vlstwrap= new List<wrapperReport>();
        vlstwrap.clear();
        List<OF_CQS_Evento__c> evList=new List<OF_CQS_Evento__c>();
        if(combotypeout=='Bad Practice'){
            evList=[select Id, CQS_Ev_Progetto__c, CQS_Ev_Lettera_D_Ordine__c, OF_CQS_Impresa_Mandataria__c, 
            OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Stato_Pratica__c, OF_CQS_Data_Evento__c, OF_CQS_Data_Apertura_Pratica__c,
            OF_CQS_Comune_Text__c, OF_CQS_Diffida__c,Numero_Protocollo__c, OF_CQS_Richiesta_Danni__c,
            OF_CQS_Inadempienze_Operative__c, OF_CQS_Oggetto__c, OF_CQS_Rispetto_Procedura__c from OF_CQS_Evento__c 
            where recordType.developername='OF_CQS_Bad_Practice'];
        }
        if(combotypeout=='Danneggiamenti a terzi'){
            evList=[select Id, CQS_Ev_Progetto__c, CQS_Ev_Lettera_D_Ordine__c, OF_CQS_Impresa_Mandataria__c, 
            OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Stato_Pratica__c, OF_CQS_Data_Evento__c, OF_CQS_Data_Apertura_Pratica__c,
            OF_CQS_Comune_Text__c,OF_CQS_Struttura_Danneggiata__c,CQS_Indice_Gravita_Taglio_Danneggiamento__c,EOF_CQS_Proprietario__c from OF_CQS_Evento__c
            where recordType.developername='OF_CQS_Danni_Arrecati' ];
        }
        if(combotypeout=='Infortuni'){
            evList=[select id, CQS_Ev_Progetto__c, CQS_Ev_Lettera_D_Ordine__c, OF_CQS_Impresa_Mandataria__c, 
            OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Stato_Pratica__c, OF_CQS_Data_Evento__c, OF_CQS_Data_Apertura_Pratica__c,
            OF_CQS_Comune_Text__c, Persona_Coinvolta__c, OF_CQS_Eta__c, OF_CQS_Mansione__c, OF_CQS_Anzianita__c, Pratica_INAIL__c, OF_CQS_Indice_Gravita_Infortunio__c, 
            OF_CQS_Giorni_Persi_e__c, OF_CQS_Decesso__c, OF_CQS_Prognosi_Riservata__c, Prognosi__c, OF_CQS_Prognosi_aggiuntiva__c 
            from OF_CQS_Evento__c where recordType.developername='OF_CQS_Infortunio'];
        }
        if(combotypeout=='Interferenze a sottoservizi'){
            evList=[select Id, CQS_Ev_Progetto__c, CQS_Ev_Lettera_D_Ordine__c, OF_CQS_Impresa_Mandataria__c, 
            OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Stato_Pratica__c, OF_CQS_Data_Evento__c, OF_CQS_Data_Apertura_Pratica__c,
            OF_CQS_Comune_Text__c, Sottoservizio__c,CQS_Indice_Gravita_Taglio_Danneggiamento__c,CQS_Ev_Profondita__c,OF_CQS_Indagini__c,OF_CQS_Rete_Superficiale__c,
            OF_CQS_Rispetto_Procedura__c,OF_CQS_Ente__c from OF_CQS_Evento__c 
            where recordType.developername='OF_CQS_Interferenza_Sottoservizi'];
        }
    
        for (OF_CQS_Evento__c ev : evList){
            
            if(combotypeout=='Bad Practice'){
                system.debug('@@@@@@@@@@@@@@@ Bad Practice');
                evList.add(ev);
            }
            if(combotypeout=='Danneggiamento a terzi'){
                evList.add(ev);
            }
            if(combotypeout=='Infortunio'){
                evList.add(ev);
            }
            if(combotypeout=='Interferenze a sottoservizi'){
                evList.add(ev);
            }
        }
        vlstwrap.addAll(evList);
        return vlstwrap; 
    }
    */
    
   	 public List<OF_CQS_Ispezione__c> getIspezioni(){
        ispezioniList = [select id, Name, CQS_ISP_Progetto__c, CQS_ISP_LDO__c, OF_CQS_Impresa_Mandataria__c, 
            OF_CQS_Impresa_Ispezionata__c, CQS_ISP_Punteggio_Totale__c, CQS_Punteggio_Tot_Max_Isp__c, CQS_ISP_Perc_Tot_Punt__c, OF_CQS_Data_Ispezione__c,
            OF_CQS_ISP_Comune__c, CQS_ISP_Esito_dettLav__c, CQS_ISP_Esito_LavorPres__c, CQS_ISP_Totale_Documentazione_Minima__c, CQS_ISP_Tot_Max_Doc_min__c, CQS_ISP_Totale_Organizzazione_Cantiere__c, CQS_ISP_Tot_Max_Org_Cantiere__c, 
            CQS_ISP_Totale_Personale_Cantiere__c, CQS_ISP_Tot_Max_Pers_Cantiere__c, CQS_ISP_Totale_Mezzi_Attrezzature_del__c, CQS_ISP_Tot_Max_Mezzi_Attrezz__c, CQS_ISP_Totale_Presidi__c,CQS_ISP_Tot_Max_Pres__c, CQS_ISP_Totale_E_Distribuzione__c, CQS_ISP_Tot_Max_E_Distr__c 
            from OF_CQS_Ispezione__c where CQS_ISP_Progetto__c in (select CQS_junc_progetto__c from Progetto_Utente_junction__c where CQS_junc_user__c=:userinfo.getuserid())];
        return ispezioniList;
    }
   
    public List<OF_CQS_Evento__c> getEventi(){
        eventiList = [select id,name, CQS_Ev_Progetto__c, CQS_Ev_Lettera_D_Ordine__c, OF_CQS_Impresa_Mandataria__c, OF_CQS_Tipo_di_Evento__c, Sottoservizio__c, 
            OF_CQS_Impresa_Esecutrice_Eventi__c, OF_CQS_Stato_Pratica__c, OF_CQS_Data_Evento__c, OF_CQS_Data_Apertura_Pratica__c,
            OF_CQS_Comune_Text__c, Persona_Coinvolta__c, OF_CQS_Eta__c, OF_CQS_Mansione__c, OF_CQS_Anzianita__c, Pratica_INAIL__c, OF_CQS_Indice_Gravita_Infortunio__c, 
            OF_CQS_Giorni_Persi_e__c, OF_CQS_Decesso__c, OF_CQS_Prognosi_Riservata__c, Prognosi__c, OF_CQS_Prognosi_aggiuntiva__c 
            from OF_CQS_Evento__c where CQS_Ev_Progetto__c in (select CQS_junc_progetto__c from Progetto_Utente_junction__c where CQS_junc_user__c=:userinfo.getuserid())];
        return eventiList;
    }
    public List<SelectOption> getComboType(){
        
        cmboType= new List<SelectOption>();
        
        /*
        cmboType.add(new SelectOption('Bad Practice','Bad Practice'));
        cmboType.add(new SelectOption('Danneggiamento a terzi','Danneggiamento a terzi'));
        cmboType.add(new SelectOption('Infortunio','Infortunio'));
        cmboType.add(new SelectOption('Interferenze a sottoservizi','Interferenze a sottoservizi'));
        */
       
        cmboType.add(new SelectOption('Eventi','Eventi'));
        cmboType.add(new SelectOption('Ispezioni','Ispezioni'));
        return  cmboType;
    }
    
    public pagereference displayMethod(){
        if(combotypeout=='Eventi'){
            getEventi();
            setpagination();
            checkEventi=true;
            checkIspezioni=false;
        }
        else if(combotypeout=='Ispezioni'){
            getIspezioni();
            setpaginationI();
            checkIspezioni=true;
            checkEventi=false;
        }
        checkButton=true;
        return null;
    }
    
    public pageReference downloadasExcel(){
        if(combotypeout=='Bad Practice'){
        ////////////    return new PageReference('/apex/PO_BillingReport_Attivazioni');//////
        }
        if(combotypeout=='Danneggiamento a terzi'){
        //////  return new PageReference('/apex/PO_BillingReport_Cessazioni'); ///
        }
        if(combotypeout=='Infortunio'){
        //////    return new PageReference('/apex/PO_BillingReport_CPE');/////
        }
        if(combotypeout=='Interferenze a sottoservizi'){
        //////  return new PageReference('/apex/PO_BillingReport_CPE');/////
        }
        return null;
    }
    
    ///Map Ispezioni
   
    Map<integer,List<OF_CQS_Ispezione__c>> mapRecordsI = new Map<integer,List<OF_CQS_Ispezione__c>>();   
   // Pagenumber  
   public integer intPageNumber{get;set;}  
   // total number of pages  
   public integer intNumberofPages{get;set;}  
   
   
   // returns the data to be displayed on the page  
   public Pagereference setPaginationI() {
      mapRecordsI.clear();  
      integer NumberofRecords = 0;   
      integer pagenumber = 1;  
     // Looping through the records of Opportunity  
        for (OF_CQS_Ispezione__c isp:ispezioniList) {  
            if (NumberofRecords < 20) {  
                if (mapRecordsI.containsKey(pagenumber)){  
                    mapRecordsI.get(pagenumber).add(isp);  
                }  
                else {  
                    List<OF_CQS_Ispezione__c > ispList = new List<OF_CQS_Ispezione__c >();
                    ispList.add(isp);
                    mapRecordsI.put(pagenumber,ispList);  
                }  
                NumberofRecords++;  
            
                if (NumberofRecords == 20) {  
                    NumberofRecords = 0;  
                    pagenumber++;  
                }  
            }
        }  
        intNumberofPages = mapRecordsI.size();  
        intPageNumber = 1;  
         return null;  
    }
    
    
    
    //Map Eventi
    
   Map<integer,List<OF_CQS_Evento__c>> mapRecords = new Map<integer,List<OF_CQS_Evento__c>>();   
   // Pagenumber  
 //  public integer intPageNumber{get;set;}  
   // total number of pages  
  // public integer intNumberofPages{get;set;}  
   // returns the data to be displayed on the page  
   public Pagereference setPagination() {
      mapRecords.clear();  
      integer NumberofRecords = 0;   
      integer pagenumber = 1;  
     // Looping through the records of Opportunity  
        for (OF_CQS_Evento__c e:eventiList) {  
            if (NumberofRecords < 20) {  
                if (mapRecords.containsKey(pagenumber)){  
                    mapRecords.get(pagenumber).add(e);  
                }  
                else {  
                    List<OF_CQS_Evento__c > eList = new List<OF_CQS_Evento__c >();
                    eList.add(e);
                    mapRecords.put(pagenumber,eList);  
                }  
                NumberofRecords++;  
            
                if (NumberofRecords == 20) {  
                    NumberofRecords = 0;  
                    pagenumber++;  
                }  
            }
        }  
        intNumberofPages = mapRecords.size();  
        intPageNumber = 1;  
         return null;  
    }  
   
   public Boolean hasNext {  
     get { 
       if (intNumberofPages <= intPageNumber) {  
         return false;  
       }  
       else {  
         return true;  
       }  
     }  
     set;  
   }  
   
   public Boolean hasPrevious {  
     get { 
       if (intPageNumber == 1) {  
         return false;  
       }  
       else {  
         return true;  
       }  
     }  
     set;  
   }
   
   
   /// ispezioni 
   public List<OF_CQS_Ispezione__c> getIspezioniPagina(){ 
        List<OF_CQS_Ispezione__c> lstwrpI= new List<OF_CQS_Ispezione__c>();  
     if(mapRecordsI.get(intPageNumber)!=null){
     lstwrpI.addAll(mapRecordsI.get(intPageNumber));  
     }
     checkButton=true;
     return lstwrpI;  
   }
   
   
   ///eventi  
   public List<OF_CQS_Evento__c> getEventiPagina(){ 
        List<OF_CQS_Evento__c> lstwrp= new List<OF_CQS_Evento__c>();  
     if(mapRecords.get(intPageNumber)!=null){
     lstwrp.addAll(mapRecords.get(intPageNumber));  
     }
     checkButton=true;
     return lstwrp;  
   }
   
   public void first() {  
      intPageNumber = 1;  
   }  
   public void last() {  
      intPageNumber=intNumberofPages;   
   }   
   
   public void previous() {  
      intPageNumber--;  
   }  
   
    public void next() {  
      this.intPageNumber=intPageNumber+1;  
    }  
    
}
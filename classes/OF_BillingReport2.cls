public class OF_BillingReport2 {
    public Date dat{get;set;}
    public Date dat1{get;set;}
    public string combotypeout{get;set;}
    public string productProvisioningCode {get;set;}
    public string PackageProvisioningCode{get;set;}
    public string promoCode {get;set;}
    //public string pricePlan {get;set;}
    //public Date ActionDate{get;set;}
    private integer count=1;   //to track the function calling
    private integer counter=0;   //to keep track of offset
    private integer list_size=10; //to set the page size to show the rows/records
    public integer total_size; //used to show user the total size of the list   
    List<Catalogo_Billing__c> Tlist = new list<Catalogo_Billing__c>();
    public list<order> Olist {get;set;}
    list<pricebookEntry> Plist = new list<pricebookEntry>();
    public list<wrapperReport> vlstwrap{get;set;}
    public string Custid {get;set;}
    
  
    
    public OF_BillingReport2()
    {
      vlstwrap=new list<wrapperReport>();
    combotypeout='';
    productProvisioningCode='';
    promoCode='';
    PackageProvisioningCode='';
  
   // actionDate=null;
    //pricePlan='';
    }
    
    
    public  list<wrapperReport> getvlstWrapper(){   
        vlstwrap.clear();
        List<Order> oList=new List<Order>();
    if(combotypeout=='Attivazioni'){
      oList=[select Id, OrderNumber,OF_Comune__c,AccountId,Account.Name,OF_Type__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IdentificativoDelPOP__c,OF_IDRisorsa__c,OF_CodiceProgettoSpeciale__c,OF_ProgettoSpeciale__c,
          (select Id,pricebook2.Name,OF_Data_Attivazione__c,OF_DataAttivazione2__c ,OF_Order__c,product2.OF_BillingElement__c,product2.OF_Servizio__c,product2.OF_BillingElement__r.Name
          from Price_Book_Entries__r where product2.OF_BillingElement__r.Name = 'Canone' OR product2.OF_BillingElement__r.Name = 'Canone Premium' )
          from order where AccountId != null and OF_Comune__c != null AND OF_Type__c='INORDER' AND id in 
          (select OF_Order__c from pricebookentry where OF_DataAttivazione2__c >=:Dat AND OF_DataAttivazione2__c <=:Dat1 
          AND (product2.OF_BillingElement__r.Name = 'Canone' OR product2.OF_BillingElement__r.Name = 'Canone Premium')
          AND (product2.OF_Servizio__c = 'GPON Passiva' OR product2.OF_Servizio__c = 'Open Stream'))];
    }
    if(combotypeout=='Cessazioni'){
      oList=[select Id, OrderNumber,OF_Comune__c,AccountId,Account.Name,OF_Type__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IdentificativoDelPOP__c,OF_IDRisorsa__c,OF_CodiceProgettoSpeciale__c,OF_ProgettoSpeciale__c,
          (select Id,pricebook2.Name,OF_Data_Attivazione__c,OF_DataAttivazione2__c ,OF_Order__c,product2.OF_BillingElement__c,product2.OF_Servizio__c,product2.OF_BillingElement__r.Name
          from Price_Book_Entries__r where product2.OF_BillingElement__r.Name = 'Contributo Disattivazione')
          from order where AccountId != null and OF_Comune__c != null AND OF_Type__c='OUTORDER' AND id in 
          (select OF_Order__c from pricebookentry where OF_DataAttivazione2__c >=:Dat AND OF_DataAttivazione2__c <=:Dat1 
          AND product2.OF_BillingElement__r.Name = 'Contributo Disattivazione'
          AND (product2.OF_Servizio__c = 'GPON Passiva' OR product2.OF_Servizio__c = 'Open Stream'))];
    }
    if(combotypeout=='CPE'){
      oList=[select Id, OrderNumber,OF_Comune__c,AccountId,Account.Name,OF_Type__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,OF_IdentificativoDelPOP__c,OF_IDRisorsa__c,OF_CodiceProgettoSpeciale__c,OF_ProgettoSpeciale__c,
          (select Id,pricebook2.Name,OF_Data_Attivazione__c,OF_DataAttivazione2__c ,OF_Order__c,product2.OF_BillingElement__c,product2.OF_Servizio__c,product2.OF_BillingElement__r.Name
          from Price_Book_Entries__r where product2.OF_BillingElement__r.Name = 'Contributo Istallazione' OR product2.OF_BillingElement__r.Name = 'Contributo Ribaltamento impianto')
          from order where AccountId != null and OF_Comune__c != null AND OF_Type__c='INORDER' AND id in 
          (select OF_Order__c from pricebookentry where OF_DataAttivazione2__c >=:Dat AND OF_DataAttivazione2__c <=:Dat1 
          AND (product2.OF_BillingElement__r.Name = 'Contributo Istallazione' OR product2.OF_BillingElement__r.Name = 'Contributo Ribaltamento impianto')
          AND (product2.OF_Servizio__c = 'GPON Passiva' OR product2.OF_Servizio__c = 'Open Stream'))];
    }
    system.debug('@@@@@@@@@@@@@@@ '+oList.size());
        set<wrapperReport> setwrapper = new set<wrapperReport>();
        Map<String, Catalogo_Billing__c> catalogoMapAttivo = new Map<String, Catalogo_Billing__c>();
        Map<String, Catalogo_Billing__c> catalogoMapPassivo = new Map<String, Catalogo_Billing__c>();
        for(Catalogo_Billing__c et : [select Id,OF_Account__c,EOF_Comune__c,EOF_Customer_ID__c,Customer_Name__c,Wholesaler__c,Product_Name__c,Product_ID__c,Billing_interval_type__c,PricePlan_ID__c from Catalogo_Billing__c]){
          catalogoMapAttivo.put(et.OF_Account__c+et.EOF_Comune__c+et.Product_Name__c,et);
          if(et.Billing_interval_type__c=='Monthly'){
            CatalogoMapPassivo.put(et.OF_Account__c+et.EOF_Comune__c,et);
          }
        }
        Integer i=0; 
        TEMPLOG__c   t = new TEMPLOG__c  ();
        String s='Prima: '+Limits.getCpuTime();
        for (order ore : oList){
          i++;
      for(pricebookentry pbe : ore.Price_Book_Entries__r){
        system.debug('@@@@@@@ quantità: '+i);
        Catalogo_Billing__c et;
        string datetimestr = pbe.OF_DataAttivazione2__c.format('YYYY-MM-DD');
        if(combotypeout=='Attivazioni'){
          system.debug('@@@@@@@@@@@@@@@ Attivazione');
          if(pbe.product2.OF_Servizio__c == 'GPON Passiva'){
                    PackageProvisioningCode='2';
                    productProvisioningCode ='4';
                    promoCode=ore.OF_CodiceProgettoSpeciale__c;
                    et=catalogoMapPassivo.get(ore.accountId+ore.OF_Comune__c);
                  }
                  else if(pbe.product2.OF_Servizio__c == 'Open Stream'){
                    system.debug('@@@@@@@@@@ catalogoMapAttivo: '+catalogoMapAttivo.keyset());
                    system.debug('@@@@@@@@@@ stringToCompare: '+ore.accountId+ore.OF_Comune__c+pbe.pricebook2.Name);
                    et=catalogoMapAttivo.get(ore.accountId+ore.OF_Comune__c+pbe.pricebook2.Name);
                    if(et!=null){
                      PackageProvisioningCode=et.Product_ID__c;
                    }
                    promoCode=ore.OF_ProgettoSpeciale__c;
                    productProvisioningCode='58';
                  }
                  if(et!=null){
                    setwrapper.add(new wrapperReport(et,ore,pbe,productProvisioningCode,promoCode,PackageProvisioningCode,datetimestr));
                  }
        }
        if(combotypeout=='Cessazioni'){
          et=catalogoMapPassivo.get(ore.accountId+ore.OF_Comune__c);
          if(pbe.product2.OF_Servizio__c == 'GPON Passiva'){
                      productProvisioningCode ='6';
                    }
                    else if(pbe.product2.OF_Servizio__c == 'Open Stream'){
                      productProvisioningCode='59';
                    }
                    if(et!=null){
                    setwrapper.add(new wrapperReport(et,ore,pbe,productProvisioningCode,promocode,PackageProvisioningCode,datetimestr ));
                  }
                    
        }
        if(combotypeout=='CPE'){
          et=catalogoMapPassivo.get(ore.accountId+ore.OF_Comune__c);
          if(pbe.product2.OF_BillingElement__r.Name == 'Contributo Istallazione'){
                      productProvisioningCode ='9';
                    }
                    else if(pbe.product2.OF_BillingElement__r.Name == 'Contributo Ribaltamento impianto'){
                      productProvisioningCode='10';
                    }
                    if(et!=null){
                    setwrapper.add(new wrapperReport(et,ore,pbe,productProvisioningCode,promocode,PackageProvisioningCode,datetimestr ));
                    }
        }
      }
    }
      vlstwrap.addAll(setwrapper);
      s=s+' dopo: '+Limits.getCpuTime();
      t.name=s;
      if(i>0){
      insert t;
      }
        return vlstwrap;
        
    }
    
    public List<SelectOption> cmbotype{get;set;}

     public List<SelectOption> getComboType()
    {
        cmboType= new List<SelectOption>();
        cmboType.add(new SelectOption('','--None--'));
        cmboType.add(new SelectOption('Attivazioni','Attivazioni'));
        cmboType.add(new SelectOption('Cessazioni','Cessazioni'));
        cmboType.add(new SelectOption('CPE','CPE'));
       
        return  cmboType;
    }

    public void displayMethod()
    {
    vlstwrap.clear();
    getvlstWrapper();
    setPagination();
    }
    public pageReference downloadasExcel()
    {
    if(combotypeout=='Attivazioni'){
    return new PageReference('/apex/PO_BillingReport_Attivazioni');
    }
    if(combotypeout=='Cessazioni'){
    return new PageReference('/apex/PO_BillingReport_Cessazioni');
    }
    if(combotypeout=='CPE'){
    return new PageReference('/apex/PO_BillingReport_CPE');
    }
    return null;
    }
    
     Map<integer,List<wrapperReport>> mapRecords = new Map<integer,List<wrapperReport>>();   
   // Pagenumber  
   public integer intPageNumber{get;set;}  
   // total number of pages  
   public integer intNumberofPages{get;set;}  
   // returns the data to be displayed on the page  
   public List<wrapperReport> getLstwrapRecords(){ 
        List<wrapperReport> lstwrp= new List<wrapperReport>();  
     if(mapRecords.get(intPageNumber)!=null){
     lstwrp.addAll(mapRecords.get(intPageNumber));  
     }
     return lstwrp;  
   }  
      public Pagereference setPagination() {
      mapRecords.clear();  
     integer NumberofRecords = 0;  
     integer pagenumber = 1;  
     // Looping through the records of Opportunity  
     for (wrapperReport vls:vlstwrap) {  
       if (NumberofRecords < 10) {  
         if (mapRecords.containsKey(pagenumber)){  
           mapRecords.get(pagenumber).add(new wrapperReport(vls.eoftest,vls.order,vls.pbentry,vls.prodprovCode,vls.promoCode,vls.PackageProvisioningCode,vls.actionDate));  
         }  
         else {  
           mapRecords.put(pagenumber,new List<wrapperReport >{new wrapperReport (vls.eoftest,vls.order,vls.pbentry,vls.prodprovCode,vls.promoCode,vls.PackageProvisioningCode,vls.actionDate)});  
         }  
         NumberofRecords++;  
         if (NumberofRecords == 10) {  
           NumberofRecords = 0;  
           pagenumber++;  
         }  
       }  
     }  
     intNumberofPages = mapRecords.size();  
     intPageNumber = 1;  
     getLstwrapRecords();  
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
   public void first() {  
      intPageNumber = 1;  
      getLstwrapRecords();  
   }  
   public void last() {  
      intPageNumber=intNumberofPages;   
      getLstwrapRecords();  
   }   
   public void previous() {  
      intPageNumber--;  
      getLstwrapRecords();  
   }  
    public void next() {  
      this.intPageNumber=intPageNumber+1;  
      getLstwrapRecords();  
    }  
    
    
    
    
    
    
    public  class wrapperReport
    {
        public Catalogo_Billing__c eoftest {get;set;}
        public order order {get;set;}
        public pricebookEntry pbentry {get;set;}
        public String prodprovCode{get;set;}
        public String promoCode{get;set;}
        public string PackageProvisioningCode{get;set;}
        public String actionDate{get;set;}
        public wrapperReport(Catalogo_Billing__c eoftest,order order,pricebookEntry pbentry,String prodprovCode,String promoCode,String PackageProvisioningCode,String ActionDate )
        {
            this.eoftest = eoftest;
            this.order = order;
            this.pbentry = pbentry;
            this.prodprovCode=prodprovCode;
            this.promoCode=promoCode;
            this.PackageProvisioningCode=PackageProvisioningCode;
            this.actionDate=actionDate;
        }
    } 
   
   /* 
    public void codeCoverage(){
      Integer i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      i=0;
      
    }*/
}
public class PO_Serv_BTS_InsertNewReq_Ctrl {
  public List<SelectOption> requestOptions{get;set;}
  public String accountname{get;set;}
  public User usr{get;set;}
  public String offertaBTS{get;set;}
  public String Nome{get;set;}
  public String requestSelected{get;set;}
  public string retUrl;
  Map<String,Id> rtMap{get;set;}
  
  
  //EC Start 2018 - 11 - 10
  
   public EOF_EAI_Service_Log__c  bhLogParent {get;set;} //EC 2018 - 11 - 10 BTS padre
  public EOF_EAI_Service_Log__c  bhLogColl {get;set;} //EC 2018 - 11 - 10 BTS collegamento
  public EOF_EAI_Service_Log__c  bhLogOrdine {get;set;} //EC 2018 - 11 - 10 BTS padre
    public List<EOF_EAI_Service_Log__c>  bhLogFattList {get;set;} //EC 2018 - 11 - 10 Lista delle richieste di fattibilità
    //public List<EOF_EAI_Service_Log__c>  bhLogCollList {get;set;} //EC 2018 - 11 - 10 Lista delle richieste di fattibilità
  //public List<EOF_EAI_Service_Log__c>  bhLogOrdList {get;set;} //EC 2018 - 11 - 10 Lista delle richieste di fattibilità  
   public Boolean btsOfferta{get;set;}
  //EC End 2018 - 11 - 10
  
  

  public PO_Serv_BTS_InsertNewReq_Ctrl() {
    retUrl=ApexPages.currentPage().getUrl();
    
    btsOfferta=(apexpages.currentpage().getparameters().get('off')=='BTS')?true:false;
    //Setto la tipologia di offert
   // offertaBTS = 'BTS';
    offertaBTS=(apexpages.currentpage().getparameters().get('off'));
    system.debug('@@@@@@@@@@EC offerta passata nella URL è ' + offertaBTS);
     
    //Recupero l'utente loggato
    usr = [SELECT Id, Contact.Account.Name, Account.EOF_Codice_Operatore__c
         FROM User
         WHERE Id = :UserInfo.getUserId()];
         
    //Popolo il campo Azienda
    accountname=usr.Contact.Account.Name;
    //Popolo la lista della dropdown
    requestOptions= new List<SelectOption>();
    requestOptions.add(new SelectOption('ATT','Ordine di Attivazione'));
    requestOptions.add(new SelectOption('CESS','Ordine di Cessazione'));

    List<recordtype> rtList=[select Id,developerName from recordtype]; 
        rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        } 
  }
  //Funzione eseguita al click di Annulla
  public PageReference DeleteParentCase(){
    return new PageReference('/PO_Index');
  }
  
  
   public Pagereference toBTS(){
   
   Pagereference pr = New PageReference('/PO_Serv_BTS_EditLogInfo');  
     
   bhLogParent = new EOF_EAI_Service_Log__c();
   bhLogParent.RecordTypeId=rtMap.get('PO_Log_BTS_Request');
   bhLogParent.PO_Nome_Progetto__c=Nome;
   bhLogParent.PO_Offerta__c = offertaBTS;
   bhLogParent.EOF_Stato_Richiesta__c='Bozza';
   bhLogParent.EOF_STATO_ORDINE__c ='Bozza';// mi pare non si debba valorizzare.
   bhLogParent.EOF_Codice_Operatore__c=usr.Account.EOF_Codice_Operatore__c;
   insert bhLogParent;
   //EC 2018 - 11 - 11 Start modifica del codice ordine olo 
   bhLogParent.EOF_Codice_Ordine_OLO__c= [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id = :bhLogParent.Id].Name.replace('LOG-',bhLogParent.EOF_Codice_Operatore__c+'_');
   update bhLogParent;
   //EC 2018 - 11 - 11 end modifica del codice ordine olo 
    pr.getParameters().put('parentId', bhLogParent.id);
  pr.getParameters().put('off', bhLogParent.PO_Offerta__c);
    pr.getParameters().put('Mode','insert');
    pr.setRedirect(true);
    return pr;
     
   }
   
    public pagereference uploadCSV()
    {
        /*
        testcase.PO_Nome_Progetto__c = Nome;
        update testcase;

        try
        {
            parentCaseObj = [select id,PO_Numero_Anni__c,PO_Note_Modifica_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Offerta__c,casenumber,status,CreatedDate,PO_Durata_Affitto__c,OwnerId from case where id=:testcase.id];
            parentCaseObj.PO_Nome_Progetto__c = Nome;
            update parentCaseObj;
            Nome = '';
        }
        catch(exception e)
        {
            system.debug('error message====='+e.getStackTraceString());
        }
        return new pagereference ('/apex/po_Uploadcsv?id'+parentCaseObj.id);
        */
                
        bhLogParent = new EOF_EAI_Service_Log__c();
        bhLogParent.RecordTypeId=rtMap.get('PO_Log_BTS_Request');
        bhLogParent.PO_Nome_Progetto__c=Nome;
        bhLogParent.PO_Offerta__c = offertaBTS;
        bhLogParent.EOF_Stato_Richiesta__c='Bozza';
        bhLogParent.EOF_STATO_ORDINE__c ='Bozza';// mi pare non si debba valorizzare.
        bhLogParent.EOF_Codice_Operatore__c=usr.Account.EOF_Codice_Operatore__c;
        insert bhLogParent;
        
        bhLogParent.EOF_Codice_Ordine_OLO__c= [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id = :bhLogParent.Id].Name.replace('LOG-',bhLogParent.EOF_Codice_Operatore__c+'_');
        update bhLogParent;
        
        //return new pagereference ('/apex/po_Uploadcsv?id'+bhLogParent.id);
        return new pagereference ('/apex/PO_Serv_BTS_UploadCSV?id='+bhLogParent.id);
    }
   
   
  
  /*EC commento 2018 - 11 - 10
  //Funzione eseguita al click di Inserisci richiesta
  public Pagereference toBTS(){
      
       system.debug('$$fiba1');
      
      PageReference pageRef = new PageReference('');
      system.debug('$$fiba12');
      
       /*
       if(requestSelected=='ATT')
       {
       */
  /*EC commento
           //ATTIVAZIONE
       //Inserisco il log della bozza
       system.debug('$$fiba13');
      EOF_EAI_Service_Log__c parentLog = new EOF_EAI_Service_Log__c();  
       system.debug('$$fiba14');
           
        system.debug('$$rtMap ' + rtMap);
           
        parentLog.RecordTypeId=rtMap.get('PO_Log_BTS_Request');
        parentLog.PO_SA_Data_Inserimento_Ordine__c = datetime.now();
        parentLog.EOF_Data_Notifica__c = datetime.now();
        parentLog.EOF_Tipo_Comunicazione_String__c = 'Ordine di Attivazione';
        parentLog.EOF_Stato_Richiesta__c='Bozza Portale';
        parentLog.EOF_STATO_ORDINE__c ='Bozza Portale';
        parentLog.EOF_Codice_Operatore__c=usr.Account.EOF_Codice_Operatore__c;
        parentLog.PO_Nome_Progetto__c=Nome;
        parentLog.PO_Offerta__c = 'BTS';
      //Faccio insert e subito dopo update, perchè al posto di LOG - inserisco il codice operatore OLO(Necessario?)
      
      system.debug('$$fiba2');
           
      insert parentLog;
           
      system.debug('$$fiba3');     
           
      parentLog.EOF_Codice_Ordine_OLO__c= [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id = :parentLog.Id].Name.replace('LOG-',parentLog.EOF_Codice_Operatore__c+'_');
      update parentLog;
      //Aggiungo l'id alla pagina
      
      system.debug('$$parentLog.Id ' + parentLog.Id);
      system.debug('$$retUrl ' + retUrl);
      
      pageRef = new PageReference('/PO_Serv_BTS_EditLogInfo');  
        pageRef.getParameters().put('parentId', parentLog.Id);
        pageref.getParameters().put('P2PattAttivazione','P2PattAttivazione');
        pageref.getParameters().put('retUrl',retUrl);
      
      /*
       }
      else if(requestSelected=='CESS') 
      {// CESSAZIONE
        pageRef = new PageReference('/PO_P2PAttiva_InserimentoIdRisorsa');
      }
      */
  /*EC commento    
    pageref.getParameters().put('Nome',Nome);
    pageRef.setRedirect(true);
      return pageref;
    }
    */
}
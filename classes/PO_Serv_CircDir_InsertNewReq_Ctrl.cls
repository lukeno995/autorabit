public class PO_Serv_CircDir_InsertNewReq_Ctrl {
  public List<SelectOption> requestOptions{get;set;}
  public String accountname{get;set;}
  public User usr{get;set;}
  public String offertaDarkFiber{get;set;}
  public String Nome{get;set;}
  public String requestSelected{get;set;}
  public string retUrl;
  Map<String,Id> rtMap{get;set;}

   public EOF_EAI_Service_Log__c  bhLogParent {get;set;}
  public EOF_EAI_Service_Log__c  bhLogColl {get;set;}
  public EOF_EAI_Service_Log__c  bhLogOrdine {get;set;}
    public List<EOF_EAI_Service_Log__c>  bhLogFattList {get;set;}
  
  

  public PO_Serv_CircDir_InsertNewReq_Ctrl() {
    retUrl=ApexPages.currentPage().getUrl();

    offertaDarkFiber=(apexpages.currentpage().getparameters().get('off'));
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
  
  
   public Pagereference toDarkFiber(){
   
   Pagereference pr = New PageReference('/PO_Serv_Circuiti_Diretti_EditLogInfo');  
     
   bhLogParent = new EOF_EAI_Service_Log__c();
   bhLogParent.RecordTypeId=rtMap.get('PO_Log_CircuitiDiretti_Request');
   bhLogParent.PO_Nome_Progetto__c=Nome;
   bhLogParent.PO_Offerta__c = offertaDarkFiber;
   bhLogParent.EOF_Stato_Richiesta__c='Bozza';
   bhLogParent.EOF_STATO_ORDINE__c ='Bozza';
   bhLogParent.EOF_Codice_Operatore__c=usr.Account.EOF_Codice_Operatore__c;
   insert bhLogParent;
   bhLogParent.EOF_Codice_Ordine_OLO__c= [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id = :bhLogParent.Id].Name.replace('LOG-',bhLogParent.EOF_Codice_Operatore__c+'_');
   update bhLogParent;
    pr.getParameters().put('parentId', bhLogParent.id);
  pr.getParameters().put('off', bhLogParent.PO_Offerta__c);
    pr.getParameters().put('Mode','insert');
    pr.setRedirect(true);
    return pr;
     
   }
   
    public pagereference uploadCSV()
    { 
        bhLogParent = new EOF_EAI_Service_Log__c();
        bhLogParent.RecordTypeId=rtMap.get('PO_Log_CircuitiDiretti_Request');
        bhLogParent.PO_Nome_Progetto__c=Nome;
        bhLogParent.PO_Offerta__c = offertaDarkFiber;
        bhLogParent.EOF_Stato_Richiesta__c='Bozza';
        bhLogParent.EOF_STATO_ORDINE__c ='Bozza';
        bhLogParent.EOF_Codice_Operatore__c=usr.Account.EOF_Codice_Operatore__c;
        insert bhLogParent;
        
        bhLogParent.EOF_Codice_Ordine_OLO__c= [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id = :bhLogParent.Id].Name.replace('LOG-',bhLogParent.EOF_Codice_Operatore__c+'_');
        update bhLogParent;

        return new pagereference ('/apex/PO_Serv_Circuiti_Diretti_UploadCSV?id='+bhLogParent.id);
    }
}
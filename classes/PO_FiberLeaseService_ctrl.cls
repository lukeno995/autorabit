public without sharing class PO_FiberLeaseService_ctrl {
    
    /**** PO_FiberLeaseIncRich ****/
    public String accountId {get; set;}
    public String childId {get; set;}
    public Id parentId {get; set;} 
    public Account acct {get; set;}
    public String Nome{get;set;}
    public String recordOfferta {get;set;}
    public EOF_EAI_Service_Log__c parentLog {get;set;}
    public recordtype rt {get; set;}
    /**** /PO_FiberLeaseIncRich ****/
    
    /**** PO_FiberLeaseInsColl ****/
    //public Case ChildCase {get;set;} //questo sarà sostituito da childLog
    public EOF_EAI_Service_Log__c childLog {get;set;}
    public String selectedIdComune {get; set;}
    public String selectedIdComune1 {get; set;}
    public String searchTerm {get; set;}
    public String searchTerm1 {get; set;}
    public string fileName{get;set;}
    public transient Blob fileBody{get;set;}
    public Boolean attachmentExists{get;set;}
    public List<Attachment> childAttachList {get;set;}
    public List<Attachment> suppChildListAttach {get; set;}
    public OF_CaseLogAttach__c caseLogAttach {get; set;}
    /**** /PO_FiberLeaseInsColl ****/

    /**** PO_FiberLeaseDettRichFatt ****/
    public list<attachment> attlst {get;set;}  //servono per visualizzare le liste di allegati
    public list<attachment> newAtt {get;set;}
    public list<attachment> attxlxs {get;set;}

    /**** /PO_FiberLeaseDettRichFatt ****/
    
    public PO_FiberLeaseService_ctrl(ApexPages.StandardController controller){
        accountId = ApexPages.currentPage().getParameters().get('accountId');
        childId = ApexPages.currentPage().getParameters().get('childId');
        parentId = ApexPages.currentPage().getParameters().get('parentId');
    }

    public PO_FiberLeaseService_ctrl(){
        accountId = ApexPages.currentPage().getParameters().get('accountId');
        childId = ApexPages.currentPage().getParameters().get('childId');
        parentId = ApexPages.currentPage().getParameters().get('parentId');
    }
    
    public void doInitInsRich(){
        Nome = '';
        
        acct = [SELECT Id, Name, EOF_Codice_Operatore__c FROM Account WHERE Id = :accountId LIMIT 1];

        rt = [SELECT id FROM recordtype 
                         WHERE sobjectType ='EOF_EAI_Service_Log__c' 
                         AND developername='PO_Log_FiberLease_Request' LIMIT 1];

        parentLog = new EOF_EAI_Service_Log__c();
        parentLog.RecordTypeId = rt.id;
        parentLog.PO_Offerta__c = 'Fiber Lease';
        parentLog.EOF_Stato_Richiesta__c = 'Bozza';
        parentLog.EOF_STATO_ORDINE__c ='Bozza';
        parentLog.EOF_Codice_Operatore__c = acct.EOF_Codice_Operatore__c;
    }
    
    public void doInitInsColl(){
        //ChildCase = new Case();
        
        /*** Se viene passato l'Id del log di collegamento, vado in query perché sto modificando un child in bozza. 
             Altrimenti creo un nuovo childLog di collegamento da inserire. ***/
        parentLog = [SELECT Id, EOF_Codice_Operatore__c, PO_Nome_Progetto__c FROM EOF_EAI_Service_Log__c WHERE Id = :parentId LIMIT 1];

        if(String.isBlank(childId)){

            

            childLog = new EOF_EAI_Service_Log__c();
            childLog.RecordTypeId = [SELECT Id FROM RecordType 
                                     WHERE DeveloperName = 'PO_Log_FiberLease_Collegamento' LIMIT 1].Id;
            childLog.EOF_SL_Riferimento__c = parentId;
            
            childLog.EOF_Codice_Operatore__c = parentLog.EOF_Codice_Operatore__c;
            childLog.PO_Offerta__c = 'Fiber Lease';
            childLog.PO_Nome_Progetto__c = parentLog.PO_Nome_Progetto__c;

            childAttachList = new List<Attachment>();
            caseLogAttach = new OF_CaseLogAttach__c();
            insert caseLogAttach;
            attachmentExists = false;

        }else{
            childLog = [SELECT Id, EOF_Stato_Richiesta__c, EOF_SITO__c, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore__c, PO_Offerta__c, PO_Nome_Progetto__c,
                               EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c, PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, 
                               PO_Tipo_percorso__c, PO_Numero_fibre_richieste__c, PO_Sito__c, Particella_Toponomastica_1__c, PO_Indirizzo_collegamento__c,
                               PO_Civico__c, PO_Nota_sito_1__c, PO_Sito_3__c, Particella_Toponomastica_2__c, PO_indirizzo_collegamento_3__c, PO_Civico_3__c,
                               PO_Nota_sito_2__c, PO_Log_Comune_2__c, PO_Log_Comune_3__c, CreatedDate, EOF_INDIRIZZO__c, EOF_NUMERO_CIVICO__c, EOF_Comune__c
                        FROM EOF_EAI_Service_Log__c WHERE Id = :childId LIMIT 1];

            caseLogAttach = [SELECT Id, Case__c, EAI_Service_Log__c 
                                                      FROM OF_CaseLogAttach__c WHERE EAI_Service_Log__c =:childId LIMIT 1];

            

            childAttachList = [SELECT id,Name,parentId, body, Description, OwnerId, 
                                createdDate,BodyLength,ContentType, createdById, LastModifiedDate,
                                LastModifiedById FROM Attachment WHERE parentId=:caseLogAttach.Id];

            attachmentExists = !childAttachList.isEmpty();
        }

        suppChildListAttach = new List<Attachment>();
    }

    public PageReference deletechildLog(){
    
    /*EOF_EAI_Service_Log__c cLogTodelete =[SELECT Id, EOF_SL_Riferimento__c, EOF_Codice_Ordine_OLO__c,PO_Nome_Progetto__c,EOF_Codice_Operatore__c,PO_Offerta__c  
                                          FROM EOF_EAI_Service_Log__c 
                                          WHERE id=:childId LIMIT 1];
    String plId=cLogTodelete.EOF_SL_Riferimento__c;*/
   
    
    //delete cLogTodelete;
    delete childLog;
    delete caseLogAttach;
    
    PageReference pg = new PageReference('/PO_Serv_FiberLease_Riepilogo');
        pg.getParameters().put('parentId', parentLog.id);
        return pg;
    
   
    }
     
    public Pagereference SaveParentChildCaseInfo(){

        suppMethod();

        if(String.isBlank(childId)){

            childLog.EOF_Stato_Richiesta__c = 'Bozza';
            childLog.EOF_STATO_ORDINE__c = 'Bozza';

            insert childLog;
            caseLogAttach.EAI_Service_Log__c = childLog.Id;
            update caseLogAttach;

            /*Double rnd = Math.random() * 1000;
            String randomValue = String.valueOf(Math.roundToLong(rnd));*/

            childLog.EOF_Codice_Ordine_OLO__c= [SELECT Name 
                                                FROM EOF_EAI_Service_Log__c 
                                                WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');

            //childLog.EOF_Codice_Ordine_OLO__c += '_'+randomValue;

            update childLog;

        }else{
            update childLog;
            update caseLogAttach;
        }

        
        
        
        

        

        System.debug(childLog);

            
        
        
        return new pagereference ('/apex/PO_Serv_FiberLease_Riepilogo?parentId='+parentLog.id);
    }
    
    public void upload() {
        suppMethod();
        Attachment childAtt = new Attachment();
        try {
            //Check sulla dimensione del file
            if(fileBody == null){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Select a file'));
                //return null; 
            }else if(fileBody.size()>6291500){
                fileBody = null;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'File size must be <= 6MB'));
                //return null;
            }else{//Se la dimensione è <= 6MB procedo
                childAtt = new attachment();
                childAtt.OwnerId = UserInfo.getUserId();
                childAtt.ParentId = caseLogAttach.Id;
                childAtt.IsPrivate = false;
                childAtt.name = fileName;
                childAtt.body = fileBody;
                fileBody = null;
                attachmentExists = true;
                childAttachList.add(childAtt);
                suppChildListAttach.add(childAtt); //necessario per bozza
                insert childAtt;
                
                
            }
        }catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            //return null;
        } 
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
       
        //giovanni 19112018 inizio   
        //return null;
        /*PageReference pg = new PageReference('/PO_FiberLeaseInsColl');
        pg.getParameters().put('parentId', parentId);
        pg.getParameters().put('childId', childId); */
        

    }

    public void suppMethod(){
        if(String.isNotBlank(selectedIdComune)){
            OF_ElencoComuniItaliani__c ag = [SELECT Id,OF_Regione__c,OF_Comune__c 
                                            FROM OF_ElencoComuniItaliani__c WHERE id =: selectedIdComune LIMIT 1];

            childLog.EOF_Comune__c = ag.OF_Comune__c; //+' '+ag.OF_Regione__c;
            childLog.OF_Id_Comune__c = selectedIdComune;
        }

        if(String.isNotBlank(selectedIdComune1)){
            OF_ElencoComuniItaliani__c ag1 = [SELECT Id,OF_Regione__c,OF_Comune__c 
                                            FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune1 LIMIT 1];

            childLog.PO_Log_Comune_2__c = ag1.OF_Comune__c; //+' '+ag1.OF_Regione__c;
            childLog.PO_Log_IdComune2__c = selectedIdComune1;
        }
    }
    
    public pagereference uploadCSV(){

        parentLog.PO_Nome_Progetto__c=Nome;
        insert parentLog;
        
        parentLog.EOF_Codice_Ordine_OLO__c= [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id = :parentLog.Id].Name.replace('LOG-',parentLog.EOF_Codice_Operatore__c+'_');
        update parentLog;
        
        return new pagereference ('/apex/PO_Serv_FiberLease_UploadCSV?id='+parentLog.id);
    }

    public pagereference childCase(){
        
        parentLog.PO_Nome_Progetto__c=Nome;                 
        insert parentLog;
        
        /*Double rnd = Math.random() * 1000;
        String randomValue = String.valueOf(Math.roundToLong(rnd)); */


        parentLog.EOF_Codice_Ordine_OLO__c= [SELECT Name 
                                             FROM EOF_EAI_Service_Log__c 
                                             WHERE Id = :parentLog.Id].Name.replace('LOG-',parentLog.EOF_Codice_Operatore__c+'_');

        //parentLog.EOF_Codice_Ordine_OLO__c += '_'+randomValue;

        update parentlog;
        
        pagereference pr = new pagereference('/PO_FiberLeaseInsColl');
              pr.getParameters().put('parentid',parentLog.id);
        
        return pr;
        
    }
    
	public pagereference annullaInsRich()
    {
        
        return new pagereference('/apex/po_index');
    }
    
    public PageReference annullaInsColl(){
        if(childId == null){
            delete caseLogAttach;
        }else{
            delete suppChildListAttach;
        }


        return new pagereference ('/apex/PO_Serv_FiberLease_Riepilogo?parentId='+parentLog.id);

    }

    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c> searchComune(String termineRic) {
        
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = 
            Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + 
                            String.escapeSingleQuotes(termineRic) + '%\'  order by OF_Comune__c ASC ' );
       
        return AreaGeograficaJunction;

    }

}
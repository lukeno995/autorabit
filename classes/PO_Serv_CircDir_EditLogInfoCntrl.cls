public without sharing class PO_Serv_CircDir_EditLogInfoCntrl {
    public String recordOfferta {get;set;}
    public EOF_EAI_Service_Log__c childLog {get;set;}
    public EOF_EAI_Service_Log__c parentLog {get;set;}
    public List<EOF_EAI_Service_Log__c>  childLogToInsert {get;set;} 
    public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
    public String searchTerm1 {get; set;}
    public String selectedIdComune1 {get; set;}
    public String searchTerm2 {get; set;}
    public String selectedIdComune2 {get; set;}
    public OF_ElencoComuniItaliani__c OF_ElencoComuniItalianiobj{get;set;}
    public OF_ElencoComuniItaliani__c OF_ElencoComuniItalianiobj1{get;set;}
    public OF_ElencoComuniItaliani__c OF_ElencoComuniItalianiobj2{get;set;}
    public boolean editMode{get;set;}
    public boolean insertMode{get;set;}
    public String urlPage {get; set;}
    public String NomeProgetto{get;set;}
    public List<SelectOption> opt{get; set;}
    public String optScelta{get; set;}
    public Map<String,Id> rtMap {get;set;}
    public string fileName{get;set;}
    public blob filebody{get;set;}
    public Boolean attachmentExists{get;set;}    
    public List<EOF_EAI_Service_Log__c> listNephewVLAN{get;set;}
    public Boolean showVLAN{get;set;}
    public String idVLAN  {get;set;}
    public string verifyProfilo{get;set;} //EC PROFILO AS OS 2018 - 08 - 08
    public boolean viewError{get;set;}//EC PROFILO AS OS 2018 - 08 - 08
    public boolean viewProfilo{get;set;}//EC PROFILO AS OS 2018 - 08 - 08
    public string profiloCommerciale{get;set;}//EC PROFILO AS OS 2018 - 08 - 08
    public boolean vLanNoMax {get;set;}
    Map<String,String> ListinoCosMap {get;set;}
    public String profiloName{get;set;}
    public string retUrl;
    public list<attachment> attlst {get;set;}
    public list<attachment> newAtt {get;set;}
    public list<attachment> attxlxs {get;set;}
    public Case parentCase { get; set;}
    public Case parentCaseObj {get;set;}
    public boolean checkModeEdit{get;set;}
    public boolean checkModeEdit2{get;set;}
    public boolean childLogEsistente{get;set;}
    public boolean showAllegati{get;set;} //EC 2018 - 11 - 17
    public List<attachment> childcasedisplayattlist{get;set;} //EC 2018 - 11 - 17
    
    public PO_Serv_CircDir_EditLogInfoCntrl (){
        retUrl=ApexPages.currentPage().getUrl();
        //Setto a false di default la visaulzizazione vlan
        showVLAN = false;
        checkModeEdit=false;
        checkModeEdit2=false;
        childLogEsistente=false;
        showAllegati=false;
        //Valorizzo la picklist di tipo collegamento - ASAP spostare in un metodo
        opt= new List<SelectOption>();
        opt.add(new SelectOption('Point-to-Point','Point-to-Point'));  
        //Fine valorizzazione
        //editMode=false;
        editMode=(apexpages.currentpage().getparameters().get('Mode')=='edit')?true:false;//EC 2018 - 11 - 10
        insertMOde=false;
        rtMap = new Map<String,Id>();
        for (recordtype rt :[select Id,developerName from recordtype]){
            rtMap.put(rt.developerName, rt.Id);
        }
        
        String childLogId = ApexPages.currentPage().getParameters().get('cLogId');
        if (childLogId != null && String.isNotBlank(childLogId)){
            childLogEsistente=true;
            editMode=true;//??? è editabile solo finché in bozza.
            childLog = [SELECT Id, EOF_Codice_Ordine_OLO__c, Name, PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, 
                        EOF_Stato_Richiesta__c, EOF_SL_Riferimento__c,PO_Prime_Contractor__c, PO_Numero_fibre_richieste__c, 
                        PO_Sito__c, PO_Civico__c, PO_Nota_sito__c, CreatedDate, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,
                        EOF_SITO__c, EOF_NOTA_SITO__c, EOF_INDIRIZZO__c, EOF_NUMERO_CIVICO__c,
                        PO_Tipo_di_collegamento__c, EOF_PROFILO__c,OF_Id_Comune__c,EOF_Codice_Operatore__c,
                        
                        //Modifica Toponomastica
                        Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,
                        
                        PO_Log_IdComune2__c,PO_Log_Comune_2__c
                        
                        FROM EOF_EAI_Service_Log__c
                        WHERE Id = :childLogId];
            
            //giovanni 03/12/2018 inizio
            system.debug('giovanni03 selectedIdComune: ' + selectedIdComune);
            if(selectedIdComune != null && String.isNotBlank(selectedIdComune))
            { 
                childLog.EOF_Comune__c = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
                childLog.OF_Id_Comune__c = selectedIdComune;
            }
            
            system.debug('giovanni03 selectedIdComune1: ' + selectedIdComune1);
            if(selectedIdComune1 != null && String.isNotBlank(selectedIdComune1))
            {
                childLog.PO_Log_Comune_2__c  = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune1].OF_Comune__c;
                childLog.PO_Log_IdComune2__c = selectedIdComune1;
            }
            //giovanni 03/12/2018 fine
            
            system.debug('giovanni childLog.OF_Id_Comune__c: ' + childLog.OF_Id_Comune__c);
            if(!String.isBlank(childLog.OF_Id_Comune__c)){
                OF_ElencoComuniItaliani__c eci =[SELECT id, OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.OF_Id_Comune__c];
                system.debug('giovanni eci: ' + eci);
                searchTerm=eci.OF_Comune__c+' '+eci.OF_Regione__c;
                system.debug('giovanni searchTerm: ' + searchTerm);
                selectedIdComune=eci.id;
                system.debug('giovanni selectedIdComune: ' + selectedIdComune);
                checkModeEdit=true;
            }
            
            if(!String.isBlank(childLog.PO_Log_IdComune2__c)){
                OF_ElencoComuniItaliani__c eci =[SELECT id,OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.PO_Log_IdComune2__c];
                searchTerm1=eci.OF_Comune__c+' '+eci.OF_Regione__c;
                selectedIdComune1=eci.id;
                checkModeEdit2=true;
            }        
            
            //EC 2018 - 11 - 17 Start mostra allegati
            
            childcasedisplayattlist=[select id,Name,parentId, body, Description, OwnerId, 
                                     createdDate,BodyLength,ContentType, createdById, LastModifiedDate,
                                     LastModifiedById from Attachment where parentId=:childLogId];
            
            showAllegati=(!childcasedisplayattlist.isEmpty())?true:false;                    
            
            //EC 2018 - 11 - 17 end mostra allegati
            
        }
        
        else{
            parentLog=[select Id,EOF_Codice_Ordine_OLO__c,PO_Nome_Progetto__c,EOF_Codice_Operatore__c,PO_Offerta__c  from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('parentId')];
            insertMode=true;
            childLog = new EOF_EAI_Service_Log__c();
            childLog.RecordTypeId=rtMap.get('PO_Log_CircuitiDiretti_Collegamento');//EC 2018 - 11 - 10
            childLog.PO_Offerta__c = parentLog.PO_Offerta__c;//EC 2018 - 11 - 10
            childLog.EOF_Stato_Richiesta__c = 'Bozza';//EC 2018 - 11 - 10
            childLog.EOF_STATO_ORDINE__c = 'Bozza';//EC 2018 - 11 - 10
            childLog.EOF_Codice_Operatore__c = parentLog.EOF_Codice_Operatore__c;
            childLog.EOF_SL_Riferimento__c = parentLog.Id;
            childLog.PO_Nome_Progetto__c = parentLog.PO_Nome_Progetto__c;
            childLog.EOF_SL_Riferimento__c = parentLog.Id;

            //Modifica Toponomastica
            childLog.Particella_Toponomastica_1__c = 'Via';
            childLog.Particella_Toponomastica_2__c = 'Via';
            childLog.Particella_Toponomastica_3__c = 'Via';            
            
            //giovanni 03/12/2018 inizio
            system.debug('giovanni03 childLog.OF_Id_Comune__c: ' + childLog.OF_Id_Comune__c);
            if(!String.isBlank(childLog.OF_Id_Comune__c))
            {
                OF_ElencoComuniItaliani__c eci =[SELECT id, OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.OF_Id_Comune__c];
                system.debug('giovanni eci1: ' + eci);
                searchTerm=eci.OF_Comune__c+' '+eci.OF_Regione__c;
                system.debug('giovanni searchTerm: ' + searchTerm);
                selectedIdComune=eci.id;
                system.debug('giovanni selectedIdComune: ' + selectedIdComune);
                checkModeEdit=true;
            }
            
            system.debug('giovanni03 childLog.PO_Log_IdComune2__c: ' + childLog.PO_Log_IdComune2__c);
            if(!String.isBlank(childLog.PO_Log_IdComune2__c))
            {
                OF_ElencoComuniItaliani__c eci =[SELECT id,OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.PO_Log_IdComune2__c];
                system.debug('giovanni eci2: ' + eci);
                searchTerm1=eci.OF_Comune__c+' '+eci.OF_Regione__c;
                selectedIdComune1=eci.id;
                checkModeEdit2=true;
            }                
        }
    }
    //EC end 2018 - 09 - 27
    public void insertChildLog(){
        if(!String.isBlank(childLog.Id)){
            return;
        }
        upsert childLog;
        childLog = [SELECT Id,Name,createdDate,EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,
                    PO_Offerta__c,EOF_Stato_Richiesta__c,EOF_STATO_ORDINE__c,EOF_Codice_Operatore__c,
                    EOF_SL_Riferimento__c,PO_Nome_Progetto__c,EOF_Codice_Ordine_OLO__c
                    FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id];
        if(String.isBlank(childLog.EOF_Codice_Ordine_OLO__c)){
            childLog.EOF_Codice_Ordine_OLO__c= childLog.Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
            update childLog;
        }
        
    }
    public Pagereference SaveParentChildLogInfo(){
        try{
            System.debug('**** searchTerm = ' + selectedIdComune); 
            if(selectedIdComune != null && String.isNotBlank(selectedIdComune)){ 
                childLog.EOF_Comune__c = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
                childLog.OF_Id_Comune__c = selectedIdComune;
            }
            
            if(selectedIdComune1 != null && String.isNotBlank(selectedIdComune1)){
                childLog.PO_Log_Comune_2__c  = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune1].OF_Comune__c;
                childLog.PO_Log_IdComune2__c = selectedIdComune1;
            }
            
            system.debug('@@@@@@@@@@@EC childLog.EOF_Comune__c è ' + childLog.EOF_Comune__c +', childLog.PO_Log_IdComune2__c ' + childLog.PO_Log_IdComune2__c);
            
            system.debug('giovanni26 EOF_Codice_Ordine_OLO__c1: ' + childLog.EOF_Codice_Ordine_OLO__c);
            
            if(insertMOde){
                
                //giovanni
                //childLog.PO_Tipo_di_collegamento__c = optScelta;
                
                upsert childLog;
                childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
                
                system.debug('giovanni26 EOF_Codice_Ordine_OLO__c2: ' + childLog.EOF_Codice_Ordine_OLO__c);
                
                update childLog;
            }
            else{
                system.debug('giovanni26 EOF_Codice_Ordine_OLO__c3: ' + childLog.EOF_Codice_Ordine_OLO__c);
                if(String.isNotBlank(childLog.EOF_Codice_Operatore__c))
                {
                    childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
                }                               
                update childLog;
            }
            PageReference pg = new PageReference('/PO_Serv_Circuiti_Diretti_Riepilogo');
            
            pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
            
            return pg;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
    }
    
    public PageReference Annulla(){
        //non capisco perche qui faceva il delete
        
        PageReference pg = new PageReference('/PO_Serv_Circuiti_Diretti_Riepilogo');
        pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
        return pg;
    }
    
    public PageReference deleteChildAlone(){
        try{
            String parentLogId = childLog.EOF_SL_Riferimento__c;
            
            
            
            //Recupero la lista di tutti i log figli del log di collegamento (le vlan)
            List<Attachment> listAttachToDelete = [SELECT Id
                                                   FROM Attachment
                                                   WHERE ParentId = :childLog.Id];
            
            
            
            if(listAttachToDelete != null && !listAttachToDelete.isEmpty()){
                delete listAttachToDelete;
            }
            
            if(listNephewVLAN != null && !listNephewVLAN.isEmpty()){
                delete listNephewVLAN;
            }                        
            
            if(childLog != null && childLog.id != null){
                delete childLog;
            }

            PageReference pg = new PageReference('/PO_Serv_Circuiti_Diretti_Riepilogo');
            
            pg.getParameters().put('parentId', parentLogId);
            return pg;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
    }
    
    public PageReference upload() {
        
        system.debug('giovanni26 childLog:' + childLog);      
        
        attachmentExists = false;
        try {
            //Check sulla dimensione del file
            if(fileBody == null){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Select a file'));
                return null; 
            }else if(fileBody.size()>6291500){
                fileBody = null;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'File size must be <= 6MB'));
                return null;
            }else{//Se la dimensione è <= 6MB procedo
                if(childLog.Id == null || String.isBlank(childLog.Id))
                {
                    //giovanni 03122018 inizio
                    if(selectedIdComune != null && String.isNotBlank(selectedIdComune))
                    { 
                        childLog.EOF_Comune__c = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
                        childLog.OF_Id_Comune__c = selectedIdComune;
                    }
                    
                    if(selectedIdComune1 != null && String.isNotBlank(selectedIdComune1))
                    {
                        childLog.PO_Log_Comune_2__c  = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune1].OF_Comune__c;
                        childLog.PO_Log_IdComune2__c = selectedIdComune1;
                    }
                    //giovanni 03122018 fine
                    
                    insert childLog;
                }
                attachment a = new attachment();
                a.OwnerId = UserInfo.getUserId();
                a.ParentId = childLog.id; // the record the file is attached to
                a.IsPrivate = false;
                a.name = fileName;
                a.body = fileBody;
                fileBody = null;
                insert a;
                attachmentExists = true;
                
                system.debug('giovanni26 a: '+ a);
            }
        }catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            return null;
        } 
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));          
        
        //giovanni 19112018 inizio   
        //return null;
        PageReference pg = new PageReference('/PO_Serv_Circuiti_Diretti_EditLogInfo');
        pg.getParameters().put('cLogId', childLog.id); 
        return pg;
        //giovanni 19112018 fine   
    }
    
    public PageReference deletechildLog(){
        
        EOF_EAI_Service_Log__c cLogTodelete =[select Id, EOF_SL_Riferimento__c, EOF_Codice_Ordine_OLO__c,PO_Nome_Progetto__c,EOF_Codice_Operatore__c,PO_Offerta__c  from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('cLogId') Limit 1];
        String plId=cLogTodelete.EOF_SL_Riferimento__c;
        
        
        delete cLogTodelete;
        
        PageReference pg = new PageReference('/PO_Serv_Circuiti_Diretti_Riepilogo');
        pg.getParameters().put('parentId', plId);
        return pg;
        
        
    }
    
    @RemoteAction 
    public static List<OF_ElencoComuniItaliani__c> searchComune(String searchTerm) {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        // System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
        return AreaGeograficaJunction;
        
    }
}
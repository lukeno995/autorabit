public without sharing class PO_Serv_FiberLink_EditLogInfoCntrl {
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
    public boolean checkModeEdit3{get;set;}
    public boolean childLogEsistente{get;set;}
    public boolean showAllegati{get;set;} //EC 2018 - 11 - 17
    public List<attachment> childcasedisplayattlist{get;set;} //EC 2018 - 11 - 17
    
    public PO_Serv_FiberLink_EditLogInfoCntrl (){
      retUrl=ApexPages.currentPage().getUrl();
        //Setto a false di default la visaulzizazione vlan
        showVLAN = false;
        checkModeEdit=false;
        checkModeEdit2=false;
        checkModeEdit3=false;
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
                                PO_Tipo_di_collegamento__c, EOF_PROFILO__c,OF_Id_Comune__c,EOF_Codice_Operatore__c  ,
                                    PO_Log_Comune_2__c,   PO_Log_IdComune2__c , PO_Log_IdComune3__c ,
                        
                                //Modifica Toponomastica
                                Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,
                        
                                PO_Sito_3__c, PO_indirizzo_collegamento_3__c, PO_Civico_3__c, PO_Nota_sito_3__c, Tipo_Evento__c, Durata_Evento__c                                                 
                                FROM EOF_EAI_Service_Log__c
                                WHERE Id = :childLogId];
                      
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

            if(!String.isBlank(childLog.PO_Log_IdComune3__c)){
              OF_ElencoComuniItaliani__c eci =[SELECT id,OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.PO_Log_IdComune3__c];
              searchTerm2=eci.OF_Comune__c+' '+eci.OF_Regione__c;
              selectedIdComune2=eci.id;
              checkModeEdit3=true;
            }
            
            //EC 2018 - 11 - 17 Start mostra allegati
            
            childcasedisplayattlist=[select id,Name,parentId, body, Description, OwnerId, 
                                createdDate,BodyLength,ContentType, createdById, LastModifiedDate,
                                LastModifiedById from Attachment where parentId=:childLogId];
                                
            showAllegati=(!childcasedisplayattlist.isEmpty())?true:false;                    
            
            //EC 2018 - 11 - 17 end mostra allegati
                             
       /*Le VLaN??? 
           listNephewVLAN = [SELECT Id, RecordType.DeveloperName, OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_SERVICE_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c, 
                                    OF_SA_USER_VLAN__c, OF_SA_PROFILO_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c
                              FROM EOF_EAI_Service_Log__c
                              WHERE EOF_SL_Riferimento__c = :childLogId
                              AND OF_SA_KIT_CONSEGNA_VLAN__c!=null];
            if (listNephewVLAN != null && listNephewVLAN.size() > 0){
                showVLAN = true;
                VLanMaxRagg(listNephewVLAN);
                
            }
            vLanNoMax=listNephewVLAN.size() < 3?true:false;
            if(!String.isBlank(childLog.OF_Id_Comune__c)){
              OF_ElencoComuniItaliani__c eci =[SELECT OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.OF_Id_Comune__c];
              searchTerm=eci.OF_Comune__c+' '+eci.OF_Regione__c;
            }*/
        }
        
        else{
          parentLog=[select Id,EOF_Codice_Ordine_OLO__c,PO_Nome_Progetto__c,EOF_Codice_Operatore__c,PO_Offerta__c  from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('parentId')];
            insertMode=true;
            childLog = new EOF_EAI_Service_Log__c();
            childLog.RecordTypeId=rtMap.get('PO_Log_FiberLink_Collegamento');//EC 2018 - 11 - 10
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
            
            //insert childLog;
           // childLogToInsert.add(childLog);
            //vLanNoMax=true;            
        }
        /*
        childLogToInsert.add(childLog);
        childLog.EOF_Codice_Ordine_OLO__c= childLog.Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
        update childLog;
        */
    }
 /*La VLAN???? EC
    //EC start 2018 - 09 - 27
    public Boolean VLanMaxRagg(List<EOF_EAI_Service_Log__c> listaVlan){
        
         ListinoCosMap = new Map<String,String>();
        for(OF_CodificaProfiloListini__c cstSett : [select Name, PO_P2PAtt_ListinoCanoneName__c, CosType__c from OF_CodificaProfiloListini__c where PO_P2PAtt_ListinoCanoneName__c !='']){
            ListinoCosMap.put(cstSett.PO_P2PAtt_ListinoCanoneName__c, cstSett.CosType__c);
        }
      String tipoCos = ListinoCosMap.get(profiloName);
     
        if(tipoCos=='MULTI_COS'){
            vLanNoMax=listaVlan.size()<3?true:false; 
        }
        else if(tipoCos=='MONO_COS'){
           vLanNoMax=listaVlan.size()<1?true:false; 
        }
        else{
            vLanNoMax=false;
        }
        return vLanNoMax;
   }
   */
    //EC end 2018 - 09 - 27
    public void insertChildLog(){
      if(!String.isBlank(childLog.Id)){
          return;
        }
      upsert childLog;
      childLog = [SELECT Id,Name,createdDate,EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,
                  PO_Offerta__c,EOF_Stato_Richiesta__c,EOF_STATO_ORDINE__c,EOF_Codice_Operatore__c,
                  EOF_SL_Riferimento__c,PO_Nome_Progetto__c,EOF_Codice_Ordine_OLO__c, EOF_SITO__c, EOF_INDIRIZZO__c, EOF_NUMERO_CIVICO__c, EOF_NOTA_SITO__c,                  
                   PO_Sito_3__c, PO_indirizzo_collegamento_3__c, PO_Civico_3__c, PO_Nota_sito_3__c                                     
                   FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id];
        if(String.isBlank(childLog.EOF_Codice_Ordine_OLO__c)){
          childLog.EOF_Codice_Ordine_OLO__c= childLog.Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
          update childLog;
        }
        
    }
    public Pagereference SaveParentChildLogInfo(){
        try{            
            if(childLog.Tipo_Evento__c && (childLog.Durata_Evento__c < 1 || childLog.Durata_Evento__c == null))
            {
            	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Se è un Evento Temporaneo è obbligatorio indicare la Durata Evento'));
            	return null;                
            }
            
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
            
            if(selectedIdComune2 != null && String.isNotBlank(selectedIdComune2)){
                childLog.PO_Log_Comune_3__c  = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune2].OF_Comune__c;
              childLog.PO_Log_IdComune3__c = selectedIdComune2; 
            }
            else
            {
                childLog.PO_Log_Comune_3__c ='';
                childLog.PO_Log_IdComune3__c='';
            }
            
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
                
                //giovanni 27/01/2019 inizio
                //childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
                if(String.isNotBlank(childLog.EOF_Codice_Operatore__c))
                {
                    childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
                }                
                //giovanni 27/01/2019 fine
                
              update childLog;
            }
            
            //PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
            PageReference pg = new PageReference('/PO_Serv_FiberLink_Riepilogo');
            
            pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
            
            return pg;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
    }
    
    public PageReference Annulla(){
        //non capisco perche qui faceva il delete
        /*
        if(insertMode)
        {
          delete childLog;
        }
        */
        PageReference pg = new PageReference('/PO_Serv_FiberLink_Riepilogo');
        pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
        return pg;
    }
   
    /*
    public PageReference insertNewVLAN(){
      if(selectedIdComune != null && String.isNotBlank(selectedIdComune)){
                childLog.EOF_Comune__c = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
              childLog.OF_Id_Comune__c = selectedIdComune;
            }
      if(insertMOde){
              childLog.PO_Tipo_di_collegamento__c = optScelta;
              upsert childLog;
              childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
              update childLog;
            }
            else{
              update childLog;
            }
        PageReference pg = new PageReference('/PO_P2PAttiva_InserisciVLAN');
        pg.getParameters().put('from', 'EditLogPg');//EC 2018 - 09 - 18
        pg.getParameters().put('cLogId', childLog.Id);
        pg.getParameters().put('Mode','ins');
        return pg;
    }
    public PageReference modificaVLAN (){     
        PageReference pg = new PageReference('/PO_P2PAttiva_InserisciVLAN');
        pg.getParameters().put('cLogId', childLog.Id);
        pg.getParameters().put('IdVLAN', idVLAN);
        pg.getParameters().put('Mode','mod');
        pg.getParameters().put('retUrl',retUrl);
        return pg;
    }

    public PageReference cessaVLAN (){
        EOF_EAI_Service_Log__c sl = [select id from EOF_EAI_Service_Log__c where id=:idVLAN];
        delete sl;
        PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
        pg.getParameters().put('cLogId', childLog.Id);
        return pg;    
    }
    */

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
                                    
            //PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
            PageReference pg = new PageReference('/PO_Serv_FiberLink_Riepilogo');
                                    
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
                childLog.OF_Id_Comune__c = selectedIdComune;
                childLog.PO_Log_IdComune2__c =selectedIdComune1 ;
                childLog.PO_Log_IdComune3__c = selectedIdComune2;
                upsert childLog;
                /*if(childLog.Id == null || String.isBlank(childLog.Id)){
                    //Modifica FF per gestione dei comuni
					
                    //FINE MODIFICA FF
                    insert childLog;
                }*/
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
        PageReference pg = new PageReference('/PO_Serv_FiberLink_EditLogInfo');
        pg.getParameters().put('cLogId', childLog.id); 
        return pg;
        //giovanni 19112018 fine   
    }
    
    //EC start deletechildLog 2018 - 11 - 16
    /*
    ** Metodo di pageReference  che deve rimandare sulla pagina di riepilogo a partire dal parentlogId, cancellando il collegamento
    */
    public PageReference deletechildLog(){
    
    EOF_EAI_Service_Log__c cLogTodelete =[select Id, EOF_SL_Riferimento__c, EOF_Codice_Ordine_OLO__c,PO_Nome_Progetto__c,EOF_Codice_Operatore__c,PO_Offerta__c  from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('cLogId') Limit 1];
    String plId=cLogTodelete.EOF_SL_Riferimento__c;
   
    
    delete cLogTodelete;
    
    PageReference pg = new PageReference('/PO_Serv_FiberLink_Riepilogo');
        pg.getParameters().put('parentId', plId);
        return pg;
    
   
    }
    
    
    //EC end deletechildLog 2018 - 11 - 16
    
    /*
     public PageReference runSearchProfilo() {
            
        String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo');  
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
        If(objListino != null && objListino.IsPortalValid__c==true){
            profiloCommerciale=(string)objListino.OF_ProfiloCommerciale__c; 
        }else{
            profiloCommerciale= 'N/A';      
        }
        //profiloCommerciale ='TEST 2 TEST';
        viewError=false;
        viewProfilo=true;
        return null;
    }
    */
    
    //EC Start 2018 - 10 - 09 profilo NEW
    /*
     public PageReference runSearchProfilo() {
            
        String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo');  
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
        If(objListino != null && objListino.PO_P2PAtt_ListinoCanoneName__c !='' && objListino.IsPortalValid__c==true ){
            profiloCommerciale=(string)objListino.PO_P2PAtt_ListinoCanoneName__c; 
        }else{
            profiloCommerciale= 'N/A';      
        }
        //profiloCommerciale ='TEST 2 TEST';
        viewError=false;
        viewProfilo=true;
        return null;
    }
    */
    
   
    
    
    /*
    public List<SelectOption> getProfiloVLAN(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
      for(OF_CodificaProfiloListini__c cstSett : [select Name, PO_P2PAtt_ListinoCanoneName__c, CosType__c from OF_CodificaProfiloListini__c where PO_P2PAtt_ListinoCanoneName__c !='']){
      options.add(new SelectOption(cstSett.Name,cstSett.PO_P2PAtt_ListinoCanoneName__c));              
      }
      return options;
    }
    */
    //EC end 2018 - 10 - 09 profilo New
    
    
    
    
    @RemoteAction 
    public static List<OF_ElencoComuniItaliani__c> searchComune(String searchTerm) {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        // System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
        return AreaGeograficaJunction;

    }
    
    /*
    public pagereference childCase()
    {
        newAtt.clear();
        attxlxs.clear();
        attlst.clear();
        system.debug('recid====='+parentCase);
        system.debug('recid====='+parentcaseobj);
        Attachment.clear();
        string recid = '';
        ID rectypeId=[select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
        Case testParent=new Case();
        //system.debug('parentcase inside childcase method'+parentcase.id);
        String testParentId= apexpages.currentpage().getparameters().get('id');
        system.debug('ParentChild'+testParentId);
        if(TestParentID!= null){
            testParent=[select Id,PO_Nome_Progetto__c,ownerId  from Case where id=:testparentID];

        }



        if(parentCase != null && parentCase.id != null)
        {
            if(parentCase.PO_Nome_Progetto__c ==''||parentCase.PO_Nome_Progetto__c == null){
                parentCase.PO_Nome_Progetto__c =Nome ;
                offertEvento = parentCase.PO_Offerta__c;
            }
            system.debug('inside the childcase condiytion'+parentCase.PO_Nome_Progetto__c);

            system.debug('inside the childcase condiytion'+testParentId);
            recid =  parentCase.id;
            if(parentcase.OwnerId!=rectypeID){
                parentCase.OwnerId = UserInfo.getUserId();
                update parentCase;
            }
        }
        else if(parentcaseobj != null && parentcaseobj.id != null)
        {
            recid =  parentcaseobj.id;
            offertEvento = parentcaseobj.PO_Offerta__c;
            if(parentcaseobj.OwnerId!=rectypeID){
                parentcaseobj.OwnerId = UserInfo.getUserId();

                update parentcaseobj;
            }
        }
        else if(testcase != null && testcase.id != null)
        {
            if( testcase.PO_Nome_Progetto__c == ''||  testcase.PO_Nome_Progetto__c == null){
                testcase.PO_Nome_Progetto__c =Nome ;

            }
            recid =  testcase.id;
            testcase.OwnerId = UserInfo.getUserId();
            update testcase;
            Nome = '';
            system.debug('testcase'+testcase);
        }

        if(testParent != null && testParent .id != null)
        {
            if( testParent .PO_Nome_Progetto__c== ''||testParent .PO_Nome_Progetto__c==null){
                testParent .PO_Nome_Progetto__c =Nome ;
                offertEvento = testcase.PO_Offerta__c;
            }
            recid =  testParent .id;
            update testParent ;
            Nome = '';
            system.debug('testParent '+testParent );
        }
        system.debug('recid====='+recid);
        case caseupdate = [select id,casenumber,PO_Offerta__c,PO_Nome_Progetto__c,OwnerId from case where id=:recid];
        // caseupdate.PO_Nome_Progetto__c = testCase.PO_Nome_Progetto__c;
        // update caseupdate;



        recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_Lease'];
        recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_link'];
        recordtype rt3 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P'];
        recordtype rt4 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_IRU'];
        recordtype rt5 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'];
        recordtype rt6 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P_Attiva']; // EC add recordType 'PO_Collegamento_P2P_Attiva' 2018 - 07 - 13
        // selectedIdComune

        case pcase = [select id,PO_Offerta__c,PO_Nome_Progetto__c,ownerId from case where id=:caseupdate.id limit 1];
        system.debug('Parent Case--------->'+pcase);
        string serviceType = pcase.PO_Offerta__c;
        system.debug('serviceType-------->'+serviceType);
        
        //if P2P Attiva ed è ancora una bozza creare un Log, altrimenti quando in 
        

        if(serviceType == 'Fiber Link')
        {
            if(pcase != null)
            {
                update pcase;
            }
            selectedIdComune = '';
            selectedIdComune1 = '';
            selectedIdComune2 = '';
            ChildCase = new Case();
            ChildCase.ParentId = pcase.id;
            ChildCase.accountid = accId;
            ChildCase.PO_Richiesta_a_fattibilit__c = recid;
            ChildCase.RecordTypeId = rt2.id;
            ChildCase.Status = 'Bozza';
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
            return pr;

        }

        if(serviceType == 'Fiber Lease')
        {  system.debug('serviceType22-------->'+serviceType);
         if(pcase != null)
         {
             update pcase;
         }
         selectedIdComune = '';
         selectedIdComune1 = '';
         selectedIdComune2 = '';
         ChildCase = new Case();
         ChildCase.ParentId =  pcase.id;
         ChildCase.accountid = accId;
         ChildCase.PO_Richiesta_a_fattibilit__c =  recid ;
         childCase.RecordTypeId = rt1.id;
          ChildCase.Status = 'Bozza';
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
            return pr;


        }
        if(serviceType == 'P2P Base')
        {   system.debug('serviceType33-------->'+serviceType);
         if(pcase != null)
         {
             update pcase;
         }
         selectedIdComune = '';
         selectedIdComune1 = '';
         selectedIdComune2 = '';
         ChildCase = new Case();
         ChildCase.ParentId = pcase.id;
         ChildCase.accountid = accId;
         ChildCase.PO_Richiesta_a_fattibilit__c =recid ;
         childCase.RecordTypeId = rt3.id;
         ChildCase.Status = 'Bozza';
         //ChildCase.Contact.id = usr.Contact.id;
         insert childCase;
         pagereference pr = new pagereference('/apex/PO_P2PBaseNew?parentid='+pcase.id);
         return pr;
        }
        if(serviceType == 'IRU')
        {
            //update parentCase;
            if(pcase != null)
            {
                update pcase;
            }
            selectedIdComune = '';
            selectedIdComune1 = '';
            selectedIdComune2 = '';
            ChildCase = new Case();
            ChildCase.ParentId = recid;
            ChildCase.accountid = accId;
            ChildCase.PO_Richiesta_a_fattibilit__c = recid;
            childCase.RecordTypeId = rt4.id;
             ChildCase.Status = 'Bozza';

            insert childCase;
            pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
            return pr;
            //ChildCase.Contact.id = PO_IRU_FiberLease_Childusr.Contact.id;

        }
        if(serviceType == 'Evento Temporaneo')
        {
            //update parentCase;
            if(pcase != null)
            {
                update pcase;
            }
            selectedIdComune = '';
            selectedIdComune1 = '';
            selectedIdComune2 = '';
            ChildCase = new Case();
            ChildCase.ParentId = recid;
            ChildCase.accountid = accId;
            ChildCase.PO_Richiesta_a_fattibilit__c = recid;
            childCase.RecordTypeId = rt5.id;
            ChildCase.Status = 'Bozza';
            //ChildCase.Contact.id = usr.Contact.id;
            insert childCase;
            pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
            return pr;

        }

        try{
            ChildCase.Status = 'Bozza';
            insert ChildCase;
        }catch(exception e){
            system.debug('getMessage error==>'+ e.getMessage() +'getStackTraceString error'+ e.getStackTraceString());

        }
        system.debug('Service Type--->'+serviceType);
        system.debug('ChildCase--->'+ChildCase);
        pagereference pr = new pagereference('/apex/OF_ChildCase?parentid='+pcase.id);
        return pr;
    }    
    */
    
}
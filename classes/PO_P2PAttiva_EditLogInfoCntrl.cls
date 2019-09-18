public without sharing class PO_P2PAttiva_EditLogInfoCntrl {
    public String recordOfferta {get;set;}
    public EOF_EAI_Service_Log__c childLog {get;set;}
    public EOF_EAI_Service_Log__c parentLog {get;set;}
    public EOF_EAI_Service_Log__c sLogKit {get;set;}
    public List<EOF_EAI_Service_Log__c> vlanList {get;set;}
    public List<EOF_EAI_Service_Log__c>  P2PAttivaLogList {get;set;} 
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
    public List<SelectOption> optTraffic{get; set;}
    public List<SelectOption> optVelocitaBanda{get; set;}
    public String optScelta{get; set;} 
    public Map<String,Id> rtMap {get;set;}
    public string fileName{get;set;}
    public blob filebody{get;set;}
    public Boolean attachmentExists{get;set;}    
    public List<EOF_EAI_Service_Log__c> listNephewVLAN{get;set;}
    public Boolean showVLAN{get;set;}
    public Boolean showTraffic{get;set;}
    public String idVLAN  {get;set;}
    public string verifyProfilo{get;set;} //EC PROFILO AS OS 2018 - 08 - 08 
    public boolean viewError{get;set;}//EC PROFILO AS OS 2018 - 08 - 08
    public boolean viewProfilo{get;set;}//EC PROFILO AS OS 2018 - 08 - 08
    public string profiloCommerciale{get;set;}//EC PROFILO AS OS 2018 - 08 - 08 
    public boolean vLanNoMax {get;set;}
    Map<String,String> ListinoCosMap {get;set;}
    public String profiloName{get;set;}
    public string retUrl;
    public Account accountN{get;set;}
    public user usr {get; set;}
    public Id accId;
    public String trafficLoadBalancing{get;set;}
    public String strSedeCalc{get;set;}

    public boolean showAllegati{get;set;} 
    public boolean isKit{get;set;}
    public boolean isProfilo{get;set;}
    public list <Contact> cnt {get;set;}
    public String searchvalue { get; set; }
    public Boolean render1 { get; set; }
    //public Boolean isProfilo{get; set;}
    public List<attachment> childcasedisplayattlist{get;set;} 
     public Decimal pirCOS5 {get;set;}
    public Decimal cirCOS5 {get;set;}
    public Decimal pirCOS3 {get;set;}
    public Decimal cirCOS3 {get;set;}
    public Decimal pirCOS1 {get;set;}
    public Decimal cirCOS1 {get;set;}
    
    public Static String profCommerciale{get;set;} //EC 20190320
    public String tipoP2PAttiva {get;set;} //EC 2019 05 23 aggiunto per P2P Attiva fase2 capire se è una eLine o una eAccess
    
    public PO_P2PAttiva_EditLogInfoCntrl(){
        
     

        
        usr=[Select Name,Profile.Name,IsActive,Contact.Account.Id,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
             contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
             contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
             contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,contact.PO_Servizio_Incident_Management__c,
             contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c,Contact.Account.EOF_Codice_Operatore__c
             From User
             Where Id =: System.UserInfo.getUserId()];
        accId = usr.Contact.Account.Id;
        system.debug('@@@@@EC accId dopo la prima query su user: ' + accId);
        tipoP2PAttiva=ApexPages.currentPage().getParameters().get('tipoP2Patt');//EC 2019 05 23 aggiunto per P2P Attiva fase2 capire se è una eLine o una eAccess
        
        retUrl=ApexPages.currentPage().getUrl();
        //Setto a false di default la visaulzizazione vlan
        showVLAN = false;
        showTraffic = false;
        //Valorizzo la picklist di tipo collegamento - ASAP spostare in un metodo
        opt= new List<SelectOption>();
        optTraffic= new List<SelectOption>();
        optVelocitaBanda= new List<SelectOption>();
        
        optVelocitaBanda.add(new SelectOption('-- None --','-- None --'));
        optVelocitaBanda.add(new SelectOption('100M','100M'));
        optVelocitaBanda.add(new SelectOption('200M','200M'));
        optVelocitaBanda.add(new SelectOption('300M','300M'));
        optVelocitaBanda.add(new SelectOption('500M','500M'));
        optVelocitaBanda.add(new SelectOption('1G','1G'));
        optVelocitaBanda.add(new SelectOption('2G','2G'));
        optVelocitaBanda.add(new SelectOption('3G','3G'));
        optVelocitaBanda.add(new SelectOption('5G','5G'));
        optVelocitaBanda.add(new SelectOption('10G','10G'));
        
        User ContactUser = [Select contactId from User where id=:UserInfo.getUserId()];
        Id accId = [Select AccountId from Contact where id =: ContactUser.ContactId].AccountId;
        accountN = [select Name from Account where id =:accId];
       
        optTraffic.add(new SelectOption('ACTIVE/STANDBY','ACTIVE/STANDBY')); 
         optTraffic.add(new SelectOption('ACTIVE/ACTIVE','ACTIVE/ACTIVE'));  
    
        
        opt.add(new SelectOption('E-Access','E-Access'));  
        //Fine valorizzazione
        
        //giovanni 28/12/2018 inizio
        optScelta = 'E-Access';
        //giovanni 28/12/2018 fine
        system.debug('@@@@EC 1 nel controller profCommerciale è ' + profCommerciale);
        profCommerciale=''; //'Apexpages.currentPage().getParameters().get('TextProfilo')'; //EC 20190320
        system.debug('@@@@EC 2 nel controller profCommerciale è ' + profCommerciale);
        editMode=false;
        insertMOde=false;
        rtMap = new Map<String,Id>();
        vlanList =  new List<EOF_EAI_Service_Log__c>();
        isKit = true;
        isProfilo = true;
        for (recordtype rt :[select Id,developerName from recordtype]){
            rtMap.put(rt.developerName, rt.Id);
        }
        String childLogId = ApexPages.currentPage().getParameters().get('cLogId');
        System.debug('childLogId'+childLogId);
        // DN
        listNephewVLAN = new List<EOF_EAI_Service_Log__c>();
        if ( childLogId != null && String.isNotBlank(childLogId)){
           
            vlanList = [SELECT  id,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_SERVICE_VLAN__c,
                        COS5_PIR__c, COS5_CIR__c, COS3_PIR__c, COS3_CIR__c, 
                        COS1_PIR__c, COS1_CIR__c,PO_P2PAttiva_Opzione__c,OF_SA_PROFILO_VLAN__c 
                        FROM EOF_EAI_Service_Log__c 
                        WHERE EOF_SL_Riferimento__c =: childLogId 
                        and RecordTypeId =: rtMap.get('OF_SA_Vlan') ]; 
            if(vlanList.size()>0){
                isProfilo = false;
            }
            editMode=true;
            childLog = [SELECT Id, EOF_Codice_Ordine_OLO__c, Name, PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, EOF_Stato_Richiesta__c, EOF_SL_Riferimento__c,
                        PO_Prime_Contractor__c, PO_Numero_fibre_richieste__c, PO_Sito__c, PO_Civico__c, PO_Nota_sito__c, CreatedDate, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,
                        PO_Tipo_di_collegamento__c, EOF_PROFILO__c,OF_Id_Comune__c,EOF_Codice_Operatore__c,
                        PO_Offerta__c,Particella_Toponomastica_1__c,ID_Sede__c,Tipologia_CPE__c,Tipologia_Alimentazione__c,Interfaccia_CPE__c,
                        TrafficLoadBalancing__c,kit_in_condivisione__c,OF_PP_KIT_Log__c
                        FROM EOF_EAI_Service_Log__c
                        WHERE Id = :childLogId  ];

            strSedeCalc =childLog.ID_Sede__c;
            if(childLog.OF_PP_KIT_Log__c!=null || childLog.kit_in_condivisione__c!=null){
              
                isKit = false;
            }
            listNephewVLAN = [SELECT Id, RecordType.DeveloperName, OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_SERVICE_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c, 
                              OF_SA_USER_VLAN__c, OF_SA_PROFILO_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c
                              FROM EOF_EAI_Service_Log__c
                              WHERE EOF_SL_Riferimento__c = :childLogId
                              AND OF_SA_KIT_CONSEGNA_VLAN__c!=null];
            if (listNephewVLAN != null && listNephewVLAN.size() > 0){
                showVLAN = true;
                VLanMaxRagg(listNephewVLAN);
                
            }
            // luca inizio 09/05/2019 aggiunti nuovi valori per la picklist in base alla tipologia di richiesta
            if(childLog!=null){
                if(childLog.PO_Offerta__c=='E-Access' ){
                    opt.add(new SelectOption('E-Access','E-Access'));
                    
                    
                }else if(childLog.PO_Offerta__c=='E-Line'){
                    opt.add(new SelectOption('E-Line','E-Line'));
                }
            }
            // luca fine
            vLanNoMax=listNephewVLAN.size() < 3?true:false; //EC 20190206 di nuovo il numero massimo di vlan deve essere 3
            if(!String.isBlank(childLog.OF_Id_Comune__c)){
                OF_ElencoComuniItaliani__c eci =[SELECT OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.OF_Id_Comune__c];
                searchTerm=eci.OF_Comune__c+' '+eci.OF_Regione__c;
            }
            
            //giovanni - 11 - 17 Start mostra allegati
            
            childcasedisplayattlist=[select id,Name,parentId, body, Description, OwnerId, 
                                     createdDate,BodyLength,ContentType, createdById, LastModifiedDate,
                                     LastModifiedById from Attachment where parentId=:childLogId];
            
            showAllegati=(!childcasedisplayattlist.isEmpty())?true:false;                    
            
            //giovanni - 11 - 17 end mostra allegati
        }
        
        else{
            parentLog=[select Id,PO_Nome_Progetto__c,EOF_Codice_Operatore__c,PO_Offerta__c  from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('parentId')];
            insertMode=true;
            childLog = new EOF_EAI_Service_Log__c();
            //EC 2019 05 23 start check su tipo di p2pAttiva preso da url per assegnare RT
            if('eAccess'.equals(tipoP2PAttiva)){
                childLog.RecordTypeId=rtMap.get('P2P_Attiva_Collegamento');
            }else if('eLine'.equals(tipoP2PAttiva)){
                childLog.RecordTypeId=rtMap.get('P2P_Attiva_Collegamento_ELine');
            }
            //EC 2019 05 23 end check su tipo di p2pAttiva preso da url per assegnare RT            
          
          // childLog.RecordTypeId=rtMap.get('P2P_Attiva_Collegamento');
            childLog.PO_Offerta__c = 'P2P Attiva';
            childLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
            childLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
            childLog.EOF_Codice_Operatore__c = parentLog.EOF_Codice_Operatore__c;
            childLog.EOF_SL_Riferimento__c = parentLog.Id;
            childLog.PO_Nome_Progetto__c = parentLog.PO_Nome_Progetto__c;
            vLanNoMax=true;


        }
    }
    //EC start 2018 - 09 - 27
    public Boolean VLanMaxRagg(List<EOF_EAI_Service_Log__c> listaVlan){
        
        ListinoCosMap = new Map<String,String>();
        for(OF_CodificaProfiloListini__c cstSett : [select Name, OF_ListinoCanoneName__c, CosType__c from OF_CodificaProfiloListini__c where servizio__c = 'P2P Attiva']){
            ListinoCosMap.put(cstSett.OF_ListinoCanoneName__c, cstSett.CosType__c);
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
    //EC end 2018 - 09 - 27
    public void insertChildLog(){
        System.debug('@@@insertChildLog'+childLog.Id);
        if(!String.isBlank(childLog.Id)){
            return;
        }
        upsert childLog;
        System.debug('@@@childdd'+childLog);
        childLog = [SELECT Id,Name,createdDate,EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,NumberSede__c,
                    PO_Offerta__c,EOF_Stato_Richiesta__c,EOF_STATO_ORDINE__c,EOF_Codice_Operatore__c
                    /*PO_Tipo_percorso__c ,PO_Indirizzo_collegamento__c,PO_Civico__c,Particella_Toponomastica_1__c ,
                    PO_Sito__c ,PO_Nota_sito__c ,Tipologia_CPE__c ,Tipologia_Alimentazione__c,Interfaccia_CPE__c ,
                    EOF_PROFILO__c */,
                    EOF_SL_Riferimento__c,PO_Nome_Progetto__c,EOF_Codice_Ordine_OLO__c, TrafficLoadBalancing__c
                    FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id];
        // da analizzare perchè non dovrebbe essere cosi!!!
        childLog.PO_Tipo_percorso__c = null;
        childLog.PO_Indirizzo_collegamento__c = null;
        childLog.PO_Civico__c = null;
        childLog.Particella_Toponomastica_1__c = null;
        childLog.PO_Sito__c = null;
        childLog.PO_Nota_sito__c = null;
        childLog.Tipologia_CPE__c = null;
        childLog.Tipologia_Alimentazione__c = null;
        childLog.Interfaccia_CPE__c = null;
        childLog.EOF_PROFILO__c = null;
        if(String.isBlank(childLog.EOF_Codice_Ordine_OLO__c)){
            childLog.EOF_Codice_Ordine_OLO__c= childLog.Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');

            strSedeCalc = childLog.EOF_Codice_Operatore__c + '_Sede_' + childLog.NumberSede__c;
            system.debug('@@@@@ strSedeCalc: ' + strSedeCalc);
        }
        
    } 
    
    public Pagereference SaveParentChildLogInfo(){
        system.debug('@@@@EC chiamato il metodo SaveParentChildLogInfo');
        //string proComm= Apexpages.currentPage().getParameters().get('TextProfilo');
        
        
        //String spr= childLog.EOF_PROFILO__c;
        // childLog.EOF_PROFILO__c=myVar; 
        //system.debug('@@@@EC *** spr: ' + spr);
        //system.debug('@@@@@EEEECCC proComm  ' + proComm); 
        
        viewProfilo=true;
        viewError=false;
        /*OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(spr);
system.debug('@@@@@EC objListino: ' + objListino);
/*If(objListino == null || !objListino.IsPortalValid__c){
profiloCommerciale= 'N/A'; 
//viewError=true;
system.debug('@@@@@EC profiloCommerciale: ' + profiloCommerciale);
return null;
}
else{
profiloCommerciale= objListino.OF_ListinoCanoneName__c; 
profCommerciale= objListino.OF_ListinoCanoneName__c; 
system.debug('@@@@@EC profiloCommerciale: ' + profiloCommerciale);

}*/
        
        //system.debug('@@@@@EC è andata. prima del try: ' + profiloCommerciale);
        try{
            // DN 24-5
            // ho spostato il codice nel metodo saveCollegamento per evitare codice
            // duplicato. (usato anche in inserisciNuovoKit) 
            saveCollegamento();
            PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
            pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            return pg;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
    }

    // DN
    public PageReference inserisciNuovoKit() {
        System.debug('@@@@@ inserisciNuovoKit START');
        String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');
        
        if(PrntLogID==null || PrntLogID==''){
            PrntLogID=[select id,EOF_SL_Riferimento__c from EOF_EAI_Service_Log__c where id=: Apexpages.currentPage().getParameters().get('cLogId')].EOF_SL_Riferimento__c;
        }
        viewProfilo=true;
        viewError=false;
        // 24/05 DN
        try {
            saveCollegamento();
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }

        PageReference pg = new PageReference('/apex/PO_P2PAttiva_InserimentoKit');
        pg.getParameters().put('parentId',PrntLogID);
        pg.getParameters().put('cLogId',childLog.Id);
        pg.getParameters().put('from','RiepReq');
        pg.getParameters().put('op','ins');
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        pg.getParameters().put('retUrl',retUrl);
        return pg;
    }

    // DN 24/05 fix a mancanza comune su collegmanto quando si clicca su aggiungi kit prima che
    // su salva coollegamento
    private void saveCollegamento() {
        System.debug('**** searchTerm = ' + selectedIdComune);
        if(selectedIdComune != null && String.isNotBlank(selectedIdComune)){
            childLog.EOF_Comune__c = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
            childLog.OF_Id_Comune__c = selectedIdComune;
        }
        
        if(childLog.EOF_PROFILO__c == '2G' || childLog.EOF_PROFILO__c == '3G' || childLog.EOF_PROFILO__c == '5G' ||childLog.EOF_PROFILO__c == '10G' ){
           childLog.Tipologia_CPE__c = 'High-End'; 
        }
         if(childLog.EOF_PROFILO__c == '10G' ){
           childLog.Interfaccia_CPE__c = 'Ottica'; 

        }
        
        if(trafficLoadBalancing != null && String.isNotBlank(trafficLoadBalancing)){
            if(childLog.PO_Tipo_percorso__c=='Singola Via'){
                childLog.TrafficLoadBalancing__c = '';
            }else{
                    childLog.TrafficLoadBalancing__c = trafficLoadBalancing;
            }
            
        }
         childLog.PO_Tipo_di_collegamento__c = optScelta;
        if(insertMOde){
            if(childLog.PO_Tipo_percorso__c !=null){
                if(childLog.PO_Tipo_percorso__c =='Singola Via'){
                    //    childLog.TrafficLoadBalancing__c='-- None --';
                    childLog.PO_Numero_fibre_richieste__c ='2';
                }else if(childLog.PO_Tipo_percorso__c =='Doppia Via'){
                    childLog.PO_Numero_fibre_richieste__c ='2+2';
                }
            }
            childLog.PO_Tipo_di_collegamento__c = optScelta;
            System.debug('##### into saveCollegamento - optScelta:' + optScelta);
            //childLog-TrafficLoadBalancing__c = trafficLoadBalancing;
            upsert childLog;
            childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
            update childLog;
        }
        else{
            if(childLog.PO_Tipo_percorso__c !=null){
                if(childLog.PO_Tipo_percorso__c =='Singola Via'){
                    //  childLog.TrafficLoadBalancing__c='-- None --';
                    childLog.PO_Numero_fibre_richieste__c ='2';
                }else if(childLog.PO_Tipo_percorso__c =='Doppia Via'){
                    childLog.PO_Numero_fibre_richieste__c ='2+2';
                }
            }
            update childLog;
        }
    }
    
    // DN 21/05
    //EC start 2018 - 09 - 21
    public pagereference inserisciNuovoKit_OLD() {       
        
        
        String cLogId = ApexPages.currentPage().getParameters().get('cLogId');
        String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');
        if(PrntLogID==null || PrntLogID==''){
            PrntLogID=[select id,EOF_SL_Riferimento__c from EOF_EAI_Service_Log__c where id=: Apexpages.currentPage().getParameters().get('cLogId')].EOF_SL_Riferimento__c;
        }
        //parentLog=[select Id,PO_Nome_Progetto__c,EOF_Codice_Operatore__c,PO_Offerta__c  from EOF_EAI_Service_Log__c where id=:cLogId];
        
        id rtP2PattKitId = rtMap.get('PO_Log_P2P_Attiva_KIT');
        childLog = new EOF_EAI_Service_Log__c();
        childLog.EOF_SL_Riferimento__c = PrntLogID;
        System.debug('@@@parentID'+cLogId);
        childLog.recordtypeId = rtP2PattKitId;
        childLog.EOF_Stato_Richiesta__c='NA';
        childLog.EOF_CODICE_OPERATORE__c=usr.Contact.Account.EOF_Codice_Operatore__c;
        childLog.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        childLog.Nome_del_KIT__c='';//nomeAzienda + s1.replace('LOG-', '_KIT_');//nomekit;
        childLog.Modello_di_Servizio__c='';//ModelloServizio;
        insert childLog;
        PageReference pg = new PageReference('/apex/PO_P2PAttiva_InserimentoKit');
        pg.getParameters().put('parentId',PrntLogID);
        pg.getParameters().put('cLogId',cLogId);
        pg.getParameters().put('kitId',childLog.id);
        pg.getParameters().put('from','RiepReq');
        pg.getParameters().put('op','ins');
        pg.getParameters().put('retUrl',retUrl);
        return pg;
    }
    //LM start 2019 - 05 - 15
    public pagereference insertVlan() {
                System.debug('@@ childLog.TrafficLoadBalancing__c.Id'+ childLog.TrafficLoadBalancing__c);
        System.debug('trafficLoadBalancing'+trafficLoadBalancing);
        PageReference pg = new PageReference('/apex/PO_P2PAttiva_InserimentoVLAN'); 
        childLog.TrafficLoadBalancing__c = trafficLoadBalancing;
         if(selectedIdComune != null && String.isNotBlank(selectedIdComune)){
            childLog.EOF_Comune__c = [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
            childLog.OF_Id_Comune__c = selectedIdComune;
        }
       
        update childLog;
        // pg.getParameters().put('parentId',parentLog.Id);
        pg.getParameters().put('cLogId',childLog.id);
        pg.getParameters().put('from','RiepReq');
        pg.getParameters().put('op','ins');  
        pg.getParameters().put('retUrl',retUrl);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg; 
    }
    //LM end 2019 - 05 - 15
    
    public PageReference Annulla(){ 
        if(insertMode){
            delete childLog;
        }
        PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    
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
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    public PageReference modificaVLAN (){     
        PageReference pg = new PageReference('/PO_P2PAttiva_InserisciVLAN');
        pg.getParameters().put('cLogId', childLog.Id);
        pg.getParameters().put('IdVLAN', idVLAN);
        pg.getParameters().put('Mode','mod');
        pg.getParameters().put('retUrl',retUrl);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    
    public PageReference cessaVLAN (){
        EOF_EAI_Service_Log__c sl = [select id from EOF_EAI_Service_Log__c where id=:idVLAN];
        delete sl;
        PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
        pg.getParameters().put('cLogId', childLog.Id);
        return pg;    
    }
    
    
    public PageReference deleteChildAlone(){
        try{
            String parentLogId = childLog.EOF_SL_Riferimento__c;
            
            //Recupero la lista di tutti i log figli del log di collegamento (le vlan)
            List<Attachment> listAttachToDelete = [SELECT Id
                                                   FROM Attachment
                                                   WHERE ParentId = :childLog.Id];
            if(!listAttachToDelete.isEmpty()){
                delete listAttachToDelete;
            }
            if(!listNephewVLAN.isEmpty()){
                delete listNephewVLAN;
            }
            if(childLog != null){
                delete childLog;
            }
            PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
            pg.getParameters().put('parentId', parentLogId);
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            return pg;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
    }
    
    public PageReference upload() {
        attachmentExists = false;
        try {

            system.debug('##### ATTACH 001' );
            //Check sulla dimensione del file
            if(fileBody == null){
                system.debug('##### ATTACH 001bis');
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Select a file'));
                return null; 
            }else if(fileBody.size()>6291500){
                fileBody = null;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'File size must be <= 6MB'));
                return null;
            }else{//Se la dimensione è <= 6MB procedo
            	system.debug('@@@@EC metodo upload di PO_P2PAttiva_EditLogInfoCntrl. la dimensione dell\'attach è minore o uguale a 6MB');
                if(childLog.Id == null || String.isBlank(childLog.Id)){
					system.debug('@@@@EC non esiste childLog.id, siamo nell\'if che verifica questa condizione. Infatti childLog.id è: ' + childLog.id);
                    insert childLog;
					system.debug('@@@@EC non esisteva childLog.id, ancora nell\'if dopo aver inserito childLog. ora childLog.id è: ' + childLog.id);
                }
                system.debug('##### ATTACH 002');
                attachment a = new attachment();
                a.OwnerId = UserInfo.getUserId();
                a.ParentId = childLog.id; // the record the file is attached to
                a.IsPrivate = false;
                a.name = fileName;
                a.body = fileBody;
                fileBody = null;
                system.debug('##### ATTACH 003');
                insert a;
                attachmentExists = true;
                system.debug('##### ATTACH 004');
            }
        }catch (DMLException e) {
            system.debug('##### ATTACH 005');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            return null;
        } 
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
        //PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
        //pg.getParameters().put('cLogId', childLog.Id);
        system.debug('##### ATTACH 006');
        //return pg;
        //
        //return null;
        try{
            System.debug('**** searchTerm = ' + selectedIdComune);
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
            PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
            pg.getParameters().put('cLogId', childLog.Id);
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            return pg;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
        
    }
    
    
    public PageReference modifyProf(){
        PageReference pg = new PageReference('/apex/PO_P2PAttiva_InserimentoVLAN');
        String idVlan = ApexPages.currentPage().getParameters().get('idvlan');
        if(idVlan!=''){
            pg.getParameters().put('idvlan',idVlan);
        }
        pg.getParameters().put('vlan','modify'); 
        pg.getParameters().put('cLogId',childLog.id);
        pg.getParameters().put('retUrl',retUrl); 
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    
    
    /* public void HideBtnColleg(){
        isKit=false;
        isProfilo=false;
        
    }
    public void showBtnColleg(){
        isKit=true; 
        isProfilo=true;
        
    } */
    //EC Start profilo 2018 - 08 - 08
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
    //EC end profilo 2018 - 08 -08
    
    //EC Start 2018 - 10 - 09 profilo NEW
    
    /*public PageReference runSearchProfilo() {

String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo'); 
system.debug('@@@EC chiamato il metodo runSearchProfilo ');
viewError=false; 
viewProfilo=true;
OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
If(objListino != null && String.isNotBlank(objListino.OF_ListinoCanoneName__c) && objListino.servizio__c == 'P2P Attiva' && objListino.IsPortalValid__c==true ){
profiloCommerciale= objListino.OF_ListinoCanoneName__c; 
profCommerciale=objListino.OF_ListinoCanoneName__c;
system.debug('@@@EC chiamato il metodo runSearchProfilo profCommerciale dovrebbe essere valorizzato in maniera ok ' + profCommerciale);

return null;

}else{
profiloCommerciale= 'N/A'; 
profCommerciale=profiloCommerciale;
viewError=true;
system.debug('@@@EC chiamato il metodo runSearchProfilo profCommerciale con profilo commerciale n/a: ' + profCommerciale);
return null;
}
//profiloCommerciale ='TEST 2 TEST';

}*/
    
    
    /* public String getProfilo(String prof) {
system.debug('@@@@EC chiamato metodo getProfilo. Il parametro passato prof è: ' + prof);
viewError=false; 
String TextProfilo = prof;  
OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
If(objListino != null && String.isNotBlank(objListino.OF_ListinoCanoneName__c) && objListino.servizio__c == 'P2P Attiva' && objListino.IsPortalValid__c==true ){
profiloCommerciale= objListino.OF_ListinoCanoneName__c; 
}else{
profiloCommerciale= 'N/A'; 
viewError=true; 
}
viewProfilo=true;
//profiloCommerciale ='TEST 2 TEST';
profCommericale= profiloCommerciale;
system.debug('@@@@EC chiamato metodo getProfilo. stiamo per tornare la stringa profCommericale così valorizzata: ' + profCommericale);
return profCommericale;
} */
    
    
    
    
    public List<SelectOption> getProfiloVLAN(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
        for(OF_CodificaProfiloListini__c cstSett : [select Name, OF_ListinoCanoneName__c, CosType__c from OF_CodificaProfiloListini__c where servizio__c = 'P2P Attiva' AND OF_ListinoCanoneName__c != null]){
            options.add(new SelectOption(cstSett.Name,cstSett.OF_ListinoCanoneName__c));              
        }
        return options;
    }
    
    //EC end 2018 - 10 - 09 profilo New
    
    
    
    
    @RemoteAction 
    public static List<OF_ElencoComuniItaliani__c> searchComune(String searchTerm) {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        // System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
        return AreaGeograficaJunction;
        
    }
    
    public PageReference onkeyupAction() {
        searchAction();
        return null;
    }
    
    public PageReference searchAction() {
        render1=true;
        cnt=[Select Name from Contact where Name like :+searchvalue+'%' order by Name asc];
        if(cnt.isEmpty())
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Error,'No Records Found'));
        }
        return null;
    }
    
    public PageReference getRecordProfili(){
        String parentLogId = childLog.EOF_SL_Riferimento__c;
        PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
        String childLogId = ApexPages.currentPage().getParameters().get('cLogId');
        pg.getParameters().put('cLogId',childLogId);
        pg.getParameters().put('parentId',childLog.EOF_SL_Riferimento__c); 
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        EOF_EAI_Service_Log__c vlanTableProf = new EOF_EAI_Service_Log__c();
        System.debug('childLogId'+childLogId);
        String velocitaBanda=childLog.EOF_PROFILO__c;
        update childLog;
        System.debug('@@@velocitaBanda'+velocitaBanda);
        String replaceVeloc;
        replaceVeloc = velocitaBanda;
        if(velocitaBanda.contains('M')){
            replaceVeloc=velocitaBanda.replace( 'M', '' );
        }else if(velocitaBanda.contains('G')){
            replaceVeloc=velocitaBanda.replace( 'G', '' ); 
            replaceVeloc+='000';
            System.debug('replaceVeloc@@@'+replaceVeloc);
        }
        vlanTableProf = [SELECT  id,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_SERVICE_VLAN__c,
                         COS5_PIR__c, COS5_CIR__c, COS3_PIR__c, COS3_CIR__c, 
                         COS1_PIR__c, COS1_CIR__c,PO_P2PAttiva_Opzione__c,OF_SA_PROFILO_VLAN__c 
                         FROM EOF_EAI_Service_Log__c 
                         WHERE EOF_SL_Riferimento__c =: childLogId
                         and RecordTypeId =: rtMap.get('OF_SA_Vlan') limit 1]; 
        List<Configurazione_VLAN__c> cvVLANList = Configurazione_VLAN__c.getAll().values();
        for(Configurazione_VLAN__c cv : cvVLANList){
            if(vlanTableProf.PO_P2PAttiva_Opzione__c== cv.Opzione__c){
                if(vlanTableProf.OF_SA_PROFILO_VLAN__c== cv.Profilo__c){
                    System.debug('@@'+cv);
                    pirCOS5 = Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS5PIR__c)/100;
                    cirCOS5 =Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS5CIR__c)/100;
                    pirCOS3 = Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS3PIR__c)/100;
                    cirCOS3 = Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS3CIR__c)/100;
                    pirCOS1= Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS1PIR__c)/100;
                    cirCOS1= Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS1CIR__c)/100;
                 
                }   
            }
        }
        vlanTableProf.COS5_PIR__c = String.valueOf(pirCOS5);
        vlanTableProf.COS5_CIR__c = String.valueOf(cirCOS5);
        vlanTableProf.COS3_PIR__c = String.valueOf(pirCOS3);
        vlanTableProf.COS3_CIR__c = String.valueOf(cirCOS3);
        vlanTableProf.COS1_PIR__c = String.valueOf(pirCOS1);
        vlanTableProf.COS1_CIR__c = String.valueOf(cirCOS1);
        update vlanTableProf;
        vlanList.clear();
        vlanList.add(vlanTableProf);
        return pg;
    }
    




}
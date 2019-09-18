public class PO_P2PAttiva_InserisciVLAN_Controller {
    
    public boolean modifyMode {get;set;}
    public boolean insertMode {get;set;}
    public boolean primaVlan {get;set;}
    public static String idVlan {get;set;}
    public static String mode {get;set;}
    public string retUrl;
    public static String pgFrom {get;set;} //EC 2018 - 09 - 18
    public static String cLogId;
    public String apageCkey{get;set;}    
    public EOF_EAI_Service_Log__c slVlan {get;set;}
    public Map<String,Id> rtMap {get;set;}   
    public List<SelectOption>  optKitList {get; set;}  
    public String KitoptName {get; set;}    
    public EOF_EAI_Service_Log__c sl{get;set;}
    public Map<String,String> ListinoCosMap {get;set;}
    public String requestLog;
    public Map<String,String> mapKitNameId;
    public List<SelectOption> ProfiloVLAN{get;set;}
    public List<SelectOption> modelloServizio{get;set;}

    
    public PO_P2PAttiva_InserisciVLAN_Controller() {		
        modifyMode=false;
        insertMode=false;
        primaVlan=false;
        pgFrom=ApexPages.currentPage().getParameters().get('from');
        idVlan=ApexPages.currentPage().getParameters().get('IdVLAN');
        mode=ApexPages.currentPage().getParameters().get('Mode');
        cLogId=ApexPages.currentPage().getParameters().get('cLogId');
        retUrl=ApexPages.currentPage().getUrl();
        system.debug('@@@@@@@@@@@EC nel controller di PO_P2PAttiva_InserisciVLAN_Controller, cLogId è ' + cLogId);
        
        if(mode =='mod'){
            slVlan=[select Id, OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c, EOF_SL_Riferimento__c,
                    OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c
                    from EOF_EAI_Service_Log__c where id=:idVlan];
            modifyMode=true;
        }else{
            insertMode=true;
            slVlan= new EOF_EAI_Service_Log__c();
            //slVlan.OF_SA_VLan_Log__c=slOrig.Id; DAPRENDERE DA QUERY STRING
            List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
            rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                rtMap.put(rt.developerName, rt.Id); 
            }  
            
            slVlan.recordtypeId=rtMap.get('OF_SA_Vlan');
            slVlan.EOF_Stato_Richiesta__c='Bozza Portale';
            slVlan.EOF_SL_Riferimento__c = cLogId;
            //slVlan.OF_SA_VLan_Log__c=ApexPages.currentPage().getParameters().get('idRisorsa');
        }
        //aggiungo la logica sul numero vlan:
        //se è la prima vlan può scegliere un kit o aggiungerne uno, dalla seconda in poi eredita il kit scelto nella prima
        //faccio il controllo se è stato tentato l'inserimento di un  kit
        List<EOF_EAI_Service_Log__c> vlanList=[select Id, OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c, EOF_SL_Riferimento__c,
                                               OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,
                                               EOF_SL_Riferimento__r.EOF_SL_Riferimento__c
                                               from EOF_EAI_Service_Log__c where EOF_SL_Riferimento__c=:cLogId and OF_SA_KIT_CONSEGNA_VLAN__c!=null];
        scegliKIT();
        if(vlanList.size()==0)
            primaVlan=true;
        else
            slVlan.OF_SA_KIT_CONSEGNA_VLAN__c=vlanList[0].OF_SA_KIT_CONSEGNA_VLAN__c;
        makeProfiloVLAN(vlanList);
        makeModelloServizio();
    }
    
    
    
    //EC Start - 2018 - 10 - 09

    public List<SelectOption> makeModelloServizio() {
        modelloServizio = new List<SelectOption>();
        modelloServizio.add(new SelectOption('',''));
        modelloServizio.add(new SelectOption('MonoCOS', 'MonoCOS'));
        modelloServizio.add(new SelectOption('MultiCOS', 'MultiCOS'));
    
	    return modelloServizio; 
    }
    
      public List<SelectOption> makeProfiloVLAN(List<EOF_EAI_Service_Log__c> vlanList){
      	system.debug('@@@@ vlanList: '+vlanList);
      	Set<String> setVlanProf = new Set<String>();
      	setVlanProf.add('COS 0');
      	setVlanProf.add('COS 3');
      	setVlanProf.add('COS 5');
      	for(EOF_EAI_Service_Log__c vlan : vlanList){
      		system.debug('@@@@ vlan.OF_SA_PROFILO_VLAN_PL__c: '+vlan.OF_SA_PROFILO_VLAN__c);
      		if(modifyMode){
      			if(vlan.Id!=slVlan.Id){
      				setVlanProf.remove(vlan.OF_SA_PROFILO_VLAN__c);
      			}
      		}
      		else{
      			setVlanProf.remove(vlan.OF_SA_PROFILO_VLAN__c);
      		}
      	}
        ProfiloVLAN = new List<SelectOption>();
        ProfiloVLAN.add(new SelectOption('',''));
        for(String vlanProf : setVlanProf){
        	ProfiloVLAN.add(new SelectOption(vlanProf,vlanProf));
        }
	    return ProfiloVLAN; 
    } 
    
    //EC end 2018 - 10 - 09
    
    public void modifyPicklist(){
        if(slVlan.OF_SA_PROFILO_VLAN__c=='0'){
            slVlan.OF_SA_PROFILO_VLAN__c='COS 0';
            slVlan.OF_SA_USER_VLAN__c='835';
        }
        else if(slVlan.OF_SA_PROFILO_VLAN__c=='3'){
            slVlan.OF_SA_PROFILO_VLAN__c='COS 3';
            slVlan.OF_SA_USER_VLAN__c='935';
        }
        else if(slVlan.OF_SA_PROFILO_VLAN__c=='5'){
            slVlan.OF_SA_PROFILO_VLAN__c='COS 5';
            slVlan.OF_SA_USER_VLAN__c='837';
        }
        else{
            slVlan.OF_SA_PROFILO_VLAN__c='';
            slVlan.OF_SA_USER_VLAN__c='';
        }        
    }
    //@testvisible added by sasya to cover the method in test class	
    @testvisible private void mappingPicklist(){
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 0'){
            slVlan.OF_SA_PROFILO_VLAN__c='0';
            slVlan.OF_SA_USER_VLAN__c='835';
        }
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 3'){
            slVlan.OF_SA_PROFILO_VLAN__c='3';
            slVlan.OF_SA_USER_VLAN__c='935';
        }
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 5'){
            slVlan.OF_SA_PROFILO_VLAN__c='5';
            slVlan.OF_SA_USER_VLAN__c='837';
        }
    }
    
    public PageReference annullaVLAN(){
        PageReference pageRef;
        if(ApexPages.currentPage().getParameters().get('retUrl')!=null){
            pageRef = new PageReference(ApexPages.currentPage().getParameters().get('retUrl'));
            return pageRef;
        }
        if(ApexPages.currentPage().getParameters().get('from')=='EditLogPg'){
            pageRef = new PageReference('/PO_P2PAttiva_EditLogInfo');
            pageRef.getParameters().put('cLogId', ApexPages.currentPage().getParameters().get('cLogId'));
        }
        else{
            pageRef = new PageReference('/PO_P2PAttiva_Req');
            // pageRef.getParameters().put('',apageCkey);
            pageRef.getParameters().put('parentId', slVlan.EOF_SL_Riferimento__r.EOF_SL_Riferimento__c);
            pageRef.getParameters().put('cLogId', ApexPages.currentPage().getParameters().get('cLogId'));
        }
        return pageRef;
    }
    
    public PageReference InserisciVLAN(){
        
        //mappingPicklist();
        list<EOF_EAI_Service_Log__c> slToUpsert = new list<EOF_EAI_Service_Log__c>();
        //se è la prima vlan aggiungo il riferimento al kit sulle vlan e sul collegamento
        if(primaVlan){
            EOF_EAI_Service_Log__c childLog = new EOF_EAI_Service_Log__c();
            childLog.Id=ApexPages.currentPage().getParameters().get('cLogId');
            childLog.OF_PP_KIT_Log__c=mapKitNameId.get(slVlan.OF_SA_KIT_CONSEGNA_VLAN__c);
            slToUpsert.add(childLog); 
        }
        slVlan.OF_PP_KIT_Log__c=mapKitNameId.get(slVlan.OF_SA_KIT_CONSEGNA_VLAN__c);
        //slVlan.OF_SA_KIT_CONSEGNA_VLAN__c=null;
        slToUpsert.add(slVlan);
        upsert slToUpsert;
        string cLogId2 = ApexPages.currentPage().getParameters().get('cLogId');
        string parentId2 = ApexPages.currentPage().getParameters().get('parentId');
        
        Pagereference pageRef;
        
        if(ApexPages.currentPage().getParameters().get('from')=='EditLogPg' ||
           ApexPages.currentPage().getParameters().get('from')=='ReqPg'){
               pageRef = new PageReference('/PO_P2PAttiva_EditLogInfo');
               pageRef.getParameters().put('cLogId', cLogId2);
               pageRef.getParameters().put('parentId', parentId2);
               
           }
        else{
            pageRef = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
            pageRef.getParameters().put('parentId', parentId2);
            pageRef.getParameters().put('cLogId', cLogId2);
        }
        pageRef.setRedirect(true);
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@EC pageReference dopo inserisciVlan è ' + pageRef);
        return pageRef;
    }
    
    public PageReference updateVLAN(){
        //mappingPicklist();
        list<EOF_EAI_Service_Log__c> slToUpsert = new list<EOF_EAI_Service_Log__c>();
        //aggiungo il riferimento al kit sulle vlan e sul collegamento
        EOF_EAI_Service_Log__c childLog = new EOF_EAI_Service_Log__c();
        childLog.Id=cLogId;
        childLog.OF_PP_KIT_Log__c=mapKitNameId.get(slVlan.OF_SA_KIT_CONSEGNA_VLAN__c);
        slVlan.OF_PP_KIT_Log__c=mapKitNameId.get(slVlan.OF_SA_KIT_CONSEGNA_VLAN__c);
        //slVlan.OF_SA_KIT_CONSEGNA_VLAN__c=null;
        slToUpsert.add(childLog);
        slToUpsert.add(slVlan);
        upsert slToUpsert;
        
        PageReference pageRef = new PageReference('/PO_P2PAttiva_EditLogInfo');
        pageRef.getParameters().put('cLogId', ApexPages.currentPage().getParameters().get('cLogId'));
        pageRef.setRedirect(true);
        return pageRef; 
    }
    
    //EC Start KIT 2018 - 09 - 26
    public void scegliKIT(){
        optKitList = new List<SelectOption>();  //optNomeProgetto      public List<SelectOption>  optKitList {get; set;}  //KitoptName{get; set;}
        User attuale=[select Id,Account.EOF_Codice_Operatore__c ,Account.name from user where Id=:userinfo.getUserId()];
        String codOperatore= attuale.Account.EOF_Codice_Operatore__c;
        //mi salvo l'id della request generale per poi usarlo nella logica di estrazione dei kit
        requestLog=[select EOF_SL_Riferimento__c from EOF_EAI_Service_Log__c where id=:cLogId].EOF_SL_Riferimento__c;
        optKitList.add(new SelectOption(' - ',' - '));
        //nella scelta del kit devo poter scegliere tra i kit all'interno della request e gli asset attivi di kit per quell'OLO
        mapKitNameId= new Map<String,String>();
        for(EOF_EAI_Service_Log__c kitLog: [SELECT id, PO_P2PAttiva_Nome_del_KIT__c
                                            FROM EOF_EAI_Service_Log__c 
                                            WHERE RecordType.DeveloperName = 'PO_Log_P2P_Attiva_KIT' 
                                            AND EOF_SL_Riferimento__c =:requestLog
                                            AND PO_P2PAttiva_Nome_del_KIT__c!='']){
                                                optKitList.add(new SelectOption(kitLog.PO_P2PAttiva_Nome_del_KIT__c,kitLog.PO_P2PAttiva_Nome_del_KIT__c));
                                                mapKitNameId.put(kitLog.PO_P2PAttiva_Nome_del_KIT__c,kitLog.Id);  
                                            }
        for(asset a : [select id, name,Account.EOF_Codice_Operatore__c 
                       from Asset 
                       where Account.EOF_Codice_Operatore__c=:codOperatore
                       and recordtype.developername='PO_Asset_P2P_Attiva_KIT' 
                       and status='Attivo']){
            optKitList.add(new SelectOption(a.name,a.name));
            //mapKitNameId.put(a.name,a.Id); l'id dell'asset non andrebbe bene
        }
    }
    
    public pagereference inserisciNuovoKit(){
        system.debug('@@@@@@@@@@@@@@@@@@EC abbiamo chiamato il metodo inserisciNuovoKit');
        MAp<String,String> rtMap = new MAp<String,String>();
        for(recordType RT : [select id, developerName from recordType]){
            rtMap.Put(rt.developerName, rt.Id);
        }
        String PrntLogID = ApexPages.currentPage().getParameters().get('parentId');
        String cLogId = ApexPages.currentPage().getParameters().get('cLogId');
        id rtP2PattKitId = rtMap.get('PO_Log_P2P_Attiva_KIT');
        sl = new EOF_EAI_Service_Log__c();
        sl.EOF_SL_Riferimento__c=PrntLogID;
        sl.recordtypeId = rtP2PattKitId;
        sl.EOF_Stato_Richiesta__c='NA';
        sl.EOF_CODICE_OPERATORE__c=usr.Contact.Account.EOF_Codice_Operatore__c;
        sl.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        sl.Nome_del_KIT__c='';//nomeAzienda + s1.replace('LOG-', '_KIT_');//nomekit;
        sl.Modello_di_Servizio__c='';//ModelloServizio;
        insert sl; 
        list<EOF_EAI_Service_Log__c> slToUpsert = new list<EOF_EAI_Service_Log__c>();
        //aggiungo il riferimento al kit sulle vlan e sul collegamento
        EOF_EAI_Service_Log__c childLog = new EOF_EAI_Service_Log__c();
        childLog.Id=cLogId;
        childLog.OF_PP_KIT_Log__c=sl.Id;
        slVlan.OF_PP_KIT_Log__c=sl.Id; 
        slVlan.OF_SA_KIT_CONSEGNA_VLAN__c=null;
        slToUpsert.add(childLog);
        slToUpsert.add(slVlan);
        upsert slToUpsert;
        system.debug('@@@@ slVlan: '+slVlan);
        PageReference pg = new PageReference('/apex/PO_P2PAttiva_InserimentoKit');
        pg.getParameters().put('parentId',PrntLogID);
        pg.getParameters().put('cLogId',cLogId);
        pg.getParameters().put('kitId',sl.id);
        pg.getParameters().put('slVlan',slVlan.id);
        pg.getParameters().put('from','InsVlan');
        pg.getParameters().put('retUrl',retUrl);
        pg.setRedirect(true);
        return pg;
        
        
    }
    
    public user usr {
        get{
            return [
                Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
                contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
                contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
                contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,contact.PO_Servizio_Incident_Management__c, 
                contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c,Contact.Account.EOF_Codice_Operatore__c
                From User
                Where Id =:System.UserInfo.getUserId()
            ];
        }
    }
    //EC 2018 - 09 - 27
    public String tipoCos(String profiloName){
        
        ListinoCosMap = new Map<String,String>();
        for(OF_CodificaProfiloListini__c cstSett : [SELECT Name, OF_ListinoCanoneName__c, CosType__c FROM OF_CodificaProfiloListini__c WHERE servizio__c = 'P2P Attiva' AND OF_ListinoCanoneName__c != null]){
            ListinoCosMap.put(cstSett.OF_ListinoCanoneName__c, cstSett.CosType__c);
        }
        String tipoCos = ListinoCosMap.get(profiloName);
        return tipoCos;
    }
    
    //EC end KIT 2018 - 09 - 26
}
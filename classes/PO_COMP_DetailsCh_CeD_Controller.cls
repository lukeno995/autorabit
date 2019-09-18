public class PO_COMP_DetailsCh_CeD_Controller {
    
    public List<Case> cases{get;set;}
    public List<Case> listCaseCessazione{get;set;}
    public List<OF_CommercialElementIstanziato__c> CEI{get;set;}
    public EOF_EAI_Service_Log__c sl{get;set;}
    public boolean desospendi{get;set;}
    public Case cas{get;set;}
    public boolean annulla{get;set;}
    public boolean hideMod{get;set;}
    public boolean rimodula{get;set;}
    public List<Case> SlApparati{get;set;}
    public String IdOrder{get;set;}
    public boolean Apparati{get;set;}
    public boolean ServiziAggiuntivi{get;set;}
    public boolean VLAN{get;set;} 
    public boolean showB{get;set;}
    public String title{get;set;}
    public boolean details{get;set;}
    public boolean error{get;set;} 
    public boolean success{get;set;} 
    public Asset asset{get;set;} 
    public boolean aperto{get;set;}
    public User u{get;set;}
    public string profiloCommerciale{get;set;}
    public string dataAttivazione{get;set;}
    public string dataCessazione{get;set;}
    
    public PO_COMP_DetailsCh_CeD_Controller(){
        
        Apparati=false;
        error=false;
        success=false;
        aperto=true;
        details=true;
        hideMod=false;
        VLAN=false;
        showB=false;
        
        asset = [SELECT ID,OF_IDCaseAttivazione__c,Status,Name,OF_ProfiloOpenStream__c,OF_Identificativo_del_POP__c,
                 OF_DataAttivazione2__c,OF_DataCessazione2__c,OF_ClusterPromozione__c,EOF_ID_Risorsa__c,OF_ID_Building__c,
                 OF_Provincia__c,OF_Comune__c,OF_Indirizzo__c,OF_Particella_Toponomastica__c,OF_Civico__c,
                 OF_Scala_Palazzina__c,Account.EOF_Codice_Operatore__c,OF_Promozione__c
                 FROM Asset 
                 where Id=:Apexpages.currentPage().getParameters().get('origId') 
                 LIMIT 1];
        
        dataAttivazione = asset.OF_DataAttivazione2__c.format('dd-MM-YYYY');
        
        if(asset.OF_DataCessazione2__c!=null){
            dataCessazione=asset.OF_DataCessazione2__c.format('dd-MM-YYYY');
        }
        asset.OF_Indirizzo__c=asset.OF_Particella_Toponomastica__c+' '+asset.OF_Indirizzo__c+' '+asset.OF_Civico__c;
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(asset.OF_ProfiloOpenStream__c);
        
        If(objListino != null){
            profiloCommerciale = objListino.OF_ProfiloCommerciale__c; 
        }
        else{  
            profiloCommerciale = '';
        }
        
        listCaseCessazione = [SELECT id, Status 
                              from Case
                              where(recordtype.developername = 'EOF_Caso_Cessazione_OPENSTREAM_CD') 
                              AND status='Acquisito' 
                              AND EOF_Id_Risorsa__c =:asset.Name ];
        
        if(listCaseCessazione.isEmpty() && asset.Status=='Attivo'){
            showB=true;            
        }
        
        List<EOF_EAI_Service_Log__c> objTemp = [SELECT Id,EOF_Stato_Richiesta__c 
                                                FROM EOF_EAI_Service_Log__c 
                                                where EOF_Stato_Richiesta__c = 'Bozza Portale' 
                                                and recordtype.developername = 'PO_SA_CD_Log_ChangeOrderRequest' 
                                                AND EOF_Id_Risorsa__c =:asset.Name];
        if(!objTemp.isEmpty()){
            sl = objTemp.get(0);
            hideMod=true; 
        }

        CEI = [SELECT Id,OF_KitConsegnaVLAN__c,OF_ServiceVLAN__c, OF_CustomerVLAN__c, OF_InformazioniVLAN__c,
                OF_UserVLAN__c, OF_ProfiloVLAN__c, OF_ModelloDiServizioVLAN__c 
                FROM OF_CommercialElementIstanziato__c 
                where OF_Asset__c=:asset.Id 
                AND OF_Stato__c='Attivo' 
                AND recordtype.developerName = 'OF_VLAN'];
                
        if(!CEI.isEmpty()){
            VLAN=true; 
        }
    }
    
    public pageReference ChangeOrder(){
        Pagereference pg = new Pagereference('/PO_CeD_DettaglioBozze');
        pg.getParameters().put('IdOrder',cas.EOF_Id_Risorsa__c);
        System.debug('@@@pageReference'+pg);
        return pg;
    }
    
    public pageReference Cessazione(){
        Pagereference pg = new Pagereference('/PO_OpenStreamCeD_InsertNewReq');
        pg.getParameters().put('idRisorsa', asset.Name);
        pg.getParameters().put('proc','CESS');
        return pg;
    }
    
    
    public PageReference openBozza(){
        PageReference pg = new PageReference('/PO_CeD_ModificaVLAN');
        pg.getParameters().put('idRisorsa',sl.id);
        pg.getParameters().put('goto', 'PO_DetailChange_CeD?origId='+asset.id);
        return pg;
    }

    public pageReference newBozza()
    {   
        if(sl!=null){  
            List<EOF_EAI_Service_Log__c> slList = [select id 
                                                   from EOF_EAI_Service_Log__c 
                                                   where recordtype.developername='OF_SA_Vlan' 
                                                   and OF_SA_VLan_Log__c=:sl.id 
                                                   and EOF_Stato_Richiesta__c='Bozza Portale' ];
            if(!slList.isEmpty()){
                delete slList;
            }
            delete sl;
        }
        sl=new EOF_EAI_Service_Log__c();
        List<recordtype> rtList=[select Id,developerName from recordtype];  
        Map<String,Id> rtMap;                                                                             
        rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }
        sl.EOF_Id_Risorsa__c = asset.name;          
        sl.recordtypeId=rtMap.get('PO_SA_CD_Log_ChangeOrderRequest');
        sl.EOF_Stato_Richiesta__c = 'Bozza Portale';
        sl.EOF_CODICE_OPERATORE__c = asset.Account.EOF_Codice_Operatore__c;
        sl.EOF_Tipo_Comunicazione_String__c = 'Change Order';
        sl.EOF_PROMOZIONE__c = asset.OF_Promozione__c;
        sl.EOF_CLUSTER_PROMOZIONE__c = asset.OF_ClusterPromozione__c;
        
        insert sl;
        List<EOF_EAI_Service_Log__c> listaVLan = new List<EOF_EAI_Service_Log__c>();
        
        if(!CEI.isEmpty())
        {            
            for(OF_CommercialElementIstanziato__c CeiAgg : CEI){
                EOF_EAI_Service_Log__c EEVlan = new EOF_EAI_Service_Log__c();
                EEVlan.OF_SA_KIT_CONSEGNA_VLAN__c = CeiAgg.OF_KitConsegnaVLAN__c;
                EEVlan.OF_SA_SERVICE_VLAN__c = CeiAgg.OF_ServiceVLAN__c;
                EEVlan.OF_SA_CUSTOMER_VLAN__c = CeiAgg.OF_CustomerVLAN__c;
                EEVlan.OF_SA_INFORMAZIONI_VLAN__c = CeiAgg.OF_InformazioniVLAN__c;
                EEVlan.OF_SA_USER_VLAN__c = CeiAgg.OF_UserVLAN__c;
                EEVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = CeiAgg.OF_ModelloDiServizioVLAN__c;
                EEVlan.OF_SA_PROFILO_VLAN__c = CeiAgg.OF_ProfiloVLAN__c;   
                EEVlan.OF_SA_VLan_Log__c = sl.id;      
                EEVlan.EOF_Stato_Richiesta__c ='Bozza Portale';
                EEVLan.recordtypeId=rtMap.get('OF_SA_Vlan');
                listaVLan.add(EEVlan);  
            }
        }
        insert listaVLan;

        PageReference pg = new PageReference('/PO_CeD_ModificaBozze');
        pg.getParameters().put('idRisorsa',sl.id);
        pg.getParameters().put('proc','newBozza');
        pg.getParameters().put('goto', 'PO_DetailChange_CeD?origId='+asset.id);
        return pg; 
    }
}
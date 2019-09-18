public class PO_TP_COMP_ListaBozze_Controller {
public List<EOF_EAI_Service_Log__c> listBozze {get;set;}
public List<BozzeWrapper> listaBozzeWrapper {get;set;}
public String IdScelta {get;set;}
public Integer totalRecord{get;set;} 
public Integer pageActual{get;set;} 
public Decimal totalpage{get;set;} 
public boolean showPag{get;set;} 
public Decimal pageRecord{get;set;}
public Integer offset_page{get;set;}
public Decimal totpg{get;set;} 
public boolean showRow{get;set;} 
public Integer totRec{get;set;} 
public List<string> ListIdRisorse {get;set;} 
public boolean richiesteBozza{get;set;}
public Map<String,Id> AssMap;
public Map<Id,String>bozzeMap;
public String idRis{get;set;}

    
public PO_TP_COMP_ListaBozze_Controller() {
    totalRecord=0; 
    pageActual=0;
    pageRecord=5; 
    totalpage=0;
    Integer off=0; 
    showRow=true; 
    showPag=true; 
    richiesteBozza = true;
    List<recordtype> rtList=[select Id,developerName from recordtype];  
     Map<String,Id> rtMap;                                                                             
        rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }

        
        
    Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId; 
    //Id contId = [SELECT ContactId FROM User where id=:userinfo.getuserid() LIMIT 1].ContactId;
    List<ASSET> ListAsset = [SELECT  Name,EOF_ID_Risorsa__c from ASSET where AccountId=:accId and Status='Attivo']; 
    List<string> ListIdRisorse = new List<string> ();        
        for(Asset a:listAsset){
            ListIdRisorse.add(a.Name);  
        }
    listBozze = [Select id,EOF_ID_Risorsa__c,EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c , EOF_PROFILO__c,EOF_Data_Ora_Creazione__c from EOF_EAI_Service_Log__c where  (recordtype.DeveloperName='PO_CO_FiberRequest' AND EOF_Stato_Richiesta__c='Bozza Portale' AND EOF_Tipo_Comunicazione_String__c='Change Order' AND EOF_ID_Risorsa__c in :ListIdRisorse)or (recordtype.DeveloperName='PO_SA_FiberRequest' AND EOF_Tipo_Comunicazione_String__c='Cessazione') LIMIT :(integer)pageRecord OFFSET :off];
    
    bozzeMap= new Map<Id,String>();
    for(EOF_EAI_Service_Log__c x: listBozze){
        if(x.EOF_Tipo_Comunicazione_String__c.equalsIgnoreCase('Change Order')){
            bozzeMap.put(x.id,'CO');
            
        }else{
            bozzeMap.put(x.id,x.EOF_ID_Risorsa__c);
            
        }
        idRis=x.EOF_ID_Risorsa__c;
    }
        
        
        System.debug('####MAP'+bozzeMap);  
    
    totRec = [Select count() from EOF_EAI_Service_Log__c where  (recordtype.DeveloperName='PO_CO_FiberRequest' AND EOF_Stato_Richiesta__c='Bozza Portale' AND EOF_Tipo_Comunicazione_String__c='Change Order' AND EOF_ID_Risorsa__c in :ListIdRisorse) or (recordtype.DeveloperName='PO_SA_FiberRequest' AND EOF_Tipo_Comunicazione_String__c='Cessazione')];
    system.debug('####### totrec '+ totRec);
    
    //QUERY DATI FALSATI PER TEST!! 
    /*listBozze = [Select id,EOF_ID_Risorsa__c,EOF_STATO_ORDINE__c , EOF_PROFILO__c,EOF_Data_Ora_Creazione__c from EOF_EAI_Service_Log__c where  recordtype.DeveloperName='PO_CO_FiberRequest' limit 15];
    totRec = [Select count() from EOF_EAI_Service_Log__c where  recordtype.DeveloperName='PO_CO_FiberRequest'];
    */
    system.debug('*****listBozzeCOST' +listBozze);
    listaBozzeWrapper= new List <BozzeWrapper>();
    for(EOF_EAI_Service_Log__c item : listBozze){ 
        BozzeWrapper temp= new BozzeWrapper(); 
        temp.id=item.id;
        temp.IDRisorsa=item.EOF_ID_Risorsa__c;
        temp.Profilo=item.EOF_PROFILO__c;
        temp.Stato=item.EOF_STATO_ORDINE__c;
        temp.DataAttivazione= string.valueOfGmt(item.EOF_Data_Ora_Creazione__c);
        if(item.EOF_Tipo_Comunicazione_String__c.equalsIgnoreCase('Change Order')){
            temp.tipoRichiesta='Change Order';
        }
        
        listaBozzeWrapper.add(temp);
    }
    totpg = (totRec /pageRecord).round(RoundingMode.CEILING); 
    system.debug('###### totpg '+ totpg);
    setPagination(null);  
}

public class BozzeWrapper{
    public String id{get;set;}
    public String IDRisorsa{get;set;}
    public String IdScelta{get;set;}
    public String Profilo{get;set;}
    public String Listino{get;set;}
    public String Stato{get;set;}
    public String DataAttivazione{get;set;}
    public String tipoRichiesta {get;set;}
    public BozzeWrapper(){}
}

public PageReference ViewDettagliBozze(){
    PageReference pg;
    String s=bozzeMap.get(IdScelta);
    System.debug('@@@@@string'+s);
    if(s.equalsIgnoreCase('CO')){
         pg= new PageReference('/PO_OF_DetailBozze');   
         pg.getParameters().put('idRisorsa',IdScelta);
        
    }else{
         pg= new PageReference('/PO_OpenStreamService_InsertNewRequest');   
         pg.getParameters().put('proc','CESS');  
         pg.getParameters().put('IdRisorsa',idRis); 

    }
    return pg;
}
public PageReference pageDown(){ 
    setPagination(false); 
    return null; 
}
public PageReference pageUp(){ 
    setPagination(true); 
    return null; 
}

public void setPagination(boolean next){ 
    if(next==null){
        pageActual=1; 
        totalpage = totpg; 
        totalRecord =totRec;
    }else if(next){ 
        if(pageActual<totalpage){ 
            pageActual++;
            totalpage = totpg; 
            totalRecord = totRec;
            preparePage(); 
        } 
    }else{ 
        if(pageActual>1){ 
            pageActual--; 
            totalpage = totpg; 
            totalRecord = totRec;
            preparePage(); 
        } 
    } 
}

public void preparePage(){  
    integer index=0;
    if(pageActual==totalpage||pageRecord>listBozze.size()){ 

        index=((pageActual-1)*((integer)pageRecord))+math.mod(totalRecord,(integer)pageRecord);
        System.debug('**** indexx!!! ' + index);  
        }else{ 
            index=(pageActual)*(integer)pageRecord; 
        } 
    integer off=(pageActual-1)*((integer)pageRecord); 
    Id accId =  [SELECT AccountId  FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId; 
    //Id contId = [SELECT ContactId FROM User where id=:userinfo.getuserid() LIMIT 1].ContactId;
    List<ASSET> ListAsset = [SELECT  Name,EOF_ID_Risorsa__c from ASSET where AccountId=:accId and Status='Attivo']; 
    List<string> ListIdRisorse = new List<string> ();        
        for(Asset a:listAsset){
            ListIdRisorse.add(a.Name);  
        }
    System.debug('**** OFFSET My!!! ' + off);
    listBozze = [Select id,EOF_ID_Risorsa__c,EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c , EOF_PROFILO__c,EOF_Data_Ora_Creazione__c from EOF_EAI_Service_Log__c where (recordtype.DeveloperName='PO_CO_FiberRequest' AND EOF_Stato_Richiesta__c='Bozza Portale' AND EOF_Tipo_Comunicazione_String__c='Change Order' AND EOF_ID_Risorsa__c in :ListIdRisorse)or (recordtype.DeveloperName='PO_SA_FiberRequest' AND EOF_Tipo_Comunicazione_String__c='Cessazione')LIMIT :(integer)pageRecord
                                OFFSET :off];
    System.debug('**** Lista My!!! ' + listBozze);
    System.debug('**** OFFSET My!!! ' + off);
    //QUERY DATI FALSATI PER TEST!!
    //listBozze = [Select id,EOF_ID_Risorsa__c,EOF_STATO_ORDINE__c , EOF_PROFILO__c,EOF_Data_Ora_Creazione__c from EOF_EAI_Service_Log__c where  recordtype.DeveloperName='PO_CO_FiberRequest' limit 15 OFFSET:off];
    bozzeMap= new Map<Id,String>();
    for(EOF_EAI_Service_Log__c x: listBozze){
        if(x.EOF_Tipo_Comunicazione_String__c.equalsIgnoreCase('Change Order')){
            bozzeMap.put(x.id,'CO');
            
        }else{
            bozzeMap.put(x.id,x.EOF_ID_Risorsa__c);
            
        }
        idRis=x.EOF_ID_Risorsa__c;
    }
    listaBozzeWrapper= new List <BozzeWrapper>();
    for(EOF_EAI_Service_Log__c item : listBozze){ 
        BozzeWrapper temp= new BozzeWrapper();
        temp.id=item.id;
        temp.IDRisorsa=item.EOF_ID_Risorsa__c;
        temp.Profilo=item.EOF_PROFILO__c;
        temp.Stato=item.EOF_STATO_ORDINE__c;
        temp.DataAttivazione= string.valueOfGmt(item.EOF_Data_Ora_Creazione__c);
        if(item.EOF_Tipo_Comunicazione_String__c.equalsIgnoreCase('Change Order')){
            temp.tipoRichiesta='Change Order';
        }
        listaBozzeWrapper.add(temp);
    }
    system.debug('*****LISTBPP' +listBozze);
    System.debug('**** indexx!!! ' + index);  
}
}
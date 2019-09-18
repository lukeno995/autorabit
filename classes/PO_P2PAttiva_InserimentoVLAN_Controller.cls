//Created by LM 15/05/2019
public class PO_P2PAttiva_InserimentoVLAN_Controller { 
    public String recordOfferta {get;set;}
    public EOF_VLAN__c vlanObj {get;set;}
    public List<SelectOption>  optProfiloList {get;set;}
    public List<SelectOption>  optOpzioneList {get;set;}
    public List<SelectOption>  optOpzioneListFlexible {get;set;}
    public List<SelectOption>  optProfiloListFlexible {get;set;}
    public EOF_EAI_Service_Log__c childLog {get;set;}
    public String vlanModify {get;set;} 
    public String cLogId {get; set;}
    public String hiddenNameProfilo {get;set;}
    public String hiddenOpzioneProfilo {get;set;}
    public Boolean showSectionProfili{get;set;}
    public String optionValue {get;set;}
    public String profiloValue {get;set;}
    public Decimal pirCOS5 {get;set;}
    public Decimal cirCOS5 {get;set;}
    public Decimal pirCOS3 {get;set;}
    public Decimal cirCOS3 {get;set;}
    public Decimal pirCOS1 {get;set;}
    public Decimal cirCOS1 {get;set;}
    public Map<String,Id> rtMap {get;set;}   
    public EOF_EAI_Service_Log__c sLogVlan {get;set;}
    public Boolean isVlanModify{get;set;}
    public String tipoP2PAttiva {get;set;}
    public String vlanMod {get;set;}
    
    public  PO_P2PAttiva_InserimentoVLAN_Controller () {
        scegliProfilo();
        scegliOpzione();
        scegliOpzioneFlexible();
        scegliProfiloFlexible();
        showSectionProfili = false;
        isVlanModify = false;
        cLogId = ApexPages.currentPage().getParameters().get('cLogId');
        vlanModify =  ApexPages.currentPage().getParameters().get('vlan');
        tipoP2PAttiva=ApexPages.currentPage().getParameters().get('tipoP2Patt');
         sLogVlan = new EOF_EAI_Service_Log__c();

        if(cLogId != null){
            childLog=[SELECT id,EOF_PROFILO__c, EOF_SL_Riferimento__c, OF_PP_KIT_Log__c, kit_in_condivisione__c  
                      FROM EOF_EAI_Service_Log__c  
                      WHERE Id =: cLogId];
            if(vlanModify!=null && vlanModify =='modify'){
                isVlanModify = true;
                 sLogVlan=[SELECT id,PO_P2PAttiva_Opzione__c,OF_SA_PROFILO_VLAN__c,
                      COS5_PIR__c,COS5_CIR__c,COS3_PIR__c,COS3_CIR__c,
                      COS1_CIR__c,COS1_PIR__c
                      FROM EOF_EAI_Service_Log__c  
                      WHERE EOF_SL_Riferimento__c =:cLogId];
            }
           
        }
        List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
        rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        }  
        
        
    }
    
    public void scegliProfilo(){
        optProfiloList = new List<SelectOption>(); 
        optProfiloList.add(new SelectOption(' - ',' - '));
        optProfiloList.add(new SelectOption('3Play','3Play'));
        optProfiloList.add(new SelectOption('Voce e Dati','Voce e Dati'));
        optProfiloList.add(new SelectOption('Solo Dati','Solo Dati'));
    }
    public void scegliProfiloFlexible(){
        optProfiloListFlexible = new List<SelectOption>(); 
        optProfiloListFlexible.add(new SelectOption(' - ',' - '));
        optProfiloListFlexible.add(new SelectOption('3Play','3Play'));
        optProfiloListFlexible.add(new SelectOption('Voce e Dati','Voce e Dati'));
    }
    public void scegliOpzione(){
        optOpzioneList = new List<SelectOption>(); 
        optOpzioneList.add(new SelectOption(' - ',' - '));
        optOpzioneList.add(new SelectOption('Standard','Standard'));
    }
    public void scegliOpzioneFlexible(){
        optOpzioneListFlexible = new List<SelectOption>(); 
        optOpzioneListFlexible.add(new SelectOption(' - ',' - '));
        optOpzioneListFlexible.add(new SelectOption('Standard','Standard'));
        optOpzioneListFlexible.add(new SelectOption('Flexible','Flexible'));
    }
    
    public PageReference getRecordProfili(){
        isVlanModify = false;
        PageReference pg  = ApexPages.currentPage();
        System.debug('@@@Profilo'+hiddenNameProfilo);
        System.debug('@@@hiddenOpzioneProfilo'+hiddenOpzioneProfilo);
        String velocitaBanda=childLog.EOF_PROFILO__c;
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
        showSectionProfili = true;
        List<Configurazione_VLAN__c> cvVLANList = Configurazione_VLAN__c.getAll().values();
        String profilo =hiddenNameProfilo;
        String opzione=hiddenOpzioneProfilo;
        System.debug('@@@Profilo'+hiddenNameProfilo);
        System.debug('@@@Opzione'+hiddenOpzioneProfilo);
        for(Configurazione_VLAN__c cv : cvVLANList){
            if(opzione== cv.Opzione__c){
                if(profilo== cv.Profilo__c){
                    optionValue = cv.Profilo__c;
                    profiloValue = cv.Opzione__c;
                    System.debug('@@'+cv);
                    pirCOS5 = Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS5PIR__c)/100;
                    cirCOS5 =Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS5CIR__c)/100;
                    pirCOS3 = Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS3PIR__c)/100;
                    cirCOS3 = Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS3CIR__c)/100;
                    pirCOS1= Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS1PIR__c)/100;
                    cirCOS1= Decimal.valueOf(replaceVeloc) * Decimal.valueOf(cv.COS1CIR__c)/100;
                    System.debug('@@optionValue'+optionValue);
                    System.debug('@@profiloValue'+profiloValue);
                }
            }      
        }
        
        
        
        
        return pg;
    }     
    
    public PageReference insertVlanLog (){
        getRecordProfili();
        System.debug('@@@Profilo'+hiddenNameProfilo);
        System.debug('@@@Opzione'+hiddenOpzioneProfilo);
        PageReference pg = new PageReference('/PO_P2PAttiva_EditLogInfo');
        pg.getParameters().put('cLogId', childLog.Id);
         if( sLogVlan.OF_SA_PROFILO_VLAN__c ==' - '){
             sLogVlan.OF_SA_PROFILO_VLAN__c = 'Solo Dati';
        }
        List<EOF_EAI_Service_Log__c> list_vlanToUpsert = new List<EOF_EAI_Service_Log__c>();
       
        sLogVlan.recordtypeId=rtMap.get('OF_SA_Vlan');
        if(hiddenNameProfilo !='' && hiddenOpzioneProfilo !=''){
        if(hiddenNameProfilo =='3Play' && hiddenOpzioneProfilo =='Standard'){
            System.debug('@@else if 3play  Standard');
            sLogVlan.OF_SA_PROFILO_VLAN__c = hiddenNameProfilo;
            sLogVlan.PO_P2PAttiva_Opzione__c = hiddenOpzioneProfilo;
            sLogVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = 'MultiCos';
            sLogVlan.COS5_PIR__c = String.valueOf(pirCOS5);
            sLogVlan.COS5_CIR__c = String.valueOf(cirCOS5);
            sLogVlan.COS3_PIR__c = String.valueOf(pirCOS3);
            sLogVlan.COS3_CIR__c = String.valueOf(cirCOS3);
            sLogVlan.COS1_PIR__c = String.valueOf(pirCOS1);
            sLogVlan.COS1_CIR__c = String.valueOf(cirCOS1);
            sLogVlan.PO_PP_cos_remarking__c  ='NO';
            sLogVlan.PO_PP_dhcp_Option82__c = 'NO';
            sLogVlan.PO_PP_cos_class__c = 'COS5-COS3-COS1';
            
        }
        
        
        else if(hiddenNameProfilo =='3Play' && hiddenOpzioneProfilo =='Flexible'){
            System.debug('@@else if 3play  Flexible');
            sLogVlan.OF_SA_PROFILO_VLAN__c = hiddenNameProfilo;
            sLogVlan.PO_P2PAttiva_Opzione__c = hiddenOpzioneProfilo;
            sLogVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = 'MultiCos';
            sLogVlan.COS5_PIR__c = String.valueOf(pirCOS5);
            sLogVlan.COS5_CIR__c = String.valueOf(cirCOS5);
            sLogVlan.COS3_PIR__c = String.valueOf(pirCOS3);
            sLogVlan.COS3_CIR__c = String.valueOf(cirCOS3);
            sLogVlan.COS1_PIR__c = String.valueOf(pirCOS1);
            sLogVlan.COS1_CIR__c = String.valueOf(cirCOS1);
            sLogVlan.PO_PP_cos_remarking__c  ='NO';
            sLogVlan.PO_PP_dhcp_Option82__c = 'NO';
            sLogVlan.PO_PP_cos_class__c = 'COS5-COS3-COS1';
            
        }
        else if(hiddenNameProfilo =='Voce e Dati' && hiddenOpzioneProfilo =='Standard'){
            System.debug('@@else if Solo Voce e Dati Standard');
            sLogVlan.OF_SA_PROFILO_VLAN__c = hiddenNameProfilo;
            sLogVlan.PO_P2PAttiva_Opzione__c = hiddenOpzioneProfilo;
            sLogVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = 'MultiCos';
            sLogVlan.COS5_PIR__c = String.valueOf(pirCOS5);
            sLogVlan.COS5_CIR__c = String.valueOf(cirCOS5);
            sLogVlan.COS1_PIR__c = String.valueOf(pirCOS1);
            sLogVlan.COS1_CIR__c = String.valueOf(cirCOS1);
            sLogVlan.COS3_PIR__c = '0';
            sLogVlan.COS3_CIR__c = '0';
            sLogVlan.PO_PP_cos_remarking__c  ='NO';
            sLogVlan.PO_PP_dhcp_Option82__c = 'NO';
            sLogVlan.PO_PP_cos_class__c = 'COS5-COS1';
            
            
        }
        else if(hiddenNameProfilo =='Voce e Dati' && hiddenOpzioneProfilo =='Flexible'){
            System.debug('@@else if Solo Voce e Dati Flexible');
            sLogVlan.OF_SA_PROFILO_VLAN__c = hiddenNameProfilo;
            sLogVlan.PO_P2PAttiva_Opzione__c = hiddenOpzioneProfilo;
            sLogVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = 'MultiCos';
            sLogVlan.COS5_PIR__c = String.valueOf(pirCOS5);
            sLogVlan.COS5_CIR__c = String.valueOf(cirCOS5);
            sLogVlan.COS1_PIR__c = String.valueOf(pirCOS1);
            sLogVlan.COS1_CIR__c = String.valueOf(cirCOS1);
            sLogVlan.COS3_PIR__c = '0';
            sLogVlan.COS3_CIR__c = '0';
            sLogVlan.PO_PP_cos_remarking__c  ='NO';
            sLogVlan.PO_PP_dhcp_Option82__c = 'NO';
            sLogVlan.PO_PP_cos_class__c = 'COS5-COS1'; 
            
        } 
        else if(hiddenNameProfilo =='Solo Dati' && hiddenOpzioneProfilo =='Standard'){
            System.debug('@@else if Solo Dati Standard');
            sLogVlan.OF_SA_PROFILO_VLAN__c = hiddenNameProfilo;
            sLogVlan.PO_P2PAttiva_Opzione__c = hiddenOpzioneProfilo;
            sLogVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c = 'MultiCos';
            sLogVlan.COS1_PIR__c = String.valueOf(pirCOS1);
            sLogVlan.COS1_CIR__c = String.valueOf(cirCOS1);
            sLogVlan.COS5_PIR__c = '0';
            sLogVlan.COS5_CIR__c = '0';
            sLogVlan.COS3_PIR__c = '0';
            sLogVlan.COS3_CIR__c = '0';
            sLogVlan.PO_PP_cos_remarking__c  ='NO';
            sLogVlan.PO_PP_dhcp_Option82__c = 'NO';
            sLogVlan.PO_PP_cos_class__c = 'COS1';
            System.debug('@@@sLogVlan'+sLogVlan);
        }
        }
        sLogVlan.EOF_SL_Riferimento__c =cLogId;
        updateNomeKitConsegna(sLogVlan);
        list_vlanToUpsert.add(sLogVlan);
       
        upsert list_vlanToUpsert;
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    
    private void updateNomeKitConsegna(EOF_EAI_Service_Log__c sLogVlan) {
        List<EOF_EAI_Service_Log__c> list_sLogKit = new List<EOF_EAI_Service_Log__c>();    
        List<Id> kitIds = new List<Id>();

        if(childLog.OF_PP_KIT_Log__c != null) {
            kitIds.add(childLog.OF_PP_KIT_Log__c);
        } else if(childLog.kit_in_condivisione__c != null) {
            kitIds.add(childLog.kit_in_condivisione__c);
        }

        if(!kitIds.isEmpty()) {
            // cerco il kit (nuovo o in condivisione) associato al collegamento
            list_sLogKit = [SELECT PO_P2PAttiva_Nome_del_KIT__c 
                            FROM EOF_EAI_Service_Log__c 
                            WHERE Id IN: kitIds];
            
            sLogVlan.PO_P2PAttiva_Kit_Consegna_VLan__c = list_sLogKit[0].PO_P2PAttiva_Nome_del_KIT__c;
            sLogVlan.OF_SA_KIT_CONSEGNA_VLAN__c = list_sLogKit[0].PO_P2PAttiva_Nome_del_KIT__c;
            if(childLog.OF_PP_KIT_Log__c != null) {
                sLogVlan.OF_PP_KIT_Log__c = list_sLogKit[0].Id;
            }            
        }        
        
    }
    
    public pageReference annullavlan(){
        Pagereference pg= new PageReference(ApexPages.currentPage().getParameters().get('retUrl'));
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        pg.getParameters().put('cLogId',cLogId); 
        return pg;
    }
    
    
}
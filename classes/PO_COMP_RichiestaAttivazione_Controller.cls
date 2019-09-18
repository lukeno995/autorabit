public with sharing class PO_COMP_RichiestaAttivazione_Controller {
     public static EOF_EAI_Service_Log__c slOrig{get;set;}
     public EOF_EAI_Service_Log__c sl{get;set;}
     public boolean modifyMode{get;set;}
     public boolean insertMode{get;set;}
     public boolean Apparati{get;set;}
     public String DATA_PREVISTA_ATTIVAZIONE{get;set;}
     public Map<String,Id> rtMap;
     public string profiloCommerciale{get;set;}
     public string dataPrevistaAttivazione{get;set;}
    
     public boolean verifyProfilo{get;set;} //PG 2-02-2018
     public boolean viewError{get;set;}
     public boolean viewProfilo{get;set;}
     
     
     public PO_COMP_RichiestaAttivazione_Controller(){       
        modifyMode=false;
        insertMode=false;
        Apparati=false;
        profiloCommerciale='';
        
        verifyProfilo = true;
        viewError=false;
        viewProfilo=false;
         
        if(slOrig!=null){
            sl=slOrig;
            modifyMode=true;
            if(ApexPages.currentPage().getParameters().get('app') =='true'){
                Apparati=true;
            }
        }
        else{
            insertMode=true;
            User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
            sl = new EOF_EAI_Service_Log__c();
            List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
            rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                rtMap.put(rt.developerName, rt.Id); 
            } 
            
            sl.recordtypeId=rtMap.get('PO_SA_FiberRequest');
            sl.EOF_Stato_Richiesta__c='Bozza Portale';
            sl.EOF_CODICE_OPERATORE__c=attuale.Account.EOF_Codice_Operatore__c;
            sl.EOF_Tipo_Comunicazione_String__c='Attivazione';
        }
     }
       
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
    
    //GB 03-04-2018    
    public boolean verifyProfiloNew(String TextProfilo) {
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
                   
        If(objListino != null && objListino.IsPortalValid__c==true){
            verifyProfilo = true;
        }else{
            verifyProfilo = false;
        }      
        system.debug('verifyProfiloNewGB'+verifyProfilo);    
        return verifyProfilo;
    }
    
    public pageReference savesl(){
        //GB 03-04-2018
        if(!verifyProfiloNew(sl.EOF_PROFILO__c)){
            viewError=true;
            viewProfilo=false;
            return null; 
        }       
            try{
                //AS MODIFICA CALENDARIO
                //System.debug('### mt string date'  +dataPrevistaAttivazione);
                //sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=date.parse(dataPrevistaAttivazione);
                insert sl; 
            }
            catch(DMLexception e){
                ApexPages.addMessages(e); 
                return null;
            }
            PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
            pg.getParameters().put('proc','attivazioneInserita');
            pg.getParameters().put('origId',sl.Id);
            return pg;        
    }
    public pageReference annullaInsSl(){
        PageReference pg;
        if(insertMode){
            pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        }
        //aggiungo la condizione che se si arriva dal clona e annulla cancella tutti i slog
        else if(ApexPages.currentPage().getParameters().get('tipo') =='clona'){
            List<EOF_EAI_Service_Log__c> slListToDelete = [select id from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origID')
                                                            OR OF_SA_Cpe_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
                                                            OR OF_SA_VLAN_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
                                                            OR OF_SA_Servizi_Aggiuntivi_Log__c=:ApexPages.currentPage().getParameters().get('origID')];
            delete slListToDelete;
            pg = new PageReference('/PO_OpenStream_DisplayRequest');
        }
        else{
            pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
            pg.getParameters().put('proc','attivazioneInserita');
            pg.getParameters().put('origId',sl.Id);
        }
        return pg;
    }
    public pageReference updatesl(){
        //GB 03-04-2018
        if(!verifyProfiloNew(sl.EOF_PROFILO__c)){
            viewError=true;
            viewProfilo=false;
            return null; 
        }        
            try{
                if(ApexPages.currentPage().getParameters().get('tipo') =='clona'){
                    //aggiorno con il codice_ordine_OLO tutti i sl associati
                    List<EOF_EAI_Service_Log__c> slListToUpdate = [select id from EOF_EAI_Service_Log__c where OF_SA_Cpe_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
                                                                   OR OF_SA_VLAN_Log__c=:ApexPages.currentPage().getParameters().get('origID')  
                                                                   OR OF_SA_Servizi_Aggiuntivi_Log__c=:ApexPages.currentPage().getParameters().get('origID')];
                    slListToUpdate.add(sl);
                    update slListToUpdate;
                }
                else
                {
                    //AS MODIFICA CALENDARIO
                    //sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=date.parse(dataPrevistaAttivazione);
                    update sl;
                }
        }
        catch(DMLexception e)
        {
            ApexPages.addMessages(e);
            return null;
        }
        PageReference pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
        pg.getParameters().put('proc','attivazioneInserita');
        pg.getParameters().put('origId',sl.Id);
        return pg;
    }
}
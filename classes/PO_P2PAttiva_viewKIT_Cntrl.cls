public class PO_P2PAttiva_viewKIT_Cntrl {
    public String recordOfferta {get;set;}
    public EOF_EAI_Service_Log__c parentLogObj {get;set;} 
    public List<EOF_EAI_Service_Log__c> kitLogList {get;set;}
    public EOF_EAI_Service_Log__c kitLogEstratto {get;set;}
    public String kitId {get;set;}
    public String parentId {get;set;}
    
    public PO_P2PAttiva_viewKIT_Cntrl(){
        
        parentLogObj = new EOF_EAI_Service_Log__c();
        kitId = (ApexPages.currentPage().getParameters().get('kitId'));
        parentId = (ApexPages.currentPage().getParameters().get('parentId'));
        
        
        
        kitLogEstratto=  [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,
                          EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,
                          EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate, 
                          caso__r.ClosedDate,Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c, Caso__r.PO_Data_Attivazione_Richiesta__c, 
                          Caso__r.PO_Numero_Telefonico_PM__c,PO_Indirizzo_collegamento__c, EOF_Comune__c,EOF_ID_Pop__c,PO_P2PAttiva_Optical_Rate_Limiting__c,
                          PO_P2PAttiva_KIT_Indirizzo_Consegna__c,PO_P2PAttiva_Nome_del_KIT__c,Service_Attribute__c
                          FROM EOF_EAI_Service_Log__c 
                          WHERE ID =:(ApexPages.currentPage().getParameters().get('kitId'))];
        
        
    }
    
    public Pagereference TornaAlRiepilogo(){
        system.debug('@@@@@@@@@@@@@@@@EC chiamato il metodo TornaAlRiepilogo ');
        string kitId2 = (ApexPages.currentPage().getParameters().get('kitId'));
        string parentId2 = (ApexPages.currentPage().getParameters().get('parentId'));
        String tipoP2PAttiva = (ApexPages.currentPage().getParameters().get('tipoP2Patt'));
        system.debug('@@@@@@@@@@@@@@@@EC  string kitId2 ' + kitId2 + ', parentId2 ' + parentId2);
        system.debug('@@@@@@@@@@@EC kitId ' + kitId + ', parentId ' + parentId); 
        
        pagereference pg = new pagereference('/apex/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('parentId',parentId2);
        pg.getParameters().put('kitId',kitId2);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        pg.setRedirect(true);
        system.debug('@@@@@@@@@@@@@@@@EC Pagereference pg è ' + pg);
        
        return pg;
        
    }
    
    
}
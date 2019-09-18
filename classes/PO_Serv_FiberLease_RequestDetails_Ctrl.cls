public class PO_Serv_FiberLease_RequestDetails_Ctrl {
	public EOF_EAI_Service_Log__c sl {get;set;}
    public String recordOfferta {get;set;} 
    
    public PO_Serv_FiberLease_RequestDetails_Ctrl() {
        
        if (String.isNotBlank(ApexPages.currentPage().getParameters().get('parentId'))){
            
            
            
            system.debug('id pagina:' + ApexPages.currentPage().getParameters().get('parentId'));
            
            sl = [SELECT Id,Name,PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, Caso__r.Casenumber, EOF_STATO_ORDINE__c  
                 FROM EOF_EAI_Service_Log__c 
                 WHERE Id = :ApexPages.currentPage().getParameters().get('parentId')];
                 
            system.debug('id log:' + sl.id);     
        }

    }
    
    public pagereference BackToBeginning(){
    
        PageReference pg = new PageReference('/PO_Serv_FiberLease_Riepilogo');
        
        pg.getParameters().put('parentId', sl.id);
        
        return pg;
    }
    
    
}
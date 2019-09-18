global class OF_CallWSVerticaliBatch implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful {
    
    private Integer firstIndex;
    private Integer lastIndex;
    
    public OF_CallWSVerticaliBatch(Integer f, Integer l) {
        firstIndex = f;
        lastIndex = l;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // String query = 'Select id,Commercial_element_istanziato__c,EOF_ID_Notifica__c from EOF_Notify__c where OF_isElaborato__c = true and RecordType.DeveloperName =\'EOF_Bill_Asset\' limit 10000';
        String query = 'SELECT Id, Commercial_element_istanziato__c, Commercial_element_istanziato__r.Asset_Verticale__c, EOF_ID_Notifica__c, Asset__c FROM EOF_Notify__c '
            + ' WHERE OF_isElaborato__c = true AND RecordType.DeveloperName =\'EOF_Bill_Asset\' AND indice__c >= :firstIndex AND indice__c <= :lastIndex';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<EOF_Notify__c> scope) {
        
        for (EOF_Notify__c noti : scope) {
            Boolean res = SyncBillingAssetUtils.callWSAssetVerticaleByCei(noti.Commercial_element_istanziato__c,noti.EOF_ID_Notifica__c);
            // lo scope size è 1  quindi la query NON è in un ciclo For
            
            if(res)
            {
                List<OF_Billing_Element_Verticale__c> bevs = SyncBillingAssetUtils.getBEV(new List<string> {noti.Asset__c});
                List<OF_Asset_Verticale__c> verts = SyncBillingAssetUtils.getVErts(noti.Commercial_element_istanziato__r.Asset_Verticale__c);
                
                System.debug('@@@@ Faccio tutti gli update' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
                SyncBillingAssetUtils.UpdateAssetVert(verts);
                SyncBillingAssetUtils.UpdateBev(bevs);
            }
            
            noti.OF_isElaborato__c = false;
            noti.EOF_Inviata__c = true;
        }
        
        update scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}
global class OF_CallWSFattibilita implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful {
    
    private Integer firstIndex;
    private Integer lastIndex;
    
    public OF_CallWSFattibilita(Integer f, Integer l) {
        firstIndex = f;
        lastIndex = l;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {        
        String query = 'SELECT Id, Commercial_element_istanziato__c, EOF_ID_Notifica__c, Asset__c FROM EOF_Notify__c '
            + ' WHERE OF_isElaborato__c = true AND RecordType.DeveloperName =\'EOF_Bill_Asset\' AND indice__c >= :firstIndex AND indice__c <= :lastIndex';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<EOF_Notify__c> scope) {
        
        system.debug('@@@@@@secondo batch');
        // lo scope size è 1  quindi la query NON è in un ciclo For
        for (EOF_Notify__c noti : scope) {
            Boolean res = SyncBillingAssetUtils.callWSAssetVerticaleByCei(noti.Commercial_element_istanziato__c,noti.EOF_ID_Notifica__c);
            if(res)
            {

            }
            
            noti.OF_isElaborato__c = false;
            noti.EOF_Inviata__c = true;
        }
        
        update scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}
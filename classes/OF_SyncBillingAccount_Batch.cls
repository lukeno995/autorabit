global  class OF_SyncBillingAccount_Batch implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful{
    
    private String IdAccount;
    private String ActionType;
    
    public OF_SyncBillingAccount_Batch(String AccId, string Action) {
        IdAccount = AccId;
        ActionType = Action; 
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id,AccountNumber,RecordType.DeveloperName, Name,EOF_Codice_Operatore__c,OF_BillingSyncronized__c, BillingCity, BillingCountry, BillingEmail__c, BillingPostalCode, BillingState, BillingStreet, Status__c, StartDate__c, TaxationCode__c,VATNumber__c, PEC__c, Class__c, Industry from Account where Id = \'' + IdAccount + '\' LIMIT 1' ;
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {      
        for(Account acc : scope){
            SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
            wrp.acc=acc;
            wrp.action=ActionType; 
            SyncBillingAccountUtils.callWSAccount(wrp, ''); 
        }
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
    
}
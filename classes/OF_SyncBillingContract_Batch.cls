global  class OF_SyncBillingContract_Batch implements Database.AllowsCallouts,Database.Batchable<sObject>, Database.Stateful{
    
    private String IdContratto;
    private String ActionType;
    private String operationType;
    
    public OF_SyncBillingContract_Batch(String ConId, string Action, string Operation) {
        IdContratto = ConId;
        ActionType = Action;
        operationType = Operation;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Status,StartDate,Name, EndDate,ContractNumber,Account.AccountNumber,NS_Rif__c,OF_BillingSyncronized__c, SuspendedDate__c, OF_TermPayment__c, BillingFrequency__c, ContractTerm, OF_IdContratto__c  FROM contract where Id = \'' + IdContratto + '\' Limit 1' ;
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Contract> scope) { 
        
        system.debug('@@@@ scope : '+ scope);
        List<String> errors = new List<String>();
        List<SyncBillingContractUtils.Wrapper> Wrperrors = new List<SyncBillingContractUtils.Wrapper>();
        
        
        for(Contract con : scope){          
            
            SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
            wrp.con=con;
            wrp.action=ActionType; 
            wrp.operationType = operationType;
            string check = SyncBillingContractUtils.checkField(wrp);
            if(check.equals('true'))
            { 
                SyncBillingContractUtils.callWSContract(wrp, '');
            }
            else
            {
                Wrperrors.add(wrp);
                errors.add(check);
            }
        }
        //creare notifiche e log
        List<EOF_Notify__c> notif = SyncBillingContractUtils.createListNotify(Wrperrors); 
        SyncBillingContractUtils.createListLog(notif,errors, '', '', '','', '');
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
    
}
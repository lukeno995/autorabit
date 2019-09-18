global class DeleteReportVerticali implements Database.AllowsCallouts,Database.Batchable<sObject>,Database.Stateful  { 
    
    global String Error='';
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query ='select id from ReportVerticali__c';
        return Database.getQueryLocator(query);
    }
    
    
    global void execute(Database.BatchableContext BC, List<ReportVerticali__c> scope) {   
        try{
            delete scope;   
        }
        catch(Exception e)
        {
            Error='Errore: '+ e.getStackTraceString().abbreviate(3800)+'  MEssaggio: '+ e.getMessage();
        }
        
    }
    
    global void finish(Database.BatchableContext BC) {
        if(string.isBlank(Error) && !Test.isRunningTest())
        {
            BatchSendAssetVerticali sv = new BatchSendAssetVerticali();
            Database.executeBatch(sv);
        }
        else
        {
            sendEmail();
        }
    }
    
    @testVisible
    private void sendEmail(){
        Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
        List<string> toAddresses = new List<string> {verticaliCS.EmailAdmin__c};
        string subject = 'ERRORE EXPORT TO PNI';
        string textBody = Error;
        string fromEmail= [select id from OrgWideEmailAddress where DisplayName  =:verticaliCS.Email_from__c].id;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setOrgWideEmailAddressId(fromEmail); 
        email.setPlainTextBody(textBody);       
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
    }
    
}
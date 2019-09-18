@isTest
public class DeleteReportVerticali_Test {
    
    @testSetup
    public static void createVerticaliCustomSetting() {
        
        Verticali__c cs = new Verticali__c();
        cs.Name='test';
        cs.delayAlgoritmo__c = 1;
        cs.delayBonifica__c = 240;
        cs.Email__c = 'test@test.org';
        cs.Email_CC__c = 'test@test.org';
        cs.Email_from__c = 'Delivery Services Openfiber';
        cs.EmailAdmin__c= 'test@test.org';
        cs.emailSubject__c = 'subj';
        cs.giorniTolleranza__c = -2;
        cs.limitBatch__c = 10;
        cs.TextBody__c = 'text';
        
        insert cs;
    } 
    
    @isTest
    public static void MethodOK()
    {
        DeleteReportVerticali rv = new DeleteReportVerticali();
        rv.Error ='';
        
        ReportVerticali__c rep = new ReportVerticali__c();
        rep.Civico__c='1';
        insert rep;
        
        Database.BatchableContext BC = null;
        List<ReportVerticali__c> scope = [select id from ReportVerticali__c ];
        rv.execute(BC, scope);
    }
    
    @isTest
    public static void MethodKO()
    {
        DeleteReportVerticali rv = new DeleteReportVerticali();
        rv.Error ='KO';
        rv.sendEmail();
    }
    
    
}
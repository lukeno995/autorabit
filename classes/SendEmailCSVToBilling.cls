global class SendEmailCSVToBilling implements Schedulable,Database.AllowsCallouts{
    
    global String reportIstance ;
    global String reportId ;
    
    public SendEmailCSVToBilling (string repIstance, string RepId)
    {
        reportIstance = repIstance;
        reportId=RepId;
    }
    
    global void execute(SchedulableContext sc)
    {
        
        sendEmailTOPNI(ReportIstance,reportId);
    }
    
    @future(callout=true)
    public static void sendEmailTOPNI(String ReportIstance,string reportId){
        Reports.ReportInstance repIst = Reports.ReportManager.getReportInstance(ReportIstance);
        if('Success'.Equals(repIst.getStatus()))
        {   
            ApexPages.PageReference objPage = new ApexPages.PageReference('/'+reportId+'?csv=1');   
            Messaging.EmailFileAttachment objMsgEmailAttach = new Messaging.EmailFileAttachment();
            objMsgEmailAttach.setFileName('Testing.csv');
            objMsgEmailAttach.setBody(objPage.getContent());
            objMsgEmailAttach.setContentType('text/csv');
            sendEmail(objMsgEmailAttach);
        }
        else if('Error'.Equals(repIst.getStatus()))
        {
            system.debug('@@@ReportIstance: '+ ReportIstance +' è andato in errore');
        }
        else
        {    
            List<CronTrigger> ctr = [SELECT Id,cronJobDetail.Name FROM CronTrigger WHERE cronJobDetail.Name ='CheckReportBillingFinished'];
            for(CronTrigger c : ctr){ 
                system.abortJob(c.Id);
            } 
            SendEmailCSVToBilling b = new SendEmailCSVToBilling(reportIstance,reportId);
            system.schedule('CheckReportBillingFinished', GetCRONExpression(Datetime.now().addMinutes(10)), b);
        }
    }
    
    @TestVisible
    private static void sendEmail(Messaging.EmailFileAttachment objMsgEmailAttach){
        list<Messaging.EmailFileAttachment> atts = new list<Messaging.EmailFileAttachment>{objMsgEmailAttach};
            Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
        List<string> toAddresses = new List<string> {verticaliCS.Email__c};
            String Cc = verticaliCS.Email_CC__c;
        List<string> ccAddresses = new List<string>();
        if(string.isNotBlank(Cc)){
            ccAddresses.addAll(Cc.split(','));
        }            
        string subject = verticaliCS.emailSubject__c + System.now();
        string textBody = verticaliCS.TextBody__c;
        string textBody2 = verticaliCS.TextBody2__c; 
        string fromEmail= [select id from OrgWideEmailAddress where DisplayName  =:verticaliCS.Email_from__c].id;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setCCAddresses(ccAddresses);
        email.setOrgWideEmailAddressId(fromEmail); 
        email.setPlainTextBody(textBody + ' ' + textBody2 );
        email.setFileAttachments(atts);
        
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
    }
    
    private static String GetCRONExpression(Datetime dt) {
        return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
    }
}
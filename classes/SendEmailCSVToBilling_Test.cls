@isTest
public class SendEmailCSVToBilling_Test {
    
    @isTest(SeeAllData='true')
    public static void method1()
    {
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report where DeveloperName = 'Report_Verticali'];
        String reportId = (String)reportList.get(0).get('Id');
        Reports.ReportInstance instance = Reports.ReportManager.runAsyncReport(reportId, true);
        SendEmailCSVToBilling send = new SendEmailCSVToBilling(instance.getId(),reportId);
        SchedulableContext SC = null;
        send.execute(SC);
          
        Messaging.EmailFileAttachment objMsgEmailAttach = new Messaging.EmailFileAttachment();
        objMsgEmailAttach.setFileName('Testing.csv');
        objMsgEmailAttach.setBody(Blob.valueOf('test;Test'));
        objMsgEmailAttach.setContentType('text/csv');
        SendEmailCSVToBilling.sendEmail(objMsgEmailAttach);
    }
}
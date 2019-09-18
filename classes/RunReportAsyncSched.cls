global class RunReportAsyncSched implements Schedulable {
    global void execute(SchedulableContext SC){   
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report where DeveloperName = 'Report_Verticali'];
        String reportId = (String)reportList.get(0).get('Id');
        Reports.ReportInstance instance = Reports.ReportManager.runAsyncReport(reportId, true);
        List<CronTrigger> ctr = [SELECT Id,cronJobDetail.Name FROM CronTrigger WHERE cronJobDetail.Name ='CheckReportBillingFinished'];
        for(CronTrigger c : ctr){ 
            system.abortJob(c.Id);
        } 
        SendEmailCSVToBilling b = new SendEmailCSVToBilling(instance.getId(),reportId);
        system.schedule('CheckReportBillingFinished', GetCRONExpression(Datetime.now().addMinutes(10)), b);
    }
    private static String GetCRONExpression(Datetime dt) {
        return ('' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year());
    }     
}
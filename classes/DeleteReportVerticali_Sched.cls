global class DeleteReportVerticali_Sched implements Schedulable {
    
    global void execute(SchedulableContext SC){   
        DeleteReportVerticali DV = new DeleteReportVerticali();
        Database.executeBatch(DV,9000);
    }   
}
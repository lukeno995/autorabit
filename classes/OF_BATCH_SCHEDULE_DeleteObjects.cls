global class OF_BATCH_SCHEDULE_DeleteObjects implements Schedulable{
    global void execute(SchedulableContext SC){
    	OF_BATCH_DeleteObjects delObj = new OF_BATCH_DeleteObjects ();
		ID batchprocessid = Database.executeBatch(delObj,2000);  
    }
}
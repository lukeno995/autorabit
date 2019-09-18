global class OF_BATCH_SCHEDULE_BonificaOrdini implements Schedulable{
    global void execute(SchedulableContext SC){
    	OF_BATCH_BonificaOrdini bonifica = new OF_BATCH_BonificaOrdini ();
		ID batchprocessid = Database.executeBatch(bonifica,2000);  
    }
}
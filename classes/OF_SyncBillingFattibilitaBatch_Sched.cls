global class OF_SyncBillingFattibilitaBatch_Sched implements Database.AllowsCallouts,Schedulable{ 
    
    private List<string> AssetIds{get;set;}

	public OF_SyncBillingFattibilitaBatch_Sched(List<string> assID) {
		AssetIds = assID;
	}
    
    global void execute(SchedulableContext SC) {          
       OF_SyncBillingFattibilitaBatch batch = new OF_SyncBillingFattibilitaBatch(AssetIds);
       Database.executeBatch(batch);
    } 
    
    
}
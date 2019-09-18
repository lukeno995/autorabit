global class OF_SyncBillingAssetVerticale_Batch implements Database.AllowsCallouts,Schedulable{
    
    
    global void execute(SchedulableContext SC) {       
         
       OF_SyncBillingVerticaleBatch batch = new OF_SyncBillingVerticaleBatch(new List<string>());
       Database.executeBatch(batch);
    }
    
}
global class BatchSendAssetVerticali_sched implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        // We now call the batch class to be scheduled
        BatchSendAssetVerticali b = new BatchSendAssetVerticali ();
       
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b);
    }
   
}
//GB OK

global class OF_SyncCaseInviato_step1_Sched implements Schedulable {

  global void execute(SchedulableContext sc) {
    // We now call the batch class to be scheduled
    
    OF_SyncCaseInviato_step01_Batch b= new OF_SyncCaseInviato_step01_Batch();
    //Parameters of ExecuteBatch(context, BatchSize)
    Database.executeBatch(b, 1); //TODO
  }
      
}
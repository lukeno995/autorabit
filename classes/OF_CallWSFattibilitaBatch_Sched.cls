global class OF_CallWSFattibilitaBatch_Sched implements Schedulable {
    
    private Integer firstIndex;
    private Integer lastIndex;
    
    public OF_CallWSFattibilitaBatch_Sched(Integer f, Integer l) {
        firstIndex = f;
        lastIndex = l;
    }
    
    global void execute(SchedulableContext sc) {
        // We now call the batch class to be scheduled
        OF_CallWSFattibilita b = new OF_CallWSFattibilita(firstIndex, lastIndex);
        
        //Parameters of ExecuteBatch(context, BatchSize)
        Database.executeBatch(b, 1);
    }
}
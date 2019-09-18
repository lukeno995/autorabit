global class OF_PNI_Obsoleti_Batch_sched implements Schedulable {

	global void execute(SchedulableContext sc) {
		// We now call the batch class to be scheduled
		OF_PNI_Obsoleti_Batch b = new OF_PNI_Obsoleti_Batch();

		Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
		Integer scopeSize = verticaliCS.limitBatch__c.intvalue();

		//Parameters of ExecuteBatch(context,BatchSize)
		Database.executeBatch(b, scopeSize);
	}
}
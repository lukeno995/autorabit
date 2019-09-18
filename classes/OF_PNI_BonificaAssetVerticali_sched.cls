global class OF_PNI_BonificaAssetVerticali_sched implements Schedulable {

	global void execute(SchedulableContext sc) {
		// We now call the batch class to be scheduled
		OF_PNI_BonificaAssetVerticali_Batch b = new OF_PNI_BonificaAssetVerticali_Batch();

		Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
		Integer scopeSize = verticaliCS.step3ScopeSize__c.intValue();

		//Parameters of ExecuteBatch(context,BatchSize)
		database.executebatch(b, scopeSize);
	}
}
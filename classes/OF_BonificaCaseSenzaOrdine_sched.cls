global class OF_BonificaCaseSenzaOrdine_sched implements Schedulable {
    // Classe coperta da OF_BonificaCaseSenzaOrdine_Batch_Test
	global void execute(SchedulableContext sc) {
		BatchBonifiche__c cs = BatchBonifiche__c.getAll().get('BonificaCaseSenzaOrdine');
		Integer scopeSize = cs.SizeBatch__c.intvalue();
		Database.executeBatch(new OF_BonificaCaseSenzaOrdine_Batch(), scopeSize);
	}
}
global class Batch_CaseNoAsset_Sched implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        //BatchBonifiche__c cs = BatchBonifiche__c.getOrgDefaults();
        Batch_CaseNoAsset b = new Batch_CaseNoAsset ();
        BatchBonifiche__c cs = BatchBonifiche__c.getAll().get('BonificaCaseNoAsset'); 
        database.executebatch(b,cs.SizeBatch__c.intvalue());
    }
   
}
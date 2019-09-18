@isTest
public class OF_SyncBillingContract_Batch_Test {
    
    public static testMethod void test1()
     {
          
          string ActionType='Test';
          string operationType='Test';
          Database.BatchableContext BC;
          
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
         
         string IdContratto= (String)contratto.ID;
         List<Contract> scope = new List<Contract>();
         scope.add(contratto);
         
          OF_SyncBillingContract_Batch SBA1= new OF_SyncBillingContract_Batch(IdContratto,ActionType,operationType);
          SBA1.start(BC);
          SBA1.execute(BC, scope);
          SBA1.finish(BC);
         
     }


}
@isTest
public class OF_PNI_DeleteStaging_Batch_Test {
    
    public static OF_Staging_PNI__c stagingCreation()
    {
        OF_Staging_PNI__c stg = new OF_Staging_PNI__c();
        stg.OF_Comune__c='Napoli';
        insert stg;
        
        return stg;
    }

    private static testMethod void test_batch() {
    	   
    	    Test.startTest();
            OF_Staging_PNI__c stg2 = stagingCreation();
    
            DataBase.executeBatch(new OF_PNI_DeleteStaging_Batch());
            Test.stopTest();
            
        }
}
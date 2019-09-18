@isTest
public class OF_SyncBillingAccount_Batch_Test{
    @testSetup 
    public static void testSetUpData() {
    Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
    Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
    Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    
    }
    public static testMethod void OOF_SyncBillingAccount_BatchMethod(){
    Account acc1 = new Account();
    acc1.name = 'Test';
    acc1.StartDate__c = System.today();
    insert acc1;
    
    Test.startTest();
    String IdAccount = acc1.id;
    Database.QueryLocator QL;
    Database.BatchableContext BC;   
    Test.setMock(WebServiceMock.class, new OF_SyncBillingAccount_Batch_mock ());
    // Test.setMock(WebServiceMock.class, new OF_Billing_Outbound_Service_mock ());
    OF_SyncBillingAccount_Batch batc = new OF_SyncBillingAccount_Batch(acc1.id,'Test');
    Account acc = acc1;
    database.executeBatch(batc);
    ql = batc.start(BC);
    batc.finish(BC);
    Test.stopTest();
    }
}
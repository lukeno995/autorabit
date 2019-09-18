@isTest
public class OF_Billing_Outbound_Service_Test{
     @testSetup 
            public static void testSetUpData() {
                Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
                Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
                Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
                
            }
    public static testMethod void OF_Billing_Outbound_SchemaMethod(){
        Test.startTest();
        OF_Billing_Outbound_Service.BillingAccountManagerSOAP  accsoap = new  OF_Billing_Outbound_Service.BillingAccountManagerSOAP();
        Date dt = system.today();
        Test.setMock(WebServiceMock.class, new OF_Billing_Outbound_Service_mock ());
        accsoap.AccountManager('Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test');
        Test.stopTest();
    }
}
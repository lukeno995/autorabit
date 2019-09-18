@isTest
public class OF_Billing_Outbound_Service2_Test{
     @testSetup 
            public static void testSetUpData() {
                Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
                Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
                Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
                
            }
    public static testMethod void OF_Billing_Outbound_Schema2Method(){
        Test.startTest();
        OF_Billing_Outbound_Service2.BillingAgreementManagerSOAP accsoap = new  OF_Billing_Outbound_Service2.BillingAgreementManagerSOAP();
        Date dt = system.today();
        Test.setMock(WebServiceMock.class, new OF_Billing_Outbound_Service2_mock ());
        accsoap.AgreementManager('Test','Test','Test','Test','Test','Test','Test','Test','Test','Test',123,'Test','Test','Test','test');
        Test.stopTest();
    }
}
@isTest
public class OF_Billing_Outbound_Service3_Test {
    
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }

    public static testMethod void test(){
        
    Test.startTest(); 
    Test.setMock(WebServiceMock.class, new Billing_Outbound_Service3_Mock());
    OF_Billing_Outbound_Service3.BillingOrderManagerSOAP obj1 = new OF_Billing_Outbound_Service3.BillingOrderManagerSOAP();
    OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType obj2 = new OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType();
    OF_Billing_Outbound_Schema3.OrderItemType orderItem = new OF_Billing_Outbound_Schema3.OrderItemType();
          OF_Billing_Outbound_Schema3.OrderInstallmentDetailsType agree6 = new OF_Billing_Outbound_Schema3.OrderInstallmentDetailsType ();
    OF_Billing_Outbound_Schema3.OrderItemOtherType orderItemOther = new OF_Billing_Outbound_Schema3.OrderItemOtherType();
    OF_Billing_Outbound_Schema3.orderItemPrices_element orderItemPrices = new OF_Billing_Outbound_Schema3.orderItemPrices_element();
    obj1.OrderManager(orderItem, orderItemOther, orderItemPrices);
    obj1.OrderManager(orderItem, orderItemOther, orderItemPrices,agree6);
    Test.stopTest();
        
    }
}
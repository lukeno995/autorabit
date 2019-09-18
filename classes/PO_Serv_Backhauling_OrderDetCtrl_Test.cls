@isTest
private class PO_Serv_Backhauling_OrderDetCtrl_Test
{
    static testMethod void testMethod1() 
    {
        Test.startTest();
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();
        insert theLog;
        
        Case theCase = new Case();
        insert theCase;
        
        PageReference pageRef = Page.PO_Serv_Backhauling_OverviewOrder;
        pageRef.getParameters().put('orderLogId', theLog.Id);
        pageRef.getParameters().put('id', theCase.Id);
        Test.setCurrentPage(pageRef);
        
        PO_Serv_Backhauling_OrderDetails_Ctrl theController = new PO_Serv_Backhauling_OrderDetails_Ctrl();
        theController.GoBack();
        theController.DetailPage(); 
        
        Test.stopTest();
    }
}
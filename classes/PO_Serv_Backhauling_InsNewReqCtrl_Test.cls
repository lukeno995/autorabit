@isTest
private class PO_Serv_Backhauling_InsNewReqCtrl_Test
{
    static testMethod void testMethod1() 
    {
        Test.startTest();   
        
        PO_Serv_Backhauling_InsertNewReq_Ctrl theController = new PO_Serv_Backhauling_InsertNewReq_Ctrl();
        
        theController.DeleteParentCase();
        theController.toBackhauling();
        theController.uploadCSV();
        
        Test.stopTest();
    }
}
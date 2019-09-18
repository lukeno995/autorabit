@isTest
private class PO_Serv_P2PBase_InsertNewReq_Ctrl_Test {
     static testMethod void testMethod1() 
    {
        Test.startTest();   
        
        PO_Serv_P2PBase_InsertNewReq_Ctrl theController = new PO_Serv_P2PBase_InsertNewReq_Ctrl();
        
        theController.DeleteParentCase();
        theController.toP2PBase();
        theController.uploadCSV();
        
        Test.stopTest();
    }

}
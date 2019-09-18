@isTest
private class PO_Serv_FiberLink_InsertNewReq_Ctrl_Test {
    
      static testMethod void testMethod1() 
    {
        Test.startTest();   
        
        PO_Serv_FiberLink_InsertNewReq_Ctrl theController = new PO_Serv_FiberLink_InsertNewReq_Ctrl();
        
        theController.DeleteParentCase();
        theController.toFiberLink();
        theController.uploadCSV();
        
        Test.stopTest();
    }
    

}
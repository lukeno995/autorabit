@isTest
private class PO_Serv_BTS_OrderDetCtrl_Test {
    
     static testMethod void testMethod1() 
    {
        Test.startTest();
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();
        insert theLog;
        
        Case theCase = new Case();
        insert theCase;
        
        PageReference pageRef = Page.PO_Serv_BTS_OverviewOrder;
        pageRef.getParameters().put('orderLogId', theLog.Id);
        pageRef.getParameters().put('id', theCase.Id);
        Test.setCurrentPage(pageRef);
        
        PO_Serv_BTS_OrderDetails_Ctrl theController = new PO_Serv_BTS_OrderDetails_Ctrl();
        theController.recordOfferta='';
        theController.CaseDetail='';
        theController.offertEvento='';
        theController.cliente='';
        theController.cliente1='';
        theController.cliente2='';
        theController.ordercasedisplayordinedate='';
        theController.childDate='';
        theController.GoBack();
        theController.DetailPage(); 
        
        Test.stopTest();
    }

}
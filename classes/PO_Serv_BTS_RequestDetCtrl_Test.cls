@isTest
private class PO_Serv_BTS_RequestDetCtrl_Test {
    
     static testMethod void testMethod1() 
    {
        Test.startTest();  
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();        
        insert theLog;
        
		Case theCase = new Case();       
        theCase.PO_Data_Attivazione_Ordine__c = Date.today();
        insert theCase;        
        
        PageReference pageRef = Page.PO_Serv_BTS_Riepilogo;
        pageRef.getParameters().put('cLogId', theLog.Id);        
        pageRef.getParameters().put('parentId', theLog.Id);   
        pageRef.getParameters().put('CaseDetail', theCase.Id);           
        Test.setCurrentPage(pageRef);  
        
        PO_Serv_BTS_RequestDetails_Ctrl theController = new PO_Serv_BTS_RequestDetails_Ctrl();         
        
        theController.CaseDetail = theCase.Id;
        
        theController.BackToBeginning();
        theController.EditOrderInfo();
        theController.DetailPage();
        
        Test.stopTest();
    }

}
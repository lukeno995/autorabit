@isTest
private class PO_Result_Import_Controller_TEST {
	
	private static testMethod void test() 
	{
	    OF_Enable_PO_UpdateOppCase_Trigger__c po_updTr = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        po_updTr.Name = 'Status';
        po_updTr.OF_Enable_Trigger__c = false;
        insert po_updTr;
	    
	    Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');

	    Test.startTest();
	    
	    PO_Result_Import_Controller contr = new PO_Result_Import_Controller();
	    PageReference p = contr.annulla();
	    Test.stopTest();
	}
}
@isTest
private class PO_JunkCases_Controller_TEST {

	private static testMethod void test() 
	{
	    OF_Enable_PO_UpdateOppCase_Trigger__c po_updTr = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        po_updTr.Name = 'Status';
        po_updTr.OF_Enable_Trigger__c = false;
        insert po_updTr;
	    
	    Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
	    
	    Case c1 = new Case();
	    c1.status = 'Accettato';
	    Case c2 = new Case();
	    c2.status = 'Acquisito';
	    List<Case> caseList = new List<Case>();
	    caseList.add(c1);
	    caseList.add(c2);
	    insert caseList;
	    
	    Test.startTest();
	    ApexPages.currentPage().getParameters().put('parentID',c1.id);
	    PO_JunkCases_Controller contr = new PO_JunkCases_Controller();
	    PageReference p = contr.annulla();
	    Test.stopTest();
	}

}
@isTest
private class PO_CeD_EditActionController_TEST {

    public static Account tiscaliAccountCreation()
    {
        Account a = new Account();
        a.name = 'Tiscali';
        a.EOF_Codice_Operatore__c = 'TIS';
        insert a;
        return a;
    }
    
    public static Case caseCreation(Account acc)
    {
        Case c = new Case();
        c.subject = 'Richiesta Attivazione';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        c.EOF_Note_Appuntamento__c = 'Note';
        insert c;
        return c;
    }
    
    public static testmethod void test_method1()
    {
        Account a = tiscaliAccountCreation();
        Case c1 = caseCreation(a);
        
        Test.StartTest();
    	PageReference pageRef = page.PO_CeD_EditActionPage;
    	pageRef.getParameters().put('Id',c1.Id);
    	Test.setCurrentPageReference(pageRef);	    	
        ApexPages.StandardController sc = new ApexPages.StandardController(c1);
        PO_CeD_EditActionController edit_ctrl = new PO_CeD_EditActionController(sc);
        edit_ctrl.aggiornaDati();
        edit_ctrl.annulla();
        Test.stopTest();
    }
}
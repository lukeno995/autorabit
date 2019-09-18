@isTest
private class PO_TP_EditFieldsCase_TEST {

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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        Case c = new Case();
        c.Subject = 'Incident Management';
        c.Status = 'Acquisito';
        c.PO_TP_causale_apertura_segnalazione__c = 'Problema tecnico/applicativo';
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.Origin = 'Portal';
        insert c;
        return c;
    }
    
    public static testmethod void test_method1()
    {
        Account a = tiscaliAccountCreation();
        Case c1 = caseCreation(a);
        
        Test.StartTest();
    	PageReference pageRef = page.PO_TP_EditFieldsCase_page;
    	pageRef.getParameters().put('Id',c1.Id);
    	Test.setCurrentPageReference(pageRef);	    	
        ApexPages.StandardController sc = new ApexPages.StandardController(c1);
        PO_TP_EditFieldsCase edit_ctrl = new PO_TP_EditFieldsCase(sc);
        //PageReference pageRef2 = edit_ctrl.aggiornaDati();
        PageReference pageRef3 = edit_ctrl.annulla();
        Test.stopTest();
    }

}
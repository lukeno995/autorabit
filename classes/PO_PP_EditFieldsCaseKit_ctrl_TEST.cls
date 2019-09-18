@isTest
public class PO_PP_EditFieldsCaseKit_ctrl_TEST {
    
    public static Account tiscaliAccountCreation()
    {
        Account a = new Account();
        a.name = 'Tiscali';
        a.EOF_Codice_Operatore__c = 'TIS';
        insert a;
        return a;
    }
    
    public static Case caseKitCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.PO_PP_POP__c = 'POP_01';
        c.PO_PP_Traffico__c = 'VULA Openstream Direct';
        c.PO_PP_Banda__c = '400';
        c.PO_PP_Interfaccia_Kit__c = '10 Giga';
        c.subject = 'Richiesta Attivazione KIT';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }
    
    public static testmethod void test_method1()
    {
        Account a = tiscaliAccountCreation();
        Case c1 = caseKitCreation(a);
        
        Test.StartTest();
    	PageReference pageRef = page.PO_PP_EditFieldsCaseKit;
    	pageRef.getParameters().put('Id',c1.Id);
    	Test.setCurrentPageReference(pageRef);	    	
        ApexPages.StandardController sc = new ApexPages.StandardController(c1);
        PO_PP_EditFieldsCaseKit edit_ctrl = new PO_PP_EditFieldsCaseKit(sc);
        //PageReference pageRef2 = edit_ctrl.aggiornaDati();
        PageReference pageRef3 = edit_ctrl.annulla();
        Test.stopTest();
    }

}
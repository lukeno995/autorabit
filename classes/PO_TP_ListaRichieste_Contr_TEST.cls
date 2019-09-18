@isTest
public class PO_TP_ListaRichieste_Contr_TEST {
    
    static testmethod void test_method()
    {   
        Test.startTest();    
        PageReference pageRef = page.PO_TP_DisplayRequest;               
        Test.setCurrentPageReference(pageRef);
        PO_TP_ListaRichieste_Controller contr = new PO_TP_ListaRichieste_Controller();  
        Test.stopTest();
    }
}
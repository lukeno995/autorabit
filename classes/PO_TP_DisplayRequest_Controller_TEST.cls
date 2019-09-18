@isTest
public class PO_TP_DisplayRequest_Controller_TEST {
    
    static testmethod void test_method()
    {   
        Test.startTest();    
        PageReference pageRef1 = page.PO_TP_DisplayRequest;  
        pageRef1.getParameters().put('azione','Provisioning');
        Test.setCurrentPageReference(pageRef1);
        PO_TP_DisplayRequest_Controller contr1 = new PO_TP_DisplayRequest_Controller ();  
        contr1.tipo_filtro = 'Segnalazione Provisioning';
        
        PageReference pageRef2 = page.PO_TP_DisplayRequest;
        pageRef2.getParameters().put('azione','Incident');
        Test.setCurrentPageReference(pageRef2);
        PO_TP_DisplayRequest_Controller contr2 = new PO_TP_DisplayRequest_Controller ();  
        contr2.tipo_filtro = 'Problema tecnico/applicativo';
        
        Test.stopTest();
    }
}
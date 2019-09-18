@isTest
public class PO_TP_Service_Controller_TEST {
    
    static testmethod void test_method()
    {       
        PageReference pageRef = page.PO_TP_InsertNewRequest;               
        pageRef.getParameters().put('proc','TPVisualizza');
        Test.setCurrentPageReference(pageRef);
        PO_TP_Service_Controller tps = new PO_TP_Service_Controller();

        PageReference pageRef0 = page.PO_TP_InsertNewRequest;               
        pageRef0.getParameters().put('proc','TPVisualizzaIncident');
        Test.setCurrentPageReference(pageRef0);
        PO_TP_Service_Controller tps0 = new PO_TP_Service_Controller();        
        
        PageReference pageRef1 = page.PO_TP_InsertNewRequest;               
        pageRef1.getParameters().put('azione','Provisioning');
        Test.setCurrentPageReference(pageRef1);
        PO_TP_Service_Controller tps1 = new PO_TP_Service_Controller();

        PageReference pageRef2 = page.PO_TP_DisplayRequest;               
        pageRef2.getParameters().put('azione','Incident');
        Test.setCurrentPageReference(pageRef2);
        PO_TP_Service_Controller tps2 = new PO_TP_Service_Controller();
    }
}
@isTest
public class PO_Servizi_Fattibilita_Routing_Ctrl_Test {
    
    public static testmethod void test_method1(){
        Test.setCurrentPage(Page.PO_Servizi_Fattibilita_Routing);
        ApexPages.currentPage().getParameters().put('id','idcase1');
        ApexPages.currentPage().getParameters().put('off','P2PBase'); 
        ApexPages.currentPage().getParameters().put('method','save');
        
        test.startTest();
        PO_Servizi_Fattibilita_Routing_Ctrl ctrl = new PO_Servizi_Fattibilita_Routing_Ctrl();
			ctrl.routeRequest();
        test.stopTest();
    }
    public static testmethod void test_method2(){
        Test.setCurrentPage(Page.PO_Servizi_Fattibilita_Routing);
        ApexPages.currentPage().getParameters().put('parentId','idcase1');
        ApexPages.currentPage().getParameters().put('off','P2PBase'); 
        ApexPages.currentPage().getParameters().put('method','Nosave');
        
        test.startTest();
        PO_Servizi_Fattibilita_Routing_Ctrl ctrl = new PO_Servizi_Fattibilita_Routing_Ctrl();
			ctrl.routeRequest();
        test.stopTest();
    }
}
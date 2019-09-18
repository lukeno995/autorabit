@isTest
public class PO_P2PAttiva_Cessazione_CTest {
	@isTest
    public static void testMethod1(){        
        PO_P2PAttiva_Cessazione_Controller cntrl = new PO_P2PAttiva_Cessazione_Controller();
        cntrl.savesl();
        cntrl.annullaInsSl();
        cntrl.updatesl();
    }
    static testMethod void testMethod2(){
        EOF_EAI_Service_Log__c sLog = new EOF_EAI_Service_Log__c();
        insert sLog;
        
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_Cessazione);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('parentId', sLog.Id);
        PO_P2PAttiva_Cessazione_Controller ctrl = new PO_P2PAttiva_Cessazione_Controller();
        ctrl.sl = sLog;
        ctrl.savesl();
        Test.stopTest();
    }
}
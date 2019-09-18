@isTest
public class OF_SA_WS_IN_OLO_Deactivation_Test {
    
    static testMethod void OF_SA_WS_IN_OLO_DeactivationTest()
    {         
       OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest OLO_DeactREQ = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest(); 
        Test.startTest();
        OF_SA_WS_IN_OLO_Deactivation.OLO_Deactivation(OLO_DeactREQ);
        Test.stopTest();       
    }

}
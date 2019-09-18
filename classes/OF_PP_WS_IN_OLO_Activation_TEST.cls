@isTest
private class OF_PP_WS_IN_OLO_Activation_TEST {

	private static testMethod void test() 
	{
	    Test.startTest();
	    OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest kit_act = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
    	OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse actResp = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse(); 
	    OF_PP_WS_IN_OLO_Activation.OLO_Activation(kit_act);
	    Test.stopTest();
	}
}
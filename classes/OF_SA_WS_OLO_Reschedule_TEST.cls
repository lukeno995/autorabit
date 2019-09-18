@isTest
public class OF_SA_WS_OLO_Reschedule_TEST {
    testMethod static void testOF_SA_WS_OLO_Response(){
	
	TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'FiberRequest', null);        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_WS_OLO_Reschedule.NotifyPortTypeEndpoint ofee = new OF_SA_WS_OLO_Reschedule.NotifyPortTypeEndpoint();
        OF_SA_WS_OLO_Response.Esito_element ofre = new OF_SA_WS_OLO_Response.Esito_element();
        
        ofee.NotifyRischedulazione(TestDataFactory.ESlog[0]);
		test.stopTest();
    }


}
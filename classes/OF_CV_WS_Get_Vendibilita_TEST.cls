@isTest
private class OF_CV_WS_Get_Vendibilita_TEST {

	private static testMethod void test_GetVendibilita() {
	    
	    OF_Puntamento_Callout__c puntamento = new OF_Puntamento_Callout__c();
        puntamento.Name='OGW';
        puntamento.OF_OGW__c='OFS-SVIL-WS';
        insert puntamento;

        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_CV_WS_Mockupcls());	
        
        OF_CV_WS_Get_Vendibilita.GetVendibilitaEndpoint ws_Vend = new OF_CV_WS_Get_Vendibilita.GetVendibilitaEndpoint();
        OF_CV_WS_Schema_Get_Vendibilita.GetVendibilitaResponseType response = ws_Vend.GetVendibilita(String.valueOf(DateTime.now().getTime()),'VF','PASSIVO');
        
        Test.stopTest();
	}
}
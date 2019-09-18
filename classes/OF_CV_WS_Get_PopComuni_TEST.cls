@isTest
private class OF_CV_WS_Get_PopComuni_TEST {

	private static testMethod void test_GetComuniFromPop() {
	    
	    OF_Puntamento_Callout__c puntamento = new OF_Puntamento_Callout__c();
        puntamento.Name='OGW';
        puntamento.OF_OGW__c='OFS-SVIL-WS';
        insert puntamento;
	    
	    List<POP__c> pops = [Select id, name
                            from POP__c 
                            limit 5];
                            
        List<String> nomi_pop = new List<String>();
        
        for(POP__c p : pops){
            nomi_pop.add(p.name);
        }
	    
	    test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_CV_WS_Mockupcls());	
        OF_CV_WS_Schema_Get_PopComuni.ListaPopType listPops = new OF_CV_WS_Schema_Get_PopComuni.ListaPopType();
        listPops.POP = nomi_pop;
        OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint ws_PopC = new OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint();
        OF_CV_WS_Schema_Get_PopComuni.GetComuniFromPopResponseType response = ws_PopC.GetComuniFromPop(String.valueOf(DateTime.now().getTime()), listPops);

        test.stopTest();
	}
	
	private static testMethod void test_GetPop() {
	    
	    OF_Puntamento_Callout__c puntamento = new OF_Puntamento_Callout__c();
        puntamento.Name='OGW';
        puntamento.OF_OGW__c='OFS-SVIL-WS';
        insert puntamento;
	    
	    test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_CV_WS_Mockupcls());	
        
        OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint ws_PopC = new OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint();
        OF_CV_WS_Schema_Get_PopComuni.GetPopResponseType  response = ws_PopC.GetPop(String.valueOf(DateTime.now().getTime()));

        test.stopTest();
	}
}
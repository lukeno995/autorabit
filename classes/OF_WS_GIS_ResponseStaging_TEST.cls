@isTest
private class OF_WS_GIS_ResponseStaging_TEST {

	private static testMethod void test() {
	    
	    Test.startTest();
	    
	    OF_WS_GIS_ResponseStaging.GIS_Obsoleto ob = new OF_WS_GIS_ResponseStaging.GIS_Obsoleto();
        
        ob.NUMERO_CIVICO = '12';
        ob.COMUNE = 'Napoli';
        ob.ID_BUILDING = 'ID_001';
        ob.ID_BUILDING_SCALA_PALAZZINA = 'ID_DB_001';
        ob.IDR_SCALA = 'ID_GI_001';
        ob.ID_RISORSA = 'ID_RIS_001';
        ob.INDIRIZZO = 'Meridionale';
        ob.PARTICELLA_TOPONOMASTICA = 'Corso';
        
        List<OF_WS_GIS_ResponseStaging.GIS_Obsoleto> list_obs = new List<OF_WS_GIS_ResponseStaging.GIS_Obsoleto>();
        list_obs.add(ob);
	    
	    Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    OF_WS_GIS_ResponseStaging.GIS_Obsoleto_response resp =  new OF_WS_GIS_ResponseStaging.GIS_Obsoleto_response();
        resp = OF_WS_GIS_ResponseStaging.OF_GetVerticali(list_obs);
	    
	    Test.stopTest();
	}
}
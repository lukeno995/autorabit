@isTest
private class OF_WS_PNI_ResponseStaging_TEST {

	private static testMethod void test() {
	    
	    Test.startTest();
	    
	    OF_WS_PNI_ResponseStaging.PNI_Obsoleto ob = new OF_WS_PNI_ResponseStaging.PNI_Obsoleto();
        ob.OF_CIVICO = '12';
        ob.OF_COMUNE = 'Napoli';
        ob.OF_ID_BUILDING = 'ID_001';
        ob.OF_ID_DB_SCALA_PALAZZINA = 'ID_DB_001';
        ob.OF_ID_GIS_SCALAPALAZZINA = 'ID_GI_001';
        ob.OF_ID_PALAZZINA = 'ID_P_001';
        ob.OF_ID_RISORSA = 'ID_RIS_001';
        ob.OF_INDIRIZZO = 'Meridionale';
        ob.OF_PALAZZINA = 'E4';
        ob.OF_PARTICELLA_TOPONOMASTICA = 'Corso';
        ob.OF_SCALA = 'A';
        ob.OF_SCALA_PALAZZINA = 'A12';
        ob.OF_UI_SCALA_PALAZZINA = 'A1234';
        
        List<OF_WS_PNI_ResponseStaging.PNI_Obsoleto> list_obs = new List<OF_WS_PNI_ResponseStaging.PNI_Obsoleto>();
        list_obs.add(ob);
	    
	    Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    OF_WS_PNI_ResponseStaging.PNI_Obsoleto_response resp =  new OF_WS_PNI_ResponseStaging.PNI_Obsoleto_response();
        resp = OF_WS_PNI_ResponseStaging.OF_GetVerticali(list_obs);
	    
	    Test.stopTest();
	}
}
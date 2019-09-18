@isTest
private class OF_CV_Regole_Utils_TEST {

	private static testMethod void test_inserisciRegola() {
    
        Boolean isComunePop = true;
        Boolean isBozzaF = false;
        Boolean isBozzaT = false;
        String olo = 'TIS';
        String servizio = 'Passivo';
        String stato = '100';
        String buildingBL = '122;40';
        String idScalaBL = '2;3';
        String codStradaBL = '1A;2B';
        
        List<String> pop_comuni = new List<String>();
        pop_comuni.add('POP_01/Napoli');
        pop_comuni.add('POP_02/Roma');
        pop_comuni.add('POP_03/Torino');
        pop_comuni.add('POP_04/Milano');
        
        Test.startTest();
        
        OF_CV_Regole_Utils.inserisciRegola(isComunePop, pop_comuni, olo, servizio, stato, buildingBL, idScalaBL, codStradaBL, isBozzaF);
        OF_CV_Regole_Utils.inserisciRegola(isComunePop, pop_comuni, olo, servizio, stato, buildingBL, idScalaBL, codStradaBL, isBozzaT);

        Test.stopTest();
	}
	
	private static testMethod void test_modificaRegola() {
    
        Boolean isComunePop = true;

        OF_CV_Regole_Vendita__c regola = new OF_CV_Regole_Vendita__c();
        regola.Id_Regola__c = 'Regola1';
        regola.Codice_OLO__c = 'VF';
        regola.isAttiva__c = true;
        regola.Servizio__c = 'ATTIVO';
        regola.stato__c = '100';
        regola.Riga__c = 2;
        regola.Pop__c = 'POP_01';
        regola.isBozza__c = false;
        insert regola;
        
        Test.startTest();
        
        List<String> pop_comuni = new List<String>();
        pop_comuni.add(regola.Pop__c);

        OF_CV_Regole_Utils.modificaRegola(regola.id_Regola__c, isComunePop, pop_comuni, regola.Codice_OLO__c, regola.Servizio__c, regola.stato__c, null, null, null, regola.isBozza__c);

        Test.stopTest();
	}
	
	private static testMethod void test_clonaRegola() {
    
        Boolean isComunePop = true;

        OF_CV_Regole_Vendita__c regola = new OF_CV_Regole_Vendita__c();
        regola.Id_Regola__c = 'Regola1';
        regola.Codice_OLO__c = 'VF';
        regola.isAttiva__c = true;
        regola.Servizio__c = 'ATTIVO';
        regola.stato__c = '100';
        regola.Riga__c = 2;
        regola.Pop__c = 'POP_01';
        regola.isBozza__c = false;
        insert regola;
        
        List<String> pop_comuni = new List<String>();
        pop_comuni.add(regola.Pop__c);  
        Test.startTest();
        
        OF_CV_Regole_Utils.clonaRegola(regola.Id_Regola__c, 'TIS', 'PASSIVO', regola.Servizio__c, regola.Codice_OLO__c);
        
        Test.stopTest();
	}
	
	private static testMethod void test_getVendibilitaByWs() {
	    
	    OF_Puntamento_Callout__c puntamento = new OF_Puntamento_Callout__c();
        puntamento.Name='OGW';
        puntamento.OF_OGW__c='OFS-SVIL-WS';
        insert puntamento;

        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_CV_WS_Mockupcls());	
        OF_CV_WS_Get_Vendibilita.GetVendibilitaEndpoint ws_Vend = new OF_CV_WS_Get_Vendibilita.GetVendibilitaEndpoint();
        OF_CV_Regole_Utils.getVendibilitaByWs('VF','ATTIVO');
        
        Test.stopTest();
	}
	
	private static testMethod void test_getPopByWs() {
	   
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
        OF_CV_Regole_Utils.getPopByWs();
	}
	
	private static testMethod void test_getComuniPopByWs() {
	   
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
        
        OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint ws_PopC = new OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint();
        OF_CV_Regole_Utils.getComuniPopByWs(nomi_pop);

        test.stopTest();
	}

}
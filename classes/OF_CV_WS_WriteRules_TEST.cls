@isTest
private class OF_CV_WS_WriteRules_TEST {

	private static testMethod void test_WriteRules() {
	    
	    OF_Puntamento_Callout__c puntamento = new OF_Puntamento_Callout__c();
        puntamento.Name = 'OGW';
        puntamento.OF_OGW__c = 'OFS-SVIL-WS';
        insert puntamento;
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_CV_WS_Mockupcls());	
        
        OF_CV_WS_WriteRules.WriteRulesEndpoint ws_wr = new OF_CV_WS_WriteRules.WriteRulesEndpoint();
        OF_CV_WS_Schema_WriteRules.RIGA_element riga = new OF_CV_WS_Schema_WriteRules.RIGA_element();
        riga.ID_RIGA = '0';
        riga.OLO = 'VF';
        riga.SERVIZIO = 'ATTIVO';
        riga.POP = 'POP01';
        riga.COMUNE = 'Napoli';
        riga.STATO = '100';
        riga.ATTIVA = '';
        //Parametri metodo(String ID_REQUEST,String ID_REGOLA,OF_CV_WS_Schema_WriteRules.LISTA_RIGHE_REGOLA_element LISTA_RIGHE_REGOLA)
        OF_CV_WS_Schema_WriteRules.LISTA_RIGHE_REGOLA_element listaRigheRegole = new OF_CV_WS_Schema_WriteRules.LISTA_RIGHE_REGOLA_element();
        listaRigheRegole.RIGA = new List<OF_CV_WS_Schema_WriteRules.RIGA_element>();
        listaRigheRegole.RIGA.add(riga);
        OF_CV_WS_Schema_WriteRules.WriteRulesResponseType response = ws_wr.WriteRules(String.valueOf(DateTime.now().getTime()),'Regola0',listaRigheRegole);
        
        Test.stopTest();
    }
}
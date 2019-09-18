public without sharing class PO_ServiziFattDOMOrdineHandler extends PO_ServiziFattDOM {
    public PO_ServiziFattDOMOrdineHandler(String rTypeDevName) {
        super(rTypeDevName);
    }

    public override Id espletamentoOK(Case theCase) {
        theCase.Status = ESPLETATO_OK;
		theCase.EOF_Fase__c = ESPLETATO_OK;
		theCase.PO_Data_Espletamento_Ordine__c  = System.today();
        theCase.OF_AggiornoOrdine__c = true;
        update theCase;
        System.debug('##### PO_ServiziFattDOMOrdineHandler.espletamentoOK - case updated ' + theCase.Id);
        return espletamento(theCase, true);
    }

    public override Id espletamento(Case theCase, Boolean esitoOK) {
        System.debug('##### PO_ServiziFattDOMOrdineHandler.espletamentoOK - START');
        Order orderr = chiusuraOrdine(theCase);
        System.debug('##### PO_ServiziFattDOMOrdineHandler.espletamentoOK - ordine chiuso: ' + orderr.Id);

        Map<String, Id> map_rTypeDevNameId = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
        String name = String.isNotBlank(orderr.OF_IDRisorsa__c) ? orderr.OF_IDRisorsa__c : orderr.OF_IDOrdineEOF__c;
        System.debug('##### PO_ServiziFattDOMOrdineHandler.espletamentoOK - asset name: ' + orderr.Id);
        
        Asset assett = createAsset(orderr, map_rTypeDevNameId.get(srvData.assetDevName__c), name, theCase, orderr.Contract.OF_Rinnovabile__c);
        System.debug('##### PO_ServiziFattDOMOrdineHandler.espletamentoOK - asset creato: ' + assett.Id);

        List<OpportunityLineItem> oppLinItemList = [SELECT Id, OpportunityId, Opportunity.RecordType.DeveloperName, Price_Book__c, 
            Product2Id, Price_Book__r.OF_Listino__r.Name, Price_Book__r.PO_Commercial_element__c, Price_Book__r.Billing_element__r.Name, 
            Price_Book__r.Billing_element__c, Quantity, UnitPrice
			FROM OpportunityLineItem
			WHERE Opportunity.PO_Collegamento__c = :theCase.PO_Case_Collegamento__c 
            AND Price_Book__c != null 
            AND Price_Book__r.OF_Listino__r.Servizio__r.Name = :servizio
            AND Price_Book__r.PO_Commercial_element__r.Name = : ORDINE_COMMERCIAL_EL_NAME];
        System.debug('##### PO_ServiziFattDOMOrdineHandler.espletamentoOK  -- oppLinItemList from query : ' + oppLinItemList);        

        createBEI(assett, map_rTypeDevNameId.get(srvData.ceiDevName__c), oppLinItemList);
        System.debug('##### PO_ServiziFattDOMOrdineHandler.espletamentoOK - END');

        update theCase;
        //aggiornaLog(theCase);
        return assett.Id;
    }
}
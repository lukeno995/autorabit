@isTest
private class PO_PP_CRMHandler_TEST {
    
     
	public static Account accountCreation(){

		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Phone = '081861784512';
        acc.EOF_Phone_2__c = '081861784512';
        acc.EOF_Provincia__c = 'Napoli';
        acc.EOF_Comune__c = 'Napoli';
        acc.EOF_Indirizzo__c = 'Piazza Plebiscito';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Codice_Operatore__c='TIS';
        acc.EOF_Numero_Civico__c = '71';        
        insert acc;

        return acc;
	}
    
    public static Case caseKitCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.OF_SA_Profilo__c = 'AG_11_36';
        c.EOF_Codice_Operatore_WS__c='TIS';
        c.accountId = acc.id;
        c.Status = 'Espletato';
        insert c;
        return c;
    }
    
    public static Case caseVlanCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning VLAN').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.OF_SA_Profilo__c = 'AG_11_36';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }
    
    public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo;
	    return catalogo;
    }
    
    public static OF_Servizio__c ServizioPP_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'PREPROVISIONING';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio;
	    servizio.OF_DataFineValidita__c = fine;
	    servizio.OF_CatalogoCommerciale__c = cat.id;
	    insert servizio;
	    return servizio;
    }
    
 /*   public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio;
	    servizio.OF_DataFineValidita__c = fine;
	    servizio.OF_CatalogoCommerciale__c = cat.id;
	    insert servizio;
	    return servizio;
    }*/
    
    public static OF_CommercialElement__c CE_Kit_Creation(OF_Servizio__c serv)
    {
	    OF_CommercialElement__c ce = new OF_CommercialElement__c();
	    Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO KIT';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio;
	    ce.OF_DataFineValidita__c = fine;
	    ce.OF_Servizio__c = serv.id;
	    insert ce;
	    return ce;
    }  
    
    public static OF_CommercialElement__c CE_Vlan_Creation(OF_Servizio__c serv)
    {
	    OF_CommercialElement__c ce = new OF_CommercialElement__c();
	    Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO VLAN';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio;
	    ce.OF_DataFineValidita__c = fine;
	    ce.OF_Servizio__c = serv.id;
	    insert ce;
	    return ce;
    } 
    
    public static Contract createContract(Account acc)
    {
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        return contratto;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract con, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = con.id;
        cs.OF_Servizio__c = serv.id;
        insert cs;
        return cs;
    }
    
    public static Asset assetCreation(Account acc){

		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Preprovisioning').getRecordTypeId();
		Asset asset_1 = new Asset();
		asset_1.Name = 'Test Asset PP';
		asset_1.Status = 'Attivo';
		asset_1.recordTypeId = assetRecordTypeId;
		asset_1.AccountId = acc.id;
		insert asset_1;
		return asset_1;
	}
    
    private static testMethod void testAll() {
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='test';
        tibco.name='Tibco UserID';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;

        Test.startTest();
        Account a = accountCreation();
        Case c = caseKitCreation(a);
        Case c2 = caseVlanCreation(a);
        Asset asset_1 = assetCreation(a);
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        OF_Servizio__c servPP = ServizioPP_Creation(cat);
        OF_CommercialElement__c ce_kit = CE_Kit_Creation(servPP);
        OF_CommercialElement__c ce_vlan = CE_Vlan_Creation(servPP);
        
        PO_PP_CRMHandler.c = c;
        PO_PP_CRMHandler.CreateOrder(c);
        string id_cei2=PO_PP_CRMHandler.createKITCE();
        
        //Pricebook
        pricebook2 prb = new pricebook2(
        name = 'PREPROV_001_CAN_KIT',
        PO_Commercial_element__c = ce_kit.id,
        OF_Master__c = true
        //RecordTypeId = RecordTypes.get('Pricebook')
        );
        insert prb;
        
        //Product
        product2 pr = new product2(
        name = 'TestProd'
        );
        insert pr;
        
        //Pricebook standard
        ID id = Test.getStandardPricebookId();
        PriceBook2 pb2 = new PriceBook2();
        pb2.Id=id;
        update pb2;
        
        //PriceBookEntry Standard
        pricebookentry pbe = new pricebookentry(
        UnitPrice = -9999,
        IsActive = true,
        Product2ID = pr.id,
        Pricebook2ID = pb2.id  //pricebook standard
        );
        insert pbe;
        
        //PriceBookEntry
        PriceBookEntry prE = new PriceBookEntry(
        Product2Id = pr.Id,           
        Pricebook2Id = prb.Id,
        OF_Asset__c = asset_1.id,
        UnitPrice = -9.999
        );
        insert prE;
        
        
        PO_PP_CRMHandler.createKITBE(id_cei2);
        //OF_CatalogoCommerciale__c cat2 = Catalogo_Creation();
        Contract contratto = createContract(a);
        //OF_Servizio__c servOpenStream = ServizioPP_Creation(cat2);
        OF_ContrattoServizio__c cs = createContrattoServizio(contratto,servPP);
        
        string id_Cei=PO_PP_CRMHandler.createVLANCE();
        PO_PP_CRMHandler.createVLANBE(id_Cei);
        PO_PP_CRMHandler.createCRMKIT(c.id);
        PO_PP_CRMHandler.createCRMVLAN(c.id,asset_1.id);
        Test.stopTest();
	}
}
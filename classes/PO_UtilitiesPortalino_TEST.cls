@isTest
public class PO_UtilitiesPortalino_TEST {
   
    @testSetup
    static void createData()
    {
        //Creazione custom setting
        list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
        CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();
        
        OF_Configurazioni__c CustSett1 = new OF_Configurazioni__c();
        CustSett1 = OF_AreaGeograficaUtilityTest.CustomSetting1();    
       
        list<OF_CodificaProfiloListini__c> CustSett2 = new list<OF_CodificaProfiloListini__c>();
        CustSett2 = OF_AreaGeograficaUtilityTest.CustomSetting2();
        
        Parametri_Fattibilita__c CustSett3 = new Parametri_Fattibilita__c();
        CustSett3 = OF_AreaGeograficaUtilityTest.CustomSetting3();
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;
        
        /*ServFattib__C cs = new ServFattib__C();
        cs.creaOppParentFase__c = 'Test\test';
        cs.creaOppParentOfferta__c = 'Test\test';
        cs.creaOppParentRecordTypeName__c = 'Test\test';
        cs.creaOppChildFase__c = 'Test\test';
        cs.creaOppChildRecordTypeName__c = 'Test\test';  
        insert cs;*/
    }
    
  Public static testmethod void test_PO_CreatePBE_Portalino(){
      
       List<RecordType> Orderrtypes = [Select Name, Id From RecordType 
                  where sObjectType='Order' and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
         OrderRecordTypes.put(rt.Name,rt.Id);
      
        

        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
       
       system.debug('checkacc:'+acc);
       
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
       
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        //c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';    
        insert c;
       
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.OF_IDCaseAttivazione__c = c.id ;
        insert asset_1;
       
        Order o = new Order();
       // String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        o.accountId = acc.Id;
        o.ContractId=contratto.id;
        o.EffectiveDate = system.today();
        o.Status='Aperto';
        o.OF_Asset__c = asset_1.Id;
        o.Description='DWDM1';
        o.RecordTypeId=OrderRecordTypes.get('INORDER');
        o.OF_CaseID__c=c.id;
        o.OF_IDRisorsa__c='test';
        o.OF_TipologiaDiServizio__c = 'Attivo';
        //o.isFiberLink__c = true;
        //o.PO_IsFromOpportunity__c = true;
        o.isFiberLease__c=true;
        insert o;
      
       Order o1 =  [SELECT ID,Name,RecordType.Name,OF_IDCaso__c,OF_Type__c,OF_TipologiaDiServizio__c,OF_SlaPremiumAssurance__c,PO_IsFromOpportunity__c,accountId,
         ContractId,isFiberLease__c,
        EffectiveDate,
        Status,
        OF_Asset__c,
        Description,
        RecordTypeId,
        OF_CaseID__c,
        OF_IDRisorsa__c,
           OF_IDBuilding__c,
                                   OF_IdentificativoDelPOP__c,
                                   OF_GPONAttestazione__c,
                                   OF_Comune__c,
                                   OF_Provincia__c,
                                   OF_ParticellaToponomastica__c,
                                   OF_Indirizzo__c,
                                   OF_Civico__c,
                                   OF_ScalaPalazzina__c,
                                   OF_IDSplitterSecondario__c,
                                   OF_PosizioneSplitterSecondario__c,
                                   OF_ProgettoSpeciale__c,
                                   OF_ProfiloOpenStream__c,
                                   OF_Promozione__c,
                                   OF_ClusterPromozione__c,
                                   OF_TipologiaApparato__c,
                                   OF_CodiceProgettoSpeciale__c,
                                   OF_IDServizio__c
                    from Order WHERE OF_IDRisorsa__c='test' LIMIT 1];
       
       system.debug('checkorder:'+o1);
       system.debug('checkorder1:'+o1.OF_CaseID__c);
       system.debug('checkorder2:'+o1.OF_IDCaso__c);
       system.debug('checkorder3:'+o1.OF_Type__c);
      
        List<Order> listaOrdini = new List<Order>();
        //listaOrdini.add(o);
        listaOrdini.add(o1);
        
      system.debug('ListOrder***:'+listaOrdini[0]);
      
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
       
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='DWDM1';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
       
        Test.startTest();
        PO_UtilitiesPortalino pu = new PO_UtilitiesPortalino();
        String tipologiaServizioPortalino = 'FiberLease';
        pu.PO_CreatePBE_Portalino(listaOrdini,tipologiaServizioPortalino);
        Test.stopTest();
    } 
    
    Public static testmethod void test_PO_CreatePBE_Portalino1(){
      
       List<RecordType> Orderrtypes = [Select Name, Id From RecordType 
                  where sObjectType='Order' and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
         OrderRecordTypes.put(rt.Name,rt.Id);
      
        

        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
       
       system.debug('checkacc:'+acc);
       
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
       
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        //c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';    
        insert c;
       
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.OF_IDCaseAttivazione__c = c.id ;
        insert asset_1;
       
        
        
         Product2 prod = new Product2(Name = 'Laptop X200',Family = 'Hardware');
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2(Name= 'P2P BaseAcc', isActive=true);
        insert customPB;
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id,
                                                        UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        String oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Oppty collegamenti P2P Attiva').getRecordTypeId();
        Opportunity OppRecA = new Opportunity();
        OppRecA.AccountId = acc.Id;
        OppRecA.PO_Collegamento__c =c.ID;
        OppRecA.name = 'Opp';
        OppRecA.Pricebook2id = customPB.Id; 
        OppRecA.stageName = 'Open';
        OppRecA.closeDate = Date.newInstance(2008,10,10);
        OppRecA.RecordTypeId = oppRecordTypeId;
        insert OppRecA;
        
        system.debug('oppppintest:'+OppRecA);
        
        Order o = new Order();
       // String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        o.accountId = acc.Id;
        o.ContractId=contratto.id;
        o.EffectiveDate = system.today();
        o.Status='Aperto';
        o.OF_Asset__c = asset_1.Id;
        o.Description='DWDM';
        o.RecordTypeId=OrderRecordTypes.get('INORDER');
        o.OF_CaseID__c=c.id;
        o.OF_IDRisorsa__c='test';
        o.OF_TipologiaDiServizio__c = 'Attivo';
        //o.isFiberLink__c = true;
        //o.PO_IsFromOpportunity__c = true;
        o.isFiberLease__c=true;
        o.PO_Opportunity__c=OppRecA.id;
        insert o;
      
       Order o1 =  [SELECT ID,Name,RecordType.Name,OF_IDCaso__c,OF_Type__c,OF_TipologiaDiServizio__c,OF_SlaPremiumAssurance__c,PO_IsFromOpportunity__c,accountId,
         ContractId,isFiberLease__c,PO_Opportunity__c,
        EffectiveDate,
        Status,
        OF_Asset__c,
        Description,
        RecordTypeId,
        OF_CaseID__c,
        OF_IDRisorsa__c,
           OF_IDBuilding__c,
                                   OF_IdentificativoDelPOP__c,
                                   OF_GPONAttestazione__c,
                                   OF_Comune__c,
                                   OF_Provincia__c,
                                   OF_ParticellaToponomastica__c,
                                   OF_Indirizzo__c,
                                   OF_Civico__c,
                                   OF_ScalaPalazzina__c,
                                   OF_IDSplitterSecondario__c,
                                   OF_PosizioneSplitterSecondario__c,
                                   OF_ProgettoSpeciale__c,
                                   OF_ProfiloOpenStream__c,
                                   OF_Promozione__c,
                                   OF_ClusterPromozione__c,
                                   OF_TipologiaApparato__c,
                                   OF_CodiceProgettoSpeciale__c,
                                   OF_IDServizio__c
                    from Order WHERE OF_IDRisorsa__c='test' LIMIT 1];
       
       system.debug('checkorder:'+o1);
       system.debug('checkorder1:'+o1.OF_CaseID__c);
       system.debug('checkorder2:'+o1.OF_IDCaso__c);
       system.debug('checkorder3:'+o1.OF_Type__c);
      
        List<Order> listaOrdini = new List<Order>();
        //listaOrdini.add(o);
        listaOrdini.add(o1);
        
      system.debug('ListOrder***:'+listaOrdini[0]);
      
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
       
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='DWDM';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
       
        Test.startTest();
        PO_UtilitiesPortalino pu = new PO_UtilitiesPortalino();
        String tipologiaServizioPortalino = 'test';
        pu.PO_CreatePBE_Portalino(listaOrdini,tipologiaServizioPortalino);
        Test.stopTest();
    } 
    
    Public static testmethod void test_PO_CreatePBE_Portalino2(){
      
       List<RecordType> Orderrtypes = [Select Name, Id From RecordType 
                  where sObjectType='Order' and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
         OrderRecordTypes.put(rt.Name,rt.Id);
      
        

        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
       
       system.debug('checkacc:'+acc);
       
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
       
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        //c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';    
        insert c;
       
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.OF_IDCaseAttivazione__c = c.id ;
        insert asset_1;
       
        
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        
        OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'Fiber Lease'; //'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = myDate;
        p2pBase.OF_DataFineValidita__c = newDate;
        insert p2pBase;
       
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name ='DWDM';
        ce.OF_Servizio__c = p2pBase.id;
        ce.OF_Attivo__c=true;
        ce.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        ce.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.OF_CommercialElement__c = ce.id;
        Date ini113 = Date.newInstance(2099,1,31);
        Date fin113= Date.newInstance(2099,1,3);
        be.OF_DataFineValidita__c=ini113;
        be.OF_DataInizioValidita__c=fin113;
        insert be;
        
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c=p2pBase.id;
        sb1.OF_BillingElement__c = be.id;
        insert sb1;
        
        OF_Listino__c lr1=new OF_Listino__c();
        String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        lr1.OF_DataFineValidita__c=ini11;
        lr1.OF_DataInizioValidita__c=fin11;
        lr1.OF_ServizioBillingElement__c=sb1.Id;
        lr1.OF_Attivo__c = true;
        lr1.RecordTypeId = ComRecordTypeId3;
        lr1.OF_ListinoDefault__c = true;
        insert lr1;
        
       
        
         Product2 prod = new Product2(Name = 'Laptop X200',Family = 'Hardware',OF_BillingElement__c=be.id,OF_ListinoCustom__c=lr1.Id);
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2(Name= 'P2P BaseAcc', isActive=true);
        insert customPB;
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id,
                                                        UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
       
         
        // String oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Oppty collegamenti P2P Attiva').getRecordTypeId();
        Opportunity OppRecA = new Opportunity();
        OppRecA.AccountId = acc.Id;
        OppRecA.PO_Collegamento__c =c.ID;
        OppRecA.name = 'Opp';
        OppRecA.Pricebook2id = customPB.Id; 
        OppRecA.stageName = 'Open';
        OppRecA.closeDate = Date.newInstance(2008,10,10);
        //OppRecA.RecordTypeId = oppRecordTypeId;
        
        insert OppRecA;
        
        system.debug('oppppintest:'+OppRecA);
       
       
       
        Order o = new Order();
       // String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        o.accountId = acc.Id;
        o.ContractId=contratto.id;
        o.EffectiveDate = system.today();
        o.Status='Aperto';
        o.OF_Asset__c = asset_1.Id;
        o.Description='DWDM';
        o.RecordTypeId=OrderRecordTypes.get('INORDER');
        o.OF_CaseID__c=c.id;
        o.OF_IDRisorsa__c='test';
        o.OF_TipologiaDiServizio__c = 'Attivo';
        //o.isFiberLink__c = true;
        //o.PO_IsFromOpportunity__c = true;
        o.isFiberLease__c=true;
        o.PO_Opportunity__c=OppRecA.id;
        insert o;
      
       Order o1 =  [SELECT ID,Name,RecordType.Name,OF_IDCaso__c,OF_Type__c,OF_TipologiaDiServizio__c,OF_SlaPremiumAssurance__c,PO_IsFromOpportunity__c,accountId,
         ContractId,isFiberLease__c,PO_Opportunity__c,
        EffectiveDate,
        Status,
        OF_Asset__c,
        Description,
        RecordTypeId,
        OF_CaseID__c,
        OF_IDRisorsa__c,
           OF_IDBuilding__c,
                                   OF_IdentificativoDelPOP__c,
                                   OF_GPONAttestazione__c,
                                   OF_Comune__c,
                                   OF_Provincia__c,
                                   OF_ParticellaToponomastica__c,
                                   OF_Indirizzo__c,
                                   OF_Civico__c,
                                   OF_ScalaPalazzina__c,
                                   OF_IDSplitterSecondario__c,
                                   OF_PosizioneSplitterSecondario__c,
                                   OF_ProgettoSpeciale__c,
                                   OF_ProfiloOpenStream__c,
                                   OF_Promozione__c,
                                   OF_ClusterPromozione__c,
                                   OF_TipologiaApparato__c,
                                   OF_CodiceProgettoSpeciale__c,
                                   OF_IDServizio__c
                    from Order WHERE OF_IDRisorsa__c='test' LIMIT 1];
       
       system.debug('checkorder:'+o1);
       system.debug('checkorder1:'+o1.OF_CaseID__c);
       system.debug('checkorder2:'+o1.OF_IDCaso__c);
       system.debug('checkorder3:'+o1.OF_Type__c);
      
        List<Order> listaOrdini = new List<Order>();
        //listaOrdini.add(o);
        listaOrdini.add(o1);
        
      system.debug('ListOrder***:'+listaOrdini[0]);
      
        
        
       
        Test.startTest();
        PO_UtilitiesPortalino pu = new PO_UtilitiesPortalino();
        String tipologiaServizioPortalino = 'FiberLink';
        pu.PO_CreatePBE_Portalino(listaOrdini,tipologiaServizioPortalino);
        Test.stopTest();
    } 
    
   
  
}
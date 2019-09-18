@isTest
public class PO_FATT_WS_IN_UtilitiesPortalino_Test1{
     public static testmethod void UtilitiesPortalinoMethod3_HNR(){   
     /*   ServFattib__C cs=new ServFattib__C(creaOppParentFase__c='Offerta Creata',
                                           creaOppParentOfferta__c='\'P2P Base\',\'IRU\',\'Fiber Link\',\'Fiber Lease\',\'Evento Temporaneo\'',
                                           creaOppParentRecordTypeName__c='PO Richiesta a servizio a fattibilità',
                                           creaOppChildFase__c='Completato',
                                           creaOppChildRecordTypeName__c='\'PO Collegamento P2P\',\'PO Collegamento IRU\',\'PO Collegamento Fiber Lease\',\'PO Collegamento Fiber link\',\'PO Collegamento Evento Temporaneo\'');
        insert cs;
        */
        Case cases = new Case();
        cases.PO_Durata_affitto__c =1;
        cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        
        cases.status = 'Accettato';
        cases.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases.OwnerId = '0058E000002dUEZ';
        cases.OwnerId=userInfo.getUserId();
        Cases.PO_Durata_affitto__c =1;
        insert cases;
        Case cases1 = new Case();
        cases1.parentid = cases.id;
        cases1.PO_Durata_affitto__c =1;
        cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases1.status = 'Accettato';
        cases1.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases1.OwnerId = '0058E000002dUEZ';
        cases1.OwnerId=userInfo.getUserId();
        insert cases1;
        System.debug('@@cases '+cases1);
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        List<Asset> assList = new List<Asset>();
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = cases1.iD;
        assList.add(asst1);
        insert assList;
        
        
        
        
        OF_CatalogoCommerciale__c cc = new OF_CatalogoCommerciale__c();
        cc.Name = 'test';
        cc.OF_DataFineValidita__c = System.today();
        cc.OF_DataInizioValidita__c = System.today();
        insert cc;
        
        OF_Servizio__c se = new OF_Servizio__c();
        se.Name = 'Fiber Lease';
        se.OF_DataFineValidita__c = System.today();
        se.OF_DataInizioValidita__c = System.today();
        se.OF_CatalogoCommerciale__c = cc.Id;
        insert se;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name = 'test';
        ce.OF_DataFineValidita__c = System.today();
        ce.OF_DataInizioValidita__c = System.today();
        ce.OF_Servizio__c = se.Id;
        insert ce;
        
        list<OF_CommercialElementIstanziato__c> comlst = new list<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = assList[0].Id;
        commercial.OF_AssetTratta__c = assList[0].Id;
        commercial.OF_Case__c = cases1.Id;
        commercial.OF_CaseTratta__c = cases1.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        comlst.add(commercial);
        //commercial.recordtypeid =rtId;
        insert comlst;
        
        PO_FATT_WS_IN_UtilitiesPortalino util = new PO_FATT_WS_IN_UtilitiesPortalino();
        util.AssociazioneTRATTEAsset(assList);

        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // cases.PO_Durata_affitto__c =1;
        //update cases;
        
        Opportunity OppRecA1 = new Opportunity(AccountId = Acc.Id,name='Opp' ,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA1.PO_Richiesta_fattibilit__c=cases.Id;
        system.debug('TOTTI' + OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c);
        insert OppRecA1;
        system.debug('cases.Id e'+cases.Id+' **  cases.PO_Durata_affitto__c: '+cases.PO_Durata_affitto__c);
        system.debug('$$$$$$$ OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c '+OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c + ' xxx ' + OppRecA1.PO_Richiesta_fattibilit__c);       
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp',PO_Collegamento__c = cases1.Id,PO_Offerta_totale__c=OppRecA1.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA;
        system.debug('$$$$$$$ OppRecA '+OppRecA.PO_Offerta_totale__r.PO_Durata_affitto__c);    
        update OppRecA1;
        
        system.debug('$$$$$$$'+OppRecA.PO_Offerta_totale__r.PO_Durata_affitto__c);
        
        Product2 p = new Product2(name='x',PO_Anni_Fiber_Link__c ='1 Anno');
        insert p;
        assList[0].Product2 = p;
        update assList[0];
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        PricebookEntry pbe1 = new PricebookEntry( Pricebook2Id = stdPb.Id, product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe1;
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, Product2Id=p.Id,pricebookentryid=pbe1.id, UnitPrice = 1.0, Quantity = 3);
        insert OppLI_Rec;
        
        
        
        util.MappaAssetOpportunity.put(assList[0].Id,OppRecA); 
        
        Map<Id,Opportunity> tempoppmap=new Map<Id,Opportunity>();
        tempoppmap.put(assList[0].Id,OppRecA);
        Map<id,OpportunityLineItem> opplinemap=New Map<id,OpportunityLineItem>();
        opplinemap.put(OppLI_Rec.Id,OppLI_Rec);
        
        Map<Id,PriceBook2> temp1=New Map<Id,PriceBook2>();
        temp1.put(OppLI_Rec.Id,stdPb);
        
        Map<Id,Map<Id,PriceBook2>> temp2=New Map<Id,Map<Id,PriceBook2>>();
        temp2.put(assList[0].Id,temp1);
        
        
        
        Map<Id,OF_CommercialElementIstanziato__c> temp3=new Map<Id,OF_CommercialElementIstanziato__c>();
        temp3.put(assList[0].Id,comlst[0]);
        util.MappaAssetOpportunity=tempoppmap;
        util.MapOppoLineItem=opplinemap;
        util.Method_CreatePBE1(temp2, 'FiberLink');//[GP 11/01/2018]
        util.createBE_FiberLink1(temp2,temp3);
        
    }
    //------------------------------------------------------------------------
    public static testMethod void UtilitiesPortalinoMethod(){
        //PO_FATT_WS_IN_UtilitiesPortalino.codeCoverage(100);
        
      /* ServFattib__C cs=new ServFattib__C(creaOppParentFase__c='Offerta Creata',
                                           creaOppParentOfferta__c='\'P2P Base\',\'IRU\',\'Fiber Link\',\'Fiber Lease\',\'Evento Temporaneo\'',
                                           creaOppParentRecordTypeName__c='PO Richiesta a servizio a fattibilità',
                                           creaOppChildFase__c='Completato',
                                           creaOppChildRecordTypeName__c='\'PO Collegamento P2P\',\'PO Collegamento IRU\',\'PO Collegamento Fiber Lease\',\'PO Collegamento Fiber link\',\'PO Collegamento Evento Temporaneo\'');
        insert cs;
        */
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        system.debug('stdPb==='+stdPb);
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        
        Product2 p = new product2(name='x',PO_Anni_Fiber_Link__c = '1 Anno');
        insert p;
        system.debug('Product2==='+p);
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        system.debug('pbe==='+pbe);
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA;
        system.debug('Opportunity==='+OppRecA);
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3);
        insert OppLI_Rec;
        system.debug('opportunitylist==='+OppLI_Rec);
        
        
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = 'test';
        asst2.recordTypeId = rtId2;
        insert asst2;
        List<Asset> assList = new List<Asset>();
        Asset asst = new Asset();
        asst.Name = 'TestdiprovaTIS';
        asst.accountId=acc.Id;
        asst.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst.recordTypeId = rtId;
        //insert asst;
        
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst1.recordTypeId = rtId1;
        //insert asst1;
        //assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.OF_Asset__c=assList[0].Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        insert ord2;
        
        List<order> orList = new List<order>();
        order ord = new order();
        ord.OF_Asset__c=asst2.Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=asst2.Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        //insert ord1 ;
        
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = 'test';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = 'test';
        asst4.recordTypeId = rtId4;
        insert asst4;
        
        Case cases = new Case();
        cases.OF_Order__c = ord.Id; 
        cases.AssetId = asst.Id;
        insert cases;
        
        OF_CatalogoCommerciale__c cc = new OF_CatalogoCommerciale__c();
        cc.Name = 'test';
        cc.OF_DataFineValidita__c = System.today();
        cc.OF_DataInizioValidita__c = System.today();
        insert cc;
        
        OF_Servizio__c se = new OF_Servizio__c();
        se.Name = 'Fiber Lease';
        se.OF_DataFineValidita__c = System.today();
        se.OF_DataInizioValidita__c = System.today();
        se.OF_CatalogoCommerciale__c = cc.Id;
        insert se;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name = 'test';
        ce.OF_DataFineValidita__c = System.today();
        ce.OF_DataInizioValidita__c = System.today();
        ce.OF_Servizio__c = se.Id;
        insert ce;
        
        list<OF_CommercialElementIstanziato__c> commlst = new   list<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        commlst.add(commercial);
        insert commlst;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        //mappaAssetIDOrderFiberLease.put(orList.Id,orList);
        
        PO_FATT_WS_IN_UtilitiesPortalino util = new PO_FATT_WS_IN_UtilitiesPortalino();
        
        
        util.AssociazioneTRATTEAsset(assList);
        util.AssociazioneOrderAsset(assList,orList);
        util.getAssetOppLineItem(orList);
        
        Map<ID,order> mappaAssetIDOrder = new Map<ID,order>();
        mappaAssetIDOrder.put(orList[0].OF_Asset__c,orList[0]);
        try
        {
            util.createCEFiberLease(assList,mappaAssetIDOrder);
        }
        catch(exception e)
        {
            system.debug('error====='+e.getStackTraceString());
        }
        //util.PO_CreatePBE_Portalino(orList,'FiberLease');
    } 
    
    public static testMethod void UtilitiesPortalinoMethod1(){    
        
       /* ServFattib__C cs=new ServFattib__C(creaOppParentFase__c='Offerta Creata',
                                           creaOppParentOfferta__c='\'P2P Base\',\'IRU\',\'Fiber Link\',\'Fiber Lease\',\'Evento Temporaneo\'',
                                           creaOppParentRecordTypeName__c='PO Richiesta a servizio a fattibilità',
                                           creaOppChildFase__c='Completato',
                                           creaOppChildRecordTypeName__c='\'PO Collegamento P2P\',\'PO Collegamento IRU\',\'PO Collegamento Fiber Lease\',\'PO Collegamento Fiber link\',\'PO Collegamento Evento Temporaneo\'');
        insert cs;*/
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        
        Product2 p = new product2(name='x',PO_Anni_Fiber_Link__c = '1 Anno');
        insert p;
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity Opp = new Opportunity(AccountId = Acc.Id,  name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert Opp;
        
        List<Asset> assList = new List<Asset>();
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst1.recordTypeId = rtId1;
        //insert asst1;
        //assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        PO_FATT_WS_IN_UtilitiesPortalino utilitiesPortalino  = new PO_FATT_WS_IN_UtilitiesPortalino();
        utilitiesPortalino.MappaAssetOpportunity.put(asst1.id,Opp);
        
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.OF_Asset__c=assList[0].Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=Opp.Id;
        insert ord2;
        
        Case cases = new Case();
        cases.OF_Order__c = ord2.Id; 
        cases.AssetId = assList[0].Id;
        cases.PO_Durata_affitto__c = 1;//123; MMAGNA
        insert cases;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, PO_Richiesta_fattibilit__c= cases.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA;
        
        Opportunity OppRecA1 = new Opportunity(AccountId = Acc.Id,PO_Offerta_totale__c=OppRecA.Id,  name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA1;
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, product2Id=p.Id,pricebookentryid=pbe.id, UnitPrice = 1.0, Quantity = 3);
        insert OppLI_Rec;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = 'test';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst = new Asset();
        asst.Name = 'TestdiprovaTIS';
        asst.accountId=acc.Id;
        asst.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst.recordTypeId = rtId;
        //insert asst;
        
        
        List<order> orList = new List<order>();
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        //insert ord1 ;
        
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = 'test';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = 'test';
        asst4.recordTypeId = rtId4;
        insert asst4;
        
        
        OF_CatalogoCommerciale__c cc = new OF_CatalogoCommerciale__c();
        cc.Name = 'test';
        cc.OF_DataFineValidita__c = System.today();
        cc.OF_DataInizioValidita__c = System.today();
        insert cc;
        
        OF_Servizio__c se = new OF_Servizio__c();
        se.Name = 'Fiber Lease';
        se.OF_DataFineValidita__c = System.today();
        se.OF_DataInizioValidita__c = System.today();
        se.OF_CatalogoCommerciale__c = cc.Id;
        insert se;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name = 'test';
        ce.OF_DataFineValidita__c = System.today();
        ce.OF_DataInizioValidita__c = System.today();
        ce.OF_Servizio__c = se.Id;
        insert ce;
        
        list<OF_CommercialElementIstanziato__c> comlst = new list<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        comlst.add(commercial);
        //commercial.recordtypeid =rtId;
        insert comlst;
        
        
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        //mappaAssetIDOrderFiberLease.put(orList.Id,orList);
        
        PO_FATT_WS_IN_UtilitiesPortalino util = new PO_FATT_WS_IN_UtilitiesPortalino();
        
        
        util.getAssetOppLineItem(orList);
        
        util.PO_CreatePBE_Portalino(orList,'Test');
        Map<Id,PriceBook2> temp1=New Map<Id,PriceBook2>();
        temp1.put(assList[0].Id,stdPb);
        
        Map<Id,Map<Id,PriceBook2>> temp2=New Map<Id,Map<Id,PriceBook2>>();
        temp2.put(assList[0].Id,temp1);
        
        Map<Id,OF_CommercialElementIstanziato__c> temp3=new Map<Id,OF_CommercialElementIstanziato__c>();
        temp3.put(assList[0].Id,comlst[0]);
        //Testing was commented b4
       // util.createBE_FiberLink1(temp2,temp3);       
        
    }
     public static testmethod void UtilitiesPortalinoMethod2(){   
      /*  ServFattib__C cs=new ServFattib__C(creaOppParentFase__c='Offerta Creata',
                                           creaOppParentOfferta__c='\'P2P Base\',\'IRU\',\'Fiber Link\',\'Fiber Lease\',\'Evento Temporaneo\'',
                                           creaOppParentRecordTypeName__c='PO Richiesta a servizio a fattibilità',
                                           creaOppChildFase__c='Completato',
                                           creaOppChildRecordTypeName__c='\'PO Collegamento P2P\',\'PO Collegamento IRU\',\'PO Collegamento Fiber Lease\',\'PO Collegamento Fiber link\',\'PO Collegamento Evento Temporaneo\'');
        insert cs;
        */
        Case cases = new Case();
        cases.PO_Durata_affitto__c =1;
        cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        
        cases.status = 'Accettato';
        cases.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases.OwnerId = '0058E000002dUEZ';
        cases.OwnerId=userInfo.getUserId();
        Cases.PO_Durata_affitto__c =1;
        insert cases;
        Case cases1 = new Case();
        cases1.parentid = cases.id;
        cases1.PO_Durata_affitto__c =1;
        cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases1.status = 'Accettato';
        cases1.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases1.OwnerId = '0058E000002dUEZ';
        cases1.OwnerId=userInfo.getUserId();
        insert cases1;
        System.debug('@@cases '+cases1);
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        List<Asset> assList = new List<Asset>();
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = cases1.iD;
        assList.add(asst1);
        insert assList;
        
        
        
        
        OF_CatalogoCommerciale__c cc = new OF_CatalogoCommerciale__c();
        cc.Name = 'test';
        cc.OF_DataFineValidita__c = System.today();
        cc.OF_DataInizioValidita__c = System.today();
        insert cc;
        
        OF_Servizio__c se = new OF_Servizio__c();
        se.Name = 'Fiber Lease';
        se.OF_DataFineValidita__c = System.today();
        se.OF_DataInizioValidita__c = System.today();
        se.OF_CatalogoCommerciale__c = cc.Id;
        insert se;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name = 'test';
        ce.OF_DataFineValidita__c = System.today();
        ce.OF_DataInizioValidita__c = System.today();
        ce.OF_Servizio__c = se.Id;
        insert ce;
        
        list<OF_CommercialElementIstanziato__c> comlst = new list<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = assList[0].Id;
        commercial.OF_AssetTratta__c = assList[0].Id;
        commercial.OF_Case__c = cases1.Id;
        commercial.OF_CaseTratta__c = cases1.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        comlst.add(commercial);
        //commercial.recordtypeid =rtId;
        insert comlst;
        
        PO_FATT_WS_IN_UtilitiesPortalino util = new PO_FATT_WS_IN_UtilitiesPortalino();
        util.AssociazioneTRATTEAsset(assList);

        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // cases.PO_Durata_affitto__c =1;
        //update cases;
        
        Opportunity OppRecA1 = new Opportunity(AccountId = Acc.Id,name='Opp' ,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA1.PO_Richiesta_fattibilit__c=cases.Id;
        system.debug('TOTTI' + OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c);
        insert OppRecA1;
        opportunity parentOpp=[select id,name,AccountId,stageName,PO_Richiesta_fattibilit__c,PO_Richiesta_fattibilit__r.PO_Durata_affitto__c,PO_Durata_affitto__c from Opportunity where id=:OppRecA1.id];
                    
        system.debug('cases.Id e'+cases.Id+' **  cases.PO_Durata_affitto__c: '+cases.PO_Durata_affitto__c);
        system.debug('$$$$$$$ OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c '+OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c + ' xxx ' + OppRecA1.PO_Richiesta_fattibilit__c);       
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp',PO_Collegamento__c = cases1.Id,PO_Offerta_totale__c=parentOpp.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA;
        system.debug('$$$$$$$ OppRecA '+OppRecA.PO_Offerta_totale__r.PO_Durata_affitto__c);    
        update OppRecA1;
        
        opportunity childOpp=[select id,name,PO_Offerta_totale__r.PO_Durata_affitto__c,PO_Offerta_totale__c,Pricebook2Id,priceBook2.PO_Commercial_element__c from Opportunity where id=:OppRecA.id];
        
        system.debug('$$$$$$$'+OppRecA.PO_Offerta_totale__r.PO_Durata_affitto__c);
        
        Product2 p = new Product2(name='x',PO_Anni_Fiber_Link__c ='1 Anno');
        insert p;
        assList[0].Product2 = p;
        update assList[0];
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        PricebookEntry pbe1 = new PricebookEntry( Pricebook2Id = stdPb.Id, product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe1;
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = childOpp.Id, Product2Id=p.Id,pricebookentryid=pbe1.id, UnitPrice = 1.0, Quantity = 3);
        insert OppLI_Rec;
        
        OpportunityLineItem Opplineitem =[select id,OpportunityId,Product2Id,Product2.PO_Anni_Fiber_Link__c,pricebookentryid,UnitPrice,Quantity from OpportunityLineItem where id=:OppLI_Rec.id]; 
        
        
        util.MappaAssetOpportunity.put(assList[0].Id,childOpp); 
        
        Map<Id,Opportunity> tempoppmap=new Map<Id,Opportunity>();
        tempoppmap.put(assList[0].Id,childOpp);
        Map<id,OpportunityLineItem> opplinemap=New Map<id,OpportunityLineItem>();
        opplinemap.put(Opplineitem.Id,Opplineitem);
        
        Map<Id,PriceBook2> temp1=New Map<Id,PriceBook2>();
        temp1.put(OppLI_Rec.Id,stdPb);
        
        Map<Id,Map<Id,PriceBook2>> temp2=New Map<Id,Map<Id,PriceBook2>>();
        temp2.put(assList[0].Id,temp1);
        
        
        
        Map<Id,OF_CommercialElementIstanziato__c> temp3=new Map<Id,OF_CommercialElementIstanziato__c>();
        temp3.put(assList[0].Id,comlst[0]);
        util.MappaAssetOpportunity=tempoppmap;
        util.MapOppoLineItem=opplinemap;
        util.Method_CreatePBE1(temp2, 'FiberLink');//[GP 11/01/2018]
        util.createBE_FiberLink1(temp2,temp3);
        
    }
   
        public static testmethod void UtilitiesPortalinoMethod4(){   
      /*  ServFattib__C cs=new ServFattib__C(creaOppParentFase__c='Offerta Creata',
                                           creaOppParentOfferta__c='\'P2P Base\',\'IRU\',\'Fiber Link\',\'Fiber Lease\',\'Evento Temporaneo\'',
                                           creaOppParentRecordTypeName__c='PO Richiesta a servizio a fattibilità',
                                           creaOppChildFase__c='Completato',
                                           creaOppChildRecordTypeName__c='\'PO Collegamento P2P\',\'PO Collegamento IRU\',\'PO Collegamento Fiber Lease\',\'PO Collegamento Fiber link\',\'PO Collegamento Evento Temporaneo\'');
        insert cs;
        */
        Case cases = new Case();
        cases.PO_Durata_affitto__c =2;
        // cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Richiesta_a_servizio_a_fattibilit'].id ;
        cases.PO_Durata_affitto__c =2;
        cases.status = 'Accettato';
        cases.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases.OwnerId = '0058E000002dUEZ';
        cases.OwnerId=userInfo.getUserId();
        // Cases.PO_Durata_affitto__c =1;
        insert cases;
        System.debug('@@cases '+cases);
        Case cases1 = new Case();
        cases1.parentid = cases.id;
        cases1.PO_Case_Collegamento__c=cases.id;
        cases1.PO_Durata_affitto__c =1;
        // cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Richiesta_a_servizio_a_fattibilit'].id ;
        cases1.status = 'Accettato';
        cases1.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases1.OwnerId = '0058E000002dUEZ';
        cases1.OwnerId=userInfo.getUserId();
        cases1.PO_Richiesta_a_fattibilit__c=cases.id;
        insert cases1;
        
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        List<Asset> assList = new List<Asset>();
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = cases1.iD;
        assList.add(asst1);
        insert assList;
        
        
        
        
        OF_CatalogoCommerciale__c cc = new OF_CatalogoCommerciale__c();
        cc.Name = 'test';
        cc.OF_DataFineValidita__c = System.today();
        cc.OF_DataInizioValidita__c = System.today();
        insert cc;
        
        OF_Servizio__c se = new OF_Servizio__c();
        se.Name = 'Fiber Lease';
        se.OF_DataFineValidita__c = System.today();
        se.OF_DataInizioValidita__c = System.today();
        se.OF_CatalogoCommerciale__c = cc.Id;
        insert se;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name = 'test';
        ce.OF_DataFineValidita__c = System.today();
        ce.OF_DataInizioValidita__c = System.today();
        ce.OF_Servizio__c = se.Id;
        insert ce;
        
        list<OF_CommercialElementIstanziato__c> comlst = new list<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = assList[0].Id;
        commercial.OF_AssetTratta__c = assList[0].Id;
        commercial.OF_Case__c = cases1.Id;
        commercial.OF_CaseTratta__c = cases1.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        comlst.add(commercial);
        //commercial.recordtypeid =rtId;
        insert comlst;
        
        PO_FATT_WS_IN_UtilitiesPortalino util = new PO_FATT_WS_IN_UtilitiesPortalino();
        util.AssociazioneTRATTEAsset(assList);
        
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // cases.PO_Durata_affitto__c =1;
        //update cases;
        
        Opportunity OppRecA1 = new Opportunity();
        OppRecA1.AccountId = Acc.Id;
        OppRecA1.name='Opp' ;
        OppRecA1.stageName='Open';
        OppRecA1.closeDate=Date.newInstance(2008,10,10);
        OppRecA1.PO_Richiesta_fattibilit__c=cases.Id;
        OppRecA1.PO_Collegamento__c=cases.Id;
        insert OppRecA1;
        // OppRecA1.PO_Richiesta_fattibilit__c=cases1.Id;
        // update OppRecA1;
         opportunity parentOpp=[select id,name,AccountId,stageName,PO_Richiesta_fattibilit__c,PO_Richiesta_fattibilit__r.PO_Durata_affitto__c,PO_Durata_affitto__c from Opportunity where id=:OppRecA1.id];
        system.debug('=+=+=+=OppRecA1=+=+=+='+OppRecA1);             
        system.debug('cases.Id e'+cases.Id+' **  cases.PO_Durata_affitto__c: '+cases.PO_Durata_affitto__c);
        system.debug('$$$$$$$ OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c '+parentOpp.PO_Durata_affitto__c + ' xxx ' + parentOpp.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c);       
        // Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp1',PO_Collegamento__c = cases1.Id,PO_Offerta_totale__c=OppRecA1.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp1',PO_Offerta_totale__c=OppRecA1.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA;
        //OppRecA.PO_Offerta_totale__r.PO_Durata_affitto__c=1;
        update OppRecA;
        opportunity childOpp=[select id,name,PO_Offerta_totale__r.PO_Durata_affitto__c,PO_Offerta_totale__c,Pricebook2Id,priceBook2.PO_Commercial_element__c from Opportunity where id=:OppRecA.id];
        system.debug('TOTTI***===' + OppRecA1.PO_Durata_affitto__c); 
        system.debug('$$$$$$$ OppRecA '+childOpp.PO_Offerta_totale__r.PO_Durata_affitto__c);    
        // update OppRecA1;
        
        system.debug('$$$$$$$'+childOpp.PO_Offerta_totale__r.PO_Durata_affitto__c);
        
        Product2 p = new Product2(name='x',PO_Anni_Fiber_Link__c ='2 Anni');
        insert p;
        assList[0].Product2 = p;
        update assList[0];
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        PricebookEntry pbe1 = new PricebookEntry( Pricebook2Id = stdPb.Id, product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe1;
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = childOpp.Id, Product2Id=p.Id,pricebookentryid=pbe1.id, UnitPrice = 1.0, Quantity = 3);
        insert OppLI_Rec;
         
       OpportunityLineItem Opplineitem =[select id,OpportunityId,Product2Id,Product2.PO_Anni_Fiber_Link__c,pricebookentryid,UnitPrice,Quantity from OpportunityLineItem where id=:OppLI_Rec.id]; 
        

        
        
        
               
        util.MappaAssetOpportunity.put(assList[0].Id,childOpp); 
        
        Map<Id,Opportunity> tempoppmap=new Map<Id,Opportunity>();
        tempoppmap.put(assList[0].Id,childOpp);
        Map<id,OpportunityLineItem> opplinemap=New Map<id,OpportunityLineItem>();
        opplinemap.put(Opplineitem.Id,Opplineitem);
        
        Map<Id,PriceBook2> temp1=New Map<Id,PriceBook2>();
        temp1.put(Opplineitem.Id,stdPb);
        
        Map<Id,Map<Id,PriceBook2>> temp2=New Map<Id,Map<Id,PriceBook2>>();
        temp2.put(assList[0].Id,temp1); 
        
        Map<Id,OF_CommercialElementIstanziato__c> temp3=new Map<Id,OF_CommercialElementIstanziato__c>();
        temp3.put(assList[0].Id,comlst[0]);
        util.MappaAssetOpportunity=tempoppmap;
        util.MapOppoLineItem=opplinemap;

        util.Method_CreatePBE1(temp2, 'FiberLink');//[GP 11/01/2018]
        util.createBE_FiberLink1(temp2,temp3);
        
    }
    
    public static testmethod void UtilitiesPortalinoMethod5(){   
 /*       ServFattib__C cs=new ServFattib__C(creaOppParentFase__c='Offerta Creata',
                                           creaOppParentOfferta__c='\'P2P Base\',\'IRU\',\'Fiber Link\',\'Fiber Lease\',\'Evento Temporaneo\'',
                                           creaOppParentRecordTypeName__c='PO Richiesta a servizio a fattibilità',
                                           creaOppChildFase__c='Completato',
                                           creaOppChildRecordTypeName__c='\'PO Collegamento P2P\',\'PO Collegamento IRU\',\'PO Collegamento Fiber Lease\',\'PO Collegamento Fiber link\',\'PO Collegamento Evento Temporaneo\'');
        insert cs;
   */     
        Case cases = new Case();
        cases.PO_Durata_affitto__c =3;
        // cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Richiesta_a_servizio_a_fattibilit'].id ;
        cases.PO_Durata_affitto__c =3;
        cases.status = 'Accettato';
        cases.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases.OwnerId = '0058E000002dUEZ';
        cases.OwnerId=userInfo.getUserId();
        // Cases.PO_Durata_affitto__c =1;
        insert cases;
        System.debug('@@cases '+cases);
        Case cases1 = new Case();
        cases1.parentid = cases.id;
        cases1.PO_Case_Collegamento__c=cases.id;
        cases1.PO_Durata_affitto__c =1;
        // cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Richiesta_a_servizio_a_fattibilit'].id ;
        cases1.status = 'Accettato';
        cases1.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases1.OwnerId = '0058E000002dUEZ';
        cases1.OwnerId=userInfo.getUserId();
        cases1.PO_Richiesta_a_fattibilit__c=cases.id;
        insert cases1;
        
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        List<Asset> assList = new List<Asset>();
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = cases1.iD;
        assList.add(asst1);
        insert assList;
        
        
        
        
        OF_CatalogoCommerciale__c cc = new OF_CatalogoCommerciale__c();
        cc.Name = 'test';
        cc.OF_DataFineValidita__c = System.today();
        cc.OF_DataInizioValidita__c = System.today();
        insert cc;
        
        OF_Servizio__c se = new OF_Servizio__c();
        se.Name = 'Fiber Lease';
        se.OF_DataFineValidita__c = System.today();
        se.OF_DataInizioValidita__c = System.today();
        se.OF_CatalogoCommerciale__c = cc.Id;
        insert se;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name = 'test';
        ce.OF_DataFineValidita__c = System.today();
        ce.OF_DataInizioValidita__c = System.today();
        ce.OF_Servizio__c = se.Id;
        insert ce;
        
        list<OF_CommercialElementIstanziato__c> comlst = new list<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = assList[0].Id;
        commercial.OF_AssetTratta__c = assList[0].Id;
        commercial.OF_Case__c = cases1.Id;
        commercial.OF_CaseTratta__c = cases1.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        comlst.add(commercial);
        //commercial.recordtypeid =rtId;
        insert comlst;
        
        PO_FATT_WS_IN_UtilitiesPortalino util = new PO_FATT_WS_IN_UtilitiesPortalino();
        util.AssociazioneTRATTEAsset(assList);
        
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // cases.PO_Durata_affitto__c =1;
        //update cases;
        
        Opportunity OppRecA1 = new Opportunity();
        OppRecA1.AccountId = Acc.Id;
        OppRecA1.name='Opp' ;
        OppRecA1.stageName='Open';
        OppRecA1.closeDate=Date.newInstance(2008,10,10);
        OppRecA1.PO_Richiesta_fattibilit__c=cases.Id;
        OppRecA1.PO_Collegamento__c=cases.Id;
        insert OppRecA1;
        // OppRecA1.PO_Richiesta_fattibilit__c=cases1.Id;
        // update OppRecA1;
         opportunity parentOpp=[select id,name,AccountId,stageName,PO_Richiesta_fattibilit__c,PO_Richiesta_fattibilit__r.PO_Durata_affitto__c,PO_Durata_affitto__c from Opportunity where id=:OppRecA1.id];
        system.debug('=+=+=+=OppRecA1=+=+=+='+OppRecA1);             
        system.debug('cases.Id e'+cases.Id+' **  cases.PO_Durata_affitto__c: '+cases.PO_Durata_affitto__c);
        system.debug('$$$$$$$ OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c '+parentOpp.PO_Durata_affitto__c + ' xxx ' + parentOpp.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c);       
        // Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp1',PO_Collegamento__c = cases1.Id,PO_Offerta_totale__c=OppRecA1.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp1',PO_Offerta_totale__c=OppRecA1.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA;
        //OppRecA.PO_Offerta_totale__r.PO_Durata_affitto__c=1;
        update OppRecA;
        opportunity childOpp=[select id,name,PO_Offerta_totale__r.PO_Durata_affitto__c,PO_Offerta_totale__c,Pricebook2Id,priceBook2.PO_Commercial_element__c from Opportunity where id=:OppRecA.id];
        system.debug('TOTTI***===' + OppRecA1.PO_Durata_affitto__c); 
        system.debug('$$$$$$$ OppRecA '+childOpp.PO_Offerta_totale__r.PO_Durata_affitto__c);    
        // update OppRecA1;
        
        system.debug('$$$$$$$'+childOpp.PO_Offerta_totale__r.PO_Durata_affitto__c);
        
        Product2 p = new Product2(name='x',PO_Anni_Fiber_Link__c ='3 Anni');
        insert p;
        assList[0].Product2 = p;
        update assList[0];
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        PricebookEntry pbe1 = new PricebookEntry( Pricebook2Id = stdPb.Id, product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe1;
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = childOpp.Id, Product2Id=p.Id,pricebookentryid=pbe1.id,UnitPrice = 1.0, Quantity = 3);
        insert OppLI_Rec;
         
       OpportunityLineItem Opplineitem =[select id,OpportunityId,Product2Id,Product2.PO_Anni_Fiber_Link__c,pricebookentryid,UnitPrice,Quantity from OpportunityLineItem where id=:OppLI_Rec.id]; 
        

        
        
        
               
        util.MappaAssetOpportunity.put(assList[0].Id,childOpp); 
        
        Map<Id,Opportunity> tempoppmap=new Map<Id,Opportunity>();
        tempoppmap.put(assList[0].Id,childOpp);
        Map<id,OpportunityLineItem> opplinemap=New Map<id,OpportunityLineItem>();
        opplinemap.put(Opplineitem.Id,Opplineitem);
        
        Map<Id,PriceBook2> temp1=New Map<Id,PriceBook2>();
        temp1.put(Opplineitem.Id,stdPb);
        
        Map<Id,Map<Id,PriceBook2>> temp2=New Map<Id,Map<Id,PriceBook2>>();
        temp2.put(assList[0].Id,temp1); 
        
        Map<Id,OF_CommercialElementIstanziato__c> temp3=new Map<Id,OF_CommercialElementIstanziato__c>();
        temp3.put(assList[0].Id,comlst[0]);
        util.MappaAssetOpportunity=tempoppmap;
        util.MapOppoLineItem=opplinemap;

        util.Method_CreatePBE1(temp2, 'FiberLink');//[GP 11/01/2018]
        util.createBE_FiberLink1(temp2,temp3);
        
    }
    
    
    public static testmethod void UtilitiesPortalinoMethod6(){   
   /*     ServFattib__C cs=new ServFattib__C(creaOppParentFase__c='Offerta Creata',
                                           creaOppParentOfferta__c='\'P2P Base\',\'IRU\',\'Fiber Link\',\'Fiber Lease\',\'Evento Temporaneo\'',
                                           creaOppParentRecordTypeName__c='PO Richiesta a servizio a fattibilità',
                                           creaOppChildFase__c='Completato',
                                           creaOppChildRecordTypeName__c='\'PO Collegamento P2P\',\'PO Collegamento IRU\',\'PO Collegamento Fiber Lease\',\'PO Collegamento Fiber link\',\'PO Collegamento Evento Temporaneo\'');
        insert cs;
     */   
        Case cases = new Case();
        cases.PO_Durata_affitto__c =5;
        // cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Richiesta_a_servizio_a_fattibilit'].id ;
        cases.PO_Durata_affitto__c =5;
        cases.status = 'Accettato';
        cases.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases.OwnerId = '0058E000002dUEZ';
        cases.OwnerId=userInfo.getUserId();
        // Cases.PO_Durata_affitto__c =1;
        insert cases;
        System.debug('@@cases '+cases);
        Case cases1 = new Case();
        cases1.parentid = cases.id;
        cases1.PO_Case_Collegamento__c=cases.id;
        cases1.PO_Durata_affitto__c =1;
        // cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'].id ;
        cases1.RecordtypeId = [select id from recordtype where sobjectType='Case' and Developername='PO_Richiesta_a_servizio_a_fattibilit'].id ;
        cases1.status = 'Accettato';
        cases1.EOF_Fase__c = 'In Verifica Supporto Vendite';
        //cases1.OwnerId = '0058E000002dUEZ';
        cases1.OwnerId=userInfo.getUserId();
        cases1.PO_Richiesta_a_fattibilit__c=cases.id;
        insert cases1;
        
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        List<Asset> assList = new List<Asset>();
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = cases1.iD;
        assList.add(asst1);
        insert assList;
        
        
        
        
        OF_CatalogoCommerciale__c cc = new OF_CatalogoCommerciale__c();
        cc.Name = 'test';
        cc.OF_DataFineValidita__c = System.today();
        cc.OF_DataInizioValidita__c = System.today();
        insert cc;
        
        OF_Servizio__c se = new OF_Servizio__c();
        se.Name = 'Fiber Lease';
        se.OF_DataFineValidita__c = System.today();
        se.OF_DataInizioValidita__c = System.today();
        se.OF_CatalogoCommerciale__c = cc.Id;
        insert se;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.Name = 'test';
        ce.OF_DataFineValidita__c = System.today();
        ce.OF_DataInizioValidita__c = System.today();
        ce.OF_Servizio__c = se.Id;
        insert ce;
        
        list<OF_CommercialElementIstanziato__c> comlst = new list<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = assList[0].Id;
        commercial.OF_AssetTratta__c = assList[0].Id;
        commercial.OF_Case__c = cases1.Id;
        commercial.OF_CaseTratta__c = cases1.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        comlst.add(commercial);
        //commercial.recordtypeid =rtId;
        insert comlst;
        
        PO_FATT_WS_IN_UtilitiesPortalino util = new PO_FATT_WS_IN_UtilitiesPortalino();
        util.AssociazioneTRATTEAsset(assList);
        
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // cases.PO_Durata_affitto__c =1;
        //update cases;
        
        Opportunity OppRecA1 = new Opportunity();
        OppRecA1.AccountId = Acc.Id;
        OppRecA1.name='Opp' ;
        OppRecA1.stageName='Open';
        OppRecA1.closeDate=Date.newInstance(2008,10,10);
        OppRecA1.PO_Richiesta_fattibilit__c=cases.Id;
        OppRecA1.PO_Collegamento__c=cases.Id;
        insert OppRecA1;
        // OppRecA1.PO_Richiesta_fattibilit__c=cases1.Id;
        // update OppRecA1;
         opportunity parentOpp=[select id,name,AccountId,stageName,PO_Richiesta_fattibilit__c,PO_Richiesta_fattibilit__r.PO_Durata_affitto__c,PO_Durata_affitto__c from Opportunity where id=:OppRecA1.id];
        system.debug('=+=+=+=OppRecA1=+=+=+='+OppRecA1);             
        system.debug('cases.Id e'+cases.Id+' **  cases.PO_Durata_affitto__c: '+cases.PO_Durata_affitto__c);
        system.debug('$$$$$$$ OppRecA1.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c '+parentOpp.PO_Durata_affitto__c + ' xxx ' + parentOpp.PO_Richiesta_fattibilit__r.PO_Durata_affitto__c);       
        // Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp1',PO_Collegamento__c = cases1.Id,PO_Offerta_totale__c=OppRecA1.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp1',PO_Offerta_totale__c=OppRecA1.Id,stageName='Open', closeDate=Date.newInstance(2008,10,10));
        insert OppRecA;
        //OppRecA.PO_Offerta_totale__r.PO_Durata_affitto__c=1;
        update OppRecA;
        opportunity childOpp=[select id,name,PO_Offerta_totale__r.PO_Durata_affitto__c,PO_Offerta_totale__c,Pricebook2Id,priceBook2.PO_Commercial_element__c from Opportunity where id=:OppRecA.id];
        system.debug('TOTTI***===' + OppRecA1.PO_Durata_affitto__c); 
        system.debug('$$$$$$$ OppRecA '+childOpp.PO_Offerta_totale__r.PO_Durata_affitto__c);    
        // update OppRecA1;
        
        system.debug('$$$$$$$'+childOpp.PO_Offerta_totale__r.PO_Durata_affitto__c);
        
        Product2 p = new Product2(name='x',PO_Anni_Fiber_Link__c ='X Anni');
        insert p;
        assList[0].Product2 = p;
        update assList[0];
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        PricebookEntry pbe1 = new PricebookEntry( Pricebook2Id = stdPb.Id, product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe1;
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = childOpp.Id, Product2Id=p.Id,pricebookentryid=pbe1.id, UnitPrice = 1.0, Quantity = 3);
        insert OppLI_Rec;
         
       OpportunityLineItem Opplineitem =[select id,OpportunityId,Product2Id,Product2.PO_Anni_Fiber_Link__c,pricebookentryid,UnitPrice,Quantity from OpportunityLineItem where id=:OppLI_Rec.id]; 
        

        
        
        
               
        util.MappaAssetOpportunity.put(assList[0].Id,childOpp); 
        
        Map<Id,Opportunity> tempoppmap=new Map<Id,Opportunity>();
        tempoppmap.put(assList[0].Id,childOpp);
        Map<id,OpportunityLineItem> opplinemap=New Map<id,OpportunityLineItem>();
        opplinemap.put(Opplineitem.Id,Opplineitem);
        
        Map<Id,PriceBook2> temp1=New Map<Id,PriceBook2>();
        temp1.put(Opplineitem.Id,stdPb);
        
        Map<Id,Map<Id,PriceBook2>> temp2=New Map<Id,Map<Id,PriceBook2>>();
        temp2.put(assList[0].Id,temp1); 
        
        Map<Id,OF_CommercialElementIstanziato__c> temp3=new Map<Id,OF_CommercialElementIstanziato__c>();
        temp3.put(assList[0].Id,comlst[0]);
        util.MappaAssetOpportunity=tempoppmap;
        util.MapOppoLineItem=opplinemap;

        util.Method_CreatePBE1(temp2, 'FiberLink');//[GP 11/01/2018]
        util.createBE_FiberLink1(temp2,temp3);
        
    }
  //---------------------------------------------------------------------------------------------------------------
 
}
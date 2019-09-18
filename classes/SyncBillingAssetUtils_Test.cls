@isTest
public class SyncBillingAssetUtils_Test {
    
    @testSetup
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        Insert new Verticali__c(RecordTypesAssets__c ='\'PO_Asset_Backhauling_Collegamento\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'', createNotifyBatchLimit__c = 10000, callWsBillingBatchSize__c = 4,RecorTypesList__c = '\'OF_ServiziAggiuntivi\',\'OF_CPE\',\'OF_VLAN\',\'OF_Standard\',\'PO_Portalino\'');
    }

    public static testMethod void test_callWSAssetVerticaleCustom1() {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.EOF_Codice_Operatore__c='te';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc1.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.OF_ProfiloOpenStream__c = 'TEST_T';
        asset_1.accountId = acc1.id;
        asset_1.Sync_Verticali__c = true;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        
        insert asset_1;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        Order ordine = new Order();
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        //ordine.OF_CaseID__c = c.id;
        ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Chiuso';
        ordine.OF_Esito__c='OK';
        ordine.ContractId= contratto1.id;
        ordine.RecordTypeId=OrderRecordTypeId;
        ordine.OF_IDOrdineOLO__c='te';
        
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        List<OF_CommercialElementIstanziato__c> ceis = new  List<OF_CommercialElementIstanziato__c>();
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        CEI.OF_Case__c=c.ID;
        
        ceis.add(CEI);
        
        
        OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
        CEI2.OF_Asset__c=asset_1.id;
        CEI2.OF_Stato__c='Cessato';
        CEI2.OF_CommercialElement__c=ce.id;
        CEI2.RecordTypeId=CeiRecordTypeId;
        CEI2.OF_DataAttivazione__c=DATETIME.now();
        CEI2.Asset_Verticale__c=va.id;
        CEI2.OF_Case__c=c.ID;
        ceis.add(CEI2);
        
        OF_CommercialElementIstanziato__c CEI3=new OF_CommercialElementIstanziato__c();
        CEI3.OF_Asset__c=asset_1.id;
        CEI3.OF_Stato__c='Cessato';
        CEI3.OF_CommercialElement__c=ce.id;
        CEI3.RecordTypeId=CeiRecordTypeId;
        CEI3.OF_DataAttivazione__c=DATETIME.now();
        CEI3.Asset_Verticale__c=va.id;
        CEI3.OF_Case__c=c.ID;
        ceis.add(CEI3);
        
        OF_CommercialElementIstanziato__c CEI4=new OF_CommercialElementIstanziato__c();
        CEI4.OF_Asset__c=asset_1.id;
        CEI4.OF_Stato__c='Attivo';
        CEI4.OF_BillingSyncronized__c = true;
        CEI4.OF_CommercialElement__c=ce.id;
        CEI4.RecordTypeId=CeiRecordTypeId;
        CEI4.OF_DataAttivazione__c=DATETIME.now();
        CEI4.Asset_Verticale__c=va.id;
        CEI4.OF_Case__c=c.ID;
        
        ceis.add(CEI4);
        
        insert ceis;
        
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id,
            OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        
        String IdCei =(String)CEI.id;
        List<String> AssetIdList=new  List<String>();
        String asset_idString=(String)asset_1.id;
        AssetIdList.add(asset_idString);
        //String idNotifica ='';
        Test.startTest();
        Test.setMock(WebServiceMock.class, new SyncBillingAssettUtils_Mock());
        SyncBillingAssetUtils.callWSAssetVerticaleCustom(AssetIdList);
        Test.stopTest();
        
    }
    
    
    
    public static testMethod void test_callWSAssetVerticaleCustom2()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc1.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.ContractId= contratto1.id;
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        // CEI.Provincia__c='TEST';
        //CEI.Comune__c='TEST';
        //CEI.Indirizzo__c='TEST';
        //CEI.Civico__c='TEST';
        
        insert CEI;
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id,
            OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        
        
        String IdCei =(String)CEI.id;
        List<String> AssetIdList=new  List<String>();
        String asset_idString=(String)asset_1.id;
        AssetIdList.add(asset_idString);
        //String idNotifica ='';
        SyncBillingAssetUtils.callWSAssetVerticaleCustom(AssetIdList);
        
    }
    
    
    public static testMethod void test_callWSAssetFattibilitaCustom()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc1.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.ContractId= contratto1.id;
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Portalino').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        // CEI.Provincia__c='TEST';
        //CEI.Comune__c='TEST';
        //CEI.Indirizzo__c='TEST';
        //CEI.Civico__c='TEST';
        
        insert CEI;
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id,
            OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        
        
        String IdCei =(String)CEI.id;
        List<String> AssetIdList=new  List<String>();
        String asset_idString=(String)asset_1.id;
        AssetIdList.add(asset_idString);
        //String idNotifica ='';
        SyncBillingAssetUtils.callWSAssetFattibilitaCustom(new list<OF_CommercialElementIstanziato__c> {CEI});
        
    }
    
    
        public static testMethod void test_callWSOpenStreamCustom()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.AccountId= acc.Id;
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.OF_ProfiloOpenStream__c='TEST_T';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.OF_ID_Building__c='1';
        asset_1.OF_Comune__c='1';
        asset_1.OF_Indirizzo__c='1';
        asset_1.OF_Civico__c='1';
        asset_1.OF_Particella_Toponomastica__c='1';
        
        
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
        
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Chiuso';
        ordine.OF_IDOrdineOLO__c='test';
        ordine.OF_Esito__c = 'OK';
        ordine.ContractId= contratto1.id;
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Standard').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        
        insert CEI;
        
        CEI = [select id,OF_Asset__c,Name,
               OF_Asset__r.Account.AccountNumber,
               OF_Asset__r.OF_DataAttivazione2__c,
               OF_Asset__r.recordType.name,
               OF_DataAttivazione__c,
               OF_Stato__c,
               OF_DataCessazione__c,
               OF_CommercialElement__r.OF_Commercial_Element_Code__c,
               OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,
               OF_Asset__r.OF_ID_Building__c,
               OF_Asset__r.OF_Comune__c,
               OF_Asset__r.OF_Indirizzo__c,
               OF_Asset__r.OF_Civico__c,
               OF_Asset__r.OF_ProfiloOpenStream__c,
               OF_DataSospensione__c,
               OF_BillingSyncronized__c,
               OF_Asset__r.OF_Particella_Toponomastica__c,
               OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c,
               OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c,
               OF_Asset__r.EOF_ID_Risorsa__c,
               OF_Asset__r.recordType.developername,
               recordType.DeveloperName
               from OF_CommercialElementIstanziato__c limit 1];
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Canone',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id,
            OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        

        
        SyncBillingAssetUtils.callWSAssetFattibilitaCustom(new List<OF_CommercialElementIstanziato__c> {CEI});
        
    }
    
    
    
    public static testMethod void test_callWSAssetVerticaleByCei1()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.id;
        insert asset_1;
        
        
        
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '0211201';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        insert ce;
        
        Id recId = [select Id from RecordType where DeveloperName = 'EOF_Bill_Asset' limit 1].Id;
        Id recIdCEI = [select Id from RecordType where DeveloperName = 'Verticale' limit 1].Id;
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.RecordTypeId=recIdCEI;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        insert CEI;
        
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id
        );
        insert testPbe;
        
        
        
        EOF_Notify__c notifica =new EOF_Notify__c();
        notifica.RecordTypeId = recId;
        notifica.EOF_ID_Notifica__c='test';
        insert notifica;
        
        
        
        String IdCei =(String)CEI.id;
        String idNotifica =notifica.EOF_ID_Notifica__c;
        SyncBillingAssetUtils.callWSAssetVerticaleByCei(IdCei, idNotifica);
        
    }
    
    // edited on 9th jan 2019
    public static testMethod void test_callWSAssetVerticaleByCei2()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.EOF_Codice_Operatore__c='te';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc1.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc1.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        
        insert asset_1;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        Order ordine = new Order();
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        //ordine.OF_CaseID__c = c.id;
        ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Chiuso';
        ordine.OF_Esito__c='OK';
        ordine.ContractId= contratto1.id;
        ordine.RecordTypeId=OrderRecordTypeId;
        
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        Id recId = [select Id from RecordType where DeveloperName = 'EOF_Bill_Asset' limit 1].Id;
        Id recIdCEI = [select Id from RecordType where DeveloperName = 'Verticale' limit 1].Id;
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=recIdCEI;
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        CEI.OF_Case__c=c.ID;
        
        // CEI.Provincia__c='TEST';
        //CEI.Comune__c='TEST';
        //CEI.Indirizzo__c='TEST';
        //CEI.Civico__c='TEST';
        
        insert CEI;
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id,
            OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        
        OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType req = new OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType();
        
        
        EOF_Notify__c notifica =new EOF_Notify__c();
        notifica.OF_JsonRequest__c = JSON.serialize(req);
        notifica.RecordTypeId = recId;
        notifica.EOF_ID_Notifica__c='test';
        insert notifica;
        
        
        String IdCei =(String)CEI.id;
        String idNotifica =notifica.EOF_ID_Notifica__c;
        Test.startTest();
        Test.setMock(WebServiceMock.class, new SyncBillingAssettUtils_Mock());
        SyncBillingAssetUtils.callWSAssetVerticaleByCei(IdCei, idNotifica);
        Test.stopTest();
    }
    // for idnotifica not blank
    public static testMethod void test_callWSAssetVerticaleByCei3()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = '';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc1.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.ContractId= contratto1.id;
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        Id recId = [select Id from RecordType where DeveloperName = 'EOF_Bill_Asset' limit 1].Id;
        Id recIdCEI = [select Id from RecordType where DeveloperName = 'Verticale' limit 1].Id;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=recIdCEI;
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        // CEI.Provincia__c='TEST';
        //CEI.Comune__c='TEST';
        //CEI.Indirizzo__c='TEST';
        //CEI.Civico__c='TEST';
        
        insert CEI;
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id
            //OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        
        
        EOF_Notify__c notifica =new EOF_Notify__c();
        notifica.EOF_ID_Notifica__c='test';
        notifica.RecordTypeId = recId;
        insert notifica;
        
        String IdCei =(String)CEI.id;
        String idNotifica ='test';
        SyncBillingAssetUtils.callWSAssetVerticaleByCei(IdCei, idNotifica);
    }
    // for 80
    public static testMethod void test_callWSAssetVerticaleByCei4()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        //contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = '';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc1.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.ContractId= contratto1.id;
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        Id recId = [select Id from RecordType where DeveloperName = 'EOF_Bill_Asset' limit 1].Id;
        Id recIdCEI = [select Id from RecordType where DeveloperName = 'Verticale' limit 1].Id;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=recIdCEI;
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        // CEI.Provincia__c='TEST';
        //CEI.Comune__c='TEST';
        //CEI.Indirizzo__c='TEST';
        //CEI.Civico__c='TEST';
        
        insert CEI;
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id
            //OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        
        
        EOF_Notify__c notifica =new EOF_Notify__c();
        notifica.EOF_ID_Notifica__c='test';
        notifica.RecordTypeId=recId;
        insert notifica;
        
        String IdCei =(String)CEI.id;
        String idNotifica ='test';
        SyncBillingAssetUtils.callWSAssetVerticaleByCei(IdCei, idNotifica);
    }
    
    
    
    
    public static testMethod void test_callWSAssetVerticaleByCei5()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc1.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        string assetid=(string)asset_1.id;
        SyncBillingAssetUtils.callVerticalBatch(assetid);
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        list<OF_Asset_Verticale__c> valist = new list<OF_Asset_Verticale__c>();
        valist.add(va);
        
        SyncBillingAssetUtils.UpdateAssetVert(valist);
        
        OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
        verticalBE.name = 'BEV-' + asset_1.EOF_ID_Risorsa__c;
        verticalBE.ID_Risorsa__c = 'test';
        // verticalBE.OLO__c = c.EOF_Account_OLO__c;
        verticalBE.Data_Attivazione__c = System.now();
        //Relaziono il BE Verticale all'Asset Standard
        verticalBE.Asset__c = asset_1.id;
        //Relaziono il BE Verticale all'Asset Verticale
        verticalBE.Asset_Verticale__c = va.id;
        verticalBE.Update_Billing__c =true;
        insert verticalBE;
        
        
        list<OF_Billing_Element_Verticale__c> bvalist = new list<OF_Billing_Element_Verticale__c>();
        bvalist.add(verticalBE);
        
        SyncBillingAssetUtils.UpdateBev(bvalist);
        SyncBillingAssetUtils.getListAssetId(bvalist);
        
        //edited on 9th jan
        list<string> lisasset = new list<string>();
        lisasset.add((string)asset_1.id);
        SyncBillingAssetUtils.getBEV(lisasset);
        SyncBillingAssetUtils.getVErts((string)va.id);
        
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        Id recId = [select Id from RecordType where DeveloperName = 'EOF_Bill_Asset' limit 1].Id;
        Id recIdCEI = [select Id from RecordType where DeveloperName = 'Verticale' limit 1].Id;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=recIdCEI;
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        // CEI.Provincia__c='TEST';
        //CEI.Comune__c='TEST';
        //CEI.Indirizzo__c='TEST';
        //CEI.Civico__c='TEST';
        
        insert CEI;
        
        SyncBillingAssetUtils.getCeiById((string)CEI.ID);
        
        
    }
    
    public static testMethod void test_callWSAssetVerticaleCustomFatt() {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.EOF_Codice_Operatore__c='te';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc1.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.OF_ID_Building__c ='234';
        asset_1.OF_Comune__c ='Napoli';
        asset_1.OF_Indirizzo__c ='Via TEst 34';
        asset_1.OF_Civico__c ='34';
        asset_1.OF_Particella_Toponomastica__c ='Via';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        
        insert asset_1;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na';
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001';
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234';
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
        
        Order ordine = new Order();
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
        //ordine.OF_CaseID__c = c.id;
        ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc1.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Chiuso';
        ordine.OF_Esito__c='OK';
        ordine.ContractId= contratto1.id;
        ordine.RecordTypeId=OrderRecordTypeId;
        ordine.OF_IDOrdineOLO__c='te';
        
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc1;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OLO_ORDER_CODE__c='test';
        
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        
        insert ce;
        
        List<OF_CommercialElementIstanziato__c> ceis = new  List<OF_CommercialElementIstanziato__c>();
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Portalino').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        CEI.OF_Case__c=c.ID;
        
        ceis.add(CEI);
        
        insert ceis;
        
        
        // OF_CommercialElementIstanziato__c CEI1=[select OF_Asset__c,OF_Stato__c,OF_CommercialElement__c,RecordTypeId,OF_DataAttivazione__c,Provincia__c from OF_CommercialElementIstanziato__c];
        
        //insert CEI1;
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id,
            OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;
        
        String IdCei =(String)CEI.id;
        List<String> AssetIdList=new  List<String>();
        String asset_idString=(String)asset_1.id;
        AssetIdList.add(asset_idString);
        //String idNotifica ='';
        Test.startTest();
        Test.setMock(WebServiceMock.class, new SyncBillingAssettUtils_Mock());
        SyncBillingAssetUtils.callWSAssetFattibilitaCustom(ceis);
        Test.stopTest();
        
    }
    
    public static testmethod void test_getListAssetId2()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.AccountNumber='123456';
        insert acc;
        
        Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.BillingFrequency__c='Monthly';
        //contratto.ContractNumber='test';
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,ContractNumber,BillingFrequency__c from Contract];
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc1.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        
        asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
        SyncBillingAssetUtils.getListAssetId(new List<Asset> {asset_1});
        
    }
    
    public static testmethod void test_CallCei()
    {
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.id;
        insert asset_1;
        
        
        
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '0211201';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        insert c;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        insert ce;
        
        Id recId = [select Id from RecordType where DeveloperName = 'EOF_Bill_Asset' limit 1].Id;
        Id recIdCEI = [select Id from RecordType where DeveloperName = 'Verticale' limit 1].Id;
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.RecordTypeId=recIdCEI;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        insert CEI;
        
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        // Run an update DML on the Pricebook2 record
        // This is the weird workaround that enables IsStandard to become true
        // on the PricebookEntry record
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2
                             WHERE Id = : standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id
        );
        insert testPbe;
        
        
        
        OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType req = new OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType();
        
        
        EOF_Notify__c notifica =new EOF_Notify__c();
        notifica.OF_JsonRequest__c = JSON.serialize(req);
        notifica.RecordTypeId = recId;
        notifica.EOF_ID_Notifica__c='test';
        insert notifica;
        
        
        String IdCei =(String)CEI.id;
        String idNotifica =notifica.EOF_ID_Notifica__c;
        Test.startTest();
        Test.setMock(WebServiceMock.class, new SyncBillingAssettUtils_Mock());
        SyncBillingAssetUtils.CallCei(IdCei, idNotifica);
        TEst.stopTest();
    }
    
    public static testmethod void test_callFattibilitaBatch()
    {
        SyncBillingAssetUtils.callFattibilitaBatch('');
    }
    
}
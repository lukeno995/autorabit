@isTest
public class OF_CD_CRMHandler_Test {

    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select DeveloperName, Id 
                                   From RecordType 
                                   where (sObjectType='Case' 
                                       OR sObjectType='Account' 
                                       OR sObjectType='Contact' 
                                       OR sObjectType = 'EOF_EAI_Service_Log__c')];
        
        Map<String,String> RecordType = new Map<String,String>{};
        
        for(RecordType rt: rtypes)
            RecordType.put(rt.DeveloperName, rt.Id);
                
       return RecordType;
    }
    
    public static testMethod void manageAssetTest()
    {
        createVerticaliCustomSetting();
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 
        
        Map<String,String> RecordTypeMap = RecordType(); 
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';    
        insert c;
        
        case c1 = [select id,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
                   EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
                   OF_Esito_Consegna_Apparato__c 
                   FROM case];
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
        
        Order ordine = new Order();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = a.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.OF_Contratto__c=contratto.id;
        insert ordine;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
        OF_CD_CRMHandler.CreateAsset(c, ordine);
        
        OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
        //CEI.Name='Test';
        CEI1.OF_Asset__c=asset_1.id;
        CEI1.OF_Stato__c='Attivo';
        CEI1.RecordTypeId=ComRecordTypeId1;
        CEI1.OF_Case__c=c.id;
        CEI1.OF_EsitoConsegnaApparato__c='1';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI1;
        
        OF_CD_CRMHandler.CreateAsset(c, ordine);
        
        OF_CommercialElementIstanziato__c CEI2 = new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
        //CEI.Name='Test';
        CEI2.OF_Asset__c=asset_1.id;
        CEI2.OF_Stato__c='Attivo';
        CEI2.RecordTypeId=ComRecordTypeId1;
        CEI2.OF_Case__c=c.id;
        CEI2.OF_EsitoConsegnaApparato__c='0';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI2;
        
        // OF_CD_CRMHandler.CreateAsset(c, ordine);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO OPEN STREAM BASE';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio1;
        ce.OF_DataFineValidita__c = fine1;
        ce.OF_Servizio__c = servizio.id;
        insert ce;
        
        OF_CommercialElement__c ce1 = new OF_CommercialElement__c();
        
        Date ini = Date.newInstance(2016,1,1);
        Date fin= Date.newInstance(2099,12,31);
        ce1.name = 'RIBALTAMENTO IMPIANTO';
        ce1.OF_Attivo__c = true;
        ce1.OF_DataInizioValidita__c = ini;
        ce1.OF_DataFineValidita__c = fin;
        ce1.OF_Servizio__c = servizio.id;
        insert ce1;
        
        List<OF_CommercialElementIstanziato__c> comList = new List<OF_CommercialElementIstanziato__c>();
        comList.add(CEI2);
        comList.add(CEI1);
        
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
                            WHERE Id = :standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Attivazione',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true
        );
        insert testPbe;
        
        Product2 testProduct1 = new Product2(
            Name = 'Contributo Consegna e Istallazione',
            IsActive = true
        );
        insert testProduct1;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =true
        );
        insert testPbe1;   
        
        Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id);
        
        insert customPB;
       
        // OF_CD_CRMHandler.cpeRibImp=false;
        OF_CD_CRMHandler.CreateAsset(c1,ordine);
        OF_CD_CRMHandler.inactivateAssetCe(c1,ordine);
        OF_CD_CRMHandler.inactivateBE(c1,ordine);
    }
      
    public static testMethod void changeOrderMethod_test(){
    
        Id RecordTypeIdlis = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();

        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdcom);
        
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
    
        order ord = new order();
        ord.OF_Profilo__c = 'Test';
        ord.AccountId = acc.Id;
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        contract con = new contract();
        con.AccountID = acc.Id;
        con.OF_IdContratto__c = 'Test';
        con.StartDate = System.today();
        con.ContractTerm = 1234;
        con.Status = 'Draft';
        insert con;
        
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = ser1.Id;
        com.name = 'SERVIZIO OPEN STREAM BASE';
        insert com;
        
        OF_BillingElement__c bill = new OF_BillingElement__c ();
        bill.Name = 'Contributo Cambio Profilo';
        bill.OF_CommercialElement__c = com.Id;
        bill.OF_DataInizioValidita__c = System.today();
        bill.OF_DataFineValidita__c = System.today();
        insert bill;
        
        OF_ServizioBillingElement__c ser = new OF_ServizioBillingElement__c();
        ser.name = 'Contributo Cambio Profilo';
        ser.OF_BillingElement__c = bill.Id;
        ser.OF_Contract__c = con.Id;
        insert ser;
        
        OF_Listino__c lis = new OF_Listino__c();
        lis.Name = 'Test';
        lis.OF_Attivo__c = true;
        lis.OF_IDContract__c= con.Id;
        lis.OF_DataFineValidita__c = System.today();
        lis.OF_DataInizioValidita__c = System.today();
        lis.RecordTypeId = RecordTypeIdlis;
        lis.OF_ServizioBillingElement__c =ser.Id;
        insert lis;
        
        OF_Listino__c lis1 = new OF_Listino__c();
        lis1.Name = 'Contributo Cambio Profilo';
        lis1.OF_Attivo__c = true;
        lis1.OF_IDContract__c= con.Id;
        lis1.OF_DataFineValidita__c = System.today();
        lis1.OF_DataInizioValidita__c = System.today();
        lis1.RecordTypeId = RecordTypeIdlis;
        lis1.OF_ServizioBillingElement__c =ser.Id;
        insert lis1;
        List<OF_CommercialElementIstanziato__c> comList = new List<OF_CommercialElementIstanziato__c>();
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =a.Id;
        istan.OF_Asset__c  = a.id;
        istan.OF_CommercialElement__c = com.Id;
        istan.RecordTypeId = RecordTypeIdcom;
        insert istan;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware',OF_ListinoCustom__c =lis.Id);
        insert prod;
        // prod.name = 'Contributo Cambio Profilo';
        // update prod;
        
        //Id pricebookId = Test.getStandardPricebookId();
        
        //PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = prod.Id, UnitPrice = 10000, IsActive = true);
        //insert standardPrice;
        
        Id pricebookId = Test.getStandardPricebookId();
    
        pricebook2 priceB = new Pricebook2(
          Name='Canone', isActive=true,OF_Listino__c = lis.Id
        );
        insert priceB;
        
        pricebookentry pbeStd = new pricebookentry(
          Product2Id = prod.id,
            Pricebook2Id = pricebookId,
            isActive = true,
            unitprice = -9999
        );
        insert pbeStd;
        
        pricebookentry pbe = new pricebookentry(
            Product2Id = prod.id,
            Pricebook2Id = priceB.Id,
            isActive = true,
            UnitPrice = -9999,
            OF_Asset__c = a.Id,OF_DataCessazione2__c = system.today(),OF_CommercialElementIstanziato__c =istan.id
            
        );
        insert pbe;
        
        OF_CD_CRMHandler.manageAssetBillingElement(a.Id,ord);
        OF_CD_CRMHandler.manageAssetVlan(a.Id,comList);
    }

    public static testMethod void CreateAsset_Test3()
    {
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 
        
        Map<String,String> RecordTypeMap = RecordType(); 
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF SP Caso Attivazione CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='1';    
        insert c;
        
        case c1 = [select id,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
                   EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
                   OF_Esito_Consegna_Apparato__c
                   FROM case];
       
        Order ordine = new Order();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        //ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.OF_Contratto__c=contratto.id;
        insert ordine;
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
        OF_CD_CRMHandler.CreateAsset(c, ordine);
        
        OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
        //CEI.Name='Test';
        CEI1.OF_Asset__c=asset_1.id;
        CEI1.OF_Stato__c='Attivo';
        CEI1.RecordTypeId=ComRecordTypeId1;
        CEI1.OF_Case__c=c.id;
        CEI1.OF_EsitoConsegnaApparato__c='1';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI1;
        
        OF_CD_CRMHandler.CreateAsset(c, ordine);
        
        OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
        //CEI.Name='Test';
        CEI2.OF_Asset__c=asset_1.id;
        CEI2.OF_Stato__c='Attivo';
        CEI2.RecordTypeId=ComRecordTypeId1;
        CEI2.OF_Case__c=c.id;
        CEI2.OF_EsitoConsegnaApparato__c='0';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI2;
        
        // OF_CD_CRMHandler.CreateAsset(c, ordine);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
      
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'GPON Passiva CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO FIBRA BASE';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio1;
        ce.OF_DataFineValidita__c = fine1;
        ce.OF_Servizio__c = servizio.id;
        insert ce;
        
        OF_CommercialElement__c ce1 = new OF_CommercialElement__c();
        
        Date ini = Date.newInstance(2016,1,1);
        Date fin= Date.newInstance(2099,12,31);
        ce1.name = 'RIBALTAMENTO IMPIANTO';
        ce1.OF_Attivo__c = true;
        ce1.OF_DataInizioValidita__c = ini;
        ce1.OF_DataFineValidita__c = fin;
        ce1.OF_Servizio__c = servizio.id;
        insert ce1;
        
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );        
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard 
                            FROM Pricebook2 
                            WHERE Id = :standardPricebook.Id];
        
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
            IsActive = true
        );
        insert testPbe;
        
        Product2 testProduct1 = new Product2(
            Name = 'Canone',
            IsActive = true
        );
        insert testProduct1;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =true
        );
        insert testPbe1;   
        
        Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id);
        
        insert customPB;
       
        // OF_CD_CRMHandler.cpeRibImp=false;
        OF_CD_CRMHandler.CreateAsset(c1,ordine);
    }

    public static testMethod void createVLANBE_Test()
    {
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 
        
        Map<String,String> RecordTypeMap = RecordType(); 
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.PO_PP_SVLAN__c=(String)c.id;
        
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        insert c;
        
        Order ordine = new Order();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        //ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.OF_Contratto__c=contratto.id;
        insert ordine;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        ce.name = 'VLAN';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio1;
        ce.OF_DataFineValidita__c = fine1;
        ce.OF_Servizio__c = servizio.id;
        insert ce;
        
        OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
        //CEI.Name='VLAN';
        CEI1.OF_Asset__c=asset_1.id;
        CEI1.OF_Stato__c='Attivo';
        CEI1.RecordTypeId=ComRecordTypeId1;
        CEI1.OF_Case__c=c.id;
        CEI1.OF_EsitoConsegnaApparato__c='1';
        CEI1.OF_SA_VLAN__c=c.id;
        
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI1;
        
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
                            WHERE Id = :standardPricebook.Id];
        
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
            IsActive = true
        );
        insert testPbe;
        
        Product2 testProduct1 = new Product2(
            Name = 'Contributo Storno Verticale',
            IsActive = true
        );
        insert testProduct1;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true
        );
        insert testPbe1;   
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id);
        
        insert customPB;
    }
    
    public static Verticali__c createVerticaliCustomSetting() {

        Verticali__c cs = new Verticali__c();
        cs.Name='test';
        cs.delayAlgoritmo__c = 1;
        cs.delayBonifica__c = 240;
        cs.Email__c = 'test@test.org';
        cs.Email_CC__c = 'test@test.org';
        cs.Email_from__c = 'Contattaci OpenFiber';
        cs.emailSubject__c = 'subj';
        cs.giorniTolleranza__c = -2;
        cs.limitBatch__c = 10;
        cs.TextBody__c = 'text';
        cs.RecordTypesAssets__c = 'OF_OpenStream';
        
        insert cs;
        return cs;
    } 
}
@isTest
public class OF_PNI_Obsoleti_Batch_Test {
    
        public static Verticali__c createVerticaliCustomSetting() {

        Verticali__c cs = new Verticali__c();
        cs.Name='test';
        cs.delayAlgoritmo__c = 1;
        cs.delayBonifica__c = 240;
        cs.Email__c = 'test@test.org';
        cs.Email_CC__c = 'test@test.org';
        cs.Email_from__c = 'Delivery Services Openfiber';
        cs.emailSubject__c = 'subj';
        cs.giorniTolleranza__c = -2;
        cs.limitBatch__c = 10;
        cs.TextBody__c = 'text';
        
        insert cs;
        return cs;
    } 
    
    
     public static Account accountCreation()
    {
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
        
        return acc;
    }

    
    public static Account accountOFCreation()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'OpenFiber';
        acc.Type = 'OLO';
        acc.EOF_Codice_Operatore__c = 'OF';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        return acc;
    }

    public static Account account_OLO_Creation()
    {
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        return accOLO;
    }
    
    public static Case caseActivationCreation(Account acc, Account accOLO, Asset asset_t)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_t.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        return c;
    }
    
    public static Order orderCreation(Case c, OF_Asset_Verticale__c va, Asset asset_t, Account acc)
    {
        Order ordine = new Order();
        ordine.OF_CaseID__c = c.id;
        ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        return ordine;
    }
    
    public static OF_Asset_Verticale__c assetVerticaleCreation(Asset asset_1)
    {
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Nazionale'; 
        va.Civico__c = '34';
        va.Comune__c = 'Milano';
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001'; 
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234'; 
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c = asset_1.id;
       
        insert va;
        
        return va;
    }
    
    public static Asset assetCreation(Account acc,Contract contr){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.OF_Contract__c=contr.Id;
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        insert asset_1;

        return asset_1;
    }
    
    public static OF_Staging_PNI__c createStaging(){
        
        OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
        staging.OF_Source_System__c = 'PNI';
        staging.OF_Civico__c = '12';
        staging.OF_Comune__c = 'Napoli';
        staging.OF_ID_GIS_ScalaPalazzina__c = 'IDR1234';
        staging.OF_UI_Scala_Palazzina__c='12345';
        staging.OF_Id_Risorsa__c = 'IDR1234';
        staging.OF_Indirizzo__c = 'Malta';
        staging.indice__c = 2;
      
        insert staging;
        
        return staging;
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
    
    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
    public static Contract createContract(Account acc)
    {
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        return contratto;
    }
    
    public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    }  
    
    public static OF_BillingElement__c createContributoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo Verticale';
        be.OF_CommercialElement__c = ce.id;
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        be.OF_Attivo__c = true;
        be.OF_DataInizioValidita__c = inizio;
        be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c = contr.Id;
        conServ.OF_Servizio__c = serv.id;
        insert conServ;      
        return conServ;
    }
    
    public static OF_BillingElement__c createContributoStornoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo di storno Verticale';
        be.OF_CommercialElement__c = ce.id;
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        be.OF_Attivo__c = true;
        be.OF_DataInizioValidita__c = inizio;
        be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }

    public static OF_Billing_Element_Verticale__c billingElementVCreation(Asset asset_t, Case c, OF_Asset_Verticale__c va)
    {
        OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
        verticalBE.name = 'BEV-'+asset_t.EOF_ID_Risorsa__c;
        verticalBE.ID_Risorsa__c = asset_t.EOF_ID_Risorsa__c;
        verticalBE.OLO__c = c.EOF_Account_OLO__c;
        verticalBE.Data_Attivazione__c = System.now();
        //Relaziono il BE Verticale all'Asset Standard
        verticalBE.Asset__c = asset_t.id;
        //Relaziono il BE Verticale all'Asset Verticale
        verticalBE.Asset_Verticale__c = va.id;
        insert verticalBE;
        return verticalBE;
    } 

    public static OF_CommercialElementIstanziato__c CommercialElementIstanziatoCreation(Asset asset_t,OF_CommercialElement__c comm )
    {
        OF_CommercialElementIstanziato__c elem = new OF_CommercialElementIstanziato__c();
        elem.OF_Asset__c=asset_t.Id;
        elem.OF_Stato__c='Attivo';
        elem.OF_DataCessazione__c = DateTime.now();
        elem.OF_CommercialElement__c= comm.Id;
        
        insert elem;
        return elem;
    }
    
    
    private static testMethod void test_batch()
    {
        
        createVerticaliCustomSetting() ;
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;    
        
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
        
 
        Account acc = accountCreation();
        account accOf = accountOFCreation();
        Account accOLO = account_OLO_Creation();
       
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        Contract contratto = createContract(acc);
        OF_Servizio__c serv = Servizio_Creation(cat);
        OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
        OF_CommercialElement__c ce_test = CE_Creation(serv);
        OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
        OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);
        
         Asset assetStd = assetCreation(acc,contratto);
        Case c = caseActivationCreation(acc, accOLO,assetStd);
        OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
        OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

        Order ord = orderCreation(c,va,assetStd,acc);
        OF_Staging_PNI__c stag = createStaging();
        List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
        lista_staging.add(stag);
        
        
         // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c = assetStd.Id,
            IsActive = true
        );
        insert testPbe;
        
        DataBase.executeBatch(new OF_PNI_Obsoleti_Batch());
    }
    
    
    private static testMethod void test_batch2()
    {
        
        createVerticaliCustomSetting() ;
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom;    
        
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
        
 
        Account acc = accountCreation();
        account accOf = accountOFCreation();
        Account accOLO = account_OLO_Creation();
       
        
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        Contract contratto = createContract(acc);
        OF_Servizio__c serv = Servizio_Creation(cat);
        OF_ContrattoServizio__c contrService = createContrattoServizio(contratto, serv);
        OF_CommercialElement__c ce_test = CE_Creation(serv);
        OF_BillingElement__c be_contributo = createContributoVerticale(ce_test);
        OF_BillingElement__c be_contributoStorno = createContributoStornoVerticale(ce_test);
        
         Asset assetStd = assetCreation(acc,contratto);
        
            
        Case c = caseActivationCreation(acc, accOLO,assetStd);
        OF_Asset_Verticale__c va = assetVerticaleCreation(assetStd);
        
        va.ID_GIS_Scala_Palazzina__c='cambio';
        update va;
        
        OF_Billing_Element_Verticale__c billingElemVert = billingElementVCreation(assetStd, c, va);

        assetStd.OF_DataAttivazione2__c = Date.newInstance(2011, 11, 18);

        
        Order ord = orderCreation(c,va,assetStd,acc);
        OF_Staging_PNI__c stag = createStaging();
        List<OF_Staging_PNI__c> lista_staging = new List<OF_Staging_PNI__c>();
        lista_staging.add(stag);
        
        
         // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c = assetStd.Id,
            IsActive = true
        );
        insert testPbe;
        
        OF_CommercialElementIstanziato__c comElem =  CommercialElementIstanziatoCreation(assetStd,ce_test);
        
        DataBase.executeBatch(new OF_PNI_Obsoleti_Batch());
    }
}
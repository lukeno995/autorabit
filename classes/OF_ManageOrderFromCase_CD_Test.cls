@isTest
public class OF_ManageOrderFromCase_CD_Test {
    
    @testsetup
    static void createData()
    {
        Case_AssetRecordType__c ccus = new Case_AssetRecordType__c();
        ccus.Name = 'test1';
        ccus.caseDevName__c = 'EOF_Caso_Attivazione_OPENSTREAM_CeD';
        ccus.assetDevName__c = 'OF_CD_Asset_OpenStream';
        ccus.beAttivazioneList__c = 'Contributo Attivazione ,Canone';
        insert ccus;
        
        Case_AssetRecordType__c ccus2 = new Case_AssetRecordType__c();
        ccus2.Name = 'test2';
        ccus2.caseDevName__c = 'EOF_SP_Caso_Attivazione_CeD';
        ccus2.assetDevName__c = 'OF_CD_Asset_GPON_Passiva';
        ccus2.beAttivazioneList__c = 'Contributo Attivazione ,Canone';
        insert ccus2;
        
        Case_AssetRecordType__c ccus3 = new Case_AssetRecordType__c();
        ccus3.Name = 'test3';
        ccus3.caseDevName__c = 'EOF_Caso_Cessazione_OPENSTREAM_CD';
        ccus3.assetDevName__c = 'OF_CD_Asset_OpenStream';
        ccus3.beAttivazioneList__c = 'Contributo Disattivazione ,Contributo Ritiro';
        insert ccus3;
        
        Case_AssetRecordType__c ccus4 = new Case_AssetRecordType__c();
        ccus4.Name = 'test4';
        ccus4.caseDevName__c = 'EOF_SP_Caso_Cessazione_CeD';
        ccus4.assetDevName__c = 'OF_CD_Asset_GPON_Passiva';
        ccus4.beAttivazioneList__c = 'Contributo Disattivazione ,Contributo Ritiro';
        insert ccus4;
        
        Verticali__c cs2 = new Verticali__c();
		cs2.createNotifyBatchLimit__c = 10000;
		cs2.callWsBillingBatchSize__c = 4;
		cs2.RecordTypesAssets__c ='\'OF_Open_Stream\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'';
		
		insert cs2;
		
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
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
    
    public static Case caseActivationCreation(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
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
        c.OF_Order__c=ord.id;
        insert c;
        
        return c;
    }
    
    public static Case caseActivationCreation1(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF SP Caso Attivazione CeD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
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
        c.OF_Order__c=ord.id;
        insert c;
        
        return c;
    }
    
    public static Order orderCreation(Asset asset_t, Account acc)
    {
        String OrderRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('OUTORDER').getRecordTypeId();
        Order ordine = new Order();
        ordine.RecordTypeId = OrderRecordTypeId;
        //ordine.OF_CaseID__c = c.id;
        ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.OF_IDRisorsa__c = 'IDR1234';
        ordine.OF_TipologiaDiServizio__c = 'Attivo';
        insert ordine;
        
        return ordine;
    }
    
    public static Asset assetCreation(Account acc, String contractId){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contractId;
        insert asset_1;

        return asset_1;
    }
    
    public static Contract createContract(Account acc)
    {
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        return contratto;
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
        servizio.name = 'Open Stream CD';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
       
        insert servizio;
        return servizio;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c = contr.Id;
        conServ.OF_Servizio__c = serv.id;
        insert conServ;      
        return conServ;
    }

    public static testMethod void test_ManageOrder1A(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        c.OF_SA_Profilo__c = 'Test';
      
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
       
        c.Status = 'Cessato KO';
        obj.ManageOrder(c);
        
        c.Status = 'Acquisito KO';
        obj.ManageOrder(c); 
        
        c.Status = 'Espletato';
        c.OF_Order__c = ordine.Id;
        //obj.ManageOrder(c);
    }
    
    public static testMethod void test_ManageOrder1B(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        c.RecordTypeId = CaseRecordTypeId1;
        c.OF_SA_Profilo__c = 'Test';
        c.OF_IDContratto__c = contratto.Id;
        
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        codifica.OF_ListinoCanoneName__c = 'Test';
        codifica.Name = 'Test';
        insert codifica;
        
        List<Asset> AssetOrderCess = new List<Asset>();
        AssetOrderCess.add(asset_1);
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        //obj.ManageOrder(c);
        
        c.Status = 'Cessato';
        c.OF_Order__c = ordine.Id;
        //obj.ManageOrder(c);
    }
    
    public static testMethod void test_ManageOrder1C(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Cessato KO';
        c.OF_Order__c = null;
        String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        c.RecordTypeId = CaseRecordTypeId1;
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
        
        c.Status = 'Cessato KO';
        c.OF_Order__c = ordine.Id;
        obj.ManageOrder(c);
    }
    
    public static testMethod void test_ManageOrder1D(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF SP Caso Cessazione CeD').getRecordTypeId();
        c.RecordTypeId = CaseRecordTypeId1;
        c.OF_SA_Profilo__c = 'Test';
        c.OF_IDContratto__c = contratto.Id;
        
        OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
        codifica.CD_ListinoCanoneName__c = 'Test';
        codifica.Name = 'Test';
        insert codifica;
        
        List<Asset> AssetOrderCess = new List<Asset>();
        AssetOrderCess.add(asset_1);
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        //obj.ManageOrder(c);
        
        c.Status = 'Cessato';
        c.OF_Order__c = ordine.Id;
        //obj.ManageOrder(c);
    }
  
    public static testMethod void test_ManageOrder2(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        //insert c;
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
        
        c.Status = 'Acquisito KO';
        c.EOF_Order_Manager__c = true;
        obj.ManageOrder(c);
        
        c.Status = 'Espletato';
        c.OF_Order__c = ordine.Id;
        //obj.ManageOrder(c);
    }
    
     public static testMethod void test_ManageOrder3(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        //insert c;
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
        
        c.Status = 'Acquisito KO';
        c.EOF_Order_Manager__c = true;
        obj.ManageOrder(c);
        
        c.Status = 'Espletato KO';
        c.OF_Order__c = ordine.Id;
        obj.ManageOrder(c);
        
        
    }
    
     public static testMethod void test_ManageOrder4(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        c.OF_SA_Profilo__c = 'Test';
        //insert c;
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
        
        c.Status = 'Acquisito KO';
        c.EOF_Order_Manager__c = true;
        obj.ManageOrder(c);
        
        c.Status = 'Annullato';
        c.OF_Order__c = ordine.Id;
        obj.ManageOrder(c);
        
        
    }
    
     public static testMethod void test_ManageOrder5(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        //insert c;
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
        
        c.Status = 'Acquisito KO';
        c.EOF_Order_Manager__c = true;
        obj.ManageOrder(c);
        
        c.Status = 'Accettato KO';
        c.OF_Order__c = ordine.Id;
        obj.ManageOrder(c);
        
        
    }
    
     public static testMethod void test_ManageOrder6(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
      
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        //insert c;
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
        
        c.Status = 'Acquisito KO';
        c.EOF_Order_Manager__c = true;
        obj.ManageOrder(c);
        
        c.Status = 'Cessato';
        c.OF_Order__c = ordine.Id;
        obj.ManageOrder(c);
        
        
    }
    
     public static testMethod void test_ManageOrder7(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        //insert c;
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.ManageOrder(c);
        
        c.Status = 'Acquisito KO';
        c.EOF_Order_Manager__c = true;
        obj.ManageOrder(c);
        
        c.Status = 'Cessato OK';
        c.OF_Order__c = ordine.Id;
        obj.ManageOrder(c);
    }
    
     public static testMethod void test_aggiornoOrdine_1(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount1';
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
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        OF_Servizio__c serv = Servizio_Creation(cat);
        OF_ContrattoServizio__c serviceContract = createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR12341';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.EOF_SLA_Premium_Assurance__c='N';
        insert asset_1;
        
        Order ordine = new Order();
        ordine.AccountId = acc.id;
        ordine.ContractId= contratto.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.OF_IDRisorsa__c='test';
        insert ordine;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test1';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Espletato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test1';
        c.OF_Esito_Consegna_Apparato__c='2';  
        c.OF_Order__c=ordine.id;
        c.OF_IDContratto__c=contratto.id;
       
        insert c;
        
        case c1 = [select id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,
                   recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,
                   EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
                   EOF_GPON_Attestazione__c, OF_SA_Codice_Motivazione__c,
                   OF_SA_Profilo__c, EOF_SLA_Premium_Assurance__c, OF_SA_Motivazione__c, EOF_Apparato__c,
                   EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_Esito_Consegna_Apparato__c,
                   EOF_ID_Building_WS__c, EOF_Provincia_WS__c, OF_SA_Promozione__c, OF_SA_CODICE_PROGETTO_SPECIALE__c,
                   OF_SA_Cluster_Promozione__c, EOF_Comune_WS__c, EOF_Particella_Toponomastica_WS__c, EOF_Scala_Palazzina_WS__c,
                   EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c
                   FROM case];
                   
        test.startTest();           
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        try{
            obj.AggiornoOrdine(c1);
        }
        catch(Exception e){}
        
        test.stopTest();
    }
    
    public static testMethod void test_aggiornoOrdine_2(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount1';
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
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        OF_Servizio__c serv = Servizio_Creation(cat);
        OF_ContrattoServizio__c serviceContract = createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR12341';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.EOF_SLA_Premium_Assurance__c='N';
        insert asset_1;
        
        Order ordine = new Order();
        ordine.AccountId = acc.id;
        ordine.ContractId= contratto.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.OF_IDRisorsa__c='test';
        insert ordine;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test1';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Cessato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test1';
        c.OF_Esito_Consegna_Apparato__c='2';  
        c.OF_Order__c=ordine.id;
        c.OF_IDContratto__c=contratto.id;
       
        insert c;
        
        case c1 = [select id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,
                   recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,
                   EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
                   OF_Esito_Consegna_Apparato__c, EOF_GPON_Attestazione__c, OF_SA_Codice_Motivazione__c,
                   OF_SA_Profilo__c, EOF_SLA_Premium_Assurance__c, OF_SA_Motivazione__c, EOF_Apparato__c
                   FROM case];
                   
        test.startTest();
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.AggiornoOrdine(c1);
        test.stopTest();
    }
    
    public static testMethod void test_aggiornaSLogPortale()
    {
        String rtype = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c sLogPortale = new EOF_EAI_Service_Log__c();
        sLogPortale.RecordTypeId = rType;
        sLogPortale.EOF_Codice_Ordine_OLO__c = 'TEST_CD_001';
        sLogPortale.EOF_Stato_Richiesta__c = 'Inserita Portale';
        insert sLogPortale;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c.EOF_Codice_Ordine_OLO__c = 'TEST_CD_001';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c = 'ID_R_1234';
        c.status = 'Espletato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId = CaseRecordTypeId;
        insert c;
        
        EOF_EAI_Service_Log__c sLogPortale1 = [Select id, EOF_Codice_Ordine_OLO__c, RecordType.developerName, 
                                               EOF_Tipo_Comunicazione__c, 
                                               EOF_Motivazione__c, EOF_ID_RISORSA__c, EOF_Data_Espletamento_Ordine__c, 
                                               EOF_NOTE__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c
                                               from EOF_EAI_Service_Log__c];

        test.startTest();
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        obj.aggiornaSLogPortale(c);
        test.stopTest();
    }
    
    public static testMethod void test_ManageOrder9(){
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        
        Order ordine = orderCreation(asset_1,acc);
        Case c = caseActivationCreation1(acc,accOLO,asset_1,ordine);
        
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        //obj.TipoServ(null);
    }
    
    //Editing start here
  
     public static testMethod void test_ManageOrder11A(){
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 
        
        //Map<String,String> RecordTypeMap = RecordType(); 
        
        //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'TestAccount11A';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        //acc.RecordTYpeId = AccountRecordTypeId ;
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
        c.status = 'Modificato KO';
        c.EOF_FASE__C = 'NA';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';    
        insert c;
        
        case c1=[select id,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];
        
        /*
        Order ordine = new Order();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        //ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.OF_Contratto__c=contratto.id;
        insert ordine;
        */
       
        Test.startTest();
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        //OF_ManageOrderFromCase_CD.manageOrderAsyncChOrd(c.Id);
        Test.stopTest();
    }
    
    public static testMethod void test_ManageOrder11B(){
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 
        
        //Map<String,String> RecordTypeMap = RecordType(); 
        
        //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'TestAccount11A';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        //acc.RecordTYpeId = AccountRecordTypeId ;
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
        
        case c1=[select id,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];
        
      
        
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
      /*  PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true
        );
        insert testPbe;*/
        
        Product2 testProduct1 = new Product2(
            Name = 'Contributo Consegna e Istallazione',
            IsActive = true
        );
        insert testProduct1;
        
        Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id);
        
        insert customPB;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =false
        );
        insert testPbe1;   
        
         PricebookEntry testPbecus = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = customPB.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =true
        );
        
        insert testPbecus; 
       
        Test.startTest();
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        //OF_ManageOrderFromCase_CD.manageOrderAsyncChOrd(c.Id);
        //OF_ManageOrderFromCase_CD.manageOrderSyncChOrd(c.id);
        Test.stopTest();
        
    }
   
    /*public static testMethod void test_ManageOrder12(){
        
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
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';
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
        c.status = 'Modificato KO';
        c.EOF_FASE__C = 'NA';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';    
        insert c;
        
        Order ordine = new Order();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        //ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.OF_Contratto__c=contratto.id;
        ordine.Id = contratto.id;
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
        
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = Contratto.Id;
        cs.OF_Servizio__c = servizio.Id;
        insert cs;
        
        Test.startTest();
        OF_ManageOrderFromCase_CD obj = new OF_ManageOrderFromCase_CD();
        OF_ManageOrderFromCase_CD.manageOrderSyncChOrd(c);
        Test.stopTest();
        
                
    } **/
    
    public static TestMethod Void test_manageOrderSyncChOrd1(){
    
        List<RecordType> orderrtypes = [Select Name, Id From RecordType 
                                        where sObjectType='Order' 
                                        and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
            OrderRecordTypes.put(rt.Name,rt.Id); 
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = True;
        c.OF_SA_Profilo__c = 'OPENSTREAM_100_50';
        c.status = 'Modificato OK';
        insert c;

        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.Caso__c = c.id;
        insert eof;
       
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        //asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
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
        CEI.OF_Case__c=c.ID;
        
        ceis.add(CEI);   
        
        Order ordine = new Order();
        String orderRecordTypeId = Schema.SObjectType.order.getRecordTypeInfosByName().get('CHANGE ORDER').getRecordTypeId();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        //ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.RecordType=OrderRecordTypes;
        insert ordine;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';
        insert contratto;
        
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = Contratto.Id;
        cs.OF_Servizio__c = servizio.Id;
        insert cs;
       
        OF_SA_CD_GE_Utils.slSFOM=eof;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Test.startTest();
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito='1';
        
        OF_CO_GE_Utils.RTMap = new  map<String,String>();
       
        OF_ManageOrderFromCase_CD.manageOrderSyncChOrd(c);
        Test.stopTest();
    }
    
    public static TestMethod Void test_manageOrderSyncChOrd2(){
    
        List<RecordType> orderrtypes = [Select Name, Id From RecordType 
                                        where sObjectType='Order' 
                                        and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
            OrderRecordTypes.put(rt.Name,rt.Id); 
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = True;
        c.OF_SA_Profilo__c = 'OPENSTREAM_100_50';
        c.status = 'Modificato KO';
        insert c;

        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.Caso__c = c.id;
        insert eof;
       
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        //asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
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
        CEI.OF_Case__c=c.ID;
        
        ceis.add(CEI);   
        
        Order ordine = new Order();
        String orderRecordTypeId = Schema.SObjectType.order.getRecordTypeInfosByName().get('CHANGE ORDER').getRecordTypeId();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        //ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.RecordType=OrderRecordTypes;
        insert ordine;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';
        insert contratto;
        
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = Contratto.Id;
        cs.OF_Servizio__c = servizio.Id;
        insert cs;
       
        OF_SA_CD_GE_Utils.slSFOM=eof;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Test.startTest();
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito='1';
        
        OF_CO_GE_Utils.RTMap = new  map<String,String>();
       
        OF_ManageOrderFromCase_CD.manageOrderSyncChOrd(c);
        Test.stopTest();
    }
}
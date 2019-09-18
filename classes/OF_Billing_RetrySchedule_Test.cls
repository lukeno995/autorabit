@isTest
public class OF_Billing_RetrySchedule_Test{ 
     
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    } 
    static testmethod Map<String,String> RecordType(){ 
        List<RecordType> rtypes = [Select developerName, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'EOF_Notify__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
            
            for(RecordType rt: rtypes)
            RecordType.put(rt.developerName,rt.Id);
        
        return RecordType;
    }
    
    public static testMethod void RetryScheduleMethod1(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contract cont = new Contract();
        cont.AccountId = acc.Id;
        cont.OF_IdContratto__c = 'Test';
        cont.StartDate = System.today();
        cont.ContractTerm = 1243;
        cont.Status = 'Draft';
        insert cont;
        
        Case cse = new Case();
        cse.Status = 'Acquisito';
        insert cse;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
        EOF_Notify__c objEOF= new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.Flag_Pagamento__c = '0';
        objEOF.Numero_Operatore__c = '1';
        objEOF.EOF_Tipo_di_intervento__c = 'Sbraccio';
        objEOF.EOF_Tipo_di_intervento_aggiuntivo__c = 'Nessun Intervento';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_ID_Risorsa__c ='Test';
        objEOF.EOF_ID_Splitter_Secondario__c = 'Test';
        objEOF.EOF_Posizione_Splitter_Secondario__c = 'Test';
        objEOF.EOF_Data_Espletamento_Ordine__c = System.today();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = cse.id;
        objEOF.Account__c = acc.Id;
        objEOF.Contract__c = cont.Id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        insert objEOF;
        
        SchedulableContext SC = null;
        
        Test.startTest();
        OF_Billing_RetrySchedule sh1 = new OF_Billing_RetrySchedule('Test Id');
        String sch = '0 0 2 * * ?'; 
        system.schedule('Test Territory Check', sch, sh1); 
        Test.stopTest();
    }
    
    public static testMethod void RetryScheduleMethod2(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contract cont = new Contract();
        cont.AccountId = acc.Id;
        cont.OF_IdContratto__c = 'Test';
        cont.StartDate = System.today();
        cont.ContractTerm = 1243;
        cont.Status = 'Attivo';
        insert cont;
        
        Case cse = new Case();
        cse.Status = 'Acquisito';
        insert cse;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
        EOF_Notify__c objEOF= new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.Flag_Pagamento__c = '0';
        objEOF.Numero_Operatore__c = '1';
        objEOF.EOF_Tipo_di_intervento__c = 'Sbraccio';
        objEOF.EOF_Tipo_di_intervento_aggiuntivo__c = 'Nessun Intervento';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_ID_Risorsa__c ='Test';
        objEOF.EOF_ID_Splitter_Secondario__c = 'Test';
        objEOF.EOF_Posizione_Splitter_Secondario__c = 'Test';
        objEOF.EOF_Data_Espletamento_Ordine__c = System.today();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = cse.id;
        //objEOF.Account__c = acc.Id;
        objEOF.Contract__c = cont.Id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        insert objEOF;
        
        SchedulableContext SC = null;
        
        Test.startTest();
        OF_Billing_RetrySchedule sh1 = new OF_Billing_RetrySchedule('Test Id');
        String sch = '0 0 2 * * ?'; 
        system.schedule('Test Territory Check', sch, sh1); 
        Test.stopTest();
    }

   public static testMethod void test_CallContract(){
        
        Map<String,String> RecordTypeMap = RecordType();
        
        Account acc = new Account();
        acc.Name = 'OpenFiber';
        insert acc;
        
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.StartDate = system.today();
        contratto.ContractTerm = 5;
        insert contratto;
        
        Contract contratto1 = [select id,name,NS_Rif__c,EndDate,Status,StartDate,ContractNumber,SuspendedDate__c,
                               OF_TermPayment__c,OF_IdContratto__c,BillingFrequency__c,ContractTerm,Account.AccountNumber,
                               AccountId from Contract where OF_IdContratto__c = 'TEST_TIS_001'];
       
        EOF_Notify__c notifica = new EOF_Notify__c();
       notifica.EOF_ID_Notifica__c = 'TEST_ID';
        notifica.Contract__c = contratto1.Id;
        notifica.RecordTypeId = RecordTypeMap.get('EOF_BILL_Contract');
        insert notifica;
        
        Test.startTest();
        OF_Billing_RetrySchedule sh1 = new OF_Billing_RetrySchedule('TEST_ID');
        SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
        wrp.con = contratto1;
        Test.setMock(WebServiceMock.class, new SyncBillingContractUtils_Mock());
        SyncBillingContractUtils.callWSContract(wrp,'TEST_ID');
        String sch = '0 0 2 * * ?'; 
        String jsonString = '{"operationType":null,"con":{"attributes":{"type":"Contract","url":"/services/data/v44.0/sobjects/Contract/'+contratto1.Id+'"},"OF_IdContratto__c":"TEST_TIS_001","AccountId":"'+acc.id+'","StartDate":"2018-12-18","EndDate":"2018-12-18","ContractTerm":5,"Id":"'+contratto1.Id+'"},"action":null}';
        system.schedule('Test Territory Check', sch, sh1);
        OF_Billing_RetrySchedule.CallContract(JsonString,'TEST_ID');
        Test.stopTest();
    } 
    
    public static testMethod void test_CallAccount(){
        
        Map<String,String> RecordTypeMap = RecordType();
        
        Account acc = new Account();
        acc.Name = 'OpenFiberNew';
        acc.Status__c='Attivo';
        acc.AccountNumber='test';
        acc.StartDate__c=datetime.now();
        acc.VATNumber__c='12345';
        acc.Class__c='Premium';
        
        acc.BillingEmail__c='';
        acc.PEC__c='';
        acc.BillingCity='t';
        acc.BillingState='t';
        acc.BillingStreet='t';
        acc.BillingCountry='t';
        acc.Industry='t';
        acc.BillingPostalCode='t';
        acc.EOF_Codice_Operatore__c='te';
        acc.SyncBilling__c=true;
        //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        acc.RecordTypeId=RecordTypeMap.get('OLO');
        
        insert acc;
        
        account acc1=[select Name,Class__c,SyncBilling__c,Status__c,AccountNumber,StartDate__c,VATNumber__c,TaxationCode__c,BillingEmail__c,PEC__c, BillingCity, BillingState,BillingStreet,BillingCountry,Industry,BillingPostalCode, EOF_Codice_Operatore__c from account];
        
        
        EOF_Notify__c ENF=new EOF_Notify__c();
        ENF.EOF_ID_Notifica__c='test';
        ENF.Account__c=acc.ID;
        insert ENF;
        
        
        Test.startTest();
        OF_Billing_RetrySchedule sh1 = new OF_Billing_RetrySchedule('Test Id');
        SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
        wrp.acc = acc;  
        wrp.action = 'modify';
        String notificaid='';
        String jsonString = '{"action":null,"acc":{"attributes":{"type":"Account","url":"/services/data/v44.0/sobjects/Account/'+acc1.Id+'"},"Name":"OpenFiberNew","Status__c":"Attivo","AccountNumber":"test","StartDate__c":"2018-12-18T08:08:14.888+0000","VATNumber__c":"12345","Class__c":"Premium","TaxationCode__c":"","BillingEmail__c":"","PEC__c":"","BillingCity":"t","BillingState":"t","BillingStreet":"t","BillingCountry":"t","Industry":"t","BillingPostalCode":"t","EOF_Codice_Operatore__c":"te","SyncBilling__c":true,"Id":"'+acc.Id+'"}}';
        // String sch = '0 0 2 * * ?'; 
        //system.schedule('Test Territory Check', sch, sh1);
        Test.setMock(WebServiceMock.class, new SyncBillingAccountUtils_Mock());
        OF_Billing_RetrySchedule.CallAccount(jsonString,notificaid);
        Test.stopTest();
    }
    
    public static testMethod void test_callWSAssetVerticaleByCei1(){
        
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
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
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
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        insert CEI;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
        EOF_Notify__c objEOF= new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.Flag_Pagamento__c = '0';
        objEOF.Numero_Operatore__c = '1';
        objEOF.EOF_Tipo_di_intervento__c = 'Sbraccio';
        objEOF.EOF_Tipo_di_intervento_aggiuntivo__c = 'Nessun Intervento';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_ID_Risorsa__c ='Test';
        objEOF.EOF_ID_Splitter_Secondario__c = 'Test';
        objEOF.EOF_Posizione_Splitter_Secondario__c = 'Test';
        objEOF.EOF_Data_Espletamento_Ordine__c = System.today();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        //objEOF.Account__c = acc.Id;
        //objEOF.Contract__c = contratto.Id;
        //objEOF.Commercial_element_istanziato__c= CEI.Id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        insert objEOF;
        
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
            IsActive = true,
            OF_CommercialElementIstanziato__c=CEI.id
        );
        insert testPbe;
        
        
        String IdCei =(String)CEI.id;
        String idNotifica ='';
        //SyncBillingAssetUtils.callWSAssetVerticaleByCei(IdCei, idNotifica);
        Test.startTest();
        OF_Billing_RetrySchedule sh1 = new OF_Billing_RetrySchedule('Test Id');
        String sch = '0 0 2 * * ?'; 
        system.schedule('Test Territory Check', sch, sh1); 
        //OF_Billing_RetrySchedule.CallAsset('Test','Test Id');
        Test.stopTest();
    }
}
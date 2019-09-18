@isTest
public class SyncBillingContractUtils_Test {
    
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select developerName, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'EOF_Notify__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
        
        for(RecordType rt: rtypes)
            RecordType.put(rt.developerName,rt.Id);
                
       return RecordType;
    }

     public static testMethod void test_checkField1(){
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         
         SyncBillingContractUtils.checkField(wrp);
    }
    
    public static testMethod void test_checkField2(){
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.action = 'modify';
         SyncBillingContractUtils.checkField(wrp);
    }
    
     public static testMethod void test_checkField3(){
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         contratto.Status = 'Sospeso';
         insert contratto;
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.con = contratto;
         wrp.action = 'modify';
         wrp.operationType = 'Create';
         SyncBillingContractUtils.checkField(wrp);
    }
    
    public static testMethod void test_checkField4(){
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = null;
         contratto.AccountId = acc.id;
         contratto.Status = 'Attivo';
         insert contratto;
        
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.con = contratto;
         wrp.action = 'modify';
         wrp.operationType = 'Create';
         SyncBillingContractUtils.checkField(wrp);
    }

    public static testMethod void test_checkField6(){
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         acc.AccountNumber = '123456789123456789123456789123456789';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         contratto.Status = 'Attivo';
         insert contratto;
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.con = contratto;
         wrp.action = 'modify';
         wrp.operationType = 'Create';
         SyncBillingContractUtils.checkField(wrp);
    }

     public static testMethod void test_createListLogA(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         notifica.RecordTypeId = RecordTypeMap.get('EOF_BILL_Contract');
         insert notifica;
         
         List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
         notifiche.add(notifica);
         
         List<string> errors = new List<string>();
         errors.add('Test1');
         errors.add('Test2');
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         
         SyncBillingContractUtils.createListLog(notifiche,errors,'request','response','codice','esito','message');
    }
   
    public static testMethod void test_createListLogB(){
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         insert notifica;
         
         List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
         notifiche.add(notifica);
         
         List<string> errors = new List<string>();
         errors.add('Test1');
         errors.add('Test2');
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         
         SyncBillingContractUtils.createListLog(notifiche,errors,'','response','codice','esito','message');
    }
   
    public static testMethod void test_callWSContractA(){
    
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
        
         Contract contratto1 = [select id,name,EndDate,NS_Rif__c,Status,StartDate,ContractNumber,SuspendedDate__c,
                                OF_TermPayment__c,OF_IdContratto__c,BillingFrequency__c,ContractTerm,Account.AccountNumber,
                                AccountId from Contract];
         
         //insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto1.Id;
         notifica.RecordTypeId = RecordTypeMap.get('EOF_BILL_Contract');
         insert notifica;
       
         Test.startTest();
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.con = contratto1;
         Test.setMock(WebServiceMock.class, new SyncBillingContractUtils_Mock());
         SyncBillingContractUtils.callWSContract(wrp,'');
         Test.stopTest();
    }
 
   
     public static testMethod void test_createResponse(){
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         OF_Billing_Outbound_Schema2.BillingAgreementManagerResponseType res = new OF_Billing_Outbound_Schema2.BillingAgreementManagerResponseType();
         SyncBillingContractUtils.createResponse(res);
    }
    
    public static testMethod void test_createLog(){
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica1 = new EOF_Notify__c();
         notifica1.Contract__c = contratto.Id;
         insert notifica1;
        
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         string notifica  = notifica1.id;
         SyncBillingContractUtils.createLog(notifica,'request','response','codice','esito','message');
    }
    
    public static testMethod void test_createLogB(){
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica1 = new EOF_Notify__c();
         notifica1.Contract__c = contratto.Id;
         insert notifica1;
        
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         string notifica  = notifica1.id;
         SyncBillingContractUtils.createLog(notifica,'','response','codice','esito','message');
    }
    
     public static testMethod void test_createLogC(){
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica1 = new EOF_Notify__c();
         notifica1.Contract__c = contratto.Id;
         insert notifica1;
        
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         string notifica  = notifica1.id;
         SyncBillingContractUtils.createLog(notifica,'','','codice','esito','message');
    }
    
   public static testMethod void test_createNotify(){
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         insert notifica;
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.con = contratto;
         SyncBillingContractUtils.createNotify(wrp);
    }
    
     public static testMethod void test_createRequest(){
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.NS_Rif__c='';
         contratto.AccountId = acc.id;
         //contratto.EndDate = system.today();
         insert contratto;
         Date myDatD = contratto.Enddate;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         insert notifica;
         
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.con = contratto;
         SyncBillingContractUtils.createRequest(wrp,notifica.Id,'TimeStamp','Status');
    }
    
    //FIBERLEASE
    /*
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
        insert contratto;
        
        Contract contratto1=[select id,OF_IdContratto__c,AccountId,Account.AccountNumber,ContractNumber,BillingFrequency__c from Contract];

        
        FiberLeaseDaGIS__c gi = new FiberLeaseDaGIS__c();
        gi.AnnoFatt__c='2019';
        gi.Comune__c='test';
        gi.ContractId__c=contratto1.id;
        gi.Lavorato__c= true;
        gi.Mese__c=2;
        
        insert gi;
        
        FiberLeaseDaGIS__c gi1=[select id,AnnoFatt__c,Mese__c,Comune__c,
                                ContractId__c,ContractId__r.OF_IdContratto__c,
                                ContractId__r.AccountId,ContractId__r.Account.AccountNumber,
                                ContractId__r.ContractNumber,ContractId__r.BillingFrequency__c 
                                from FiberLeaseDaGIS__c];

        
        
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
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('PO_CEI_FiberLease').getRecordTypeId();
        CEI.FiberLeaseDaGISId__c=gi.id;
        CEI.OF_Stato__c='Attivo';
        CEI.UpdateBilling__c= true;
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        
        insert CEI;
        

        OF_CommercialElementIstanziato__c cei1 = [SELECT id, RecordType.DeveloperName, OF_DataAttivazione__c,OF_DataCessazione__c,OF_Stato__c,
Name,OF_BillingSyncronized__c,FiberLeaseDaGISId__c,FiberLeaseDaGISId__r.ContractId__r.ContractNumber,
FiberLeaseDaGISId__r.ContractId__r.Account.AccountNumber,
FiberLeaseDaGISId__r.ContractId__r.OF_IdContratto__c,
FiberLeaseDaGISId__r.Comune__c,
OF_CommercialElement__r.OF_Commercial_Element_Code__c,
OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,
OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c,
OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c 
From OF_CommercialElementIstanziato__c 
where RecordType.DeveloperName='PO_CEI_FiberLease' and FiberLeaseDaGISId__r.Lavorato__c = true limit 1];
        
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
        
                OF_BillingElement__c bill = new OF_BillingElement__c();
        bill.Name='test';
        bill.OF_Billing_Element_Code__c ='1234';
        bill.OF_CommercialElement__c = ce.id;
        bill.OF_DataInizioValidita__c = ce.OF_DataInizioValidita__c;
        bill.OF_DataFineValidita__c = ce.OF_DataFineValidita__c;
        insert bill;
        
        // Create the Product
        Product2 testProduct = new Product2(
            OF_BillingElement__c = bill.id,
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
        PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            IsActive = true,
            numCoppia__c = 10,
            OF_CommercialElementIstanziato__c=CEI.id,
            OF_DataAttivazione2__c=datetime.now()
        );
        insert testPbe;

        SyncBillingContractUtils.CallFiberLease(new list<OF_CommercialElementIstanziato__c> {CEI1});
        
    }
    */
}
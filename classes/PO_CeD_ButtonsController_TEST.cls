@isTest
private class PO_CeD_ButtonsController_TEST{

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
    
    public static Contract createContract(Account acc)
    {
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        return contratto;
    }

    public static OF_Servizio__c Servizio_OpCD_Creation(OF_CatalogoCommerciale__c cat)
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
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract con, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = con.id;
        cs.OF_Servizio__c = serv.id;
        insert cs;
        return cs;
    }

    public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
    {
	    OF_CommercialElement__c ce = new OF_CommercialElement__c();
	    Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio;
	    ce.OF_DataFineValidita__c = fine;
	    ce.OF_Servizio__c = serv.id;
	    insert ce;
	    return ce;
    }  
    
    static testMethod void test_callConstructor()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id, Name from RecordType where SobjectType='case' and developerName ='EOF_Caso_Attivazione_OPENSTREAM_CeD' Limit 1];
        RecordType rt1 = [select id, Name from RecordType where SobjectType='case' and developerName ='EOF_SP_Caso_Attivazione_CeD' Limit 1];
        Group codaOpCD = [select id, type from Group where name ='Coda Ordini CD' Limit 1];

        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Accettato';
        //originalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'Da lavorare';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaOpCD.id;
        originalCase.PO_Owner_Originario__c=codaOpCD.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Annullato';
        originalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Acquisito';
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        
        Test.startTest();
        
        PageReference pageRef = Page.PO_CeD_ButtonsPage;
        pageRef.getParameters().put('Id', originalCase.Id);
        Test.setCurrentPage(pageRef);

        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_CeD_ButtonsController posc = new PO_CeD_ButtonsController(sc);
        
        PageReference pageRef1 = Page.PO_CeD_ButtonsPage;
        pageRef1.getParameters().put('Id', originalCase1.Id);
        Test.setCurrentPage(pageRef1);

        ApexPages.StandardController sc1 = new ApexPages.StandardController(originalCase1);
        PO_CeD_ButtonsController posc1 = new PO_CeD_ButtonsController(sc1);

        Test.stopTest();
    }
    
    static testMethod void test_prendiInCarico()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id, Name from RecordType where SobjectType='case' and developerName ='EOF_Caso_Attivazione_OPENSTREAM_CeD' Limit 1];
        RecordType rt1 = [select id, Name from RecordType where SobjectType='case' and developerName ='EOF_Caso_Attivazione_OPENSTREAM_CeD' Limit 1];
        Group codaOpCD = [select id, type from Group where name ='Coda Ordini CD' Limit 1];

        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        List<case> csList = new List<case>();
        case cs = new case();
        cs.status = 'Acquisito';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;

        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        //originalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'Da lavorare';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaOpCD.id;
        originalCase.PO_Owner_Originario__c=codaOpCD.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        originalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Acquisito';
        originalCase1.AccountId = acc.Id;
        
        csList.add(originalCase);
        csList.add(originalCase1);
        
        PageReference pageRef = Page.PO_CeD_ButtonsPage;
        pageRef.getParameters().put('Id', originalCase.Id);
        Test.setCurrentPage(pageRef);

        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_CeD_ButtonsController posc = new PO_CeD_ButtonsController(sc);
        
        posc.PrendiInCarico();
        PO_CeD_ButtonsController.findObjectNameFromRecordIdPrefix('AAAAAABBBBB');
        
        Test.startTest();
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
       
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        Case cTest = posc.c;
        
        Group testGroup = new Group();
        testGroup.Name = 'Coda Ordini CD';
        testGroup.DeveloperName = 'CD_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        System.runAs(new User(Id=UserInfo.getUserId())){
            QueueSobject mappingObject = new QueueSobject(QueueId = testGroup.Id, SobjectType = 'Case');
            insert mappingObject;
        }
        
        originalCase1.ownerId = testGroup.id;
        insert originalCase1;
        
        PageReference pageRef2 = Page.PO_CeD_ButtonsPage;
        pageRef2.getParameters().put('Id', originalCase1.Id);
        Test.setCurrentPage(pageRef2);
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController(originalCase1);
        PO_CeD_ButtonsController posc1 = new PO_CeD_ButtonsController(sc1);

        posc1.UserInQueueGET();

        Test.stopTest();
    }
    
    static testMethod void test_Cessato_OK()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id, Name 
                         from RecordType 
                         where SobjectType='case' 
                         and developerName ='EOF_Caso_Cessazione_OPENSTREAM_CD' 
                         Limit 1];
                         
        RecordType rt1 = [select id, Name 
                          from RecordType 
                          where SobjectType='case' 
                          and developerName ='EOF_SP_Caso_Cessazione_CeD' 
                          Limit 1];
                          
        Group codaOpCD = [select id, type 
                          from Group 
                          where name ='Coda Ordini CD' 
                          Limit 1];

        account acc = new account();
        acc.name = 'TISCALI';        
        acc.EOF_Codice_Operatore__c = 'TIS';
        insert acc;
        
        List<case> csList = new List<case>();

        case originalCase = new case();
        originalCase.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase.EOF_Codice_Ordine_OLO__c = 'TIS_OPCD_001';
        originalCase.recordtypeId = rt.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'Da Lavorare';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.PO_SA_Portale__c = true;
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaOpCD.id;
        originalCase.PO_Owner_Originario__c=codaOpCD.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase1.EOF_Codice_Ordine_OLO__c = 'TIS_OPCD_002';
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        originalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Da Lavorare';
        originalCase1.PO_SA_Portale__c = true;
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        PageReference pageRef = Page.PO_CeD_OperationChoicePage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        //ApexPages.currentPage().getParameters().put('Oper', 'CESS_OK');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_CeD_ButtonsController posc = new PO_CeD_ButtonsController(sc);
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        Contract contratto = createContract(acc);
        
        OF_Servizio__c serv = Servizio_OpCD_Creation(cat);
        OF_CommercialElement__c ce_base = CE_Creation(serv);
        OF_ContrattoServizio__c serviceContract = createContrattoServizio(contratto,serv);
        
        Group testGroup = new Group();
        testGroup.Name = 'Coda Ordini CD';
        testGroup.DeveloperName = 'CD_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.OriginalCase=originalCase;
       
        posc.cessato_OK();
        Test.stopTest();
    }
    
    static testMethod void test_Cessato_KO()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id, Name 
                         from RecordType 
                         where SobjectType='case' 
                         and developerName ='EOF_Caso_Cessazione_OPENSTREAM_CD' 
                         Limit 1];
                         
        RecordType rt1 = [select id, Name 
                          from RecordType 
                          where SobjectType='case' 
                          and developerName ='EOF_SP_Caso_Cessazione_CeD' 
                          Limit 1];
                          
        Group codaOpCD = [select id, type 
                          from Group 
                          where name ='Coda Ordini CD' 
                          Limit 1];

        account acc = new account();
        acc.name = 'TISCALI';        
        acc.EOF_Codice_Operatore__c = 'TIS';
        insert acc;
        
        List<case> csList = new List<case>();

        case originalCase = new case();
        originalCase.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase.EOF_Codice_Ordine_OLO__c = 'TIS_OPCD_001';
        originalCase.recordtypeId = rt.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'Da Lavorare';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaOpCD.id;
        originalCase.PO_Owner_Originario__c=codaOpCD.id;
        //originalCase.OF_Order__c= ord.id;
        originalCase.PO_SA_Portale__c = true;
        insert originalCase;
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c = originalCase.Id;
        eaiLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_DATA_Notifica__c = System.now();
        eaiLog.EOF_Codice_Ordine_OLO__c = 'TIS_OPCD_001';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        PageReference pageRef = Page.PO_CeD_OperationChoicePage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        //ApexPages.currentPage().getParameters().put('Oper', 'CESS_KO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_CeD_ButtonsController posc = new PO_CeD_ButtonsController(sc);
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        Contract contratto = createContract(acc);
        
        OF_Servizio__c serv = Servizio_OpCD_Creation(cat);
        OF_CommercialElement__c ce_base = CE_Creation(serv);
        OF_ContrattoServizio__c serviceContract = createContrattoServizio(contratto,serv);
        
        Group testGroup = new Group();
        testGroup.Name = 'Coda Ordini CD';
        testGroup.DeveloperName = 'CD_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        
        Test.startTest();
        posc.OriginalCase=originalCase;
        try{
            posc.cessato_KO();
        }
        catch(DmlException d){}
        
        Test.stopTest();
    }
}
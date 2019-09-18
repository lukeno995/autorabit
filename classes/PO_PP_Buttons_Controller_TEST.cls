@isTest
private class PO_PP_Buttons_Controller_TEST{

    //22/09/2017 Start
    @testSetup
    static void createData()
    {
        list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustSett1 = new list<OF_FiberLeaseListinoPrezzoAnnuo__c>();
        //CustSett1 = CustomSettingFibLease();
        
        list<OF_FiberLeasePrezzoMedioAnnuo__c> CustSett2 = new list<OF_FiberLeasePrezzoMedioAnnuo__c>();
        //CustSett2 = CustomSettingFibLease1();
    }
    //22/09/2017 END
    
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

    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
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
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract con, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = con.id;
        cs.OF_Servizio__c = serv.id;
        insert cs;
        return cs;
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
    
    static testMethod void POPPButtonsController_TestMethodCarico()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id, type from Group where name ='Ingegneria Pre-Provisioning' Limit 1];

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
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
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        originalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
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
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        pageRef.getParameters().put('Id', originalCase.Id);
        Test.setCurrentPage(pageRef);

        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        posc.PrendiInCarico();
        PO_PP_Buttons_Controller.findObjectNameFromRecordIdPrefix('AAAAAABBBBB');
        
        Test.startTest();
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        System.runAs(new User(Id=UserInfo.getUserId())){
            QueueSobject mappingObject = new QueueSobject(QueueId = testGroup.Id, SobjectType = 'Case');
            insert mappingObject;
        }
        
        originalCase1.ownerId = testGroup.id;
        insert originalCase1;
        
        PageReference pageRef2 = Page.PO_PP_ButtonsPage;
         pageRef2.getParameters().put('Id', originalCase1.Id);
        Test.setCurrentPage(pageRef2);
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController(originalCase1);
        PO_PP_Buttons_Controller posc1 = new PO_PP_Buttons_Controller(sc1);

        posc1.UserInQueueGET();
        posc1.chiudiCaso();

        Test.stopTest();
    }
   
   
    static testMethod void test_Espletamento_OK()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id, type from Group where name ='Ingegneria Pre-Provisioning' Limit 1];
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
        account acc = new account();
        acc.name = 'TISCALI';        
        acc.EOF_Codice_Operatore__c = 'TIS';
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
        originalCase.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_PP_NomeKit__c = 'TEST_K_001';
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        OriginalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase1.PO_PP_NomeKit__c = 'TEST_K_002';
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Acquisito';
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        Contract contratto = createContract(acc);
        OF_Servizio__c servOpenStream = Servizio_Creation(cat);
        OF_ContrattoServizio__c serviceContract = createContrattoServizio(contratto,servOpenStream);
        
        OF_Servizio__c servPP = ServizioPP_Creation(cat);
        OF_CommercialElement__c ce_kit = CE_Kit_Creation(servPP);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        posc.espletamento();
        Test.stopTest();
    }
   
    static testMethod void test_Espletamento_KO()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id, type from Group where name ='Ingegneria Pre-Provisioning' Limit 1];
        

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
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
        originalCase.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        OriginalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Acquisito';
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        posc.Espletamento_KO();
        
        Test.stopTest();
    }
   
    static testMethod void test_CaseInAnnullamento()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id, type from Group where name ='Ingegneria Pre-Provisioning' Limit 1];

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
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
        originalCase.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Annullamento';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        
        Test.stopTest();
    }
    
    static testMethod void test_CaseAnnullato()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id, type from Group where name ='Ingegneria Pre-Provisioning' Limit 1];

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
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
        originalCase.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Annullato';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        
        Test.stopTest();
    }
   
   
    static testMethod void test_Sospensione()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id, type from Group where name ='Ingegneria Pre-Provisioning' Limit 1];

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
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

        Contact contatto = new Contact();
        contatto.Email = 'prova_test@prova.com';
        contatto.LastName = 'TestTest';
        insert contatto;
        
        case originalCase = new case();
        originalCase.contactId = contatto.id;
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        OriginalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        //Service LOG
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - KIT - ActivationRequest').getRecordTypeId();
        eaiLog.recordtypeId = eaiRecordType;
        eaiLog.Caso__c = originalCase.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.EOF_Tipo_Comunicazione__c = '1';
        eaiLog.EOF_ID_Risorsa__c = 'Test_01';
        insert eaiLog;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Acquisito';
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        posc.sospendi();

        Test.stopTest();
    }
   
   
    static testMethod void test_InviaAlDelivery()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id from Group where name ='Ingegneria Pre-Provisioning' Limit 1];

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
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
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        OriginalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Acquisito';
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        posc.InviaAlDelivery();

        Test.stopTest();
    }
   
    static testMethod void test_InviaAdIngegneria()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id from Group where name ='Ingegneria Pre-Provisioning' Limit 1];

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
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
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        OriginalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt1.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Acquisito';
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        
        String titleTest = posc.title;
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        posc.modifica();
        posc.InviaIngegneria();

        Test.stopTest();
    }
   
   
    static testMethod void POPPButtonsController_TestMethodUser()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        //PO Collegamento Fiber link
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id from Group where name ='Ingegneria Pre-Provisioning' Limit 1];
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;

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
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        OriginalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        //originalCase.OF_Order__c= ord.id;
        insert originalCase;
   
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        posc.UserInQueueGET();
        posc.annulla();
        Test.stopTest();
    }
    
    static testMethod void test_InserisciNote()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='OF_PP_PreProvisioning_KITConsegna' Limit 1];
        Group codaIng = [select id from Group where name ='Ingegneria Pre-Provisioning' Limit 1];

        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;
        
        account acc = new account();
        acc.name = 'TISCALI';        
        acc.EOF_Codice_Operatore__c = 'TIS';
        insert acc;
        // List<case> csList = new List<case>();
        
        Contact contatto = new Contact();
        contatto.Email = 'prova_test@prova.com';
        contatto.LastName = 'TestTest';
        contatto.accountId = acc.id;
        insert contatto;
      
        case cs = new case();
        cs.status = 'Acquisito';
        cs.contactId = contatto.id;
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;

        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'Acquisito';
        originalCase.PO_Esito_collegamento__c='KO';
        originalCase.EOF_Note_Interne__c = '0';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.EOF_FAse__c= 'In Lavorazione Ingegneria';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.EOF_Comunicazioni_con_OLO__c='Test';
        originalCase.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase.PO_PP_NomeKit__c = 'TEST_K_001';
        originalCase.AccountId = acc.Id;
        originalCase.OwnerId=codaIng.id;
        originalCase.PO_Owner_Originario__c=codaIng.id;
        originalCase.EOF_Note_Operatore__c = 'Test Note Operatore';
        originalCase.EOF_Note__c = 'Test Note1';
        //originalCase.OF_Order__c= ord.id;
        originalCase.contactId = contatto.id;
        insert originalCase;
        
        case originalCase2 = new case();
        originalCase2.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase2.PO_PP_NomeKit__c = 'TEST_K_002';
        originalCase2.recordtypeId = rt1.Id;
        originalCase2.EOF_Note_Operatore__c = 'Test';
        originalCase2.Status = 'Acquisito';
        originalCase2.EOF_Note_Interne__c = '2';
        originalCase2.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase2.EOF_Note__c = 'UnitTest';
        originalCase2.EOF_FAse__c = 'Acquisito';
        originalCase2.EOF_Note_Operatore__c = 'Test Note Operatore';
        originalCase2.AccountId = acc.Id;
        originalCase2.ContactId = contatto.id;
        insert originalCase2;
        
        case originalCase3 = new case();
        originalCase3.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase3.PO_PP_NomeKit__c = 'TEST_K_003';
        originalCase3.recordtypeId = rt1.Id;
        originalCase3.EOF_Note_Operatore__c = 'Test';
        originalCase3.Status = 'Acquisito';
        originalCase3.EOF_Note_Interne__c = '3';
        originalCase3.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase3.EOF_Note__c = 'UnitTest';
        originalCase3.EOF_Note_Operatore__c = 'Test Note Operatore';
        originalCase3.AccountId = acc.Id;
        originalCase3.PO_PP_NomeKit__c = 'TEST_K01';
        originalCase3.contactId = contatto.id;
        insert originalCase3;
        
        case originalCase4 = new case();
        originalCase4.EOF_Codice_Operatore_WS__c = 'TIS';
        originalCase4.PO_PP_NomeKit__c = 'TEST_K_004';
        originalCase4.recordtypeId = rt1.Id;
        originalCase4.EOF_Note_Operatore__c = 'Test';
        originalCase4.Status = 'Acquisito';
        originalCase4.EOF_Note_Interne__c = '4';
        originalCase4.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase4.EOF_Note__c = 'UnitTest';
        originalCase4.EOF_Note_Operatore__c = 'Test Note Operatore';
        originalCase4.AccountId = acc.Id;
        originalCase4.PO_PP_NomeKit__c = 'TEST_K01';
        originalCase4.contactId = contatto.id;
        insert originalCase4;
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - KIT - ActivationRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c eaiLog0 = new EOF_EAI_Service_Log__c();
        eaiLog0.Caso__c = originalCase3.Id;
        eaiLog0.EOF_ID_Notifica__c = 'test_01';
        eaiLog0.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog0.recordTypeId = eaiRecordType;
        eaiLog0.EOF_Tipo_Comunicazione__c = '1';
        eaiLog0.EOF_ID_Risorsa__c = 'Test_01';
        insert eaiLog0;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.recordtypeId = eaiRecordType;
        eaiLog.Caso__c = originalCase.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.EOF_Tipo_Comunicazione__c = '1';
        eaiLog.EOF_ID_Risorsa__c = 'Test_01';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c = originalCase4.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.recordTypeId = eaiRecordType;
        eaiLog1.EOF_Tipo_Comunicazione__c = '1';
        eaiLog1.EOF_ID_Risorsa__c = 'Test_01';
        insert eaiLog1;
        
        PageReference pageRef = Page.PO_PP_ButtonsPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Group testGroup = new Group();
        testGroup.Name = 'Ingegneria Pre-Provisioning';
        testGroup.DeveloperName = 'Ingegneria_Pre_Provisioning_test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        Contract contratto = createContract(acc);
        OF_Servizio__c servOpenStream = Servizio_Creation(cat);
        OF_ContrattoServizio__c serviceContract = createContrattoServizio(contratto,servOpenStream);
        
        OF_Servizio__c servPP = ServizioPP_Creation(cat);
        OF_CommercialElement__c ce_kit = CE_Kit_Creation(servPP);
        
        Test.startTest();
       
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc = new PO_PP_Buttons_Controller(sc);
        
        posc.OriginalCase=originalCase;
        posc.collegamentoFattibilita=true;
        String CaseIdTest = posc.CaseId;
       
        ApexPages.currentPage().getParameters().put('Oper', 'ING');
        //posc.inserisciNote();
        
        Contact ct = new Contact();
        ct.Email = 'mail@gmail.com';
        ct.LastName = 'TestTest';
        ct.accountId = acc.id;
        insert ct;
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController(originalCase);
        PO_PP_Buttons_Controller posc1 = new PO_PP_Buttons_Controller(sc1);
        PageReference pageRef1 = Page.PO_PP_ButtonsPage;
        pageRef1.getParameters().put('Oper', 'EspOK');
        pageRef1.getParameters().put('Id', originalCase.Id);
        Test.setCurrentPage(pageRef1);
        originalCase.contactId = ct.id;
        update originalCase;
        posc1.OriginalCase=originalCase;
        posc1.inserisciNote();
        
        ApexPages.StandardController sc2 = new ApexPages.StandardController(originalCase2);
        PO_PP_Buttons_Controller posc2 = new PO_PP_Buttons_Controller(sc2);
        PageReference pageRef2 = Page.PO_PP_ButtonsPage;
        pageRef2.getParameters().put('Oper', 'Del');
        pageRef2.getParameters().put('Id', originalCase2.Id);
        Test.setCurrentPage(pageRef2);
        posc2.OriginalCase=originalCase2;
        //posc2.inserisciNote();
        
        ApexPages.StandardController sc3 = new ApexPages.StandardController(originalCase3);
        PO_PP_Buttons_Controller posc3 = new PO_PP_Buttons_Controller(sc3);
        PageReference pageRef3 = Page.PO_PP_ButtonsPage;
        pageRef3.getParameters().put('Oper', 'EspOK');
        pageRef3.getParameters().put('Id', originalCase3.Id);
        Test.setCurrentPage(pageRef3);
        posc3.OriginalCase = originalCase3;
        posc3.inserisciNote();
        
        ApexPages.StandardController sc4 = new ApexPages.StandardController(originalCase4);
        PO_PP_Buttons_Controller posc4 = new PO_PP_Buttons_Controller(sc3);
        PageReference pageRef4 = Page.PO_PP_ButtonsPage;
        pageRef4.getParameters().put('Oper', 'EspKO');
        pageRef4.getParameters().put('Id', originalCase4.Id);
        Test.setCurrentPage(pageRef4);
        posc4.OriginalCase = originalCase4;
        posc4.inserisciNote();
        
        //ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        //posc.inserisciNote();
        
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        //posc.inserisciNote();

        Test.stopTest();
    }
}
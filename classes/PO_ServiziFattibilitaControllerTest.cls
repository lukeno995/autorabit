@isTest
public class PO_ServiziFattibilitaControllerTest
{
    //22/09/2017 Start
    @testSetup
    static void createData()
    {
        list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustSett1 = new list<OF_FiberLeaseListinoPrezzoAnnuo__c>();
        CustSett1 = CustomSettingFibLease();
        
        list<OF_FiberLeasePrezzoMedioAnnuo__c> CustSett2 = new list<OF_FiberLeasePrezzoMedioAnnuo__c>();
        CustSett2 = CustomSettingFibLease1();
        
        Map<String,String> rtMap = new Map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }
        
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        
        Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
        // end profile creation
        
        // OLO Account creation
        list<Account> aco = new list<Account>();
        
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO');
        
        accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO');
        aco.add(accOLO);
        
        insert aco;
        
        
        PO_ServiziFattibilitaControllerTest.createUser(p);
        PO_ServiziFattibilitaControllerTest.createUser(p1);
        
        
        List<Account> acp = new list<Account>();
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = rtMap.get('PersonAccount')  ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        acp.add(acc);
        insert acp;
        // end Person account creation
        
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today(), OF_TT_TuttoSuTTM__c=false, OF_TT_CodOpOLOSuTTM__c='VF');
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;
        
        List<Asset> ast = new List<Asset>();
        
                
        Asset a = new Asset();
        a.RecordTypeId = rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='risorsa';
        a.name='Test';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        
        ast.add(a);
        
        Asset a1 = new Asset();
        a1.RecordTypeId = rtMap.get('OF_OpenStream');
        a1.status='Attivo';
        a1.EOF_ID_Risorsa__c='risorsa';
        a1.name='Test';
        a1.accountId=accOlo.id;
        a1.EOF_OLO__c='VF';
        
        ast.add(a1);
        
        insert ast;
    }
    //22/09/2017 END
    
    public static User createUser(Profile p) {
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = 'testUser_' + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = u.email;
        u.IsActive = true;
        insert u;
        return u;
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_1_01() {
        
        List<Profile> profili = [SELECT Id, Name FROM Profile WHERE Name IN ('PO Supporto Vendite', 'PO Referente Fattibilità', 'PO Tecnico fattibilità', 'PO Ordini Delivery', 'PO Network Creation', 'System Administrator', 'PO Ingegneria P2PAttiva')];
        Map<String, Profile> mapNomeProfilo = new Map<String, Profile> ();
        for (Profile p : profili) {
            mapNomeProfilo.put(p.Name, p);
        }
        
        User utenteSupportoVendite = PO_ServiziFattibilitaControllerTest.createUser(mapNomeProfilo.get('PO Supporto Vendite'));
        //Id groupQueue = [SELECT Id FROM Group WHERE DeveloperName = 'PO_Coda_Servizi_a_fattibilit' LIMIT 1].Id;
        System.runAs(utenteSupportoVendite) {
            PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
            Case cKit = data.caseKit;
            //cKit.EOF_Fase__c = 'In Lavorazione Network Creation';

            EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
            log.EOF_Stato_Richiesta__c = 'test';
            log.EOF_STATO_ORDINE__c = 'test';
            log.Caso__c = data.caseCollegamento.Id;
            log.EOF_Comunicazioni_con_OLO__c = 'test';
            log.EOF_NOTE__c = 'test';
            insert log;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(data.caseCollegamento);
            ApexPages.currentPage().getParameters().put('Id', data.caseCollegamento.Id);
            PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
            Test.startTest();
            posc.getCheckEspletamento();
            posc.P2PAttiva_esitiCompletati();
            
            data.caseCollegamento.EOF_Id_Risorsa__c = '';
            data.caseCollegamento.PO_Esito_collegamento__c = 'KO';
            update data.caseCollegamento;
            posc = new PO_ServiziFattibilita_Controller(sc);
            posc.getCheckEspletamento();

            data.caseCollegamento.view_error_file_PSM__c = true;
            data.caseCollegamento.view_PopUp_PSM__c = true;
            update data.caseCollegamento;
            posc = new PO_ServiziFattibilita_Controller(sc);
            posc.setViewErrorFilePopUpPSM();
            posc.setViewPopUpPSM();
            
            Test.stopTest();
        }
    }
    static testMethod void PO_ServiziFattibilitaTestMethod_1_01_02() {
        
        List<Profile> profili = [SELECT Id, Name FROM Profile WHERE Name IN ('PO Supporto Vendite', 'PO Referente Fattibilità', 'PO Tecnico fattibilità', 'PO Ordini Delivery', 'PO Network Creation', 'System Administrator', 'PO Ingegneria P2PAttiva')];
        Map<String, Profile> mapNomeProfilo = new Map<String, Profile> ();
        for (Profile p : profili) {
            mapNomeProfilo.put(p.Name, p);
        }
        
        User utenteSupportoVendite = PO_ServiziFattibilitaControllerTest.createUser(mapNomeProfilo.get('PO Supporto Vendite'));
        //Id groupQueue = [SELECT Id FROM Group WHERE DeveloperName = 'PO_Coda_Servizi_a_fattibilit' LIMIT 1].Id;
        // System.runAs(utenteSupportoVendite) {
            PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
           
            EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
            log.EOF_Stato_Richiesta__c = 'test';
            log.EOF_STATO_ORDINE__c = 'test';
            log.Caso__c = data.casePadre.Id;
            log.EOF_Comunicazioni_con_OLO__c = 'test';
            log.EOF_NOTE__c = 'test';
            insert log;
            
            data.casePadre.PO_Owner_Originario__c = utenteSupportoVendite.Id;
            data.casePadre.PO_P2P_Attiva__c = true;
            data.casePadre.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
            data.caseCollegamento.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
            data.caseCollegamento.PO_Incluso_nell_offerta__c = true;
            data.caseKit.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
            data.caseKit.PO_Incluso_nell_offerta__c = true;
            update data.caseCollegamento;
            update data.caseKit;
            update data.casePadre;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(data.caseCollegamento);
            ApexPages.currentPage().getParameters().put('Id', data.casePadre.Id);
            PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
            Test.startTest();
            posc.confermaAssegnazione();
            posc.InviaAlSupportoVendite();
            posc.InviaAlDelivery();
            posc.kitP2PAttiva = true;
            posc.ordineFattibilita = false;
            posc.richiestaFattibilita = false;
            posc.collegamentoFattibilita = false;
            posc.PrendiInCarico();
            Test.stopTest();
        //}
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_1_02_01() {
        List<Profile> profili = [SELECT Id, Name FROM Profile WHERE Name IN ('PO Supporto Vendite', 'PO Referente Fattibilità', 'PO Tecnico fattibilità', 'PO Ordini Delivery', 'PO Network Creation', 'System Administrator', 'PO Ingegneria P2PAttiva')];
        Map<String, Profile> mapNomeProfilo = new Map<String, Profile> ();
        for (Profile p : profili) {
            mapNomeProfilo.put(p.Name, p);
        }
        
        Test.startTest();
        User utente = PO_ServiziFattibilitaControllerTest.createUser(mapNomeProfilo.get('PO Referente Fattibilità'));
        //Id groupQueue = [SELECT Id FROM Group WHERE DeveloperName = 'PO_Coda_Servizi_a_fattibilit' LIMIT 1].Id;
        System.runAs(utente) {
            PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
            
            ApexPages.StandardController sc = new ApexPages.StandardController(data.caseCollegamento);
            ApexPages.currentPage().getParameters().put('Id', data.caseCollegamento.Id);
            PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        }
        
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_1_02_02() {
        
        List<Profile> profili = [SELECT Id, Name FROM Profile WHERE Name IN ('PO Supporto Vendite', 'PO Referente Fattibilità', 'PO Tecnico fattibilità', 'PO Ordini Delivery', 'PO Network Creation', 'System Administrator', 'PO Ingegneria P2PAttiva')];
        Map<String, Profile> mapNomeProfilo = new Map<String, Profile> ();
        for (Profile p : profili) {
            mapNomeProfilo.put(p.Name, p);
        }
        
        Test.startTest();
        User utente = PO_ServiziFattibilitaControllerTest.createUser(mapNomeProfilo.get('PO Tecnico fattibilità'));
        //Id groupQueue = [SELECT Id FROM Group WHERE DeveloperName = 'PO_Coda_Servizi_a_fattibilit' LIMIT 1].Id;
        System.runAs(utente) {
            PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
            
            ApexPages.StandardController sc = new ApexPages.StandardController(data.caseCollegamento);
            ApexPages.currentPage().getParameters().put('Id', data.caseCollegamento.Id);
            PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        }
        
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_1_02_03() {
        
        List<Profile> profili = [SELECT Id, Name FROM Profile WHERE Name IN ('PO Supporto Vendite', 'PO Referente Fattibilità', 'PO Tecnico fattibilità', 'PO Ordini Delivery', 'PO Network Creation', 'System Administrator', 'PO Ingegneria P2PAttiva')];
        Map<String, Profile> mapNomeProfilo = new Map<String, Profile> ();
        for (Profile p : profili) {
            mapNomeProfilo.put(p.Name, p);
        }
        
        Test.startTest();
        User utente = PO_ServiziFattibilitaControllerTest.createUser(mapNomeProfilo.get('PO Network Creation'));
        //Id groupQueue = [SELECT Id FROM Group WHERE DeveloperName = 'PO_Coda_Servizi_a_fattibilit' LIMIT 1].Id;
        System.runAs(utente) {
            PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
            
            ApexPages.StandardController sc = new ApexPages.StandardController(data.caseCollegamento);
            ApexPages.currentPage().getParameters().put('Id', data.caseCollegamento.Id);
            PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        }
        
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_1_03() {
        
        List<Profile> profili = [SELECT Id, Name FROM Profile WHERE Name IN ('PO Supporto Vendite', 'PO Referente Fattibilità', 'PO Tecnico fattibilità', 'PO Ordini Delivery', 'PO Network Creation', 'System Administrator', 'PO Ingegneria P2PAttiva')];
        Map<String, Profile> mapNomeProfilo = new Map<String, Profile> ();
        for (Profile p : profili) {
            mapNomeProfilo.put(p.Name, p);
        }
        
        Test.startTest();
        
        User utente = PO_ServiziFattibilitaControllerTest.createUser(mapNomeProfilo.get('PO Ordini Delivery'));
        System.runAs(utente) {
            PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
                
            ApexPages.StandardController sc = new ApexPages.StandardController(data.caseCollegamento);
            ApexPages.currentPage().getParameters().put('Id', data.caseCollegamento.Id);
            PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        }
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_1_04() {
        
        List<Profile> profili = [SELECT Id, Name FROM Profile WHERE Name IN ('PO Supporto Vendite', 'PO Referente Fattibilità', 'PO Tecnico fattibilità', 'PO Ordini Delivery', 'PO Network Creation', 'System Administrator', 'PO Ingegneria P2PAttiva')];
        Map<String, Profile> mapNomeProfilo = new Map<String, Profile> ();
        for (Profile p : profili) {
            mapNomeProfilo.put(p.Name, p);
        }
        
        Test.startTest();
        User utente = [SELECT Id, IsActive FROM User WHERE Name = 'Atos crm' LIMIT 1];
        utente.IsActive = true;
        update utente;
        
        Group grp = [SELECT Id, Name, DeveloperName FROM Group WHERE Type = 'queue' and DeveloperName = 'PO_Coda_Servizi_a_fattibilit' LIMIT 1];
        
        System.runAs(utente) {
            PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
            data.caseCollegamento.OwnerId = grp.Id;
            update data.caseCollegamento;
            
            ApexPages.StandardController sc = new ApexPages.StandardController(data.caseCollegamento);
            ApexPages.currentPage().getParameters().put('Id', data.caseCollegamento.Id);
            ApexPages.currentPage().getParameters().put('OLO', 'true');
            PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        }
        
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_1_05() {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        
        Case c = new Case();
		c.AccountId = data.caseCollegamento.AccountId;
		//c.EOF_Account_OLO__c = acc.Id;
		c.Status = 'Sospeso';
		c.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'PO_Collegamento_P2P_Attiva' LIMIT 1].Id;
		c.EOF_Id_Risorsa__c = data.caseCollegamento.EOF_Id_Risorsa__c;
		c.SN_bypassValidation__c = false;
		c.PO_Data_Attivazione_Ordine__c = System.today();
		c.PO_Offerta__c = data.caseCollegamento.PO_Offerta__c;
		c.EOF_Identificativo_del_POP__c = 'abc';
		c.PO_P2PAttiva_Kit_Indirizzo_Consegna__c = 'via roma';
		c.PO_PP_NomeKit__c = 'kitkat';
		c.PO_P2PAttiva_KIT_OpticalRateLimiting__c = '255';
		c.EOF_Fase__c = 'In Lavorazione Network Creation';

		insert c;

		Case cKit = data.caseKit;
		//cKit.EOF_Fase__c = 'In Lavorazione Network Creation';

		//update cKit;

        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        ApexPages.currentPage().getParameters().put('Id', c.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NetCreToTecFat');
        ApexPages.currentPage().getParameters().put('OLO', 'true');
        
        Test.startTest();
        
        new PO_ServiziFattibilita_Controller(sc);
        
        c.Status = 'Acquisito';
        c.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        update c;
        sc = new ApexPages.StandardController(c);
        ApexPages.currentPage().getParameters().put('Id', c.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NetCreToTecFat');
        ApexPages.currentPage().getParameters().put('OLO', 'true');
        ApexPages.currentPage().getParameters().put('Oper', 'SupVenToRefFat');
        new PO_ServiziFattibilita_Controller(sc);
        
        
        c.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        update c;
        sc = new ApexPages.StandardController(c);
        ApexPages.currentPage().getParameters().put('Id', c.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'TecFatToRefFat');
        new PO_ServiziFattibilita_Controller(sc);
        
        ApexPages.currentPage().getParameters().put('Id', c.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'TecFatToNetCre');
        new PO_ServiziFattibilita_Controller(sc);
        
        c.EOF_FAse__c = 'In Lavorazione Referente Fattibilità';
        update c;
        sc = new ApexPages.StandardController(c);
        ApexPages.currentPage().getParameters().put('Id', c.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');
        new PO_ServiziFattibilita_Controller(sc);
        
        ApexPages.currentPage().getParameters().put('Id', c.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        new PO_ServiziFattibilita_Controller(sc);
        
        //cKit
        sc = new ApexPages.StandardController(cKit);
        ApexPages.currentPage().getParameters().put('Id', cKit.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NetCreToTecFat');
        ApexPages.currentPage().getParameters().put('OLO', 'true');
        new PO_ServiziFattibilita_Controller(sc);
        
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_0_01()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name, DeveloperName from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_Lease' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Richiesta_a_servizio_a_fattibilit' Limit 1];
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
        
        /* order ord = new order();
            ord.name='test';
            ord.isFiberLease__c=true;
            ord.AccountId= acc.Id;
            ord.Status='Aperto';
            ord.EffectiveDate=system.today();
            insert ord;*/
        
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.AccountId = acc.Id;
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
        originalCase1.EOF_FAse__c = 'In Lavorazione Supporto Vendite';

        
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        
        //giovanni
        //posc.OriginalCase=originalCase;
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        
        //posc.esitiCompletati();
        //posc.espletamento();
        //posc.Espletamento_KO();
        
        //giovanni
        posc.ordineFattibilita = true;
        originalCase.eof_comunicazioni_con_olo__c = 'test';
        posc.urlRedir();
        
        posc.InviaAlNetworkCreation();
        posc.inserisciNote();
        //posc.InviaAlDelivery();
        //Posc.richiestaFattibilita=true;
        
        //PO_ServiziFattibilita_Controller.OrderCreation(csList);
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod_0_02()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name, DeveloperName from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_Lease' Limit 1];
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Richiesta_a_servizio_a_fattibilit' Limit 1];
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
        
        /* order ord = new order();
            ord.name='test';
            ord.isFiberLease__c=true;
            ord.AccountId= acc.Id;
            ord.Status='Aperto';
            ord.EffectiveDate=system.today();
            insert ord;*/
        
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.AccountId = acc.Id;
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
        originalCase1.EOF_FAse__c = 'In Lavorazione Supporto Vendite';

        
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        
        //giovanni
        //posc.OriginalCase=originalCase;
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        
        //posc.esitiCompletati();
        //posc.espletamento();
        //posc.Espletamento_KO();
        
        //giovanni
        posc.ordineFattibilita = true;
        originalCase.eof_comunicazioni_con_olo__c = 'test';
        
        posc.sospendi();
        posc.desospendi();
        
        //giovanni
        posc.ordineFattibilita = true;
        
        posc.PrendiInCarico();
        //PO_ServiziFattibilita_Controller.OrderCreation(csList);
        Test.stopTest();
    }
    
    
    
    static testMethod void PO_ServiziFattibilitaTestMethod01_01()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name,developerName from RecordType where SobjectType='Case' and developerName ='PO_Collegamento_Fiber_Lease' Limit 1];                
        
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Richiesta_a_servizio_a_fattibilit' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.AccountId = acc.Id;
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
        originalCase1.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        
        //giovanni
        //posc.OriginalCase=originalCase;
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        
        //posc.esitiCompletati();
        //posc.espletamento();
        //posc.Espletamento_KO();
        posc.InviaAlNetworkCreation();
        posc.inserisciNote();
        //posc.InviaAlDelivery();
        //Posc.richiestaFattibilita=true;
        posc.urlRedir();
        //PO_ServiziFattibilita_Controller.OrderCreation(csList);
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod01_02()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name,developerName from RecordType where SobjectType='Case' and developerName ='PO_Collegamento_Fiber_Lease' Limit 1];                
        
        RecordType rt1 = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Richiesta_a_servizio_a_fattibilit' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'Completato';
        originalCase.AccountId = acc.Id;
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
        originalCase1.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        csList.add(originalCase1);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        String titleTest = posc.title;
        
        //giovanni
        //posc.OriginalCase=originalCase;
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        String CaseIdTest = posc.CaseId;
        String idNotifyTest = posc.idNotify;
        String urlRedirTest = posc.urlRedir;
        String performTest = posc.perform;
        String ruoloDiPartenzaTest = posc.ruoloDiPartenza;
        Case cTest = posc.c;
        
        //posc.esitiCompletati();
        //posc.espletamento();
        //posc.Espletamento_KO();
        posc.sospendi();
        posc.desospendi();
        //posc.InviaAlDelivery();
        //Posc.richiestaFattibilita=true;
        posc.PrendiInCarico();
        //PO_ServiziFattibilita_Controller.OrderCreation(csList);
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod1()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat;    
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;
        
        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.presentaOfferta();
        posc.inserisciNote();
        // posc.annulla();
        Posc.richiestaFattibilita=true;
        posc.collegamentoFattibilita=false;
        posc.PrendiInCarico();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod2()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_IRU' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Ovest';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod3()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Centro';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod4()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_P2P' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Sud';
        originalCase.EOF_FAse__c = 'Completato';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod5()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_P2P' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote(); 
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod6()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NC');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod7()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Del');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod8()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspOK');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        //posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod9()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod10()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Des');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod11()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Ann');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod12()
    {   
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        //posc.inserisciNote();
        posc.getCheckEspletamento();
        posc.inviaAlRefFat();
        posc.inviaAlTecFat();
        posc.assegnaAlTecnico();
        //  posc.confermaAssegnazione();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod13()
    {  
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        RecordType rtAttiva = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_P2P_Attiva' Limit 1];
        
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case casetoOrder = new case();
        casetoOrder.recordtypeId = rt.Id;
        casetoOrder.PO_Richiesta_a_fattibilit__c = originalCase.Id;
        casetoOrder.EOF_Note_Operatore__c = 'Test';
        casetoOrder.Status = 'In Lavorazione';
        casetoOrder.EOF_Note_Interne__c = 'This is Unit tesing';
        casetoOrder.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        casetoOrder.EOF_Note__c = 'UnitTest';
        casetoOrder.PO_Note_fattibilit__c = 'Test';
        casetoOrder.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        casetoOrder.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        
        //giovanni
        casetoOrder.PO_Incluso_nell_offerta__c = true;
        
        casetoOrder.AccountId = acc.Id;
        insert casetoOrder;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        try{ posc.originalCase=originalCase;
            posc.confermaAssegnazione();
            posc.creaOrdine();
           }
        catch(exception e){}
        
        try{ posc.originalCase=originalCase;
            
            originalCase.recordtypeId = rtAttiva.Id;
            
            
            posc.confermaAssegnazione();
            posc.creaOrdine();
           }
        catch(exception e){}
        
        
        Test.stopTest();
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////  
    static testMethod void PO_ServiziFattibilitaTestMethod15()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_IRU' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Ovest';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod16()
    {  
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Centro';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod17()
    {  
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_P2P' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Sud';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod18()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_P2P' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod19()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NC');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod20()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Del');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod21()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspOK');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        //posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod22()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'Offerta Accettata';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod23()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Des');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod24()
    {         
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase.EOF_FAse__c = 'In Lavorazione Tecnico Fattibilità';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Ann');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.accettaOfferta();
        posc.mostraNoteTecFatToRefFat=true;
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod25()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Completato';
        
        originalCase1.AccountId = acc.Id;
        //insert originalCase1;
        csList.add(originalCase);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        
        posc.esitiCompletati();
        posc.accettaOfferta();
        posc.getCheckEspletamento();
        //posc.espletamento();
        posc.sospendi();
        //posc.Espletamento_KO();
        Test.stopTest();
    }
    
    
    static testMethod void PO_ServiziFattibilitaTestMethod26()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Ovest';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case casetoOrder = new case();
        casetoOrder.recordtypeId = rt.Id;
        casetoOrder.PO_Richiesta_a_fattibilit__c = originalCase.Id;
        casetoOrder.EOF_Note_Operatore__c = 'Test';
        casetoOrder.Status = 'In Lavorazione';
        casetoOrder.EOF_Note_Interne__c = 'This is Unit tesing';
        casetoOrder.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        casetoOrder.EOF_Note__c = 'UnitTest';
        casetoOrder.PO_Note_fattibilit__c = 'Test';
        casetoOrder.PO_Assegnazione_Area_Geografica__c = 'Nord Ovest';
        casetoOrder.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        casetoOrder.AccountId = acc.Id;
        insert casetoOrder;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        try{ posc.originalCase=originalCase;
            posc.confermaAssegnazione();
            posc.creaOrdine();
            posc.assegnaAlTecnico();
           }
        catch(exception e){}
        
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod27()
    {  
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Centro';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case casetoOrder = new case();
        casetoOrder.recordtypeId = rt.Id;
        casetoOrder.PO_Richiesta_a_fattibilit__c = originalCase.Id;
        casetoOrder.EOF_Note_Operatore__c = 'Test';
        casetoOrder.Status = 'In Lavorazione';
        casetoOrder.EOF_Note_Interne__c = 'This is Unit tesing';
        casetoOrder.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        casetoOrder.EOF_Note__c = 'UnitTest';
        casetoOrder.PO_Note_fattibilit__c = 'Test';
        casetoOrder.PO_Assegnazione_Area_Geografica__c = 'Centro';
        casetoOrder.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        casetoOrder.AccountId = acc.Id;
        insert casetoOrder;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        try{ posc.originalCase=originalCase;
            posc.confermaAssegnazione();
            posc.creaOrdine();
            posc.assegnaAlTecnico();
           }
        catch(exception e){}
        
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod28()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Sud';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case casetoOrder = new case();
        casetoOrder.recordtypeId = rt.Id;
        casetoOrder.PO_Richiesta_a_fattibilit__c = originalCase.Id;
        casetoOrder.EOF_Note_Operatore__c = 'Test';
        casetoOrder.Status = 'In Lavorazione';
        casetoOrder.EOF_Note_Interne__c = 'This is Unit tesing';
        casetoOrder.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        casetoOrder.EOF_Note__c = 'UnitTest';
        casetoOrder.PO_Note_fattibilit__c = 'Test';
        casetoOrder.PO_Assegnazione_Area_Geografica__c = 'Sud';
        casetoOrder.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        casetoOrder.AccountId = acc.Id;
        insert casetoOrder;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        try{ posc.originalCase=originalCase;
            posc.confermaAssegnazione();
            posc.creaOrdine();
            posc.assegnaAlTecnico();
           }
        catch(exception e){}
        
        Test.stopTest();
    }
    
    
    static testMethod void PO_ServiziFattibilitaTestMethod29()
    {  
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Ovest';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        //posc.inserisciNote();
        posc.getCheckEspletamento();
        posc.inviaAlRefFat();
        posc.inviaAlTecFat();
        posc.assegnaAlTecnico();
        //  posc.confermaAssegnazione();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod30()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Sud';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        //posc.inserisciNote();
        posc.getCheckEspletamento();
        posc.inviaAlRefFat();
        posc.inviaAlTecFat();
        posc.assegnaAlTecnico();
        //  posc.confermaAssegnazione();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod31()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Centro';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        //posc.inserisciNote();
        posc.getCheckEspletamento();
        posc.inviaAlRefFat();
        posc.inviaAlTecFat();
        posc.assegnaAlTecnico();
        //  posc.confermaAssegnazione();
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod32()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper','SupVenToNetCre');
        //ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        posc.getCheckEspletamento();
        posc.inviaAlRefFat();
        posc.inviaAlTecFat();
        posc.assegnaAlTecnico();
        //  posc.confermaAssegnazione();
        Test.stopTest();
    }
    
    //22/09/2017 CRM start
    static testMethod void PO_ServiziFattibilitaTestMethod33()
    {
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        //22/09/2017 CRM
        originalCase.PO_Esito_collegamento__c = 'SI in FTTH';
        originalCase.PO_BB_1_interessato__c = 9999;
        originalCase.PO_Posa_1_nuovo_Drop__c = 9999;
        originalCase.PO_Lunghezza_m__c = 9999;
        originalCase.PO_Drop_FL_1__c = true;
        //22/09/2017 CRM END
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Completato';
        
        originalCase1.AccountId = acc.Id;
        //insert originalCase1;
        csList.add(originalCase);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.esitiCompletati();
        Test.stopTest();
    }	
    
    
    static testMethod void PO_ServiziFattibilitaTestMethod34()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        //22/09/2017 CRM
        originalCase.PO_Esito_collegamento__c = 'SI in FTTH';
        originalCase.PO_BB_1_interessato__c = 9999;
        originalCase.PO_Posa_1_nuovo_Drop__c = 9999;
        originalCase.PO_Lunghezza_m__c = 9999;
        originalCase.PO_Drop_FL_1__c = true;
        //22/09/2017 CRM END
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt.Id;
        originalCase1.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase1.EOF_Note_Operatore__c = 'Test';
        originalCase1.Status = 'Acquisito';
        OriginalCase1.PO_Esito_collegamento__c='KO';
        originalCase1.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase1.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase1.EOF_Note__c = 'UnitTest';
        originalCase1.PO_Note_fattibilit__c = 'Test';
        originalCase1.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        originalCase1.EOF_FAse__c = 'Completato';
        //22/09/2017 CRM
        originalCase1.PO_Esito_collegamento__c = 'SI in FTTH';
        originalCase1.PO_BB_1_interessato__c = 9999;
        originalCase1.PO_Posa_1_nuovo_Drop__c = 9999;
        originalCase1.PO_Lunghezza_m__c = 9999;
        originalCase1.PO_Drop_FL_1__c = true;
        //22/09/2017 CRM END
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.esitiCompletati();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod35()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        //22/09/2017 CRM
        originalCase.PO_Esito_collegamento__c = 'SI in FTTH';
        originalCase.PO_BB_1_interessato__c = 9999;
        originalCase.PO_Posa_1_nuovo_Drop__c = 9999;
        originalCase.PO_Lunghezza_m__c = 9999;
        originalCase.PO_Drop_FL_1__c = true;
        //22/09/2017 CRM END
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case originalCase1 = new case();
        originalCase1.recordtypeId = rt.Id;
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
        //22/09/2017 CRM
        originalCase1.PO_Esito_collegamento__c = 'SI in FTTH';
        originalCase1.PO_BB_1_interessato__c = 9999;
        originalCase1.PO_Posa_1_nuovo_Drop__c = 9999;
        originalCase1.PO_Lunghezza_m__c = 9999;
        originalCase1.PO_Drop_FL_1__c = true;
        //22/09/2017 CRM END
        
        originalCase1.AccountId = acc.Id;
        insert originalCase1;
        csList.add(originalCase);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.esitiCompletati();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod36()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        //22/09/2017 CRM
        originalCase.PO_Esito_collegamento__c = 'SI in FTTH';
        originalCase.PO_BB_1_interessato__c = 9999;
        originalCase.PO_Posa_1_nuovo_Drop__c = 9999;
        //originalCase.PO_Lunghezza_m__c = 9999;
        originalCase.PO_Drop_FL_1__c = true;
        //22/09/2017 CRM END
        originalCase.AccountId = acc.Id;
        insert originalCase;
        csList.add(originalCase);
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.esitiCompletati();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod37()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_lease' Limit 1];
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
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Nord Est';
        //originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        //22/09/2017 CRM
        originalCase.PO_Esito_collegamento__c = 'SI in FTTH';
        originalCase.PO_BB_1_interessato__c = 9999;
        //originalCase.PO_Posa_1_nuovo_Drop__c = 9999;
        originalCase.PO_Lunghezza_m__c = 9999;
        originalCase.PO_Drop_FL_1__c = false;
        //22/09/2017 CRM END
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        csList.add(originalCase);
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        
        posc.esitiCompletati();
        posc.InviaAlSupportoVendite();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod38()
    { 
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper','NetCreToSupVen');
        //ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod39()
    {  
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper','DelToSupVen');
        //ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        Test.stopTest();
    }
    
    //22/09/2017 CRM
    public static list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustomSettingFibLease()
    {
        list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustSettList = new list<OF_FiberLeaseListinoPrezzoAnnuo__c>();
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs1 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '1',
            Anno__c = '2030',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs1);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs2 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '2',
            Anno__c = '2029',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs2);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs3 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '3',
            Anno__c = '2028',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs3);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs4 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '4',
            Anno__c = '2027',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs4);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs5 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '5',
            Anno__c = '2026',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs5);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs6 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '6',
            Anno__c = '2025',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs6);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs7 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '7',
            Anno__c = '2024',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs7);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs8 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '8',
            Anno__c = '2023',
            Prezzo__c = 2.63
        );
        CustSettList.add(cs8);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs9 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '9',
            Anno__c = '2022',
            Prezzo__c = 2.79
        );
        CustSettList.add(cs9);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs10 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '10',
            Anno__c = '2021',
            Prezzo__c = 3.10
        );
        CustSettList.add(cs10);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs11 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '11',
            Anno__c = '2020',
            Prezzo__c = 3.41
        );
        CustSettList.add(cs11);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs12 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '12',
            Anno__c = '2019',
            Prezzo__c = 3.72
        );
        CustSettList.add(cs12);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs13 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '13',
            Anno__c = '2018',
            Prezzo__c = 4.03
        );
        CustSettList.add(cs13);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs14 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '14',
            Anno__c = '2017',
            Prezzo__c = 4.65
        );
        CustSettList.add(cs14);
        
        insert CustSettList;
        return CustSettList;
    }
    
    //22/09/2017 CRM
    public static list<OF_FiberLeasePrezzoMedioAnnuo__c> CustomSettingFibLease1()
    {
        list<OF_FiberLeasePrezzoMedioAnnuo__c> CustSettList = new list<OF_FiberLeasePrezzoMedioAnnuo__c>();
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Backbone1',
            Prezzo__c = 0.34
        );
        CustSettList.add(cs);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs1 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Backbone2',
            Prezzo__c = 0.34
        );
        CustSettList.add(cs1);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs2 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Drop1',
            Prezzo__c = 2.63
        );
        CustSettList.add(cs2);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs3 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Drop2',
            Prezzo__c = 2.63
        );
        CustSettList.add(cs3);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs4 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Drop2AltreCoppie',
            Prezzo__c = 0.84
        );
        CustSettList.add(cs4);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs5 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'CostanteFiberLease1',
            Prezzo__c = 0.08
        );
        CustSettList.add(cs5);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs6 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'CostanteFiberLease2',
            Prezzo__c = 0.55
        );
        CustSettList.add(cs6);
        
        insert CustSettList;
        return CustSettList;
    }
    
    //22/09/2017 CRM END
    
    public static testmethod void PO_ServiziFattibilitaTestMethod40(){
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;        
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);   
        PO_ServiziFattibilita_Controller.findObjectNameFromRecordIdPrefix('test');
        test.stopTest();    
    }
    
    /*
Private Class
EC
*/
    
    
    public static testmethod void PO_ServiziFattibilitaTestMethod42(){
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
        List<Asset> assList = new List<Asset>();
        Asset asst = new Asset();
        asst.Name = 'TestdiprovaTIS';
        asst.accountId=acc.Id;
        asst.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        //asst.recordTypeId = rtId;
        //insert asst;
        
        Asset asst1 = new Asset();
        asst1.Name = 'TestdiprovaTIS';
        asst1.accountId=acc.Id;
        asst1.OF_IDCaseAttivazione__c = cs.Id;
        //asst1.recordTypeId = rtId1;
        //insert asst1;
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        insert o;
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Network Creation';
        originalCase.AccountId = acc.Id;
        originalCase.PO_Case_Collegamento__c = cs.Id;
        insert originalCase;     
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);

        Attachment atc = new Attachment();
        atc.ParentId = originalCase.PO_Case_Collegamento__c;
        atc.body = Blob.valueof('test');
        atc.Name = 'test';
        insert atc;
        
        test.startTest();
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_controller psf = new PO_ServiziFattibilita_controller(sc);
        psf.InvioPSM();
        psf.CessazionePSM(); 
        psf.AnnullaPSM();
        //psf.UserInQueueGET();
        //psf.espletamento();
        psf.Espletamento_KO();
        test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod43()
    {
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Collegamento_P2P' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;
        
        //giovanni
        Order theOrder = new Order();
        theOrder.AccountId = acc.Id;
        theOrder.Status = 'Aperto';
        theOrder.Description= 'test';
        theOrder.EffectiveDate = system.today();
        //theOrder.PO_Opportunity__c=OppRecA.Id;
        //theOrder.isFiberLease__c=true; 
        insert theOrder;
        
        //Order Where Id = :originalCase.OF_Order__c];
        
        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Network Creation';
        originalCase.AccountId = acc.Id;
        
        //giovanni
        originalCase.OF_Order__c = theOrder.Id;
        
        insert originalCase;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        posc.inserisciNote();
        
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        posc.inserisciNote();
        
        Test.stopTest();
    }    
    
    static testMethod void PO_ServiziFattibilitaTestMethod44(){
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;     
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Map<String,Id> mapRType= new Map<String,Id>();
        for(recordtype rti : [select id,developername from recordtype]){
            mapRType.put(rti.developername,rti.id);
        }
       //  OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        test.startTest();
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_controller psf = new PO_ServiziFattibilita_controller(sc);
        boolean ordineFattibilita=true;
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        //  psf.espletamento();  
        Test.stopTest();
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod45(){
        //TestDataFactory.CreateTestRecords(null,null,null);
        //RecordType rTa = [Select id from RecordType where SobjectType='Asset' and DeveloperName='OF_GPONPassiva' Limit 1];
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = cs.Id;//'5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = cs.Id;//'5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = cs.Id;//'5008E0000091EIF';
        asst4.recordTypeId = rtId4;
        insert asst4;
        
        //Asset a=[Select id from Asset where id=asst3.id/*where RecordType.DeveloperName='OF_GPONPassiva'*/Limit 1];
        String s =asst4.id;
        Test.startTest();
        
        String s2=PO_ServiziFattibilita_Controller.findObjectNameFromRecordIdPrefix(s);
        System.assertEquals('Asset', s2);
        Test.stopTest();
    }
    static testMethod void PO_ServiziFattibilitaTestMethod46(){
        //TestDataFactory.CreateTestRecords(null,null,null);
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        //Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId =rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;   
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Map<String,Id> mapRType= new Map<String,Id>();
        for(recordtype rti : [select id,developername from recordtype]){
            mapRType.put(rti.developername,rti.id);
        }
        
      // OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        List<Case> caseList = new List<Case>();
        caseList.add(originalCase);
        caseList.add(cs);
        caseList.add(cases);
        
        
        Test.startTest();
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_Controller psf = new PO_ServiziFattibilita_Controller(sc);
        boolean ordineFattibilita=true;
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        
        PO_ServiziFattibilita_Controller.OrderCreation(caseList);
        
        Test.stopTest();
        
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod47(){
        //TestDataFactory.CreateTestRecords(null,null,null);
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        //Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        
        /*ECCCCCCCC @@@
* Map<String,Id> mapRType= new Map<String,Id>();
for(recordtype rti : [select id,developername from recordtype]){
mapRType.put(rti.developername,rti.id);
}
*/
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;   
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Map<String,Id> mapRType= new Map<String,Id>();
        for(recordtype rti : [select id,developername from recordtype]){
            mapRType.put(rti.developername,rti.id);
        }
        
       // OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        List<Case> caseList = new List<Case>();
        caseList.add(originalCase);
        caseList.add(cs);
        caseList.add(cases);
        
        
        Test.startTest();
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_Controller psf = new PO_ServiziFattibilita_Controller(sc);
        boolean ordineFattibilita=true;
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();
        ordineFattibilita = true;
        psf.PrendiInCarico();
    }
    
    
    static testMethod void PO_ServiziFattibilitaTestMethod48(){
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        //Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId =rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;   
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Map<String,Id> mapRType= new Map<String,Id>();
        for(recordtype rti : [select id,developername from recordtype]){
            mapRType.put(rti.developername,rti.id);
        }
        
        // OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        List<Case> caseList = new List<Case>();
        caseList.add(originalCase);
        caseList.add(cs);
        caseList.add(cases);
        
        
        Test.startTest();        
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_Controller psf = new PO_ServiziFattibilita_Controller(sc);
        boolean ordineFattibilita=true;
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        
        PO_ServiziFattibilita_Controller.OrderCreation(caseList);
        
        Test.stopTest();
        
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod49(){
        //TestDataFactory.CreateTestRecords(null,null,null);
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        //Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId =rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;   
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Map<String,Id> mapRType= new Map<String,Id>();
        for(recordtype rti : [select id,developername from recordtype]){
            mapRType.put(rti.developername,rti.id);
        }
        
       // OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        List<Case> caseList = new List<Case>();
        caseList.add(originalCase);
        caseList.add(cs);
        caseList.add(cases);
        
        
        Test.startTest();
        
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_Controller psf = new PO_ServiziFattibilita_Controller(sc);
        boolean ordineFattibilita=true;
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        
        PO_ServiziFattibilita_Controller.OrderCreation(caseList);
        
        Test.stopTest();
        
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod50(){
        //TestDataFactory.CreateTestRecords(null,null,null);
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        //Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId =rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;   
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Map<String,Id> mapRType= new Map<String,Id>();
        for(recordtype rti : [select id,developername from recordtype]){
            mapRType.put(rti.developername,rti.id);
        }
        
    //    OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        List<Case> caseList = new List<Case>();
        caseList.add(originalCase);
        caseList.add(cs);
        caseList.add(cases);
        
        
        Test.startTest();
        
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_Controller psf = new PO_ServiziFattibilita_Controller(sc);
        boolean ordineFattibilita=true;
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        
        PO_ServiziFattibilita_Controller.OrderCreation(caseList);
        
        Test.stopTest();
        
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod51(){
        //TestDataFactory.CreateTestRecords(null,null,null);
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        //Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        /*
List<Case> caseToInsert = new List<Case>();
MAp<String,String> rtMap = new MAp<String,String>();
for(recordType RT : RList){
rtMap.Put(rt.developerName, rt.Id);
}
*/
        //Id rtCId4 = [select id from RecordType where SobjectType='Case' and DeveloperName = 'PO_Ordine_Fiber_link' Limit 1];
        
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId =rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;   
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        Map<String,Id> mapRType= new Map<String,Id>();
        for(recordtype rti : [select id,developername from recordtype]){
            mapRType.put(rti.developername,rti.id);
        }
        
       //  OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        List<Case> caseList = new List<Case>();
        caseList.add(originalCase);
        caseList.add(cs);
        caseList.add(cases);
        
        
        Test.startTest();
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_Controller psf = new PO_ServiziFattibilita_Controller(sc);
        boolean ordineFattibilita=true;
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        
        PO_ServiziFattibilita_Controller.OrderCreation(caseList);
        
        Test.stopTest();
        
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod52(){
        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        RecordType oRt = [select id, Name, developerName from RecordType where SobjectType='Order' and developerName='OF_INORDER' Limit 1];
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;  
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('Open Stream').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('P2P').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('Fiber Link').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
        //Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        
        // Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        
        Pricebook2 stdPb = new Pricebook2();
        // stdPb.OF_Listino__c=l.Id;
        stdPb.name='test';
        stdPb.isActive=true;
        insert stdPb;
        
        // Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
        //insert pbk1;
        Contract nc=new Contract();
        nc.AccountId = acc.id;
        insert nc;
        
        OF_Listino__c  lc=new  OF_Listino__c();
        lc.Name='Testing';
        lc.OF_IDContract__c=nc.id; 
        lc.OF_DataInizioValidita__c=Date.newInstance(2018,12,1);
        lc.OF_DataFineValidita__c=Date.newInstance(2018,12,5);    
        insert lc;
        
        Product2 p = new product2(name='x');
        p.OF_ListinoCustom__c = lc.Id;
        p.PO_Anni_Fiber_Link__c = '1 Anno';
        insert p;
        
        
        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
        OppRecA.PO_Offerta_totale__c = OppRecA.Id;
        //OppRecA.PO_Richiesta_fattibilit__c = cases.Id;
        //OppRecA.PO_Durata_affitto__c = PO_Richiesta_fattibilit__r.PO_Durata_affitto__c;   
        insert OppRecA;
        
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3,Product2Id = p.Id );
        insert OppLI_Rec;
        
        List<order> oList = new List<order>();
        order ord3 = new order();
        ord3.AccountId = acc.Id;
        ord3.Status = 'Aperto';
        ord3.Description= 'test';
        ord3.EffectiveDate = system.today();
        ord3.PO_Opportunity__c=OppRecA.Id;
        ord3.isFiberLease__c=true;  
        //insert ord3;
        
        order ord2 = new order();
        ord2.AccountId = acc.Id;
        ord2.Status = 'Aperto';
        ord2.Description= 'test';
        ord2.EffectiveDate = system.today();
        ord2.PO_Opportunity__c=OppRecA.Id;
        ord2.isFiberLease__c=true;  
        insert ord2;
        
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
        assList.add(asst);
        assList.add(asst1);
        insert assList;
        
        List<order> orList = new List<order>();
        
        Order o = new Order();
        //o.OWNERID ='0058E000002bADhQAM';
        o.CONTRACTID =nc.id; 
        o.ACCOUNTID= acc.id;//'0018E00000dbbWyQAI';
        o.RECORDTYPEID=oRt.id;
        o.EFFECTIVEDATE= System.today();
        o.ISREDUCTIONORDER=false;
        o.STATUS ='Aperto';
        // o.STATUSCODE ='D';
        // o.OF_CASENOME__C ='Test0000001';
        o.OF_ISFROMASSET__C= false;
        o.PO_ISFROMOPPORTUNITY__C=true;
        o.PO_OPPORTUNITY__C=OppRecA.id;
        o.ISFIBERLEASE__C =false;
        o.ISFIBERLINK__C =false;
        // insert o;
        
        
        order ord = new order();
        ord.OF_Asset__c=assList[0].Id;
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.Description= 'test';
        ord.EffectiveDate = system.today();
        ord.isFiberLease__c=true;   
        ord.PO_Opportunity__c=OppRecA.Id;
        
        //insert ord ;
        
        order ord1 = new order();
        ord1.AccountId = acc.Id;
        ord1.OF_Asset__c=assList[0].Id;
        ord1.Status = 'Aperto';
        ord.Description= 'test';
        ord1.EffectiveDate = system.today();
        ord1.PO_Opportunity__c=OppRecA.Id;
        ord1.isFiberLease__c=true;  
        //insert ord1 ;
        
        orList.add(o);
        orList.add(ord);
        orList.add(ord1);
        insert orList;
        
        Asset asst2 = new Asset();
        asst2.Name = 'test';
        asst2.accountId=acc.Id;
        asst2.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst2.recordTypeId = rtId2;
        insert asst2;
        
        Asset asst3 = new Asset();
        asst3.Name = 'test';
        asst3.accountId=acc.Id;
        asst3.OF_IDCaseAttivazione__c = '5008E0000091EIF';
        asst3.recordTypeId = rtId3;
        insert asst3;
        
        Asset asst4 = new Asset();
        asst4.Name = 'test';
        asst4.accountId=acc.Id;
        asst4.OF_IDCaseAttivazione__c = '5008E0000091EIF';
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
        
        
        OF_CommercialElementIstanziato__c commercial = new OF_CommercialElementIstanziato__c();
        commercial.OF_Asset__c = asst.Id;
        commercial.OF_AssetTratta__c = asst.Id;
        commercial.OF_Case__c = cases.Id;
        commercial.OF_CaseTratta__c = cases.Id;
        commercial.OF_CommercialElement__c = ce.Id;
        commercial.OF_Stato__c = 'Attivo';
        //commercial.recordtypeid =rtId;
        insert commercial;
        
        Map<ID,Order> mappaAssetIDOrderFiberLease = new Map<ID,order>();
        
//List<Case> caseToInsert = new List<Case>();
        MAp<String,String> rtMap = new MAp<String,String>();
        for(recordType rtp : [select id,developername from recordtype]){
            rtMap.Put(rtp.developerName, rtp.Id);
        }

        //Id rtCId4 = [select id from RecordType where SobjectType='Case' and DeveloperName = 'PO_Ordine_Fiber_link' Limit 1];
        
        
        
        case originalCase = new case();
        originalCase.OF_Order__c=o.id;
        originalCase.recordtypeId =rtMap.get('PO_Collegamento_Fiber_Lease');
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.Status = 'Espletato';
        originalCase.EOF_FAse__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c=true;
        originalCase.AccountId = acc.Id;
        insert originalCase;   
        
        EOF_Notify__c notifyPSM = new EOF_Notify__c();
        notifyPSM.Caso__c=originalCase.id;
        notifyPSM.EOF_Data_Notifica__c= system.today();
        
        insert notifyPSM;
        
        PO_ServiziFattibilita_Controller.createAssetId=assList[0].Id;
        
        PO_UtilitiesPortalino costruttore = new PO_UtilitiesPortalino();
        String proc = 'Portalino';
        //costruttore.PO_CreatePBE_Portalino(orList, proc); 
        
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
       // OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList);
       /* OF_IstanziazioneAsset.CreazioneAssetFromProcess(orList,
                                                        mapRType.get('OF_GPONPassiva'),
                                                        mapRType.get('OF_OpenStream'),
                                                        mapRType.get('P2P'),
                                                        mapRType.get('Fiber_Link'),
                                                        mapRType.get('Fiber_Lease')
                                                       ); */
        
        List<Case> caseList = new List<Case>();
        caseList.add(originalCase);
        caseList.add(cs);
        caseList.add(cases);
        
        
        Test.startTest();
        test.setMock(WebserviceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);        
        PO_ServiziFattibilita_Controller psf = new PO_ServiziFattibilita_Controller(sc);
        boolean ordineFattibilita=true;
        
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        psf.inserisciNote();

        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToSupVen');        
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        
        ApexPages.currentPage().getParameters().put('Oper', 'RefFatToTecFat');
        originalCase.EOF_FAse__c='In Lavorazione Referente Fattibilità';
        update originalCase;
        
        PO_ServiziFattibilita_Controller.OrderCreation(caseList);
        
        Test.stopTest();
        
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod53()
    {        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1]; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;
        
        //giovanni
        Order theOrder = new Order();
        theOrder.AccountId = acc.Id;
        theOrder.Status = 'Aperto';
        theOrder.Description= 'test';
        theOrder.EffectiveDate = system.today();
        //theOrder.PO_Opportunity__c=OppRecA.Id;
        //theOrder.isFiberLease__c=true; 
        insert theOrder;            
        
        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        
        originalCase.OF_Order__c = theOrder.Id;
        
        originalCase.AccountId = acc.Id;
        insert originalCase;        
        
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);  
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        
        posc.P2PAttiva_esitiCompletati();
        
        originalCase.PO_Esito_collegamento__c = 'KO';
        update originalCase;        
        posc.P2PAttiva_esitiCompletati();
        
        originalCase.PO_Esito_collegamento__c = 'SI in FTTH';
        update originalCase;  
        posc.P2PAttiva_esitiCompletati();
        
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();
        theLog.Caso__c = originalCase.id;
        insert theLog;
        
        
        //posc.espletamento();
        posc.updateLog(originalCase.id);
        posc.updateLog(cs.id, originalCase.id);
        
        test.stopTest(); 
                
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod54()
    {        
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1]; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;
        
        //giovanni
        Order theOrder = new Order();
        theOrder.AccountId = acc.Id;
        theOrder.Status = 'Aperto';
        theOrder.Description= 'test';
        theOrder.EffectiveDate = system.today();
        //theOrder.PO_Opportunity__c=OppRecA.Id;
        //theOrder.isFiberLease__c=true; 
        insert theOrder;            
        
        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id;
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        
        originalCase.PO_Esito_collegamento__c = 'KO';
        
        originalCase.OF_Order__c = theOrder.Id;
        
        originalCase.AccountId = acc.Id;
        insert originalCase;        
        
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);  
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
               
        
        posc.P2PAttiva_esitiCompletati();
        
        
        test.stopTest(); 
                
    } 
    
    static testMethod void PO_ServiziFattibilitaTestMethod55()
    {        
        ////TestDataFactory.CreateTestRecords(null,null,null);
        
        PO_ServFatt_DataFactory.WrapData result = PO_ServFatt_DataFactory.createP2PAttivaData();
        
        /*
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1]; 
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
        cs.origin = 'Web';
        cs.Priority = 'Medium';
        cs.PO_OLO_Registrazione__c = 'Test';
        cs.PO_Struttura_di_appartenenza_registrazio__c = 'Test';
        cs.PO_Cognome_Registrazione__c = 'Test';
        insert cs;
        
        //giovanni
        Order theOrder = new Order();
        theOrder.AccountId = acc.Id;
        theOrder.Status = 'Aperto';
        theOrder.Description= 'test';
        theOrder.EffectiveDate = system.today();
        //theOrder.PO_Opportunity__c=OppRecA.Id;
        //theOrder.isFiberLease__c=true; 
        insert theOrder;            
        
        case originalCase = new case();
        originalCase.recordtypeId = rt.Id;
        originalCase.PO_Richiesta_a_fattibilit__c = cs.Id; 
        originalCase.EOF_Note_Operatore__c = 'Test';
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Isole';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        
        originalCase.PO_Esito_collegamento__c = 'OK';
        
        originalCase.OF_Order__c = theOrder.Id;
        
        originalCase.AccountId = acc.Id;
        insert originalCase;        
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();
        theLog.Caso__c = originalCase.id;
        insert theLog;
        
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        */
        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c();
        theLog.Caso__c = result.caseCollegamento.Id;
        insert theLog;
        
        result.caseCollegamento.PO_Esito_collegamento__c = 'SI in FTTH';
        update result.caseCollegamento;
        
        ApexPages.currentPage().getParameters().put('Id', result.caseCollegamento.Id);
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(result.caseCollegamento);  
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
               
        
        posc.P2PAttiva_esitiCompletati();
        
        posc.kitP2PAttiva = true;
        
        posc.kitVerificaOK();
        posc.kitVerificaKO();
                
        test.stopTest();                 
    }     
    
    static testMethod void PO_ServiziFattibilitaTestMethod56()
    {        
        ////TestDataFactory.CreateTestRecords(null,null,null);
        
        PO_ServFatt_DataFactory.WrapData result = PO_ServFatt_DataFactory.createP2PAttivaData();
        
	    /*
        result.casePadre.PO_P2P_Attiva__c = false;        
        RecordType rtOther = [select id,Name, DeveloperName from RecordType where SobjectType='case' and developerName ='PO_Collegamento_Fiber_Lease' Limit 1];
        result.casePadre.RecordTypeId = rtOther.Id;
        update result.casePadre;
        */        
        
        ApexPages.currentPage().getParameters().put('Id', result.casePadre.Id);
        
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(result.casePadre);  
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);        
        
        posc.espletamento();   
        
        test.stopTest(); 
    }
    
    static testMethod void PO_ServiziFattibilitaTestMethod57()
    { 
        //TestDataFactory.CreateTestRecords(null,null,null);
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        RecordType rt = [select id,Name from RecordType where SobjectType='case' and developerName ='PO_Registrazione' Limit 1];
        
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        case cs = new case();
        cs.status = 'In Lavorazione';
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
        originalCase.Status = 'In Lavorazione';
        originalCase.EOF_Note_Interne__c = 'This is Unit tesing';
        originalCase.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        originalCase.EOF_Note__c = 'UnitTest';
        originalCase.PO_Note_fattibilit__c = 'Test';
        originalCase.PO_Assegnazione_Area_Geografica__c = 'Sud';
        originalCase.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        originalCase.AccountId = acc.Id;
        insert originalCase;
        
        case casetoOrder = new case();
        casetoOrder.recordtypeId = rt.Id;
        casetoOrder.PO_Richiesta_a_fattibilit__c = originalCase.Id;
        casetoOrder.EOF_Note_Operatore__c = 'Test';
        casetoOrder.Status = 'In Lavorazione';
        casetoOrder.EOF_Note_Interne__c = 'This is Unit tesing';
        casetoOrder.EOF_Comunicazioni_con_OLO__c = 'This is Unit tesing';
        casetoOrder.EOF_Note__c = 'UnitTest';
        casetoOrder.PO_Note_fattibilit__c = 'Test';
        casetoOrder.PO_Assegnazione_Area_Geografica__c = 'Sud';
        casetoOrder.EOF_FAse__c = 'In Lavorazione Supporto Vendite';
        casetoOrder.AccountId = acc.Id;
                
        casetoOrder.PO_Incluso_nell_offerta__c = true;
        
        insert casetoOrder;
        
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', originalCase.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'EspKO');
        
        ApexPages.StandardController sc = new ApexPages.StandardController(originalCase);
        PO_ServiziFattibilita_Controller posc = new PO_ServiziFattibilita_Controller(sc);
        Group testGroup = new Group();
        testGroup.Name = 'testGroup';
        testGroup.DeveloperName = 'Test';
        testGroup.Type = 'Queue';
        insert testGroup;
        
        Test.startTest();
        
        posc.CaseKit = new List<case>();
        posc.usr = new User();
            
        Test.stopTest();
    }    
}
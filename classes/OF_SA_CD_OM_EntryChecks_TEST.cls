@isTest
public class OF_SA_CD_OM_EntryChecks_TEST {
    
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
        
        testSetUpData();
        
        Verticali__c cs2 = new Verticali__c();
		cs2.createNotifyBatchLimit__c = 10000;
		cs2.callWsBillingBatchSize__c = 4;
	
		cs2.RecordTypesAssets__c ='\'OF_Open_Stream\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'';
		
		insert cs2;
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
    
    public static void createContrattoServizio(Contract contratto, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = contratto.id;
        cs.OF_Servizio__c = serv.id;
        insert cs;
    }
    
    public static OF_Servizio__c createServizio(OF_CatalogoCommerciale__c cat, String nome_servizio)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = nome_servizio;
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio;
	    servizio.OF_DataFineValidita__c = fine;
	    servizio.OF_CatalogoCommerciale__c = cat.id;
	    insert servizio;
	    return servizio;
    }
    
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
	
	public static void CEIst(case c)
    { 
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_commercialElementIstanziato__c CE = new OF_commercialElementIstanziato__c();
        CE.Recordtypeid = RecordTypeMap.get('CPE');
        CE.OF_SA_CPE__c = c.id;
        CE.OF_Case__c = c.id;
        CE.OF_TipologiaApparato__C = 'T';
        insert CE;
    }
	
    public static void CEIst1(case c)
    { 
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_commercialElementIstanziato__c CE1 = new OF_commercialElementIstanziato__c();
        CE1.Recordtypeid = RecordTypeMap.get('Servizi Aggiuntivi');
        CE1.OF_SA_Servizio_Aggiuntivo__c = c.id;
        CE1.OF_Case__c = c.id;
        CE1.OF_Nome_Servizio__C = 'T';
        insert CE1;
    }
    
    public static void CEIst2(case c)
    { 
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_commercialElementIstanziato__c CE2 = new OF_commercialElementIstanziato__c();
        CE2.Recordtypeid = RecordTypeMap.get('VLAN');
        CE2.OF_SA_VLAN__c = c.id;
        CE2.OF_Case__c = c.id;
        CE2.OF_Nome_Servizio__C = 'T';
        CE2.OF_ServiceVLAN__c = 'T';
        CE2.OF_UserVLAN__c = 'T';
        insert CE2;
    }
   
	static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'OF_commercialElementIstanziato__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
		
		for(RecordType rt: rtypes)
    		RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
	
    /*****************START SyncChecksNotifyCompletionOrder(method first)*******************/
    
    public static testmethod void Metodo1(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c,OF_Order__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        //co.CODICE_OPERATORE = 'VF';
        co.CODICE_OPERATORE = ' ';
        //co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo2(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c,OF_Order__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        //co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo3(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c,OF_Order__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        //co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo4(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo5(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        //co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo6(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        //co.ID_NOTIFICA = 'T';
        
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo7(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo8(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        //co.STATO_ORDINE = '1';
        
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo9(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.STATO_ORDINE = '22';
        
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo10(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.STATO_ORDINE = '1';
        //co.CODICE_MOTIVAZIONE = 'T';
        
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo11(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '12345';
        
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo12(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '12';
        //co.MOTIVAZIONE = 'T';
         
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo13(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        //co.ID_RISORSA = 'T';
        
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo14(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
         
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '1';
        co.ID_RISORSA = '12345678901234567890123456789012345678901234567890';
         
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo15(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '1';
        //co.ID_RISORSA = '12345678901234567890123456789012345678901234567890';
        //co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
  
    public static testmethod void Metodo16(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
  
    public static testmethod void Metodo17(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = '';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo18(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'TTTTT';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
            
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo19(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
            
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo20(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'TT';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo21(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'TTTTT';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo22(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    /*
    public static testmethod void Metodo23(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        OF_Servizio__c serv = createServizio(cat, 'Open Stream CD');
        createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    */
    
    public static testmethod void Metodo24(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo25(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'TTTTT';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo26(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '1';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = '';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo27(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '1';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo28(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo29(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '0';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = '';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo30(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '0';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = '12345';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo31(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '0';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = '';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo32(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = '12345';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = '';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = '';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    /*
    public static testmethod void Metodo33(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';  
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        OF_Servizio__c serv = createServizio(cat, 'Open Stream CD');
        createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        //co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        //co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    */
    
     public static testmethod void Metodo34(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '1';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        //co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        //co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo35(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
         
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = 'T';
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        //co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        //co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        //OF_CRMWorkAround.Esito = 0;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
     public static testmethod void Metodo36(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo37(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1234567890123456789012345678901234567890123456789012345678901234567890';
        
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        //co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        //co.APPARATO.add(OLO_APPARATO);
        
        //co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        //co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo38(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c = o.Id;
        insert c;
        
       
        
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
        
        CEIst1(c);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1234567890';
        co.CODICE_MOTIVAZIONE = '12';
        co.MOTIVAZIONE = 'T';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
         
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        //co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        //co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    

    
    /*****************START SyncChecksNotifyReschedule(method two)*******************/
    
    
     public static testmethod void MetodoTwo1(){
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = '';
         
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo2(){
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = 'T';
        r.CODICE_ORDINE_OLO = '';
         
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo3(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Cessato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo4(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Cessato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo5(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo6(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoTwo7(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo8(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoTwo9(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo10(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo11(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }

     public static testmethod void MetodoTwo12(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }

    public static testmethod void MetodoTwo13(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        r.ORARIO_APPUNTAMENTO = '10:00:00';
        r.CODICE_MOTIVAZIONE = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }

     public static testmethod void MetodoTwo14(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        r.ORARIO_APPUNTAMENTO = '10:00:00';
        r.CODICE_MOTIVAZIONE = '12345';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo15(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        r.ORARIO_APPUNTAMENTO = '10:00:00';
        r.CODICE_MOTIVAZIONE = '12';
        r.MOTIVAZIONE = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo16(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        r.ORARIO_APPUNTAMENTO = '10:00:00';
        r.CODICE_MOTIVAZIONE = '12';
        r.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoTwo17(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        r.ORARIO_APPUNTAMENTO = '10:00:00';
        r.CODICE_MOTIVAZIONE = '12';
        r.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls1());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoTwo18(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
         
         String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        r.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        r.Codice_Ordine_OF = c.id;
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890123456789012345678901234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '12345678901234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        r.ORARIO_APPUNTAMENTO = '';
        r.CODICE_MOTIVAZIONE = '12';
        r.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls1());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
        Test.stopTest(); 
    }
    
    
   /*****************START SyncChecksNotifyStatusUpdate*******************/
  
   public static testmethod void MetodoFour1(){
       
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.STATO_ORDINE = '6';
        su.CODICE_OPERATORE = '';
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour2(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.STATO_ORDINE = '6';
        su.CODICE_OPERATORE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour3(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '10';
        
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour4(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        //su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '0';
        su.CODICE_ORDINE_OLO = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
  
    public static testmethod void MetodoFour5(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        //su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '0';
       
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
  
     public static testmethod void MetodoFour6(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = ' ';
       
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour7(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
       
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour8(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour9(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
  
     public static testmethod void MetodoFour10(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
         
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour11(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'In Annullamento';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
         
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }

    public static testmethod void MetodoFour12(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
         
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour13(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
         
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour14(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }

    public static testmethod void MetodoFour15(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = 'T';
        su.MOTIVAZIONE = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour16(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12345';
        su.MOTIVAZIONE = 'T';
         
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
      public static testmethod void MetodoFour17(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour18(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour19(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }

    public static testmethod void MetodoFour20(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour21(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '7';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        
        try{
            OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        }
        catch(Exception e){}
        
        Test.stopTest(); 
    }

    public static testmethod void MetodoFour22(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
        OF_Servizio__c serv = createServizio(cat, 'GPON Passiva CD');
        createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        //su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }

    public static testmethod void MetodoFour23(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '123456789012345678901234567890';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    // to cover else part (849)
     public static testmethod void MetodoFour24(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '0';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }

    public static testmethod void MetodoFour25(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
        OF_Servizio__c serv = createServizio(cat, 'GPON Passiva CD');
        createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
     
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }    
    
    public static testmethod void MetodoFour26(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        //OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.TIPOLOGIA_APPARATO = '';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
     
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }

 public static testmethod void MetodoFour27(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        //OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.TIPOLOGIA_APPARATO = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
     
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }     
    
     public static testmethod void MetodoFour28(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.TIPOLOGIA_APPARATO = '12345678901234567890';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = '';
         
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
     
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }     
    
     public static testmethod void MetodoFour29(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.TIPOLOGIA_APPARATO = '12345678901234567890';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = '12345';
         
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
     
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }     
   
     public static testmethod void MetodoFour30(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.TIPOLOGIA_APPARATO = '12345678901234567890';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = '12345';
         
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
     
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    } 

  public static testmethod void MetodoFour31(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
        OF_Servizio__c serv = createServizio(cat, 'GPON Passiva CD');
        createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour32(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.USER_VLAN = '';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }      
    
    public static testmethod void MetodoFour33(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.USER_VLAN = '12345';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    } 
    
      public static testmethod void MetodoFour34(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = '';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour35(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = '12345';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour36(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = '';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour37(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = '12345';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
   
    public static testmethod void MetodoFour38(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '2';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour39(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
        OF_Servizio__c serv = createServizio(cat, 'GPON Passiva CD');
        createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';  
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst2(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour40(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';  
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '0';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;

        try{
            OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        }
        catch(Exception e){}
        
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour41(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '0';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        try{
            OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        }
        catch(Exception e){}
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoFour42(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '2';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour43(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '2';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = ' ';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
   
    public static testmethod void MetodoFour44(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '3';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = ' ';
        su.CODICE_MOTIVAZIONE = 'T';
        su.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour45(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '4';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        su.CODICE_MOTIVAZIONE = 'T';
        su.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
   
     public static testmethod void MetodoFour46(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '4';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '';
        su.CODICE_MOTIVAZIONE = 'T';
        su.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour47(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'In Annullamento';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '5';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '';
        su.CODICE_MOTIVAZIONE = 'T';
        su.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
   
    public static testmethod void MetodoFour48(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '7';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '';
        su.CODICE_MOTIVAZIONE = 'T';
        su.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour49(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '';
        su.CODICE_MOTIVAZIONE = 'T';
        su.MOTIVAZIONE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour50(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.Previous_Status__c = 	'Aperto';
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '0';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'TT';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour51(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
        OF_Servizio__c serv = createServizio(cat, 'GPON Passiva CD');
        createContrattoServizio(contratto, serv);
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.Id = asset_1.Id;
        insert asset_1;
     
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Aperto';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        c.AssetId = asset_1.Id;
        c.OF_Order__c = o.Id;
        insert c;
        
        CEIst2(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
     
     	OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
      
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = 'T';
        su.GPON_DI_ATTESTAZIONE = '12345';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '123456789012345678901234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '';
        su.ORARIO_APPUNTAMENTO = '';
        su.PIN_INTERVENTO_A_VUOTO = '1234567';
      
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        //OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale = c;
     
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoFour52(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        CEIst(c);
    	
    	list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
    	system.debug('DG_OF_SA_CD_OM_EntryChecks_Test - CEList: ' + CEList);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.codice_ordine_of = c.Id;
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.STATO_ORDINE = '0';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest(); 
    }
    
    /*****************START SyncChecksNotifyStatusUpdateChOrd(method third)*******************/

   public static testmethod void MetodoThree1(){
       
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_ChangeOrder_OPENSTREAM_CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
        c.PO_SA_Portale__c = true;
        //c.OF_Blocked_Case__c = true;
        insert c;
        
        //ordine
        Order o = new Order();
        o.accountId=acc.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su.STATO_ORDINE = '8';
        su.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        su.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        su.CODICE_ORDINE_OF = c.Id;
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = 'T';
        
		su.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        su.VLAN.add(OLO_VAN);
        
        su.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        su.APPARATO.add(OLO_APPARATO);
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        try{
            OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdateChOrd(su);
        }
        catch(Exception e){}
        
        Test.stopTest(); 
    }
}
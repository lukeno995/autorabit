@isTest
public class OF_SA_OM_EntryChecks_Test {
    
   /*@testSetup
    
    static void testDataSetup(){
        ServFattib__c servFattib = new ServFattib__c();
        servFattib.creaOppChildFase__c = 'Completato';
        servFattib.creaOppChildRecordTypeName__c = '\''+'PO Collegamento P2P'+'\','+'PO'+'\'';
        servFattib.creaOppParentFase__c = 'Offerta Creata';
        servFattib.creaOppParentOfferta__c = '\''+'P2P Base'+'\','+'IRU'+'\','+ 'Fiber Link' +'\','+ 'Fiber Lease' +'\','+ 'Evento Temporaneo' +'\'';
        servFattib.creaOppParentRecordTypeName__c = 'PO Richiesta a servizio a fattibilità';
        servFattib.oppChildDevNames__c = 'PO_Oppty_Evento_Temporaneo,PO_Oppty_Fiber_Lease,PO_Oppty_Fiber_Link,PO_Oppty_IRU,PO_Oppty_Misto_Lease_Link_per_FW,PO_Oppty_collegamenti';
        servFattib.oppChildDurationDays__c = 150;
        servFattib.oppChildEvtTempDevName__c = 'PO_Oppty_Evento_Temporaneo';
        servFattib.oppChildFiberLeaseDevName__c = 'PO_Oppty_Fiber_Lease';
        servFattib.oppChildFiberLeaseMistoDevName__c = 'PO_Oppty_Misto_Lease_Link_per_FW';
        servFattib.oppChildFiberLinkDevName__c = 'PO_Oppty_Fiber_Link';
        servFattib.oppChildIRUDevName__c = 'PO_Oppty_IRU';
        servFattib.oppChildName__c = 'Offerta Collegamento';
        servFattib.oppChildP2PBaseDevName__c = 'PO_Oppty_collegamenti';
        servFattib.oppChildStageName__c = 'Prospecting';
        servFattib.oppParentDevNames__c = 'PO_Oppty_Richiesta_fattibilit,PO_Oppty_Richiesta_fattibilit_Evento_Temporaneo,PO_Oppty_Richiesta_fattibilit_Fiber_Lease,PO_Oppty_Richiesta_fattibilit_Fiber_Link,PO_Oppty_Richiesta_fattibilit_IRU,PO_Oppty_Richiesta_fattibilit_Misto_Lease_Link_per_FW';
        servFattib.oppParentDurationDays__c = 150;
        servFattib.oppParentEvtTempDevName__c = 'PO_Oppty_Richiesta_fattibilit_Evento_Temporaneo';
        servFattib.oppParentFiberLeaseDevName__c = 'PO_Oppty_Richiesta_fattibilit_Fiber_Lease';
        servFattib.oppParentFiberLeaseMistoDevName__c = 'PO_Oppty_Richiesta_fattibilit_Misto_Lease_Link_per_FW';
        servFattib.oppParentFiberLinkDevName__c = 'PO_Oppty_Richiesta_fattibilit_Fiber_Link';
        servFattib.oppParentIRUDevName__c = 'PO_Oppty_Richiesta_fattibilit_IRU';
        servFattib.oppParentName__c = 'Offerta Totale';
        servFattib.oppParentP2PBaseDevName__c = 'PO_Oppty_Richiesta_fattibilit';
        servFattib.oppParentStageName__c = 'Prospecting';
        
        insert servFattib;
    }*/
    
    public static void CEIst(case c)
    { 
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_commercialElementIstanziato__c CE = new OF_commercialElementIstanziato__c();
        CE.Recordtypeid = RecordTypeMap.get('CPE');
        CE.OF_SA_CPE__c = c.id;
        CE.OF_Case__c = c.id;
        CE.OF_TipologiaApparato__C = 'T';
        insert CE;
        
        OF_commercialElementIstanziato__c CE1 = new OF_commercialElementIstanziato__c();
        CE1.Recordtypeid = RecordTypeMap.get('Servizi Aggiuntivi');
        CE1.OF_SA_Servizio_Aggiuntivo__c = c.id;
        CE1.OF_Case__c = c.id;
        CE1.OF_Nome_Servizio__C = 'T';
        insert CE1;
    }
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'OF_commercialElementIstanziato__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
        
        for(RecordType rt: rtypes)
            RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
    // base
    public static testmethod void Metodo1(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    public static testmethod void Metodo1a(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        //TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.OF_Blocked_Case__c=True;
        update TestDataFactory.c1;
        
        case cas = [select id,OF_Blocked_Case__c, EOF_Codice_Ordine_Olo__c,OF_Order__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        OF_SA_GE_Utils.caseOriginale = TestDataFactory.c1;
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    // test codice operatore & codice ordine OLO
    public static testmethod void Metodo2(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        
        co.CODICE_OPERATORE = 'TTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_OPERATORE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_OPERATORE = 'TISSSSSS';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_OPERATORE = 'VF';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_ORDINE_OLO = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_ORDINE_OLO = 'TTTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
        
    //test case non a sistema
    public static testmethod void Metodo3(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
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
        co.CODICE_ORDINE_OLO = 'T';
        co.CODICE_ORDINE_OF = 'Test';
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }

    //test codice ordine OF & data notifica
    public static testmethod void Metodo4(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        
        co.CODICE_ORDINE_OF = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_ORDINE_OF = 'TTTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_ORDINE_OF = cas.id;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00Z';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
        co.ID_NOTIFICA = '1111';
        co.STATO_ORDINE = '0';
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();  
    }
    
    //test id notifica & stato ordine
    public static testmethod void Metodo5(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id,PO_SA_Portale__c, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        
        co.ID_NOTIFICA = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.ID_NOTIFICA = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.ID_NOTIFICA = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
        co.STATO_ORDINE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.STATO_ORDINE = '000';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.STATO_ORDINE = '0';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
       
    }
    
    //test codice motivazione & motivazione
    public static testmethod void Metodo6(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
        
        co.CODICE_MOTIVAZIONE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_MOTIVAZIONE = 'TTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_MOTIVAZIONE = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
        co.MOTIVAZIONE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.MOTIVAZIONE = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
        
    }
    
    //test id risorsa
    public static testmethod void Metodo7(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        
        co.ID_RISORSA = 'TTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.ID_RISORSA = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    } 
    
    //test scala palazzina
    public static testmethod void Metodo8(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';        
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTT';    
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();       
    }

    //test data espletamento ordine vuota
    public static testmethod void Metodo9(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = 'T';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
        
    }
    
    //test stato ordine = 0 & esito servizio vuoto
    public static testmethod void Metodo10(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
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
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();  
    }
    
    //test stato ordine = 0 & esito servizio >1
    public static testmethod void Metodo11(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
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
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();  
    }
    
    //test stato ordine =0 e nome servizio vuoto (da vedere, non funziona)
    public static testmethod void Metodo12(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
                
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2017-07-14';
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //test stato ordine =0 & codice motivazione servizio & esito servizio = 1
    public static testmethod void Metodo13(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
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
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //test stato ordine =0 e codice motivazione servizio >3 & esito servizio = 1
    public static testmethod void Metodo14(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
                
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = '1';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'TTTT';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();
    }
    
    //test stato ordine =0 e codice motivazione servizio >3 & esito servizio != 1
    public static testmethod void Metodo15(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
                
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'TTTT';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();
    }
    
    //test stato ordine =0 &  motivazione servizio & esito servizio = 1
    public static testmethod void Metodo16(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
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
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //test motivazione vuoto e stato ordine =1 
    public static testmethod void Metodo17(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
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
        co.CODICE_OPERATORE = 'TIS';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = '';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
        
    //test tipologia apparato > 100 (da vedere, non funziona)
    public static testmethod void Metodo18(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //test esito consegna apparato vuoto
    public static testmethod void Metodo19(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
            
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '';
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //test esito consegna apparato > 1
    public static testmethod void Metodo20(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'TT';
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
        
    //test esito consegna apparato = 1,2,3 e id apparato consegnato vuoto
    public static testmethod void Metodo21(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '2';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = '';
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //test esito consegna apparato = 1,2,3 e id apparato consegnato > 50
    public static testmethod void Metodo22(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
    
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '2';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = '11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111';
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
        
    }

    //test esito consegna apparato != 1,2,3 e id apparato consegnato > 50
    public static testmethod void Metodo23(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '7';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = '11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111';
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
        
    }
    
    //test esito consegna apparato = 0,3,5 e codice motivazione consegna vuoto
    public static testmethod void Metodo24(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
            
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '5';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = '';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
                
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();    
    }
    
    //test esito consegna apparato = 0,3,5 e codice motivazione consegna > 3
    public static testmethod void Metodo25(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '5';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'TTTT';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
                
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();    
    }
    
    //test esito consegna apparato = 0,3,5 e motivazione consegna vuoto
    public static testmethod void Metodo26(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '5';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = '';
                
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //test esito consegna apparato != 0,3,5 e codice motivazione consegna >3
    public static testmethod void Metodo27(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_CONSEGNA_APPARATO = '7';
        OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'TTTT';
        OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
                
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    // test status != accettato
    public static testmethod void Metodo28(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];

        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
 
        
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();        
    }    
    
    // test tipologia apparato vuoto
    public static testmethod void Metodo29(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
                
        case cas = [select id, OF_Order__c,EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = '';
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();
    }    

    //test data espletamento ordine > 10
    public static testmethod void Metodo30(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        
        case cas = [select id,OF_Order__c, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = 'T';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2017-09-14T';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
        
    }

    //test apparati = null
   /* public static testmethod void Metodo31(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        case cas = [select id,OF_Order__c, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id AND recordtype.developername ='OF_SA_Attivazione'];
        
        //OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        //OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        //OLO_APPARATO.ESITO_CONSEGNA_APPARATO = 'T';
        //OLO_APPARATO.ID_APPARATO_CONSEGNATO = 'T';
        //OLO_APPARATO.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        //OLO_APPARATO.MOTIVAZIONE_CONSEGNA = 'T';
                
        //OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        //OLO_SERAGG.NOME_SERVIZIO = 'T';
        //OLO_SERAGG.ESITO_SERVIZIO = 'T';
        //OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        //OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest();
    } */   

    public static testmethod void Metodo32(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }

    public static testmethod void Metodo33(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = '';
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
        
    }    

    // test response from OM =0
    public static testmethod void Metodo34(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        
        case cas = [select id,OF_Order__c, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }

    // test response from OM =0 & stato ordine = 0
    public static testmethod void Metodo35(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }

    public static testmethod void Metodo36(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = 'Ttttt';
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
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //ID_NOTIFICA > 100
    public static testmethod void Metodo37(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        
        case cas = [select id,OF_Order__c, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
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
        co.ID_NOTIFICA = '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATO);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    //ID_RISORSA > 100
    public static testmethod void Metodo38(){
        
         Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.AccOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;

        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        
        update TestDataFactory.c1;
        
        
        case cas = [select id,OF_Order__c, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
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
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = 'T';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = '1234567890123456789012345678901234567890123456789012345678901234567890';
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
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        Test.stopTest(); 
    }
    
    /*****************START SyncChecksNotifyReschedule*******************/
    
    //base
    public static testmethod void MetodoR1(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
        
    }
    
    //test codice operatore & codice ordine olo
    public static testmethod void MetodoR2(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        NR.CODICE_OPERATORE = 'TTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = 'TISS';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = 'VF';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.CODICE_ORDINE_OLO = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_ORDINE_OLO = 'TTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest();  
    }
    
    //test data notifica e id notifica
    public static testmethod void MetodoR3(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        NR.CODICE_ORDINE_OF = cas.id;
        
        NR.DATA_NOTIFICA = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00x';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.ID_NOTIFICA = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.ID_NOTIFICA = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.ID_NOTIFICA = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
    }
    
    //test case non presente a sistema
    public static testmethod void MetodoR4(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
            
        //case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        //CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = 'TEST';
        NR.CODICE_ORDINE_OF = 'TEST';
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
    }
    
    //test nome cliente & cognome cliente
    public static testmethod void MetodoR5(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        
        NR.NOME_CLIENTE = 'TestTestTestTestTestTest';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.NOME_CLIENTE = 'Test';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.COGNOME_CLIENTE = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.COGNOME_CLIENTE = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
    }
    
    //test recapito telefonico cliente 1 & 2
    public static testmethod void MetodoR6(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTestTest';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'TestTestTestTestTestTestTest';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
    }
    
    //test data prevista attivazione & orario appuntamento
    public static testmethod void MetodoR7(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        
        NR.DATA_PREVISTA_ATTIVAZIONE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.DATA_PREVISTA_ATTIVAZIONE = '2017-09-15x';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.DATA_PREVISTA_ATTIVAZIONE = '2017-09-15';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.ORARIO_APPUNTAMENTO = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
            
    }
    
    //test codice motivazione & motivazione (controllare la webservice callout)
    public static testmethod void MetodoR8(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = '';
        NR.MOTIVAZIONE ='T';        
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
    }

    // test status != accettato
    public static testmethod void MetodoR9(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        NR.CODICE_OPERATORE = 'VF';
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest(); 
        
    }

    
    /*****************START SyncChecksNotifyStatusUpdate*******************/
    
    //base
    public static testmethod void MetodoS1(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
    //test codice operatore & codice ordine olo & codice ordine OF
    public static testmethod void MetodoS2(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        cas.Previous_Status__c = 'Test';
        update cas;
        OF_SA_GE_Utils.caseOriginale = cas;
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'TT';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = '1';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = '1';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        SU.CODICE_OPERATORE = 'TTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.CODICE_OPERATORE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.CODICE_OPERATORE = 'TISSSS';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.CODICE_OPERATORE = 'VF';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
       
        SU.CODICE_ORDINE_OLO = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.CODICE_ORDINE_OLO = 'TTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        
        SU.CODICE_ORDINE_OF = 'TTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.CODICE_ORDINE_OF = cas.id;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '0';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
    //test data notifica & id notifica
    public static testmethod void MetodoS3(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        
        SU.DATA_NOTIFICA = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00x';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        
        SU.ID_NOTIFICA = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.ID_NOTIFICA = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        SU.ID_NOTIFICA = 'T';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
       
    // test tipologia apparato vuota
    public static testmethod void MetodoS8(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = '';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest(); 
    }
    
    // test tipologia apparato > 100
    public static testmethod void MetodoS9(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest();
        
    }
    
    // test esito ritiro apparato vuoto
    public static testmethod void MetodoS10(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = '';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest(); 
    }
    
    // test esito ritiro apparato > 1
    public static testmethod void MetodoS11(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'TT';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest();
        
    }
    
    // test codice motivazione ritiro > 3
    public static testmethod void MetodoS12(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'TTTT';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest();   
    }
    
    // test user vlan vuoto
    public static testmethod void MetodoS13(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = '';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest(); 
    }
    
    // test user vlan > 4 
    public static testmethod void MetodoS14(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'TTTTT';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest(); 
    }
    
    // test service vlan vuoto
    public static testmethod void MetodoS15(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = '';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 1;
        Test.stopTest();
    }
    
    // test service vlan > 4
    public static testmethod void MetodoS16(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
            
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'TTTTT';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 0;
        Test.stopTest(); 
    }
    
    // test customer vlan vuoto
     public static testmethod void MetodoS17(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = '';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 0;
        Test.stopTest();
    }
    
    // test customer vlan > 4
    public static testmethod void MetodoS18(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'TTTTT';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 0;
        Test.stopTest(); 
    }
    
    // test case non a sistema
    public static testmethod void MetodoS19(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        //case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: c.id];
        
        /**CE istanziati**/
        //CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'TIS';
        SU.CODICE_ORDINE_OLO = 'TIS';
        SU.CODICE_ORDINE_OF = 'TIS';
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = 'T';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        OF_CRMWorkAround.Esito = 0;
        Test.stopTest(); 
    }
    
    // test status = espletato
    public static testmethod void MetodoS20(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: Testdatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = 'T';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }

    // test status = in annullamento && stato ordine = 5
    public static testmethod void MetodoS21(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TesTDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = 'T';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }

    // test status = sospeso && stato ordine != 0 && stato ordine != 2
    public static testmethod void MetodoS22(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
            
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = 'T';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }

    // test status = acquisito && stato ordine != 3 && stato ordine != 2 && stato ordine != 4
    public static testmethod void MetodoS23(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '1';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }

    // test stato ordine = 6
    public static testmethod void MetodoS24(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '6';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }

    //base
    public static testmethod void MetodoS25(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    //---------------------
    public static testmethod void MetodoS_Testmethod(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        cas.Status='Sospeso';
        update cas;
        /**CE istanziati**/
        CEIst(cas);
        //Rajani start
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        //Rajani End
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '0';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        try{
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        }Catch(exception e){}
        Test.stopTest(); 
    }
    //--------------------
    public static testmethod void MetodoS_Testmethod1(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        cas.Status='Sospeso';
        update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '0';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        try{
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        }Catch(exception e){}
                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
    }
    
    //---------------
     public static testmethod void MetodoS_Testmethod2(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        cas.Status='Sospeso';
        update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '0';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        try{
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        }Catch(exception e){}
                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
     }public static testmethod void MetodoS_Testmethod3(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        cas.Status='Sospeso';
        update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '2';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
     }
    public static testmethod void MetodoS_Testmethod4(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        cas.Status='Acquisito';
       update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '2';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
     }
    //---------------
public static testmethod void MetodoS_Testmethod5(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
          //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.Status='Acquisito';
        update TestDataFactory.c1;
        
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        //cas.Status='Acquisito';
      //update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '3';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        try{
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        }Catch(exception e){}
                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
     }
    //---------------
    public static testmethod void MetodoS_Testmethod6(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.Status='In Annullamento';
        update TestDataFactory.c1;
        
        
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        //cas.Status='In Annullamento';
     // update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '5';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        try{
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        }Catch(exception e){}
                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
     }
    //---------------
 public static testmethod void MetodoS_Testmethod7(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.Status='Inviato';
        update TestDataFactory.c1;
        
        
        
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        //cas.Status='Inviato';
     // update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '9';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
     }
 //--------------------------   
 public static testmethod void MetodoS_Testmethod8(){
           
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
       cas.status='Chiuso';
        /**CE istanziati**/
        CEIst(cas);
        update cas;
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '7';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
     Test.stopTest(); }
        public static testmethod void MetodoS_Testmethod10(){
           
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
         //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.Status='Chiuso';
        update TestDataFactory.c1;
        
        
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
      // cas.status='Chiuso';
        /**CE istanziati**/
        CEIst(cas);
       // update cas;
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '2';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        try{
            OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(null);
        }catch(Exception e){
            System.debug('Exception ->'+e.getMessage());
        }
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotify2('SG','T');
     Test.stopTest(); }
    
    //---------------------
    public static testmethod void MetodoS_Testmethod11(){
    }
    
    public static testmethod void testMethod_yogesh(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.Status='Inviato';
        update TestDataFactory.c1;
        
        
        
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        //cas.Status='Inviato';
     // update cas;
        /**CE istanziati**/

        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '6';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO OLO_APPARATOTest = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        OLO_APPARATOTest.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATOTest.ESITO_CONSEGNA_APPARATO = 'T';
        OLO_APPARATOTest.ID_APPARATO_CONSEGNATO = 'T';
        OLO_APPARATOTest.CODICE_MOTIVAZIONE_CONSEGNA = 'T';
        OLO_APPARATOTest.MOTIVAZIONE_CONSEGNA = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.ESITO_SERVIZIO = 'T';
        OLO_SERAGG.CODICE_MOTIVAZIONE_SERVIZIO = 'T';
        OLO_SERAGG.MOTIVAZIONE_SERVIZIO = 'T';
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        co.CODICE_OPERATORE = '';
        co.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        co.CODICE_ORDINE_OF = cas.id;
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = 'T';
        co.STATO_ORDINE = '6';
        co.CODICE_MOTIVAZIONE = 'Ttttt';
        co.MOTIVAZIONE = 'T';
        co.ID_RISORSA = 'T';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.SCALA_PALAZZINA = 'T';
        co.DDT = 'T';
        co.NOTE = 'T';
        
        co.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        co.APPARATO.add(OLO_APPARATOTest);
        
        co.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        co.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        co.STATO_ORDINE = '8';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        co.STATO_ORDINE = '6';
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        //OF_SA_OM_EntryChecks.SyncChecksNotify2('SG','T');
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_OPERATORE = 'VFTest';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.CODICE_OPERATORE = 'VF';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
        co.DATA_NOTIFICA ='';
        OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);

                // OF_SA_OM_EntryChecks.SyncChecksNotifycheck('SG','T');

        Test.stopTest(); 
     }
     
     
     public static testmethod void MetodoS_Testmethod100(){
       Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        
          //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.Status='Acquisito';
        update TestDataFactory.c1;
        
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        //cas.Status='Acquisito';
      //update cas;
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '3';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        OF_CRMWorkAround.Esito = 0;
        //OF_SA_OM_EntryChecks.SyncChecksNotify('SG','T');
        //OF_SA_OM_EntryChecks.SyncChecksNotifyer('SG','T');
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        
        Test.stopTest(); 
     }
    
    public static testmethod void MetodoSA(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
      public static testmethod void MetodoSB(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = '';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoSC(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoSD(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = '';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoSE(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = '';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoSF(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = '1234567890';
        SU.MOTIVAZIONE = 'T';
        
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoSG(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = '12345678901234567890';
        
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
     public static testmethod void MetodoSH(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = '123456789012345678901234567890';
        
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
      public static testmethod void MetodoSI(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoSJ(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.PIN_INTERVENTO_A_VUOTO = 'T';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = '1234567890';
        SU.RECAPITO_TELEFONICO_CLIENTE = '1234567890123456789012345678901234567890';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
    
    public static testmethod void MetodoSK(){
        
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
                
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDatafactory.c1.id];
        
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_StatusUpdate.VLAN OLO_VAN = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.ESITO_RITIRO_APPARATO = 'T';
        OLO_APPARATO.CODICE_MOTIVAZIONE_RITIRO = 'T';
        OLO_APPARATO.MOTIVAZIONE_RITIRO = 'T';
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate SU = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        SU.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        SU.CODICE_ORDINE_OF = cas.id;
        SU.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        SU.ORARIO_APPUNTAMENTO = '10:00:00';
        SU.NOTE = 'T';
        
        SU.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        SU.ID_NOTIFICA = 'T';
        SU.STATO_ORDINE = '4';
        SU.CODICE_MOTIVAZIONE = 'T';
        SU.MOTIVAZIONE = 'T';
        SU.GPON_DI_ATTESTAZIONE = 'T';
        SU.NOME_CLIENTE = 'T';
        SU.COGNOME_CLIENTE = 'T';
        SU.RECAPITO_TELEFONICO_CLIENTE = 'T';
        SU.PIN_INTERVENTO_A_VUOTO = '12345678901234567890';
        
        SU.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        SU.VLAN.add(OLO_VAN);
        
        SU.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        SU.APPARATO.add(OLO_APPARATO);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_OM_EntryChecks.SyncChecksNotifyStatusUpdate(SU);
        Test.stopTest(); 
    }
 
    public static testmethod void MetodoR2_new(){
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        //TestDataFactory.c1.EOF_Order_Manager__c = true;
        TestDataFactory.c1.OF_Blocked_Case__c=True;
        update TestDataFactory.c1;
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c,OF_Blocked_Case__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        NR.CODICE_OPERATORE = 'TTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = 'TISS';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = 'VF';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.CODICE_ORDINE_OLO = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_ORDINE_OLO = 'TTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
        OF_SA_GE_Utils.caseOriginale = TestDataFactory.c1;  
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest();  
    }
    public static testmethod void MetodoR2_new1(){
        
		Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null,null);
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();
        
        //ordine
        Order o = new Order();
        o.accountId=TestDataFactory.accOLO.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        TestDataFactory.c1.OF_Order__c=o.Id;
        //TestDataFactory.c1.EOF_Order_Manager__c = true;
        //TestDataFactory.c1.OF_Blocked_Case__c=True;
        TestDataFactory.c1.Status='Cessato';
        update TestDataFactory.c1;
        
        case cas = [select id, EOF_Codice_Ordine_Olo__c, EOF_Account_OLO__c, status, Codice_Ordine_Eof__c from case where id =: TestDataFactory.c1.id];
        /**CE istanziati**/
        CEIst(cas);
        
        list<OF_commercialElementIstanziato__c> CEList = [select id, OF_SA_CPE__c,OF_SA_Servizio_Aggiuntivo__c, OF_Case__c, recordtypeid, OF_Nome_Servizio__C, OF_TipologiaApparato__C from OF_commercialElementIstanziato__c];
        system.debug('DG_OF_SA_OM_EntryChecks_Test - CEList: ' + CEList);
        /**End CE istanziati**/
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule NR = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        NR.CODICE_OPERATORE = 'TTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = 'TISS';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_OPERATORE = 'VF';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.CODICE_ORDINE_OLO = '';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_ORDINE_OLO = 'TTTTTTTTTTTTTTTTTTT';
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        NR.CODICE_ORDINE_OLO = cas.EOF_Codice_Ordine_Olo__c;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        
        NR.CODICE_ORDINE_OF = cas.id;
        NR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        NR.ID_NOTIFICA = 'T';
        NR.NOME_CLIENTE = 'T';
        NR.COGNOME_CLIENTE = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_1 = 'T';
        NR.RECAPITO_TELEFONICO_CLIENTE_2 = 'T';
        NR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        NR.ORARIO_APPUNTAMENTO = '10:00:00';
        NR.CODICE_MOTIVAZIONE = 'T';
        NR.MOTIVAZIONE = 'T';
        NR.NOTE = 'T';
        OF_SA_GE_Utils.caseOriginale = TestDataFactory.c1;  
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 0;
        OF_SA_OM_EntryChecks.SyncChecksNotifyReschedule(NR);
        Test.stopTest();  
    }
  }
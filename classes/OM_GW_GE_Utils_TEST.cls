@isTest
private class OM_GW_GE_Utils_TEST {
    
    public static testMethod void testCreate_Log_Acquisizione_Cessazione() {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account acc = new Account();
		acc.Name = 'Tiscali';
		acc.Type = 'OLO';
		acc.EOF_Codice_Operatore__c = 'TIS';
		acc.RecordTYpeId = AccountRecordTypeId;
		insert acc;
		
        Case c = new Case();
        c.AccountId = acc.Id;   
        c.RecordTypeId = [Select id from RecordType where developerName='EOF_Caso_Attivazione'].id;
        insert c;
        test.startTest();
        //OM_GW_GE_Utils.acd('a');
        
        if(!OM_GW_GE_Utils.checkRTMap){
                //vado a creare la mappa dei recordtype per poi utilizzarla
                OM_GW_GE_Utils.RTMap = new  map<String,String>();
                for(recordtype rt : [select id,developername from recordtype]){
                    OM_GW_GE_Utils.RTMap.put(rt.developername,rt.id);
                }
                OM_GW_GE_Utils.checkRTMap=true;
            } 
        
        
         OM_GW_GE_Utils.create_Log_Acquisizione_Cessazione_To_OLO(c,'OK');
         OM_GW_GE_Utils.create_Log_Acquisizione_Cessazione_To_OLO(c,'KO');
        
        EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
        log.EOF_Data_Notifica__c = System.now();
        
        OM_GW_GE_Utils.copy_notify_AcqCess(log);
        
        OM_GW_GE_Utils.checkDate(null);
        OM_GW_GE_Utils.checkDate('abc');
        OM_GW_GE_Utils.checkDate('2015-3-2');
        OM_GW_GE_Utils.checkDate('2015-03-02');
        
        OM_GW_GE_Utils.checkDateTime(null);
        OM_GW_GE_Utils.checkDateTime('0123456789');
        OM_GW_GE_Utils.checkDateTime('2015-3-2');
        OM_GW_GE_Utils.checkDateTime('2015-03-02');
        OM_GW_GE_Utils.checkDateTime('2015-03-02T22:02:1a');
        OM_GW_GE_Utils.checkDateTime('2015-03-02T22:02:15');
        OM_GW_GE_Utils.checkDateTime('2015-03-02X22:02:15+01:00');
        OM_GW_GE_Utils.checkDateTime('2015-03-02X22:02:15+03:00');
        
        OM_GW_GE_Utils.simulateNACK('OLO');
        OM_GW_GE_Utils.simulateNACK('OM');
        
        OM_GW_GE_Utils.checkTime(null);
        OM_GW_GE_Utils.checkTime('abc');
        OM_GW_GE_Utils.checkTime('2015:20:20');
        OM_GW_GE_Utils.checkTime('35:03:02');
        
        try {
            OM_GW_GE_Utils.aggiornamentoDatiAcquisizione('Attivazione', '', '');
        } catch (Exception e) {}
        try {
            OM_GW_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Create', '11', '');
        } catch (Exception e) {}
        
        try {
            OM_GW_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Delete', '11', '');
        } catch (Exception e) {}
        
        try {
            OM_GW_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Delete', '98', '');
        } catch (Exception e) {}
        
        test.stopTest();
    }
    
    static testMethod void syncErrorNotify_TEST1() {
         
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
       
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'Test';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        
        OM_GW_WS_Notify.returnNotifyResponse rnr = new  OM_GW_WS_Notify.returnNotifyResponse();
        OM_GW_WS_Notify.FiberNotify fn = new OM_GW_WS_Notify.FiberNotify();

        test.startTest();
        
        rnr=OM_GW_GE_Utils.syncerrorNotify(fn,'A_K5', 'Cognome');
        OM_GW_GE_Utils.create_notify(fn, TestDataFactory.c.Id, 'WN');
        EOF_EAI_Service_Log__c sl = OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
            'Codice_errore' => 'A_K7',
            'Causale_errore' => 'COgnome',
            'Codice_operatore' => 'WN',
            'Codice_ordine_OLO' => 'WN_0000001',
            'ID_notifica' => 'abcdefghi',
            'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(frequest),
            'Tipo Comunicazione' => 'OLO->SF - NACK - FiberRequest - '+ OM_GW_GE_Utils.retCodOp(frequest)});
        
        OM_GW_GE_Utils.create_EAI_Log(TestDataFactory.objeof);
        OM_GW_GE_Utils.create_EAI_Log(TestDataFactory.c); 
        OM_GW_GE_Utils.create_EAI_Log(fn, TestDataFactory.c.Id, 'WN'); 
        OM_GW_GE_Utils.create_EAI_Log(frequest, TestDataFactory.c.Id, 'WN');
        OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.DateToString(datetime.now());
        OM_GW_GE_Utils.DateToStringNoTime(date.today());
		OM_GW_GE_Utils.syncError(frequest, 'A_K5','Cognome');
        
        for(integer i=0; i<100; i++){
            String f=string.valueOf(i);
            OM_GW_GE_Utils.retCodOp(f);
        }
        fn.codice_operatore='wind';
        OM_GW_GE_Utils.retCodOp(fn);
        
        OM_GW_GE_Utils.retNotRecType(fn);
        OM_GW_GE_Utils.checkDate('2017-11-16');
        OM_GW_GE_Utils.checkTime('10:30:00');
        OM_GW_GE_Utils.checkEmail('test@test.it');
        OM_GW_GE_Utils.checkDateTime('2017-11-16T10:00:00+01:00');
        OM_GW_GE_Utils.checkAmministratori(TestDataFactory.c);
        //OM_GW_GE_Utils.aggiornamentoDatiAcquisizione('Attivazione','test','ok');
        //OM_GW_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Create', '2', 'ok');
        test.stopTest();
        
    }
    
    static testMethod void syncErrorNotify_TEST2() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'Test';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        
        OM_GW_WS_Notify.returnNotifyResponse rnr = new  OM_GW_WS_Notify.returnNotifyResponse();
        OM_GW_WS_Notify.FiberNotify fn = new OM_GW_WS_Notify.FiberNotify();
        test.startTest();
        
        rnr=OM_GW_GE_Utils.syncerrorNotify(fn,'A_K5', 'Cognome');
        OM_GW_GE_Utils.create_notify(fn, TestDataFactory.c.Id, 'WN');
        EOF_EAI_Service_Log__c sl = OM_GW_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
            'Codice_errore' => 'A_K7',
            'Causale_errore' => 'COgnome',
            'Codice_operatore' => 'WN',
            'Codice_ordine_OLO' => 'WN_0000001',
            'ID_notifica' => 'abcdefghi',
            'Richiesta Notifica' => OM_GW_GE_Utils.Copy_request(frequest),
            'Tipo Comunicazione' => 'OLO->SF - NACK - FiberRequest - '+ OM_GW_GE_Utils.retCodOp(frequest)});
        
        OM_GW_GE_Utils.create_EAI_Log(TestDataFactory.objeof3);
        OM_GW_GE_Utils.create_EAI_Log(TestDataFactory.c); 
        OM_GW_GE_Utils.create_EAI_Log(fn, TestDataFactory.c.Id, 'WN'); 
        OM_GW_GE_Utils.create_EAI_Log(frequest, TestDataFactory.c.Id, 'WN');  
        OM_GW_GE_Utils.DateToString(datetime.now());
        OM_GW_GE_Utils.DateToStringNoTime(date.today());
        OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.syncError(frequest, 'A_K6','Cognome');
        
        
        for(integer i=0; i<100; i++){
            String f=string.valueOf(i);
            OM_GW_GE_Utils.retCodOp(f);
        }
        fn.codice_operatore='wind';
        OM_GW_GE_Utils.retCodOp(fn);
        
        for(integer i=0; i<100;i++){
            string s = string.valueof(i);
            OM_GW_GE_Utils.retSpec(s);
        }
        OM_GW_GE_Utils.retSpec(fn);
        
        map<String,String> testmap = new map<String,String>();
		testmap.put('test','ACK');
        
        OM_GW_GE_Utils.createACK(testmap);
        OM_GW_GE_Utils.create_Log_Attivazione_cessazione_To_OM(TestDataFactory.ESlog[0],TestDataFactory.c,'1','1');

        test.stopTest();
        
    }
    
    //giovanni ernetti 17-10-2018 INIZIO
    public static testmethod void controlloVendibilita_Test()
    {
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;         
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.controlloVendibilita('VF','123');
        test.stopTest();
    }
    //giovanni ernetti 17-10-2018 FINE
}
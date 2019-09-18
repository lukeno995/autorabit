@isTest

public class EOF_GW_Utils_TEST{ 
    
    //-------------- Tipo Comm Equals 2---------------
    
 /*   public static testmethod void EOFGWUtil_TestTipoCommEquals2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
 
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest(); 
        
    }*/
    
    //-------------- Tipo Comm Equals 3---------------
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest(); 
        
    }
    
    //-------------- Tipo Comm Equals 1---------------
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'popbu';
        
        insert nwtworkInv;   
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'test';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Test';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'cc2';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = 'testbuilding';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Luigi';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.APPARATO = 'Y';
        frequest.TIPOLOGIA_APPARATO = '1';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1001';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';    
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abcd@email.it';    
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        
        insert contactPerson;
        
        //------Contact ends------
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abcd@email.it';
        frequest.ID_BUILDING = 'testbuilding';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        
        insert contactPerson;
        
        //------Contact ends------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(system.today().addMonths(2));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abcd@email.it';
        frequest.ID_BUILDING = 'testbuilding';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        
        insert contactPerson;
        
        //------Contact ends------
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest(); 
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case4(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abcd@test.it';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        
        insert contactPerson;
        
        //------Contact ends------
        
        //  ---insert additional account -----
        
        Account accAdd = new Account();
        accAdd.Name = 'res';
        accAdd.Phone = 'cc1';
        
        insert accAdd;
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case5(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abcd@test.it';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        
        insert contactPerson;
        
        //------Contact ends------
        
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case6(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = '';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        
        insert contactPerson;
        
        //------Contact ends------
        
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case7(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        // EOF_GW_Utils.add_result_message(c,'msg');
        Test.stopTest(); 
        
    }

    
    public static testmethod void EOFGWUtil_TestTipoComm1Case8(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = null;
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        // EOF_GW_Utils.add_result_message(c,'msg');
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case9(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv; 
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_0901';
        frequest.GPON_ATTESTAZIONE = 'test';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Ortega';
        frequest.COGNOME_CLIENTE = 'res';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = 'ab_01';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Lucio';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'a@b.com';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(Date.newInstance(2018, 1, 10));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.APPARATO = 'Y';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';    
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abcd@a.it';
        frequest.ID_BUILDING = 'testbuilding';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1001';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        
        insert contactPerson;
        
        //------Contact ends------      
        
        
        Test.startTest(); 
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);    
        Test.stopTest(); 
        
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case10(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = null;
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);  
        Test.stopTest(); 
    }
    
    public static testmethod void EOFGWUtil_TestTipoComm1Case11(){  
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
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
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'prova';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = 'prova';
        frequest.DATA_NOTIFICA = null;
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        //-----insert contact------
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'test';
        contactPerson.LastName = 'abcd';
        contactPerson.Phone = 'abcd';
        contactPerson.Email = 'test@xyz.com';
        contactPerson.AccountID = accOLO.Id;
        
        insert contactPerson;
        
        //------Contact ends------
        
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = 'prova';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = '';
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(c); 
        
        frequest.IDENTIFICATIVO_DEL_POP = 'test_01';
        frequest.GPON_ATTESTAZIONE = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(c);
		
        Test.stopTest(); 
    }
    
    
    //-------------- Tipo Comm Equals 11---------------
    public static testmethod void EOFGWUtil_TestTipoCommEquals11(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abcd@test.it';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest(); 
        
    }
    
    // test_method_1 --> test tipo comunicazione = 1
    public static testmethod void test_method_1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    // test_method_2 --> test tipo comunicazione = 2
    public static testmethod void test_method_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v01(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }    
    
    public static testmethod void test_method_2v02(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v03(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v04(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v05(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'RossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v06(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345123456789012345678901234567890';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v07(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'MarioMarioMarioMarioMarioMario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v08(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234512345678901234567890123456789';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v09(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v10(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.COGNOME_REFERENTE_TECNICO_OLO ='TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v11(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO ='123456789012345678901234567890';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v12(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.RECAPITO_TEST_LINEA ='23456789123456789123456789';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v13(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        frequest.OPZIONE_SYSTEM_UNICO ='T';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_2v14(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA ='12345678912345678912345678';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    
    // test_method_3 --> test tipo comunicazione = 3
    public static testmethod void test_method_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v01(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v02(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v03(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v04(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = '';
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v05(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'RossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v06(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123451234567891234567891234567890';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v07(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'MarioMarioMarioMarioMarioMario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v08(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345123456789123456789123456789';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFActory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v09(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v10(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.COGNOME_REFERENTE_TECNICO_OLO ='TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v11(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO ='123456789123456789123456789123456789';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v12(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        frequest.RECAPITO_TEST_LINEA ='12345678123456789123456789';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v13(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        frequest.OPZIONE_SYSTEM_UNICO='N';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    public static testmethod void test_method_3v14(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di sospensione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_02';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA ='123456789123456781234567812345678';
        
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c4, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c4);
        
        Test.stopTest(); 
        
    }
    
    
    // test_method_4 --> test tipo comunicazione = 4
    public static testmethod void test_method_4(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);  
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v01(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);  
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v02(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = '';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'tt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);  
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v03(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'tt';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);  
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v04(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);  
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v05(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);  
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v06(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'RossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossiRossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v07(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'tttttttttttttttttttttt';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TesTDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v08(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'ttytttttttttttttttttttttttttttttttt';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v09(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc11111111111111111111111111111111111111111111';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v10(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt111111111111111111111111111111111111111111111111111';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v11(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'testttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v12(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcdasdfghjasdfghjkasdfghjkabcdasdfghjasdfghjkasdfghjkabcdasdfghjasdfghjkasdfghjk';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
    OM_GW_GE_Utils.checkslOrig=true;

    test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v13(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678123456789123456789';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    public static testmethod void test_method_4v14(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = '2017-09-27';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = '';
        frequest.NOME_CLIENTE = 'tty';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'cc1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'tt';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'ttt';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 't';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '16:00:00';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'abcd';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'test@xyz.com';
        frequest.RECAPITO_TEST_LINEA ='1234567890123456789123456789';
        
        //---------insert network inventory------
        
        EOF_Network_Inventory__c nwtworkInv = new EOF_Network_Inventory__c();
        nwtworkInv.EOF_ID_Building__c = 'testbuilding';
        nwtworkInv.EOF_Stato_Building__c = 110;
        nwtworkInv.EOF_Pop__c = 'PG_0901';
        
        insert nwtworkInv;   
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');  
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }
    
    
    // test_method_5 --> test tipo comunicazione = 11
    public static testmethod void test_method_5(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.ORARIO_APPUNTAMENTO = '12:00:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K16','x' );
        EOF_GW_Utils.create_Notify(TestDataFactory.c, 6, 'KO' , 'B_K17','x' );
        EOF_GW_Utils.checkSync(frequest);
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        Test.stopTest(); 
        
    }
    
    
    //----- Metodi della EOF_GW_Utils_TEST1 ----- //
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals2_1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'test';
        frequest.GPON_VINCOLANTE = 'test';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'Mario';
        frequest.COGNOME_CLIENTE = 'Rossi';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'ad';
        frequest.APPARATO = 'y';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '11:30:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest(); 
    }
    
    //-------Tipo Comm equals 2----
   /* public static testmethod void EOFGWUtil_TestTipoCommEquals2Extended(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '11:30:00';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        frequest.ID_NOTIFICA = 'test_01';
        frequest.CODICE_OPERATORE = 'OT';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_CLIENTE = 'abc';
        frequest.DATA_PREVISTA_ATTIVAZIONE = null;
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_NOTIFICA = null;
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.ORARIO_APPUNTAMENTO = 'test';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest(); 
    }
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals2Extended2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        frequest.ID_NOTIFICA = '';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.ID_NOTIFICA = 'test_01';
        frequest.CODICE_OPERATORE = 'OT';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_CLIENTE = 'abc';
        frequest.DATA_PREVISTA_ATTIVAZIONE = null;
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_NOTIFICA = null;
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.ORARIO_APPUNTAMENTO = 'test';
        //EOF_GW_Utils.checkSync(frequest); 
        
        frequest.ORARIO_APPUNTAMENTO = '';
        EOF_GW_Utils.checkSync(frequest); 
        frequest.TIPO_COMUNICAZIONE = '3';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE = 'abc';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.DATA_NOTIFICA = null;
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        Test.stopTest();  
    }
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals2Extended2_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        frequest.ID_NOTIFICA = '';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.ID_NOTIFICA = 'test_01';
        frequest.CODICE_OPERATORE = 'OT';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_CLIENTE = 'abc';
        frequest.DATA_PREVISTA_ATTIVAZIONE = null;
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_NOTIFICA = null;
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.ORARIO_APPUNTAMENTO = 'test';
        //EOF_GW_Utils.checkSync(frequest); 
        
        frequest.ORARIO_APPUNTAMENTO = '';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.TIPO_COMUNICAZIONE = '3';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE = '';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE = 'abc';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.DATA_NOTIFICA = null;
        //EOF_GW_Utils.checkSync(frequest); 
        
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ORARIO_APPUNTAMENTO = 'test:12';
        EOF_GW_Utils.checkSync(frequest); 
        frequest.TIPO_COMUNICAZIONE = '4'; 
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        //------Tipo Comm = 1---
        frequest.TIPO_COMUNICAZIONE = '1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.DATA_PREVISTA_ATTIVAZIONE = null;
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest); 
        
        Test.stopTest(); 
    }*/
    
    //-----testing --------  
    public static testmethod void EOFGWUtil_TestTipoCommEquals1_1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        //frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest; 
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        frequest.ID_NOTIFICA = 'test_01';
        frequest.CODICE_OPERATORE = 'VF';
        EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.COGNOME_CLIENTE = 'test_01';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }  
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11_1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest; 
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.CODICE_OPERATORE = 'VF';
        EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        //EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.COGNOME_CLIENTE = 'test_01';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        //EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.DATA_NOTIFICA = null;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.IDENTIFICATIVO_DEL_POP = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }  
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest; 
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.CODICE_OPERATORE = 'VF';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        //EOF_GW_Utils.checkAsync(c);
        frequest.COGNOME_CLIENTE = 'test_01';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.DATA_NOTIFICA = null;
        //EOF_GW_Utils.checkAsync(c);
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.IDENTIFICATIVO_DEL_POP = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.IDENTIFICATIVO_DEL_POP = 'test';
        frequest.PROVINCIA = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        
        frequest.PROVINCIA = 'test';
        frequest.COMUNE = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.COMUNE = 'test';
        frequest.INDIRIZZO = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }  
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest;  
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.ID_NOTIFICA = 'test_01';
        frequest.CODICE_OPERATORE = 'VF';
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        //EOF_GW_Utils.checkAsync(c);
        frequest.COGNOME_CLIENTE = 'test_01';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.DATA_NOTIFICA = null;
        //EOF_GW_Utils.checkAsync(c);
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.IDENTIFICATIVO_DEL_POP = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.IDENTIFICATIVO_DEL_POP = 'test';
        frequest.PROVINCIA = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.PROVINCIA = 'test';
        frequest.COMUNE = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.COMUNE = 'test';
        frequest.INDIRIZZO = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.NUMERO_CIVICO = '6';
        frequest.PARTICELLA_TOPONOMASTICA = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest(); 
    }  
    
    //------Tipo Comm equals 11-----
    
    //-----testing --------  
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'TestAccount';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest; 
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.ID_BUILDING = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest();
    } 
    
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'TestAccount';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest; 
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.ID_BUILDING = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.GPON_ATTESTAZIONE = 'test';
        frequest.GPON_VINCOLANTE = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.COLLEGAMENTO_P2P = '0';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.COLLEGAMENTO_P2P = '';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = 'Z';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest();
    } 
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = '';
        frequest.COGNOME_CLIENTE = 'TestAccount';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest; 
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.ID_BUILDING = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.GPON_ATTESTAZIONE = 'test';
        frequest.GPON_VINCOLANTE = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.COLLEGAMENTO_P2P = '0';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.COLLEGAMENTO_P2P = '';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = 'Z';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = 'F';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.APPARATO = '';
        frequest.GPON_VINCOLANTE = 'Z';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.GPON_VINCOLANTE = '';
        frequest.OPZIONE_SYSTEM_UNICO = 'V';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.TIPOLOGIA_SERVIZIO = 'OT';
        frequest.ORARIO_APPUNTAMENTO = '12:34';
        
        Test.stopTest();
    } 
    //-----testing --------  
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '11';
        EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.ORARIO_APPUNTAMENTO = system.today()+'';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest();
    } 
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended2_1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '11';
        EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        //EOF_GW_Utils.checkAsync(c);
        frequest.ORARIO_APPUNTAMENTO = system.today()+'';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.ORARIO_APPUNTAMENTO = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_40';
        update netwrkInv;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        netwrkInv.EOF_Stato_Building__c = 110;
        update netwrkInv;
        EOF_GW_Utils.checkAsync(TestDataFactory.c); 
        
        Test.stopTest();
    }
    
    //-----Case Type = 11-------------- 
    public static testmethod void EOFGWUtil_TestCTypeEquals11(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '11';
        EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA =  null;
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_RISORSA = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.ID_RISORSA = 'risorsa';
        frequest.APPARATO = 'Y';
        frequest.COGNOME_CLIENTE = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        Test.stopTest();
    } 
    
    public static testmethod void EOFGWUtil_TestCTypeEquals11_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '11';
        EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA =  null;
        //EOF_GW_Utils.checkAsync(c);
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_RISORSA = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.ID_RISORSA = 'risorsa';
        frequest.APPARATO = 'Y';
        frequest.COGNOME_CLIENTE = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.COGNOME_CLIENTE = 'testacc';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.APPARATO = 'K';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        frequest.APPARATO = '';
        //EOF_GW_Utils.checkAsync(c);
        //EOF_GW_Utils.checkAsync(c);
        //EOF_GW_Utils.add_result_message(c,'Test');
        
        Test.stopTest();
    }  
    
    public static testmethod void EOFGWUtil_TestCTypeEquals11_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.fr_tmp=frequest; 
        frequest.TIPO_COMUNICAZIONE = '11';
        //EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        frequest.DATA_NOTIFICA =  null;
        //EOF_GW_Utils.checkAsync(c);
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_RISORSA = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.ID_RISORSA = 'risorsa';
        frequest.APPARATO = 'Y';
        frequest.COGNOME_CLIENTE = '';
        //EOF_GW_Utils.checkAsync(c);
        
        frequest.COGNOME_CLIENTE = 'testacc';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        //EOF_GW_Utils.checkAsync(c);
        frequest.APPARATO = 'K';
        //EOF_GW_Utils.checkAsync(c);
        frequest.APPARATO = '';
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        EOF_GW_Utils.checkAsync(TestDataFactory.c);
        EOF_GW_Utils.add_result_message(TestDataFactory.c,'Test');
        
        Test.stopTest();
    }
    //-----------Create Notify Test----------
    
    public static testmethod void EOFGWUtil_TestCreateNotify(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        frequest.TIPO_COMUNICAZIONE = '11';
        EOF_GW_Utils.checkSync(frequest);  
        // frequest.CODICE_ORDINE_OLO = '02112016_38';
        EOF_GW_Utils.create_notify(TestDataFactory.c,5,'OK','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,5,'KO','B_K6','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,5,'KO','A_K14','sampleName');
        
        Test.stopTest();
    }  
    
    public static testmethod void EOFGWUtil_TestCreateNotify_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '11';
        EOF_GW_Utils.checkSync(frequest);  
        EOF_GW_Utils.create_notify(TestDataFactory.c,6,'OK','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,6,'KO','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,7,'OK','','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,7,'KO','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,9,'OK','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,12,'OK','','');
        
        Test.stopTest();
    }
    
  /*  public static testmethod void EOFGWUtil_TestCreateNotify1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '12345678912345678912345456';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        Test.stopTest();
    } */ 
    
    public static testmethod void EOFGWUtil_TestCreateNotify1_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');        
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_notify(TestDataFactory.c,5,'OK','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,5,'KO','B_K6','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,5,'KO','A_K14','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,6,'OK','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,6,'KO','A_K1','sampleName');
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify1_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');        
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.create_notify(TestDataFactory.c,7,'OK','','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,7,'KO','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,9,'OK','A_K1','sampleName');
        EOF_GW_Utils.create_notify(TestDataFactory.c,12,'OK','','');
        
        Test.stopTest();
    }
    
   /* public static testmethod void EOFGWUtil_TestCreateNotify2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.NOME_REFERENTE_TECNICO_OLO = '12';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify2_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.NOME_REFERENTE_TECNICO_OLO = '12';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        
        
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234567812345678912345678456789';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        frequest.OPZIONE_SYSTEM_UNICO = 'S';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        frequest.OPZIONE_SYSTEM_UNICO = 'Y';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify2_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest', null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.NOME_REFERENTE_TECNICO_OLO = '12';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        
        
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234567812345678912345678456789';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        frequest.OPZIONE_SYSTEM_UNICO = 'S';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        frequest.OPZIONE_SYSTEM_UNICO = 'Y';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
        //EOF_GW_Utils.checkSync(frequest);
        
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '12345678912345678912345456';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest', null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.NOME_REFERENTE_TECNICO_OLO = '12';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify3_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest', null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.NOME_REFERENTE_TECNICO_OLO = '12';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234567812345678912345678456789';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        frequest.OPZIONE_SYSTEM_UNICO = 'S';
        EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        frequest.OPZIONE_SYSTEM_UNICO = 'Y';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify3_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest', null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        //EOF_GW_Utils.checkSync(frequest); 
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '123456789';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.NOME_REFERENTE_TECNICO_OLO = '12';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234567812345678912345678456789';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        frequest.OPZIONE_SYSTEM_UNICO = 'S';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
        frequest.RECAPITO_TEST_LINEA= '1234567891234';
        frequest.OPZIONE_SYSTEM_UNICO = 'Y';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
        //EOF_GW_Utils.checkSync(frequest);
        
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        
        Test.stopTest();
    }*/
    
    public static testmethod void EOFGWUtil_TestCreateNotify4(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
/*        
        frequest.TIPO_COMUNICAZIONE = '3';
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
        frequest.RECAPITO_TEST_LINEA = '123456781234567834343434';
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
        frequest.RECAPITO_TEST_LINEA = '123456781';
        frequest.OPZIONE_SYSTEM_UNICO = 'S';
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
        frequest.RECAPITO_TEST_LINEA = '123456781';
        frequest.OPZIONE_SYSTEM_UNICO = 'Y';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '123456789123456789125123456789123456789125';*/
        EOF_GW_Utils.checkSync(frequest);
        Test.stopTest();
    }
    
   /* public static testmethod void EOFGWUtil_TestCreateNotify5(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '12345678912345678912345456';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify5_2(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        //frequest.TIPO_COMUNICAZIONE = '4';
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '12345678912345678912345456';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
        //EOF_GW_Utils.checkSync(frequest);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
        frequest.RECAPITO_TEST_LINEA = '123456781234567834343434';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify5_3(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = 'Y';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '0000';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'test';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.COGNOME_CLIENTE='';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.SCALA_PALAZZINA = 'test';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.TIPOLOGIA_APPARATO = '';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '';
        frequest.SLA_PREMIUM_ASSURANCE = '';
        frequest.APPARATO = '';
        frequest.OPZIONE_SYSTEM_UNICO = '';
        frequest.ORARIO_APPUNTAMENTO = null;
        frequest.COLLEGAMENTO_P2P = '';
        
        // --- Network inventory----
        EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
        netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
        netwrkInv.EOF_Stato_Building__c = 120;
        netwrkInv.EOF_Pop__c  = 'PG_01';
        insert netwrkInv;
        
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        //frequest.TIPO_COMUNICAZIONE = '4';
        frequest.COGNOME_CLIENTE='testing'; 
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
        frequest.NOME_CLIENTE = '12345678912345678912345456';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
        //EOF_GW_Utils.checkSync(frequest);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
        //EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
        frequest.RECAPITO_TEST_LINEA = '123456781234567834343434';
        //EOF_GW_Utils.checkSync(frequest);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
        frequest.RECAPITO_TEST_LINEA = '123456781';
        frequest.OPZIONE_SYSTEM_UNICO = 'S';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
        frequest.NOME_CLIENTE = '123456';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
        frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
        frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
        frequest.RECAPITO_TEST_LINEA = '123456781';
        frequest.OPZIONE_SYSTEM_UNICO = 'Y';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '123456789123456789125123456789123456789125';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        frequest.COGNOME_CLIENTE = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        Test.stopTest();
    }*/
    
    // ----- Metodi della EOF_GW_Utils_TEST3 ----- //

    static testmethod void EOF_GW_Utils_testmethod_1(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        // create group
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        // end create group
        
        // network inventory creation
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        //end network inventory creation 
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             

        EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
    }
    
   /* static testMethod void EOF_GW_Utils_TESTMETHOD_17() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '1';
        frequest.CODICE_ORDINE_OLO = '02112016_38';
        
        frequest.COGNOME_CLIENTE='';
        frequest.CODICE_ORDINE_OLO = '02112016_39';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.tipo_comunicazione='1';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.CODICE_ORDINE_OLO = '02112016_40';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_18() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.CODICE_ORDINE_OLO = '02112016_41';
        frequest.tipo_comunicazione='1';
        frequest.data_notifica = null;
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_42';
        frequest.tipo_comunicazione='1';
        frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
        frequest.IDENTIFICATIVO_DEL_POP='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }*/
    
   /* static testMethod void EOF_GW_Utils_TESTMETHOD_19() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_43';
        frequest.tipo_comunicazione='1';
        frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
        frequest.IDENTIFICATIVO_DEL_POP='PG_01';
        frequest.Provincia='';
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_2() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_44';
        frequest.tipo_comunicazione='1';
        frequest.Provincia='PG';
        frequest.comune=''; 
        EOF_GW_Utils.checkSync(frequest);
        frequest.CODICE_ORDINE_OLO = '02112016_45';
        frequest.tipo_comunicazione='1';
        frequest.Provincia='PG';
        frequest.comune='Perugia'; 
        frequest.indirizzo='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_20() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_46';
        frequest.tipo_comunicazione='1';
        frequest.Provincia='PG';
        frequest.comune='Perugia'; 
        frequest.indirizzo='via dei Pini';
        frequest.numero_civico='';
        EOF_GW_Utils.checkSync(frequest);
        frequest.CODICE_ORDINE_OLO = '02112016_47';
        frequest.tipo_comunicazione='1';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_21() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
                
        frequest.CODICE_ORDINE_OLO = '02112016_48';
        frequest.tipo_comunicazione='1';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='Via';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_49';
        frequest.tipo_comunicazione='1';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='Via';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
        frequest.ID_BUILDING='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;        
        EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_22() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();                     
        
        frequest.CODICE_ORDINE_OLO = '02112016_50';
        frequest.tipo_comunicazione='1';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='Via';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
        frequest.ID_BUILDING='10_054_054039_8000064301_40';
        frequest.NOME_REFERENTE_TECNICO_OLO='';
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_51';
        frequest.tipo_comunicazione='1';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;        
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    } */
    
  /*  static testMethod void EOF_GW_Utils_TESTMETHOD_3() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_52';
        frequest.tipo_comunicazione='1';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='';
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_53';
        frequest.tipo_comunicazione='1';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_30() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_54';
        frequest.tipo_comunicazione='1';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='';
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_55';
        frequest.tipo_comunicazione='1';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        for(integer x=0; x<55; x++){
            frequest.NOME_REFERENTE_TECNICO_OLO=frequest.NOME_REFERENTE_TECNICO_OLO+'a';
        }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_31() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
                
        frequest.CODICE_ORDINE_OLO = '02112016_56';
        frequest.tipo_comunicazione='1';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
        for(integer x=0; x<55; x++){
            frequest.COGNOME_REFERENTE_TECNICO_OLO=frequest.COGNOME_REFERENTE_TECNICO_OLO+'a';
        }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_ORDINE_OLO = '02112016_39';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }*/
    
  /*  static testMethod void EOF_GW_Utils_TESTMETHOD_4() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
                
        frequest.CODICE_ORDINE_OLO = '02112016_56';
        frequest.tipo_comunicazione='1';
        for(integer x=0; x<55; x++){
            frequest.TELEFONO_REFERENTE_TECNICO_OLO=frequest.TELEFONO_REFERENTE_TECNICO_OLO+'a';
        }
        EOF_GW_Utils.checkSync(frequest);
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_58';
        frequest.tipo_comunicazione='1';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        for(integer x=0; x<55; x++){
            frequest.IDENTIFICATIVO_DEL_POP=frequest.IDENTIFICATIVO_DEL_POP+'a';
        }
OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
                EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_40() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_59';
        frequest.tipo_comunicazione='1';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        for(integer x=0; x<75; x++){
            frequest.COGNOME_CLIENTE=frequest.COGNOME_CLIENTE+'a';
        }
        
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.CODICE_ORDINE_OLO = '02112016_60';
        frequest.tipo_comunicazione='1';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        for(integer x=0; x<75; x++){
            frequest.RECAPITO_TELEFONICO_CLIENTE_1=frequest.RECAPITO_TELEFONICO_CLIENTE_1+'a';
        }
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_42() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
               
        frequest.CODICE_ORDINE_OLO = '02112016_61';
        frequest.tipo_comunicazione='1';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1='1234';
        frequest.OPZIONE_SYSTEM_UNICO='s';
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_62';
        frequest.tipo_comunicazione='1';
        frequest.GPON_VINCOLANTE='s';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
              
        test.stopTest();
        
    }*/
    
   /* static testMethod void EOF_GW_Utils_TESTMETHOD_5() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.apparato='s';
        frequest.CODICE_ORDINE_OLO = '02112016_62';
        frequest.tipo_comunicazione='1';
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.SLA_PREMIUM_ASSURANCE='s';
        frequest.CODICE_ORDINE_OLO = '02112016_63';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
              
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_50() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.apparato='s';
        frequest.CODICE_ORDINE_OLO = '02112016_62';
        frequest.tipo_comunicazione='1';
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.SLA_PREMIUM_ASSURANCE='s';
        frequest.CODICE_ORDINE_OLO = '02112016_63';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        EOF_GW_Utils.checkSync(frequest);
        
                
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_51() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        frequest.tipologia_servizio='si';
        frequest.CODICE_ORDINE_OLO = '02112016_64';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.COLLEGAMENTO_P2P='si';
        frequest.CODICE_ORDINE_OLO = '02112016_65';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_52() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
                
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.PROGETTO_SPECIALE=frequest.PROGETTO_SPECIALE+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_66';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.TIPOLOGIA_APPARATO=frequest.TIPOLOGIA_APPARATO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_67';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_53() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
                
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH=frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_68';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
   /* static testMethod void EOF_GW_Utils_TESTMETHOD_6() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        for(integer x=0; x<55; x++){
            frequest.PASSWORD_APPARATO=frequest.PASSWORD_APPARATO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_68';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.RECAPITO_TEST_LINEA=frequest.RECAPITO_TEST_LINEA+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_69';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_61() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
               
        for(integer x=0; x<55; x++){
            frequest.SCALA_PALAZZINA=frequest.SCALA_PALAZZINA+'a';
        }       
        frequest.CODICE_ORDINE_OLO = '02112016_70';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.GPON_ATTESTAZIONE=frequest.GPON_ATTESTAZIONE+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_71';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.RECAPITO_TELEFONICO_CLIENTE_2=frequest.RECAPITO_TELEFONICO_CLIENTE_2+'a';
        }
                
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_62() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.RECAPITO_TELEFONICO_CLIENTE_2=frequest.RECAPITO_TELEFONICO_CLIENTE_2+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_72';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.NOME_CLIENTE=frequest.NOME_CLIENTE+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_73';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
                
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_63() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA=frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_74';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
 /*   static testMethod void EOF_GW_Utils_TESTMETHOD_7() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
               
        for(integer x=0; x<55; x++){
            frequest.PARTICELLA_TOPONOMASTICA=frequest.PARTICELLA_TOPONOMASTICA+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_69';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.NUMERO_CIVICO=frequest.NUMERO_CIVICO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_70';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_70() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
                
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
                
        
        for(integer x=0; x<55; x++){
            frequest.INDIRIZZO=frequest.INDIRIZZO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_71';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.COMUNE=frequest.COMUNE+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_72';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_72() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.PROVINCIA=frequest.PROVINCIA+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_73';
        frequest.tipo_comunicazione='1';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
                
        test.stopTest();
        
    }
    
  /*  static testMethod void EOF_GW_Utils_TESTMETHOD_80() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '1';
        
        frequest.COGNOME_CLIENTE='';
        frequest.CODICE_ORDINE_OLO = '02112016_39';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        frequest.tipo_comunicazione='11';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.CODICE_ORDINE_OLO = '02112016_40';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_81() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.CODICE_ORDINE_OLO = '02112016_41';
        frequest.tipo_comunicazione='11';
        frequest.data_notifica = null;
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        frequest.CODICE_ORDINE_OLO = '02112016_42';
        frequest.tipo_comunicazione='11';
        frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
        frequest.IDENTIFICATIVO_DEL_POP='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_82() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_43';
        frequest.tipo_comunicazione='11';
        frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
        frequest.IDENTIFICATIVO_DEL_POP='PG_01';
        frequest.Provincia='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        frequest.CODICE_ORDINE_OLO = '02112016_44';
        frequest.tipo_comunicazione='11';
        frequest.Provincia='PG';
        frequest.comune=''; 
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }*/
    
  /*  static testMethod void EOF_GW_Utils_TESTMETHOD_9() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();         
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
            
        
        frequest.CODICE_ORDINE_OLO = '02112016_45';
        frequest.tipo_comunicazione='11';
        frequest.Provincia='PG';
        frequest.comune='Perugia'; 
        frequest.indirizzo='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        frequest.CODICE_ORDINE_OLO = '02112016_46';
        frequest.tipo_comunicazione='11';
        frequest.Provincia='PG';
        frequest.comune='Perugia'; 
        frequest.indirizzo='via dei Pini';
        frequest.numero_civico='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_90() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
       
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_47';
        frequest.tipo_comunicazione='11';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_48';
        frequest.tipo_comunicazione='11';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='Via';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_91() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');

        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
               
        frequest.CODICE_ORDINE_OLO = '02112016_49';
        frequest.tipo_comunicazione='11';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='Via';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
        frequest.ID_BUILDING='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_50';
        frequest.tipo_comunicazione='11';
        frequest.numero_civico='41';
        frequest.particella_toponomastica='Via';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
        frequest.ID_BUILDING='10_054_054039_8000064301_40';
        frequest.NOME_REFERENTE_TECNICO_OLO='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_X1() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_OPERATORE = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_X2() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.ID_NOTIFICA = '12345678901234567889899999';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_X3() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.ID_NOTIFICA = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_X4() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.ORARIO_APPUNTAMENTO = 'ok';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_X5() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.ORARIO_APPUNTAMENTO = '123:999:999';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_X6() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.ORARIO_APPUNTAMENTO = '25:67:99';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_X7() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        //frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.DATA_NOTIFICA = '';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    /*static testMethod void EOF_GW_Utils_TESTMETHOD_X8() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di acquisizione');
        // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
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
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        //frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = '';
        frequest.CODICE_ORDINE_OLO = '02112016';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        OM_GW_GE_Utils.checkslOrig=true;
        
        test.startTest();        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
                
        frequest.CODICE_ORDINE_OLO = '02112016';
        frequest.tipo_comunicazione='11';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkAsync(c);
        
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_92() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
       
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
		OM_GW_GE_Utils.checkslOrig=true;

		test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
                
        frequest.CODICE_ORDINE_OLO = '02112016_51';
        frequest.tipo_comunicazione='11';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
   /* static testMethod void EOF_GW_Utils_TESTMETHOD_10() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_52';
        frequest.tipo_comunicazione='11';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_53';
        frequest.tipo_comunicazione='11';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_100() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
       
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.CODICE_ORDINE_OLO = '02112016_54';
        frequest.tipo_comunicazione='11';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_55';
        frequest.tipo_comunicazione='11';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        for(integer x=0; x<30; x++){
            frequest.NOME_REFERENTE_TECNICO_OLO=frequest.NOME_REFERENTE_TECNICO_OLO+'a';
        }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_101() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_56';
        frequest.tipo_comunicazione='11';
        frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
        for(integer x=0; x<55; x++){
            frequest.COGNOME_REFERENTE_TECNICO_OLO=frequest.COGNOME_REFERENTE_TECNICO_OLO+'a';
        }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        
        
        
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_ORDINE_OLO = '02112016_39';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_11() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_56';
        frequest.tipo_comunicazione='11';
        for(integer x=0; x<30; x++){
            frequest.TELEFONO_REFERENTE_TECNICO_OLO=frequest.TELEFONO_REFERENTE_TECNICO_OLO+'a';
        }
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_58';
        frequest.tipo_comunicazione='11';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        for(integer x=0; x<55; x++){
            frequest.IDENTIFICATIVO_DEL_POP=frequest.IDENTIFICATIVO_DEL_POP+'a';
        }
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_110() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_59';
        frequest.tipo_comunicazione='11';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        for(integer x=0; x<75; x++){
            frequest.COGNOME_CLIENTE=frequest.COGNOME_CLIENTE+'a';
        }
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.CODICE_ORDINE_OLO = '02112016_60';
        frequest.tipo_comunicazione='11';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        for(integer x=0; x<75; x++){
            frequest.RECAPITO_TELEFONICO_CLIENTE_1=frequest.RECAPITO_TELEFONICO_CLIENTE_1+'a';
        }
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_111() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
                
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        frequest.CODICE_ORDINE_OLO = '02112016_61';
        frequest.tipo_comunicazione='11';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1='1234';
        frequest.OPZIONE_SYSTEM_UNICO='s';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '02112016_62';
        frequest.tipo_comunicazione='11';
        frequest.GPON_VINCOLANTE='s';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_12() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.apparato='s';
        frequest.CODICE_ORDINE_OLO = '02112016_62';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.SLA_PREMIUM_ASSURANCE='s';
        frequest.CODICE_ORDINE_OLO = '02112016_63';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
        
    static testMethod void EOF_GW_Utils_TESTMETHOD_121() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');

        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
               
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
       
                
        frequest.tipologia_servizio='si';
        frequest.CODICE_ORDINE_OLO = '02112016_64';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        frequest.COLLEGAMENTO_P2P='si';
        frequest.CODICE_ORDINE_OLO = '02112016_65';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_122() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.PROGETTO_SPECIALE=frequest.PROGETTO_SPECIALE+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_66';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.TIPOLOGIA_APPARATO=frequest.TIPOLOGIA_APPARATO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_67';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_123() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        
        for(integer x=0; x<55; x++){
            frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH=frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_68';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
   /* static testMethod void EOF_GW_Utils_TESTMETHOD_13() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        for(integer x=0; x<55; x++){
            frequest.PASSWORD_APPARATO=frequest.PASSWORD_APPARATO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_68';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.RECAPITO_TEST_LINEA=frequest.RECAPITO_TEST_LINEA+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_69';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_130() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.SCALA_PALAZZINA=frequest.SCALA_PALAZZINA+'a';
        }       
        frequest.CODICE_ORDINE_OLO = '02112016_70';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.GPON_ATTESTAZIONE=frequest.GPON_ATTESTAZIONE+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_71';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_131() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.RECAPITO_TELEFONICO_CLIENTE_2=frequest.RECAPITO_TELEFONICO_CLIENTE_2+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_72';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<55; x++){
            frequest.NOME_CLIENTE=frequest.NOME_CLIENTE+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_73';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_132() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
                
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
               
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        for(integer x=0; x<55; x++){
            frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA=frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA+'a';
        }
        
        frequest.CODICE_ORDINE_OLO = '02112016_74';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
 /*   static testMethod void EOF_GW_Utils_TESTMETHOD_14() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
                
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        
        for(integer x=0; x<20; x++){
            frequest.PARTICELLA_TOPONOMASTICA=frequest.PARTICELLA_TOPONOMASTICA+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_69';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<8; x++){
            frequest.NUMERO_CIVICO=frequest.NUMERO_CIVICO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_70';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_140() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
        
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        
        
        for(integer x=0; x<55; x++){
            frequest.INDIRIZZO=frequest.INDIRIZZO+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_71';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        for(integer x=0; x<50; x++){
            frequest.COMUNE=frequest.COMUNE+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_72';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        test.stopTest();
        
    }*/
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_141() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        // frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        
        
        
        for(integer x=0; x<20; x++){
            frequest.PROVINCIA=frequest.PROVINCIA+'a';
        }
        frequest.CODICE_ORDINE_OLO = '02112016_73';
        frequest.tipo_comunicazione='11';
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
        EOF_GW_Utils.checkSync(frequest);
        
        
        
        
        
        test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_151() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest','Notifica di accettazione');
        
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        
        EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
        i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
        i.EOF_Stato_Building__c=104;
        i.EOF_Pop__c='PG_01';
        insert i;
                
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
        frequest.GPON_VINCOLANTE = 'N';
        frequest.ID_RISORSA = 'risorsa';
        frequest.NOME_CLIENTE = 'XYZ';
        frequest.COGNOME_CLIENTE = 'XYZ';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
        frequest.PROVINCIA = 'Milano';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = '1';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        
        OM_GW_GE_Utils.slOrig = OM_GW_GE_Utils.create_EAI_Log(frequest);
OM_GW_GE_Utils.checkslOrig=true;

test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_GE_Utils.tpl = new TEMPLOG__c();
        OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        
        frequest.TIPO_COMUNICAZIONE = '1';
        EOF_GW_Utils.fr_tmp=frequest;
        EOF_GW_Utils.create_notify(TestDataFactory.c, 5, 'KO', 'B_K4', 'test');
        EOF_GW_Utils.create_notify(TestDataFactory.c, 5, 'KO', 'B_K5', 'test');
        EOF_GW_Utils.create_notify(TestDataFactory.c, 5, 'KO', 'B_K6', 'test');
        EOF_GW_Utils.create_notify(TestDataFactory.c, 5, 'KO', 'A_K3', 'test');
        EOF_GW_Utils.create_notify(TestDataFactory.c, 5, 'KO', 'A_K14', 'test');
        EOF_GW_Utils.create_notify(TestDataFactory.c, 12, 'KO', 'C_K13', 'test');
        
        test.stopTest();
        
    }
    
    // DA ELIMINARE ASAP
    /*
    public static testMethod void CodeCoverage(){
        test.starttest();
        EOF_GW_Utils.CodeCoverage();
        test.stoptest();
    }    
    */

}
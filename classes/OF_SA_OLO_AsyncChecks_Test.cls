@isTest
global class OF_SA_OLO_AsyncChecks_Test {
    @testSetup static void datasetupcustomsetting() {
        List<Stato_Building_positivi__c> lstCsPositivi = new List<Stato_Building_positivi__c>();
        
        Stato_Building_positivi__c state102 = new Stato_Building_positivi__c();
        	state102.Name = '102';
        lstCsPositivi.add(state102);
        
        Stato_Building_positivi__c state104 = new Stato_Building_positivi__c();
        	state104.Name = '104';
        lstCsPositivi.add(state104);        
        
        Stato_Building_positivi__c state105 = new Stato_Building_positivi__c();
        	state105.Name = '105';
        lstCsPositivi.add(state105);
        
        Stato_Building_positivi__c state107 = new Stato_Building_positivi__c();
        	state107.Name = '107';
        lstCsPositivi.add(state107);
        
        Stato_Building_positivi__c state109 = new Stato_Building_positivi__c();
        	state109.Name = '109';
        lstCsPositivi.add(state109);
        
        Stato_Building_positivi__c state110 = new Stato_Building_positivi__c();
        	state110.Name = '110';
        lstCsPositivi.add(state110);
        
        insert lstCsPositivi;
        
    } 
    
    global static testMethod void Method1(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq;
        
        system.debug('il service log ha id:' +slFiberReq.id);
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		
        system.debug('il recordtype referente tecnico ha id:' +OF_SA_GE_Utils.rtMap.get('Referente_Tecnico_OLO'));
        
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();
        OF_SA_GE_Utils.refTec.recordtypeId = OF_SA_GE_Utils.rtMap.get('Referente_Tecnico_OLO');
        
        System.debug('Il Contact id è:' + OF_SA_GE_Utils.refTec.id);
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('################# il case id è:'+ TestDataFactory.c1.id);
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory con stato building != 104 e 110
    global static testMethod void Method2(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 100;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory con pop sbagliato
    global static testMethod void Method3(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        


        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
       
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'TestTest';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory con data non RFA/RFC
    global static testMethod void Method4(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = string.valueof(system.today());
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();        

        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //Network Inventory ok
    global static testMethod void Method5(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'Test';
        OLO_VAN.USER_VLAN = 'Test';
        OLO_VAN.SERVICE_VLAN = 'Test';
        OLO_VAN.PROFILO_VLAN = 'Test';
        OLO_VAN.INFORMAZIONI_VLAN = 'Test';
        OLO_VAN.CUSTOMER_VLAN = 'Test';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'Test';
        List<OF_SA_WS_IN_OLO_Activation.VLAN> OLO_VLANList = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        OLO_VLANList.add(OLO_VAN);
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'Test';
        OLO_APPARATO.PASSWORD_APPARATO = 'Test';
        OLO_APPARATO.AZIONE_APPARATO = 'Test';
        List<OF_SA_WS_IN_OLO_Activation.APPARATO> OLO_APPARATOList = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        OLO_APPARATOList.add(OLO_APPARATO);
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'Test'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';
        List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO> OLO_SERAGGList = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        OLO_SERAGGList.add(OLO_SERAGG);
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        /**End Network Inventory**/
        
        /**Elenco comuni italiani**/
        OF_ElencoComuniItaliani__c EC = new OF_ElencoComuniItaliani__c();
        EC.OF_CodiceIstat__c = ni.OF_SA_Comune__c;
        EC.OF_Comune__c = 'Test';
        EC.OF_Provincia__c = 'Test';
        insert EC;
        /**End Elenco comuni italiani**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    
    //Nome cliente e OF_SA_ID_Servizio__c e contatti vuoti - NI OK
    global static testMethod void Method6(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'Test';
        OLO_VAN.USER_VLAN = 'Test';
        OLO_VAN.SERVICE_VLAN = 'Test';
        OLO_VAN.PROFILO_VLAN = 'Test';
        OLO_VAN.INFORMAZIONI_VLAN = 'Test';
        OLO_VAN.CUSTOMER_VLAN = 'Test';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'Test';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'Test';
        OLO_APPARATO.PASSWORD_APPARATO = 'Test';
        OLO_APPARATO.AZIONE_APPARATO = 'Test';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'Test'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = '';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = ActivationReq.ID_BUILDING;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        /**End Network Inventory**/
        
        /**Elenco comuni italiani**/
        OF_ElencoComuniItaliani__c EC = new OF_ElencoComuniItaliani__c();
        EC.OF_CodiceIstat__c = ni.OF_SA_Comune__c;
        EC.OF_Comune__c = 'Test';
        EC.OF_Provincia__c = 'Test';
        insert EC;
        /**End Elenco comuni italiani**/
        
        
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'Open Stream';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = OLO_SERAGG.NOME_SERVIZIO; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        insert ce;
        /**END Commercial Element Istanziato**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
                
    }
    
    
    //Testa il metodo OLO_AsyncStatusUpdate
    global static testMethod void Method7(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        StatReq.CODICE_ORDINE_OF = 'Test';
        StatReq.CODICE_OPERATORE = 'TIS';
        StatReq.CODICE_ORDINE_OLO = 'Test';
        StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        StatReq.ID_NOTIFICA = 'Test';
        StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'M';
        StatReq.MOTIVAZIONE = 'M';
        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        StatReq.ORARIO_APPUNTAMENTO = 'Test';
        StatReq.NOME_CLIENTE = 'Test';
        StatReq.COGNOME_CLIENTE = 'Test';
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        StatReq.NOTE = 'Test';
        

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncStatusUpdate(TestDataFactory.c1, StatReq);
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        Test.stopTest(); 
        

    }
    
   
    //Testa il metodo OLO_AsyncReschedule
    global static testMethod void Method8(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
        
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        RR.CODICE_ORDINE_OF = 'Test';
        RR.CODICE_OPERATORE = 'TIS';
        RR.CODICE_ORDINE_OLO = 'Test';
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        RR.ID_NOTIFICA = 'Test';
        RR.NOME_CLIENTE = 'Test';
        RR.COGNOME_CLIENTE = 'Test';
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        RR.ORARIO_APPUNTAMENTO = 'Test';
        RR.NOTE = 'Test';
        RR.CODICE_MOTIVAZIONE = 'M';
        RR.MOTIVAZIONE = 'M';
        
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncReschedule(TestDataFactory.c1, RR);
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        Test.stopTest(); 
        
    }
    
    
    //Testa il metodo OLO_AsyncDeactivation - non esiste l'asset
    global static testMethod void Method9(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - FiberRequest', null);        

       
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest DR = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        DR.CODICE_OPERATORE = 'TIS';
        DR.CODICE_ORDINE_OLO = 'Test';
        DR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        DR.ID_NOTIFICA = 'Test';
        DR.ID_RISORSA = 'Test';
        DR.NOME_CLIENTE = 'Test';
        DR.COGNOME_CLIENTE = 'Test';
        DR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        DR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        DR.CODICE_MOTIVAZIONE = 'M';
        DR.MOTIVAZIONE = 'M';
        DR.NOTE = 'Test';
        
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.cliente.name='Marco';
        
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        
        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();

        
        OF_SA_OLO_AsyncChecks.OLO_AsyncDeactivation(TestDataFactory.c1.id, TestDataFactory.ESlog[0].id);
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        Test.stopTest(); 
        
    }
 /*   
    global static testMethod void Method10(){
        Test.startTest();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - FiberRequest', null); 
         
        Insert new Verticali__c(RecordTypesAssets__c ='\'PO_Asset_Backhauling_Collegamento\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'', createNotifyBatchLimit__c = 10000, callWsBillingBatchSize__c = 4,RecorTypesList__c = '\'OF_ServiziAggiuntivi\',\'OF_CPE\',\'OF_VLAN\',\'OF_Standard\',\'PO_Portalino\'');
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
            Deact.CODICE_OPERATORE = 'VF';
            Deact.CODICE_ORDINE_OLO='TEST_CESS_001';
            Deact.DATA_NOTIFICA= String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
            Deact.ID_NOTIFICA = String.valueOf(System.now().getTime());
            Deact.ID_RISORSA = 'ATT_2018-12-12_09:47:43';
            Deact.NOME_CLIENTE = 'NOME';
            Deact.COGNOME_CLIENTE = 'COGNOME';
            Deact.RECAPITO_TELEFONICO_CLIENTE_1 = '88888888';
            Deact.RECAPITO_TELEFONICO_CLIENTE_2 = '88888888';
            Deact.NOTE = 'test';
        
        OF_SA_GE_Utils.create_EAI_Log(deact);
        
        Case c = new Case();
            c.subject='Richiesta Cessazione';
            c.recordtypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Cessazione');
            c.Status='Inviato';
            c.EOF_Id_Risorsa__c=Deact.ID_Risorsa;
            c.EOF_Codice_Ordine_Olo__c=Deact.CODICE_ORDINE_OLO;
            c.EOF_Codice_Operatore_WS__c = Deact.CODICE_OPERATORE;            
            c.EOF_Codice_Ordine_OLO__c = Deact.CODICE_ORDINE_OLO;
            c.EOF_Data_Notifica__c = OF_SA_GE_Utils.StringToDate(Deact.DATA_NOTIFICA);
            c.EOF_Id_Notifica__c = Deact.ID_NOTIFICA;
            c.PO_SA_Portale__c=OF_SA_GE_Utils.PORTAL;
        	OLO_ID__c oloId = OLO_ID__c.getInstance(c.EOF_Codice_Operatore_WS__c);
        	c.EOF_Account_OLO__c = oloId.OF_Olo_Id__c;
        insert c;
        Asset ass = new Asset();
        	ass.Name = c.EOF_Id_Risorsa__c;
        	ass.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_OpenStream');
        	ass.Status='Attivo';
        	ass.EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c;
        	ass.AccountId = c.EOF_Account_OLO__c;
        insert ass;
        
        	Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        	OF_SA_OLO_AsyncChecks.OLO_AsyncDeactivation(c.id, OF_SA_GE_Utils.slOLOSF.id);
        Test.stopTest(); 
    }
    
	global static testMethod void Method10bis(){
        Test.startTest();
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - FiberRequest', null); 
         
        Insert new Verticali__c(RecordTypesAssets__c ='\'PO_Asset_Backhauling_Collegamento\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'', createNotifyBatchLimit__c = 10000, callWsBillingBatchSize__c = 4,RecorTypesList__c = '\'OF_ServiziAggiuntivi\',\'OF_CPE\',\'OF_VLAN\',\'OF_Standard\',\'PO_Portalino\'');
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
            Deact.CODICE_OPERATORE = 'VF';
            Deact.CODICE_ORDINE_OLO='TEST_CESS_001';
            Deact.DATA_NOTIFICA= String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
            Deact.ID_NOTIFICA = String.valueOf(System.now().getTime());
            Deact.ID_RISORSA = 'ATT_2018-12-12_09:47:43';
            Deact.NOME_CLIENTE = 'NOME';
            Deact.COGNOME_CLIENTE = 'COGNOME';
            Deact.RECAPITO_TELEFONICO_CLIENTE_1 = '88888888';
            Deact.RECAPITO_TELEFONICO_CLIENTE_2 = '88888888';
            Deact.NOTE = 'test';
        Deact.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();

        for(Integer i=0; i<1; i++){
            OF_SA_WS_IN_OLO_Deactivation.APPARATO app2 = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
            app2.TIPOLOGIA_APPARATO='Modem';
            Deact.APPARATO.add(app2);
        } 
        OF_SA_GE_Utils.create_EAI_Log(deact);
        
        Case c = new Case();
            c.subject='Richiesta Cessazione';
            c.recordtypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Cessazione');
            c.Status='Inviato';
            c.EOF_Id_Risorsa__c=Deact.ID_Risorsa;
            c.EOF_Codice_Ordine_Olo__c=Deact.CODICE_ORDINE_OLO;
            c.EOF_Codice_Operatore_WS__c = Deact.CODICE_OPERATORE;            
            c.EOF_Codice_Ordine_OLO__c = Deact.CODICE_ORDINE_OLO;
            c.EOF_Data_Notifica__c = OF_SA_GE_Utils.StringToDate(Deact.DATA_NOTIFICA);
            c.EOF_Id_Notifica__c = Deact.ID_NOTIFICA;
            c.PO_SA_Portale__c=OF_SA_GE_Utils.PORTAL;
        	OLO_ID__c oloId = OLO_ID__c.getInstance(c.EOF_Codice_Operatore_WS__c);
        	c.EOF_Account_OLO__c = oloId.OF_Olo_Id__c;
        insert c;
        Asset ass = new Asset();
        	ass.Name = c.EOF_Id_Risorsa__c;
        	ass.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_OpenStream');
        	ass.Status='Attivo';
        	ass.EOF_Id_Risorsa__c = c.EOF_Id_Risorsa__c;
        	ass.AccountId = c.EOF_Account_OLO__c;
        insert ass;
        
        	Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        	OF_SA_OLO_AsyncChecks.OLO_AsyncDeactivation(c.id, OF_SA_GE_Utils.slOLOSF.id);
        Test.stopTest(); 
    }*/
    global static testMethod void Method11(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Vlan', null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,TestDataFactory.ESlog[0].id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method12(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Cpe', null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        
        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();

        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,TestDataFactory.ESlog[0].id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method13(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Servizi Aggiuntivi', null);        


        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,TestDataFactory.sa.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method14(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', 'OF - SA - Servizi Aggiuntivi', null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,TestDataFactory.sa.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();

        Test.stopTest(); 
        
        
    }

    global static testMethod void Method15(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }

    global static testMethod void Method16(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 101;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }

    global static testMethod void Method17(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000001';
        
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('la data precedente è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
               
        TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c = Date.valueof('2024-11-16');
        system.debug('la data nuova è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }

    global static testMethod void Method18(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);       

        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'WN';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000001';
        OF_SA_GE_Utils.slOLOSF.EOF_ID_POP__c = ni.OF_SA_Pop__c;
        
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';


        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('la data precedente è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
               
        TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c = Date.valueof('2024-11-16');
		
		OF_Generatore_ID_Servizio__c g= new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=TestDataFactory.c1.id;
        insert g;         
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
	
    //metodo per testare la NotifyServiceMockupNACK
    global static testMethod void Method19(){
        
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);        

        
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
       
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq;
        
        system.debug('il service log ha id:' +slFiberReq.id);
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.EOF_Codice_Operatore__c ='VF';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
		
        system.debug('il recordtype referente tecnico ha id:' +OF_SA_GE_Utils.rtMap.get('Referente_Tecnico_OLO'));
        
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();
        OF_SA_GE_Utils.refTec.recordtypeId = OF_SA_GE_Utils.rtMap.get('Referente_Tecnico_OLO');
        
        System.debug('Il Contact id è:' + OF_SA_GE_Utils.refTec.id);
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
            

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';   

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('################# il case id è:'+ TestDataFactory.c1.id);
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        
        Test.stopTest(); 
        
        
    }
    //Attivazione ok
    global static testMethod void Method17bis(){ 

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
		//Inserisco il contratto
		Contract co = new Contract();
            co.AccountId = [SELECT Id FROM Account WHERE Name = 'Vodafone' AND Type = 'OLO' LIMIT 1].Id;
            co.Status = 'Attivo';
            co.StartDate = Date.newInstance(2019, 01, 01);
            //co.EndDate = Date.newInstance(2099, 01, 01);
            System.debug('*** AA - - => ' + co.AccountId);
        insert co;
        System.debug('************AA'+[SELECT Id, EndDate FROM Contract WHERE Status = 'Attivo']);
        OF_CatalogoCommerciale__c cat = new OF_CatalogoCommerciale__c();
            cat.name='Catalogo test';
            cat.OF_Attivo__c=true;
            cat.OF_DataInizioValidita__c=System.today().addDays(-10);
            cat.OF_DataFineValidita__c=System.today().addDays(100);
        insert cat;
        
        OF_Servizio__c serv = new OF_Servizio__c();
        	serv.Name = 'Open Stream';
            serv.OF_Attivo__c=true;
            serv.OF_DataInizioValidita__c=System.today().addDays(-10);
            serv.OF_DataFineValidita__c=System.today().addDays(100);
            serv.OF_CatalogoCommerciale__c= cat.id;
        insert serv;
        
        OF_ContrattoServizio__c coserv = new OF_ContrattoServizio__c ();
            coserv.OF_Contract__c = co.Id;
            coserv.OF_Servizio__c = serv.Id;
        insert coserv;
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000001';
        
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('la data precedente è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
               
        TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c = Date.valueof('2024-11-16');
        system.debug('la data nuova è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    //Attivazione ok
    global static testMethod void Method17bis2(){ 

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
		//Inserisco il contratto
		Contract co = new Contract();
            co.AccountId = [SELECT Id FROM Account WHERE Name = 'Vodafone' AND Type = 'OLO' LIMIT 1].Id;
            co.Status = 'Attivo';
            co.StartDate = Date.newInstance(2019, 01, 01);
            //co.EndDate = Date.newInstance(2099, 01, 01);
            System.debug('*** AA - - => ' + co.AccountId);
        insert co;
        System.debug('************AA'+[SELECT Id, EndDate FROM Contract WHERE Status = 'Attivo']);
        OF_CatalogoCommerciale__c cat = new OF_CatalogoCommerciale__c();
            cat.name='Catalogo test';
            cat.OF_Attivo__c=true;
            cat.OF_DataInizioValidita__c=System.today().addDays(-10);
            cat.OF_DataFineValidita__c=System.today().addDays(100);
        insert cat;
        
        OF_Servizio__c serv = new OF_Servizio__c();
        	serv.Name = 'Open Stream';
            serv.OF_Attivo__c=true;
            serv.OF_DataInizioValidita__c=System.today().addDays(-10);
            serv.OF_DataFineValidita__c=System.today().addDays(100);
            serv.OF_CatalogoCommerciale__c= cat.id;
        insert serv;
        
        OF_ContrattoServizio__c coserv = new OF_ContrattoServizio__c ();
            coserv.OF_Contract__c = co.Id;
            coserv.OF_Servizio__c = serv.Id;
        insert coserv;
        
        OF_AreaGeograficaCustom__c areageo = new OF_AreaGeograficaCustom__c ();
            areageo.OF_Istat__c = 'Test';
        insert areageo;
        
        OF_AreaGeograficaJunction__c areageojun = new OF_AreaGeograficaJunction__c ();
            areageojun.OF_Contratto__c = co.Id;
            areageojun.OF_AreaGeografica__c = areageo.Id;
        insert areageojun;
        
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=TestDataFactory.c1.id;
        insert g;
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = TestDataFactory.c1.EOF_ID_Building_WS__c;
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 110;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000001';
        
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('la data precedente è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
               
        TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c = Date.valueof('2024-11-16');
        system.debug('la data nuova è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(TestDataFactory.c1.id,slFiberReq.id);
        Test.stopTest(); 
        
        
    }
    //Attivazione ok
    global static testMethod void Method17bis3(){ 

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);        
		//Inserisco il contratto
		Contract co = new Contract();
            co.AccountId = [SELECT Id FROM Account WHERE Name = 'Vodafone' AND Type = 'OLO' LIMIT 1].Id;
            co.Status = 'Attivo';
            co.StartDate = Date.newInstance(2019, 01, 01);
            //co.EndDate = Date.newInstance(2099, 01, 01);
            System.debug('*** AA - - => ' + co.AccountId);
        insert co;
        System.debug('************AA'+[SELECT Id, EndDate FROM Contract WHERE Status = 'Attivo']);
        OF_CatalogoCommerciale__c cat = new OF_CatalogoCommerciale__c();
            cat.name='Catalogo test';
            cat.OF_Attivo__c=true;
            cat.OF_DataInizioValidita__c=System.today().addDays(-10);
            cat.OF_DataFineValidita__c=System.today().addDays(100);
        insert cat;
        
        OF_Servizio__c serv = new OF_Servizio__c();
        	serv.Name = 'Open Stream';
            serv.OF_Attivo__c=true;
            serv.OF_DataInizioValidita__c=System.today().addDays(-10);
            serv.OF_DataFineValidita__c=System.today().addDays(100);
            serv.OF_CatalogoCommerciale__c= cat.id;
        insert serv;
        
        OF_ContrattoServizio__c coserv = new OF_ContrattoServizio__c ();
            coserv.OF_Contract__c = co.Id;
            coserv.OF_Servizio__c = serv.Id;
        insert coserv;
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test12345';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test1';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';
        
        Case c = new Case(); 

        c.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Attivazione');
        c.EOF_Codice_Ordine_Olo__c=ActivationReq.CODICE_ORDINE_OLO;
        c.EOF_Codice_Operatore_WS__c = ActivationReq.CODICE_OPERATORE;            
        c.EOF_Codice_Ordine_OLO__c = ActivationReq.CODICE_ORDINE_OLO;
        c.EOF_Data_Notifica__c = OF_SA_GE_Utils.StringToDate(ActivationReq.DATA_NOTIFICA);
        c.EOF_Id_Notifica__c = ActivationReq.ID_NOTIFICA;                
        c.EOF_Data_Prevista_Attivazione__c = OF_SA_GE_Utils.StringToDateNoTime(ActivationReq.DATA_PREVISTA_ATTIVAZIONE);
        c.EOF_Identificativo_del_POP__c= ActivationReq.IDENTIFICATIVO_DEL_POP;
        c.EOF_ID_Building_WS__c =ActivationReq.ID_BUILDING;
        c.subject='Richiesta Attivazione';
        c.status='Acquisito';
        c.EOF_FASE__C='NA';
        c.PO_SA_Portale__c=OF_SA_GE_Utils.PORTAL;
        insert c;
        //creo il record di generatore ID Servizio che poi mi andrò a querare in asincrono
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=c.Id;
        insert g;
        
        EOF_EAI_Service_Log__c slog = OF_SA_GE_Utils.create_EAI_Log(ActivationReq);
        
        /**Service log**/
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        /**End Service log**/
        
        /**BusinessHours**/
        BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        /**End BusinessHours**/
        
        /**Network Inventory**/
        OF_SA_Network_Inventory_Attivi__c ni = new OF_SA_Network_Inventory_Attivi__c();
        ni.OF_SA_Civico__c = 'Test';
        ni.OF_SA_Comune__c = 'Test';
        ni.OF_SA_GPON_ID__c = 'Test';
        ni.OF_SA_ID_Building__c = 'Test';
        ni.OF_SA_Pop__c = 'Test';
        ni.OF_SA_Indirizzo__c = 'Test';
        ni.OF_SA_Particella_Top__c = 'Test';
        ni.OF_SA_Provincia__c = 'Test';
        ni.OF_SA_Scala_Palazzina__c = 'Test';
        ni.OF_SA_Stato_Building__c = 101;
        ni.OF_SA_ID_Building_OM__c = 'Test';
        insert ni;
        
        /**End Network Inventory**/
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000001';
        
        OF_SA_GE_Utils.cliente = new Account();
        OF_SA_GE_Utils.refTec = new contact();

        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_CLIENTE__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_COGNOME_REFERENTE_TECNICO_OLO__c ='test';
        OF_SA_GE_Utils.slSFOLO.EOF_NOME_REFERENTE_TECNICO_OLO__c ='test';

        OF_SA_GE_Utils.ListSlActivationSFOM = new List<EOF_EAI_Service_Log__c>();
		OF_SA_GE_Utils.ListSlActivationOLOSF = new List<EOF_EAI_Service_Log__c>();
        OF_SA_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        
        system.debug('la data precedente è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
               
        TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c = Date.valueof('2024-11-16');
        system.debug('la data nuova è :' +TestDataFactory.c1.EOF_Data_Prevista_Attivazione__c);
        
        OF_SA_OLO_AsyncChecks.OLO_AsyncActivation(c.id,slog.id);
        Test.stopTest(); 
        
        
    }
}
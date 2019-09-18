/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class OM_GW_Notify_Utils_TEST {
    
    // ------ TIPO COMUNICAZIONE = 6 ------
    static testMethod void OM_GW_Notify_Utils_testmethod_6v01() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF =TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='test_01';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v02() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
                
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
                
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF =TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
        
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v03() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
                
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='';
        fn.CODICE_ORDINE_EOF =TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v04() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v05() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v06() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v07() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='TestTestTestTestTestTestTestTest';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDatafactory.objeof, '1', 'OK', 'OK');
        OM_GW_GE_Utils.Endtemplog();        
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v08() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v09() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v10() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='6';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v11() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='666';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v12() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='1';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v13() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDatafactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='1';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v14() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='1';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='tTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v15() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='1';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v16() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37x';
        fn.CODICE_ORDINE_EOF =TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='test_01';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        //OM_GW_Notify_Utils.create_notify_Update_case(fn);
        //OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        //OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_6v17() {
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='6';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF =TestDataFactory.c.Id + 'x';
        fn.ID_NOTIFICA ='test_01';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        //OM_GW_Notify_Utils.create_notify_Update_case(fn);
        //OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        //OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    
    // ------ TIPO COMUNICAZIONE = 7 ------
    
    static testMethod void OM_GW_Notify_Utils_testmethod_7v01() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v02() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v03() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v04() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v05() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='testtesttesttesttesttesttesttesttesttesttesttesttesttesttest';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v06() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v07() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='11';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v08() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v09() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='11';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v10() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v11() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='11';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v12() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v13() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='testtesttesttesttesttesttesttesttesttesttest';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v14() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDatafactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v15() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        fn.ESITO_CONSEGNA_APPARATO ='1';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_7v16() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di espletamento');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='7';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_36';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c6.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        fn.ESITO_CONSEGNA_APPARATO ='2';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objEOF3, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }
    

    // ------ TIPO COMUNICAZIONE = 8 ------

    static testMethod void OM_GW_Notify_Utils_testmethod_8v01() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='8';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_8v02() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
       
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='8';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_8v03() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='8';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_8v04() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='8';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_8v05() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='8';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_8v06() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='8';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }


	// ------ TIPO COMUNICAZIONE = 9 ------
    
    static testMethod void OM_GW_Notify_Utils_testmethod_9v01() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='9';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_9v02() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='9';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }


    // ------ TIPO COMUNICAZIONE = 10 ------

    static testMethod void OM_GW_Notify_Utils_testmethod_10v01() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];

        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='10';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_10v02() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
       
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='10';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }
    

	// ------ TIPO COMUNICAZIONE = 12 ------
    
    static testMethod void OM_GW_Notify_Utils_testmethod_12v01() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='12';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_12v02() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
                  
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='12';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_12v03() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='12';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='1';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDatafactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }
    

	// ------ TIPO COMUNICAZIONE = 13 ------    

    static testMethod void OM_GW_Notify_Utils_testmethod_13v01() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='13';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
                
        test.stopTest();
        
        
    }

    static testMethod void OM_GW_Notify_Utils_testmethod_13v02() {

        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione', null, 'Notifica di accettazione');
        
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE ='13';
        fn.CODICE_OPERATORE ='VF';
        fn.CODICE_ORDINE_OLO ='02112016_37';
        fn.CODICE_ORDINE_EOF = TestDataFactory.c.Id;
        fn.ID_NOTIFICA ='Test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-13T13:30:00+02:00';
        fn.STATO_RICHIESTA ='0';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO ='test';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-10';
        fn.FLAG_PAGAMENTO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.PARAMETRI_TRASMISSIVI_OTTICI='test';
        fn.POSIZIONE_SPLITTER_SECONDARIO='test';
        fn.NUOVA_DAC ='2017-10-10';
        fn.CODICE_MOTIVAZIONE_RIMODULAZIONE_CONFERMA_DAC='t';
        fn.REASON_RIMODULAZIONE_CONFERMA_DAC='test';
        fn.CODICE_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='t';
        fn.MOTIVO_RIFIUTO_SOSPENSIONE_ANNULLAMENTO='test';
        
        
        test.startTest();
        OM_GW_GE_Utils.CreateTemplogOM(fn);        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_Notify_Utils.checkSync(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(TestDataFactory.objeof, '1', 'OK', 'OK');
        //OM_GW_Notify_Utils.call_OLO(fn);
                
        test.stopTest();
        
        
    }
 
}
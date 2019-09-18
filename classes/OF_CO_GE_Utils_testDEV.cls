@istest
public class OF_CO_GE_Utils_testDEV {
    
    public static testmethod void MyUnitTest1(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        system.assertEquals('A',OF_CO_GE_Utils.IdservizioIntToString(1));
        system.assertEquals('B',OF_CO_GE_Utils.IdservizioIntToString(2));
        system.assertEquals('C',OF_CO_GE_Utils.IdservizioIntToString(3));
        system.assertEquals('D',OF_CO_GE_Utils.IdservizioIntToString(4));
        system.assertEquals('E',OF_CO_GE_Utils.IdservizioIntToString(5));
        system.assertEquals('F',OF_CO_GE_Utils.IdservizioIntToString(6));
        system.assertEquals('G',OF_CO_GE_Utils.IdservizioIntToString(7));
        system.assertEquals('H',OF_CO_GE_Utils.IdservizioIntToString(8));
        system.assertEquals('I',OF_CO_GE_Utils.IdservizioIntToString(9));
        system.assertEquals('J',OF_CO_GE_Utils.IdservizioIntToString(10));
        system.assertEquals('K',OF_CO_GE_Utils.IdservizioIntToString(11));
        system.assertEquals('L',OF_CO_GE_Utils.IdservizioIntToString(12));
        system.assertEquals('M',OF_CO_GE_Utils.IdservizioIntToString(13));
        system.assertEquals('N',OF_CO_GE_Utils.IdservizioIntToString(14));
        system.assertEquals('O',OF_CO_GE_Utils.IdservizioIntToString(15));
        system.assertEquals('P',OF_CO_GE_Utils.IdservizioIntToString(16));
        system.assertEquals('Q',OF_CO_GE_Utils.IdservizioIntToString(17));
        system.assertEquals('R',OF_CO_GE_Utils.IdservizioIntToString(18));
        system.assertEquals('S',OF_CO_GE_Utils.IdservizioIntToString(19));
        system.assertEquals('T',OF_CO_GE_Utils.IdservizioIntToString(20));
        system.assertEquals('U',OF_CO_GE_Utils.IdservizioIntToString(21));
        system.assertEquals('V',OF_CO_GE_Utils.IdservizioIntToString(22));
        system.assertEquals('W',OF_CO_GE_Utils.IdservizioIntToString(23));
        system.assertEquals('X',OF_CO_GE_Utils.IdservizioIntToString(24));
        system.assertEquals('Y',OF_CO_GE_Utils.IdservizioIntToString(25));
        system.assertEquals('Z',OF_CO_GE_Utils.IdservizioIntToString(26));
    }
    /**MyUnitTest3() copre il seguente metodo:
/*1.IdServizioStringToInt
*/
    public static testmethod  void MyUnitTest2(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null, null);
        
        system.assertEquals(1,OF_CO_GE_Utils.IdservizioStringToInt('A'));
        system.assertEquals(2,OF_CO_GE_Utils.IdservizioStringToInt('B'));
        system.assertEquals(3,OF_CO_GE_Utils.IdservizioStringToInt('C'));
        system.assertEquals(4,OF_CO_GE_Utils.IdservizioStringToInt('D'));
        system.assertEquals(5,OF_CO_GE_Utils.IdservizioStringToInt('E'));
        system.assertEquals(6,OF_CO_GE_Utils.IdservizioStringToInt('F'));
        system.assertEquals(7,OF_CO_GE_Utils.IdservizioStringToInt('G'));
        system.assertEquals(8,OF_CO_GE_Utils.IdservizioStringToInt('H'));
        system.assertEquals(9,OF_CO_GE_Utils.IdservizioStringToInt('I'));
        system.assertEquals(10,OF_CO_GE_Utils.IdservizioStringToInt('J'));
        system.assertEquals(11,OF_CO_GE_Utils.IdservizioStringToInt('K'));
        system.assertEquals(12,OF_CO_GE_Utils.IdservizioStringToInt('L'));
        system.assertEquals(13,OF_CO_GE_Utils.IdservizioStringToInt('M'));
        system.assertEquals(14,OF_CO_GE_Utils.IdservizioStringToInt('N'));
        system.assertEquals(15,OF_CO_GE_Utils.IdservizioStringToInt('O'));
        system.assertEquals(16,OF_CO_GE_Utils.IdservizioStringToInt('P'));
        system.assertEquals(17,OF_CO_GE_Utils.IdservizioStringToInt('Q'));
        system.assertEquals(18,OF_CO_GE_Utils.IdservizioStringToInt('R'));
        system.assertEquals(19,OF_CO_GE_Utils.IdservizioStringToInt('S'));
        system.assertEquals(20,OF_CO_GE_Utils.IdservizioStringToInt('T'));
        system.assertEquals(21,OF_CO_GE_Utils.IdservizioStringToInt('U'));
        system.assertEquals(22,OF_CO_GE_Utils.IdservizioStringToInt('V'));
        system.assertEquals(23,OF_CO_GE_Utils.IdservizioStringToInt('W'));
        system.assertEquals(24,OF_CO_GE_Utils.IdservizioStringToInt('X'));
        system.assertEquals(25,OF_CO_GE_Utils.IdservizioStringToInt('Y'));
        system.assertEquals(26,OF_CO_GE_Utils.IdservizioStringToInt('Z'));
    }
    
    /**MyUnitTest4 copre il seguente metodo:
/*1.copy_request**/
    public static testmethod  void MyUnitTest3(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest a = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        a.CODICE_OPERATORE ='VF';
        a.CODICE_ORDINE_OLO ='test12';
        a.DATA_NOTIFICA = '2017-05-16T13:00:15+01:00';
        a.NOME_REFERENTE_TECNICO_OLO = 'Gianluca';
        a.COGNOME_REFERENTE_TECNICO_OLO = 'Galeazzi';
        a.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        a.EMAIL_REFERENTE_TECNICO_OLO = 'test@test.it';
        a.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        a.NOME_CLIENTE = 'Test';
        a.COGNOME_CLIENTE = 'Test';
        a.RECAPITO_TELEFONICO_CLIENTE_1 = 'Tel01';
        a.RECAPITO_TELEFONICO_CLIENTE_2 = 'Tel02';
        a.INFORMAZIONI_LOGISTICA_APPARATI = 'apparato1';
        a.DATA_PREVISTA_ATTIVAZIONE = '2017-07-17';
        a.ORARIO_APPUNTAMENTO = '18:00:00';
        a.CODICE_PROGETTO_SPECIALE = 'progetto1';
        a.PROMOZIONE = 'promozione1';
        a.CLUSTER_PROMOZIONE = 'Cluster1';
        a.NOTE = 'Note1';
        a.ID_BUILDING = '03_015_015146_1300_18';
        a.SCALA_PALAZZINA = 'Scala_Palazzina01';
        a.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Tel_Linea0123';
        a.RECAPITO_TEST_LINEA = 'Test_Linea_1';
        a.IDENTIFICATIVO_DEL_POP = 'MI/FCO/9';
        a.PROFILO = 'Profilo1';
        
        OF_SA_WS_IN_OLO_Activation.VLAN vlan1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        vlan1.KIT_CONSEGNA_VLAN = 'K';
        vlan1.USER_VLAN = 'v1';
        vlan1.SERVICE_VLAN = 'Serv';
        vlan1.PROFILO_VLAN = 'pr1';
        vlan1.INFORMAZIONI_VLAN = 'info1';
        vlan1.CUSTOMER_VLAN = 'cus1';
        vlan1.MODELLO_DI_SERVIZIO_VLAN = 'mod1';
        
        a.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        a.VLAN.add( vlan1 );
        
        
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO servAggiuntivo = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        servAggiuntivo.NOME_SERVIZIO =  's1'; 
        servAggiuntivo.INFORMAZIONI_SERVIZIO = 'Info_s1';
        
        a.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        a.SERVIZIO_AGGIUNTIVO.add( servAggiuntivo );
        
        
        OF_SA_WS_IN_OLO_Activation.APPARATO app = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        app.TIPOLOGIA_APPARATO = '1';
        app.PASSWORD_APPARATO = 'psw1';
        app.AZIONE_APPARATO = 'Y';
        
        a.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();        
        a.APPARATO.add( app );
        
        test.startTest();
        
        OF_CO_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_CO_GE_Utils.slOLOSF.id = TestDataFactory.ESlog[0].id;
                
        OF_CO_GE_Utils.create_EAI_Log( a );
        OF_CO_GE_Utils.CreateAcquisition_Log(TestDataFactory.c1);
        OF_CO_GE_Utils.create_ActivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog);        
        OF_CO_GE_Utils.syncError( a , 'A03' , 'test' );
        OF_CO_GE_Utils.checkDate('2017-11-16');
        OF_CO_GE_Utils.CheckTime('10:00:00');
        OF_CO_GE_Utils.checkDateTime('2017-11-16T10:00:00');
        OF_CO_GE_Utils.checkEmail('test@test.it');
        OF_CO_GE_Utils.checkAmministratori(TestDataFactory.c1);
        OF_CO_GE_Utils.getQuery('a','test');
        OF_CO_GE_Utils.simulateNACK ('test');
        
        //OF_CO_GE_Utils.CreateTemplogOLO(a);
        //OF_CO_GE_Utils.partialTemplog('test');
        //OF_CO_GE_Utils.EndTemplog();
        
        test.stopTest();
    }
    
    public static testmethod void MyUnitTest4(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);


        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        
        deact.CODICE_OPERATORE = 'VF';
        deact.CODICE_ORDINE_OLO = 'Test123';
        deact.DATA_NOTIFICA = '2017-05-16T13:00:15+01:00';
        deact.ID_NOTIFICA = 'n123';
        deact.ID_RISORSA = 'Risorsa01';
        deact.NOME_CLIENTE = 'Pippo';
        deact.COGNOME_CLIENTE = 'Baudo';
        deact.RECAPITO_TELEFONICO_CLIENTE_1  = 'Tel012';
        deact.RECAPITO_TELEFONICO_CLIENTE_2 = 'Tel012';
        deact.CODICE_MOTIVAZIONE = '1';
        deact.MOTIVAZIONE = 'Y';
        deact.NOTE = 'Note1';
        
        
        OF_SA_WS_IN_OLO_Deactivation.APPARATO app = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
        
        app.TIPOLOGIA_APPARATO = '1';
        app.ID_APPARATO = '1';
        
        deact.APPARATO =  new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();        
        deact.APPARATO.add( app );
        
        test.startTest();
        
        OF_CO_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_CO_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;

        
        OF_CO_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();
        
        
        OF_CO_GE_Utils.create_EAI_Log( deact );
        OF_CO_GE_Utils.syncError( deact , 'A07' , 'test' );
        OF_CO_GE_Utils.OLO_CreateDeactivation_Log(TestDataFactory.c1, deact);
        OF_CO_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_CO_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        //OF_CO_GE_Utils.CreateTemplogOLO(deact);
        //OF_CO_GE_Utils.partialTemplog('test');
        //OF_CO_GE_Utils.EndTemplog();

        
        test.stopTest();
        
    }
    
    public static testmethod void MyUnitTest5 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate ();
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-10-05T13:30:00+02:00';
        Notify.ID_NOTIFICA = '14950347';
        Notify.STATO_ORDINE ='7';
        Notify.CODICE_MOTIVAZIONE ='D02';
        Notify.MOTIVAZIONE ='test';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        //OF_CO_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_CO_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_CO_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_CO_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_CO_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        //OF_CO_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();        
    }
    
    public static testmethod void MyUnitTest6 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest Req = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
                
        Req.CODICE_OPERATORE ='VF';
        Req.CODICE_ORDINE_OLO ='Test';
        Req.DATA_NOTIFICA ='2017-08-28T11:30:15+01:00';
        Req.ID_NOTIFICA ='358925';
        Req.NOME_CLIENTE ='Marina';
        Req.COGNOME_CLIENTE ='Silvestro';
        Req.RECAPITO_TELEFONICO_CLIENTE_1 ='4352223';
        Req.RECAPITO_TELEFONICO_CLIENTE_2 ='1234454';
        Req.DATA_PREVISTA_ATTIVAZIONE ='2017-09-14';
        Req.ORARIO_APPUNTAMENTO ='14:30:00';
        Req.CODICE_MOTIVAZIONE ='D13';
        Req.MOTIVAZIONE ='Motivi cliente';
        Req.NOTE ='';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Req );
        OF_CO_GE_Utils.syncError( Req , 'A05' , 'test' );
        OF_CO_GE_Utils.OLO_CreateReschedule_Log(TestDataFactory.c1, Req);
        //OF_CO_GE_Utils.CreateTemplogOLO(Req);
        
        test.stopTest();        
    }
    
    public static testmethod void MyUnitTest7 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest Request = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest ();
        
        Request.CODICE_OPERATORE='VF'; 
        Request.CODICE_ORDINE_OLO='Test';
        Request.DATA_NOTIFICA='2017-07-10T15:20:15+02:00';
        Request.ID_NOTIFICA='test_01';
        Request.AZIONE='0';
        Request.CODICE_MOTIVAZIONE='AB';
        Request.MOTIVAZIONE='ABC';
        Request.DATA_PREVISTA_ATTIVAZIONE='2017-10-24';
        Request.ORARIO_APPUNTAMENTO='10:30:00';
        Request.NOME_CLIENTE='Mario';
        Request.COGNOME_CLIENTE='Rossi';
        Request.RECAPITO_TELEFONICO_CLIENTE_1='123456';
        Request.RECAPITO_TELEFONICO_CLIENTE_2='1234567';
        Request.NOTE='';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Request );
        OF_CO_GE_Utils.syncError( Request , 'A08' , 'test' );
        OF_CO_GE_Utils.OLO_CreateStatusUpdate_Log(TestDataFactory.c1,Request);
        //OF_CO_GE_Utils.CreateTemplogOLO(Request);        
        test.stopTest();
    }
    
    public static testmethod void MyUnitTest8 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','PO - SA - FiberRequest', null);

        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule Notify = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO='Test';
        Notify.CODICE_ORDINE_OF= TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA='2017-10-05T15:00:00+01:00';
        Notify.ID_NOTIFICA='test_redac_01';
        Notify.NOME_CLIENTE='Mario';
        Notify.COGNOME_CLIENTE='Rossi';
        Notify.RECAPITO_TELEFONICO_CLIENTE_1='123456';
        Notify.RECAPITO_TELEFONICO_CLIENTE_2='1234567';
        Notify.DATA_PREVISTA_ATTIVAZIONE='2017-10-24';
        Notify.ORARIO_APPUNTAMENTO='16:00:00';
        Notify.CODICE_MOTIVAZIONE='D13';
        Notify.MOTIVAZIONE='Motivi Cliente';
        Notify.NOTE='';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        OF_CO_GE_Utils.syncError( Notify , 'A06' , 'test' );                        
        OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_Reschedule');        
        OF_CO_GE_Utils.OM_CreateReschedule_Log(TestDataFactory.c1,notify);        
        
        test.stopTest();

    }
    
    public static testmethod void MyUnitTest9 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','PO - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        OF_CO_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');

        test.stopTest();
    }

    public static testmethod void MyUnitTest10 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','PO - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        OF_CO_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');

        test.stopTest();
    }

    public static testmethod void MyUnitTest11 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','PO - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        OF_CO_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest12 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','PO - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';
        
        Notify.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO serv2 = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        serv2.TIPOLOGIA_APPARATO='Modem';                                                                   
        serv2.ESITO_CONSEGNA_APPARATO='1';                                                                  
        serv2.ID_APPARATO_CONSEGNATO='qwer';                                                                    
        serv2.CODICE_MOTIVAZIONE_CONSEGNA='';
        serv2.MOTIVAZIONE_CONSEGNA='';
        Notify.APPARATO.add(serv2);
        
        Notify.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO serv1 = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        serv1.NOME_SERVIZIO='Ribaltamento Impianto';
        serv1.ESITO_SERVIZIO='0';
        serv1.MOTIVAZIONE_SERVIZIO='';
        serv1.CODICE_MOTIVAZIONE_SERVIZIO='';        
        Notify.SERVIZIO_AGGIUNTIVO.add(serv1);
        
        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        OF_CO_GE_Utils.syncError( Notify , 'A10' , 'test' );
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');

        test.stopTest();
    }

    public static testmethod void MyUnitTest13 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate ();
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-10-05T13:30:00+02:00';
        Notify.ID_NOTIFICA = '14950347';
        Notify.STATO_ORDINE ='7';
        Notify.CODICE_MOTIVAZIONE ='D02';
        Notify.MOTIVAZIONE ='test';

        Notify.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO serv2 = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        serv2.TIPOLOGIA_APPARATO='Modem';
        serv2.ESITO_RITIRO_APPARATO='';
        serv2.CODICE_MOTIVAZIONE_RITIRO='';
        serv2.MOTIVAZIONE_RITIRO='';
        Notify.APPARATO.add(serv2);             
        
        Notify.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        OF_SA_WS_IN_OM_StatusUpdate.VLAN servV = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        servV.USER_VLAN ='1';
        servV.SERVICE_VLAN ='1';
        servV.CUSTOMER_VLAN ='1';
        Notify.VLAN.add(servV);
        
        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        //OF_CO_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_CO_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_CO_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_CO_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_CO_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        
        test.stopTest();        
    }

    public static testmethod void MyUnitTest14 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
               
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        OF_CO_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_CO_GE_Utils.aggiornamentoDatiEspletamento(TestDataFactory.c1.id,TestDataFactory.ESLog[0].id,TestDataFactory.ESLog[0].id);
        OF_CO_GE_Utils.simulateNACK('OM');
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest15 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','PO - SA - FiberRequest2', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        OF_CO_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        OF_CO_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_CO_GE_Utils.simulateNACK('OLO');
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest16(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        
        deact.CODICE_OPERATORE = 'VF';
        deact.CODICE_ORDINE_OLO = 'Test123';
        deact.DATA_NOTIFICA = '2017-05-16T13:00:15+01:00';
        deact.ID_NOTIFICA = 'n123';
        deact.ID_RISORSA = 'Risorsa01';
        deact.NOME_CLIENTE = 'Pippo';
        deact.COGNOME_CLIENTE = 'Baudo';
        deact.RECAPITO_TELEFONICO_CLIENTE_1  = 'Tel012';
        deact.RECAPITO_TELEFONICO_CLIENTE_2 = 'Tel012';
        deact.CODICE_MOTIVAZIONE = '1';
        deact.MOTIVAZIONE = 'Y';
        deact.NOTE = 'Note1';
        
        
        OF_SA_WS_IN_OLO_Deactivation.APPARATO app = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
        
        app.TIPOLOGIA_APPARATO = '1';
        app.ID_APPARATO = '1';
        
        deact.APPARATO =  new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();        
        deact.APPARATO.add( app );
        
        test.startTest();
        OF_CO_GE_Utils.tmpl = new TEMPLOG__c();
        OF_CO_GE_Utils.tmpl.Tempi_Parziali__c = string.valueof(datetime.now());
   
        OF_CO_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_CO_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;       

        
        OF_CO_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();        
        
        OF_CO_GE_Utils.create_EAI_Log( deact );
        OF_CO_GE_Utils.syncError( deact , 'A07' , 'test' );
        
        TestDataFactory.c1.status='Cessato KO';
        update TestDataFactory.c1;
        
        OF_CO_GE_Utils.OLO_CreateDeactivation_Log(TestDataFactory.c1, deact);
        OF_CO_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_CO_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        test.stopTest();
        
    }

    public static testmethod void MyUnitTest17(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);

        OF_SA_WS_OLO_Classi.NotificaOrdineGpona_element ngp = new  OF_SA_WS_OLO_Classi.NotificaOrdineGpona_element();
        
        ngp.CODICE_ORDINE_OLO ='';
        ngp.CODICE_OPERATORE ='';
        ngp.CODICE_ORDINE_EOF='';
        ngp.DATA_NOTIFICA ='';
        ngp.ID_NOTIFICA ='';
        ngp.STATO_ORDINE='';
        ngp.CODICE_MOTIVAZIONE='';
        ngp.MOTIVAZIONE ='';
        ngp.ID_RISORSA ='';
        ngp.DATA_ESPLETAMENTO_ORDINE ='';
        ngp.SCALA_PALAZZINA ='';
        ngp.DDT ='';
        ngp.NOTE ='';
        
        test.startTest();
        OF_CO_GE_Utils.copy_request(ngp);
        test.stopTest();
    }

    public static testmethod void MyUnitTest18(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);

        OF_SA_WS_OLO_Classi.NotificaRischedulazione_element nre = new OF_SA_WS_OLO_Classi.NotificaRischedulazione_element();
        nre.CODICE_OPERATORE='';
        nre.CODICE_ORDINE_OLO ='';
        nre.DATA_NOTIFICA ='';
        nre.ID_NOTIFICA ='';
        nre.NOME_CLIENTE ='';
        nre.COGNOME_CLIENTE ='';
        nre.RECAPITO_TELEFONICO_CLIENTE_1 ='';
        nre.RECAPITO_TELEFONICO_CLIENTE_2 ='';
        nre.DATA_PREVISTA_ATTIVAZIONE ='';
        nre.ORARIO_APPUNTAMENTO ='';
        nre.CODICE_MOTIVAZIONE ='';
        nre.MOTIVAZIONE ='';
        nre.NOTE ='';
        
        test.startTest();
        OF_CO_GE_Utils.copy_request(nre);       
        test.stopTest();
        
    }

    public static testmethod void MyUnitTest19(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        map<string,string> mappa = new map<string,string>();
        mappa.put('Type','ACK');
        
        
        test.startTest();
        
        OF_CO_GE_Utils.create_EAI_Log(mappa);
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest20(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);

        OF_SA_WS_OM_Classi.AttivazioneGpona_element age = new OF_SA_WS_OM_Classi.AttivazioneGpona_element();
        age.CODICE_OPERATORE='';
        age.CODICE_ORDINE_OLO='';
        age.DATA_NOTIFICA='';
        age.ID_NOTIFICA='';
        age.NOME_REFERENTE_TECNICO_OLO='';
        age.COGNOME_REFERENTE_TECNICO_OLO='';
        age.TELEFONO_REFERENTE_TECNICO_OLO='';
        age.EMAIL_REFERENTE_TECNICO_OLO='';
        age.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH='';
        age.NOME_CLIENTE='';
        age.COGNOME_CLIENTE='';
        age.RECAPITO_TELEFONICO_CLIENTE_1='';
        age.RECAPITO_TELEFONICO_CLIENTE_2='';
        age.INFORMAZIONI_LOGISTICA_APPARATI='';
        age.DATA_PREVISTA_ATTIVAZIONE='';
        age.ORARIO_APPUNTAMENTO='';
        age.CODICE_PROGETTO_SPECIALE='';
        age.PROMOZIONE='';
        age.CLUSTER_PROMOZIONE='';
        age.NOTE='';
        age.ID_BUILDING='';
        age.SCALA_PALAZZINA='';
        age.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
        age.RECAPITO_TEST_LINEA='';
        age.IDENTIFICATIVO_DEL_POP='';
        age.TIPO_COMUNICAZIONE='';
        age.SORGENTE='';
        age.CODICE_ORDINE_OF='';
        age.SLA_DATE='';
        age.GPON_ATTESTAZIONE='';
        age.GPON_VINCOLANTE='';
        age.ID_RISORSA='';
        age.OPZIONE_SYSTEM_UNICO='';
        age.CODICE_MOTIVAZIONE='';
        age.MOTIVAZIONE='';
        age.COLLEGAMENTO_P2P='';
        age.TRACCIATO='';
        age.ID_SERVIZIO='';
        age.PROFILO='';
        age.PROVINCIA='';
        age.COMUNE='';
        age.INDIRIZZO='';
        age.NUMERO_CIVICO='';
        age.PARTICELLA_TOPONOMASTICA='';
        age.SLA_PREMIUM_ASSURANCE='';

        test.starttest();
        OF_CO_GE_Utils.create_EAI_Log(age);
        
        test.stoptest();
    }    
}
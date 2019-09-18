@istest
public class OF_SA_GE_Utils_test {
    
    public static testmethod  void MyUnitTest1(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        system.assertEquals('A',OF_SA_GE_Utils.IdservizioIntToString(1));
        system.assertEquals('B',OF_SA_GE_Utils.IdservizioIntToString(2));
        system.assertEquals('C',OF_SA_GE_Utils.IdservizioIntToString(3));
        system.assertEquals('D',OF_SA_GE_Utils.IdservizioIntToString(4));
        system.assertEquals('E',OF_SA_GE_Utils.IdservizioIntToString(5));
        system.assertEquals('F',OF_SA_GE_Utils.IdservizioIntToString(6));
        system.assertEquals('G',OF_SA_GE_Utils.IdservizioIntToString(7));
        system.assertEquals('H',OF_SA_GE_Utils.IdservizioIntToString(8));
        system.assertEquals('I',OF_SA_GE_Utils.IdservizioIntToString(9));
        system.assertEquals('J',OF_SA_GE_Utils.IdservizioIntToString(10));
        system.assertEquals('K',OF_SA_GE_Utils.IdservizioIntToString(11));
        system.assertEquals('L',OF_SA_GE_Utils.IdservizioIntToString(12));
        system.assertEquals('M',OF_SA_GE_Utils.IdservizioIntToString(13));
        system.assertEquals('N',OF_SA_GE_Utils.IdservizioIntToString(14));
        system.assertEquals('O',OF_SA_GE_Utils.IdservizioIntToString(15));
        system.assertEquals('P',OF_SA_GE_Utils.IdservizioIntToString(16));
        system.assertEquals('Q',OF_SA_GE_Utils.IdservizioIntToString(17));
        system.assertEquals('R',OF_SA_GE_Utils.IdservizioIntToString(18));
        system.assertEquals('S',OF_SA_GE_Utils.IdservizioIntToString(19));
        system.assertEquals('T',OF_SA_GE_Utils.IdservizioIntToString(20));
        system.assertEquals('U',OF_SA_GE_Utils.IdservizioIntToString(21));
        system.assertEquals('V',OF_SA_GE_Utils.IdservizioIntToString(22));
        system.assertEquals('W',OF_SA_GE_Utils.IdservizioIntToString(23));
        system.assertEquals('X',OF_SA_GE_Utils.IdservizioIntToString(24));
        system.assertEquals('Y',OF_SA_GE_Utils.IdservizioIntToString(25));
        system.assertEquals('Z',OF_SA_GE_Utils.IdservizioIntToString(26));
    }
    /**MyUnitTest3() copre il seguente metodo:
/*1.IdServizioStringToInt
*/
    public static testmethod  void MyUnitTest2(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM',null, null);
        
        system.assertEquals(1,OF_SA_GE_Utils.IdservizioStringToInt('A'));
        system.assertEquals(2,OF_SA_GE_Utils.IdservizioStringToInt('B'));
        system.assertEquals(3,OF_SA_GE_Utils.IdservizioStringToInt('C'));
        system.assertEquals(4,OF_SA_GE_Utils.IdservizioStringToInt('D'));
        system.assertEquals(5,OF_SA_GE_Utils.IdservizioStringToInt('E'));
        system.assertEquals(6,OF_SA_GE_Utils.IdservizioStringToInt('F'));
        system.assertEquals(7,OF_SA_GE_Utils.IdservizioStringToInt('G'));
        system.assertEquals(8,OF_SA_GE_Utils.IdservizioStringToInt('H'));
        system.assertEquals(9,OF_SA_GE_Utils.IdservizioStringToInt('I'));
        system.assertEquals(10,OF_SA_GE_Utils.IdservizioStringToInt('J'));
        system.assertEquals(11,OF_SA_GE_Utils.IdservizioStringToInt('K'));
        system.assertEquals(12,OF_SA_GE_Utils.IdservizioStringToInt('L'));
        system.assertEquals(13,OF_SA_GE_Utils.IdservizioStringToInt('M'));
        system.assertEquals(14,OF_SA_GE_Utils.IdservizioStringToInt('N'));
        system.assertEquals(15,OF_SA_GE_Utils.IdservizioStringToInt('O'));
        system.assertEquals(16,OF_SA_GE_Utils.IdservizioStringToInt('P'));
        system.assertEquals(17,OF_SA_GE_Utils.IdservizioStringToInt('Q'));
        system.assertEquals(18,OF_SA_GE_Utils.IdservizioStringToInt('R'));
        system.assertEquals(19,OF_SA_GE_Utils.IdservizioStringToInt('S'));
        system.assertEquals(20,OF_SA_GE_Utils.IdservizioStringToInt('T'));
        system.assertEquals(21,OF_SA_GE_Utils.IdservizioStringToInt('U'));
        system.assertEquals(22,OF_SA_GE_Utils.IdservizioStringToInt('V'));
        system.assertEquals(23,OF_SA_GE_Utils.IdservizioStringToInt('W'));
        system.assertEquals(24,OF_SA_GE_Utils.IdservizioStringToInt('X'));
        system.assertEquals(25,OF_SA_GE_Utils.IdservizioStringToInt('Y'));
        system.assertEquals(26,OF_SA_GE_Utils.IdservizioStringToInt('Z'));
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
        
        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.id = TestDataFactory.ESlog[0].id;
                
        OF_SA_GE_Utils.create_EAI_Log( a );
        OF_SA_GE_Utils.CreateAcquisition_Log(TestDataFactory.c1);
        OF_SA_GE_Utils.create_ActivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog);        
        OF_SA_GE_Utils.syncError( a , 'A03' , 'test' );
        OF_SA_GE_Utils.checkDate('2017-11-16');
        OF_SA_GE_Utils.CheckTime('10:00:00');
        OF_SA_GE_Utils.checkDateTime('2017-11-16T10:00:00');
        OF_SA_GE_Utils.checkEmail('test@test.it');
        OF_SA_GE_Utils.checkAmministratori(TestDataFactory.c1);
        OF_SA_GE_Utils.getQuery('a','test');
        OF_SA_GE_Utils.simulateNACK ('test');
        
        OF_SA_GE_Utils.CreateTemplogOLO(a);
        OF_SA_GE_Utils.partialTemplog('test');
        OF_SA_GE_Utils.EndTemplog();
        
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
        
        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;

        
        OF_SA_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();
        
        
        OF_SA_GE_Utils.create_EAI_Log( deact );
        OF_SA_GE_Utils.syncError( deact , 'A07' , 'test' );
        OF_SA_GE_Utils.OLO_CreateDeactivation_Log(TestDataFactory.c1, deact);
        OF_SA_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_SA_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        OF_SA_GE_Utils.CreateTemplogOLO(deact);
        OF_SA_GE_Utils.partialTemplog('test');
        OF_SA_GE_Utils.EndTemplog();

        
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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_SA_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_SA_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_SA_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_SA_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
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
        OF_SA_GE_Utils.create_EAI_Log( Req );
        OF_SA_GE_Utils.syncError( Req , 'A05' , 'test' );
        OF_SA_GE_Utils.OLO_CreateReschedule_Log(TestDataFactory.c1, Req);
        OF_SA_GE_Utils.CreateTemplogOLO(Req);
        
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
        OF_SA_GE_Utils.create_EAI_Log( Request );
        OF_SA_GE_Utils.syncError( Request , 'A08' , 'test' );
        OF_SA_GE_Utils.OLO_CreateStatusUpdate_Log(TestDataFactory.c1,Request);
        OF_SA_GE_Utils.CreateTemplogOLO(Request);        
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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'A06' , 'test' );                        
        OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_Reschedule');        
        OF_SA_GE_Utils.OM_CreateReschedule_Log(TestDataFactory.c1,notify);
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_SA_GE_Utils.CreateTemlogOM(Notify);

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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        OF_SA_GE_Utils.CreateTemlogOM(Notify);

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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'A10' , 'test' );
        OF_SA_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_SA_GE_Utils.CreateTemlogOM(Notify);

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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_SA_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_SA_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_SA_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_SA_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_SA_GE_Utils.aggiornamentoDatiEspletamento(TestDataFactory.c1.id,TestDataFactory.ESLog[0].id,TestDataFactory.ESLog[0].id);
        OF_SA_GE_Utils.simulateNACK('OM');
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        OF_SA_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_SA_GE_Utils.simulateNACK('OLO');
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
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
        OF_SA_GE_Utils.tmpl = new TEMPLOG__c();
        OF_SA_GE_Utils.tmpl.Tempi_Parziali__c = string.valueof(datetime.now());
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();         
        OF_SA_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;
        

        
        OF_SA_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();
        
        
        OF_SA_GE_Utils.create_EAI_Log( deact );
        OF_SA_GE_Utils.syncError( deact , 'A07' , 'test' );
        
        TestDataFactory.c1.status='Cessato KO';
        update TestDataFactory.c1;
        
        OF_SA_GE_Utils.OLO_CreateDeactivation_Log(TestDataFactory.c1, deact);
        OF_SA_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_SA_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        OF_SA_GE_Utils.CreateTemplogOLO(deact);
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
        OF_SA_GE_Utils.copy_request(ngp);
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
        OF_SA_GE_Utils.copy_request(nre);       
        test.stopTest();
        
    }

    public static testmethod void MyUnitTest19(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        map<string,string> mappa = new map<string,string>();
        mappa.put('Type','ACK');
        
        
        test.startTest();
        
        OF_SA_GE_Utils.create_EAI_Log(mappa);
        
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
        OF_SA_GE_Utils.create_EAI_Log(age);
        
        test.stoptest();
    }

    public static testmethod void MyUnitTest21(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
        list<EOF_EAI_Service_Log__c> sList = new list<EOF_EAI_Service_Log__c>();
                
        EOF_EAI_Service_Log__c eaiLog3 = new EOF_EAI_Service_Log__c();
        eaiLog3.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        eaiLog3.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        eaiLog3.EOF_ID_Notifica__c ='';
        eaiLog3.EOF_STATO_ORDINE__c ='Acquisito';
        eaiLog3.recordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_FiberRequest');
        
        sList.add(eaiLog3);
        
        EOF_EAI_Service_Log__c sl5 = new EOF_EAI_Service_Log__c();
        sl5 = new EOF_EAI_Service_Log__c();
        sl5.recordtypeId= OF_SA_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl5.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl5.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl5.OF_SA_Servizi_Aggiuntivi_Log__c=sl5.id;
        sl5.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl5.OF_SA_NOME_SERVIZIO__c ='Modem';
        sl5.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';        
        
        sList.add(sl5);
        
        EOF_EAI_Service_Log__c sl3 = new EOF_EAI_Service_Log__c();
        sl3.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Vlan'); 
        sl3.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl3.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl3.EOF_ID_Notifica__c ='12345';
        sl3.EOF_STATO_ORDINE__c ='Acquisito';
        sl3.OF_SA_VLan_Log__c=sl3.id;
        sl3.EOF_Stato_Richiesta__c='Inserita Portale';
        
        sList.add(sl3);
        
        EOF_EAI_Service_Log__c sl4 = new EOF_EAI_Service_Log__c();
        sl4.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Cpe'); 
        sl4.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl4.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl4.EOF_ID_Notifica__c ='12345';
        sl4.EOF_STATO_ORDINE__c ='Acquisito';
        sl4.OF_SA_Servizi_Aggiuntivi_Log__c=sl4.id;
        sl4.EOF_Stato_Richiesta__c='Inserita Portale';
        sl4.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl4.EOF_Tipo_Comunicazione_String__c='CPE';
        
        sList.add(sl4);
        
        insert sList;

        test.startTest();

        OF_SA_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.slOLOSF.id = eaiLog3.id;
        
        OF_SA_GE_Utils.create_ActivationToOM_Log(TestDataFactory.c1,sList);        
        
        test.stoptest();
        
    }
    
    //giovanni ernetti 17-10-2018 INIZIO
    public static testmethod void MyUnitTest22()
    {
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;         
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_GE_Utils.controlloVendibilita('VF','123');
        test.stopTest();
    }
    //giovanni ernetti 17-10-2018 FINE
    
    //Nikita Mali 29-03-2019 
    
    //for method create_ActivationToOM_Log
    //sl.recordtype.developername=='OF_SA_Vlan'
    public static testmethod void MyUnitTest23()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test777';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog.OF_SA_USER_VLAN__c = 'Test';
        eaiLog.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog_t = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test777'];
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t);
        
        test.startTest();
        OF_SA_GE_Utils.create_ActivationToOM_Log(c,slList);
        test.stopTest();
    }
    
    //sl.recordtype.developername=='OF_SA_Cpe'
    public static testmethod void MyUnitTest24()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog1.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test888';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog1.OF_SA_USER_VLAN__c = 'Test';
        eaiLog1.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog1.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog1.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog1.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        eaiLog1.EOF_TIPOLOGIA_APPARATO__C = 'Test';
        eaiLog1.OF_SA_PASSWORD_APPARATO__C = 'Test';
        eaiLog1.OF_SA_AZIONE_APPARATO__C = 'Test';
        insert eaiLog1;
        
        EOF_EAI_Service_Log__c  eaiLog_t1 = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,OF_SA_AZIONE_APPARATO__C
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test888'];
        
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t1);
        
        test.startTest();
        OF_SA_GE_Utils.create_ActivationToOM_Log(c,slList);
        test.stopTest();
    } 
    
    //sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'
    public static testmethod void MyUnitTest25()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test777';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog.OF_SA_USER_VLAN__c = 'Test';
        eaiLog.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        eaiLog.OF_SA_NOME_SERVIZIO__c = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_SERVIZIO__c = 'Test';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog_t = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test777'];
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t);
        
        test.startTest();
        OF_SA_GE_Utils.create_ActivationToOM_Log(c,slList);
        test.stopTest();
    } 
    
    //sl.recordtype.developername=='OF_SA_FiberRequest'
    public static testmethod void MyUnitTest26()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        
        c.OF_SA_CODICE_MOTIVAZIONE__c = 'Test';
        c.OF_SA_MOTIVAZIONE__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Particella_Toponomastica_WS__c = 'Test';
        c.EOF_Indirizzo_WS__c = 'Test';
        c.EOF_Numero_Civico_WS__c = 'Test';
        c.OF_SA_ID_Building_OM__c = 'Test';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test777';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog.OF_SA_USER_VLAN__c = 'Test';
        eaiLog.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        eaiLog.OF_SA_NOME_SERVIZIO__c = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_SERVIZIO__c = 'Test';
        eaiLog.EOF_Codice_Operatore__c = 'Test';
        eaiLog.EOF_Data_Notifica__c = System.today();
        eaiLog.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'Test';
        eaiLog.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        eaiLog.EOF_CODICE_PROGETTO_SPECIALE__c = 'Test';
        eaiLog.EOF_PROMOZIONE__c = 'Test';
        eaiLog.EOF_CLUSTER_PROMOZIONE__C = 'Test';
        eaiLog.EOF_NOTE__C = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__C = 'Test';
        eaiLog.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C = 'Test';
        eaiLog.EOF_RECAPITO_TEST_LINEA__C = 'Test';
        eaiLog.EOF_ID_Pop__c = 'Test';
        eaiLog.EOF_PROFILO__C = 'Test';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog_t = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,
                                           EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                           EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                           EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,EOF_RECAPITO_TEST_LINEA__C,
                                           EOF_ID_Pop__c,EOF_PROFILO__C
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test777'];
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t);
        
        test.startTest();
        OF_SA_GE_Utils.create_ActivationToOM_Log(c,slList);
        test.stopTest();
    } 
    
    //sl.recordtype.developername=='OF_SA_FiberRequest' and c.status = 'Acquisito'
    public static testmethod void MyUnitTest27()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        
        c.OF_SA_CODICE_MOTIVAZIONE__c = 'Test';
        c.OF_SA_MOTIVAZIONE__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Particella_Toponomastica_WS__c = 'Test';
        c.EOF_Indirizzo_WS__c = 'Test';
        c.EOF_Numero_Civico_WS__c = 'Test';
        c.OF_SA_ID_Building_OM__c = 'Test';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test777';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog.OF_SA_USER_VLAN__c = 'Test';
        eaiLog.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        eaiLog.OF_SA_NOME_SERVIZIO__c = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_SERVIZIO__c = 'Test';
        eaiLog.EOF_Codice_Operatore__c = 'Test';
        eaiLog.EOF_Data_Notifica__c = System.today();
        eaiLog.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'Test';
        eaiLog.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        eaiLog.EOF_CODICE_PROGETTO_SPECIALE__c = 'Test';
        eaiLog.EOF_PROMOZIONE__c = 'Test';
        eaiLog.EOF_CLUSTER_PROMOZIONE__C = 'Test';
        eaiLog.EOF_NOTE__C = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__C = 'Test';
        eaiLog.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C = 'Test';
        eaiLog.EOF_RECAPITO_TEST_LINEA__C = 'Test';
        eaiLog.EOF_ID_Pop__c = 'Test';
        eaiLog.EOF_PROFILO__C = 'Test';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog_t = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,
                                           EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                           EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                           EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,EOF_RECAPITO_TEST_LINEA__C,
                                           EOF_ID_Pop__c,EOF_PROFILO__C
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test777'];
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t);
        
        test.startTest();
        OF_SA_GE_Utils.create_ActivationToOM_Log(c,slList);
        test.stopTest();
    } 
    
    //for method create_DeactivationToOM_Log 
    //sl.recordtype.developername=='OF_SA_FiberRequest' and c.status = 'Acquisito'
    public static testmethod void MyUnitTest28()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        
        c.OF_SA_CODICE_MOTIVAZIONE__c = 'Test';
        c.OF_SA_MOTIVAZIONE__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Particella_Toponomastica_WS__c = 'Test';
        c.EOF_Indirizzo_WS__c = 'Test';
        c.EOF_Numero_Civico_WS__c = 'Test';
        c.OF_SA_ID_Building_OM__c = 'Test';
        c.EOF_GPON_Vincolante__c = 'Test';
        c.EOF_Opzione_System_Unico__c = 'Test';
        c.EOF_Collegamento_P2P__c = 'T';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test777';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog.OF_SA_USER_VLAN__c = 'Test';
        eaiLog.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        eaiLog.OF_SA_NOME_SERVIZIO__c = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_SERVIZIO__c = 'Test';
        eaiLog.EOF_Codice_Operatore__c = 'Test';
        eaiLog.EOF_Data_Notifica__c = System.today();
        eaiLog.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'Test';
        eaiLog.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        eaiLog.EOF_CODICE_PROGETTO_SPECIALE__c = 'Test';
        eaiLog.EOF_PROMOZIONE__c = 'Test';
        eaiLog.EOF_CLUSTER_PROMOZIONE__C = 'Test';
        eaiLog.EOF_NOTE__C = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__C = 'Test';
        eaiLog.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C = 'Test';
        eaiLog.EOF_RECAPITO_TEST_LINEA__C = 'Test';
        eaiLog.EOF_ID_Pop__c = 'Test';
        eaiLog.EOF_PROFILO__C = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog_t = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,
                                           EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                           EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                           EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,EOF_RECAPITO_TEST_LINEA__C,
                                           EOF_ID_Pop__c,EOF_PROFILO__C,EOF_ID_RISORSA__c
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test777'];
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t);
        
        test.startTest();
        OF_SA_GE_Utils.create_DeactivationToOM_Log(c,slList,asset_1);
        test.stopTest();
    } 
    
    //sl.recordtype.developername=='OF_SA_FiberRequest' and c.status != 'Acquisito'
    public static testmethod void MyUnitTest29()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        
        c.OF_SA_CODICE_MOTIVAZIONE__c = 'Test';
        c.OF_SA_MOTIVAZIONE__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Particella_Toponomastica_WS__c = 'Test';
        c.EOF_Indirizzo_WS__c = 'Test';
        c.EOF_Numero_Civico_WS__c = 'Test';
        c.OF_SA_ID_Building_OM__c = 'Test';
        c.EOF_GPON_Vincolante__c = 'Test';
        c.EOF_Opzione_System_Unico__c = 'Test';
        c.EOF_Collegamento_P2P__c = 'T';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test777';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog.OF_SA_USER_VLAN__c = 'Test';
        eaiLog.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        eaiLog.OF_SA_NOME_SERVIZIO__c = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_SERVIZIO__c = 'Test';
        eaiLog.EOF_Codice_Operatore__c = 'Test';
        eaiLog.EOF_Data_Notifica__c = System.today();
        eaiLog.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'Test';
        eaiLog.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        eaiLog.EOF_CODICE_PROGETTO_SPECIALE__c = 'Test';
        eaiLog.EOF_PROMOZIONE__c = 'Test';
        eaiLog.EOF_CLUSTER_PROMOZIONE__C = 'Test';
        eaiLog.EOF_NOTE__C = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__C = 'Test';
        eaiLog.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C = 'Test';
        eaiLog.EOF_RECAPITO_TEST_LINEA__C = 'Test';
        eaiLog.EOF_ID_Pop__c = 'Test';
        eaiLog.EOF_PROFILO__C = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog_t = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,
                                           EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                           EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                           EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,EOF_RECAPITO_TEST_LINEA__C,
                                           EOF_ID_Pop__c,EOF_PROFILO__C,EOF_ID_RISORSA__c
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test777'];
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t);
        
        test.startTest();
        OF_SA_GE_Utils.create_DeactivationToOM_Log(c,slList,asset_1);
        test.stopTest();
    } 
    
     //sl.recordtype.developername=='OF_SA_Cpe' 
    public static testmethod void MyUnitTest30()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        
        c.OF_SA_CODICE_MOTIVAZIONE__c = 'Test';
        c.OF_SA_MOTIVAZIONE__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Particella_Toponomastica_WS__c = 'Test';
        c.EOF_Indirizzo_WS__c = 'Test';
        c.EOF_Numero_Civico_WS__c = 'Test';
        c.OF_SA_ID_Building_OM__c = 'Test';
        c.EOF_GPON_Vincolante__c = 'Test';
        c.EOF_Opzione_System_Unico__c = 'Test';
        c.EOF_Collegamento_P2P__c = 'T';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        //eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test777';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.OF_SA_KIT_CONSEGNA_VLAN__c = 'Test';
        eaiLog.OF_SA_USER_VLAN__c = 'Test';
        eaiLog.OF_SA_SERVICE_VLAN__c  = 'Test';
        eaiLog.OF_SA_PROFILO_VLAN__C = 'Test';
        eaiLog.OF_SA_CUSTOMER_VLAN__C = 'Test';
        eaiLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_VLAN__c = 'Test';
        eaiLog.OF_SA_NOME_SERVIZIO__c = 'Test';
        eaiLog.OF_SA_INFORMAZIONI_SERVIZIO__c = 'Test';
        eaiLog.EOF_Codice_Operatore__c = 'Test';
        eaiLog.EOF_Data_Notifica__c = System.today();
        eaiLog.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'Test';
        eaiLog.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'Test';
        eaiLog.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        eaiLog.EOF_CODICE_PROGETTO_SPECIALE__c = 'Test';
        eaiLog.EOF_PROMOZIONE__c = 'Test';
        eaiLog.EOF_CLUSTER_PROMOZIONE__C = 'Test';
        eaiLog.EOF_NOTE__C = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__C = 'Test';
        eaiLog.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C = 'Test';
        eaiLog.EOF_RECAPITO_TEST_LINEA__C = 'Test';
        eaiLog.EOF_ID_Pop__c = 'Test';
        eaiLog.EOF_PROFILO__C = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_TIPOLOGIA_APPARATO__C = 'Test';
        eaiLog.OF_SA_ID_APPARATO__C = 'Test';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog_t = [SELECT recordtype.developername,Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,OF_SA_VLan_Log__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                           EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Stato_Richiesta__c,RecordTypeId,
                                           EOF_GPON_Attestazione__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                           EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_Codice_Motivazione__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,
                                           OF_SA_CUSTOMER_VLAN__C,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_INFORMAZIONI_VLAN__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,
                                           EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                           EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                           EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,EOF_RECAPITO_TEST_LINEA__C,
                                           EOF_ID_Pop__c,EOF_PROFILO__C,EOF_ID_RISORSA__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ID_APPARATO__C
                                           FROM EOF_EAI_Service_Log__c Where EOF_Nome_Cliente__c = 'Test777'];
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog_t);
        
        test.startTest();
        OF_SA_GE_Utils.create_DeactivationToOM_Log(c,slList,asset_1);
        test.stopTest();
    } 
    
    //for method dateToStringNoTime
     public static testmethod void MyUnitTest31()
     {
        test.startTest();
        Date dt = System.today();
        OF_SA_GE_Utils.dateToStringNoTime(dt);
        test.stopTest();
        
     }
    
    //for method CreateTemlogOM
    public static testmethod void MyUnitTest32(){
        
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
        OF_SA_GE_Utils.create_EAI_Log( Notify );
        OF_SA_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_SA_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_SA_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_SA_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_SA_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_SA_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        Notify.STATO_ORDINE ='0';
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        Notify.STATO_ORDINE ='1';
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        Notify.STATO_ORDINE ='2';
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        Notify.STATO_ORDINE ='3';
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        Notify.STATO_ORDINE ='4';
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        Notify.STATO_ORDINE ='5';
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        Notify.STATO_ORDINE ='6';
        OF_SA_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();        
    }
    
    //for method getQuery
    public static testmethod void MyUnitTest33(){
                
        test.startTest();
        
        OF_SA_GE_Utils.getQuery('case','AsyncActivation');
        OF_SA_GE_Utils.getQuery('case','AsyncDeactivation');
        
        OF_SA_GE_Utils.getQuery('sl','AsyncActivation');
        OF_SA_GE_Utils.getQuery('sl','AsyncDeactivation');
        
        OF_SA_GE_Utils.getQuery('asset','AsyncDeactivation');
        
        test.stopTest();        
    }
    
    //for method controlloVendibilita
    public static testmethod void MyUnitTest34()
    {
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;         
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_GE_Utils.controlloVendibilita('WN','123');
        test.stopTest();
    }
   
  
}
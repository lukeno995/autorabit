@istest
public class OF_SA_CD_OLO_SendToOM_TEST {

    public static TestMethod Void metodo1(){
        
        TestDataFactory.CreateTestRecords(null, null, null);
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - Deactivation';
        eof.EOF_CODICE_OPERATORE__c = 'test1';
        eof.EOF_CODICE_ORDINE_OLO__c = 'test1';
        eof.EOF_CODICE_ORDINE_EOF__c = 'test1';
        //  eof.EOF_DATA_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_STATO_ORDINE__c = 'test1';
        eof.EOF_CODICE_MOTIVAZIONE__c = 'test1';
        eof.EOF_MOTIVAZIONE__c = 'test1';
        eof.EOF_GPON_Attestazione__c = 'test1';
        eof.EOF_NOME_CLIENTE__c = 'test1';
        eof.EOF_COGNOME_CLIENTE__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1';
        eof.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.Today();
        eof.EOF_ORARIO_APPUNTAMENTO__c = 'test1';
        eof.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1';
        eof.EOF_NOTE__c = 'test1';
        eof.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_EMAIL_REFERENTE_TECNICO_OLO__c  = 'test1';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1';
        eof.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1';
        eof.EOF_ID_Case_Temp__c = 'test1';
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        String eofStr;

        insert eof;
        eofStr = String.valueOf(eof.Id);
        
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        OF_SA_CD_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.caseOriginale=new Case();
        Insert OF_SA_CD_GE_Utils.caseOriginale;
        OF_SA_CD_GE_Utils.slSFOM.caso__c=OF_SA_CD_GE_Utils.caseOriginale.Id;
        
        Test.startTest();
        // Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofStr);
        //Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        //OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofStr);
        Test.stopTest();
    }
    
    public static TestMethod Void metodo2(){

        TestDataFactory.CreateTestRecords(null, null, null);
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = true;
        insert c;
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.EOF_CODICE_OPERATORE__c = 'test1';
        eof.EOF_CODICE_ORDINE_OLO__c = 'test1';
        eof.EOF_CODICE_ORDINE_EOF__c = 'test1';
        //  eof.EOF_DATA_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_STATO_ORDINE__c = 'test1';
        eof.EOF_CODICE_MOTIVAZIONE__c = 'test1';
        eof.EOF_MOTIVAZIONE__c = 'test1';
        eof.EOF_GPON_Attestazione__c = 'test1';
        eof.EOF_NOME_CLIENTE__c = 'test1';
        eof.EOF_COGNOME_CLIENTE__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1';
        eof.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.Today();
        eof.EOF_ORARIO_APPUNTAMENTO__c = 'test1';
        eof.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1';
        eof.EOF_NOTE__c = 'test1';
        eof.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_EMAIL_REFERENTE_TECNICO_OLO__c  = 'test1';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1';
        eof.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1';
        eof.EOF_ID_Case_Temp__c = c.id;
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        String eofStr;

        insert eof;
        eofStr = String.valueOf(eof.Id);
        
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        OF_SA_CD_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.caseOriginale=new Case();
        
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivation(eoflst);
        //OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivationNew(eoflst);
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestDeactivationNew(eoflst);

        // OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivationNew_GPONP(eoflst);
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivation(eoflst);
        Test.stopTest();
    }
    
    public static TestMethod Void metodo3(){

        TestDataFactory.CreateTestRecords(null, null, null);
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        insert c;
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Activation';
        eof.EOF_CODICE_OPERATORE__c = 'test1';
        eof.EOF_CODICE_ORDINE_OLO__c = 'test1';
        eof.EOF_CODICE_ORDINE_EOF__c = 'test1';
        //  eof.EOF_DATA_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_STATO_ORDINE__c = 'test1';
        eof.EOF_CODICE_MOTIVAZIONE__c = 'test1';
        eof.EOF_MOTIVAZIONE__c = 'test1';
        eof.EOF_GPON_Attestazione__c = 'test1';
        eof.EOF_NOME_CLIENTE__c = 'test1';
        eof.EOF_COGNOME_CLIENTE__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1';
        eof.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.Today();
        eof.EOF_ORARIO_APPUNTAMENTO__c = 'test1';
        eof.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1';
        eof.EOF_NOTE__c = 'test1';
        eof.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_EMAIL_REFERENTE_TECNICO_OLO__c  = 'test1';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1';
        eof.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1';
        eof.EOF_ID_Case_Temp__c = c.id;
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        String eofStr;

        insert eof;
        eofStr = String.valueOf(eof.Id);
        
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        OF_SA_CD_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.caseOriginale=new Case();
       
        Test.startTest();

        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls()); 
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(eof);
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK()); 
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(eof);
        Test.stopTest();
        
    }
    
    public static TestMethod Void metodo4(){

        TestDataFactory.CreateTestRecords(null, null, null);
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        insert c;
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - ACK - Activation';
        eof.EOF_CODICE_OPERATORE__c = 'test1';
        eof.EOF_CODICE_ORDINE_OLO__c = 'test1';
        eof.EOF_CODICE_ORDINE_EOF__c = 'test1';
        //  eof.EOF_DATA_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_STATO_ORDINE__c = 'test1';
        eof.EOF_CODICE_MOTIVAZIONE__c = 'test1';
        eof.EOF_MOTIVAZIONE__c = 'test1';
        eof.EOF_GPON_Attestazione__c = 'test1';
        eof.EOF_NOME_CLIENTE__c = 'test1';
        eof.EOF_COGNOME_CLIENTE__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1';
        eof.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.Today();
        eof.EOF_ORARIO_APPUNTAMENTO__c = 'test1';
        eof.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1';
        eof.EOF_NOTE__c = 'test1';
        eof.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_EMAIL_REFERENTE_TECNICO_OLO__c  = 'test1';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1';
        eof.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1';
        eof.EOF_ID_Case_Temp__c = c.id;
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        String eofStr;

        insert eof;
        eofStr = String.valueOf(eof.Id);
        
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        OF_SA_CD_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.caseOriginale=new Case();
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls()); 
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK()); 
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
        Test.stopTest();
        
    }
    public static TestMethod Void metodo5(){
        
        TestDataFactory.CreateTestRecords(null, null, null);
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - Deactivation';
        eof.EOF_CODICE_OPERATORE__c = 'test1';
        eof.EOF_CODICE_ORDINE_OLO__c = 'test1';
        eof.EOF_CODICE_ORDINE_EOF__c = 'test1';
        //  eof.EOF_DATA_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_STATO_ORDINE__c = 'test1';
        eof.EOF_CODICE_MOTIVAZIONE__c = 'test1';
        eof.EOF_MOTIVAZIONE__c = 'test1';
        eof.EOF_GPON_Attestazione__c = 'test1';
        eof.EOF_NOME_CLIENTE__c = 'test1';
        eof.EOF_COGNOME_CLIENTE__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1';
        eof.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.Today();
        eof.EOF_ORARIO_APPUNTAMENTO__c = 'test1';
        eof.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1';
        eof.EOF_NOTE__c = 'test1';
        eof.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_EMAIL_REFERENTE_TECNICO_OLO__c  = 'test1';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1';
        eof.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1';
        eof.EOF_ID_Case_Temp__c = 'test1';
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        String eofStr;

        insert eof;
        eofStr = String.valueOf(eof.Id);
        
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        OF_SA_CD_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.caseOriginale=new Case();
        Insert OF_SA_CD_GE_Utils.caseOriginale;
        OF_SA_CD_GE_Utils.slSFOM.caso__c=OF_SA_CD_GE_Utils.caseOriginale.Id;
        
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eoflst);
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eoflst);
        Test.stopTest();
        
    }
    public static TestMethod Void metodo6(){

        TestDataFactory.CreateTestRecords(null, null, null);
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = true;
        insert c;
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.EOF_CODICE_OPERATORE__c = 'test1';
        eof.EOF_CODICE_ORDINE_OLO__c = 'test1';
        eof.EOF_CODICE_ORDINE_EOF__c = 'test1';
        //  eof.EOF_DATA_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_STATO_ORDINE__c = 'test1';
        eof.EOF_CODICE_MOTIVAZIONE__c = 'test1';
        eof.EOF_MOTIVAZIONE__c = 'test1';
        eof.EOF_GPON_Attestazione__c = 'test1';
        eof.EOF_NOME_CLIENTE__c = 'test1';
        eof.EOF_COGNOME_CLIENTE__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1';
        eof.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.Today();
        eof.EOF_ORARIO_APPUNTAMENTO__c = 'test1';
        eof.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1';
        eof.EOF_NOTE__c = 'test1';
        eof.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_EMAIL_REFERENTE_TECNICO_OLO__c  = 'test1';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1';
        eof.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1';
        eof.EOF_ID_Case_Temp__c = c.id;
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        String eofStr;

        insert eof;
        eofStr = String.valueOf(eof.Id);
        
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        /*
        OF_GPONP_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_GPONP_GE_Utils.caseOriginale=new Case();
        */
        
        Test.startTest();
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito='1';
        //OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivationNew_GPONP(eoflst);
        Test.stopTest();
        
    }
     public static TestMethod Void metodo7(){
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;

        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.Caso__c = c.id;
        insert eof;
       
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
       // insert eoflst;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        /*
        OF_GPONP_GE_Utils.slSFOM=eof;
        OF_GPONP_GE_Utils.caseOriginale=c;
       */
       // OF_SA_CD_GE_Utils.slSFOM=eof;
       // OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Test.startTest();
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito='1';
        //OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivationNew_GPONP(eoflst);
        //OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivation(eoflst);
        Test.stopTest();
        
    }
         public static TestMethod Void metodo8(){
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;

        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.Caso__c = c.id;
        insert eof;
       
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
       
        OF_SA_CD_GE_Utils.slSFOM=eof;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Test.startTest();
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito='1';
       
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivation(eoflst);
       Test.stopTest();
        
    }
    public static TestMethod Void metodo9(){
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;

        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.Caso__c = c.id;
        insert eof;
       
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
       
        OF_SA_CD_GE_Utils.slSFOM=eof;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Test.startTest();
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito='1';
       
        //OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivation_ChOrd(c,eoflst);

        Test.stopTest();
        
    }
    
    public static TestMethod Void metodo10(){
    
        List<RecordType> orderrtypes = [Select Name, Id From RecordType 
                                        where sObjectType='Order' 
                                        and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
         OrderRecordTypes.put(rt.Name,rt.Id); 
        
        Account acc = new account();
        acc.name = 'Vodafone';
        acc.EOF_Codice_operatore__c = 'VF';
        acc.Type = 'OLO';
        insert acc;
        
        case c = new case();
        c.EOF_account_olo__c = acc.id;
        c.OF_Bonifica_Locked_Row__c = True;
        c.OF_SA_Profilo__c = '202';
        c.status = 'Modificato OK';
        insert c;

        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OM - NACK - Deactivation';
        eof.Caso__c = c.id;
        insert eof;
       
        List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
        eoflst.add(eof);
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Cessato';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        //OF_DataAttivazione2__c
        asset_1.OF_DataAttivazione2__c=datetime.now();
        //asset_1.OF_Contract__c = contratto1.id;
        insert asset_1;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio1;
        servizio.OF_DataFineValidita__c = fine1;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='test';
        //servizio.OF_Durata_Servizio__c=4.2; 
        insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        ce.name = 'Servizio Verticale';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio2;
        ce.OF_DataFineValidita__c = fine2;
        ce.OF_Servizio__c = servizio.id;
        ce.OF_Commercial_Element_Code__c='test';
        insert ce;
        
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Na'; 
        va.Civico__c = '34';
        va.Comune__c = 'Mi';
        va.Provincia__c='te';
        va.UI_Scala_Palazzina__c=2.4;
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001'; 
        va.ID_GIS_Scala_Palazzina__c = 'IDR1234'; 
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Asset__c=asset_1.id;
        
        insert va;
         
        List<OF_CommercialElementIstanziato__c> ceis = new  List<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String CeiRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.RecordTypeId=CeiRecordTypeId;
        CEI.OF_DataAttivazione__c=DATETIME.now();
        CEI.Asset_Verticale__c=va.id;
        CEI.OF_Case__c=c.ID;
        
        ceis.add(CEI);   
        
        Order ordine = new Order();
        String orderRecordTypeId = Schema.SObjectType.order.getRecordTypeInfosByName().get('CHANGE ORDER').getRecordTypeId();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        //ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.RecordType=OrderRecordTypes;
        insert ordine;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';
        insert contratto;
        
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = Contratto.Id;
        cs.OF_Servizio__c = servizio.Id;
        insert cs;
       
        OF_SA_CD_GE_Utils.slSFOM=eof;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Test.startTest();
        OF_SA_WS_OM_Response.Esito_element respTemp = new OF_SA_WS_OM_Response.Esito_element();
        respTemp.Esito='1';
        
        OF_CO_GE_Utils.RTMap = new  map<String,String>();
       
        OF_SA_CD_OLO_SendToOM.OM_CreateAckNackRequestActivation_ChOrd(c,ceis);

        Test.stopTest();
    }
 }
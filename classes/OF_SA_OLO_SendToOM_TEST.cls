@istest
public class OF_SA_OLO_SendToOM_TEST {

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
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.caseOriginale=new Case();
        Insert OF_SA_GE_Utils.caseOriginale;
        OF_SA_GE_Utils.slSFOM.caso__c=OF_SA_GE_Utils.caseOriginale.Id;
        
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofStr);
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofStr);
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
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.caseOriginale=new Case();
        
       
        Test.startTest();
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestActivation(eoflst);
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestActivation(eoflst);
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
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.caseOriginale=new Case();
       
		Test.startTest();

		Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls()); 
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(eof);
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK()); 
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(eof);
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
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.caseOriginale=new Case();
       
        Test.startTest();
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls()); 
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK()); 
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
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
        
        OF_SA_GE_Utils.slSFOM=new EOF_EAI_Service_Log__c();
        OF_SA_GE_Utils.caseOriginale=new Case();
        Insert OF_SA_GE_Utils.caseOriginale;
        OF_SA_GE_Utils.slSFOM.caso__c=OF_SA_GE_Utils.caseOriginale.Id;
        
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eoflst);
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
		OF_SA_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eoflst);
       	Test.stopTest();
        
    }
 
}
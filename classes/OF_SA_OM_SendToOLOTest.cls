@isTest
global class OF_SA_OM_SendToOLOTest {
    global static TestMethod Void MyUnitTest1(){
    	
    	TestDataFactory.CreateTestRecords(null,null,null);
        
        Test.startTest();
        // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c; 
        OF_SA_GE_Utils.caseOriginale=c;
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OLO - StatusUpdate';
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
        eof.EOF_ID_Case_Temp__c = c.Id;
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        EOF_EAI_Service_Log__c eof1 =  new EOF_EAI_Service_Log__c( );
         eof1.EOF_Tipo_Comunicazione_String__C ='CPE';
        eof1.EOF_CODICE_OPERATORE__c = 'test1' ;
        eof1.EOF_CODICE_ORDINE_OLO__c  = 'test1' ;            
        eof1.EOF_CODICE_ORDINE_EOF__c = 'test1' ;
        eof1.EOF_DATA_NOTIFICA__c = System.today();
        eof1.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof1.EOF_STATO_ORDINE__c = 'test1' ; 
        eof1.EOF_CODICE_MOTIVAZIONE__c = 'test1' ;
        eof1.EOF_MOTIVAZIONE__c = 'test1' ;
        eof1.EOF_NOME_CLIENTE__c = 'test1' ;
        eof1.EOF_COGNOME_CLIENTE__c  = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1' ;
        eof1.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.today();
        eof1.EOF_ORARIO_APPUNTAMENTO__c = 'test1' ; 
        eof1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1' ;
        eof1.EOF_NOTE__c = 'test1' ;
        eof1.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c  = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1' ;
        eof1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1' ;
        eof1.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1' ;
        eof1.EOF_PROMOZIONE__c = 'test1' ;
        eof1.EOF_CLUSTER_PROMOZIONE__c = 'test1' ;
        eof1.EOF_ID_BUILDING__c = 'test1' ;
        eof1.EOF_SCALA_PALAZZINA__c = 'test1' ;
        eof1.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1' ;
        eof1.EOF_RECAPITO_TEST_LINEA__c = 'test1' ;
        eof1.EOF_ID_POP__c = 'test1' ;
        eof1.EOF_PROFILO__c = 'test1' ;
        eof1.EOF_SORGENTE__c = 'test1' ; 
        eof1.EOF_SLA_DATE__c = 'test1' ;
        eof1.EOF_GPON_ATTESTAZIONE__c = 'test1' ;
        eof1.EOF_GPON_VINCOLANTE__c = 'test1' ;
        eof1.EOF_ID_RISORSA__c = 'test1' ;
        eof1.EOF_OPZIONE_SYSTEM_UNICO__c = 'test1' ;
        eof1.EOF_TIPO_COMUNICAZIONE__c = 'test1' ;
        eof1.EOF_COLLEGAMENTO_P2P__c = 'test1' ;
        eof1.EOF_TRACCIATO__c = 'test1' ;
        eof1.EOF_ID_SERVIZIO__c = 'test1' ; 
        eof1.EOF_PROVINCIA__c = 'test1' ; 
        eof1.EOF_COMUNE__c = 'test1' ;
        eof1.EOF_INDIRIZZO__c = 'test1' ;
        eof1.EOF_NUMERO_CIVICO__c = 'test1' ;
        eof1.EOF_PARTICELLA_TOPONOMASTICA__c = 'test1' ;
        eof1.EOF_SLA_PREMIUM_ASSURANCE__c = 'test1' ;
        eof1.EOF_ID_Case_Temp__c = c.Id ;
        eof1.EOF_Tipo_Comunicazione_String__c = 'test1' ;
        //EOF_ID_Case_Temp__c
        
        
        String eofStr;
        String eofStr1;
        try
        {
            insert eof;
            insert eof1;
            eofStr = String.valueOf(eof.Id);
            eofStr1 = String.valueOf(eof1.Id);
            
            List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
            eoflst.add(eof);
            
            /**Step1**/
            Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
            OF_SA_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate( eof);
            
            eof1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - Deactivation' ;
            update eof1;
            String eofStr01 = String.valueOf(eof1.Id);
            OF_SA_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate( eof1 );
                      
          Test.stopTest();

            
        }
        catch(exception e){
            system.debug('error message----->'+e.getStackTraceString());
        }  
    }
    global static TestMethod Void MyUnitTest2()
    {
        TestDataFactory.CreateTestRecords(null,null,null);
        // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        
         EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OLO - StatusUpdate';
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
        eof.EOF_ID_Case_Temp__c = c.Id;
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ;
        
        EOF_EAI_Service_Log__c eof1 =  new EOF_EAI_Service_Log__c( );
        eof1.EOF_Tipo_Comunicazione_String__C ='CPE';
        eof1.EOF_CODICE_OPERATORE__c = 'test1' ;
        eof1.EOF_CODICE_ORDINE_OLO__c  = 'test1' ;            
        eof1.EOF_CODICE_ORDINE_EOF__c = 'test1' ;
        eof1.EOF_DATA_NOTIFICA__c = System.today();
        eof1.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof1.EOF_STATO_ORDINE__c = 'test1' ; 
        eof1.EOF_CODICE_MOTIVAZIONE__c = 'test1' ;
        eof1.EOF_MOTIVAZIONE__c = 'test1' ;
        eof1.EOF_NOME_CLIENTE__c = 'test1' ;
        eof1.EOF_COGNOME_CLIENTE__c  = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1' ;
        eof1.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.today();
        eof1.EOF_ORARIO_APPUNTAMENTO__c = 'test1' ; 
        eof1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1' ;
        eof1.EOF_NOTE__c = 'test1' ;
        eof1.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c  = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1' ;
        eof1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1' ;
        eof1.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1' ;
        eof1.EOF_PROMOZIONE__c = 'test1' ;
        eof1.EOF_CLUSTER_PROMOZIONE__c = 'test1' ;
        eof1.EOF_ID_BUILDING__c = 'test1' ;
        eof1.EOF_SCALA_PALAZZINA__c = 'test1' ;
        eof1.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1' ;
        eof1.EOF_RECAPITO_TEST_LINEA__c = 'test1' ;
        eof1.EOF_ID_POP__c = 'test1' ;
        eof1.EOF_PROFILO__c = 'test1' ;
        eof1.EOF_SORGENTE__c = 'test1' ; 
        eof1.EOF_SLA_DATE__c = 'test1' ;
        eof1.EOF_GPON_ATTESTAZIONE__c = 'test1' ;
        eof1.EOF_GPON_VINCOLANTE__c = 'test1' ;
        eof1.EOF_ID_RISORSA__c = 'test1' ;
        eof1.EOF_OPZIONE_SYSTEM_UNICO__c = 'test1' ;
        eof1.EOF_TIPO_COMUNICAZIONE__c = 'test1' ;
        eof1.EOF_COLLEGAMENTO_P2P__c = 'test1' ;
        eof1.EOF_TRACCIATO__c = 'test1' ;
        eof1.EOF_ID_SERVIZIO__c = 'test1' ; 
        eof1.EOF_PROVINCIA__c = 'test1' ; 
        eof1.EOF_COMUNE__c = 'test1' ;
        eof1.EOF_INDIRIZZO__c = 'test1' ;
        eof1.EOF_NUMERO_CIVICO__c = 'test1' ;
        eof1.EOF_PARTICELLA_TOPONOMASTICA__c = 'test1' ;
        eof1.EOF_SLA_PREMIUM_ASSURANCE__c = 'test1' ;
        eof1.EOF_ID_Case_Temp__c = c.Id ;
        eof1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - Deactivation' ;
        
        insert eof;
        insert eof1;
        
        String eofStr = String.valueOf(eof.Id);
        String eofStr1 = String.valueOf(eof1.Id);
        OF_SA_GE_Utils.slSFOLO=eof;
		Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        OF_SA_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate( eof);
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate( eof);
        Test.stopTest();
       
    }
    
    global static TestMethod Void MyUnitTest3()
    {
    	TestDataFactory.CreateTestRecords(null,null,null);
      // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate var = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        var.CODICE_OPERATORE='TIS';
        var.CODICE_ORDINE_OLO='1234';
        var.CODICE_ORDINE_OF='12';
        var.DATA_NOTIFICA=String.valueOf(system.now());
        var.ID_NOTIFICA='test';
        var.STATO_ORDINE='test';
        var.CODICE_MOTIVAZIONE='test';
        var.MOTIVAZIONE='test';
        var.GPON_DI_ATTESTAZIONE='test';
        var.NOME_CLIENTE='test';
        var.COGNOME_CLIENTE='test';
        var.RECAPITO_TELEFONICO_CLIENTE='test';
        var.DATA_PREVISTA_ATTIVAZIONE=String.valueOf(system.now());
        var.ORARIO_APPUNTAMENTO='18:00:00';
        var.PIN_INTERVENTO_A_VUOTO='test';
        var.NOTE='test';
        var.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        var.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>(); 
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        OF_SA_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM( c , var );
        Test.stopTest();
    }

    global static TestMethod Void MyUnitTest4()
    {
    	TestDataFactory.CreateTestRecords(null,null,null);
      // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate var = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        var.CODICE_OPERATORE='TIS';
        var.CODICE_ORDINE_OLO='1234';
        var.CODICE_ORDINE_OF='12';
        var.DATA_NOTIFICA=String.valueOf(system.now());
        var.ID_NOTIFICA='test';
        var.STATO_ORDINE='test';
        var.CODICE_MOTIVAZIONE='test';
        var.MOTIVAZIONE='test';
        var.GPON_DI_ATTESTAZIONE='test';
        var.NOME_CLIENTE='test';
        var.COGNOME_CLIENTE='test';
        var.RECAPITO_TELEFONICO_CLIENTE='test';
        var.DATA_PREVISTA_ATTIVAZIONE=String.valueOf(system.now());
        var.ORARIO_APPUNTAMENTO='18:00:00';
        var.PIN_INTERVENTO_A_VUOTO='test';
        var.NOTE='test';
        var.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        var.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>(); 
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());        
        OF_SA_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM( c , var );
        Test.stopTest();
    }
    
    global static TestMethod Void MyUnitTest5()
    {
    	TestDataFactory.CreateTestRecords(null,null,null);
      // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule var = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        var.CODICE_OPERATORE='TIS';
        var.CODICE_ORDINE_OLO='1234';
        var.CODICE_ORDINE_OF='12';
        var.DATA_NOTIFICA=String.valueOf(system.now());
        var.ID_NOTIFICA='test';
        var.CODICE_MOTIVAZIONE='test';
        var.MOTIVAZIONE='test';
        var.NOME_CLIENTE='test';
        var.COGNOME_CLIENTE='test';
        var.DATA_PREVISTA_ATTIVAZIONE=String.valueOf(system.now());
        var.ORARIO_APPUNTAMENTO='18:00:00';
        var.NOTE='test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        OF_SA_OM_SendToOLO.OM_CreateAckNackReschedule( c , var );
        Test.stopTest();
    }
    global static TestMethod Void MyUnitTest6()
    {
    	TestDataFactory.CreateTestRecords(null,null,null);
      // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule var = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        var.CODICE_OPERATORE='TIS';
        var.CODICE_ORDINE_OLO='1234';
        var.CODICE_ORDINE_OF='12';
        var.DATA_NOTIFICA=String.valueOf(system.now());
        var.ID_NOTIFICA='test';
        var.CODICE_MOTIVAZIONE='test';
        var.MOTIVAZIONE='test';
        var.NOME_CLIENTE='test';
        var.COGNOME_CLIENTE='test';
        var.DATA_PREVISTA_ATTIVAZIONE=String.valueOf(system.now());
        var.ORARIO_APPUNTAMENTO='18:00:00';
        var.NOTE='test';

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());        
        OF_SA_OM_SendToOLO.OM_CreateAckNackReschedule( c , var );
        Test.stopTest();
    }
    global static TestMethod Void MyUnitTest7()
    {
    	TestDataFactory.CreateTestRecords(null,null,null);
      // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder var = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        var.CODICE_OPERATORE='TIS';
        var.CODICE_ORDINE_OLO='1234';
        var.CODICE_ORDINE_OF='12';
        var.DATA_NOTIFICA=String.valueOf(system.now());
        var.ID_NOTIFICA='test';
        var.CODICE_MOTIVAZIONE='test';
        var.MOTIVAZIONE='test';
       
        var.NOTE='test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        OF_SA_OM_SendToOLO.OM_CreateAckNackCompletionOrder( c , var );
        Test.stopTest();
    }
    global static TestMethod Void MyUnitTest8()
    {
    	TestDataFactory.CreateTestRecords(null,null,null);
      // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c;
        OF_SA_GE_Utils.caseOriginale=c;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder var = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        var.CODICE_OPERATORE='TIS';
        var.CODICE_ORDINE_OLO='1234';
        var.CODICE_ORDINE_OF='12';
        var.DATA_NOTIFICA=String.valueOf(system.now());
        var.ID_NOTIFICA='test';
        var.CODICE_MOTIVAZIONE='test';
        var.MOTIVAZIONE='test';
        
        var.NOTE='test';

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());        
        OF_SA_OM_SendToOLO.OM_CreateAckNackCompletionOrder( c , var );
        Test.stopTest();
    }
    
	/*public static testMethod void CodeCoverage(){
    	test.starttest();
		OF_SA_OM_SendToOLO.CodeCoverage(2);
		test.stoptest();
    }*/
    
}
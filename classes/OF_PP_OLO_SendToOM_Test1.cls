@isTest
public class OF_PP_OLO_SendToOM_Test1{
@testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    public static testMethod void OM_CreateAckNackRequestActivation_0(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - ACK').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_PP_VLAN_ACK',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap;
        // Test.startTest();
        // Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock ());
        OF_PP_OLO_SendToOM.OM_CreateAckNackRequestActivation(eofList);
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock());
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(eof);
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
        Test.stopTest();
    }

    
    public static testMethod void OM_CreateAckNackRequestActivation_1(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.OF_Bonifica_Locked_Row__c = false;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - NACK').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'KO';
        eof.EOF_ID_Notifica__c = 'test_01';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_PP_VLAN_NACK',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap;
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock1());
        OF_PP_OLO_SendToOM.OM_CreateAckNackRequestActivation(eofList);
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(eof);
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
        Test.stopTest();
    }
    
    /*
    public static testMethod void AsyncChecksMethod1(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
        
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - ACK').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_PP_VLAN_ACK',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap; 
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock1());
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(eof);
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
        Test.stopTest();
    }
    
        public static testMethod void AsyncChecksMethod2(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
        
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - ACK').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_PP_VLAN_ACK',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap;
       // Test.startTest();
       // Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock ());
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock());
      
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
        Test.stopTest();
    }
        public static testMethod void AsyncChecksMethod3(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
        
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - ACK').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_PP_VLAN_ACK',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap;
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock1());
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestReschedule(eof);
        Test.stopTest();
    }
    public static testMethod void AsyncChecksMethod4(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
        
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        eof.EOF_Richiesta_Notifica__c = 'Test';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        slFiberReq.EOF_Richiesta_Notifica__c = 'Test';
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_SA_FiberRequest',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap;
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock());
      
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofList);
        Test.stopTest();
    }
    
        public static testMethod void AsyncChecksMethod5(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
        
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        eof.EOF_Richiesta_Notifica__c = 'Test';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        slFiberReq.EOF_Richiesta_Notifica__c = 'Test';
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        //OF_SA_GE_Utils.slSFOM = slfiberReq;
        
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_SA_FiberRequest',EofRecordType);
        //OF_SA_GE_Utils.rtMap = rtMap;
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock1());
      
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofList);
        Test.stopTest();
    }
    
        public static testMethod void AsyncChecksMethod6(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
        
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        eof.Caso__c = c.id;
        eof.EOF_Richiesta_Notifica__c = 'Test';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        slFiberReq.EOF_Richiesta_Notifica__c = 'Test';
        slFiberReq.Caso__c = c.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        //OF_SA_GE_Utils.slSFOM = slfiberReq;
        OF_PP_GE_Utils.slSFOM = slfiberReq;
        
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_SA_FiberRequest',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap;
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock());
      
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofList[0].id);
        Test.stopTest();
    }
    
       public static testMethod void AsyncChecksMethod7(){
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
        
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        eof.Caso__c = c.id;
        eof.EOF_Richiesta_Notifica__c = 'Test';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        slFiberReq.EOF_Richiesta_Notifica__c = 'Test';
        slFiberReq.Caso__c = c.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_SA_FiberRequest',EofRecordType);
        OF_PP_GE_Utils.rtMap = rtMap;
       
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_PP_OLO_SendToOM_mock1());
      
        //OF_PP_OLO_SendToOM.OM_CreateAckNackRequestDeactivation(eofList[0].id);
        Test.stopTest();
    }    
    */
}
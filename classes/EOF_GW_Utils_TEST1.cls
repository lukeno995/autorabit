@isTest

public class EOF_GW_Utils_TEST1{

 public static testmethod void EOFGWUtil_TestInitialLines(){
  
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        frequest.TIPO_COMUNICAZIONE = '2';
    
        //-----insert EAI Service Log------
    
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
     
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');       
        //EOF_GW_Utils.checkSync(frequest);
        EOF_GW_WS_Request.FiberRequest frequest1 = new EOF_GW_WS_Request.FiberRequest();
        frequest1.TIPO_COMUNICAZIONE = '2';
        frequest1.CODICE_ORDINE_OLO = '02112016_37_12345678'; 
        //EOF_GW_Utils.checkSync(frequest1);
        Test.stopTest(); 
     }
     //-------------- Tipo Comm Equals 2---------------

 public static testmethod void EOFGWUtil_TestTipoCommEquals2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
    
     EOF_GW_Utils.checkSync(frequest);
        
   
     EOF_GW_WS_Request.FiberRequest frequest1 = new EOF_GW_WS_Request.FiberRequest();
     frequest1.TIPO_COMUNICAZIONE = '2';
     frequest1.CODICE_OPERATORE = 'VF';
     frequest1.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test_RECAPITO_TELEFONICO_CLIENTE_1';
     frequest1.COGNOME_CLIENTE = 'Test';
     //EOF_GW_Utils.checkSync(frequest1);
       
     Test.stopTest(); 
     }
     
     //-------Tipo Comm equals 2----
     public static testmethod void EOFGWUtil_TestTipoCommEquals2Extended(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
      frequest.ID_NOTIFICA = '';
     //EOF_GW_Utils.checkSync(frequest);
     frequest.ID_NOTIFICA = 'test_01';
     frequest.CODICE_OPERATORE = 'OT';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.CODICE_OPERATORE = 'VF';
     frequest.COGNOME_CLIENTE = 'abc';
     frequest.DATA_PREVISTA_ATTIVAZIONE = null;
     EOF_GW_Utils.checkSync(frequest); 
     frequest.DATA_NOTIFICA = null;
     EOF_GW_Utils.checkSync(frequest); 
     frequest.DATA_NOTIFICA = String.valueOf(system.today());
     frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
     frequest.ORARIO_APPUNTAMENTO = 'test';
     EOF_GW_Utils.checkSync(frequest);
     /* 
     frequest.ORARIO_APPUNTAMENTO = '';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.TIPO_COMUNICAZIONE = '3';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE = '';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE = 'abc';
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
     frequest.DATA_NOTIFICA = null;
     EOF_GW_Utils.checkSync(frequest); 
     frequest.DATA_NOTIFICA = String.valueOf(system.today());
     frequest.ORARIO_APPUNTAMENTO = 'test:12';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.TIPO_COMUNICAZIONE = '4'; 
     EOF_GW_Utils.checkSync(frequest); 
     frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
     EOF_GW_Utils.checkSync(frequest);
     
     //------Tipo Comm = 1---
     frequest.TIPO_COMUNICAZIONE = '1';
     EOF_GW_Utils.checkSync(frequest);
     frequest.DATA_PREVISTA_ATTIVAZIONE = null;
     EOF_GW_Utils.checkSync(frequest); 
     
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     */
      
     Test.stopTest(); 
     }
     
     public static testmethod void EOFGWUtil_TestTipoCommEquals2Extended2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
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
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE = '';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE = 'abc';
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     //EOF_GW_Utils.checkSync(frequest); 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
     frequest.DATA_NOTIFICA = null;
     EOF_GW_Utils.checkSync(frequest); 
     /*
     frequest.DATA_NOTIFICA = String.valueOf(system.today());
     frequest.ORARIO_APPUNTAMENTO = 'test:12';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.TIPO_COMUNICAZIONE = '4'; 
     EOF_GW_Utils.checkSync(frequest); 
     frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
     EOF_GW_Utils.checkSync(frequest);
     
     //------Tipo Comm = 1---
     frequest.TIPO_COMUNICAZIONE = '1';
     EOF_GW_Utils.checkSync(frequest);
     frequest.DATA_PREVISTA_ATTIVAZIONE = null;
     EOF_GW_Utils.checkSync(frequest); 
     
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     
      */
     Test.stopTest();  
     }
     
     public static testmethod void EOFGWUtil_TestTipoCommEquals2Extended2_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
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
     EOF_GW_Utils.checkSync(frequest); 
     frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
     EOF_GW_Utils.checkSync(frequest); 
     frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
     EOF_GW_Utils.checkSync(frequest);
     
     //------Tipo Comm = 1---
     frequest.TIPO_COMUNICAZIONE = '1';
     EOF_GW_Utils.checkSync(frequest);
     frequest.DATA_PREVISTA_ATTIVAZIONE = null;
     EOF_GW_Utils.checkSync(frequest); 
     
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     
      
     Test.stopTest(); 
     }
     
   //-----testing --------  
     public static testmethod void EOFGWUtil_TestTipoCommEquals11(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     EOF_GW_Utils.fr_tmp=frequest; 
     frequest.TIPO_COMUNICAZIONE = '11';
      //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
      c.EOF_Codice_Ordine_OLO__c = '02112016_38';
      c.Type = '1';
      update c;
      frequest.ID_NOTIFICA = 'test_01';
      frequest.CODICE_OPERATORE = 'VF';
      EOF_GW_Utils.checkSync(frequest); 
      frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
      EOF_GW_Utils.checkAsync(c);
      frequest.COGNOME_CLIENTE = 'test_01';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
      EOF_GW_Utils.checkAsync(c);
      /*
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
      frequest.DATA_NOTIFICA = null;
      EOF_GW_Utils.checkAsync(c);
      frequest.DATA_NOTIFICA = String.valueOf(system.today());
      frequest.IDENTIFICATIVO_DEL_POP = '';
      EOF_GW_Utils.checkAsync(c);
       
      frequest.IDENTIFICATIVO_DEL_POP = 'test';
      frequest.PROVINCIA = '';
      EOF_GW_Utils.checkAsync(c);
     
      frequest.PROVINCIA = 'test';
      frequest.COMUNE = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.COMUNE = 'test';
      frequest.INDIRIZZO = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.INDIRIZZO = 'Piazzale Gorini';
      frequest.NUMERO_CIVICO = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.NUMERO_CIVICO = '6';
      frequest.PARTICELLA_TOPONOMASTICA = '';
      EOF_GW_Utils.checkAsync(c);
     frequest.PARTICELLA_TOPONOMASTICA = '123';
      frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '';
      EOF_GW_Utils.checkAsync(c);
    /**   frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
      frequest.ID_BUILDING = '';
      EOF_GW_Utils.checkAsync(c); **/
      Test.stopTest(); 
     }  
     
     public static testmethod void EOFGWUtil_TestTipoCommEquals11_1(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     EOF_GW_Utils.fr_tmp=frequest; 
     frequest.TIPO_COMUNICAZIONE = '11';
      //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
      c.EOF_Codice_Ordine_OLO__c = '02112016_38';
      c.Type = '1';
      update c;
      frequest.ID_NOTIFICA = 'test_01';
      frequest.CODICE_OPERATORE = 'VF';
      EOF_GW_Utils.checkSync(frequest); 
      frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
      //EOF_GW_Utils.checkAsync(c);
      frequest.COGNOME_CLIENTE = 'test_01';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
      //EOF_GW_Utils.checkAsync(c);
      
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
      frequest.DATA_NOTIFICA = null;
      EOF_GW_Utils.checkAsync(c);
      frequest.DATA_NOTIFICA = String.valueOf(system.today());
      frequest.IDENTIFICATIVO_DEL_POP = '';
      EOF_GW_Utils.checkAsync(c);
      /* 
      frequest.IDENTIFICATIVO_DEL_POP = 'test';
      frequest.PROVINCIA = '';
      EOF_GW_Utils.checkAsync(c);
     
      frequest.PROVINCIA = 'test';
      frequest.COMUNE = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.COMUNE = 'test';
      frequest.INDIRIZZO = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.INDIRIZZO = 'Piazzale Gorini';
      frequest.NUMERO_CIVICO = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.NUMERO_CIVICO = '6';
      frequest.PARTICELLA_TOPONOMASTICA = '';
      EOF_GW_Utils.checkAsync(c);
     frequest.PARTICELLA_TOPONOMASTICA = '123';
      frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '';
      EOF_GW_Utils.checkAsync(c);
    /**   frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
      frequest.ID_BUILDING = '';
      EOF_GW_Utils.checkAsync(c); **/
      Test.stopTest(); 
     }  
    
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
       EOF_GW_Utils.fr_tmp=frequest; 
     frequest.TIPO_COMUNICAZIONE = '11';
      //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
      c.EOF_Codice_Ordine_OLO__c = '02112016_38';
      c.Type = '1';
      update c;
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
      EOF_GW_Utils.checkAsync(c);
      
      frequest.PROVINCIA = 'test';
      frequest.COMUNE = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.COMUNE = 'test';
      frequest.INDIRIZZO = '';
      EOF_GW_Utils.checkAsync(c);
      frequest.INDIRIZZO = 'Piazzale Gorini';
      frequest.NUMERO_CIVICO = '';
      EOF_GW_Utils.checkAsync(c);
      /*
      frequest.NUMERO_CIVICO = '6';
      frequest.PARTICELLA_TOPONOMASTICA = '';
      EOF_GW_Utils.checkAsync(c);
     frequest.PARTICELLA_TOPONOMASTICA = '123';
      frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '';
      EOF_GW_Utils.checkAsync(c);
    /**   frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
      frequest.ID_BUILDING = '';
      EOF_GW_Utils.checkAsync(c); **/
      Test.stopTest(); 
     }  
     
      public static testmethod void EOFGWUtil_TestTipoCommEquals11_3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     EOF_GW_Utils.fr_tmp=frequest;  
     frequest.TIPO_COMUNICAZIONE = '11';
      //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
      c.EOF_Codice_Ordine_OLO__c = '02112016_38';
      c.Type = '1';
      update c;
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
      EOF_GW_Utils.checkAsync(c);
     frequest.PARTICELLA_TOPONOMASTICA = '123';
      frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '';
      EOF_GW_Utils.checkAsync(c);
    /**   frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234';
      frequest.ID_BUILDING = '';
      EOF_GW_Utils.checkAsync(c); **/
      Test.stopTest(); 
     }  
    //------Tipo Comm equals 11-----
    
    //-----testing --------  
     public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     EOF_GW_Utils.fr_tmp=frequest; 
     frequest.TIPO_COMUNICAZIONE = '11';
     //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '1';
     update c;
     EOF_GW_Utils.checkAsync(c);
     frequest.ID_BUILDING = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
     frequest.ID_BUILDING = '10_054_054039_8000064301_40';
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
     EOF_GW_Utils.checkAsync(c);
     
     frequest.COGNOME_REFERENTE_TECNICO_OLO = 'test';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '';
     //EOF_GW_Utils.checkAsync(c);
     /*
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = 'test';
     frequest.EMAIL_REFERENTE_TECNICO_OLO = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
     frequest.GPON_ATTESTAZIONE = 'test';
     frequest.GPON_VINCOLANTE = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.COLLEGAMENTO_P2P = '0';
     frequest.GPON_ATTESTAZIONE = '';
     frequest.GPON_VINCOLANTE = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.COLLEGAMENTO_P2P = '';
     frequest.TIPOLOGIA_SERVIZIO = '';
     frequest.SLA_PREMIUM_ASSURANCE = 'Z';
     EOF_GW_Utils.checkAsync(c);
     
     frequest.SLA_PREMIUM_ASSURANCE = '';
     frequest.APPARATO = 'F';
     EOF_GW_Utils.checkAsync(c);
     frequest.APPARATO = '';
     frequest.GPON_VINCOLANTE = 'Z';
     EOF_GW_Utils.checkAsync(c);
     frequest.GPON_VINCOLANTE = '';
     frequest.OPZIONE_SYSTEM_UNICO = 'V';
     EOF_GW_Utils.checkAsync(c);
     frequest.OPZIONE_SYSTEM_UNICO = '';
     frequest.TIPOLOGIA_SERVIZIO = 'OT';
     frequest.ORARIO_APPUNTAMENTO = '12:34';
     */
     Test.stopTest();
    } 
    
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     EOF_GW_Utils.fr_tmp=frequest; 
     frequest.TIPO_COMUNICAZIONE = '11';
     //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '1';
     update c;
     
     EOF_GW_Utils.checkAsync(c);
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
     EOF_GW_Utils.checkAsync(c);
     frequest.COLLEGAMENTO_P2P = '0';
     frequest.GPON_ATTESTAZIONE = '';
     frequest.GPON_VINCOLANTE = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.COLLEGAMENTO_P2P = '';
     frequest.TIPOLOGIA_SERVIZIO = '';
     frequest.SLA_PREMIUM_ASSURANCE = 'Z';
     EOF_GW_Utils.checkAsync(c);
     /*
     frequest.SLA_PREMIUM_ASSURANCE = '';
     frequest.APPARATO = 'F';
     EOF_GW_Utils.checkAsync(c);
     frequest.APPARATO = '';
     frequest.GPON_VINCOLANTE = 'Z';
     EOF_GW_Utils.checkAsync(c);
     frequest.GPON_VINCOLANTE = '';
     frequest.OPZIONE_SYSTEM_UNICO = 'V';
     EOF_GW_Utils.checkAsync(c);
     frequest.OPZIONE_SYSTEM_UNICO = '';
     frequest.TIPOLOGIA_SERVIZIO = 'OT';
     frequest.ORARIO_APPUNTAMENTO = '12:34';
     */
     Test.stopTest();
    } 
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended_3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     EOF_GW_Utils.fr_tmp=frequest; 
     frequest.TIPO_COMUNICAZIONE = '11';
     //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '1';
     update c;
     
     EOF_GW_Utils.checkAsync(c);
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
     EOF_GW_Utils.checkAsync(c);
     frequest.APPARATO = '';
     frequest.GPON_VINCOLANTE = 'Z';
     EOF_GW_Utils.checkAsync(c);
     frequest.GPON_VINCOLANTE = '';
     frequest.OPZIONE_SYSTEM_UNICO = 'V';
     EOF_GW_Utils.checkAsync(c);
     frequest.OPZIONE_SYSTEM_UNICO = '';
     frequest.TIPOLOGIA_SERVIZIO = 'OT';
     frequest.ORARIO_APPUNTAMENTO = '12:34';
     
     Test.stopTest();
    } 
    //-----testing --------  
     public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
      
     frequest.TIPO_COMUNICAZIONE = '11';
     EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '1';
     update c;
     EOF_GW_Utils.checkAsync(c);
     frequest.ORARIO_APPUNTAMENTO = system.today()+'';
     EOF_GW_Utils.checkAsync(c);
     /*
     frequest.ORARIO_APPUNTAMENTO = '';
     EOF_GW_Utils.checkAsync(c);
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_40';
     update netwrkInv;
     EOF_GW_Utils.checkAsync(c);
     netwrkInv.EOF_Stato_Building__c = 110;
     update netwrkInv;
     EOF_GW_Utils.checkAsync(c); 
     */
     Test.stopTest();
    } 
    
    public static testmethod void EOFGWUtil_TestTipoCommEquals11Extended2_1(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
 
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
      
     frequest.TIPO_COMUNICAZIONE = '11';
     EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '1';
     update c;
     //EOF_GW_Utils.checkAsync(c);
     frequest.ORARIO_APPUNTAMENTO = system.today()+'';
     //EOF_GW_Utils.checkAsync(c);
     
     frequest.ORARIO_APPUNTAMENTO = '';
     EOF_GW_Utils.checkAsync(c);
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_40';
     update netwrkInv;
     EOF_GW_Utils.checkAsync(c);
     netwrkInv.EOF_Stato_Building__c = 110;
     update netwrkInv;
     EOF_GW_Utils.checkAsync(c); 
     
     Test.stopTest();
    }
    
       //-----Case Type = 11-------------- 
     public static testmethod void EOFGWUtil_TestCTypeEquals11(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
      
     frequest.TIPO_COMUNICAZIONE = '11';
     EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '11';
     update c;
     frequest.DATA_NOTIFICA =  null;
     EOF_GW_Utils.checkAsync(c);
     frequest.DATA_NOTIFICA = String.valueOf(system.today());
     frequest.ID_RISORSA = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.ID_RISORSA = 'risorsa';
     frequest.APPARATO = 'Y';
     frequest.COGNOME_CLIENTE = '';
     EOF_GW_Utils.checkAsync(c);
     /*
     frequest.COGNOME_CLIENTE = 'testacc';
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     EOF_GW_Utils.checkAsync(c);
     frequest.APPARATO = 'K';
     EOF_GW_Utils.checkAsync(c);
     frequest.APPARATO = '';
     EOF_GW_Utils.checkAsync(c);
     objAsset.Status = 'Cessato';
     update objAsset;
     EOF_GW_Utils.checkAsync(c);
     EOF_GW_Utils.add_result_message(c,'Test');
     */
     Test.stopTest();
    } 
    
    public static testmethod void EOFGWUtil_TestCTypeEquals11_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
      
     frequest.TIPO_COMUNICAZIONE = '11';
     EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '11';
     update c;
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
     EOF_GW_Utils.checkAsync(c);
     frequest.APPARATO = 'K';
     EOF_GW_Utils.checkAsync(c);
     frequest.APPARATO = '';
     //EOF_GW_Utils.checkAsync(c);
     objAsset.Status = 'Cessato';
     update objAsset;
     //EOF_GW_Utils.checkAsync(c);
     //EOF_GW_Utils.add_result_message(c,'Test');
     
     Test.stopTest();
    }  
     
     public static testmethod void EOFGWUtil_TestCTypeEquals11_3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     EOF_GW_Utils.fr_tmp=frequest; 
     frequest.TIPO_COMUNICAZIONE = '11';
     //EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     c.EOF_Codice_Ordine_OLO__c = '02112016_38';
     c.Type = '11';
     update c;
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
     EOF_GW_Utils.checkAsync(c);
     objAsset.Status = 'Cessato';
     update objAsset;
     EOF_GW_Utils.checkAsync(c);
     EOF_GW_Utils.add_result_message(c,'Test');
     
     Test.stopTest();
    }
    //-----------Create Notify Test----------
    
    public static testmethod void EOFGWUtil_TestCreateNotify(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
     frequest.TIPO_COMUNICAZIONE = '11';
     EOF_GW_Utils.checkSync(frequest);  
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     EOF_GW_Utils.create_notify(c,5,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','B_K6','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','A_K14','sampleName');
     
     /*EOF_GW_Utils.create_notify(c,6,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,6,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,7,'OK','','sampleName');
     EOF_GW_Utils.create_notify(c,7,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,9,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,12,'OK','','');
     */
     Test.stopTest();
    }  
    
    public static testmethod void EOFGWUtil_TestCreateNotify_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
     frequest.TIPO_COMUNICAZIONE = '11';
     EOF_GW_Utils.checkSync(frequest);  
     /*
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     EOF_GW_Utils.create_notify(c,5,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','B_K6','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','A_K14','sampleName');
     */
     EOF_GW_Utils.create_notify(c,6,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,6,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,7,'OK','','sampleName');
     EOF_GW_Utils.create_notify(c,7,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,9,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,12,'OK','','');
     
     Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify1(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '12345678912345678912345456';
     EOF_GW_Utils.checkSync(frequest);
     /*
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     EOF_GW_Utils.create_notify(c,5,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','B_K6','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','A_K14','sampleName');
     EOF_GW_Utils.create_notify(c,6,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,6,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,7,'OK','','sampleName');
     EOF_GW_Utils.create_notify(c,7,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,9,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,12,'OK','','');
     */
     Test.stopTest();
    }  
    
     public static testmethod void EOFGWUtil_TestCreateNotify1_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      /*
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '12345678912345678912345456';
     EOF_GW_Utils.checkSync(frequest);
     */
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     EOF_GW_Utils.create_notify(c,5,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','B_K6','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','A_K14','sampleName');
     EOF_GW_Utils.create_notify(c,6,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,6,'KO','A_K1','sampleName');
     /*
     EOF_GW_Utils.create_notify(c,7,'OK','','sampleName');
     EOF_GW_Utils.create_notify(c,7,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,9,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,12,'OK','','');
     */
     Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify1_3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      /*
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '12345678912345678912345456';
     EOF_GW_Utils.checkSync(frequest);
     
     // frequest.CODICE_ORDINE_OLO = '02112016_38';
     EOF_GW_Utils.create_notify(c,5,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','B_K6','sampleName');
     EOF_GW_Utils.create_notify(c,5,'KO','A_K14','sampleName');
     EOF_GW_Utils.create_notify(c,6,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,6,'KO','A_K1','sampleName');
     */
     EOF_GW_Utils.create_notify(c,7,'OK','','sampleName');
     EOF_GW_Utils.create_notify(c,7,'KO','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,9,'OK','A_K1','sampleName');
     EOF_GW_Utils.create_notify(c,12,'OK','','');
     
     Test.stopTest();
    }
    public static testmethod void EOFGWUtil_TestCreateNotify2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     frequest.NOME_CLIENTE = '123456789';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '123456789';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     frequest.NOME_REFERENTE_TECNICO_OLO = '12';
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     
     /*
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234567812345678912345678456789';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'S';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'Y';
     frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
     EOF_GW_Utils.checkSync(frequest);
     frequest.TIPO_COMUNICAZIONE = '3';
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '12345678912345678912345456';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     
     */
     Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify2_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
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
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'S';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'Y';
     frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
     EOF_GW_Utils.checkSync(frequest);
     /*
     frequest.TIPO_COMUNICAZIONE = '3';
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '12345678912345678912345456';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     
     */
     Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify2_3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
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
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '12345678912345678912345456';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     
     
     Test.stopTest();
    }
    public static testmethod void EOFGWUtil_TestCreateNotify3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
     EOF_GW_Utils.checkSync(frequest); 
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     frequest.NOME_CLIENTE = '123456789';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
     frequest.NOME_CLIENTE = '123456789';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456789123';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     frequest.NOME_REFERENTE_TECNICO_OLO = '12';
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     /*
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456789123456784321234567891234567891234567843212345678912345678912345678432';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234567812345678912345678456789';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'S';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'Y';
     frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
     EOF_GW_Utils.checkSync(frequest);
     frequest.TIPO_COMUNICAZIONE = '3';
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     
     EOF_GW_Utils.checkSync(frequest);
     
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
     frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
     frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
     EOF_GW_Utils.checkSync(frequest);
     
	*/
     Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify3_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
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
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'S';
     EOF_GW_Utils.checkSync(frequest);
     frequest.COGNOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678912345678';
     frequest.RECAPITO_TEST_LINEA= '1234567891234';
     frequest.OPZIONE_SYSTEM_UNICO = 'Y';
     frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '1234567891234567812345678912345678456789';
     EOF_GW_Utils.checkSync(frequest);
     /*
     frequest.TIPO_COMUNICAZIONE = '3';
     frequest.COGNOME_CLIENTE='testing'; 
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
     
     EOF_GW_Utils.checkSync(frequest);
     
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
     frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
     frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
     EOF_GW_Utils.checkSync(frequest);
     
	*/
     Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify3_3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
      
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
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
     frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
     EOF_GW_Utils.checkSync(frequest);
     frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
     frequest.NOME_CLIENTE = '123456';
     frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
     frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
     frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
     frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
     EOF_GW_Utils.checkSync(frequest);
     
	
     Test.stopTest();
    }
    public static testmethod void EOFGWUtil_TestCreateNotify4(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
           
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
     frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '123456789123456789125123456789123456789125';
     EOF_GW_Utils.checkSync(frequest);
     Test.stopTest();
    }
    
    public static testmethod void EOFGWUtil_TestCreateNotify5(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
           
     frequest.TIPO_COMUNICAZIONE = '4';
frequest.COGNOME_CLIENTE='testing'; 
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';

EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
frequest.NOME_CLIENTE = '12345678912345678912345456';
EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
frequest.NOME_CLIENTE = '123456';
frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
EOF_GW_Utils.checkSync(frequest);
/*
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
frequest.NOME_CLIENTE = '123456';
frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
frequest.NOME_CLIENTE = '123456';
frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
frequest.NOME_CLIENTE = '123456';
frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
EOF_GW_Utils.checkSync(frequest);
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
frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '123456789123456789125123456789123456789125';
EOF_GW_Utils.checkSync(frequest);
frequest.COGNOME_CLIENTE = '';
EOF_GW_Utils.checkSync(frequest);
*/
     Test.stopTest();
    }
    public static testmethod void EOFGWUtil_TestCreateNotify5_2(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
           
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
EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
frequest.NOME_CLIENTE = '123456';
frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
frequest.COGNOME_REFERENTE_TECNICO_OLO  = '12345678912345678912345123456789123456789123451234567891234567891234512345678912345678912345';
EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
frequest.NOME_CLIENTE = '123456';
frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
frequest.TELEFONO_REFERENTE_TECNICO_OLO = '123456789123456785123456789123456785';
EOF_GW_Utils.checkSync(frequest);
frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456';
frequest.NOME_CLIENTE = '123456';
frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '123456';
frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456785';
frequest.COGNOME_REFERENTE_TECNICO_OLO  = '123456789123456789125';
frequest.TELEFONO_REFERENTE_TECNICO_OLO = '12345678';
frequest.RECAPITO_TEST_LINEA = '123456781234567834343434';
EOF_GW_Utils.checkSync(frequest);
/*
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
frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '123456789123456789125123456789123456789125';
EOF_GW_Utils.checkSync(frequest);
frequest.COGNOME_CLIENTE = '';
EOF_GW_Utils.checkSync(frequest);
*/
     Test.stopTest();
    }
     public static testmethod void EOFGWUtil_TestCreateNotify5_3(){
 
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
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
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
        c.AccountId = acc.Id;
        insert c;
 
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
    
    //-----insert EAI Service Log------
    
     String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
     EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
     eaiLog.Caso__c  = c.Id;
     eaiLog.EOF_ID_Notifica__c = 'test_01';
     eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
     eaiLog.recordTypeId = eaiRecordType;
     insert eaiLog;
     
     
     // --- Network inventory----
     EOF_Network_Inventory__c netwrkInv = new EOF_Network_Inventory__c();
     netwrkInv.EOF_ID_Building__c = '10_054_054039_8000064301_41';
     netwrkInv.EOF_Stato_Building__c = 120;
     netwrkInv.EOF_Pop__c  = 'PG_01';
     insert netwrkInv;
     
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      objAsset.EOF_ID_Risorsa__c = 'risorsa';
      insert objAsset;
      
     Test.startTest();
     xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
     Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
     var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
     
           
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
EOF_GW_Utils.checkSync(frequest);
frequest.COGNOME_CLIENTE = '';
EOF_GW_Utils.checkSync(frequest);

     Test.stopTest();
    }
}
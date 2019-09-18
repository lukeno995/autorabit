@isTest
public class Copia_EOF_GW_Utils_TEST{

    public static testmethod void Copia_EOF_GW_UtilsTestTipoComm3(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
     
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
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '1234';
        contactPerson.Email = 'abc@xyz.com';
        
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        c.OwnerId = u.Id;
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
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'Test';
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xyz';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
    
    
    //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
    
        system.test.startTest();
        
        frequest.CODICE_OPERATORE = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_OPERATORE = 'VF';
        frequest.ID_NOTIFICA = '';
        Copia_EOF_GW_Utils.checkSync(frequest);

        frequest.ID_NOTIFICA = 'test_01';
        frequest.COGNOME_CLIENTE = 'xyz';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        Copia_EOF_GW_Utils.checkSync(frequest);
        
        frequest.CODICE_ORDINE_OLO = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
                
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.COGNOME_CLIENTE = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
        
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
        Copia_EOF_GW_Utils.checkAsync(c);
       // frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        Copia_EOF_GW_Utils.checkSync(frequest);
        frequest.TIPO_COMUNICAZIONE = '3';
        Copia_EOF_GW_Utils.checkSync(frequest);
        
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.COGNOME_CLIENTE = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
         Copia_EOF_GW_Utils.checkAsync(c);
        
        frequest.COGNOME_CLIENTE = 'test';
        
        Copia_EOF_GW_Utils.checkSync(frequest);
        Copia_EOF_GW_Utils.checkAsync(c);
        
         frequest.PROVINCIA = '';
         Copia_EOF_GW_Utils.checkAsync(c);
         
         frequest.PROVINCIA = 'xyg';
         frequest.COMUNE = '';
         Copia_EOF_GW_Utils.checkAsync(c);
         
          frequest.COMUNE = 'xyg';
          frequest.INDIRIZZO = '';
         Copia_EOF_GW_Utils.checkAsync(c);
         
         frequest.INDIRIZZO = 'test';
         frequest.NUMERO_CIVICO = '';
         Copia_EOF_GW_Utils.checkAsync(c);
         
       /**  frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
         frequest.NOME_REFERENTE_TECNICO_OLO = 'test';
          Copia_EOF_GW_Utils.checkAsync(c);
      **/     
         
        
        
        //------Tipo Communicazione=4-----------
        
        frequest.TIPO_COMUNICAZIONE = '4';
        frequest.COGNOME_CLIENTE = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
        
        frequest.COGNOME_CLIENTE = 'test';
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
        
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'test';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        Copia_EOF_GW_Utils.checkSync(frequest);
        
        
        
        //------Tipo Communicazione=1-----------
        
         frequest.TIPO_COMUNICAZIONE = '1';
         frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'test';
         Copia_EOF_GW_Utils.checkSync(frequest);
         Copia_EOF_GW_Utils.checkAsync(c);
        
        //------Tipo Communicazione=11-----------
        frequest.TIPO_COMUNICAZIONE = '11';
        Copia_EOF_GW_Utils.checkSync(frequest);
        Copia_EOF_GW_Utils.checkAsync(c);
      //  Copia_EOF_GW_Utils.create_notify(c,6,'OK','','EOF_ID_Notifica__c');
     
        
        system.test.stopTest();
    }
    
      public static testmethod void Copia_EOF_GW_UtilsTestTipoComm2(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
    
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
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '1234';
        contactPerson.Email = 'abc@xyz.com';
        
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        c.OwnerId = u.Id;
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
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'Test';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xyz';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.RECAPITO_TEST_LINEA = 'test';
        frequest.OPZIONE_SYSTEM_UNICO = 'test';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'test';
    
    
    //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
     
        system.test.startTest();
        frequest.TIPO_COMUNICAZIONE = '11';
        Copia_EOF_GW_Utils.checkSync(frequest);
        Copia_EOF_GW_Utils.checkAsync(c);
        Copia_EOF_GW_Utils.create_notify(c,6,'OK','','EOF_ID_Notifica__c');
        
        frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
        frequest.NOME_CLIENTE = 'test';
        Copia_EOF_GW_Utils.checkSync(frequest);
        Copia_EOF_GW_Utils.checkAsync(c);
        
        system.test.stopTest();
    }
    
    public static testmethod void Copia_EOF_GW_UtilsTestTipoComm11(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
    
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
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '1234';
        contactPerson.Email = 'abc@xyz.com';
        
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'Test';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '123';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xyz';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.RECAPITO_TEST_LINEA = 'test';
        frequest.OPZIONE_SYSTEM_UNICO = 'test';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'test';
    
    
    //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      insert objAsset;  
    
      system.test.startTest();
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.create_notify(c, 7, 'OK', null, null);
      Copia_EOF_GW_Utils.create_notify(c, 7, 'KO', null, null);
      Copia_EOF_GW_Utils.create_notify(c, 6, 'KO', null, null);
      Copia_EOF_GW_Utils.create_notify(c, 9, 'KO', null, null);
     // Copia_EOF_GW_Utils.create_notify(c, 12, 'KO', null, null);
    
      c.Type = '11';
      frequest.ID_RISORSA = objAsset.id;
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      
      frequest.ID_RISORSA = 'Test';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      
      Copia_EOF_GW_Utils.create_notify(c, 12, 'KO', null, null);
      
      Copia_EOF_GW_Utils.add_result_message(c,'OK');
      Copia_EOF_GW_Utils.create_notify(c, 5, 'OK', null, null);
                  
      system.test.stopTest();
    }
    
      public static testmethod void CopiaGWUtilTestNoCase(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
    
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
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '1234';
        contactPerson.Email = 'abc@xyz.com';
        contactPerson.AccountId = accOLO.Id;
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA =String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'Test';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE =String.valueOf(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xyz';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.RECAPITO_TEST_LINEA = 'test';
        frequest.OPZIONE_SYSTEM_UNICO = 'test';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'test';
    
    
    //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      insert objAsset;  
    
      system.test.startTest();
      
      
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      
       frequest.PARTICELLA_TOPONOMASTICA = 'test';
      frequest.NOME_REFERENTE_TECNICO_OLO = 'xyz';
      frequest.COGNOME_REFERENTE_TECNICO_OLO = '';
      Copia_EOF_GW_Utils.checkAsync(c);
      
      frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xyz';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO = '';
      Copia_EOF_GW_Utils.checkAsync(c);
      
      frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
      frequest.EMAIL_REFERENTE_TECNICO_OLO = '';
      Copia_EOF_GW_Utils.checkAsync(c);
      
      frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
      Copia_EOF_GW_Utils.checkAsync(c);
      
                       
      system.test.stopTest();
    }
    
     public static testmethod void CopiaGWUtilTestNoContact(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
    
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
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '123899';
        contactPerson.Email = 'abc@xyz.com';
        
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '11';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37';
        frequest.DATA_NOTIFICA =String.valueOf(system.today());
        frequest.ID_NOTIFICA = 'test_01';
        frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
        frequest.GPON_ATTESTAZIONE = '';
        frequest.GPON_VINCOLANTE = '';
        frequest.ID_RISORSA = 'Test';
        frequest.NOME_CLIENTE = 'test';
        frequest.COGNOME_CLIENTE = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'test';
        frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        frequest.PROVINCIA = 'Milano';
        frequest.COMUNE = 'Milano';
        frequest.PARTICELLA_TOPONOMASTICA = '';
        frequest.INDIRIZZO = 'Piazzale Gorini';
        frequest.NUMERO_CIVICO = '6';
        frequest.ID_BUILDING = '10_054_054039_8000064301_40';
        frequest.SCALA_PALAZZINA = '';
        frequest.NOME_REFERENTE_TECNICO_OLO = '';
        frequest.DATA_PREVISTA_ATTIVAZIONE =String.valueOf(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        frequest.COGNOME_REFERENTE_TECNICO_OLO = 'xyz';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        frequest.EMAIL_REFERENTE_TECNICO_OLO = 'abc@xyz.com';
        frequest.RECAPITO_TEST_LINEA = 'test';
        frequest.OPZIONE_SYSTEM_UNICO = 'test';
        frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'test';
    
    
    //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      insert objAsset;  
    
      system.test.startTest();
         
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
                       
      system.test.stopTest();
    }
    
    public static testmethod void CopiaGWUtilTestNoContact1(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
    
     // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'AF';
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
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '123899';
        contactPerson.Email = 'abc@xyz.com';
        
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37_12';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'AF';
        frequest.CODICE_ORDINE_OLO = '02112016_37_12';
        frequest.ID_NOTIFICA = 'test_01_12345678';
    
    
    //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01_1';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37_12';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      insert objAsset;  
    
      system.test.startTest();
         
      //Copia_EOF_GW_Utils.checkSync(frequest);
      //Copia_EOF_GW_Utils.checkAsync(c);
      accOLO.EOF_Codice_Operatore__c = 'VF';
      update accOLO;
      frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'VF';
        frequest.CODICE_ORDINE_OLO = '02112016_37_12';
        frequest.ID_NOTIFICA = 'test_01_1';
        //Copia_EOF_GW_Utils.checkSync(frequest);
      //Copia_EOF_GW_Utils.checkAsync(c); 
      //frequest.TIPO_COMUNICAZIONE = '2';
      
      frequest.NOME_CLIENTE = '12345678912345678912345';
      frequest.COGNOME_CLIENTE = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
      frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
      frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
      frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567891';
      frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123451234567891234567891234512345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c); 
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567891';
      frequest.NOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '123456789123456789123451234567891234567891234512345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c); 
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567891';
      frequest.NOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '123456789123';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c); 
                   
      system.test.stopTest();
    }
    
    public static testmethod void CopiaGWUtilTestNoContact2(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
    
     // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'AF';
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
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '123899';
        contactPerson.Email = 'abc@xyz.com';
        
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37_12';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c;
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        frequest.CODICE_OPERATORE = 'AF';
        frequest.CODICE_ORDINE_OLO = '02112016_37_12';
        frequest.ID_NOTIFICA = 'test_01_1';
    
    
    //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01_1';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37_12';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
      //------Asset Creation ------
      Asset objAsset = new Asset();
      objAsset.Name= 'Test Asset';
      objAsset.Status = 'Attivo';
      objAsset.AccountId = acc.Id; 
      insert objAsset;  
    
      system.test.startTest();
         
      //Copia_EOF_GW_Utils.checkSync(frequest);
      //Copia_EOF_GW_Utils.checkAsync(c);
      accOLO.EOF_Codice_Operatore__c = 'VF';
      update accOLO;
      frequest.CODICE_OPERATORE = 'VF';
      frequest.TIPO_COMUNICAZIONE = '3';
      frequest.NOME_CLIENTE = '12345678912345678912345';
      frequest.COGNOME_CLIENTE = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
      frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '12345678912345678912345';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
      frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '12345678912345678912345';
      frequest.NOME_REFERENTE_TECNICO_OLO = '12345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c);
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567891';
      frequest.NOME_REFERENTE_TECNICO_OLO = '123456789123456789123451234567891234567891234512345678912345678912345';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c); 
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567891';
      frequest.NOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '123456789123456789123451234567891234567891234512345678912345678912345';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      frequest.EMAIL_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c); 
      frequest.NOME_CLIENTE = '123456789123';
      frequest.COGNOME_CLIENTE = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '123456789';
      frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567891';
      frequest.NOME_REFERENTE_TECNICO_OLO = '1234567891234567891234';
      frequest.COGNOME_REFERENTE_TECNICO_OLO= '123456789123';
      frequest.TELEFONO_REFERENTE_TECNICO_OLO= '12345678912345678912345';
      Copia_EOF_GW_Utils.checkSync(frequest);
      Copia_EOF_GW_Utils.checkAsync(c); 
   }
    
}
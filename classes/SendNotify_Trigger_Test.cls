@isTest

public class SendNotify_Trigger_Test{
    
    public static testmethod void SendNotify_TestMethod1(){
        
        TestDataFactory.CreatetestRecords(null, null, null);
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        // User Creation
        
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        insert u;
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
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
        c.EOF_ID_Risorsa__c = 'Test';
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
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Nuova_DAC__c = system.today();
        objEOF.EOF_Orario_DAC__c = '10:30 - 12:30';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.EOF_ID_Risorsa__c = 'Test';
        objAsset.AccountId = acc.Id; 
        insert objAsset;
        
        System.Test.startTest();
        System.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType obj = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
        
        obj = var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        
        String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione KO').getRecordTypeId();
        objEOF.EOF_Inviata__c=false;
        objEOF.RecordTYpeId = NotifyRecordTypeId1;
        update objEOF;
        String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId2;
        update objEOF;
        String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento KO').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId3;
        update objEOF;
        /*
        String NotifyRecordTypeId4 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId4;
        update objEOF;
        String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId5;
        c.Status = 'Sospeso';
        objEOF.Caso__c = c.id;
        c.ownerId = userInfo.getUserId();
        update c;
        System.runAs(u) {
            c.ownerId = userInfo.getUserId();
            update c;
            update objEOF;
        }
        String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId6;
        c.Status = 'Sospeso';
        update c;
        update objEOF;
        
      /**  String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId7;
        c.EOF_ID_Risorsa__c = 'Test';
        update c;
        objAsset.EOF_ID_Risorsa__c = 'Testing';
        update objAsset;
        update objEOF;
        String NotifyRecordTypeId8 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione KO').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId8;
        update objEOF;
        **/
       
        System.Test.stopTest();
    }
    
    public static testmethod void SendNotify_TestMethod2(){
        
        TestDataFactory.CreatetestRecords(null, null, null);
        
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        insert u;
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
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
        c.EOF_ID_Risorsa__c = 'Test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.EOF_ID_Risorsa__c = '';
        objAsset.AccountId = acc.Id; 
        insert objAsset;
        
        System.Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType obj = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
        System.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        obj = var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        
        
        update objEOF;
        
         String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId5;
        c.Status = 'Sospeso';
        c.ownerId = userInfo.getUserId();
        update c;
        update objEOF;
        
        String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId7;
        c.EOF_ID_Risorsa__c = '';
        update c;
        update objEOF;
        
       System.Test.stopTest();
     }
     
     public static testmethod void SendNotify_TestMethod3(){

        TestDataFactory.CreatetestRecords(null, null, null);
         
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        insert u;
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_ID_Risorsa__c = 'Test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Data_Max_risoluzione_Ticket__c=system.now().addDays(1);
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.EOF_ID_Risorsa__c = '';
        objAsset.AccountId = acc.Id; 
        insert objAsset;
        
        System.Test.startTest();
        System.Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        
       
        
         String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId5;
        c.Status = 'Sospeso';
        c.ownerId = userInfo.getUserId();
        update c;
        update objEOF;
        
        String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Sospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId7;
        CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        c.recordTypeId=CaseRecordTypeId;
        c.EOF_ID_Risorsa__c = '';
        c.Status = 'In Lavorazione';
        update c;
        update objEOF;
          /*
        String NotifyRecordTypeId8 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Desospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId8;
        c.EOF_ID_Risorsa__c = '';
        update c;
        update objEOF;
      
        String NotifyRecordTypeId9 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Annullamento').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId9;
        c.EOF_ID_Risorsa__c = '';
        update c;
        update objEOF;
        
        String NotifyRecordTypeId10 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di TimeoutOK').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId10;
        c.EOF_ID_Risorsa__c = '';
        update c;
        update objEOF;
        */
        System.Test.stopTest();
       
     }
     
    public static testmethod void SendNotify_TestMethod4(){

        TestDataFactory.CreatetestRecords(null, null, null);

        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        // User Creation
        
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        insert u;
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
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
        c.EOF_ID_Risorsa__c = 'Test';
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
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Nuova_DAC__c = system.today();
        objEOF.EOF_Orario_DAC__c = '10:30 - 12:30';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.EOF_ID_Risorsa__c = 'Test';
        objAsset.AccountId = acc.Id; 
        insert objAsset;
        
        System.Test.startTest();
        System.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType obj = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
        
        obj = var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        /*
        String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione KO').getRecordTypeId();
        objEOF.EOF_Inviata__c=false;
        objEOF.RecordTYpeId = NotifyRecordTypeId1;
        update objEOF;
        String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId2;
        update objEOF;
        String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento KO').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId3;
        update objEOF;
        */
        String NotifyRecordTypeId4 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId4;
        update objEOF;
        String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId5;
        c.Status = 'Sospeso';
        objEOF.Caso__c = c.id;
        c.ownerId = userInfo.getUserId();
        update c;
        System.runAs(u) {
            c.ownerId = userInfo.getUserId();
            update c;
            update objEOF;
        }
        String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId6;
        c.Status = 'Sospeso';
        update c;
        update objEOF;
        
      /**  String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId7;
        c.EOF_ID_Risorsa__c = 'Test';
        update c;
        objAsset.EOF_ID_Risorsa__c = 'Testing';
        update objAsset;
        update objEOF;
        String NotifyRecordTypeId8 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione KO').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId8;
        update objEOF;
        **/
       
        System.Test.stopTest();
    }
    
    public static testmethod void SendNotify_TestMethod5(){

        TestDataFactory.CreatetestRecords(null, null, null);
        
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        insert u;
        
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_ID_Risorsa__c = 'Test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Data_Max_risoluzione_Ticket__c=system.now().addDays(1);
        insert c;
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.EOF_ID_Risorsa__c = '';
        objAsset.AccountId = acc.Id; 
        insert objAsset;
        
        System.Test.startTest();
        System.Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        
       
        /*
         String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId5;
        c.Status = 'Sospeso';
        c.ownerId = userInfo.getUserId();
        update c;
        update objEOF;
        
        String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Sospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId7;
        c.EOF_ID_Risorsa__c = '';
        c.Status = 'In Lavorazione';
        update c;
        update objEOF;
         
        String NotifyRecordTypeId8 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Desospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId8;
        c.EOF_ID_Risorsa__c = '';
        update c;
        update objEOF;
       */
        String NotifyRecordTypeId9 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Annullamento').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId9;
        c.EOF_ID_Risorsa__c = '';
        update c;
        update objEOF;
        
        String NotifyRecordTypeId10 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di TimeoutOK').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId10;
        c.EOF_ID_Risorsa__c = '';
        update c;
        update objEOF;
        
        String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Desospensione').getRecordTypeId();
        objEOF.RecordTYpeId = NotifyRecordTypeId6;
        objEOF.EOF_referente_desospensione__C='Tizio';
        c.Status = 'Sospeso';
        c.EOF_Minuti_rimanenti_sospesi__c=10;
        update c;
        update objEOF;
        
        System.Test.stopTest();
       
     }
}
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
private class OM_GW_WS_Notify_TEST {

    static testMethod void OM_GW_WS_Notify_TESTMETHOD_1() {
        TestDataFactory.CreateTestRecords(null,null,null);
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        
        // User Creation        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
        //end user creation
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
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
        c.EOF_Order_Manager__c=true;
        insert c;
        
        
        // TO DO: implement unit test
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        fn.codice_operatore='wn';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        fn.codice_operatore='ovdafrank';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        fn.codice_operatore='wind';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        fn.codice_operatore='vodafone';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        fn.codice_operatore='tiscali';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        fn.codice_operatore='';
        fn.codice_ordine_olo='';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        fn.codice_operatore='';
        fn.codice_ordine_olo='02112016_37';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        fn.tipo_comunicazione='6';
        fn.codice_ordine_olo='02112016_37';
        fn.codice_ordine_eof=c.id;
        fn.ID_NOtifica='xyz';
        fn.stato_richiesta='1';
        fn.GPON_ATTESTAZIONE='xyz';
        
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        
        fn.TIPO_COMUNICAZIONE = '7';
        fn.CODICE_OPERATORE = 'WN';
        fn.CODICE_ORDINE_OLO = 'test';        
        fn.CODICE_ORDINE_EOF = c.id;
        fn.ID_NOTIFICA ='test';
        fn.STATO_RICHIESTA ='0';
        fn.GPON_ATTESTAZIONE ='test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-27';
        fn.DATA_ESPLETAMENTO_ORDINE ='';
        fn.PARAMETRI_TRASMISSIVI_OTTICI ='';
        fn.POSIZIONE_SPLITTER_SECONDARIO ='';
        fn.ID_SPLITTER_SECONDARIO ='';
        fn.NUMERO_OPERATORE ='';
        fn.ID_APPARATO_CONSEGNATO ='';
        fn.ESITO_CONSEGNA_APPARATO ='';
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        test.stopTest();
    }
    
    static testmethod void OM_GW_WS_Notify_TESTMETHOD_2(){
        TestDataFactory.CreateTestRecords(null,null,null);
        // profile creation
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // end profile creation
        
        // User Creation        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
        // End user creation
        
        // Group creation
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        // End group creation
         
        // OLO Account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        // End OLO Account creation
        
        // Person Account creation
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
        // End Person Account creation
        
        //ordine
        Order o = new Order();
        o.accountId=accOlo.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        // Case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = 'test';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.EOF_Order_Manager__c=true;
        c.OF_Order__c=o.Id;
        insert c;
        
        // End case creation
        
        // Notify creation
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = c.id;
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
        // End notify creation
   
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE = '7';
        fn.CODICE_OPERATORE = 'WN';
        fn.CODICE_ORDINE_OLO = 'test';        
        fn.CODICE_ORDINE_EOF = c.id;
        fn.ID_NOTIFICA ='test';
        fn.STATO_RICHIESTA ='0';
        fn.GPON_ATTESTAZIONE ='test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-27T16:17:30+02:00';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-14';
        fn.PARAMETRI_TRASMISSIVI_OTTICI ='1';
        fn.POSIZIONE_SPLITTER_SECONDARIO ='1';
        fn.ID_SPLITTER_SECONDARIO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.ID_APPARATO_CONSEGNATO ='';
        fn.ESITO_CONSEGNA_APPARATO ='';
        fn.FLAG_PAGAMENTO ='1';
        
        test.startTest();
        system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(objeof, '1', 'OK', 'OK');
        OM_GW_GE_Utils.create_notify(fn, c.Id, 'WN');
        test.stopTest();
    }    

    static testmethod void OM_GW_WS_Notify_TESTMETHOD_3(){
        TestDataFactory.CreateTestRecords(null,null,null);
        // profile creation
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // end profile creation
        
        // User Creation        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
        // End user creation
        
        // Group creation
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        // End group creation
         
        // OLO Account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        // End OLO Account creation
        
        // Person Account creation
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
        // End Person Account creation
        
        //ordine
        Order o = new Order();
        o.accountId=accOlo.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        // Case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = 'test';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.EOF_Order_Manager__c=true;
        c.OF_Order__c=o.Id;
        insert c;
        
        // End case creation
        
        // Notify creation
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = c.id;
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
        // End notify creation
   
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE = '7';
        fn.CODICE_OPERATORE = 'WN';
        fn.CODICE_ORDINE_OLO = 'test';        
        fn.CODICE_ORDINE_EOF = c.id;
        fn.ID_NOTIFICA ='test';
        fn.STATO_RICHIESTA ='0';
        fn.GPON_ATTESTAZIONE ='test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-27T16:17:30+02:00';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-14';
        fn.PARAMETRI_TRASMISSIVI_OTTICI ='1';
        fn.POSIZIONE_SPLITTER_SECONDARIO ='1';
        fn.ID_SPLITTER_SECONDARIO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.ID_APPARATO_CONSEGNATO ='';
        fn.ESITO_CONSEGNA_APPARATO ='';
        fn.FLAG_PAGAMENTO ='1';
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(objeof, '1', 'OK', 'OK');        
        test.stopTest();
    }    
    
    static testmethod void OM_GW_WS_Notify_TESTMETHOD_4(){
        TestDataFactory.CreateTestRecords(null,null,null);
        // profile creation
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // end profile creation
        
        // User Creation        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
        // End user creation
        
        // Group creation
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        // End group creation
         
        // OLO Account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        // End OLO Account creation
        
        // Person Account creation
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
        // End Person Account creation
        
        // Case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = 'test';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.EOF_Order_Manager__c=true;
        insert c;
        
        // End case creation
        
        // Notify creation
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = c.id;
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
        // End notify creation
   
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE = '7';
        fn.CODICE_OPERATORE = 'WIND';
        fn.CODICE_ORDINE_OLO = 'test';        
        fn.CODICE_ORDINE_EOF = c.id;
        fn.ID_NOTIFICA ='test';
        fn.STATO_RICHIESTA ='0';
        fn.GPON_ATTESTAZIONE ='test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-27T16:17:30+02:00';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-14';
        fn.PARAMETRI_TRASMISSIVI_OTTICI ='1';
        fn.POSIZIONE_SPLITTER_SECONDARIO ='1';
        fn.ID_SPLITTER_SECONDARIO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.ID_APPARATO_CONSEGNATO ='';
        fn.ESITO_CONSEGNA_APPARATO ='';
        fn.FLAG_PAGAMENTO ='1';
        
        test.startTest();
        system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupNACK());
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(objeof, '1', 'OK', 'OK');
        OM_GW_GE_Utils.create_notify(fn, c.Id, 'WN');
        test.stopTest();
    }    

    /*public static testMethod void CodeCoverage(){
        test.starttest();
        OM_GW_WS_Notify.CodeCoverage(2);
        test.stoptest();
    }*/

    static testmethod void OM_GW_WS_Notify_TESTMETHOD_5(){
        TestDataFactory.CreateTestRecords(null,null,null);
        // profile creation
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // end profile creation
        
        // User Creation        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
        // End user creation
        
        // Group creation
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        // End group creation
         
        // OLO Account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        // End OLO Account creation
        
        // Person Account creation
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
        // End Person Account creation
        
        //ordine
        Order o = new Order();
        o.accountId=accOlo.Id;
        o.EffectiveDate=system.today();
        o.Status='Aperto';
        insert o;
        
        // Case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = 'test';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.EOF_Order_Manager__c=true;
        c.OF_Order__c=o.Id;
        insert c;
        
        // End case creation
        
        // Notify creation
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = c.id;
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
        // End notify creation
   
        OM_GW_WS_Notify.fibernotify fn = new OM_GW_WS_Notify.fibernotify();
        
        fn.TIPO_COMUNICAZIONE = '7';
        fn.CODICE_OPERATORE = 'WN';
        fn.CODICE_ORDINE_OLO = 'test';        
        fn.CODICE_ORDINE_EOF = c.id;
        fn.ID_NOTIFICA ='test';
        fn.STATO_RICHIESTA ='0';
        fn.GPON_ATTESTAZIONE ='test';
        fn.ID_RISORSA ='test';
        fn.DATA_NOTIFICA ='2017-09-27T16:17:30+02:00';
        fn.DATA_ESPLETAMENTO_ORDINE ='2017-10-14';
        fn.PARAMETRI_TRASMISSIVI_OTTICI ='1';
        fn.POSIZIONE_SPLITTER_SECONDARIO ='1';
        fn.ID_SPLITTER_SECONDARIO ='1';
        fn.NUMERO_OPERATORE ='1';
        fn.ID_APPARATO_CONSEGNATO ='';
        fn.ESITO_CONSEGNA_APPARATO ='';
        fn.FLAG_PAGAMENTO ='1';
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OM_GW_WS_Notify.returnNotifyResponse rnr= new OM_GW_WS_Notify.returnNotifyResponse();    
        rnr=OM_GW_WS_Notify.fiberNotify(fn);
        OM_GW_Notify_Utils.checkSync(fn);        
        OM_GW_Notify_Utils.create_notify_Update_case(fn);
        OM_GW_Notify_Utils.create_ack_nack(objeof, '0', 'OK', 'OK');
        OM_GW_Notify_Utils.create_ack_nack(objeof, '1', 'OK', 'OK');
        OM_GW_GE_Utils.create_notify(fn, c.Id, 'WN');
        
        test.stopTest();
    }    
    
    
}
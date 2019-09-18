@isTest

public class EOF_GW_GE_Utils_TEST{

    public static testmethod void EOF_GW_GE_Utils_TestMethod(){
 
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
        frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(system.today());
        frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        frequest.CODICE_RICHIESTA_ANNULLAMENTO = '';
        frequest.APPARATO = '';
        frequest.TIPOLOGIA_APPARATO = 'test';
        frequest.NOTE = 'xyz';
        frequest.TIPOLOGIA_SERVIZIO = 'test';
        frequest.SLA_PREMIUM_ASSURANCE = 'Y';
        frequest.ORARIO_APPUNTAMENTO = DateTime.now().getTime()+'';
        
        /*
        //-------------Trouble Ticket Creation----------------
         EOF_GW_WS_Request.TroubleTicket tTicket = new EOF_GW_WS_Request.TroubleTicket();
         tTicket.TIPO_COMUNICAZIONE = '1';
         tTicket.CODICE_OPERATORE = 'VF';
         tTicket.ID_NOTIFICA = 'test_01';
         tTicket.ID_RISORSA = 'risorsa';
         tTicket.NOME_CLIENTE = '';
         tTicket.COGNOME_CLIENTE = '';
         tTicket.RECAPITO_TELEFONICO_CLIENTE_1 = '';
         tTicket.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tTicket.NOTE = 'xyz';
         tTicket.CODICE_COMUNICAZIONE_OLO = 'testolo';
         tTicket.CATEGORIA_GUASTO = '0';
         tTicket.CAUSALE_DESOSPENSIONE = 'xyz';
         tTicket.REFERENTE_DESOSPENSIONE = 'xyz';
         tTicket.VERIFICA_APPARATO_CLIENTE = 'xyz';
        //-------------Trouble Ticket Ends-----------------------
        */
    
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
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.EOF_ID_Risorsa__c = 'Test';
        objAsset.AccountId = accOLO.Id; 
        insert objAsset;
        //-----insert EAI Service Log------
        
        /*String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;*/
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        system.test.startTest();
		OM_GW_GE_Utils.tpl = new TEMPLOG__c();
		OM_GW_GE_Utils.AttrTime= datetime.now().getTime();             
        EOF_GW_GE_Utils.syncError(frequest,'A_K5','TestField');
        //EOF_GW_GE_Utils.syncError(tTicket,'A_K6','TestField');
        EOF_GW_GE_Utils.create_EAI_Log(objEOF,eaiRecordType);
        EOF_GW_GE_Utils.create_EAI_Log(frequest);
        //EOF_GW_GE_Utils.create_EAI_Log(tTicket);
        EOF_GW_GE_Utils.copy_request(frequest);
        //EOF_GW_GE_Utils.copy_tt_request(tTicket);
        EOF_GW_GE_Utils.copy_notify(objEOF);
        EOF_GW_GE_Utils.updateFiberNotify(objEOF);
        EOF_GW_GE_Utils.create_EAI_Log(c);
        
        String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
        EOF_Notify__c objEOF1 = new EOF_Notify__c();
        objEOF1.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF1.EOF_ID_Notifica__c = 'Test Id';
        objEOF1.EOF_Stato_Richiesta__c = 'OK';
        objEOF1.EOF_Codice_Operatore__c = 'VF';
        objEOF1.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF1.EOF_Data_Notifica__c = system.now();
        objEOF1.EOF_Note__c = 'Test Note';
        objEOF1.EOF_Inviata__c = false;
        objEOF1.Caso__c = c.id;
        objEOF1.RecordTYpeId = NotifyRecordTypeId1;
        
        insert objEOF1;
        
        EOF_GW_GE_Utils.updateFiberNotify(objEOF);
        
        String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
        EOF_Notify__c objEOF2 = new EOF_Notify__c();
        objEOF2.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF2.EOF_ID_Notifica__c = 'Test Id';
        objEOF2.EOF_Stato_Richiesta__c = 'OK';
        objEOF2.EOF_Codice_Operatore__c = 'VF';
        objEOF2.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF2.EOF_Data_Notifica__c = system.now();
        objEOF2.EOF_Note__c = 'Test Note';
        objEOF2.EOF_Inviata__c = false;
        objEOF2.Caso__c = c.id;
        objEOF2.RecordTYpeId = NotifyRecordTypeId2;
        
        insert objEOF2;
        EOF_GW_GE_Utils.updateFiberNotify(objEOF);
        
        String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
        
        EOF_Notify__c objEOF3 = new EOF_Notify__c();
        objEOF3.RecordTYpeId = NotifyRecordTypeId3;
        objEOF3.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF3.EOF_ID_Notifica__c = 'Test Id';
        objEOF3.EOF_Stato_Richiesta__c = 'OK';
        objEOF3.EOF_Codice_Operatore__c = 'VF';
        objEOF3.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF3.EOF_Data_Notifica__c = system.now();
        objEOF3.EOF_Note__c = 'Test Note';
        objEOF3.EOF_Inviata__c = false;
        objEOF3.Caso__c = c.id;
        insert objEOF3;
        EOF_GW_GE_Utils.updateFiberNotify(objEOF3);
        
        String NotifyRecordTypeId4 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
        EOF_Notify__c objEOF4 = new EOF_Notify__c();
        objEOF4.RecordTYpeId = NotifyRecordTypeId4;
        objEOF4.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF4.EOF_ID_Notifica__c = 'Test Id';
        objEOF4.EOF_Stato_Richiesta__c = 'OK';
        objEOF4.EOF_Codice_Operatore__c = 'VF';
        objEOF4.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF4.EOF_Data_Notifica__c = system.now();
        objEOF4.EOF_Note__c = 'Test Note';
        objEOF4.EOF_Inviata__c = false;
        objEOF4.Caso__c = c.id;
        insert objEOF4;
        EOF_GW_GE_Utils.updateFiberNotify(objEOF4);
        
        String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
        EOF_Notify__c objEOF5 = new EOF_Notify__c();
        objEOF5.RecordTYpeId = NotifyRecordTypeId5;
        objEOF5.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF5.EOF_ID_Notifica__c = 'Test Id';
        objEOF5.EOF_Stato_Richiesta__c = 'OK';
        objEOF5.EOF_Codice_Operatore__c = 'VF';
        objEOF5.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF5.EOF_Data_Notifica__c = system.now();
        objEOF5.EOF_Note__c = 'Test Note';
        objEOF5.EOF_Inviata__c = false;
        objEOF5.Caso__c = c.id;
        insert objEOF5;
        EOF_GW_GE_Utils.updateFiberNotify(objEOF5);
        
        String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
        EOF_Notify__c objEOF6 = new EOF_Notify__c();
        objEOF6.RecordTYpeId = NotifyRecordTypeId6;
        objEOF6.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF6.EOF_ID_Notifica__c = 'Test Id';
        objEOF6.EOF_Stato_Richiesta__c = 'OK';
        objEOF6.EOF_Codice_Operatore__c = 'VF';
        objEOF6.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF6.EOF_Data_Notifica__c = system.now();
        objEOF6.EOF_Note__c = 'Test Note';
        objEOF6.EOF_Inviata__c = false;
        objEOF6.Caso__c = c.id;
        insert objEOF6;
        EOF_GW_GE_Utils.updateFiberNotify(objEOF6);
        String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di annullamento').getRecordTypeId();
        EOF_Notify__c objEOF7 = new EOF_Notify__c();
        objEOF7.RecordTYpeId = NotifyRecordTypeId7;
        objEOF7.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF7.EOF_ID_Notifica__c = 'Test Id';
        objEOF7.EOF_Stato_Richiesta__c = 'OK';
        objEOF7.EOF_Codice_Operatore__c = 'VF';
        objEOF7.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF7.EOF_Data_Notifica__c = system.now();
        objEOF7.EOF_Note__c = 'Test Note';
        objEOF7.EOF_Inviata__c = false;
        objEOF7.Caso__c = c.id;
        insert objEOF7;
        EOF_GW_GE_Utils.updateFiberNotify(objEOF7);
        system.test.stopTest();
    }
}
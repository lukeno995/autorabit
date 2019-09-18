@isTest

public class Create_Asset_Trigger_TEST{
    @isTest(seeAllData=true)
    public static void Create_Asset_Trigger_TestMethod1(){
        
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
        
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.AccountId = acc.Id; 
        insert objAsset;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.AccountId = acc.Id;
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
        
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
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
        String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
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
        String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
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
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.Notify__c = objEOF2.Id;
        insert eaiLog;
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType obj = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        obj = var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        Test.stopTest();
        String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
        objEOF2.RecordTYpeId = NotifyRecordTypeId3;
        objEOF2.EOF_ID_Risorsa__c = 'Test1';
        update objEOF2;
    }
}
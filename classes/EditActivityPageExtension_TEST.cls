@isTest
public class EditActivityPageExtension_TEST{
    public static testMethod void testActivityPgExt(){
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
        insert c;
        
        Task taskObj = new Task();
        taskObj.OwnerId = UserInfo.getUserID();
        taskObj.WhatId = c.Id;
        taskObj.Subject = 'Chiamata'; 
        taskObj.EOF_Data_Ora_Chiamata__c = system.now();
        taskObj.Fascia_Oraria_Appuntamento__c = '08:30 - 10:30';
        taskObj.ReminderDateTime = system.now();
        taskObj.Data_Appuntamento__c = system.today();
        taskObj.EOF_Esito_della_chiamata__c = 'Positivo';
        insert taskObj; 
        
        ApexPages.StandardController sc = new ApexPages.StandardController(taskObj);
        EditActivityPageExtension edAcPg = new EditActivityPageExtension(sc);
        edAcPg.getTimeOptions();
        //edAcPg.attachment ();
        Test.startTest();
        xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1 var = new xmlnsEnelItOloGatwayWsdlConcreteS.SyncPortTypeEndpoint1();
        xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType obj = new xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        obj = var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        
        edAcPg.saveMethod();
        Test.stopTest();
    }
    /*
    public static testMethod void testActivityPgExt1(){
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
        insert c;
        
        Task taskObj = new Task();
        taskObj.OwnerId = UserInfo.getUserID();
        taskObj.WhatId = c.Id;
        taskObj.Subject = 'Chiamata'; 
        taskObj.EOF_Data_Ora_Chiamata__c = system.now();
        taskObj.Fascia_Oraria_Appuntamento__c = '08:30 - 10:30';
        taskObj.ReminderDateTime = system.now();
        taskObj.Data_Appuntamento__c = system.today();
        //insert taskObj; 
        PageReference pageRef = Page.EditActivityPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('what_id',c.Id);
        //ApexPages.StandardController sc = new ApexPages.StandardController(taskObj);
        EditActivityPageExtension edAcPg = new EditActivityPageExtension(new ApexPages.StandardController(taskObj));
        edAcPg.dtr= '11/4/2016';
        edAcPg.saveMethod();
        edAcPg.getTimeOptions();
        //edAcPg.attachment ();
        Test.startTest();
        EOF_GW_WS_Notify.EOFOLO var = new EOF_GW_WS_Notify.EOFOLO('VF');
        EOF_GW_WS_Notify.FiberNotifyRespType obj = new EOF_GW_WS_Notify.FiberNotifyRespType();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        obj = var.Notify('Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7','Test 8','Test 9','Test 10','Test 11','Test 12','Test 13','Test 14','Test 15','Test 16','Test 17','Test 18','Test 19','Test 20','Test 21','Test 22','Test 23');
        
        edAcPg.saveMethod();
        Test.stopTest();
    }
    */
}
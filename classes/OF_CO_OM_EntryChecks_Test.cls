@isTest
public class OF_CO_OM_EntryChecks_Test {
    @testsetup
    static void createData()
    {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true); 
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
        
        
        list<case> vclst = new list<case>();
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_ChangeOrder_OPENSTREAM').getRecordTypeId();
        for(integer i=0 ; i<=10;i++)
        {
            Case c = new Case();
            c.EOF_Account_OLO__c = accOLO.Id;
            c.Subject = 'Richiesta di attivazione';
            c.EOF_Codice_Ordine_OLO__c = '02112016_37CO'+i;
            c.EOF_Data_Prevista_Attivazione__c = system.today();
            c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c.Status = 'Acquisito';
            c.EOF_Fase__c = 'In Verifica BO';
            c.Type = '1';
            c.EOF_Tipologia_Servizio__c = 'test sasya1';
            c.EOF_Codice_Operatore_WS__c = 'VF';
            c.EOF_SLA_Premium_Assurance__c ='Y';
            c.Account = acc;
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c.EOF_Numero_Civico_WS__c = '7';
            c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c.EOF_Recapito_Test_Linea__c = '111';
            c.EOF_Tipologia_Apparato__c = 'test'+ i;
            c.OwnerId = userInfo.getUserId();
            c.RecordTypeId = CaseRecordTypeId;
            c.EOF_Id_Notifica__c = 'test_01';
            c.Origin = 'Web';
            c.Priority = 'Medium';
            c.EOF_GPON_Vincolante__c = 'Y';
            c.PO_SA_Portale__C = false;
            c.OF_Bonifica_Locked_Row__c = false;
            vclst.add(c);
        }
        insert vclst;
        
        Case cs = new Case();
        cs.EOF_Account_OLO__c = accOLO.Id;
        cs.Subject = 'Richiesta di attivazione';
        cs.EOF_Codice_Ordine_OLO__c = '02112016_38CO';
        cs.EOF_Data_Prevista_Attivazione__c = system.today();
        cs.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        cs.Status = 'Acquisito';
        cs.EOF_Fase__c = 'In Verifica BO';
        cs.Type = '1';
        cs.EOF_Tipologia_Servizio__c = 'test sasya1987';
        cs.EOF_Codice_Operatore_WS__c = 'VF';
        cs.EOF_SLA_Premium_Assurance__c ='Y';
        cs.Account = acc;
        cs.EOF_Identificativo_del_POP__c = 'PG_01';
        cs.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        cs.EOF_Numero_Civico_WS__c = '7';
        cs.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        cs.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        cs.EOF_Recapito_Test_Linea__c = '111';
        cs.EOF_Tipologia_Apparato__c = 'test';
        cs.OwnerId = userInfo.getUserId();
        cs.RecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_ChangeOrder_OPENSTREAM').getRecordTypeId();
        cs.EOF_Id_Notifica__c = 'test_01';
        cs.Origin = 'Web';
        cs.Priority = 'Medium';
        cs.EOF_GPON_Vincolante__c = 'Y';
        cs.PO_SA_Portale__C = false;
        cs.OF_Bonifica_Locked_Row__c = false;
        
        insert cs;
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = vclst[0].Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
    }
    static testMethod void Method1()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1'];
        
        
        OLO_ID__c  od = new OLO_ID__c();
        od.name = 'VF';
        od.OF_Olo_Id__c = clst[0].accountid;
        insert od;
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        su.STATO_ORDINE = '8';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = 'VF';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OLO = '';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OF = clst[0].id;
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.ID_NOTIFICA = '';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su); 
        su.STATO_ORDINE = '9';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        test.stopTest();
        
    }
    static testMethod void Method3()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1'];
        
        
        OLO_ID__c  od = new OLO_ID__c();
        od.name = 'VF';
        od.OF_Olo_Id__c = clst[0].accountid;
        insert od;
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        su.STATO_ORDINE = '8';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = 'VF';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OF = clst[0].id;
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.ID_NOTIFICA = '';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su); 
        
        test.stopTest();
        
    }
    static testMethod void Method2()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1'];
        
        
        OLO_ID__c  od = new OLO_ID__c();
        od.name = 'VF';
        od.OF_Olo_Id__c = clst[0].accountid;
        insert od;
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        su.CODICE_ORDINE_OF = clst[0].id;
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = 'VF';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        
        test.stopTest();
        
    }
    
    static testMethod void Method4()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1'];
        
        EOF_EAI_Service_Log__c sl = [select id, EOF_Tipo_comunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                     Caso__c,EOF_Codice_Operatore__c,EOF_Codice_Ordine_Olo__c,EOF_Data_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_ID_NOTIFICA__C,OF_SA_ESITO__C,EOF_CODICE_MOTIVAZIONE__C,
                                     EOF_MOTIVAZIONE__C,EOF_Retry__c,EOF_Codice_Errore__c,EOF_Causale_Errore__c,EOF_Codice_Ordine_EOF__c,
                                     EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_SERVICE_VLAN__C,
                                     OF_SA_ESITO_RITIRO_APPARATO__C,EOF_Nome_Cliente__c,EOF_COGNOME_CLIENTE__c,
                                     EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                     EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01' limit 1];
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        su.CODICE_ORDINE_OF = clst[0].id;
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.STATO_ORDINE = '8';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = 'VF';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        
        clst[0].EOF_codice_Ordine_OLO__c = su.CODICE_ORDINE_OLO;
        clst[0].EOF_Codice_Operatore_WS__c = su.CODICE_OPERATORE;
        update clst[0];
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        test.stopTest();
    }
    static testMethod void Method5()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1'];
        
        EOF_EAI_Service_Log__c sl = [select id, EOF_Tipo_comunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                     Caso__c,EOF_Codice_Operatore__c,EOF_Codice_Ordine_Olo__c,EOF_Data_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_ID_NOTIFICA__C,OF_SA_ESITO__C,EOF_CODICE_MOTIVAZIONE__C,
                                     EOF_MOTIVAZIONE__C,EOF_Retry__c,EOF_Codice_Errore__c,EOF_Causale_Errore__c,EOF_Codice_Ordine_EOF__c,
                                     EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_SERVICE_VLAN__C,
                                     OF_SA_ESITO_RITIRO_APPARATO__C,EOF_Nome_Cliente__c,EOF_COGNOME_CLIENTE__c,
                                     EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                     EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01' limit 1];
        
        su.STATO_ORDINE = '9';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OF = clst[0].id;
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = 'VF';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OLO = 'Test';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = string.valueof(date.today());
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.ID_NOTIFICA = '';
        String.isEmpty(su.ID_NOTIFICA);         
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        su.ID_NOTIFICA = 'Testyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        test.stopTest();
    }
    static testMethod void Method6()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1'];
        
        
        EOF_EAI_Service_Log__c sl = [select id, EOF_Tipo_comunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                     Caso__c,EOF_Codice_Operatore__c,EOF_Codice_Ordine_Olo__c,EOF_Data_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_ID_NOTIFICA__C,OF_SA_ESITO__C,EOF_CODICE_MOTIVAZIONE__C,
                                     EOF_MOTIVAZIONE__C,EOF_Retry__c,EOF_Codice_Errore__c,EOF_Causale_Errore__c,EOF_Codice_Ordine_EOF__c,
                                     EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_SERVICE_VLAN__C,
                                     OF_SA_ESITO_RITIRO_APPARATO__C,EOF_Nome_Cliente__c,EOF_COGNOME_CLIENTE__c,
                                     EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                     EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01' limit 1];
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        
        su.CODICE_ORDINE_OF = clst[0].id;
        su.CODICE_OPERATORE = 'Test';
        
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        test.stopTest();
    }
    static testMethod void Method7()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1'];
        EOF_EAI_Service_Log__c sl = [select id, EOF_Tipo_comunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                     Caso__c,EOF_Codice_Operatore__c,EOF_Codice_Ordine_Olo__c,EOF_Data_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_ID_NOTIFICA__C,OF_SA_ESITO__C,EOF_CODICE_MOTIVAZIONE__C,
                                     EOF_MOTIVAZIONE__C,EOF_Retry__c,EOF_Codice_Errore__c,EOF_Causale_Errore__c,EOF_Codice_Ordine_EOF__c,
                                     EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_SERVICE_VLAN__C,
                                     OF_SA_ESITO_RITIRO_APPARATO__C,EOF_Nome_Cliente__c,EOF_COGNOME_CLIENTE__c,
                                     EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                     EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01' limit 1];
        
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        su.STATO_ORDINE = '9';
        su.CODICE_ORDINE_OF = clst[0].id;
        su.CODICE_OPERATORE = 'Test';
        su.CODICE_ORDINE_OLO = 'Test';
        su.DATA_NOTIFICA = string.valueof(date.today());
        
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su1 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su1.ID_NOTIFICA = '';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su1);
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su2 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        su2.ID_NOTIFICA = 'testingtesttestingtesttestingtesttestingtesttestingtesttestingtesttestingtesttestingtesttestingtesttestt';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su2);
        test.stopTest();
    }
    static testMethod void Method8()
    {
        
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test1());
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());     
        
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1987'];
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        su.CODICE_ORDINE_OLO = 'Test';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = clst[0].id;
        su.DATA_NOTIFICA = string.valueOf(System.today());
        su.ID_NOTIFICA = '';
        
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        
        
        test.stopTest();
    }
    static testMethod void Method9()
    {
    	test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test1());
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());     
        
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1987'];
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
    	su.CODICE_ORDINE_OLO = 'Test';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = clst[0].id;
        su.DATA_NOTIFICA = string.valueOf(System.today());
        su.ID_NOTIFICA = 'Testyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy';
        
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
        
    }
    /*
    static testMethod void Method10()
    {
    	test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test1());
        Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());     
        
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1987'];
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
    
    	su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = clst[0].id;
        su.DATA_NOTIFICA = string.valueOf(System.today());
        su.ID_NOTIFICA = 'Testyyyyyyyyyyyyyyyyyyy';
        
        
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
    }
    */
}
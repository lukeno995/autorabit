@isTest
public class OF_CO_OM_SendToOLOTest {
    
    
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
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo; 
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract con = new contract();
        con.accountId=accOLO.id;
        con.status='Attivo';
        insert con;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=con.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
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
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.PO_SA_Portale__C = false;
       c.OF_Bonifica_Locked_Row__c = false;
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
        
    }
    static testMethod void method1()
    {
       
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'test';
        oloor.ID_RISORSA = 'test';
        oloor.CODICE_OPERATORE = 'VF';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_PROGETTO_SPECIALE = 'test';
        oloor.PROMOZIONE = 'test';
        oloor.CLUSTER_PROMOZIONE = 'test';
        oloor.NOTE = 'test';
        oloor.PROFILO = 'test';
       // oloor.VLAN = '';
       // OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'test';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'test';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan.INFORMAZIONI_VLAN = 'T';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlstcls = new list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlstcls.add(vlan);
         oloor.VLAN = vlstcls;
         OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response orolo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response();
        orolo.CODICE_MOTIVAZIONE = 'T';
        orolo.ESITO = 'T';
        orolo.ID_NOTIFICA = 'Test';
        orolo.MOTIVAZIONE = 'Test';
       
          OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
             
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        
        EOF_EAI_Service_Log__c sl = [select id, Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1];
         OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
       test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       OF_CO_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM(c,su);
      // OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl);
        test.stopTest();
    }
     static testMethod void method2()
    {
       
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'test';
        oloor.ID_RISORSA = 'test';
        oloor.CODICE_OPERATORE = 'VF';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_PROGETTO_SPECIALE = 'test';
        oloor.PROMOZIONE = 'test';
        oloor.CLUSTER_PROMOZIONE = 'test';
        oloor.NOTE = 'test';
        oloor.PROFILO = 'test';
       // oloor.VLAN = '';
       // OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'test';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'test';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan.INFORMAZIONI_VLAN = 'T';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlstcls = new list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlstcls.add(vlan);
         oloor.VLAN = vlstcls;
         OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response orolo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response();
        orolo.CODICE_MOTIVAZIONE = 'T';
        orolo.ESITO = 'T';
        orolo.ID_NOTIFICA = 'Test';
        orolo.MOTIVAZIONE = 'Test';
       
          OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
             
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        
        EOF_EAI_Service_Log__c sl = [select id, Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1];
         OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
       test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_SendToOLO_Mockcls2());
       OF_CO_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM(c,su);
      // OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl);
        test.stopTest();
    }
     static testMethod void method3()
    {
       
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'test';
        oloor.ID_RISORSA = 'test';
        oloor.CODICE_OPERATORE = 'VF';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_PROGETTO_SPECIALE = 'test';
        oloor.PROMOZIONE = 'test';
        oloor.CLUSTER_PROMOZIONE = 'test';
        oloor.NOTE = 'test';
        oloor.PROFILO = 'test';
       // oloor.VLAN = '';
       // OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'test';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'test';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan.INFORMAZIONI_VLAN = 'T';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlstcls = new list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlstcls.add(vlan);
         oloor.VLAN = vlstcls;
         OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response orolo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response();
        orolo.CODICE_MOTIVAZIONE = 'T';
        orolo.ESITO = 'T';
        orolo.ID_NOTIFICA = 'Test';
        orolo.MOTIVAZIONE = 'Test';
       
          OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
          String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        
       account acc = [select id,name from account where name='Vodafone' limit 1]; 
        
        account acc2 = [select FirstName,LastName,Phone , EOF_Phone_2__c ,EOF_Provincia__c ,EOF_Comune__c , 
                        EOF_Indirizzo__c,EOF_Particella_Toponomastica__c ,EOF_Numero_Civico__c from Account 
                        where FirstName = 'Test' limit 1];
        Case c1 = new Case();
        c1.EOF_Account_OLO__c = acc.id;
        c1.Subject = 'Richiesta di attivazione';
        c1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c1.EOF_Data_Prevista_Attivazione__c = system.today();
        c1.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c1.Status = 'Acquisito';
        c1.EOF_Fase__c = 'In Verifica BO';
        c1.Type = '1';
        c1.EOF_Tipologia_Servizio__c = 'test sasya2';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.EOF_SLA_Premium_Assurance__c ='Y';
        c1.Account = acc2;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c1.EOF_Numero_Civico_WS__c = '7';
        c1.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c1.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c1.EOF_Recapito_Test_Linea__c = '111';
        c1.EOF_Tipologia_Apparato__c = 'test';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.EOF_Id_Notifica__c = 'test_01';
        c1.Origin = 'Web';
        c1.Priority = 'Medium';
        c1.EOF_GPON_Vincolante__c = 'Y';
        c1.PO_SA_Portale__C = false;
       c1.OF_Bonifica_Locked_Row__c = false;
        insert c1;
           OF_CO_GE_Utils.caseOriginale = c1; 
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
         OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
       test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_SendToOLO_Mockcls());
        //OF_CO_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM(c,su);
        OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl);
        test.stopTest();
    }
     static testMethod void method4()
    {
       
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'test';
        oloor.ID_RISORSA = 'test';
        oloor.CODICE_OPERATORE = 'VF';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_PROGETTO_SPECIALE = 'test';
        oloor.PROMOZIONE = 'test';
        oloor.CLUSTER_PROMOZIONE = 'test';
        oloor.NOTE = 'test';
        oloor.PROFILO = 'test';
       // oloor.VLAN = '';
       // OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'test';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'test';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan.INFORMAZIONI_VLAN = 'T';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlstcls = new list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlstcls.add(vlan);
         oloor.VLAN = vlstcls;
         OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response orolo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response();
        orolo.CODICE_MOTIVAZIONE = 'T';
        orolo.ESITO = 'T';
        orolo.ID_NOTIFICA = 'Test';
        orolo.MOTIVAZIONE = 'Test';
       
          OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
          String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        
       account acc = [select id,name from account where name='Vodafone' limit 1]; 
        
        account acc2 = [select FirstName,LastName,Phone , EOF_Phone_2__c ,EOF_Provincia__c ,EOF_Comune__c , 
                        EOF_Indirizzo__c,EOF_Particella_Toponomastica__c ,EOF_Numero_Civico__c from Account 
                        where FirstName = 'Test' limit 1];
        Case c1 = new Case();
        c1.EOF_Account_OLO__c = acc.id;
        c1.Subject = 'Richiesta di attivazione';
        c1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c1.EOF_Data_Prevista_Attivazione__c = system.today();
        c1.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c1.Status = 'Acquisito';
        c1.EOF_Fase__c = 'In Verifica BO';
        c1.Type = '1';
        c1.EOF_Tipologia_Servizio__c = 'test sasya2';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.EOF_SLA_Premium_Assurance__c ='Y';
        c1.Account = acc2;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c1.EOF_Numero_Civico_WS__c = '7';
        c1.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c1.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c1.EOF_Recapito_Test_Linea__c = '111';
        c1.EOF_Tipologia_Apparato__c = 'test';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.EOF_Id_Notifica__c = 'test_01';
        c1.Origin = 'Web';
        c1.Priority = 'Medium';
        c1.EOF_GPON_Vincolante__c = 'Y';
        c1.PO_SA_Portale__C = false;
       c1.OF_Bonifica_Locked_Row__c = false;
        insert c1;
           OF_CO_GE_Utils.caseOriginale = c1; 
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
         OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
       test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_SendToOLO_MockclsNew());
        //OF_CO_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM(c,su);
        OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl);
        test.stopTest();
    }

}
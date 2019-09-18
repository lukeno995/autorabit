/*
-------------------------------------------------------------------------------------------------------
Author : Sasya  Date : 31-05-2018  Description: Test code coverage for OF_CO_OLO_EntryChecks controller
-------------------------------------------------------------------------------------------------------
*/
@isTest
public class OF_CO_OLO_EntryChecksTest {
   
    @testsetup
    static void CreateTestData()
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
        
        
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_ChangeOrder_OPENSTREAM').getRecordTypeId();
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
         Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        OF_Servizio__c GPONAttiva = new OF_Servizio__c();
        GPONAttiva.Name = 'Open Stream';
        GPONAttiva.OF_Attivo__c = true;
        GPONAttiva.OF_CatalogoCommerciale__c = catalogo.Id;
        GPONAttiva.OF_DataInizioValidita__c = myDate;
        GPONAttiva.OF_DataFineValidita__c = newDate;
        insert GPONAttiva;
        system.debug('GPONAttiva====='+GPONAttiva);
        list<OF_CommercialElementIstanziato__c> vlstofc = new list<OF_CommercialElementIstanziato__c>();
        
        OF_CommercialElement__c itemComm = new OF_CommercialElement__c();
        itemComm.OF_Servizio__c = GPONAttiva.id;
        //system.debug('OSCRM ix:'+serv.Name);
        itemComm.OF_Attivo__c=true;
        itemComm.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
        itemComm.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        itemComm.Name = 'VLAN';
        insert itemComm;
        //listCEist = GPONAttiva.CommercialElements__r[0];
        OF_CommercialElementIStanziato__c obj = new OF_CommercialElementIStanziato__c();
        obj.OF_Asset__c = a.id;
        obj.OF_CommercialElement__c = itemComm.Id;
        //vlstofc.add(obj);
        insert obj;
        system.debug('obj====='+obj);
               
    }
    static testmethod void Method1()
    {
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'test1234444444444444444444444444444444444444444444444�555';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'test1234444444444444444�44444444444444444444�555';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan.INFORMAZIONI_VLAN = 'T';
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response orolo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response();
        orolo.CODICE_MOTIVAZIONE = 'T';
        orolo.ESITO = 'T';
        orolo.ID_NOTIFICA = 'Test';
        orolo.MOTIVAZIONE = 'Test';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlast = new list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlast.add(vlan);
        oloor.VLAN = vlast;
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
       
    }
    static testMethod void method2()
    {
          Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        oloor.CODICE_OPERATORE = '';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = ''; //2017-06-01T18:30:15+01:00
            OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.ID_NOTIFICA = '';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_OPERATORE = 'VF';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.ID_NOTIFICA = 'Test';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
         oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
      //  OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
       // OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'test1234444444444444444444444444444444444444444444444�555';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'test1234444444444444444�44444444444444444444�555';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan.INFORMAZIONI_VLAN = 'T';
        
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlast = new list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlast.add(vlan);
        oloor.VLAN = vlast;
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = '';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = '�';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        //OF_CO_GE_Utils.checkCaseOriginale = true;
        oloor.DATA_NOTIFICA = '';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.ID_NOTIFICA = '';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
    }
    static testmethod void Method3()
    {
        
          Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c,EOF_Codice_Operatore_WS__c, 
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'test1234444444444444444�44444444444444444444�55599999999999';
        oloor.ID_RISORSA = 'test1234444444444444444�44444444444444444444�55599999999999';
        oloor.CODICE_OPERATORE = 'VF';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_PROGETTO_SPECIALE = 'test1234444444444444444�44444444444444444444�55599999999999';
        oloor.PROMOZIONE = 'test1234444444444444444�44444444444444444444�55599999999999';
        oloor.CLUSTER_PROMOZIONE = 'test1234444444444444444�44444444444444444444�55599999999999';
        oloor.NOTE = 'test1234444444444444444�44444444444444444444�55599999999999test1234444444444444444�44444444444444444444�55599999999999test1234444444444444444�44444444444444444444�55599999999999test1234444444444444444�44444444444444444444�55599999999999test1234444444444444444�44444444444444444444�55599999999999';
        oloor.PROFILO = 'test1234444444444444444�44444444444444444444�55599999999999';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.CODICE_ORDINE_OLO = 'test1234444444444444444444444444444444444444444444444�555';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'test1234444444444444444�44444444444444444444�555';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan.INFORMAZIONI_VLAN = 'T';
        
         OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan1 = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan1.KIT_CONSEGNA_VLAN = 'T';
        vlan1.USER_VLAN = 'T';
        vlan1.SERVICE_VLAN = 'T';
        vlan1.PROFILO_VLAN = 'T';
        vlan1.CUSTOMER_VLAN = 'T';
        vlan1.MODELLO_DI_SERVIZIO_VLAN = 'T';
        vlan1.INFORMAZIONI_VLAN = 'T';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlast = new list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlast.add(vlan);
        vlast.add(vlan1);
        oloor.VLAN = vlast;
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        oloor.ID_NOTIFICA = 'test123444444444444444444444444444444444444555999999999999999999999999999999999999999999999999999999999999999999999999999999999999999';
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
    }
    static testMethod void method4()
    {
          
          Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
           // Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
            
          case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
                 
                // OF_CO_GE_Utils.caseOriginale = c;
       
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
         OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        vlan.KIT_CONSEGNA_VLAN = 'test�test�testeste';
         OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         test.stopTest();
       
    }
    static testMethod void method5()
    {
          
          Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
           // Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
            
          case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
                 
                // OF_CO_GE_Utils.caseOriginale = c;
       
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
        vlan.KIT_CONSEGNA_VLAN = 'TestingTesting�';
        vlan.USER_VLAN = 'TestingTesting�';
        vlan.SERVICE_VLAN = 'TestingTesting�';
        vlan.PROFILO_VLAN = 'TestingTesting�';
        vlan.CUSTOMER_VLAN = 'TestingTesting�';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'TestingTesting�';
        vlan.INFORMAZIONI_VLAN = 'TestingTesting�';
        //OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlstcls = new list< OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlstcls.add(vlan);
         oloor.VLAN = vlstcls;
          OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response orolo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Response();
        orolo.CODICE_MOTIVAZIONE = 'Testing�';
        orolo.ESITO = 'Testing�';
        orolo.ID_NOTIFICA = 'Testing�';
        orolo.MOTIVAZIONE = 'Testing�';
         OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
       
         test.stopTest();
       
    }
    static testMethod void Method6()
    {
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = '';
        vlan.USER_VLAN = '';
        vlan.SERVICE_VLAN = '';
        vlan.PROFILO_VLAN = '';
        vlan.CUSTOMER_VLAN = '';
        vlan.MODELLO_DI_SERVIZIO_VLAN = '';
        vlan.INFORMAZIONI_VLAN = '';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlanlst = new  list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlanlst.add(vlan);
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        oloor.VLAN = vlanlst;
         Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         vlan.KIT_CONSEGNA_VLAN ='Testing�';
         OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        test.stopTest();
    }
      static testMethod void Method7()
    {
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = '�';
        vlan.USER_VLAN = '�';
        vlan.SERVICE_VLAN = '�';
        vlan.PROFILO_VLAN = '�';
        vlan.CUSTOMER_VLAN = '�';
        vlan.MODELLO_DI_SERVIZIO_VLAN = '�';
        vlan.INFORMAZIONI_VLAN = '�';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlanlst = new  list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlanlst.add(vlan);
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        oloor.VLAN = vlanlst;
         Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         vlan.KIT_CONSEGNA_VLAN ='Testing�';
         OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
        test.stopTest();
    }
    
        static testMethod void Method8()
    {
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'T';
        vlan.USER_VLAN = '�';
        vlan.SERVICE_VLAN = '�';
        vlan.PROFILO_VLAN = '�';
        vlan.CUSTOMER_VLAN = '�';
        vlan.MODELLO_DI_SERVIZIO_VLAN = '�';
        vlan.INFORMAZIONI_VLAN = '�';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlanlst = new  list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlanlst.add(vlan);
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        oloor.VLAN = vlanlst;
         Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
          vlan.USER_VLAN = 'Testing�';  
          OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         
        test.stopTest();
    }
         static testMethod void Method9()
    {
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'T';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = '�';
        vlan.PROFILO_VLAN = '�';
        vlan.CUSTOMER_VLAN = '�';
        vlan.MODELLO_DI_SERVIZIO_VLAN = '�';
        vlan.INFORMAZIONI_VLAN = '�';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlanlst = new  list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlanlst.add(vlan);
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        oloor.VLAN = vlanlst;
         Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
          vlan.SERVICE_VLAN = 'Testing�';  
          OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         
        test.stopTest();
    }
    
    
    
       static testMethod void Method10()
    {
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'T';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = '�';
        vlan.CUSTOMER_VLAN = '�';
        vlan.MODELLO_DI_SERVIZIO_VLAN = '�';
        vlan.INFORMAZIONI_VLAN = '�';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlanlst = new  list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlanlst.add(vlan);
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        oloor.VLAN = vlanlst;
         Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
          vlan.PROFILO_VLAN = 'Testing�';  
          OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         
        test.stopTest();
    }
    
     static testMethod void Method11()
    {
          case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'T';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = '�';
        vlan.MODELLO_DI_SERVIZIO_VLAN = '�';
        vlan.INFORMAZIONI_VLAN = '�';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlanlst = new  list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlanlst.add(vlan);
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        oloor.VLAN = vlanlst;
         Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
          vlan.CUSTOMER_VLAN = 'Testing�';  
          OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         
        test.stopTest();
    }
    
    
    
      static testMethod void Method12()
    {
          case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, EOF_Codice_Operatore_WS__c,
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
                  
                  OLO_ID__c  od = new OLO_ID__c();
                  
                 od.name = 'VF';
                 od.OF_Olo_Id__c = c.accountid;
                 insert od;
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request oloor = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'T';
        vlan.USER_VLAN = 'T';
        vlan.SERVICE_VLAN = 'T';
        vlan.PROFILO_VLAN = 'T';
        vlan.CUSTOMER_VLAN = 'T';
        vlan.MODELLO_DI_SERVIZIO_VLAN = '�';
        vlan.INFORMAZIONI_VLAN = '�';
        list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN> vlanlst = new  list<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        vlanlst.add(vlan);
        oloor.CODICE_OPERATORE = 'VF';
        oloor.CODICE_ORDINE_OLO = 'Test';
        oloor.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        oloor.ID_NOTIFICA = 'Test';
        oloor.ID_RISORSA = 'Test';
        oloor.CODICE_PROGETTO_SPECIALE = 'Test';
        oloor.PROMOZIONE = 'Test';
        oloor.CLUSTER_PROMOZIONE = 'Test';
        oloor.NOTE = 'Testing';
        oloor.PROFILO = 'Test';
        oloor.VLAN = vlanlst;
         Test.startTest();
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
          vlan.MODELLO_DI_SERVIZIO_VLAN = 'Testing�';  
          OF_CO_OLO_EntryChecks.SyncChecksChangeSetup(oloor);
         
        test.stopTest();
    }
    
    
    
    
    
    
    
}
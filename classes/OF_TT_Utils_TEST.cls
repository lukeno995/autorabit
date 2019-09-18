@isTest 
public with sharing class OF_TT_Utils_TEST {
    
    public static Account accOlo;
    public static Account acc;
    public static Case c;
    public static OF_TT_WS_TroubleTicketRequest.TroubleTicket tt;
    public static User testUser;
    public static Group bo;
    public static Profile p;
    public static Asset a;
    public static EOF_Notify__c nGPON;
    public static EOF_Notify__c n;
    public static OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse rttr;
    public static String s;
    public static String y='Y';
    public static EOF_EAI_Service_Log__c  eaiLog;
    
    
    
     
    public static testmethod void test1(){

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch

        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;     
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                         LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
                 
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_CODICE_COMUNICAZIONE_OLO__c = 'testalo';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------

         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = '3083252521';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '255456';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'TITO LABIENO';
        // tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.VERIFICA_APPARATO_CLIENTE = y;
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         tt.CAUSALE_RICHIESTA_ANNULLAMENTO='1';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id; 
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('TroubleTicketRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_CODICE_COMUNICAZIONE_OLO__c = 'testalo';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        //String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        
        //Start test1
        Test.startTest();
        
        
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        rttr = OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
        
                
        rttr = OF_TT_Utils.syncError(tt,'A_K6','TestField');
        OF_TT_Utils.create_EAI_Log(nGPON);
        OF_TT_Utils.create_EAI_Log(tt);
        OF_TT_Utils.copy_tt_request(tt);
        OF_TT_Utils.copy_TT_notify(nGPON);
        //OF_TT_Utils.updateFiberNotify(nGPON);
        OF_TT_Utils.create_EAI_Log(c);
        
        
        String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
        n = new EOF_Notify__c();
        n.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        n.EOF_ID_Notifica__c = 'Test Id';
        n.EOF_Stato_Richiesta__c = 'OK';
        n.EOF_Codice_Operatore__c = 'VF';
        n.EOF_GPON_Attestazione__c = 'Test Gpon';
        n.EOF_Data_Notifica__c = system.now();
        n.EOF_Note__c = 'Test Note';
        n.EOF_Inviata__c = false;
        n.Caso__c = c.id;
        n.RecordTYpeId = NotifyRecordTypeId1;
        
        insert n;
       
        
        OF_TT_Utils.setNotify(n);
        n=OF_TT_Utils.getNotify();
        
        OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'TT_ACK', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => c.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
        OF_TT_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'Trouble Ticket - Richiesta Scartata', 'Codice_operatore' => tt.CODICE_OPERATORE, 'Codice_comunicazione_OLO' => tt.CODICE_COMUNICAZIONE_OLO,    
                                                    'ID_notifica' => tt.ID_NOTIFICA, 'CaseId' => c.Id, 'TT_Request'=>OF_TT_Utils.copy_TT_Request(tt), 'Tipo Comunicazione' => tt.TIPO_COMUNICAZIONE});
        s = OF_TT_Utils.dateToString(System.now());
        OF_TT_Utils.StringToDate(s);
        OF_TT_Utils.stringToDateNoTime(s);
        
        Boolean theBool = true;
        String theString = (theBool) ? 'true' : 'false';
        OF_TT_Utils.checkDate(theString);
        OF_TT_Utils.checkTime(theString);
        OF_TT_Utils.checkDateTime(theString);
        
                
        tt.TIPO_COMUNICAZIONE='1';          
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        tt.TIPO_COMUNICAZIONE='6';
        tt.TELEFONO_REFERENTE_TECNICO_OLO='x';
        tt.NOME_REFERENTE_TECNICO_OLO='x';
        tt.EMAIL_REFERENTE_TECNICO_OLO='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.NOME_REFERENTE_TECNICO_OLO='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='x';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.NOME_REFERENTE_TECNICO_OLO='x';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.EMAIL_REFERENTE_TECNICO_OLO='x';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.EMAIL_REFERENTE_TECNICO_OLO='xxx@email.it';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        Test.stopTest();
    }
    
    
    public static testmethod void test2(){  

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
       
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
        /*
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON2 = new EOF_Notify__c();
        nGPON2.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON2.EOF_ID_Notifica__c = 'Test Id';
        nGPON2.EOF_Stato_Richiesta__c = 'OK';
        nGPON2.EOF_Codice_Operatore__c = 'VF';
        nGPON2.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON2.EOF_Data_Notifica__c = system.now();
        nGPON2.EOF_Note__c = 'Test Note';
        nGPON2.EOF_Inviata__c = true;
        //nGPON.Update = false;
        nGPON2.Caso__c = c.id;
        nGPON2.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON2;
        */
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //previous Start test7
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,10,'','');
     //   OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    //  OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        /*
        c.status='Sospeso';
        c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        */
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now());
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
 //     OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
   //   OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        tt.TIPO_COMUNICAZIONE='8';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        OF_TT_Utils.createAckNackNotifyServiceLog(nGPON.id);
        test.stopTest();
    }
    
     public static testmethod void test3(){  

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test8 
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,10,'','');
      //OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxx';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        c.status='Sospeso';
        c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now());
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
    //  OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
   //   OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        tt.TIPO_COMUNICAZIONE='8';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        test.stopTest();
    }
    
     public static testmethod void test4(){  

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OF_TT_Parametri__c par =new OF_TT_Parametri__c(); 
        par.EOF_Num_min_ritorno_in_lavorazione__c=5;
        insert par;
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.Type='OLO';
        insert acc;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test9
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,10,'','');
     //   OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        c.status='Sospeso';
        c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now().addDays(1));
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
        tt.data_ora_desospensione=OF_TT_Utils.DateToString(OF_TT_Utils.now().addDays(1));
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
    //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
           
        tt.TIPO_COMUNICAZIONE='8';
     //   OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        test.stopTest();
    }

        
    public static testmethod void test5(){ 

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
         
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
          
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account(); 
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'xyz';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        //String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        
        //Start test10
        Test.starttest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        tt.EMAIL_REFERENTE_TECNICO_OLO='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.NOME_REFERENTE_TECNICO_OLO='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='333';
        tt.NOME_REFERENTE_TECNICO_OLO='Ale';
        tt.EMAIL_REFERENTE_TECNICO_OLO='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx@it.it';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.NOME_REFERENTE_TECNICO_OLO='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        tt.TELEFONO_REFERENTE_TECNICO_OLO='333';
        tt.NOME_REFERENTE_TECNICO_OLO='Ale';
        tt.EMAIL_REFERENTE_TECNICO_OLO='xxxxxx@it.it';
        
        
            
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        OF_TT_Case_Buttons_Controller bt = new OF_TT_Case_Buttons_Controller(sc);
    //  bt.richiestaChiusura();
    //  bt.sospendi();
    //  bt.desospendi();
        bt.annulla();
        bt.PrendiInCarico();
        bt.deleteNotifyNotSent();
        
        Test.setCurrentPageReference(new PageReference('Page.myPage'));
        sc = new ApexPages.StandardController(c);
        System.currentPageReference().getParameters().put('Id', c.Id);
        System.debug('L id del case è: '+System.currentPageReference().getParameters().get('Id'));      
        OF_TT_PhaseTransictions_Controller ptc = new OF_TT_PhaseTransictions_Controller(sc);
        ptc.inviaOnField();
        ptc.inviaInCollaudo();
        ptc.inviaInAnalisi(); 
        
        for(Integer i=0; i < 22; i+1){
            
            Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
            OF_TT_Utils.getValueTipoComunicazione(OF_TT_Utils.getStringTipoComunicazione(i+'')); 
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleApertura(i+'');
            OF_TT_Utils.getStringCategoriaGuasto(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            
            i=i+1;
        }
        Test.stopTest();
    }

    
    public static testmethod void test6(){ 

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase

        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.EOF_ID_Building_WS__c ='10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
             
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'WN';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = '';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='2';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Cessato';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test14
       test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,10,'','');
      //  OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        c.status='Scartato';
        //c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        //c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now());
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
           
         test.stopTest();
    }
    
      public static testmethod void test7(){ 

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
         
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
                
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'xyz';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
//         tt.CAUSALE_RICHIESTA_ANNULLAMENTO='1';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Codice_Comunicazione_OLO__c='Test';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        insert eaiLog;
        
        //modifiche per entrare negli errori
        a.status='Cessato';
        update a;
        
        //Start test5
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        c = [select Id,EOF_codice_Operatore_WS__c,EOF_categoria_guasto__c,EOF_ID_Risorsa__c,Status,
                            Eof_fase__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Codice_Comunicazione_OLO__c,
                            EOF_Comunicazioni_con_OLO__c,EOF_Num_min_risoluzione_Ticket__c,EOF_Data_Max_Risoluzione_Ticket__c,
                            EOF_Secondi_Sospesi_allo_SLA__c, EOF_SLA_Premium_Assurance__c, EOF_Collaudi_Negativi__c,
                            EOF_Causale_Sospensione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Account_OLO__c 
                            from Case where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO];
         tt.tipo_comunicazione='9';
         OF_TT_EntryChecks.checkAsync(c,tt);
         tt.data_ora_richiesta_annullamento=OF_TT_Utils.DateToString(OF_TT_Utils.now());
         OF_TT_EntryChecks.checkAsync(c,tt);
         c.status='In Lavorazione';
         c.canModify__c=true;
        //EC  il metodo di test 17  di EntryChecks_TEST potrebbe fallire su questo update
        try{
        update c;
        }
        catch(Exception e){
             System.debug('The following exception has occurred: ' + e.getMessage());
        }
        OF_TT_EntryChecks.checkAsync(c,tt);
         OF_TT_Utils.updateSlPortale(nGPON.id);
         //OF_TT_Utils.createAckNackNotify_TTeTTM_ServiceLog(nGPON.id);
        test.stopTest();
    }
    
    public static testmethod void test8(){ 


         
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'WIND';
        accOLO.EOF_Codice_Operatore__c = 'WN';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
        c.EOF_ID_Risorsa__c = null;
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = null;
        c.EOF_Fase__c = null;
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'WN';
        c.EOF_SLA_Premium_Assurance__c ='N';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c= null;
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = null;
         tt.ID_RISORSA = null;
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'xyz';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Cessato';
        a.EOF_ID_Risorsa__c = null;
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test11
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        /*
        OF_TT_EntryChecks.checkAsync(c, tt);
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        OF_TT_EntryChecks.checkAsync(c, tt);
        tt.COGNOME_CLIENTE='';
        OF_TT_EntryChecks.checkAsync(c, tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        OF_TT_EntryChecks.checkAsync(c, tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        OF_TT_EntryChecks.checkAsync(c, tt);
         
        c.status='Sospeso';
        OF_TT_EntryChecks.checkAsync(c, tt);
        c.EOF_Fase__c='Sospeso Analisi';
        OF_TT_EntryChecks.checkAsync(c, tt);
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        OF_TT_EntryChecks.checkAsync(c, tt);
        c.EOF_ID_RISORSA__C='Test';
        OF_TT_EntryChecks.checkAsync(c, tt);
         
       
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now());
        OF_TT_EntryChecks.checkAsync(c, tt);
        */
        tt.TIPO_COMUNICAZIONE='6';
        OF_TT_EntryChecks.checkAsync(c, tt);
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.REFERENTE_DESOSPENSIONE = null;
        OF_TT_EntryChecks.checkAsync(c, tt); 
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
        OF_TT_EntryChecks.checkAsync(c, tt);
        tt.TIPO_COMUNICAZIONE='9';
        OF_TT_EntryChecks.checkAsync(c, tt);
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
        OF_TT_EntryChecks.checkAsync(c, tt);
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
         test.stopTest();
    }

     public static testmethod void test9(){  

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
         
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OF_TT_Parametri__c par =new OF_TT_Parametri__c(); 
        par.EOF_Num_min_ritorno_in_lavorazione__c=5;
        insert par;
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.Type='OLO';
        insert acc;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test9
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,2,'','');
     //   OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        c.status='Sospeso';
        c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now().addDays(1));
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
        tt.data_ora_desospensione=OF_TT_Utils.DateToString(OF_TT_Utils.now().addDays(1));
     //   OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
           
        tt.TIPO_COMUNICAZIONE='8';
  //      OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        test.stopTest();
    }
    
    public static testmethod void test10(){  

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OF_TT_Parametri__c par =new OF_TT_Parametri__c(); 
        par.EOF_Num_min_ritorno_in_lavorazione__c=5;
        insert par;
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.Type='OLO';
        insert acc;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test9
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,10,'','');
     //   OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        c.status='Sospeso';
        c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now().addDays(1));
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
        tt.data_ora_desospensione=OF_TT_Utils.DateToString(OF_TT_Utils.now().addDays(1));
       // OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
     //   OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
           
        tt.TIPO_COMUNICAZIONE='8';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        test.stopTest();
    }
    
    public static testmethod void test11(){

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
          
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        //String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        //Start test5
        Test.starttest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        tt.EMAIL_REFERENTE_TECNICO_OLO='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.NOME_REFERENTE_TECNICO_OLO='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='333';
        tt.NOME_REFERENTE_TECNICO_OLO='Ale';
        tt.EMAIL_REFERENTE_TECNICO_OLO='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx@it.it';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TELEFONO_REFERENTE_TECNICO_OLO='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.NOME_REFERENTE_TECNICO_OLO='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        tt.TELEFONO_REFERENTE_TECNICO_OLO='333';
        tt.NOME_REFERENTE_TECNICO_OLO='Ale';
        tt.EMAIL_REFERENTE_TECNICO_OLO='xxxxxx@it.it';
        
        
            
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        OF_TT_Case_Buttons_Controller bt = new OF_TT_Case_Buttons_Controller(sc);
        bt.richiestaChiusura();
        bt.sospendi();
        bt.desospendi();
        Test.setCurrentPageReference(new PageReference('Page.myPage'));
        sc = new ApexPages.StandardController(c);
        System.currentPageReference().getParameters().put('Id', c.Id);
        System.debug('L id del case è: '+System.currentPageReference().getParameters().get('Id'));      
        OF_TT_PhaseTransictions_Controller ptc = new OF_TT_PhaseTransictions_Controller(sc);
        ptc.inviaOnField();
        ptc.inviaInCollaudo();
        ptc.inviaInAnalisi(); 
        
        for(Integer i=0; i < 22; i+1){
            
            Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
            OF_TT_Utils.getValueTipoComunicazione(OF_TT_Utils.getStringTipoComunicazione(i+'')); 
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleApertura(i+'');
            OF_TT_Utils.getStringCategoriaGuasto(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            OF_TT_Utils.getStringCausaleDesospensione(i+'');
            
            i=i+1;
        }
        Test.stopTest();
    }
    
    public static testmethod void test12(){  

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
       
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
        /*
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON2 = new EOF_Notify__c();
        nGPON2.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON2.EOF_ID_Notifica__c = 'Test Id';
        nGPON2.EOF_Stato_Richiesta__c = 'OK';
        nGPON2.EOF_Codice_Operatore__c = 'VF';
        nGPON2.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON2.EOF_Data_Notifica__c = system.now();
        nGPON2.EOF_Note__c = 'Test Note';
        nGPON2.EOF_Inviata__c = true;
        //nGPON.Update = false;
        nGPON2.Caso__c = c.id;
        nGPON2.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON2;
        */
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //previous Start test7
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST1());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,10,'','');
     //   OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    //  OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        /*
        c.status='Sospeso';
        c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        */
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now());
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
 //     OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
   //   OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        tt.TIPO_COMUNICAZIONE='8';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        OF_TT_Utils.createAckNackNotifyServiceLog(nGPON.id);
        test.stopTest();
    }
    
    public static testmethod void test13(){ 

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase

        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.EOF_ID_Building_WS__c ='10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
             
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'WN';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = '';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='2';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = True;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Cessato';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test14
       test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,13,'','');
      //  OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        c.status='Scartato';
        //c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        //c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now());
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
         OF_TT_Utils.getValueCausaleSospensione('Test');
         OF_TT_Utils.getValueCausaleScarto('Test');
         test.stopTest();
    }
    
          public static testmethod void test14(){ 

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
         
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
                
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'xyz';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
//         tt.CAUSALE_RICHIESTA_ANNULLAMENTO='1';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Codice_Comunicazione_OLO__c='Test';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        insert eaiLog;
        
        //modifiche per entrare negli errori
        a.status='Cessato';
        update a;
        
        //Start test5
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST2());
        c = [select Id,EOF_codice_Operatore_WS__c,EOF_categoria_guasto__c,EOF_ID_Risorsa__c,Status,
                            Eof_fase__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Codice_Comunicazione_OLO__c,
                            EOF_Comunicazioni_con_OLO__c,EOF_Num_min_risoluzione_Ticket__c,EOF_Data_Max_Risoluzione_Ticket__c,
                            EOF_Secondi_Sospesi_allo_SLA__c, EOF_SLA_Premium_Assurance__c, EOF_Collaudi_Negativi__c,
                            EOF_Causale_Sospensione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Account_OLO__c 
                            from Case where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO];
         tt.tipo_comunicazione='9';
         OF_TT_EntryChecks.checkAsync(c,tt);
         tt.data_ora_richiesta_annullamento=OF_TT_Utils.DateToString(OF_TT_Utils.now());
         OF_TT_EntryChecks.checkAsync(c,tt);
         c.status='In Lavorazione';
         c.canModify__c=true;
        //EC  il metodo di test 17  di EntryChecks_TEST potrebbe fallire su questo update
        try{
        update c;
        }
        catch(Exception e){
             System.debug('The following exception has occurred: ' + e.getMessage());
        }
        OF_TT_EntryChecks.checkAsync(c,tt);
        // OF_TT_Utils.updateSlPortale(nGPON.id);
         OF_TT_Utils.createAckNackNotify_TTeTTM_ServiceLog(nGPON.id);
         OF_TT_Utils.calcoloSLA(false);
        test.stopTest();
    }
    
              public static testmethod void test15(){ 

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
         
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
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
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
                
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'xyz';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
//         tt.CAUSALE_RICHIESTA_ANNULLAMENTO='1';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Codice_Comunicazione_OLO__c='Test';
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Codice_Comunicazione_OLO__c='Test';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        insert eaiLog;
        
        //modifiche per entrare negli errori
        a.status='Cessato';
        update a;
        
        //Start test5
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST3());
        c = [select Id,EOF_codice_Operatore_WS__c,EOF_categoria_guasto__c,EOF_ID_Risorsa__c,Status,
                            Eof_fase__c,EOF_Minuti_rimanenti_sospesi__c,EOF_Codice_Comunicazione_OLO__c,
                            EOF_Comunicazioni_con_OLO__c,EOF_Num_min_risoluzione_Ticket__c,EOF_Data_Max_Risoluzione_Ticket__c,
                            EOF_Secondi_Sospesi_allo_SLA__c, EOF_SLA_Premium_Assurance__c, EOF_Collaudi_Negativi__c,
                            EOF_Causale_Sospensione__c,EOF_Rischedulazione_Appuntamento__c,EOF_Account_OLO__c 
                            from Case where EOF_Codice_Comunicazione_OLO__c=:tt.CODICE_COMUNICAZIONE_OLO];
         tt.tipo_comunicazione='9';
         OF_TT_EntryChecks.checkAsync(c,tt);
         tt.data_ora_richiesta_annullamento=OF_TT_Utils.DateToString(OF_TT_Utils.now());
         OF_TT_EntryChecks.checkAsync(c,tt);
         c.status='In Lavorazione';
         c.canModify__c=true;
        //EC  il metodo di test 17  di EntryChecks_TEST potrebbe fallire su questo update
        try{
        update c;
        }
        catch(Exception e){
             System.debug('The following exception has occurred: ' + e.getMessage());
        }
        OF_TT_EntryChecks.checkAsync(c,tt);
        // OF_TT_Utils.updateSlPortale(nGPON.id);
         OF_TT_Utils.createAckNackNotify_TTeTTM_ServiceLog(nGPON.id);
         OF_TT_Utils.calcoloSLA(true);

        test.stopTest();
    }
    
    public static testmethod void test16(){  

        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
         // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        //AS Custom settings
        OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;  
        
        p = [SELECT Id FROM Profile WHERE Name='OF_TT_BO_Analisi'];
        
        testUser = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1980@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', 
                        LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1980@camfed.org');
        
        insert testUser;
        
        bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        
        OF_TT_Parametri__c par =new OF_TT_Parametri__c(); 
        par.EOF_Num_min_ritorno_in_lavorazione__c=5;
        insert par;
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        acc = new Account();
        acc.Name = 'Test Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.Type='OLO';
        insert acc;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta Risoluzione Guasto';
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
        c.OwnerId = testUser.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Descrizione_Intervento_Risoluzione__c='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
        c.EOF_Codice_comunicazione_olo__c='testalo';
        insert c;
        
        
        
        
        //-------------Trouble Ticket Creation----------------
         tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
         tt.TIPO_COMUNICAZIONE = '1';
         tt.CODICE_OPERATORE = 'VF';
         tt.ID_NOTIFICA = 'test_01';
         tt.ID_RISORSA = 'Test';
         tt.NOME_CLIENTE = 'Franco';
         tt.COGNOME_CLIENTE = 'Daje';
         tt.RECAPITO_TELEFONICO_CLIENTE_1 = 'ijppok';
         tt.RECAPITO_TELEFONICO_CLIENTE_2 = '';
         tt.NOTE = 'xyz';
         tt.CODICE_COMUNICAZIONE_OLO = 'testalo';
         tt.REFERENTE_DESOSPENSIONE = 'xyz';
         tt.VERIFICA_APPARATO_CLIENTE = 'N';
         tt.NOME_REFERENTE_TECNICO_OLO='xyz';
         tt.TELEFONO_REFERENTE_TECNICO_OLO='xyz';
         tt.EMAIL_REFERENTE_TECNICO_OLO='xyz@test.it';
         tt.CAUSALE_DESOSPENSIONE='3';
         tt.CATEGORIA_GUASTO='2';
         tt.CAUSALE_APERTURA='4';
         
        //-------------Trouble Ticket Ends-----------------------
        
    
        String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Trouble Ticket - Notifica di Richiesta Chiusura').getRecordTypeId();
        nGPON = new EOF_Notify__c();
        nGPON.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        nGPON.EOF_Codice_comunicazione_olo__c='testalo';
        nGPON.EOF_ID_Notifica__c = 'Test Id';
        nGPON.EOF_Stato_Richiesta__c = 'OK';
        nGPON.EOF_Codice_Operatore__c = 'VF';
        nGPON.EOF_GPON_Attestazione__c = 'Test Gpon';
        nGPON.EOF_Data_Notifica__c = system.now();
        nGPON.EOF_Note__c = 'Test Note';
        nGPON.EOF_Inviata__c = false;
        //nGPON.Update = false;
        nGPON.Caso__c = c.id;
        nGPON.RecordTYpeId = NotifyRecordTypeId;
        
        insert nGPON;
       // Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c FROM Asset WHERE EOF_ID_Risorsa__c=: originalcase.EOF_ID_Risorsa__c AND Status = 'Attivo']; 
        a = new Asset();
        a.Name= 'Test Asset';
        a.Status = 'Attivo';
        a.EOF_ID_Risorsa__c = 'Test';
        a.AccountId = accOLO.Id;  
        insert a;
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
       
       //Start test9
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        OF_TT_Utils.create_notify(c,3,'','');
        OF_TT_Utils.create_notify(c,4,'','');
        OF_TT_Utils.create_notify(c,5,'','');
        OF_TT_Utils.create_notify(c,7,'','');
        OF_TT_Utils.create_notify(c,10,'','');
     //   OF_TT_Utils.create_notify(c,13,'','');
        
        tt.RECAPITO_TELEFONICO_CLIENTE_1='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='x';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        //OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.COGNOME_CLIENTE='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        
        c.status='Richiesta Chiusura';
        c.EOF_Fase__c='Sospeso Analisi';
        c.EOF_Categoria_Guasto__c=OF_TT_Utils.getStringCategoriaGuasto('2');
        c.EOF_ID_RISORSA__C='Test';
        c.EOF_Minuti_rimanenti_sospesi__c=1300;
        update c;
        
        
        tt.DATA_ORA_DESOSPENSIONE=OF_TT_Utils.DateToString(system.now().addDays(1));
        tt.TIPO_COMUNICAZIONE='6';
        tt.nome_cliente='Mario';
        tt.COGNOME_CLIENTE='rossi';
        tt.RECAPITO_TELEFONICO_CLIENTE_1='34255';
        tt.RECAPITO_TELEFONICO_CLIENTE_2='34255';
        tt.EMAIL_REFERENTE_TECNICO_OLO='akokonionik@test.it';
        tt.CATEGORIA_GUASTO='2';
        tt.data_ora_desospensione=OF_TT_Utils.DateToString(OF_TT_Utils.now().addDays(1));
        OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        tt.TIPO_COMUNICAZIONE='9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO='Annullato';
    //    OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
           
        tt.TIPO_COMUNICAZIONE='8';
     //   OF_TT_WS_TroubleTicketRequest.troubleTicket(tt);
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO OLO/CLIENTE: SOSTITUZIONE ONT CLIENTE');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO OLO/CLIENTE: RESET CPE/ONT CLIENTE');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO OLO/CLIENTE: SOSTITUZIONE BRETELLA OTTICA');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RIBALTAMENTO EFFETTUATO');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO MEDIANTE INTERVENTO CONGIUNTO');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('CHIUSO PER TIMEOUT_OK');
        OF_TT_Utils.getValueStatoTicket('Richiesta Chiusura');
        OF_TT_Utils.getValueCausaleScarto('Formato dati errato o incompleto');
        OF_TT_Utils.getValueCausaleScarto('Ticket aperto per stesso ID risorsa');
        OF_TT_Utils.getValueCausaleScarto('ID Risorsa Inesistente');
        OF_TT_Utils.getValueCausaleScarto('Codice Comunicazione OLO già presente');
        OF_TT_Utils.getValueCausaleScarto('Guasto Aperto come Post-Provisioning oltre i termini previsti');
        OF_TT_Utils.getValueCausaleSospensione('SEDE OLO/CLIENTE FINALE INACCESSIBILE');
        OF_TT_Utils.getValueCausaleSospensione('CLIENTE IRREPERIBILE');
        OF_TT_Utils.getValueCausaleSospensione('CLIENTE INDISPONIBILE');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO: TRATTA VERTICALE');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO TRATTA ORIZZONTALE: CENTRALE');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO TRATTA ORIZZONTALE: RETE PRIMARIA');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO TRATTA ORIZZONTALE: RETE SECONDARIA');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('NON RISCONTRATO: SENZA USCITA');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('NON RISCONTRATO: CON USCITA');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO: SBRACCIO');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO: BORCHIA OTTICA');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('NON RISOLVIBILE: CAUSA IMPIANTO CLIENTE');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('NON RISOLVIBILE: CAUSA CPE CLIENTE');
        OF_TT_Utils.getValueDescrizioneInterventoRisoluzione('RISOLTO OLO/CLIENTE: CONFIGURAZIONE CPE/ONT CLIENTE');
        test.stopTest();
    }

   

  }
@isTest
public class OF_SA_OLO_EntryChecksNew_Test {

    Static String testStrBlw10Chars = 'TestTest';
    Static String testStrBlw20Chars = 'TestTestTestTest';
    Static String testStrBlw50Chars = 'TestTestTestTestTestTestTestTestTestTestTestTest';
    
    Static String testStrAbv20Chars = 'TestTestTestTestTestTest';
    Static String testStrAbv50Chars = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
    Static String testStrAbv70Chars = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
    Static String testStrAbv100Chars = testStrAbv70Chars + testStrAbv50Chars;
    
    Static String testStrBlw10CharsWithSplCh = 'Test�Test';
    Static String testStrWithSplChars = 'TestTest�TestTest';
    
    @testSetup
    public static void testDataSetup(){
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '9876543';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'CNN';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        insert c;
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.Name = 'CNN';
        oloId.OF_Olo_Id__c = '0018E00000dbbWiQAI';
        insert oloId;
    }
    
    public static testMethod void SyncChcksActvtnNewTestMethodPositive(){
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '9876543';
        
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c From Case LIMIT 1];
        cs.EOF_Codice_Ordine_OLO__c = act.CODICE_ORDINE_OLO;
        update cs;
        
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        Test.startTest();
        
        act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '98765431';
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrAbv20Chars;
        act.NOME_REFERENTE_TECNICO_OLO = testStrAbv20Chars;
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrAbv20Chars;
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrBlw20Chars;
        act.EMAIL_REFERENTE_TECNICO_OLO = 'test.test@test.com';
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrBlw20Chars;
        act.NOME_CLIENTE = testStrBlw20Chars;
        act.COGNOME_CLIENTE = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrBlw20Chars;
        act.DATA_PREVISTA_ATTIVAZIONE = '2018-07-19';
        act.ORARIO_APPUNTAMENTO = '11:11:11';
        act.CODICE_PROGETTO_SPECIALE = testStrBlw20Chars;
        act.PROMOZIONE = testStrBlw20Chars;
        act.CLUSTER_PROMOZIONE = testStrBlw20Chars;
        act.NOTE = testStrBlw20Chars;
        act.ID_BUILDING = testStrBlw20Chars;
        act.SCALA_PALAZZINA = testStrBlw20Chars;
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = testStrBlw20Chars;
        act.RECAPITO_TEST_LINEA = testStrBlw20Chars;
        act.IDENTIFICATIVO_DEL_POP = testStrBlw10Chars;
        act.PROFILO = testStrBlw20Chars;
        act.TRACCIATO_TRASCODIFICATO = 'SI';
        act.CODICE_OPERATORE_SECONDARIO = 'SKY';
        
        List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO> testList_oloSer = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
        testList_oloSer.add(OLO_SERAGG);
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        
        List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO> testList_apparato = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO>();
        OF_SA_WS_IN_OLO_ActivationNew.APPARATO testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        act.APPARATO = testList_apparato;
        
        List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> testList_VLAN = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        OF_SA_WS_IN_OLO_ActivationNew.VLAN testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        testList_VLAN.clear();
        testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        testVLAN.KIT_CONSEGNA_VLAN = 'T';
        testVLAN.USER_VLAN = 'T';
        testVLAN.SERVICE_VLAN = 'T';
        testVLAN.PROFILO_VLAN = 'T';
        testVLAN.INFORMAZIONI_VLAN = 'T';
        testVLAN.CUSTOMER_VLAN = 'T';
        testVLAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        testList_VLAN.add(testVLAN);
        act.VLAN = testList_VLAN;
        
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_EntryChecksNew_Mock());
        //OF_GPONP_GE_Utils.responseFromSH.Result = 'OK';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChcksActvtnNewTestMethodNegative1(){
        Test.startTest();
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        
        //Test for Empty value in CODICE_OPERATORE variable
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //Test for length in CODICE_OPERATORE variable
        act.CODICE_OPERATORE = 'Test';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //Re-declaring the 'act' variable
        act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        act.CODICE_OPERATORE = 'KIT';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_OPERATORE = 'CNN';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_ORDINE_OLO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_ORDINE_OLO = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_ORDINE_OLO = '98765432';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.DATA_NOTIFICA = '2014-07-19T13:00:00+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.ID_NOTIFICA = testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.ID_NOTIFICA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_OPERATORE = 'SKY';
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '98765431';
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NOME_REFERENTE_TECNICO_OLO = testStrAbv70Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NOME_REFERENTE_TECNICO_OLO = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrAbv70Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChcksActvtnNewTestMethodNegative2(){
        Test.startTest();
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '98765431';
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        act.NOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.EMAIL_REFERENTE_TECNICO_OLO = 'test.test@test.com';
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrBlw20Chars;
        act.NOME_CLIENTE = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NOME_CLIENTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NOME_CLIENTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.COGNOME_CLIENTE = testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.COGNOME_CLIENTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.COGNOME_CLIENTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.DATA_PREVISTA_ATTIVAZIONE = '2014-07-19T13:00:00+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.DATA_PREVISTA_ATTIVAZIONE = '2018-07-19';
        act.ORARIO_APPUNTAMENTO = '11:11:oo';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.ORARIO_APPUNTAMENTO = '11:11:11';
        act.CODICE_PROGETTO_SPECIALE = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_PROGETTO_SPECIALE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
                
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChcksActvtnNewTestMethodNegative3(){
        Test.startTest();
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '98765431';
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        act.NOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrBlw20Chars;
        act.EMAIL_REFERENTE_TECNICO_OLO = 'test.test@test.com';
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrBlw20Chars;
        act.NOME_CLIENTE = testStrBlw20Chars;
        act.COGNOME_CLIENTE = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrBlw20Chars;
        act.DATA_PREVISTA_ATTIVAZIONE = '2018-07-19';
        act.ORARIO_APPUNTAMENTO = '11:11:11';

        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CODICE_PROGETTO_SPECIALE = testStrBlw20Chars;
        act.PROMOZIONE = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.PROMOZIONE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.PROMOZIONE = testStrBlw20Chars;
        act.CLUSTER_PROMOZIONE = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CLUSTER_PROMOZIONE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.CLUSTER_PROMOZIONE = testStrBlw20Chars;
        act.NOTE = testStrAbv100Chars + testStrAbv100Chars + testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NOTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NOTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.ID_BUILDING = testStrAbv100Chars + testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.ID_BUILDING = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.ID_BUILDING = testStrBlw20Chars;
        act.SCALA_PALAZZINA = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.SCALA_PALAZZINA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.SCALA_PALAZZINA = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = testStrBlw20Chars;
        act.RECAPITO_TEST_LINEA = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.RECAPITO_TEST_LINEA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.RECAPITO_TEST_LINEA = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChcksActvtnNewTestMethodNegative4(){
        Test.startTest();
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '98765431';
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        act.NOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrBlw20Chars;
        act.EMAIL_REFERENTE_TECNICO_OLO = 'test.test@test.com';
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrBlw20Chars;
        act.NOME_CLIENTE = testStrBlw20Chars;
        act.COGNOME_CLIENTE = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrBlw20Chars;
        act.DATA_PREVISTA_ATTIVAZIONE = '2018-07-19';
        act.ORARIO_APPUNTAMENTO = '11:11:11';
        act.CODICE_PROGETTO_SPECIALE = testStrBlw20Chars;
        act.PROMOZIONE = testStrBlw20Chars;
        act.CLUSTER_PROMOZIONE = testStrBlw20Chars;
        act.NOTE = testStrBlw20Chars;
        act.ID_BUILDING = testStrBlw20Chars;
        act.SCALA_PALAZZINA = testStrBlw20Chars;
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = testStrBlw20Chars;
        act.RECAPITO_TEST_LINEA = testStrBlw20Chars;

        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.IDENTIFICATIVO_DEL_POP = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.IDENTIFICATIVO_DEL_POP = testStrBlw10CharsWithSplCh;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.IDENTIFICATIVO_DEL_POP = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.PROFILO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.PROFILO = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.PROFILO = testStrBlw20Chars;
        act.TRACCIATO_TRASCODIFICATO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        act.TRACCIATO_TRASCODIFICATO = 'SI';
        act.CODICE_OPERATORE_SECONDARIO = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> testList_oloVlan = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        OF_SA_WS_IN_OLO_ActivationNew.VLAN OLO_vlan = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        OLO_vlan.KIT_CONSEGNA_VLAN = 'KIT';
        OLO_vlan.USER_VLAN = '835';
        OLO_vlan.SERVICE_VLAN='200';
        OLO_vlan.PROFILO_VLAN='0';
        OLO_vlan.CUSTOMER_VLAN='50';
        OLO_vlan.MODELLO_DI_SERVIZIO_VLAN='Test';
        OLO_vlan.INFORMAZIONI_VLAN='TT';
        testList_oloVlan.add(OLO_vlan);
        
        act.CODICE_OPERATORE_SECONDARIO = 'a�c';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        
        act.CODICE_OPERATORE_SECONDARIO = 'SKY';
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
       
        
        //
        List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO> testList_oloSer = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
        testList_oloSer.add(OLO_SERAGG);
        
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        testList_oloSer.clear();
        OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = testStrAbv50Chars;
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
        testList_oloSer.add(OLO_SERAGG);
        
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        testList_oloSer.clear();
        OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = testStrWithSplChars;
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
        testList_oloSer.add(OLO_SERAGG);
        
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        testList_oloSer.clear();
        OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        testList_oloSer.add(OLO_SERAGG);
        
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        testList_oloSer.clear();
        OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';
        testList_oloSer.add(OLO_SERAGG);
        
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        testList_oloSer.clear();
        OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T�';
        testList_oloSer.add(OLO_SERAGG);
        
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChcksActvtnNewTestMethodNegative5(){
        Test.startTest();
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '98765431';
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        act.NOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrBlw20Chars;
        act.EMAIL_REFERENTE_TECNICO_OLO = 'test.test@test.com';
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrBlw20Chars;
        act.NOME_CLIENTE = testStrBlw20Chars;
        act.COGNOME_CLIENTE = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrBlw20Chars;
        act.DATA_PREVISTA_ATTIVAZIONE = '2018-07-19';
        act.ORARIO_APPUNTAMENTO = '11:11:11';
        act.CODICE_PROGETTO_SPECIALE = testStrBlw20Chars;
        act.PROMOZIONE = testStrBlw20Chars;
        act.CLUSTER_PROMOZIONE = testStrBlw20Chars;
        act.NOTE = testStrBlw20Chars;
        act.ID_BUILDING = testStrBlw20Chars;
        act.SCALA_PALAZZINA = testStrBlw20Chars;
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = testStrBlw20Chars;
        act.RECAPITO_TEST_LINEA = testStrBlw20Chars;
        act.IDENTIFICATIVO_DEL_POP = testStrBlw10Chars;
        act.PROFILO = testStrBlw20Chars;
        act.TRACCIATO_TRASCODIFICATO = 'SI';
        act.CODICE_OPERATORE_SECONDARIO = 'SKY';
        
        List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO> testList_oloSer = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
        testList_oloSer.add(OLO_SERAGG);
        
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        
        List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> testList_oloVlan = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        OF_SA_WS_IN_OLO_ActivationNew.VLAN OLO_vlan = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        OLO_vlan.KIT_CONSEGNA_VLAN = 'KIT';
        OLO_vlan.USER_VLAN = '835';
        OLO_vlan.SERVICE_VLAN='200';
        OLO_vlan.PROFILO_VLAN='0';
        OLO_vlan.CUSTOMER_VLAN='50';
        OLO_vlan.MODELLO_DI_SERVIZIO_VLAN='Test';
        OLO_vlan.INFORMAZIONI_VLAN='TT';
        testList_oloVlan.add(OLO_vlan);
        
        List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO> testList_apparato = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO>();
        OF_SA_WS_IN_OLO_ActivationNew.APPARATO testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        
        //1
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //2
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = testStrAbv100Chars;
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //3
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = testStrWithSplChars;
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //4
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = testStrAbv50Chars;
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //5
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = testStrWithSplChars;
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //6
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //7
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = testStrAbv20Chars;
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //8
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = '�';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //9
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = testStrAbv100Chars + testStrAbv50Chars + testStrAbv50Chars;
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        //10
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = testStrWithSplChars;
        testList_apparato.add(testApparato);
        
        act.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChcksActvtnNewTestMethodNegative6(){
        Test.startTest();
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest act = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        act.CODICE_OPERATORE = 'CNN';
        act.CODICE_ORDINE_OLO = '98765431';
        act.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        act.ID_NOTIFICA = String.valueOf(System.now().getTime());
        act.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        act.NOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.COGNOME_REFERENTE_TECNICO_OLO = testStrBlw50Chars;
        act.TELEFONO_REFERENTE_TECNICO_OLO = testStrBlw20Chars;
        act.EMAIL_REFERENTE_TECNICO_OLO = 'test.test@test.com';
        act.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = testStrBlw20Chars;
        act.NOME_CLIENTE = testStrBlw20Chars;
        act.COGNOME_CLIENTE = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        act.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        act.INFORMAZIONI_LOGISTICA_APPARATI = testStrBlw20Chars;
        act.DATA_PREVISTA_ATTIVAZIONE = '2018-07-19';
        act.ORARIO_APPUNTAMENTO = '11:11:11';
        act.CODICE_PROGETTO_SPECIALE = testStrBlw20Chars;
        act.PROMOZIONE = testStrBlw20Chars;
        act.CLUSTER_PROMOZIONE = testStrBlw20Chars;
        act.NOTE = testStrBlw20Chars;
        act.ID_BUILDING = testStrBlw20Chars;
        act.SCALA_PALAZZINA = testStrBlw20Chars;
        act.NUMERO_TELEFONICO_PRINCIPALE_LINEA = testStrBlw20Chars;
        act.RECAPITO_TEST_LINEA = testStrBlw20Chars;
        act.IDENTIFICATIVO_DEL_POP = testStrBlw10Chars;
        act.PROFILO = testStrBlw20Chars;
        act.TRACCIATO_TRASCODIFICATO = 'SI';
        act.CODICE_OPERATORE_SECONDARIO = 'SKY';
        
        List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> testList_oloVlan = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        OF_SA_WS_IN_OLO_ActivationNew.VLAN OLO_vlan = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        OLO_vlan.KIT_CONSEGNA_VLAN = 'KIT';
        OLO_vlan.USER_VLAN = '835';
        OLO_vlan.SERVICE_VLAN='200';
        OLO_vlan.PROFILO_VLAN='0';
        OLO_vlan.CUSTOMER_VLAN='50';
        OLO_vlan.MODELLO_DI_SERVIZIO_VLAN='Test';
        OLO_vlan.INFORMAZIONI_VLAN='TT';
        testList_oloVlan.add(OLO_vlan);
        
        
        List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO> testList_oloSer = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T';
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
        testList_oloSer.add(OLO_SERAGG);
        act.SERVIZIO_AGGIUNTIVO = testList_oloSer;
        
        List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO> testList_apparato = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO>();
        OF_SA_WS_IN_OLO_ActivationNew.APPARATO testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testApparato.PASSWORD_APPARATO = 'T';
        testApparato.AZIONE_APPARATO = 'T';
        testApparato.CAUSALE = 'T';
        testList_apparato.add(testApparato);
        act.APPARATO = testList_apparato;
        
        OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        
        List<OF_SA_WS_IN_OLO_ActivationNew.VLAN> testList_VLAN = new List<OF_SA_WS_IN_OLO_ActivationNew.VLAN>();
        OF_SA_WS_IN_OLO_ActivationNew.VLAN testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        
        for(Integer i  = 1; i<=18; i++){
            testList_VLAN.clear();
            testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
            testVLAN = createVLANData(i);
            testList_VLAN.add(testVLAN);
            act.VLAN = testList_VLAN;
            
            OF_SA_OLO_EntryChecksNew.SyncChecksActivationNew(act);
        }
        
        Test.stopTest();
    }
    
    public static OF_SA_WS_IN_OLO_ActivationNew.VLAN createVLANData(Integer itrtnCount){
        OF_SA_WS_IN_OLO_ActivationNew.VLAN testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
        //for(Integer i  = 1; i<=18; i++){
            
            if(itrtnCount < 10){
                if(itrtnCount >= 1 && itrtnCount <= 3){
                    testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
                    if(itrtnCount == 2){
                        testVLAN.KIT_CONSEGNA_VLAN = testStrAbv20Chars;
                    }
                    if(itrtnCount == 3){
                        testVLAN.KIT_CONSEGNA_VLAN = testStrBlw10CharsWithSplCh;
                    }
                    testVLAN.USER_VLAN = 'T';
                    testVLAN.SERVICE_VLAN = 'T';
                }
                if(itrtnCount >= 4 && itrtnCount <= 6){
                    testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
                    testVLAN.KIT_CONSEGNA_VLAN = 'T';
                    if(itrtnCount == 5){
                        testVLAN.USER_VLAN = testStrBlw10Chars;
                    }
                    if(itrtnCount == 6){
                        testVLAN.USER_VLAN = 'A�B';
                    }
                    testVLAN.SERVICE_VLAN = 'T';
                }
                if(itrtnCount >= 7 && itrtnCount <= 9){
                    testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
                    testVLAN.KIT_CONSEGNA_VLAN = 'T';
                    testVLAN.USER_VLAN = 'T';
                    if(itrtnCount == 8){
                        testVLAN.SERVICE_VLAN = testStrBlw10Chars;
                    }
                    if(itrtnCount == 9){
                        testVLAN.SERVICE_VLAN = 'A�B';
                    }
                }
                testVLAN.PROFILO_VLAN = 'T';
                testVLAN.INFORMAZIONI_VLAN = 'T';
                testVLAN.CUSTOMER_VLAN = 'T';
                testVLAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
            }
            
            if(itrtnCount >= 10 && itrtnCount <= 12){
                testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
                testVLAN.KIT_CONSEGNA_VLAN = 'T';
                testVLAN.USER_VLAN = 'T';
                testVLAN.SERVICE_VLAN = 'T';
                if(itrtnCount == 11){
                    testVLAN.PROFILO_VLAN = testStrBlw10Chars;
                }
                if(itrtnCount == 12){
                    testVLAN.PROFILO_VLAN = 'A�B';
                }
                testVLAN.INFORMAZIONI_VLAN = 'T';
                testVLAN.CUSTOMER_VLAN = 'T';
                testVLAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
            }
            
            if(itrtnCount > 12){
                
                    testVLAN = new OF_SA_WS_IN_OLO_ActivationNew.VLAN();
                    testVLAN.KIT_CONSEGNA_VLAN = 'T';
                    testVLAN.USER_VLAN = 'T';
                    testVLAN.SERVICE_VLAN = 'T';
                    testVLAN.PROFILO_VLAN = 'T';
                    
                if(itrtnCount >= 13 && itrtnCount <= 14){
                    if(itrtnCount == 13){
                        testVLAN.CUSTOMER_VLAN = testStrBlw10Chars;
                    }
                    if(itrtnCount == 14){
                        testVLAN.CUSTOMER_VLAN = 'A�B';
                    }
                    testVLAN.INFORMAZIONI_VLAN = 'T';
                    testVLAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
                }
                if(itrtnCount >= 15 && itrtnCount <= 16){
                    testVLAN.CUSTOMER_VLAN = 'T';
                    if(itrtnCount == 15){
                        testVLAN.MODELLO_DI_SERVIZIO_VLAN = testStrAbv20Chars;
                    }
                    if(itrtnCount == 16){
                        testVLAN.MODELLO_DI_SERVIZIO_VLAN = testStrWithSplChars;
                    }
                    testVLAN.INFORMAZIONI_VLAN = 'T';
                }
                if(itrtnCount >= 17 && itrtnCount <= 18){
                    testVLAN.CUSTOMER_VLAN = 'T';
                    testVLAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
                    if(itrtnCount == 17){
                        testVLAN.INFORMAZIONI_VLAN = testStrAbv100Chars + testStrAbv100Chars;
                    }
                    if(itrtnCount == 18){
                        testVLAN.INFORMAZIONI_VLAN = testStrWithSplChars;
                    }
                }
                
            }
        //}
        
        return testVLAN;
    }
    
    @isTest
    public static void SyncChecksDeactivationNewTestMethodPositive(){
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest Deact = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        
        Deact.CODICE_OPERATORE = 'CNN';
        Deact.CODICE_ORDINE_OLO = '98765431';
        Deact.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        Deact.ID_NOTIFICA = String.valueOf(System.now().getTime());
        Deact.ID_RISORSA = testStrAbv20Chars;
        Deact.NOME_CLIENTE = testStrBlw20Chars;
        Deact.TRACCIATO_TRASCODIFICATO = 'SI';
        Deact.CODICE_OPERATORE_SECONDARIO = 'SKY';
        Deact.NOTE = testStrBlw20Chars;
        
        Deact.COGNOME_CLIENTE = testStrBlw20Chars;
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        
        List<OF_SA_WS_IN_OLO_DeactivationNew.APPARATO> testList_apparato = new List<OF_SA_WS_IN_OLO_DeactivationNew.APPARATO>();
        OF_SA_WS_IN_OLO_DeactivationNew.APPARATO testApparato = new OF_SA_WS_IN_OLO_DeactivationNew.APPARATO();
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_DeactivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testList_apparato.add(testApparato);
        Deact.APPARATO = testList_apparato;
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksDeactivationNewTestMethodNegative1(){
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest Deact = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        
        Test.startTest();
        
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_OPERATORE = 'Test';
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_OPERATORE = 'KIT';
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_OPERATORE = 'CNN';
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_ORDINE_OLO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_ORDINE_OLO = testStrBlw10CharsWithSplCh;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_ORDINE_OLO = '98765431';
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.DATA_NOTIFICA = '2014-07-19T13:00:00+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.ID_NOTIFICA = testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.ID_NOTIFICA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.ID_NOTIFICA = String.valueOf(System.now().getTime());
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        
        Deact.ID_RISORSA = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.ID_RISORSA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.ID_RISORSA = testStrAbv20Chars;
        Deact.NOME_CLIENTE = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.NOME_CLIENTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.NOME_CLIENTE = testStrBlw20Chars;
        Deact.TRACCIATO_TRASCODIFICATO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.TRACCIATO_TRASCODIFICATO = 'SI';
        Deact.CODICE_OPERATORE_SECONDARIO = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_OPERATORE_SECONDARIO = 'a�c';
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.CODICE_OPERATORE_SECONDARIO = 'SKY';
        Deact.NOTE = testStrAbv100Chars + testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.NOTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.NOTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksDeactivationNewTestMethodNegative2(){
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest Deact = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        
        Deact.CODICE_OPERATORE = 'CNN';
        Deact.CODICE_ORDINE_OLO = '98765431';
        Deact.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        Deact.ID_NOTIFICA = String.valueOf(System.now().getTime());
        Deact.ID_RISORSA = testStrAbv20Chars;
        Deact.NOME_CLIENTE = testStrBlw20Chars;
        Deact.TRACCIATO_TRASCODIFICATO = 'SI';
        Deact.CODICE_OPERATORE_SECONDARIO = 'SKY';
        Deact.NOTE = testStrBlw20Chars;
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        
        List<OF_SA_WS_IN_OLO_DeactivationNew.APPARATO> testList_apparato = new List<OF_SA_WS_IN_OLO_DeactivationNew.APPARATO>();
        OF_SA_WS_IN_OLO_DeactivationNew.APPARATO testApparato = new OF_SA_WS_IN_OLO_DeactivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = testStrAbv100Chars;
        testList_apparato.add(testApparato);
        
        Deact.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_DeactivationNew.APPARATO();
        testList_apparato.add(testApparato);
        Deact.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        testList_apparato.clear();
        testApparato = new OF_SA_WS_IN_OLO_DeactivationNew.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testList_apparato.add(testApparato);
        Deact.APPARATO = testList_apparato;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.COGNOME_CLIENTE = testStrAbv70Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.COGNOME_CLIENTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.COGNOME_CLIENTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksDeactivationNew(Deact);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksStatusUpdateNewTestMethodPositive(){
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        
        sur.CODICE_OPERATORE = 'CNN';
        sur.CODICE_ORDINE_OLO = '9876543';
        sur.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        sur.ID_NOTIFICA = String.valueOf(System.now().getTime());
        
        Test.startTest();
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        Case cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c From Case LIMIT 1];
        cs.EOF_Codice_Operatore_WS__c = sur.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = sur.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = testStrBlw10Chars;
        cs.OF_Response_Da_OLO__c = testStrBlw10Chars;
        cs.OF_Response_Da_OM__c = testStrBlw10Chars;
        cs.OF_OM_Nuovo_Flusso__c = true;
        cs.Status = 'Acquisito';
        cs.Previous_Status__c = null;
        update cs;
        
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.AZIONE = '1';
        sur.CODICE_MOTIVAZIONE = 'SKY';
        sur.MOTIVAZIONE = testStrBlw10Chars;
        sur.NOTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.Previous_Status__c = 'Sospeso';
        cs.Status = 'Sospeso';
        update cs;

        sur.AZIONE = '0';
        sur.CODICE_MOTIVAZIONE = 'SKY';
        sur.MOTIVAZIONE = testStrBlw10Chars;
        sur.NOME_CLIENTE = testStrBlw20Chars;
        sur.COGNOME_CLIENTE = testStrBlw50Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        
        date datePreAtt = date.newInstance(2019, 02, 28);
        date datePreAttCurr = datePreAtt.addMonths(3);
        sur.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(datePreAttCurr);
        
        //sur.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(Date.today());
        sur.ORARIO_APPUNTAMENTO = '11:11:11';
        
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);

        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksStatusUpdateNewTestMethodNegative1(){
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        
        Test.startTest();
        
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_OPERATORE = 'Test';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_OPERATORE = 'KIT';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_OPERATORE = 'CNN';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_ORDINE_OLO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_ORDINE_OLO = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_ORDINE_OLO = '98765432';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_OPERATORE = 'CNN';
        sur.CODICE_ORDINE_OLO = '98765431';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_ORDINE_OLO = '9876543';
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c,
                    OF_Response_da_SH__c, OF_Response_Da_OLO__c, OF_Response_Da_OM__c 
                    From Case LIMIT 1];
                    
        cs.EOF_Codice_Operatore_WS__c = sur.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = sur.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = 'NACK TECNICO';
        update cs;
        
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.OF_Response_da_SH__c = 'Test';
        cs.OF_Response_Da_OLO__c = 'NACK TECNICO';
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.OF_Response_Da_OLO__c = 'Test';
        cs.OF_Response_Da_OM__c = 'NACK TECNICO';
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.OF_Response_Da_OM__c = 'Test';
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.DATA_NOTIFICA = '2014-07-19T13:00:00+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.ID_NOTIFICA = testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.ID_NOTIFICA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.ID_NOTIFICA = String.valueOf(System.now().getTime());
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksStatusUpdateNewTestMethodNegative2_AZIONE1(){
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        
        Test.startTest();
        
        sur.CODICE_OPERATORE = 'CNN';
        sur.CODICE_ORDINE_OLO = '9876543';
        sur.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        sur.ID_NOTIFICA = String.valueOf(System.now().getTime());
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c From Case LIMIT 1];
        cs.EOF_Codice_Operatore_WS__c = sur.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = sur.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = testStrBlw10Chars;
        cs.OF_Response_Da_OLO__c = testStrBlw10Chars;
        cs.OF_Response_Da_OM__c = testStrBlw10Chars;
        cs.Status = 'Acquisitot';
        update cs;
        
        sur.AZIONE = '2';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.OF_OM_Nuovo_Flusso__c = false;
        update cs;
        
        sur.AZIONE = '1';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.OF_OM_Nuovo_Flusso__c = true;
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_MOTIVAZIONE = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_MOTIVAZIONE = 'A�T';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_MOTIVAZIONE = 'SKY';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.MOTIVAZIONE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.MOTIVAZIONE = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.Status = 'Acquisito';
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksStatusUpdateNewTestMethodNegative3_AZIONE0(){
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        
        Test.startTest();
        
        sur.CODICE_OPERATORE = 'CNN';
        sur.CODICE_ORDINE_OLO = '9876543';
        sur.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        sur.ID_NOTIFICA = String.valueOf(System.now().getTime());
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c From Case LIMIT 1];
        cs.EOF_Codice_Operatore_WS__c = sur.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = sur.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = testStrBlw10Chars;
        cs.OF_Response_Da_OLO__c = testStrBlw10Chars;
        cs.OF_Response_Da_OM__c = testStrBlw10Chars;
        cs.OF_OM_Nuovo_Flusso__c = true;
        cs.Status = 'Acquisito';
        cs.Previous_Status__c = 'Sospeso';
        update cs;
        
        sur.AZIONE = '0';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.Status = 'Sospeso';
        update cs;
        //OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_MOTIVAZIONE = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_MOTIVAZIONE = 'A�T';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.CODICE_MOTIVAZIONE = 'SKY';
        sur.MOTIVAZIONE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        //sur.MOTIVAZIONE = testStrWithSplChars;
        //OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.MOTIVAZIONE = testStrBlw10Chars;
        sur.NOME_CLIENTE = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.NOME_CLIENTE = testStrBlw20Chars;
        sur.COGNOME_CLIENTE = testStrAbv70Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.COGNOME_CLIENTE = testStrBlw50Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_1 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_2 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksStatusUpdateNewTestMethodNegative4_AZIONE0(){
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        
        Test.startTest();
        
        sur.CODICE_OPERATORE = 'CNN';
        sur.CODICE_ORDINE_OLO = '9876543';
        sur.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        sur.ID_NOTIFICA = String.valueOf(System.now().getTime());
        sur.AZIONE = '0';
        sur.CODICE_MOTIVAZIONE = 'SKY';
        sur.MOTIVAZIONE = testStrBlw10Chars;
        sur.NOME_CLIENTE = testStrBlw10Chars;
        sur.COGNOME_CLIENTE = testStrBlw50Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw10Chars;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c From Case LIMIT 1];
        cs.EOF_Codice_Operatore_WS__c = sur.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = sur.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = testStrBlw10Chars;
        cs.OF_Response_Da_OLO__c = testStrBlw10Chars;
        cs.OF_Response_Da_OM__c = testStrBlw10Chars;
        cs.OF_OM_Nuovo_Flusso__c = true;
        cs.Status = 'Acquisito';
        cs.Previous_Status__c = 'Sospeso';
        update cs;
        
        sur.AZIONE = '0';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        cs.Previous_Status__c = 'Acquisito';
        cs.Status = 'Sospeso';
        update cs;
        sur.DATA_PREVISTA_ATTIVAZIONE = '2013-07-19T13:00:00+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.DATA_PREVISTA_ATTIVAZIONE = '2019-01-20';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        date datePreAtt = date.newInstance(2019, 02, 28);
        date datePreAttCurr = datePreAtt.addMonths(3);
        sur.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(datePreAttCurr);
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.ORARIO_APPUNTAMENTO = '11:11:oo';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.ORARIO_APPUNTAMENTO = '11:11:11';
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksStatusUpdateNewTestMethodNegative5(){
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest sur = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        
        Test.startTest();
        
        sur.CODICE_OPERATORE = 'CNN';
        sur.CODICE_ORDINE_OLO = '9876543';
        sur.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        sur.ID_NOTIFICA = String.valueOf(System.now().getTime());
        sur.AZIONE = '0';
        sur.CODICE_MOTIVAZIONE = 'SKY';
        sur.MOTIVAZIONE = testStrBlw10Chars;
        sur.NOME_CLIENTE = testStrBlw10Chars;
        sur.COGNOME_CLIENTE = testStrBlw50Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        sur.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw10Chars;
        sur.AZIONE = '1';
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c From Case LIMIT 1];
        cs.EOF_Codice_Operatore_WS__c = sur.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = sur.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = testStrBlw10Chars;
        cs.OF_Response_Da_OLO__c = testStrBlw10Chars;
        cs.OF_Response_Da_OM__c = testStrBlw10Chars;
        cs.OF_OM_Nuovo_Flusso__c = true;
        cs.Status = 'Acquisito';
        cs.Previous_Status__c = 'Sospeso';
        update cs;
        
        sur.NOTE = testStrAbv100Chars + testStrAbv100Chars + testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.NOTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        sur.NOTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksStatusUpdateNew(sur);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksRescheduleNewTestMethodPositive(){
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
        
        r.CODICE_OPERATORE = 'CNN';
        r.CODICE_ORDINE_OLO = '9876543';
        r.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        r.ID_NOTIFICA = String.valueOf(System.now().getTime());
        r.NOME_CLIENTE = testStrBlw20Chars;
        r.COGNOME_CLIENTE = testStrBlw20Chars;
        r.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        r.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        r.CODICE_MOTIVAZIONE = 'SKY';
        r.MOTIVAZIONE = testStrBlw10Chars;
        r.NOTE = testStrBlw20Chars;

        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c From Case LIMIT 1];
        cs.EOF_Codice_Operatore_WS__c = r.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = r.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = testStrBlw10Chars;
        cs.OF_Response_Da_OLO__c = testStrBlw10Chars;
        cs.OF_Response_Da_OM__c = testStrBlw10Chars;
        cs.OF_OM_Nuovo_Flusso__c = true;
        cs.Status = 'Acquisito';
        update cs;
        
        Test.startTest();
        
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksRescheduleNewTestMethodNegative1(){
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
        
        Test.startTest();
        
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_OPERATORE = 'Test';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_OPERATORE = 'KIT';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_OPERATORE = 'CNN';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_ORDINE_OLO = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_ORDINE_OLO = testStrBlw10CharsWithSplCh;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_ORDINE_OLO = '9876543';
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c,
                    OF_Response_da_SH__c, OF_Response_Da_OLO__c, OF_Response_Da_OM__c 
                    From Case LIMIT 1];
                    
        cs.EOF_Codice_Operatore_WS__c = r.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = r.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        //cs.OF_Response_da_SH__c = 'NACK TECNICO';
        cs.OF_Response_da_SH__c = 'Test';
        update cs;
        
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        /*
        cs.OF_Response_da_SH__c = 'Test';
        update cs;
        */
        cs.Status = 'Acquisitot';
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        cs.OF_OM_Nuovo_Flusso__c = false;
        cs.Status = 'Acquisito';
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        cs.OF_OM_Nuovo_Flusso__c = true;
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksRescheduleNewTestMethodNegative2(){
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
        
        Test.startTest();
        
        r.CODICE_OPERATORE = 'CNN';
        r.CODICE_ORDINE_OLO = '9876543';

        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c,
                    OF_Response_da_SH__c, OF_Response_Da_OLO__c, OF_Response_Da_OM__c 
                    From Case LIMIT 1];
                    
        cs.EOF_Codice_Operatore_WS__c = r.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = r.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = 'Test';
        cs.Status = 'Acquisito';
        cs.OF_OM_Nuovo_Flusso__c = true;
        update cs;
        
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.DATA_NOTIFICA = '2014-07-19T13:00:00+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.ID_NOTIFICA = testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.ID_NOTIFICA = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.ID_NOTIFICA = String.valueOf(System.now().getTime());
        r.IDENTIFICATIVO_PRENOTAZIONE = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        r.NOME_CLIENTE = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.NOME_CLIENTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.NOME_CLIENTE = testStrBlw20Chars;
        r.COGNOME_CLIENTE = testStrAbv70Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.COGNOME_CLIENTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.COGNOME_CLIENTE = testStrBlw20Chars;
        r.RECAPITO_TELEFONICO_CLIENTE_1 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.RECAPITO_TELEFONICO_CLIENTE_1 = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        r.RECAPITO_TELEFONICO_CLIENTE_2 = testStrAbv20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.RECAPITO_TELEFONICO_CLIENTE_2 = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_OPERATORE = 'SKY';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.IDENTIFICATIVO_PRENOTAZIONE = testStrAbv50Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_OPERATORE = 'CNN';
        r.CODICE_ORDINE_OLO = '98765431';
        r.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        r.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        r.ID_NOTIFICA = String.valueOf(System.now().getTime());
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        Test.stopTest();
    }
    
    @isTest
    public static void SyncChecksRescheduleNewTestMethodNegative3(){
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest r = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
        
        Test.startTest();
        
        r.CODICE_OPERATORE = 'CNN';
        r.CODICE_ORDINE_OLO = '9876543';
        r.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        r.ID_NOTIFICA = String.valueOf(System.now().getTime());
        r.IDENTIFICATIVO_PRENOTAZIONE = testStrBlw50Chars;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('OF_SA_Attivazione').getRecordTypeId();
        CASE cs = [Select id, EOF_Codice_Ordine_OLO__c, EOF_Codice_Operatore_WS__c,
                    OF_Response_da_SH__c, OF_Response_Da_OLO__c, OF_Response_Da_OM__c 
                    From Case LIMIT 1];
                    
        cs.EOF_Codice_Operatore_WS__c = r.CODICE_OPERATORE;
        cs.EOF_Codice_Ordine_OLO__c = r.CODICE_ORDINE_OLO;
        cs.RecordTypeId = CaseRecordTypeId;
        cs.OF_Response_da_SH__c = 'Test';
        cs.Status = 'Acquisito';
        cs.OF_OM_Nuovo_Flusso__c = true;
        update cs;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.DATA_PREVISTA_ATTIVAZIONE = '2013-07-19T13:00:00+01:00';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        date datePreAtt = date.newInstance(2019, 02, 28);
        date datePreAttCurr = datePreAtt.addMonths(3);
        r.DATA_PREVISTA_ATTIVAZIONE = String.valueOf(datePreAttCurr);
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.ORARIO_APPUNTAMENTO = '11:11:oo';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.ORARIO_APPUNTAMENTO = '11:11:11';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_MOTIVAZIONE = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_MOTIVAZIONE = 'A�T';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.CODICE_MOTIVAZIONE = 'SKY';
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.MOTIVAZIONE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.MOTIVAZIONE = testStrBlw10Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.NOTE = testStrAbv100Chars + testStrAbv100Chars + testStrAbv100Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.NOTE = testStrWithSplChars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        r.NOTE = testStrBlw20Chars;
        OF_SA_OLO_EntryChecksNew.SyncChecksRescheduleNew(r);
        
        Test.stopTest();
    }
}
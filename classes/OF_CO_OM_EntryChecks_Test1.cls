@isTest
public class OF_CO_OM_EntryChecks_Test1 {

    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
   
    static testmethod void Method(){
     Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
     account acc = new account();
            acc.EOF_Codice_Operatore__c= 'VF';
            acc.name = 'test';        
            insert acc;
    
     case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            //parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.EOF_Codice_Operatore_WS__c = 'BBB';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.EOF_Account_OLO__c = acc.Id;
            parentCase.EOF_Id_Risorsa__c = 'risorsa';
            parentCase.RecordtypeId = RecordTypeIdcase;
            parentCase.status = 'Acquisito';
            parentCase.OF_Response_Da_OLO__c = 'ack';
            parentCase.PO_SA_Portale__c = false;
            parentCase.OF_Bonifica_Locked_Row__c = false;
            insert parentCase;
        
    Test.startTest(); 
        
    OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse obj1  = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();  
   // Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
    OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate obj2 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
    obj2.STATO_ORDINE = '9';
    obj2.ID_NOTIFICA = '';
    OF_CO_OM_EntryChecks obj3  = new OF_CO_OM_EntryChecks();
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
    Test.stoptest();    
        
    } 
    
    public static testmethod void Method1(){
     Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
     account acc = new account();
            acc.EOF_Codice_Operatore__c= 'VF';
            acc.name = 'test';        
            insert acc;
    
     case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            //parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.EOF_Codice_Operatore_WS__c = 'BBB';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.EOF_Account_OLO__c = acc.Id;
            parentCase.EOF_Id_Risorsa__c = 'risorsa';
            parentCase.RecordtypeId = RecordTypeIdcase;
            parentCase.status = 'Acquisito';
            parentCase.OF_Response_Da_OLO__c = 'ack';
            parentCase.PO_SA_Portale__c = false;
            parentCase.OF_Bonifica_Locked_Row__c = false;
            insert parentCase;
        
    Test.startTest(); 
        
    OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse obj1  = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();  
   // Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
    OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate obj2 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
    obj2.CODICE_OPERATORE = 'Test';
    obj2.STATO_ORDINE = '8';
         obj2.ID_NOTIFICA = 'tesssssssssssssssssssssssssssssssssssssssssssstttttttttttttttttttttttttttttttttttttttt';
    OF_CO_OM_EntryChecks obj3  = new OF_CO_OM_EntryChecks();
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
     Test.stoptest();    
        
    } 
    
    
    public static testmethod void Method2(){
     Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
     account acc = new account();
            acc.EOF_Codice_Operatore__c= 'VF';
            acc.name = 'test';        
            insert acc;
    
     case parentCase = new Case();
            parentCase.accountId = acc.Id;
            parentCase.Status='Acquisito';
            parentCase.EOF_Fase__c='In Verifica BO';
            //parentCase.PO_Offerta__c = 'P2P Base';
            parentCase.EOF_codice_Ordine_OLO__c = 'Test';
            parentCase.PO_Nome_Progetto__c='test';
            parentCase.EOF_Account_OLO__c = acc.Id;
            parentCase.EOF_Id_Risorsa__c = 'risorsa';
            parentCase.RecordtypeId = RecordTypeIdcase;
            parentCase.status = 'Acquisito';
            parentCase.OF_Response_Da_OLO__c = 'ack';
            parentCase.PO_SA_Portale__c = false;
            parentCase.OF_Bonifica_Locked_Row__c = false;
            insert parentCase;
            
            EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
            ser.OF_SA_ACK__c = true;
            insert ser;
        
    Test.startTest(); 
        
    OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse obj1  = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();  
   // Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
    OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate obj2 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
    obj2.CODICE_OPERATORE = 'VF';
    OF_CO_OM_EntryChecks obj3  = new OF_CO_OM_EntryChecks();
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
    
    obj2.CODICE_OPERATORE = 'VF';
    obj2.CODICE_ORDINE_OLO= 'Test';
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
    
    obj2.CODICE_OPERATORE = 'VF';
    obj2.CODICE_ORDINE_OLO= 'Test';
    obj2.CODICE_ORDINE_OF = parentCase.Id;
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
    
    obj2.CODICE_OPERATORE = 'VF';
    obj2.CODICE_ORDINE_OLO= 'Test';
    obj2.CODICE_ORDINE_OF = parentCase.Id;
    obj2.DATA_NOTIFICA = String.ValueOf(System.today());
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
    
    obj2.CODICE_OPERATORE = 'VF';
    obj2.CODICE_ORDINE_OLO= 'Test';
    obj2.CODICE_ORDINE_OF = parentCase.Id;
    obj2.DATA_NOTIFICA = String.ValueOf(System.today());
    obj2.ID_NOTIFICA = 'Testyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy';
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
    
    obj2.CODICE_OPERATORE = 'VF';
    obj2.CODICE_ORDINE_OLO= 'Test';
    obj2.CODICE_ORDINE_OF = parentCase.Id;
    obj2.DATA_NOTIFICA = String.ValueOf(System.today());
    obj2.ID_NOTIFICA = 'Testy';
    OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
   
    
     Test.stoptest();    
        
    } 
    
    public static testmethod void Method3(){
    
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_ChangeOrder_OPENSTREAM').getRecordTypeId();
        Id RecordTypeIdasset = Schema.SObjectType.asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        contract contra = new contract();
        contra.AccountId = acc.Id;
        contra.OF_IdContratto__c = 'Test';
        contra.StartDate = System.today();
        contra.ContractTerm = 123;
        contra.Status = 'Attivo';
        insert contra;
        
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.name = 'Open Stream';
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        
        OF_ContrattoServizio__c conser = new OF_ContrattoServizio__c();
        conser.OF_Contract__c = contra.Id;
        conser.OF_Servizio__c = ser1.Id;
        insert conser;
        
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        a.RecordtypeId = RecordTypeIdasset;
        insert a;
        
        order ord = new order();
        ord.OF_Profilo__c = 'Test';
        ord.AccountId = acc.Id;
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Chiuso';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_codice_Ordine_OLO__c = 'Test';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = 'risorsa';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.status = 'Acquisito';
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.OF_Order__c=ord.Id;
        insert parentCase;
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.OF_SA_ACK__c = true;
        insert ser;
        
        
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse obj1  = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();  
        // Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate obj2 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        obj2.CODICE_OPERATORE = 'VF';
        OF_CO_OM_EntryChecks obj3  = new OF_CO_OM_EntryChecks();
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        obj2.DATA_NOTIFICA = String.ValueOf(System.today());
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        obj2.DATA_NOTIFICA = String.ValueOf(System.today());
        obj2.ID_NOTIFICA = 'Testyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        obj2.DATA_NOTIFICA = String.ValueOf(System.today());
        obj2.ID_NOTIFICA = 'Testy';
        obj2.STATO_ORDINE = '8';
        
        Test.startTest();
        //OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate objc = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        Test.stoptest();    
        
    } 
    
     public static testmethod void Method4(){
    
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_ChangeOrder_OPENSTREAM').getRecordTypeId();
        Id RecordTypeIdasset = Schema.SObjectType.asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        contract contra = new contract();
        contra.AccountId = acc.Id;
        contra.OF_IdContratto__c = 'Test';
        contra.StartDate = System.today();
        contra.ContractTerm = 123;
        contra.Status = 'Attivo';
        insert contra;
        
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.name = 'Open Stream';
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        
        OF_ContrattoServizio__c conser = new OF_ContrattoServizio__c();
        conser.OF_Contract__c = contra.Id;
        conser.OF_Servizio__c = ser1.Id;
        insert conser;
        
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        a.RecordtypeId = RecordTypeIdasset;
        insert a;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Chiuso';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_codice_Ordine_OLO__c = 'Test';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = 'risorsa';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.status = 'Acquisito';
        parentCase.OF_Response_Da_OLO__c = 'NACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        insert parentCase;
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.OF_SA_ACK__c = true;
        insert ser;
        
        
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse obj1  = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();  
        // Test.setMock(WebServiceMock.class, new OF_CO_OM_EntryChecks_mock_Test());
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate obj2 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        obj2.CODICE_OPERATORE = 'VF';
        OF_CO_OM_EntryChecks obj3  = new OF_CO_OM_EntryChecks();
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        obj2.DATA_NOTIFICA = String.ValueOf(System.today());
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        obj2.DATA_NOTIFICA = String.ValueOf(System.today());
        obj2.ID_NOTIFICA = 'Testyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy';
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        
        obj2.CODICE_OPERATORE = 'VF';
        obj2.CODICE_ORDINE_OLO= 'Test';
        obj2.CODICE_ORDINE_OF = parentCase.Id;
        obj2.DATA_NOTIFICA = String.ValueOf(System.today());
        obj2.ID_NOTIFICA = 'Testy';
        obj2.STATO_ORDINE = '9';
        
        Test.startTest();
        //OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate objc = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        Test.setMock(WebServiceMock.class, new OF_CO_OM_SendToOLO_Mockcls2());
        OF_CO_OM_EntryChecks.SyncChecksNotifyStatusUpdate(obj2);
        Test.stoptest();    
        
    } 
    }
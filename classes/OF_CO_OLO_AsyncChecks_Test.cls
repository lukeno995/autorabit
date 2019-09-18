@isTest
public class OF_CO_OLO_AsyncChecks_Test{
    
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    public static testMethod void OF_CO_OLO_AsyncChecksMethod(){
        
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;        
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_Asset__c =ass.Id;
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
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
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;        
        
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        // OF_SA_WS_OLO_Response.Esito_element resp = OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(ser);
        // OF_CO_GE_Utils.caseOriginale = ChildCase1;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_AsyncChecks  olo1 = new OF_CO_OLO_AsyncChecks ();
        OF_CO_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id,ser.id);
        Test.StopTest();
    }
    
    public static testMethod void OF_CO_OLO_AsyncChecksMethod_1(){
        
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Cessato';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;        
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_Asset__c =ass.Id;
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
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
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        // OF_SA_WS_OLO_Response.Esito_element resp = OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(ser);
        // OF_CO_GE_Utils.caseOriginale = ChildCase1;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_AsyncChecks  olo1 = new OF_CO_OLO_AsyncChecks ();
        OF_CO_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id,ser.id);
        Test.StopTest();
    }
    
    public static testMethod void OF_CO_OLO_AsyncChecksMethod_2(){
        
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;        
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_Asset__c =ass.Id;
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
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
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        // OF_SA_WS_OLO_Response.Esito_element resp = OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(ser);
        // OF_CO_GE_Utils.caseOriginale = ChildCase1;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_AsyncChecks  olo1 = new OF_CO_OLO_AsyncChecks ();
        OF_CO_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id,ser.id);
        Test.StopTest();
    }
    
    public static testMethod void OF_CO_OLO_AsyncChecksMethod_3(){
        
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;        
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_Asset__c =ass.Id;
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
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
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        // OF_SA_WS_OLO_Response.Esito_element resp = OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(ser);
        // OF_CO_GE_Utils.caseOriginale = ChildCase1;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_AsyncChecks  olo1 = new OF_CO_OLO_AsyncChecks ();
        OF_CO_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id,ser.id);
        Test.StopTest();
    }
    
    public static testMethod void OF_CO_OLO_AsyncChecksMethod_4(){
        
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;        
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        log1.EOF_PROFILO__c = '14';
        log1.EOF_ID_Notifica__c = '1529661331591';  
        log1.OF_SA_VLan_Log__c = ser.id;
        insert log1;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_Asset__c =ass.Id;
        istan.RecordtypeId = RecordTypeIdcom;
        istan.OF_Case__c = parentCase.Id;
        insert istan;
        
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
        
        contract c = new contract();
        c.accountId=acc.id;
        c.status='Attivo';
        insert c;
        
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c=c.Id;
        conServ.OF_Servizio__c=servizio.id;
		insert conServ;     
		
        OF_CommercialElement__c istanElem = new OF_CommercialElement__c();
        istanElem.OF_Servizio__c = servizio.id;
        istanElem.Name='VLAN';
        istanElem.OF_DataInizioValidita__c = System.today() - 100;
        istanElem.OF_DataFineValidita__c = System.today();        
        insert istanElem;
        
        // OF_SA_WS_OLO_Response.Esito_element resp = OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(ser);
        // OF_CO_GE_Utils.caseOriginale = ChildCase1;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_OLO_AsyncChecks  olo1 = new OF_CO_OLO_AsyncChecks ();
        OF_CO_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id,ser.id);
        Test.StopTest();
    }
}
@isTest
public class OF_SA_OLO_SendToOMNew_Test {
    
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    //for method OM_CreateAckNackRequestActivationNew
    public static testmethod void testMethod_OM_CreateAckNackRequestActivationNewA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew(sList);
        Test.stopTest();
    }
    
     public static testmethod void testMethod_OM_CreateAckNackRequestActivationNewB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Bonifica_Locked_Row__c = false;
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew(sList);
        Test.stopTest();
    }
    
    //for method OM_CreateAckNackRequestActivationNew_GPONP
    public static testmethod void testMethod_OM_CreateAckNackRequestActivationNew_GPONPA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew_GPONP(sList);
        Test.stopTest();
    }
    
     public static testmethod void testMethod_OM_CreateAckNackRequestActivationNew_GPONPB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Bonifica_Locked_Row__c = false;
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Codice_Ordine_Olo__c = 'T';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Codice_Ordine_Olo__c = 'T';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
         Test.startTest();
         Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
         OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
         OF_GPONP_GE_Utils.caseOriginale = c;
         OF_GPONP_GE_Utils.slSFOM = eaiLog1;
         OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew_GPONP(sList);
         Test.stopTest();
    }
    
      public static testmethod void testMethod_OM_CreateAckNackRequestActivationNew_GPONPC(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Bonifica_Locked_Row__c = false;
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestActivationNew_GPONP(sList);
        Test.stopTest();
    }
    
    //for method OM_CreateAckNackRequestStatusUpdateNew
    public static testmethod void testMethod_OM_CreateAckNackRequestStatusUpdateNewA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock1());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestStatusUpdateNew(eaiLog1);
        Test.stopTest();
    }
    
     public static testmethod void testMethod_OM_CreateAckNackRequestStatusUpdateNewB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock2());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestStatusUpdateNew(eaiLog1);
        Test.stopTest();
    }

    
    //for method OM_CreateAckNackRequestStatusUpdateNew_GPONP
    public static testmethod void testMethod_OM_CreateAckNackRequestStatusUpdateNew_GPONPA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c='ACK';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock1());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestStatusUpdateNew_GPONP(eaiLog1);
        Test.stopTest();
    }
    
    public static testmethod void testMethod_OM_CreateAckNackRequestStatusUpdateNew_GPONPB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c='ACK';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock2());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestStatusUpdateNew_GPONP(eaiLog1);
        Test.stopTest();
    }
    
     //for method OM_CreateAckNackRequestRescheduleNew
    public static testmethod void testMethod_OM_CreateAckNackRequestRescheduleNewA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'ACK';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock3());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestRescheduleNew(eaiLog1);
        Test.stopTest();
    }

    public static testmethod void testMethod_OM_CreateAckNackRequestRescheduleNewB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'NACK TECNICO';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock4());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestRescheduleNew(eaiLog1);
        Test.stopTest();
    }
    
     //for method OM_CreateAckNackRequestRescheduleNew_GPONP
    public static testmethod void testMethod_OM_CreateAckNackRequestRescheduleNew_GPONPA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'ACK';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestRescheduleNew_GPONP(eaiLog1);
        Test.stopTest();
    }
    
    public static testmethod void testMethod_OM_CreateAckNackRequestRescheduleNew_GPONPB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'NACK TECNICO';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock4());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestRescheduleNew_GPONP(eaiLog1);
        Test.stopTest();
    }
    
     //for method OM_CreateAckNackRequestDeactivationNew
    public static testmethod void testMethod_OM_CreateAckNackRequestDeactivationNewA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'ACK';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Response__C='ACK';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Response__C='ACK';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock5());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew(sList);
        Test.stopTest();
    }
    
    public static testmethod void testMethod_OM_CreateAckNackRequestDeactivationNewB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'ACK';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = false;
        eaiLog.EOF_Response__C='NACK';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = false;
        eaiLog1.EOF_Response__C='NACK';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock6());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew(sList);
        Test.stopTest();
    }
    
      //for method OM_CreateAckNackRequestDeactivationNew_GPONP
    public static testmethod void testMethod_OM_CreateAckNackRequestDeactivationNew_GPONPA(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'ACK';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Response__C='ACK';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Response__C='ACK';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock5());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew_GPONP(sList);
        Test.stopTest();
    }
    
     public static testmethod void testMethod_OM_CreateAckNackRequestDeactivationNew_GPONPB(){
        
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
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
        c.OF_Response_Da_OM__c= 'NACK TECNICO';
        insert c;
        
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = false;
        eaiLog.EOF_Response__C='NACK';
        eaiLog.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = false;
        eaiLog1.EOF_Response__C='NACK';
        eaiLog1.EOF_Codice_Ordine_Olo__c = 'TEST_1';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(eaiLog);
        sList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_OLO_SendToOMNew sa = new OF_SA_OLO_SendToOMNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOM = eaiLog1;
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock6());
        OF_SA_OLO_SendToOMNew.OM_CreateAckNackRequestDeactivationNew_GPONP(sList);
        Test.stopTest();
    }



}
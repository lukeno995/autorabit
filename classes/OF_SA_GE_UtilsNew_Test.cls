@isTest
public class OF_SA_GE_UtilsNew_Test {
    
      @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    //for method syncError
    public static testMethod void Method_syncErrorOne(){
        
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
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest o = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        String errorCode1 = 'A03';
        String fieldName = 'Test';
        OF_SA_GE_UtilsNew.syncError(o,errorCode1,fieldName);
        String errorCode2 = 'A04';
        OF_SA_GE_UtilsNew.syncError(o,errorCode2,fieldName);
        String errorCode3 = 'A05';
        OF_SA_GE_UtilsNew.syncError(o,errorCode3,fieldName);
        String errorCode4 = 'A06';
        OF_SA_GE_UtilsNew.syncError(o,errorCode4,fieldName);
        String errorCode5 = 'A08';
        OF_SA_GE_UtilsNew.syncError(o,errorCode5,fieldName);
        String errorCode6 = 'A07';
        OF_SA_GE_UtilsNew.syncError(o,errorCode6,fieldName);
        String errorCode7 = 'A12';
        OF_SA_GE_UtilsNew.syncError(o,errorCode7,fieldName);
        String errorCode8 = 'A13';
        OF_SA_GE_UtilsNew.syncError(o,errorCode8,fieldName);
        String errorCode9 = 'A14';
        OF_SA_GE_UtilsNew.syncError(o,errorCode9,fieldName);
        String errorCode10 = 'B04';
        OF_SA_GE_UtilsNew.syncError(o,errorCode10,fieldName);
        String errorCode11 = 'A09';
        OF_SA_GE_UtilsNew.syncError(o,errorCode11,fieldName);
        String errorCode12 = 'A10';
        OF_SA_GE_UtilsNew.syncError(o,errorCode12,fieldName);
        Test.stopTest();
        
    }
    
    public static testMethod void Method_syncErrorTwo(){
        
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
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest O1 = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        String errorCode = 'A03';
        String fieldName = 'Test';
        OF_SA_GE_UtilsNew.syncError(O1,errorCode,fieldName);
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest O2 = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
        OF_SA_GE_UtilsNew.syncError(O2,errorCode,fieldName);
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest O3 = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        OF_SA_GE_UtilsNew.syncError(O3,errorCode,fieldName);
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate O4 = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        OF_SA_GE_UtilsNew.syncError(O4,errorCode,fieldName);
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule O5 = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        OF_SA_GE_UtilsNew.syncError(O5,errorCode,fieldName);
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder O6 = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        OF_SA_GE_UtilsNew.syncError(O6,errorCode,fieldName);
        Test.stopTest();
    }
    
   
    //for method create_EAI_Log
    public static testMethod void Method_create_EAI_Log_One(){
        
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
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest O1 = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_SA_WS_IN_OLO_ActivationNew.VLan v = new OF_SA_WS_IN_OLO_ActivationNew.VLan();
        O1.VLan = new List<OF_SA_WS_IN_OLO_ActivationNew.VLan>();
        O1.VLan.add(v);
        
        OF_SA_WS_IN_OLO_ActivationNew.APPARATO apparta = new OF_SA_WS_IN_OLO_ActivationNew.APPARATO();
        O1.APPARATO = new List<OF_SA_WS_IN_OLO_ActivationNew.APPARATO>();
        O1.APPARATO.add(apparta);
        
        OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO sa = new OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO();
        O1.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_ActivationNew.SERVIZIO_AGGIUNTIVO>();
        O1.SERVIZIO_AGGIUNTIVO.add(sa);
        
        OF_SA_GE_UtilsNew.create_EAI_Log(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_create_EAI_Log_Two(){
        
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
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate O1 = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_WS_IN_OM_StatusUpdateNew.VLan v = new OF_WS_IN_OM_StatusUpdateNew.VLan();
        O1.VLan = new List<OF_WS_IN_OM_StatusUpdateNew.VLan>();
        O1.VLan.add(v);
        
        OF_WS_IN_OM_StatusUpdateNew.APPARATO apparta = new OF_WS_IN_OM_StatusUpdateNew.APPARATO();
        O1.APPARATO = new List<OF_WS_IN_OM_StatusUpdateNew.APPARATO>();
        O1.APPARATO.add(apparta);
        
        OF_SA_GE_UtilsNew.create_EAI_Log(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_create_EAI_Log_Three(){
        
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
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder O1 = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO apparta = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        O1.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        O1.APPARATO.add(apparta);
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sa = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        O1.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        O1.SERVIZIO_AGGIUNTIVO.add(sa);
        
        OF_SA_GE_UtilsNew.create_EAI_Log(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_create_EAI_Log_Four(){
        
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
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest O1 = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_SA_WS_IN_OLO_DeactivationNew.APPARATO apparta = new OF_SA_WS_IN_OLO_DeactivationNew.APPARATO();
        O1.APPARATO = new List<OF_SA_WS_IN_OLO_DeactivationNew.APPARATO>();
        O1.APPARATO.add(apparta);
        
        OF_SA_GE_UtilsNew.create_EAI_Log(O1);
        Test.stopTest();
    }
    
     public static testMethod void Method_create_EAI_Log_Five(){
        
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
        eaiLog.EOF_Response__c = 'ACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest O1 = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        O1.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        O1.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_SA_GE_UtilsNew.create_EAI_Log(O1);
         
        Map<String, String> O2 = new Map<String, String>();
        O2.put('Type','ACK');
        OF_SA_GE_UtilsNew.create_EAI_Log(O2);
        Test.stopTest();
    }
    
    //for method copy_request
    public static testMethod void Method_copy_request_One(){
        
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
        eaiLog.EOF_Response__c = 'ACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_OLO_classi.NotificaOrdineGpona_element O1 = new OF_SA_WS_OLO_classi.NotificaOrdineGpona_element();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_SA_GE_UtilsNew.copy_request(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_copy_request_Two(){
        
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
        eaiLog.EOF_Response__c = 'ACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_OLO_Classi.NotificaRischedulazione_element O1 = new OF_SA_WS_OLO_Classi.NotificaRischedulazione_element();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_SA_GE_UtilsNew.copy_request(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_copy_request_Three(){
        
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
        eaiLog.EOF_Response__c = 'ACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element O1 = new OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_SA_GE_UtilsNew.copy_request(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_copy_request_Four(){
        
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
        eaiLog.EOF_Response__c = 'ACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_OM_Classi.AttivazioneGpona_element O1 = new OF_SA_WS_OM_Classi.AttivazioneGpona_element();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_SA_GE_UtilsNew.copy_request(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_copy_request_Five(){
        
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
        eaiLog.EOF_Response__c = 'ACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_OM_Classi.Disattivazione_element O1 = new OF_SA_WS_OM_Classi.Disattivazione_element();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        
        OF_SA_GE_UtilsNew.copy_request(O1);
        Test.stopTest();
    }
    
    public static testMethod void Method_copy_request_Six(){
        
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
        eaiLog.EOF_Response__c = 'ACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.slOLOSF = eaiLog;
        OF_SA_WS_OM_Classi.Rischedulazione_element O1 = new OF_SA_WS_OM_Classi.Rischedulazione_element();
        O1.CODICE_ORDINE_OLO = '02112016_37';
        OF_SA_GE_UtilsNew.copy_request(O1);
        
        OF_SA_WS_OM_Classi.AggiornamentoStato_element O2 = new OF_SA_WS_OM_Classi.AggiornamentoStato_element();
        OF_SA_GE_UtilsNew.copy_request(O2);
        Test.stopTest();
    }
    
    //for method dateToStringNoTime
    public static testMethod void Method_dateToStringNoTime(){
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        date dt = System.today();
        OF_SA_GE_UtilsNew.dateToStringNoTime(dt);
        Test.stopTest();
    }
    
    //for method getQueryNew
    public static testMethod void Method_getQueryNew(){
        
        Test.startTest();
        
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String oggetto1 = 'case';
        String Processo1 = 'AsyncActivation';
        OF_SA_GE_UtilsNew.getQueryNew(oggetto1,Processo1);
        
        String Processo2 = 'AsyncDeactivation';
        OF_SA_GE_UtilsNew.getQueryNew(oggetto1,Processo2);
        
        String oggetto2 = 'sl';
        OF_SA_GE_UtilsNew.getQueryNew(oggetto2,Processo1);
        
        String Processo3 = 'AsyncDeactivation';
        OF_SA_GE_UtilsNew.getQueryNew(oggetto2,Processo3);
        
        String oggetto3 = 'asset';
        String Processo4 = 'AsyncDeactivation';
        OF_SA_GE_UtilsNew.getQueryNew(oggetto3,Processo4);
        
        Test.stopTest();
    }
    
    //for method CreateAcquisition_LogNew
    public static testMethod void Method_CreateAcquisition_LogNew_One(){
        
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
        c.Status = 'Acquisito';
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
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(c);
        Test.stopTest();
    }
    
    public static testMethod void Method_CreateAcquisition_LogNew_Two(){
        
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
        c.Status = 'Acquisito KO';
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
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(c);
        c.Status = 'Cessato KO';
        OF_SA_GE_UtilsNew.CreateAcquisition_LogNew(c);
        Test.stopTest();
    }
    
    //for method makeCalloutOLOOMNew
 /**   public static testMethod void Method_makeCalloutOLOOMNew(){
        
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
        
         List<RecordType> Casertypes = [Select developerName, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.developerName,rt.Id); 
        
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
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
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = CaseRecordTypes.get('EOF_Caso_Attivazione');
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        //insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_02';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_371';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today() + 5;
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test1';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today() + 5;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Response__c = 'NACK';
        eaiLog1.EOF_Tipo_comunicazione__c = '5';
        //insert eaiLog1;
        
        List<EOF_EAI_Service_Log__C> ListSlTOOM = new List<EOF_EAI_Service_Log__C>();
        ListSlTOOM.add(eaiLog);
        ListSlTOOM.add(eaiLog1);
        
        Case_AssetRecordType__c cs = new Case_AssetRecordType__c();
        cs.assetDevName__c = 'Name';
        cs.caseDevName__c = CaseRecordTypes.get('EOF_Caso_Attivazione');
        CS.Name = 'Name2';
        insert cs;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_SA_GE_UtilsNew.ListSlActivationOLOSF = ListSlTOOM;
        OF_SA_GE_UtilsNew.a = asset_1;
        OF_SA_GE_UtilsNew.slSFOM = eaiLog1;
        OF_SA_GE_UtilsNew.makeCalloutOLOOMNew(eaiLog);
        Test.stopTest();
        
    } **/
    
    //for method OLO_CreateStatusUpdate_Log
    public static testMethod void Method_OLO_CreateStatusUpdate_Log(){
        
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
        c.OF_OM_Nuovo_Flusso__c = true;
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest o = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        o.CODICE_ORDINE_OLO = '02112016_37';
        OF_SA_GE_UtilsNew.OLO_CreateStatusUpdate_Log(c,o);
        Test.stopTest();
        
    } 
    
    //for method OLO_CreateReschedule_Log
    public static testMethod void Method_OLO_CreateReschedule_Log(){
        
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
        c.OF_OM_Nuovo_Flusso__c = true;
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest o = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
        o.CODICE_ORDINE_OLO = '02112016_37';
        OF_SA_GE_UtilsNew.OLO_CreateReschedule_Log(c,o);
        Test.stopTest();
        
    } 
    
    //for method OM_CreateReschedule_LogNew
    public static testMethod void Method_OM_CreateReschedule_LogNew(){
        
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
        c.OF_OM_Nuovo_Flusso__c = true;
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule o = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        OF_SA_GE_UtilsNew.OM_CreateReschedule_LogNew(c,o);
        Test.stopTest();
        
    } 
    
    //for method checkAmministratori
    public static testMethod void Method_checkAmministratori(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CA Amministratori').getRecordTypeId();
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
        c.OF_OM_Nuovo_Flusso__c = true;
        c.EOF_ID_Building_WS__c = 'Test';
        c.CA_ID_Building__c = 'Test';
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_SA_GE_UtilsNew.checkAmministratori(c);
        Test.stopTest();
        
    } 
    
    //for method OM_CreateStatusUpdate_LogNew
    public static testMethod void Method_OM_CreateStatusUpdate_LogNew(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CA Amministratori').getRecordTypeId();
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
        c.OF_OM_Nuovo_Flusso__c = true;
        c.EOF_ID_Building_WS__c = 'Test';
        c.CA_ID_Building__c = 'Test';
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate O1 = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        
        OF_WS_IN_OM_StatusUpdateNew.VLan v = new OF_WS_IN_OM_StatusUpdateNew.VLan();
        O1.VLan = new List<OF_WS_IN_OM_StatusUpdateNew.VLan>();
        O1.VLan.add(v);
        
        OF_WS_IN_OM_StatusUpdateNew.APPARATO apparta = new OF_WS_IN_OM_StatusUpdateNew.APPARATO();
        O1.APPARATO = new List<OF_WS_IN_OM_StatusUpdateNew.APPARATO>();
        O1.APPARATO.add(apparta);
        
        OF_SA_GE_UtilsNew.OM_CreateStatusUpdate_LogNew(c,O1);
        Test.stopTest();
        
    }
    
    //for method aggiornamentoDatiEspletamentoNew
    public static testMethod void Method_aggiornamentoDatiEspletamentoNew(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CA Amministratori').getRecordTypeId();
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
        c.OF_OM_Nuovo_Flusso__c = true;
        c.EOF_ID_Building_WS__c = 'Test';
        c.CA_ID_Building__c = 'Test';
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
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
        eaiLog1.EOF_Response__c = 'NACK';
        eaiLog1.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog1;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate O1 = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        
        OF_SA_GE_UtilsNew.aggiornamentoDatiEspletamentoNew(C.Id,eaiLog.Id,eaiLog1.Id);
        Test.stopTest();
        
    }
    
     //for method aggiornamentoDatiEspletamentoNew_GPONP
    public static testMethod void Method_aggiornamentoDatiEspletamentoNew_GPONP(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CA Amministratori').getRecordTypeId();
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
        c.OF_OM_Nuovo_Flusso__c = true;
        c.EOF_ID_Building_WS__c = 'Test';
        c.CA_ID_Building__c = 'Test';
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
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
        eaiLog1.EOF_Response__c = 'NACK';
        eaiLog1.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog1;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate O1 = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        
        OF_SA_GE_UtilsNew.aggiornamentoDatiEspletamentoNew_GPONP(C.Id,eaiLog.Id,eaiLog1.Id);
        Test.stopTest();
        
    }
    
      //for method OM_CreateCompletionOrder_Log
    public static testMethod void Method_OM_CreateCompletionOrder_Log(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CA Amministratori').getRecordTypeId();
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
        c.OF_OM_Nuovo_Flusso__c = true;
        c.EOF_ID_Building_WS__c = 'Test';
        c.CA_ID_Building__c = 'Test';
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
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
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
        eaiLog1.EOF_Response__c = 'NACK';
        eaiLog1.EOF_Tipo_comunicazione__c = '5';
        insert eaiLog1;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.slSFOLO = eaiLog;
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder O1 = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        
        OF_WS_IN_OM_CompletionOrderNew.apparato v = new OF_WS_IN_OM_CompletionOrderNew.apparato();
        O1.apparato = new List<OF_WS_IN_OM_CompletionOrderNew.apparato>();
        O1.apparato.add(v);
        
        OF_WS_IN_OM_CompletionOrderNew.servizio_Aggiuntivo apparta = new OF_WS_IN_OM_CompletionOrderNew.servizio_Aggiuntivo();
        O1.servizio_Aggiuntivo = new List<OF_WS_IN_OM_CompletionOrderNew.servizio_Aggiuntivo>();
        O1.servizio_Aggiuntivo.add(apparta);
        
        OF_SA_GE_UtilsNew.OM_CreateCompletionOrder_Log(C,O1);
        Test.stopTest();
        
    }
    
      //for method dateToString,checkDate and checkEmail
    public static testMethod void Method_dateToString(){
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        date dt1 = null;
        OF_SA_GE_UtilsNew.dateToString(dt1);
        date dt2 = System.today();
        OF_SA_GE_UtilsNew.dateToString(dt2);
        String S1 = '';
        OF_SA_GE_UtilsNew.checkDate(S1);
        String S2 = 'Test';
        OF_SA_GE_UtilsNew.checkDate(S2);
        String email1 = '';
        OF_SA_GE_UtilsNew.checkEmail(email1);
        String email2 = 'Test';
        OF_SA_GE_UtilsNew.checkEmail(email2);
        Test.stopTest();
        
    }
    
     //for method CreateTemplogOLO
    public static testMethod void Method_CreateTemplogOLO(){
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        
        OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest O1 = new OF_SA_WS_IN_OLO_ActivationNew.OLO_ActivationRequest();
        OF_SA_GE_UtilsNew.CreateTemplogOLO(O1);
        
        OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest O2 = new OF_SA_WS_IN_OLO_DeactivationNew.OLO_DeactivationRequest();
        OF_SA_GE_UtilsNew.CreateTemplogOLO(O2);
        
        OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest O3 = new OF_SA_WS_IN_OLO_RescheduleNew.OLO_RescheduleRequest();
        OF_SA_GE_UtilsNew.CreateTemplogOLO(O3);
        
        OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest O4 = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
        O4.AZIONE = '0';
        OF_SA_GE_UtilsNew.CreateTemplogOLO(O4);
        O4.AZIONE = '1';
        OF_SA_GE_UtilsNew.CreateTemplogOLO(O4);
        Test.stopTest();
        
    }
    
    //for method partialTemplog and EndTemplog
    public static testMethod void Method_partialTemplog(){
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String s = 'Test';        
        OF_SA_GE_UtilsNew.partialTemplog(s);
        OF_SA_GE_UtilsNew.EndTemplog();
        Test.stopTest();
    }
    
    //for method CreateTemlogOM
    public static testMethod void Method_CreateTemlogOM(){
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate O1 = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        O1.STATO_ORDINE = '0';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        O1.STATO_ORDINE = '1';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        O1.STATO_ORDINE = '2';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        O1.STATO_ORDINE = '3';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        O1.STATO_ORDINE = '4';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        O1.STATO_ORDINE = '5';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        O1.STATO_ORDINE = '6';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        O1.STATO_ORDINE = '7';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O1);
        
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule O2 = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        OF_SA_GE_UtilsNew.CreateTemlogOM(O2);
        
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder O3 = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        O3.STATO_ORDINE = '0';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O3);
        O3.STATO_ORDINE = '1';
        OF_SA_GE_UtilsNew.CreateTemlogOM(O3);
        
        Test.stopTest();
       
    }
    
    //for method returnStatusFromInt
    public static testMethod void Method_returnStatusFromInt(){
        
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo1 ='OM_StatusUpdate';
        string stato_ordine1 = '0';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine1,metodo1);
        string stato_ordine2 = '1';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine2,metodo1);
        string stato_ordine3 = '2';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine3,metodo1);
        string stato_ordine4 = '3';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine4,metodo1);
        string stato_ordine5 = '4';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine5,metodo1);
        string stato_ordine6 = '5';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine6,metodo1);
        string stato_ordine7 = '6';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine7,metodo1);
        string stato_ordine8 = '7';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine8,metodo1);
        
        String metodo2 ='OM_CompletionOrder';
        string stato_ordine9 = '0';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine9,metodo2);
        string stato_ordine10 = '1';
        OF_SA_GE_UtilsNew.returnStatusFromInt(stato_ordine10,metodo2);
        
        Test.stopTest();
        
    }
    
    //for method OLOSHConfirm_copy_request
    public static testMethod void Method_OLOSHConfirm_copy_request(){
        
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
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.OLOSHConfirm_copy_request(eaiLog);
        eaiLog.OF_SA_Esito__c = 'OK';
        OF_SA_GE_UtilsNew.OLOSHConfirm_copy_request(eaiLog);
        Test.stopTest();
        
    }
    
    //for method controlloVendibilita
    public static testMethod void Method_controlloVendibilita(){
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String theOlo1 = 'VF';
        String theBuildingId = 'Test';
        Test.setMock(WebServiceMock.class, new OF_SA_GE_UtilsNew_Mock());
        OF_SA_GE_UtilsNew.controlloVendibilita(theOlo1,theBuildingId);
        String theOlo2 = 'WN';
        OF_SA_GE_UtilsNew.controlloVendibilita(theOlo2,theBuildingId);
        Test.stopTest();
    }
    
     
    //for method makeCalloutOLOSHCancelReserve
    public static testMethod void Method_makeCalloutOLOSHCancelReserve(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String tokenId = 'Test1';
        String codice_ordine_olo = 'Test2';
        OF_SA_GE_UtilsNew.caseOriginale = c;
        OF_SA_GE_UtilsNew.makeCalloutOLOSHCancelReserve(tokenId,codice_ordine_olo);
        Test.stopTest();
    }
    
     //for method makeCalloutOLOSHConfirmation
    public static testMethod void Method_makeCalloutOLOSHConfirmation(){
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String tokenId = 'Test1'; 
        String codice_ordine_olo = 'Test2';
        String codice_operatore = 'Test3';
        String data_prevista_attivazione = 'Test4';
        OF_SA_GE_UtilsNew.makeCalloutOLOSHConfirmation(tokenId,codice_ordine_olo,codice_operatore,data_prevista_attivazione);
        Test.stopTest();
    }
    
     //for method aggiornaSLPortale
    public static testMethod void Method_aggiornaSLPortale_One(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_StatusUpdate';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Two(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_StatusUpdate';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Three(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_011';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_371';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test1';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test1';
        eaiLog.EOF_Nome_Cliente__c = 'Test1';
        eaiLog.EOF_COgnome_CLiente__c = 'Test1';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test1';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test1';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test1';
        eaiLog.EOF_Codice_Motivazione__c = 'Test1';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_StatusUpdate';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
     public static testMethod void Method_aggiornaSLPortale_Four(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_StatusUpdate';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Five(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.EOF_ID_RISORSA__c = 'Test';
        eaiLog1.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog1.OF_SA_DDT__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_CompletionOrder';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Six(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.EOF_ID_RISORSA__c = 'Test';
        eaiLog1.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog1.OF_SA_DDT__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_CompletionOrder';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Seven(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.EOF_ID_RISORSA__c = 'Test';
        eaiLog1.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog1.OF_SA_DDT__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_CompletionOrder';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Eight(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_011';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_371';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test1';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test1';
        eaiLog1.EOF_Nome_Cliente__c = 'Test1';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test1';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test1';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test1';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test1';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test1';
        eaiLog1.EOF_ID_RISORSA__c = 'Test1';
        eaiLog1.EOF_SCALA_PALAZZINA__c = 'Test1';
        eaiLog1.OF_SA_DDT__c = 'Test1';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_CompletionOrder';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Nine(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_011';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_371';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test1';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test1';
        eaiLog1.EOF_Nome_Cliente__c = 'Test1';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test1';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test1';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test1';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test1';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test1';
        eaiLog1.EOF_ID_RISORSA__c = 'Test1';
        eaiLog1.EOF_SCALA_PALAZZINA__c = 'Test1';
        eaiLog1.OF_SA_DDT__c = 'Test1';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_CompletionOrder';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Ten(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_CompletionOrder';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Eleven(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_Reschedule';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
     public static testMethod void Method_aggiornaSLPortale_Twelve(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_StatusUpdate';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    public static testMethod void Method_aggiornaSLPortale_Thirteen(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_011';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_371';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test1';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test1';
        eaiLog1.EOF_Nome_Cliente__c = 'Test1';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test1';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test1';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test1';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test1';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test1';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        slList.add(eaiLog);
        slList.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String metodo = 'OM_StatusUpdate';
        OF_SA_GE_UtilsNew.aggiornaSLPortale(slList,metodo);
        Test.stopTest();
    }
    
    //for method create_DeactivationToOM_Log
    public static testMethod void Method_create_DeactivationToOM_Log(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.EOF_ID_RISORSA__c = 'Test';
        eaiLog1.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog1.OF_SA_DDT__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> ListSlOrig = new List<EOF_EAI_Service_Log__c>();
        ListSlOrig.add(eaiLog);
        ListSlOrig.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.create_DeactivationToOM_Log(c,ListSlOrig,asset_1);
        Test.stopTest();
    }
    
    //for method create_ActivationToOM_Log
    public static testMethod void Method_create_ActivationToOM_Log(){
        
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
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
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
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.RecordTypeId = EaiLogRecordTypeId;
        eaiLog.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog.EOF_GPON_Attestazione__c = 'Test';
        eaiLog.EOF_Nome_Cliente__c = 'Test';
        eaiLog.EOF_COgnome_CLiente__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog.EOF_Codice_Motivazione__c = 'Test';
        eaiLog.EOF_ID_RISORSA__c = 'Test';
        eaiLog.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog.OF_SA_DDT__c = 'Test';
        insert eaiLog;
         
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_RichiestaVLAN__c = eaiLog.Id;
        eaiLog1.PO_PP_ID_VLAN__c = eaiLog.Id;
        eaiLog1.OF_PP_KIT_Log__c = eaiLog.Id;
        eaiLog1.EOF_SL_Riferimento__c = eaiLog.Id;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.EOF_ID_RISORSA__c = 'Test';
        eaiLog1.EOF_SCALA_PALAZZINA__c = 'Test';
        eaiLog1.OF_SA_DDT__c = 'Test';
        insert eaiLog1;
        
        List<EOF_EAI_Service_Log__c> ListSlOrig = new List<EOF_EAI_Service_Log__c>();
        ListSlOrig.add(eaiLog);
        ListSlOrig.add(eaiLog1);
        
        Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        OF_SA_GE_UtilsNew.create_ActivationToOM_Log(c,ListSlOrig);
        Test.stopTest();
    }
    
     
    public static testMethod void Method_aggiornamentoDatiAttivazioneCessazioneToOM(){
        
         OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci;
                 
         
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
       //insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id); 
       /*
       OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
       */
     Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
         spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
         
         // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
            c1.OF_SA_Interfaccia_OM__c='Nuova IF';
            c1.OF_OM_Nuovo_Flusso__c= true;
            c1.EOF_Identificativo_del_POP__c='MI/FCO/2';
            insert c1;
            
            OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=c1.Id;
            insert g;
             String gid=g.id;
        	 gid= gid.abbreviate(10);
            c1.OF_SA_ID_Servizio__c=gid;
            update c1;
                
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        //service log creation 
        EOF_EAI_Service_Log__c slA = new EOF_EAI_Service_Log__c();
        slA.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        slA.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        slA.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        slA.EOF_ID_Notifica__c ='0000000';
        slA.EOF_STATO_ORDINE__c ='Acquisito';
        slA.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='Y';
        slA.EOF_NOME_REFERENTE_TECNICO_OLO__c= 'NomeRefTec'; 
		slA.EOF_COGNOME_REFERENTE_TECNICO_OLO__c='CognomeRefTec' ; 
		slA.EOF_Telefono_Referente_OLO_Onfield_Notec__c= '06230514258587'; 
		slA.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c= '06230514258586'; 
		slA.EOF_Nome_Cliente__c= 'NomeCliente' ; 
		slA.EOF_COgnome_CLiente__c= 'CognomeCliente' ; 
		slA.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= '0623051425899' ; 
		slA.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= '06230514258888' ; 
		slA.EOF_DATA_PREVISTA_ATTIVAZIONE__c= System.today().addDays(35); 
		slA.EOF_ORARIO_APPUNTAMENTO__c='10:00:00' ; 
		slA.EOF_NOTE__c= 'Note request' ; 
		slA.EOF_ID_BUILDING__c= 'ID_Building001' ;
		slA.EOF_ID_Pop__c ='MI/FCO/2';
        insert slA;
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='0000000';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='Y';
        sl.EOF_NOME_REFERENTE_TECNICO_OLO__c= 'NomeRefTec'; 
		sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c='CognomeRefTec' ; 
		sl.EOF_Telefono_Referente_OLO_Onfield_Notec__c= '06230514258587'; 
		sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c= '06230514258586'; 
		sl.EOF_Nome_Cliente__c= 'NomeCliente' ; 
		sl.EOF_COgnome_CLiente__c= 'CognomeCliente' ; 
		sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= '0623051425899' ; 
		sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= '06230514258888' ; 
		sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c= System.today().addDays(35); 
		sl.EOF_ORARIO_APPUNTAMENTO__c='10:00:00' ; 
		sl.EOF_NOTE__c= 'Note request' ; 
		sl.EOF_ID_BUILDING__c= 'ID_Building001' ;
		sl.EOF_ID_Pop__c ='MI/FCO/2';
        sl.EOF_SL_Riferimento__c=slA.id;
        
       // insert sl;
        EOF_EAI_Service_Log__c sl1 = new EOF_EAI_Service_Log__c();
        sl1.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl1.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl1.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl1.EOF_ID_Notifica__c ='0000000';
        sl1.EOF_STATO_ORDINE__c ='Acquisito';
        sl1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='Y';
        sl1.EOF_NOME_REFERENTE_TECNICO_OLO__c= 'NomeRefTec'; 
		sl1.EOF_COGNOME_REFERENTE_TECNICO_OLO__c='CognomeRefTec' ; 
		sl1.EOF_Telefono_Referente_OLO_Onfield_Notec__c= '06230514258587'; 
		sl1.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c= '06230514258586'; 
		sl1.EOF_Nome_Cliente__c= 'NomeCliente' ; 
		sl1.EOF_COgnome_CLiente__c= 'CognomeCliente' ; 
		sl1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= '0623051425899' ; 
		sl1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= '06230514258888' ; 
		sl1.EOF_DATA_PREVISTA_ATTIVAZIONE__c= System.today().addDays(35); 
		sl1.EOF_ORARIO_APPUNTAMENTO__c='10:00:00' ; 
		sl1.EOF_NOTE__c= 'Note request' ; 
		sl1.EOF_ID_BUILDING__c= 'ID_Building001' ;
		sl1.EOF_ID_Pop__c ='MI/FCO/2';
        sl1.EOF_SL_Riferimento__c=slA.id;
        
       // insert sl1;
       // 
        	EOF_EAI_Service_Log__c fr = new EOF_EAI_Service_Log__c ();
            fr.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
            fr.EOF_Codice_Ordine_OLo__C = 'Test';
            
            EOF_EAI_Service_Log__c fr1 = new EOF_EAI_Service_Log__C ();
            fr1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
            fr1.EOF_Codice_Ordine_OLo__C = 'Test';
        	fr1.EOF_SL_Riferimento__c=slA.id;
        OF_SA_GE_UtilsNew.slSFOLOresp= fr1;
       
        EOF_EAI_Service_Log__c fr2 = new EOF_EAI_Service_Log__C ();
            fr2.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
            fr2.EOF_Codice_Ordine_OLo__C = 'Test';
        	fr2.EOF_SL_Riferimento__c=slA.id;
        OF_SA_GE_UtilsNew.slSFOMResp=fr2;
        
        //.EOF_SL_Riferimento__c=slA.id; 
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        sc.OF_SA_Azione_APPARATO__c='1';
        insert sc;
        // end cpe service log creation
        OF_SA_GE_UtilsNew.slSFOLO=sl;
        OF_SA_GE_UtilsNew.slSFOM=sl1;
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        //aggiornamentoDatiAttivazioneCessazioneToOM(String processo, String tipo_comunicazione, String esito){
         Test.startTest();
        OF_SA_GE_UtilsNew utils = new OF_SA_GE_UtilsNew();
        String processo = 'Create'; //Delete
        String tipo_comunicazione = '2'; //11
        String esito = '0';
        String data_prevista_attivazione = 'Test4';
        OF_SA_GE_UtilsNew.aggiornamentoDatiAttivazioneCessazioneToOM(processo, tipo_comunicazione, esito);
        Test.stopTest();
        
    }
    
    
    
    
   
}
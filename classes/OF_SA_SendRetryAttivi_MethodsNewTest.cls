@isTest
public class OF_SA_SendRetryAttivi_MethodsNewTest {
    
     @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    //for method routeRetry
    public static testMethod void MethodOne_routeRetry1(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_Activation';
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        Test.startTest();
        OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        String rtypeDevName = 'OF_SA_Attivazione';
        string codiceOrdineOLO = 'Codice';
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
        
    }
    //for method retryCalloutOLOOM(else part - 50)
    public static testMethod void MethodOne_routeRetry2(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_Activation';
        c.OF_Response_da_SH__c = 'Test';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
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
        eaiLog.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        insert eaiLog;
        
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        insert eaiLog1;
        
        Test.startTest();
        OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        String rtypeDevName = 'OF_SA_Attivazione';
        string codiceOrdineOLO = '02112016_37';
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
       
    }
    //for method retryCalloutOLOOM(else part - 174)
    public static testMethod void MethodOne_routeRetry3(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_Activation';
        c.OF_Response_Da_OM__c = 'Test';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        eaiLog.OF_SA_Direzione_Flusso__c='SF-OM';
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
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        eaiLog1.OF_SA_Direzione_Flusso__c='SF-OM';
        insert eaiLog1;
        
        String EaiLogRecordTypeId2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_ID_Notifica__c = 'test_01';
        eaiLog2.EOF_Codice_Ordine_OLO__c = '02112016_37';
        //eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog2.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog2.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog2.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog2.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog2.RecordTypeId = EaiLogRecordTypeId2;
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog2.EOF_GPON_Attestazione__c = 'Test';
        eaiLog2.EOF_Nome_Cliente__c = 'Test';
        eaiLog2.EOF_COgnome_CLiente__c = 'Test';
        eaiLog2.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog2.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog2.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog2.EOF_Codice_Motivazione__c = 'Test';
        eaiLog2.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        eaiLog2.OF_SA_VLan_Log__c = eaiLog.Id;
        eaiLog2.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog2.OF_SA_servizi_Aggiuntivi_Log__c = eaiLog.Id;
        insert eaiLog2;
        
        String EaiLogRecordTypeId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog3 = new EOF_EAI_Service_Log__c();
        eaiLog3.Caso__c  = c.Id;
        eaiLog3.EOF_ID_Notifica__c = 'test_01';
        eaiLog3.EOF_Codice_Ordine_OLO__c = '02112016_37';
        //eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog3.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog3.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog3.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog3.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog3.OF_SA_ACK__c = true;
        eaiLog3.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog3.RecordTypeId = EaiLogRecordTypeId3;
        eaiLog3.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog3.EOF_GPON_Attestazione__c = 'Test';
        eaiLog3.EOF_Nome_Cliente__c = 'Test';
        eaiLog3.EOF_COgnome_CLiente__c = 'Test';
        eaiLog3.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog3.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog3.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog3.EOF_Codice_Motivazione__c = 'Test';
        eaiLog3.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        eaiLog3.OF_SA_VLan_Log__c = eaiLog.Id;
        eaiLog3.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog3.OF_SA_servizi_Aggiuntivi_Log__c = eaiLog.Id;
        eaiLog3.OF_SA_Direzione_Flusso__c='SF-OM';
        insert eaiLog3;
        
        Test.startTest();
         OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        String rtypeDevName = 'EOF_Caso_Attivazione';
        string codiceOrdineOLO = '02112016_37';
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
        
    }
    //for method retryCalloutOLOOM(else part - 234)
    public static testMethod void MethodOne_routeRetry4(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_Activation';
        c.OF_Response_Da_OM__c = 'Test';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
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
        eaiLog.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        eaiLog.OF_SA_Direzione_Flusso__c='SF-OM';
        eaiLog.EOF_TIPOLOGIA_SERVIZIO__c = 'Test';
        insert eaiLog;
        
        String EaiLogRecordTypeId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog1.RecordTypeId = EaiLogRecordTypeId1;
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog1.EOF_GPON_Attestazione__c = 'Test';
        eaiLog1.EOF_Nome_Cliente__c = 'Test';
        eaiLog1.EOF_COgnome_CLiente__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog1.EOF_Codice_Motivazione__c = 'Test';
        eaiLog1.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.Id;
        eaiLog1.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog1.OF_SA_servizi_Aggiuntivi_Log__c = eaiLog.Id;
        eaiLog1.EOF_TIPOLOGIA_SERVIZIO__c = 'Test';
        insert eaiLog1;
        
        String EaiLogRecordTypeId2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_ID_Notifica__c = 'test_01';
        eaiLog2.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog2.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog2.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog2.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog2.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog2.RecordTypeId = EaiLogRecordTypeId2;
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'CPE';
        eaiLog2.EOF_GPON_Attestazione__c = 'Test';
        eaiLog2.EOF_Nome_Cliente__c = 'Test';
        eaiLog2.EOF_COgnome_CLiente__c = 'Test';
        eaiLog2.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'Test';
        eaiLog2.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'Test';
        eaiLog2.EOF_PIN_INTERVENTO_A_VUOTO__c = 'Test';
        eaiLog2.EOF_Codice_Motivazione__c = 'Test';
        eaiLog2.OF_SA_Metodo__c = 'OLO_DeactivationOrder';
        eaiLog2.OF_SA_VLan_Log__c = eaiLog.Id;
        eaiLog2.OF_SA_Cpe_Log__c = eaiLog.Id;
        eaiLog2.OF_SA_servizi_Aggiuntivi_Log__c = eaiLog.Id;
        eaiLog2.EOF_TIPOLOGIA_SERVIZIO__c = 'Test';
        insert eaiLog2;
        
        List<EOF_EAI_Service_Log__c> eai = new List<EOF_EAI_Service_Log__c>();
        eai.add(eaiLog1);
        eai.add(eaiLog2);
        
        Test.startTest();
         OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        OF_SA_GE_UtilsNew.ListSlDeactivationSFOM = eai;
        OF_SA_GE_UtilsNew.checkRTMap = false;
        String rtypeDevName = 'EOF_Caso_Attivazione';
        string codiceOrdineOLO = '02112016_37';
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock5());
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
        
    }
    //for method retryCalloutOM_StatusUpdate (containskey('0'))
    public static testMethod void MethodOne_routeRetry5(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_StatusUpdate';
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
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
        
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SF->OM - StatusUpdateRequest';
        eaiLog.OF_SA_Direzione_Flusso__c = 'SF-OM';
        eaiLog.OF_SA_Metodo__c = 'OLO_StatusUpdate';
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Response__c = 'NACK TECNICO';
        eaiLog.EOF_CODICE_OPERATORE__c = 'VF';
        
        insert eaiLog;
        
        Test.startTest();
        OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        String rtypeDevName = 'OF_SA_Attivazione';
        string codiceOrdineOLO = 'Codice';
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock1());
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
        
    }
    
     //for method retryCalloutOM_StatusUpdate (containskey('1'))
    public static testMethod void MethodOne_routeRetry6(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_StatusUpdate';
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
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
        
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SF->OM - StatusUpdateRequest';
        eaiLog.OF_SA_Direzione_Flusso__c = 'SF-OM';
        eaiLog.OF_SA_Metodo__c = 'OLO_StatusUpdate';
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Response__c = 'NACK TECNICO';
        eaiLog.EOF_CODICE_OPERATORE__c = 'VF';
        
        insert eaiLog;
        
        Test.startTest();
        OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        String rtypeDevName = 'OF_SA_Attivazione';
        string codiceOrdineOLO = 'Codice';
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock2());
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
        
    }
    
    //for method retryCalloutOM_Reschedule (containskey('0'))
    public static testMethod void MethodOne_routeRetry7(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_Reschedule';
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
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
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SF->OM - RescheduleRequest';
        eaiLog.OF_SA_Direzione_Flusso__c = 'SF-OM';
        eaiLog.OF_SA_Metodo__c = 'OLO_Reschedule';
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Response__c = 'NACK TECNICO';
        eaiLog.EOF_CODICE_OPERATORE__c = 'VF';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        String rtypeDevName = 'OF_SA_Attivazione';
        string codiceOrdineOLO = 'Codice';
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock3());
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
        
    } 
    
     //for method retryCalloutOM_Reschedule (containskey('1'))
    public static testMethod void MethodOne_routeRetry8(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.OF_Flusso_Retry__c = 'OLO_Reschedule';
        c.OF_Response_da_SH__c = 'NACK TECNICO';
        insert c;
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
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
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SF->OM - RescheduleRequest';
        eaiLog.OF_SA_Direzione_Flusso__c = 'SF-OM';
        eaiLog.OF_SA_Metodo__c = 'OLO_Reschedule';
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Response__c = 'NACK TECNICO';
        eaiLog.EOF_CODICE_OPERATORE__c = 'VF';
        insert eaiLog;
        
        Test.startTest();
        OF_SA_SendRetryAttivi_MethodsNew Attivi = new OF_SA_SendRetryAttivi_MethodsNew();
        OF_GPONP_GE_Utils.caseOriginale = c;
        String rtypeDevName = 'OF_SA_Attivazione';
        string codiceOrdineOLO = 'Codice';
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock4());
        OF_SA_SendRetryAttivi_MethodsNew.routeRetry(c.Id,rtypeDevName,codiceOrdineOLO);
        Test.stopTest();
        
    } 

}
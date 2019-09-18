@isTest
public class OF_GPONP_GE_Utils_Test {
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    public static testMethod void syncErrorMethod1() {
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
        
        OF_GPONP_GE_Utils.slOLOSF = eaiLog;
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP olo = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP();  
        String errorCode = 'A03';
        OF_GPONP_GE_Utils.syncError(olo, errorCode,'Test');
        String errorCode1 = 'A05';
        OF_GPONP_GE_Utils.syncError(olo, errorCode1,'Test');
        String errorCode2 = 'A06';
        OF_GPONP_GE_Utils.syncError(olo, errorCode2,'Test');
        String errorCode3 = 'A08';
        OF_GPONP_GE_Utils.syncError(olo, errorCode3,'Test');
        String errorCode4 = 'A07';
        OF_GPONP_GE_Utils.syncError(olo, errorCode4,'Test');
        String errorCode5 = 'A12';
        OF_GPONP_GE_Utils.syncError(olo, errorCode5,'Test');
        String errorCode6 = 'A13';
        OF_GPONP_GE_Utils.syncError(olo, errorCode6,'Test');
        String errorCode7 = 'A14';
        OF_GPONP_GE_Utils.syncError(olo, errorCode7,'Test');
        //String errorCode9 = '*KO_SH*';
        //OF_GPONP_GE_Utils.syncError(olo, errorCode9,'Test');
        String errorCode10 = 'B04';
        OF_GPONP_GE_Utils.syncError(olo, errorCode10,'Test');
        String errorCode11 = 'A09';
        OF_GPONP_GE_Utils.syncError(olo, errorCode11,'Test');
        String errorCode12 = 'A10';
        OF_GPONP_GE_Utils.syncError(olo, errorCode12,'Test');
        OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP olo1 = new OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP();
        OF_GPONP_GE_Utils.syncError(olo1, errorCode,'Test');
        OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP olo2 = new OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP();
        olo2.CODICE_ORDINE_OLO ='02112016_37';
        OF_GPONP_GE_Utils.syncError(olo2, errorCode,'Test');
        OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest olo3 = new OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        OF_GPONP_GE_Utils.syncError(olo3, errorCode,'Test');
        
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP olo4 = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP();
        olo4.CODICE_ORDINE_OLO = '02112016_37';
        OF_GPONP_WS_IN_OLO_Activation.APPARATO apparta = new OF_GPONP_WS_IN_OLO_Activation.APPARATO();
        olo4.APPARATO = new List<OF_GPONP_WS_IN_OLO_Activation.APPARATO>();
        olo4.APPARATO.add(apparta);
        OF_GPONP_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO sa = new OF_GPONP_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        olo4.SERVIZIO_AGGIUNTIVO = new List<OF_GPONP_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        olo4.SERVIZIO_AGGIUNTIVO.add(sa);
        OF_GPONP_GE_Utils.create_EAI_Log(olo4);
        
        OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP olo5 = new OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP();
        olo5.CODICE_ORDINE_OLO ='02112016_37';
        OF_GPONP_GE_Utils.create_EAI_Log(olo5);
        
        OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest olo6 = new OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        olo6.CODICE_ORDINE_OLO ='02112016_37';
        OF_GPONP_WS_IN_OLO_Deactivation.APPARATO apparta1 = new OF_GPONP_WS_IN_OLO_Deactivation.APPARATO();
        olo6.APPARATO = new List<OF_GPONP_WS_IN_OLO_Deactivation.APPARATO>();
        olo6.APPARATO.add(apparta1);
        OF_GPONP_GE_Utils.create_EAI_Log(olo6);
        
        Map<String, String> olo7 = new Map<String, String>();
        olo7.put('Type','ACK');
        OF_GPONP_GE_Utils.create_EAI_Log(olo7);
        
        OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP olo8 = new OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP();
        olo8.CODICE_ORDINE_OLO ='02112016_37';
        OF_GPONP_GE_Utils.OLO_CreateStatusUpdate_Log(c,olo8);
        OF_GPONP_GE_Utils.checkRTMap = False;
        OF_GPONP_GE_Utils.CreateAcquisition_LogNew(c);
        OF_GPONP_GE_Utils.copy_notify_AcqCessNew(eaiLog);
        OF_GPONP_GE_Utils.slSFOLO= eaiLog;
       // OF_GPONP_GE_Utils.aggiornamentoDatiAcquisizione(c);
    }
     
    public static testMethod void syncErrorMethod2() {
        
        List<RecordType> rtypes = [SELECT DeveloperName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
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
        

        String serRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        List<EOF_EAI_Service_Log__c>  eaiLogList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        //eaiLog.name = 'abc';
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        //eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Codice_Ordine_OLO__c = 'abc_1';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.RecordTypeId = serRecordTypeId;
        eaiLog.RecordTypeId = RTMap.get('OF_SA_FiberRequest');
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        //insert eaiLogList; 
        insert eaiLog; 
        eaiLogList.add(eaiLog);
        //eaiLogList.add(eaiLog);
        EOF_EAI_Service_Log__c eaiLog1 = [select recordtype.developername,EOF_NOTE__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,EOF_RECAPITO_TEST_LINEA__c,EOF_ID_Pop__c,EOF_PROFILO__c,TRACCIATO_TRASCODIFICATO__c,EOF_GPON_Attestazione__c,OF_Codice_Operatore_Secondario__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, Caso__c,OF_SA_VLan_Log__c, EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                EOF_ID_Risorsa__c,EOF_Tipo_COmunicazione_String__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Response__c,EOF_Tipo_comunicazione__c FROM EOF_EAI_Service_Log__c
                                WHERE EOF_Codice_Ordine_OLO__c = 'abc_1'];
        eaiLogList.add(eaiLog1);
        OF_GPONP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_GPONP_GE_Utils.slOLOSF = eaiLog1;
        
        OF_GPONP_GE_Utils.create_ActivationToOM_Log(c,eaiLogList); // Need to increase
        TEMPLOG__c  temp = new TEMPLOG__c();
        temp.Class__c = 'Test';
        temp.Tempi_Parziali__c = 'Test';
        insert temp;
        Test.startTest();
        TEMPLOG__c tmpl = temp;
        OF_GPONP_GE_Utils.EndTemplog();
        OF_GPONP_GE_Utils.partialTemplog('Test');
        OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP olo = new OF_GPONP_WS_IN_OLO_Activation.OLO_ActivationRequest_GPONP();
        OF_GPONP_GE_Utils.CreateTemplogOLO(olo);
        OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP olo1 = new OF_GPONP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest_GPONP();
        olo1.AZIONE = '0';
        OF_GPONP_GE_Utils.CreateTemplogOLO(olo1);
        olo1.AZIONE = '1';
        OF_GPONP_GE_Utils.CreateTemplogOLO(olo1);
        OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP olo2 = new OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP();
        OF_GPONP_GE_Utils.CreateTemplogOLO(olo2);
        OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest olo3 = new OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        OF_GPONP_GE_Utils.CreateTemplogOLO(olo3);
        OF_GPONP_GE_Utils.checkAmministratori(c);
        
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        OF_GPONP_GE_Utils.controlloVendibilita('VF','Test');
        OF_GPONP_GE_Utils.getQueryNew('case','AsyncActivation');
        String processo ='AsyncDeactivation';
        OF_GPONP_GE_Utils.getQueryNew('case',processo);
        String oggetto='sl';
        OF_GPONP_GE_Utils.getQueryNew(oggetto,'AsyncActivation');
        OF_GPONP_GE_Utils.getQueryNew(oggetto,'AsyncDeactivation');
        OF_GPONP_GE_Utils.getQueryNew('asset','AsyncDeactivation');
        
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        OF_GPONP_GE_Utils.ListSlDeactivationOLOSF=eaiLogList;
        OF_GPONP_GE_Utils.ListSlDeactivationSFOM =eaiLogList;
        OF_GPONP_GE_Utils.ListSlActivationOLOSF =eaiLogList;
        OF_GPONP_GE_Utils.a =asset_1;
        Test.setMock(WebServiceMock.class, new OF_GPONP_GE_Utils_Mock());
       // OF_GPONP_GE_Utils.makeCalloutOLOOMNew(eaiLog);
        try{
            OF_GPONP_GE_Utils.makeCalloutOLOOMNew(eaiLog);
        }Catch(exception e){}
        OF_GPONP_GE_Utils.create_DeactivationToOM_Log(c,eaiLogList,asset_1);
       
        Test.stopTest();
       
    }
    
    public static testMethod void syncErrorMethod2a() {
        
        List<RecordType> rtypes = [SELECT DeveloperName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
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
        

        String serRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        List<EOF_EAI_Service_Log__c>  eaiLogList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        //eaiLog.name = 'abc';
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        //eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Codice_Ordine_OLO__c = 'abc_1';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.RecordTypeId = serRecordTypeId;
        //eaiLog.RecordTypeId = RTMap.get('OF_SA_FiberRequest');
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        //insert eaiLogList; 
        insert eaiLog; 
        eaiLogList.add(eaiLog);
        //eaiLogList.add(eaiLog);
        EOF_EAI_Service_Log__c eaiLog1 = [select recordtype.developername,EOF_NOTE__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,EOF_RECAPITO_TEST_LINEA__c,EOF_ID_Pop__c,EOF_PROFILO__c,TRACCIATO_TRASCODIFICATO__c,EOF_GPON_Attestazione__c,OF_Codice_Operatore_Secondario__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, Caso__c,OF_SA_VLan_Log__c, EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                EOF_ID_Risorsa__c,OF_SA_ID_APPARATO__c,EOF_Tipo_COmunicazione_String__c,EOF_TIPOLOGIA_APPARATO__c,OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,EOF_CAUSALE_APPARATO__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Response__c,EOF_Tipo_comunicazione__c FROM EOF_EAI_Service_Log__c
                                WHERE EOF_Codice_Ordine_OLO__c = 'abc_1'];
        eaiLogList.add(eaiLog1);
        OF_GPONP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_GPONP_GE_Utils.slOLOSF = eaiLog1;
        
        OF_GPONP_GE_Utils.create_ActivationToOM_Log(c,eaiLogList);
        OF_GPONP_GE_Utils.create_DeactivationToOM_Log(c,eaiLogList,asset_1);
        
       }
    
        public static testMethod void syncErrorMethod2b() {
        
        List<RecordType> rtypes = [SELECT DeveloperName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
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
        

        String serRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        List<EOF_EAI_Service_Log__c>  eaiLogList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        //eaiLog.name = 'abc';
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        //eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Codice_Ordine_OLO__c = 'abc_1';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.RecordTypeId = serRecordTypeId;
        //eaiLog.RecordTypeId = RTMap.get('OF_SA_FiberRequest');
        eaiLog.EOF_Response__c = 'NACK';
        eaiLog.EOF_Tipo_comunicazione__c = '5';
        //insert eaiLogList; 
        insert eaiLog; 
        eaiLogList.add(eaiLog);
        //eaiLogList.add(eaiLog);
        EOF_EAI_Service_Log__c eaiLog1 = [select recordtype.developername,EOF_NOTE__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,EOF_RECAPITO_TEST_LINEA__c,EOF_ID_Pop__c,EOF_PROFILO__c,TRACCIATO_TRASCODIFICATO__c,EOF_GPON_Attestazione__c,OF_Codice_Operatore_Secondario__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, Caso__c,OF_SA_VLan_Log__c, EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_COmunicazione_String__c,EOF_TIPOLOGIA_APPARATO__c,OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,EOF_CAUSALE_APPARATO__c,EOF_Data_Espletamento_Ordine__c,OF_SA_ACK__c,EOF_Response__c,EOF_Tipo_comunicazione__c FROM EOF_EAI_Service_Log__c
                                WHERE EOF_Codice_Ordine_OLO__c = 'abc_1'];
        eaiLogList.add(eaiLog1);
        OF_GPONP_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_GPONP_GE_Utils.slOLOSF = eaiLog1;
        
        OF_GPONP_GE_Utils.create_ActivationToOM_Log(c,eaiLogList); 
        
       }
       public static testMethod void syncErrorMethod3() {
        
        List<RecordType> rtypes = [SELECT DeveloperName, Id 
                                   FROM RecordType 
                                   WHERE (sObjectType = 'Case' OR sObjectType = 'Account' OR sObjectType = 'Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  
                                   AND isActive = true];
        
        map<String,Id> RTMap = new Map<String,Id>();
        
        for(RecordType rt : rtypes){
            RTMap.put(rt.DeveloperName, rt.Id);    
        }
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
        

        //String serRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        List<EOF_EAI_Service_Log__c>  eaiLogList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        //eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.EOF_Codice_Ordine_OLO__c = 'abc_1';
        eaiLog.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.RecordTypeId = RTMap.get('OF_SA_FiberRequest');
        eaiLog.EOF_Response__c = 'NACK';
        insert eaiLog; 
           
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        //eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'abc_1';
        eaiLog1.OF_SA_VLan_Log__c = eaiLog.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        eaiLog1.EOF_Data_Espletamento_Ordine__c = System.today();
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_SL_Riferimento__c =  eaiLog.id;
        eaiLog1.RecordTypeId = RTMap.get('OF_SA_FiberRequest');
        eaiLog1.EOF_Response__c = 'NACK';
        insert eaiLog1; 
        eaiLogList.add(eaiLog);
           
        OF_GPONP_GE_Utils.slSFOLOresp = eaiLog1;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog1;
        Test.startTest();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        OF_GPONP_GE_Utils.ListSlDeactivationOLOSF=eaiLogList;
        OF_GPONP_GE_Utils.ListSlDeactivationSFOM =eaiLogList;
        OF_GPONP_GE_Utils.ListSlActivationOLOSF =eaiLogList;
        OF_GPONP_GE_Utils.a =asset_1;
        Test.setMock(WebServiceMock.class, new OF_GPONP_GE_Utils_Mock());
        try{
            OF_GPONP_GE_Utils.makeCalloutOLOOMNew(eaiLog);
        }Catch(exception e){}
        try{
        OF_GPONP_GE_Utils.makeCalloutOMNew(eaiLogList);
        }Catch(exception e){}
           
        //OF_GPONP_GE_Utils.checkCliente = false;
        //OF_GPONP_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('Create','98','Test');
        OF_GPONP_GE_Utils.slSFOLO = eaiLog ;
        //OF_GPONP_GE_Utils.aggiornamentoDatiAcquisizione(c);
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
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        OF_GPONP_GE_Utils.checkAmministratori(c);
        Test.stopTest();
        } 
     //for method dateToString,checkDate and checkEmail
    public static testMethod void Method_dateToString(){
        
        Test.startTest();
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        date dt1 = null;
        OF_GPONP_GE_Utils.dateToString(dt1);
        date dt2 = System.today();
        OF_GPONP_GE_Utils.dateToString(dt2);
        String S1 = '';
        OF_GPONP_GE_Utils.checkDate(S1);
        String S2 = 'Test';
        OF_GPONP_GE_Utils.checkDate(S2);
        String email1 = '';
        OF_GPONP_GE_Utils.checkEmail(email1);
        String email2 = 'Test';
        OF_GPONP_GE_Utils.checkEmail(email2);
        Test.stopTest();
        
    }
     //for method dateToStringNoTime
    public static testMethod void Method_dateToStringNoTime(){
        
        Test.startTest();
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        date dt = System.today();
        OF_GPONP_GE_Utils.dateToStringNoTime(dt);
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
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        String tokenId = 'Test1';
        String codice_ordine_olo = 'Test2';
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.makeCalloutOLOSHCancelReserve(tokenId,codice_ordine_olo);
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
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        OF_GPONP_GE_Utils.OLOSHConfirm_copy_request(eaiLog);
        eaiLog.OF_SA_Esito__c = 'OK';
        OF_GPONP_GE_Utils.OLOSHConfirm_copy_request(eaiLog);
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
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        OF_GPONP_GE_Utils.caseOriginale = c;
        OF_GPONP_GE_Utils.slSFOLO = eaiLog;
        OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP o = new OF_GPONP_WS_IN_OLO_Reschedule.OLO_RescheduleRequest_GPONP();
        o.CODICE_ORDINE_OLO = '02112016_37';
        OF_GPONP_GE_Utils.OLO_CreateReschedule_Log(c,o);
        Test.stopTest();
        
    } 
//for method makeCalloutOLOSHConfirmation
    public static testMethod void Method_makeCalloutOLOSHConfirmation(){
        
        Test.startTest();
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        String tokenId = 'Test1'; 
        String codice_ordine_olo = 'Test2';
        String codice_operatore = 'Test3';
        String data_prevista_attivazione = 'Test4';
        OF_SA_GE_UtilsNew.makeCalloutOLOSHConfirmation(tokenId,codice_ordine_olo,codice_operatore,data_prevista_attivazione);
        Test.stopTest();
    }
    
      //for method partialTemplog and EndTemplog
    public static testMethod void Method_partialTemplog(){
        
        Test.startTest();
        OF_GPONP_GE_Utils utils = new OF_GPONP_GE_Utils();
        String s = 'Test';        
        OF_GPONP_GE_Utils.partialTemplog(s);
        OF_GPONP_GE_Utils.EndTemplog();
        Test.stopTest();
    }


 
  
}
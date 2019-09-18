@isTest
public class OF_OM_EntryChecksNew_Test {
    
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    } 
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'OF_commercialElementIstanziato__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
        
        for(RecordType rt: rtypes)
            RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
    public static void CEIst(case c)
    { 
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_commercialElementIstanziato__c CE = new OF_commercialElementIstanziato__c();
        CE.Recordtypeid = RecordTypeMap.get('CPE');
        CE.OF_SA_CPE__c = c.id;
        CE.OF_Case__c = c.id;
        CE.OF_TipologiaApparato__C = 'T';
        CE.OF_Stato__c='Attivo';
        CE.OF_EsitoConsegnaApparato__c='2';
        CE.OF_CommercialElement__c=ce.id;
        insert CE;
    }
    
    public static void CEIst1(case c)
    { 
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_commercialElementIstanziato__c CE = new OF_commercialElementIstanziato__c();
        CE.Recordtypeid = RecordTypeMap.get('Servizi Aggiuntivi');
        CE.OF_SA_CPE__c = c.id;
        CE.OF_Case__c = c.id;
        CE.OF_TipologiaApparato__C = 'T';
        CE.OF_SA_Servizio_Aggiuntivo__c = c.id;
        CE.OF_Nome_Servizio__c = 'T';
        insert CE;
    }
    
    public static void CEIst2(case c)
    { 
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_commercialElementIstanziato__c CE = new OF_commercialElementIstanziato__c();
        CE.Recordtypeid = RecordTypeMap.get('VLAN');
        CE.OF_SA_VLAN__c = c.id;
        CE.OF_Case__c = c.id;
        CE.OF_TipologiaApparato__C = 'T';
        CE.OF_ServiceVLAN__c = 'SERVICE';
        CE.OF_UserVLAN__c = 'USER';
        insert CE;
    } 
    
    //for method 1 - SyncChecksNotifyStatusUpdate
    public static testMethod void MethodOne_1(){
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_OPERATORE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = '12';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_OPERATORE = 'VF';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OLO = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OLO = '1234567890';
        su.CODICE_ORDINE_OF = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OF = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.CODICE_ORDINE_OF = '1234567890';
        su.STATO_ORDINE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.STATO_ORDINE = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest();
    }
    
    public static testMethod void MethodOne_2(){
        
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
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.STATO_ORDINE = '6';
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        su.DATA_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        c1.Status = 'In Annullamento';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        c1.Status = 'Sospeso';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        c1.Status = 'Accettato';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest();
    }
    
    public static testMethod void MethodOne_3(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.STATO_ORDINE = '6';
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '6';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '4';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        Test.stopTest();
    }
    
    public static testMethod void MethodOne_4A(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.PIN_INTERVENTO_A_VUOTO = '1234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    //for last else part of the method 1
   /**  public static testMethod void MethodOne_4B(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        c.PO_SA_Portale__C = false;
        c.OF_Bonifica_Locked_Row__c = true;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        Test.setMock(WebServiceMock.class, new OF_OM_EntryChecksNew_Mock2());
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '4';
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.PIN_INTERVENTO_A_VUOTO = '1234567890';
        Test.setMock(WebServiceMock.class, new OF_OM_EntryChecksNew_Mock2());
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    } **/
    
    public static testMethod void MethodOne_5(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        su.STATO_ORDINE = '2';
        su.NOME_CLIENTE = '1';
        su.ID_SERVIZIO = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '2';
        su.NOME_CLIENTE = '1';
        su.ID_SERVIZIO = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '0';
        su.ID_SERVIZIO = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '0';
        su.ID_SERVIZIO = '1';
        su.FLAG_DESOSPENSIONE = '123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '0';
        su.ID_SERVIZIO = '1';
        su.FLAG_DESOSPENSIONE = 'SI';
        su.REMOTE_ID = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    //APPARATO
    public static testMethod void MethodOne_6(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '0';
        
        OF_WS_IN_OM_StatusUpdateNew.APPARATO ra = new OF_WS_IN_OM_StatusUpdateNew.APPARATO();
        su.APPARATO = new List<OF_WS_IN_OM_StatusUpdateNew.APPARATO>();
        
        ra.TIPOLOGIA_APPARATO = '';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        ra.TIPOLOGIA_APPARATO = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        ra.TIPOLOGIA_APPARATO = '1234567890';
        ra.ESITO_RITIRO_APPARATO = '';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        ra.TIPOLOGIA_APPARATO = '1234567890';
        ra.ESITO_RITIRO_APPARATO = '12';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        ra.TIPOLOGIA_APPARATO = '1234567890';
        ra.ESITO_RITIRO_APPARATO = '1';
        ra.CODICE_MOTIVAZIONE_RITIRO = '12345';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        ra.TIPOLOGIA_APPARATO = '1234567890';
        ra.ESITO_RITIRO_APPARATO = '1';
        ra.CODICE_MOTIVAZIONE_RITIRO = '1';
        ra.ID_APPARATO = '123456789012345678901234567890123456789012345678901234567890';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        ra.TIPOLOGIA_APPARATO = '1234567890';
        ra.ESITO_RITIRO_APPARATO = '1';
        ra.CODICE_MOTIVAZIONE_RITIRO = '1';
        ra.ID_APPARATO = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodOne_6A(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '0';
        
        OF_WS_IN_OM_StatusUpdateNew.APPARATO ra = new OF_WS_IN_OM_StatusUpdateNew.APPARATO();
        su.APPARATO = new List<OF_WS_IN_OM_StatusUpdateNew.APPARATO>();
        
        ra.TIPOLOGIA_APPARATO = '1234567890';
        ra.ESITO_RITIRO_APPARATO = '1';
        ra.CODICE_MOTIVAZIONE_RITIRO = '1';
        ra.ID_APPARATO = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    
    //VLAN
    public static testMethod void MethodOne_7(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst2(c1);
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        su.STATO_ORDINE = '0';
        
        OF_WS_IN_OM_StatusUpdateNew.VLAN vn = new OF_WS_IN_OM_StatusUpdateNew.VLAN();
        su.VLAN = new List<OF_WS_IN_OM_StatusUpdateNew.VLAN>();
        
        vn.USER_VLAN = '';
        su.VLAN.add(vn);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        vn.USER_VLAN = '12345';
        su.VLAN.add(vn);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        vn.USER_VLAN = '1';
        vn.SERVICE_VLAN = '';
        su.VLAN.add(vn);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        vn.USER_VLAN = '1';
        vn.SERVICE_VLAN = '12345';
        su.VLAN.add(vn);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        vn.USER_VLAN = '1';
        vn.SERVICE_VLAN = '1';
        vn.CUSTOMER_VLAN = '';
        su.VLAN.add(vn);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        vn.USER_VLAN = '1';
        vn.SERVICE_VLAN = '1';
        vn.CUSTOMER_VLAN = '12345';
        su.VLAN.add(vn);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        vn.USER_VLAN = 'T';
        vn.SERVICE_VLAN = 'T1';
        vn.CUSTOMER_VLAN = '1';
        su.VLAN.add(vn);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    //for STATO_ORDINE =2,4
    public static testMethod void MethodOne_8(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c 
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        su.STATO_ORDINE = '2';
        su.ID_SERVIZIO = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '4';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    //for STATO_ORDINE =3,5
    public static testMethod void MethodOne_9(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        su.STATO_ORDINE = '3';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        su.STATO_ORDINE = '5';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    
    //for STATO_ORDINE =6
    public static testMethod void MethodOne_10(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        //contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        Case_AssetRecordType__c cs = new Case_AssetRecordType__c();
        cs.Name = 'Name';
        cs.assetDevName__c = 'P2P';
        cs.caseDevName__c = 'OF_SA_Cessazione';
        cs.beAttivazioneList__c= 'Contributo Attivazione ,Canone';
        cs.beCessazioneList__c = 'Contributo Cessazione ,Canone';
        insert cs;
        
        Verticali__c v = new Verticali__c();
        v.Name = 'Name';
        v.RecordTypesAssets__c = 'OF_OpenStream';
        insert v;
        
        su.STATO_ORDINE = '6';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    
    //for STATO_ORDINE =7
    public static testMethod void MethodOne_11(){
        
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
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        //contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        Case_AssetRecordType__c cs = new Case_AssetRecordType__c();
        cs.Name = 'Name';
        cs.assetDevName__c = 'P2P';
        cs.caseDevName__c = 'OF_SA_Cessazione';
        cs.beAttivazioneList__c= 'Contributo Attivazione ,Canone';
        cs.beCessazioneList__c = 'Contributo Cessazione ,Canone';
        insert cs;
        
        Verticali__c v = new Verticali__c();
        v.Name = 'Name';
        v.RecordTypesAssets__c = 'OF_OpenStream';
        insert v;
        
        su.STATO_ORDINE = '7';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate(su);
        
        Test.stopTest();
    }
    
    //for method 2 - SyncChecksNotifyStatusUpdate_GPONP
    public static testMethod void MethodTwo_1(){
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        
        su.CODICE_OPERATORE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = '12';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = 'VF';
        SU.CODICE_ORDINE_OLO = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OLO = '1';
        su.CODICE_ORDINE_OF = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OLO = '1';
        su.CODICE_ORDINE_OF = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OLO = '1';
        su.CODICE_ORDINE_OF = '1';
        su.STATO_ORDINE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OLO = '1';
        su.CODICE_ORDINE_OF = '1';
        su.STATO_ORDINE = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    //su.STATO_ORDINE = '6' and case record type = 'EOF Caso - Cessazione'
    public static testMethod void MethodTwo_2(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Cessazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '6';
        
        c1.OF_Blocked_Case__c = True;
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        c1.OF_Blocked_Case__c = False;
        update c1;
        su.DATA_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:20';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Espletato';
        update c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'In Annullamento';
        update c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Sospeso';
        update c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Accettato';
        update c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodTwo_3(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Cessazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '6';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        su.CODICE_MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.FLAG_DESOSPENSIONE = '123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.FLAG_DESOSPENSIONE = 'SI';
        su.REMOTE_ID = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
                
        Test.stopTest();
    }
    //su.STATO_ORDINE = '4' and case record type = 'EOF Caso - Attivazione'
    public static testMethod void MethodTwo_4A(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '4';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        
        su.NOME_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    
    //su.STATO_ORDINE = '4'(if part) and case record type = 'EOF Caso - Attivazione'
    public static testMethod void MethodTwo_4B(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '4';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        
        su.NOME_CLIENTE = '1';
        su.COGNOME_CLIENTE = '1';
        su.RECAPITO_TELEFONICO_CLIENTE = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    //su.STATO_ORDINE = '2'
    public static testMethod void MethodTwo_5(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '2';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        
        su.GPON_DI_ATTESTAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.GPON_DI_ATTESTAZIONE = '123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.GPON_DI_ATTESTAZIONE = '1';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodTwo_6(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
    
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '2';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        
        su.GPON_DI_ATTESTAZIONE = '1';
        su.PIN_INTERVENTO_A_VUOTO = '1234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.GPON_DI_ATTESTAZIONE = '1';
        su.PIN_INTERVENTO_A_VUOTO = '1';
        su.ID_SERVIZIO = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.GPON_DI_ATTESTAZIONE = '1';
        su.PIN_INTERVENTO_A_VUOTO = '1';
        su.ID_SERVIZIO = '1';
        su.STATO_ORDINE = '0';
        su.GPON_DI_ATTESTAZIONE = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    //APPARATO
    public static testMethod void MethodTwo_7(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '2';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        OF_WS_IN_OM_StatusUpdateNew.APPARATO ra = new OF_WS_IN_OM_StatusUpdateNew.APPARATO();
        su.APPARATO = new List<OF_WS_IN_OM_StatusUpdateNew.APPARATO>();
        
        ra.TIPOLOGIA_APPARATO = '';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        ra.TIPOLOGIA_APPARATO = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        ra.TIPOLOGIA_APPARATO = '1';
        ra.ESITO_RITIRO_APPARATO = '';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        ra.TIPOLOGIA_APPARATO = '1';
        ra.ESITO_RITIRO_APPARATO = '12';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        ra.TIPOLOGIA_APPARATO = '1';
        ra.ESITO_RITIRO_APPARATO = '1';
        ra.CODICE_MOTIVAZIONE_RITIRO = '12345';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        ra.TIPOLOGIA_APPARATO = '1';
        ra.ESITO_RITIRO_APPARATO = '1';
        ra.CODICE_MOTIVAZIONE_RITIRO = '1';
        ra.ID_APPARATO = '123456789012345678901234567890123456789012345678901234567890';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        ra.TIPOLOGIA_APPARATO = '1';
        ra.ESITO_RITIRO_APPARATO = '1';
        ra.CODICE_MOTIVAZIONE_RITIRO = '1';
        ra.ID_APPARATO = '1';
        su.APPARATO.add(ra);
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    //su.STATO_ORDINE = '6'
    public static testMethod void MethodTwo_8(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Cessazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        Case_AssetRecordType__c cs = new Case_AssetRecordType__c();
        cs.Name = 'Name';
        cs.assetDevName__c = 'P2P';
        cs.caseDevName__c = 'EOF_Caso_Cessazione';
        cs.beAttivazioneList__c= 'Contributo Attivazione ,Canone';
        cs.beCessazioneList__c = 'Contributo Cessazione ,Canone';
        insert cs;
        
       Verticali__c v = new Verticali__c();
        v.Name = 'Name';
        v.RecordTypesAssets__c = 'OF_OpenStream';
        insert v; 
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '6';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    
    //su.STATO_ORDINE = '0'
    public static testMethod void MethodTwo_9(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '0';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    
    //for STATO_ORDINE =3,5
    public static testMethod void MethodTwo_10(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        su.STATO_ORDINE = '3';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        su.STATO_ORDINE = '5';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    //for su.stato_ordine = '7'
    public static testMethod void MethodTwo_11(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c1.id;
        su.STATO_ORDINE = '0';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        su.ORARIO_APPUNTAMENTO = '10:00:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    
    //for STATO_ORDINE =7
    public static testMethod void MethodTwo_12(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Cessazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Realizzazione Impianto Completata';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.codice_ordine_of = c1.Id;
        su.CODICE_OPERATORE = 'VF';
        
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        su.MOTIVAZIONE = '1';
        su.CODICE_MOTIVAZIONE = '1';
        su.GPON_DI_ATTESTAZIONE = '1';
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        //contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        Case_AssetRecordType__c cs = new Case_AssetRecordType__c();
        cs.Name = 'Name';
        cs.assetDevName__c = 'P2P';
        cs.caseDevName__c = 'OF_SA_Cessazione';
        cs.beAttivazioneList__c= 'Contributo Attivazione ,Canone';
        cs.beCessazioneList__c = 'Contributo Cessazione ,Canone';
        insert cs;
        
        Verticali__c v = new Verticali__c();
        v.Name = 'Name';
        v.RecordTypesAssets__c = 'OF_OpenStream';
        insert v;
        
        su.STATO_ORDINE = '7';
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        
        Test.stopTest();
    }
    
    //for last else part
    public static testMethod void MethodTwo_13(){
        
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
        //c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_SA_Portale__C = false;
        c.OF_Bonifica_Locked_Row__c = true;
        c.EOF_codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Codice_Operatore_WS__c = 'VF';
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
         
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate su = new OF_WS_IN_OM_StatusUpdateNew.OM_Notify_StatusUpdate();
        su.CODICE_ORDINE_OLO = '02112016_37';
        su.CODICE_OPERATORE = 'VF';
        su.CODICE_ORDINE_OF = c.id;
        su.STATO_ORDINE = '4';
        su.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        su.ID_NOTIFICA = '1234567890';
        OF_SA_GE_UtilsNew.caseOriginale = c;
        su.CODICE_MOTIVAZIONE = '12';
        su.MOTIVAZIONE = '1234567890';
        su.FLAG_DESOSPENSIONE = 'SI';
        su.REMOTE_ID = '1234567890';
        su.NOME_CLIENTE = '1234567890';
        su.COGNOME_CLIENTE = '1234567890';
        su.RECAPITO_TELEFONICO_CLIENTE = '1234567890';
        su.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        Test.setMock(WebServiceMock.class, new OF_OM_EntryChecksNew_Mock1());
        OF_OM_EntryChecksNew.SyncChecksNotifyStatusUpdate_GPONP(su);
        Test.stopTest();
    }
    
  //for method 3 - SyncChecksNotifyReschedule
    public static testMethod void MethodThree_1(){
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        
        r.CODICE_OPERATORE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.CODICE_OPERATORE = 'Test';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.CODICE_OPERATORE = 'VF';
        r.CODICE_ORDINE_OLO = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.CODICE_OPERATORE = 'VF';
        r.CODICE_ORDINE_OLO = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodThree_2(){
        
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.CODICE_OPERATORE = 'VF';
        
        c1.OF_Blocked_Case__c = True;
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        c1.OF_Blocked_Case__c = False;
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        c1.Status = 'Acquisito';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1; 
        r.DATA_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodThree_3(){
        
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.CODICE_OPERATORE = 'VF';
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.DATA_PREVISTA_ATTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-12-05';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '1';
        r.MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodThree_4(){
        
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.CODICE_OPERATORE = 'VF';
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '1';
        r.MOTIVAZIONE = '1';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        Test.stopTest();
    }
    //for last else part
  /**  public static testMethod void MethodThree_5(){
        
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
        c.PO_SA_Portale__C = false;
        c.OF_Bonifica_Locked_Row__c = true;
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.CODICE_OPERATORE = 'VF';
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '1';
        r.MOTIVAZIONE = '1';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        c1.PO_SA_Portale__C = false;
        update c1;
        Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock2());
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule(r);
        
        Test.stopTest();
    } **/
    
    //for method 4 - SyncChecksNotifyReschedule_GPONP
    public static testMethod void MethodFour_1(){
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        
        r.CODICE_OPERATORE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.CODICE_OPERATORE = 'Test';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.CODICE_OPERATORE = 'VF';
        r.CODICE_ORDINE_OLO = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.CODICE_OPERATORE = 'VF';
        r.CODICE_ORDINE_OLO = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodFour_2(){
         
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.CODICE_OPERATORE = 'VF';
        
        c1.OF_Blocked_Case__c = True;
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        c1.OF_Blocked_Case__c = False;
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        c1.Status = 'Acquisito';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1; 
        r.DATA_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        Test.stopTest();
    }
    
    public static testMethod void MethodFour_3(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.CODICE_OPERATORE = 'VF';
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.DATA_PREVISTA_ATTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-12-05';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '1';
        r.MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFour_4(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Test.startTest();
        OF_OM_EntryChecksNew entrycheck = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.CODICE_OPERATORE = 'VF';
        
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1';
        r.NOME_CLIENTE = '1';
        r.COGNOME_CLIENTE = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1';
        r.ORARIO_APPUNTAMENTO = '10:00:20';
        r.CODICE_MOTIVAZIONE = '1';
        r.MOTIVAZIONE = '1';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        
        Test.stopTest();
    }
    

   public static testMethod void Method_SyncChecksNotifyReschedule_GPONP_Nineteen(){
        
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
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Order_Manager__c = true;
        insert c;
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule r = new OF_WS_IN_OM_RescheduleNew.OM_Notify_Reschedule();
        r.CODICE_OPERATORE = 'VF';
        r.CODICE_ORDINE_OLO = '02112016_37';
        r.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        r.ID_NOTIFICA = '1234567890';
        r.NOME_CLIENTE = '1234567890';
        r.COGNOME_CLIENTE = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_1 = '1234567890';
        r.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890';
        r.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        r.ORARIO_APPUNTAMENTO = '15:05:05';
        r.CODICE_MOTIVAZIONE = '12';
        r.MOTIVAZIONE = '1234567890';
        Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock3());
        OF_OM_EntryChecksNew.SyncChecksNotifyReschedule_GPONP(r);
        Test.stopTest();
    }
    
    //for method 5 - SyncChecksNotifyCompletionOrder
    public static testMethod void MethodFive_1(){
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        
        co.CODICE_OPERATORE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = '1234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = '12';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '1234567890';
        co.CODICE_ORDINE_OF = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '1234567890';
        co.CODICE_ORDINE_OF = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '1234567890';
        co.CODICE_ORDINE_OF = '1234567890';
        co.CODICE_ORDINE_OF = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodFive_2(){
         
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
         
        c1.OF_Blocked_Case__c = True;
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        c1.OF_Blocked_Case__c = False;
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        c1.Status = 'Accettato';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        co.DATA_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '10';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_3(){
         
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1234567890123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_4(){
         
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
   /** public static testMethod void MethodFive_5A(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        String EaiLogRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
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
        
        Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
        ccus.Name='test1';
        ccus.caseDevName__c='OF_SA_Attivazione';
        ccus.assetDevName__c='P2P';
        ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione,Contributo Consegna e istallazione';
        insert ccus;
        
        Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
        cer.name='testcer1';
        cer.ceName__c='VLAN1';
        cer.ceiDevName__c='CPE_Passivi';
        insert cer;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
      
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        contrattoServizio.OF_Contract__c=Contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id;
        insert contrattoServizio;
        
        Verticali__c v = new Verticali__c();
        v.Name = 'Name';
        v.RecordTypesAssets__c = 'OF_OpenStream';
        insert v;
       
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    } **/
      
    
    public static testMethod void MethodFive_5(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '123456789012345';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '9';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '9';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_6(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'CI';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);

        Test.stopTest();
    }
    //CEIst1 and SERVIZIO_AGGIUNTIVO
    public static testMethod void MethodFive_7(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_8(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '11';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodFive_9(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_10(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12345';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_11(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12';
        sai.MOTIVAZIONE_SERVIZIO = '';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_12(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '9';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12';
        sai.MOTIVAZIONE_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12345';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    //CEIst and Apparta
    public static testMethod void MethodFive_12a(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_13(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '12';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_14(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '1';
        cap.ID_APPARATO_CONSEGNATO = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_15(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '1';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_16(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '9';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_17(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.ID_APPARATO_CONSEGNATO = '12';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_18(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.ID_APPARATO_CONSEGNATO = '12';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '12345';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_19(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.ID_APPARATO_CONSEGNATO = '12';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '12';
        cap.MOTIVAZIONE_CONSEGNA = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodFive_20(){
         
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
        ordine.ContractId= contratto.id;
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
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15';
        co.DDT = '1';
        co.NOTE = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '9';
        cap.ID_APPARATO_CONSEGNATO = '12';
        cap.MOTIVAZIONE_CONSEGNA = '12';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '12345';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder(co);
        
        Test.stopTest();
    }
    
    //for method 6 - SyncChecksNotifyCompletionOrder_GPONP
    public static testMethod void MethodSix_1(){
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        
        co.CODICE_OPERATORE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = '1234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = '12';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '1234567890';
        co.CODICE_ORDINE_OF = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '1234567890';
        co.CODICE_ORDINE_OF = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OLO = '1234567890';
        co.CODICE_ORDINE_OF = '1234567890';
        co.CODICE_ORDINE_OF = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_2(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        c1.OF_Blocked_Case__c = True;
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        c1.OF_Blocked_Case__c = False;
        c1.Status = 'Realizzazione Impianto Completata';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        c1.Status = 'Accettato';
        update c1;
        OF_SA_GE_UtilsNew.caseOriginale = c1;
        co.DATA_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodSix_3(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '2';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.CODICE_MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.CODICE_MOTIVAZIONE = '12345';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.CODICE_MOTIVAZIONE = '�';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_4(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = ''; 
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '2';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_5(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '0';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = '1';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'CI';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '12345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodSix_6(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    //APPARATO and CEI(CPE)
    public static testMethod void MethodSix_7(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodSix_8(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '12';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '1';
        cap.ID_APPARATO_CONSEGNATO = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '1';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '4';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_9(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '1';
        cap.ID_APPARATO_CONSEGNATO = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '1';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '4';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_10(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '1';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '4';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_11(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '4';
        cap.ID_APPARATO_CONSEGNATO = '123456789012345678901234567890123456789012345678901234567890';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_12(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ID_APPARATO_CONSEGNATO = '1';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ID_APPARATO_CONSEGNATO = '1';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '12345';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_13(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ID_APPARATO_CONSEGNATO = '1';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '12345';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_14(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ID_APPARATO_CONSEGNATO = '1';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '1';
        cap.MOTIVAZIONE_CONSEGNA = '';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_15(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ID_APPARATO_CONSEGNATO = '1';
        cap.ESITO_CONSEGNA_APPARATO = '6';
        cap.MOTIVAZIONE_CONSEGNA = '';
        cap.CODICE_MOTIVAZIONE_CONSEGNA = '12345';
        co.APPARATO.add(cap);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    //STATO_ORDINE = 1
    public static testMethod void MethodSix_16(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '1';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        co.ID_SPLITTER_SECONDARIO = '123456789012345678901234567890123456789012345678901234567890';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    //CEIst1 and SERVIZIO_AGGIUNTIVO
    public static testMethod void MethodSix_17(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_18(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '123';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_19(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
    public static testMethod void MethodSix_20(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12345';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodSix_21(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12';
        sai.MOTIVAZIONE_SERVIZIO = '';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodSix_22(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst1(c1);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO sai = new OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO();
        co.SERVIZIO_AGGIUNTIVO = new List<OF_WS_IN_OM_CompletionOrderNew.SERVIZIO_AGGIUNTIVO>();
        
        sai.NOME_SERVIZIO = 'T';
        sai.ESITO_SERVIZIO = '8';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12';
        sai.MOTIVAZIONE_SERVIZIO = '1';
        sai.CODICE_MOTIVAZIONE_SERVIZIO = '12345';
        co.SERVIZIO_AGGIUNTIVO.add(sai);
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
     public static testMethod void MethodSix_23(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'Accettato';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '02112016_37';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c1.id;
         
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        //co.STATO_ORDINE = '0';
        co.ID_RISORSA = '1';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2018-11-15'; 
        co.GPON_DI_ATTESTAZIONE = '1';
        co.SERIALE_BORCHIA = '1';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '1';
        co.STATO_ORDINE = '12';
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
	
     public static testMethod void MethodSix_24(){
        
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
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '20190402_2234';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(+70);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.EOF_Id_Risorsa__c='IDR1234';
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
        c.Previous_Status__c = 'Aperto';
        c.PO_Comune__c = 'Test';
        c.EOF_Comune_WS__c = 'Test';
        c.EOF_Istat_Comune__c = 'Test';
        c.EOF_Istat_Provincia__c = 'Test';
        c.EOF_Provincia_WS__c = 'Test';
        c.OF_Blocked_Case__c = False;
        insert c;
        
        Case c1 = [Select EOF_Account_OLO__c,Subject,EOF_Codice_Ordine_OLO__c,EOF_Data_Prevista_Attivazione__c,EOF_Orario_Appuntamento__c,Status,EOF_Fase__c,Type,
                          EOF_Tipologia_Servizio__c,EOF_Codice_Operatore_WS__c,EOF_SLA_Premium_Assurance__c,AssetId,OwnerId,RecordTypeId,EOF_Id_Notifica__c,Origin,Priority,
                          EOF_GPON_Vincolante__c,OF_Order__c,OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c,PO_SA_Portale__C,OF_Bonifica_Locked_Row__c,Previous_Status__c,PO_Comune__c,
                          EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Provincia_WS__c,OF_Blocked_Case__c
                          From Case Where Subject = 'Richiesta Attivazione' FOR UPDATE];
        
        CEIst(c1);
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
	//	Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_OM_AsyncChecksNew.OM_AsyncCompletionOrderNew(cList[0], co);
        
        Test.startTest();
        OF_OM_EntryChecksNew entryC = new OF_OM_EntryChecksNew();
         
        OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder co = new OF_WS_IN_OM_CompletionOrderNew.OM_Notify_CompletionOrder();
        co.CODICE_ORDINE_OLO = '20190402_2234';
        co.CODICE_OPERATORE = 'VF';
        co.CODICE_ORDINE_OF = c.id;
        
        co.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.ID_NOTIFICA = '2017-06-01T18:30:15+01:00';
        co.CODICE_MOTIVAZIONE = '1';
        co.MOTIVAZIONE = '1';
        co.STATO_ORDINE = '0';
        co.ID_RISORSA = 'IDR1234';
        co.SCALA_PALAZZINA = '1';
        co.DATA_ESPLETAMENTO_ORDINE = '2019-06-25'; 
        co.GPON_DI_ATTESTAZIONE = 'PG_01';
        co.SERIALE_BORCHIA = '9981';
        co.FLAG_PAGAMENTO = '0';
        co.NUMERO_OPERATORE = '1';
        co.BRETELLA_OTTICA = 'Y';
        co.ESTENSIONE_IMPIANTO_EFFETTUATA = 'SI';
        co.ESTENSIONE_IMPIANTO = '1';
        co.METRI_TOT = '1';
        co.ID_SPLITTER_SECONDARIO = '1';
        co.POSIZIONE_SPLITTER_SECONDARIO = '1';
        co.PARAMETRI_TRASMISSIVI_OTTICI = '1';
        co.ID_SPLITTER_SECONDARIO = '123456789012345678901234567890123456789012345678901234567890';
        
        OF_WS_IN_OM_CompletionOrderNew.APPARATO cap = new OF_WS_IN_OM_CompletionOrderNew.APPARATO();
        co.APPARATO = new List<OF_WS_IN_OM_CompletionOrderNew.APPARATO>();
        
        cap.TIPOLOGIA_APPARATO = 'T';
        cap.ESITO_CONSEGNA_APPARATO = '0';
        cap.ID_APPARATO_CONSEGNATO = '12';
        cap.CODICE_MOTIVAZIONE_CONSEGNA='T';
        cap.MOTIVAZIONE_CONSEGNA='88'; 
         
        co.APPARATO.add(cap);

       
       
        
      
        OF_OM_EntryChecksNew.SyncChecksNotifyCompletionOrder_GPONP(co);
        
        Test.stopTest();
    }
    
}
@isTest
public class OF_PP_OLO_EntryChecksKIT_Test {

    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        }
    
    public static OF_CatalogoCommerciale__c Catalogo_Creation(){
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        return catalogo;
    }
    
    public static Account accountCreation(){

        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Phone = '081861784512';
        acc.EOF_Phone_2__c = '081861784512';
        acc.EOF_Provincia__c = 'Napoli';
        acc.EOF_Comune__c = 'Napoli';
        acc.EOF_Indirizzo__c = 'Piazza Plebiscito';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '71';        
        insert acc;

        return acc;
    }
    
    public static Account tiscaliAccountCreation()
    {
        Account a = new Account();
        a.name = 'Tiscali';
        a.EOF_Codice_Operatore__c = 'TIS';
        insert a;
        return a;
    }
    
    public static Asset assetCreation(Account acc){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Preprovisioning').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'Test Asset PP';
        asset_1.Status = 'Attivo';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.AccountId = acc.id;
        insert asset_1;
        return asset_1;
    }
    
    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
        public static OF_Servizio__c Servizio_Creation_PP(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'PREPROVISIONING';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
    public static Contract createContract(Account acc)
    {
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        return contratto;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract con, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = con.id;
        cs.OF_Servizio__c = serv.id;
        insert cs;
        return cs;
    }
    
    public static OF_CommercialElement__c CE_Kit_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO KIT';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    }  
    
    public static OF_CommercialElement__c CE_Vlan_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO VLAN';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    } 
    
    public static OF_Servizio__c ServizioPP_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'PREPROVISIONING';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
    public static Case caseVlanCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning VLAN').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.OF_SA_Profilo__c = 'AG_11_36';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        c.Codice_ordine_so__c = 'TIS_123450';
        c.Codice_Ordine_sfdc__c = 'TIS_123451';
        insert c;
        return c;
    }
    
    public static EOF_EAI_Service_Log__c vlanLogCreation(Case c)
    {
        EOF_EAI_Service_Log__c vlanLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - PP - VLAN').getRecordTypeId();
        vlanLog.recordTypeId = rtId;
        vlanLog.PO_PP_POP_raccolta__c = 'pop_001';
        vlanLog.PO_PP_cos_type__c = 'MultiCOS';
        vlanLog.PO_PP_cos_class__c = '0 - 1 - 5';
        vlanLog.PO_PP_MultiCos_Class__c = '0 - 1 - 5';
        vlanLog.SVLAN__c = 'AX1';
        vlanLog.PO_PP_cos_remarking__c = 'None';
        vlanLog.PO_PP_dhcp_Option82__c = 'None';
        vlanLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
        vlanLog.Caso__c = c.id;
        insert vlanLog;
        return vlanLog;
    }
    
    public static testmethod void EntryChecksKITMethod() {
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
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
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        OF_PP_OLO_EntryChecksKIT entryckit = new OF_PP_OLO_EntryChecksKIT(); 
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest statusreq = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        statusreq.CODICE_ORDINE_OF = 'Test';
        statusreq.NOME_KIT = 'Test';
        statusreq.MODELLO_SERVIZIO = 'Test';
        statusreq.IDENTIFICATIVO_DEL_POP = 'Test';
        statusreq.BANDA = 'Test';
        statusreq.ODF = 'Test';
        statusreq.TRAFFICO = 'Test';
        statusreq.SERVIZIFINALI = 'Test';
        statusreq.DATA_NOTIFICA = string.valueof(datetime.now());
        statusreq.DATA_PREVISTA_ATTIVAZIONE = string.valueof(datetime.now());
        statusreq.PROFILO = 'Test';
        statusreq.ID_NOTIFICA = 'Test';
        statusreq.CODICE_OPERATORE = 'VF';
        statusreq.CODICE_ORDINE_OLO = 'Test';
        statusreq.NOTE = 'Test';
        statusreq.AZIONE = '0';
        statusreq.CODICE_MOTIVAZIONE = 'A04';
        statusreq.MOTIVAZIONE = 'Test';
        statusreq.ORARIO_APPUNTAMENTO = 'Test';
        statusreq.CODICE_ORDINE_OF = c.Id;
        
        
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest activereq = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
 
        //activereq .CODICE_ORDINE_OF = 'Test';
        activereq .NOME_KIT = 'Test';
        activereq .MODELLO_SERVIZIO = 'Test';
        activereq .IDENTIFICATIVO_DEL_POP = 'Test';
        activereq .BANDA = 'Test';
        activereq .ODF = 'Test';
        //activereq .ESITO = '0';
        activereq .TRAFFICO = 'Test';
        activereq .SERVIZIFINALI = 'Test';
        activereq .DATA_NOTIFICA = string.valueof(datetime.now());
        activereq .DATA_PREVISTA_ATTIVAZIONE = string.valueof(datetime.now());
        activereq .PROFILO = 'Test';
        activereq .ID_NOTIFICA = 'Test';
        activereq .CODICE_OPERATORE = 'VF';
        activereq .CODICE_ORDINE_OLO = 'Test';
        activereq .NOTE = 'Test';
        activereq .STATO_ORDINE='11';
        activereq .INTERFACCIA = 'Test';
        
       // activereq.CODICE_MOTIVAZIONE= 'A041';
       // activereq .MOTIVAZIONE = 'Test';
        //activereq .ORARIO_APPUNTAMENTO = 'Test';
        activereq .CODICE_ORDINE_OF = c.Id;
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new EntryCheckMock ());
        OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksStatusUpdate(statusreq,eaiLog1);
        OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdate(statusreq);
        OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksActivation(activereq,eaiLog1);
        Test.stopTest();
        
    }
    
    //method line number 5 and 26 esito == 0
    public static testmethod void EntryChecksKITMethod1() {
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
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
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        OF_PP_OLO_EntryChecksKIT entryckit = new OF_PP_OLO_EntryChecksKIT(); 
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest statusreq = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        statusreq.CODICE_ORDINE_OF = 'Test';
        statusreq.NOME_KIT = 'Test';
        statusreq.MODELLO_SERVIZIO = 'Test';
        statusreq.IDENTIFICATIVO_DEL_POP = 'Test';
        statusreq.BANDA = 'Test';
        statusreq.ODF = 'Test';
        statusreq.TRAFFICO = 'Test';
        statusreq.SERVIZIFINALI = 'Test';
        statusreq.DATA_NOTIFICA = string.valueof(datetime.now());
        statusreq.DATA_PREVISTA_ATTIVAZIONE = string.valueof(datetime.now());
        statusreq.PROFILO = 'Test';
        statusreq.ID_NOTIFICA = 'Test';
        statusreq.CODICE_OPERATORE = 'VF';
        statusreq.CODICE_ORDINE_OLO = 'Test';
        statusreq.NOTE = 'Test';
        statusreq.AZIONE = '1';
       // statusreq.CODICE_MOTIVAZIONE = 'Test';
        statusreq.MOTIVAZIONE = 'Test';
        statusreq.ORARIO_APPUNTAMENTO = 'Test';
        statusreq.CODICE_ORDINE_OF = c.Id;
        Test.startTest();
        Test.setMock(WebServiceMock.class, new EntryCheckMock ());
        OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksStatusUpdate(statusreq,eaiLog1);
        OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdate(statusreq);
        Test.stopTest();
        
    }
   public static testmethod void EntryChecksKITMethod2() {
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
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
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        OF_PP_OLO_EntryChecksKIT entryckit = new OF_PP_OLO_EntryChecksKIT(); 
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest statusreq = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        statusreq.CODICE_ORDINE_OF = 'Test';
        statusreq.NOME_KIT = 'Test';
        statusreq.MODELLO_SERVIZIO = 'Test';
        statusreq.IDENTIFICATIVO_DEL_POP = 'Test';
        statusreq.BANDA = 'Test';
        statusreq.ODF = 'Test';
        statusreq.TRAFFICO = 'Test';
        statusreq.SERVIZIFINALI = 'Test';
        statusreq.DATA_NOTIFICA = string.valueof(datetime.now());
        statusreq.DATA_PREVISTA_ATTIVAZIONE = string.valueof(datetime.now());
        statusreq.PROFILO = 'Test';
        statusreq.ID_NOTIFICA = 'Test';
        statusreq.CODICE_OPERATORE = 'VF';
        statusreq.CODICE_ORDINE_OLO = 'Test';
        statusreq.NOTE = 'Test';
        statusreq.AZIONE = '0';
       // statusreq.CODICE_MOTIVAZIONE = 'Test';
        statusreq.MOTIVAZIONE = 'Test';
        statusreq.ORARIO_APPUNTAMENTO = 'Test';
        statusreq.CODICE_ORDINE_OF = c.Id;
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new EntryCheckMock1 ());
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest olo = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksStatusUpdate(olo,eaiLog1);
        //OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdate(statusreq);
        Test.stopTest();
    }
   
    //method line number 373 and 536
    public static testmethod void EntryChecksKITMethod3() {
       
        OF_PP_OLO_EntryChecksKIT entryckit = new OF_PP_OLO_EntryChecksKIT();
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse   activeres = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest activereq = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        activereq.CODICE_OPERATORE = 'Test';
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
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
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
     OF_PP_OLO_EntryChecksKIT.SyncChecksActivation(activereq);
    //OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksActivation(activereq,eaiLog1);
    }
    
    //method line number 563 and 593
    public static testmethod void EntryChecksKITMethod4() {
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Chiuso';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_codice_Ordine_OLO__c = 'Test';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = 'risorsa';
        // parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.status = 'Acquisito';
        parentCase.OF_Response_Da_OLO__c = 'NACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        insert parentCase;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'TIS';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        OF_PP_OLO_EntryChecksKIT entryckit = new OF_PP_OLO_EntryChecksKIT();
        OF_PP_WS_IN_OLO_Activation.VLAN_PP actvlan = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
        OF_PP_WS_IN_OLO_Activation.VLAN_PP actvlan1 = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
        OF_PP_WS_IN_OLO_Activation.VLAN_PP actvlan2 = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
        OF_PP_WS_IN_OLO_Activation.VLAN_PP actvlan3 = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
        OF_PP_WS_IN_OLO_Activation.VLAN_PP actvlan4 = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
    
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        insert service;
            
        OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksActivation_SVLAN(actvlan,service);
            
        actvlan.CODICE_OPERATORE = 'Test';   
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan);
            
        actvlan.CODICE_OPERATORE = 'VF';
        actvlan.DATA_NOTIFICA = '';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan);
            
        actvlan.DATA_NOTIFICA = string.valueof(datetime.now());
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan);
            
        actvlan.STATO_ORDINE = '9';
        actvlan.DATA_NOTIFICA = String.ValueOf(System.today());
        actvlan.ID_NOTIFICA = '';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan);
        OF_PP_GE_Utils.checkRTMap = false;
        
        actvlan1.CODICE_OPERATORE = 'VF';
        actvlan1.STATO_ORDINE = '10';
        actvlan1.DATA_NOTIFICA = '2018-10-10T11:30:30+01:00';
        //actvlan.ID_NOTIFICA = 'ID_N001';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan1);
        //OF_PP_GE_Utils.checkRTMap = false;
        
        actvlan2.CODICE_OPERATORE = 'VF';
        actvlan2.STATO_ORDINE = '10';
        actvlan2.DATA_NOTIFICA = '2018-10-10T11:30:30+01:00';
        actvlan2.ID_NOTIFICA = '�';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan2);
        
        actvlan3.CODICE_OPERATORE = 'VF';
        actvlan3.STATO_ORDINE = '10';
        actvlan3.DATA_NOTIFICA = '2018-10-10T11:30:30+01:00';
        actvlan3.ID_NOTIFICA = 'ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001ID_N001';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan3);
        
        /*
        actvlan4.CODICE_OPERATORE = 'VF';
        actvlan4.STATO_ORDINE = '10';
        actvlan4.DATA_NOTIFICA = '2018-10-10T11:30:30+01:00';
        actvlan4.ID_NOTIFICA = 'ID_N_001';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivationSVLAN(actvlan4);
        */
        
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse  activeres = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest activereq = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        activereq.CODICE_OPERATORE = 'Test';
        
        // OF_PP_WS_IN_OLO_Activation.VLAN_PP actvlan = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        // String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
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
        
        OF_PP_GE_Utils.caseOriginale = c;
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        
        //-----insert EAI Service Log------
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        Test.startTest();
        Test.setMock(WebServiceMock.class, new EntryCheckMock());
        OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksActivation(activereq,eaiLog1);
       
        Test.stopTest();
    } 
    
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
    
        for(RecordType rt: rtypes)
            RecordType.put(rt.Name,rt.Id);
                    
        return RecordType;
    }
    
    static testMethod void testOLO_PreProv_StatusUpdate(){
        
        Profile prf = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt11', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = prf.Id,UserRoleID = Usr.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'PFProduction@test.com',isactive = true);
        insert thisUser;
        
        System.RunAs(thisUser)
        {
            List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account')  and isActive=true];
            
            Map<String,String> RecordTyp = new Map<String,String>{};
        
            for(RecordType rt: rtypes)
                RecordTyp.put(rt.Name,rt.Id);
           
            String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
            // This code runs as the system user
            //Profile p = [SELECT Id FROM Profile WHERE Name='Partner Community Super User'];
            //User u = [SELECT Id FROM user WHERE Name='Mario Rossi' and Profile.name='Partner Community Super User'];
            RecordType rt = [select id,Name from RecordType where SobjectType='case' and DeveloperName  ='OF_PP_PreProvisioning_Vlan' Limit 1];
            Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true); 
            //System.runAs(u) {
                  // The following code runs as user 'u'
                  System.debug('Current User: ' + UserInfo.getUserName());
                  System.debug('Current Profile: ' + UserInfo.getProfileId());
             
          
            //Map<String,String> RecordTypeMap = RecordType();
             
            /**Account**/
            Account acc= new Account();       
            acc.Name = 'Tiscali';
            acc.EOF_Codice_Operatore__c = 'TIS';
            acc.Type = 'OLO';
            acc.Industry = 'Telecommunications';
            acc.RecordTYpeId = RecordTyp.get('OLO');
            insert acc;
            /**End Account**/
           
            /**Case**/
            String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
            List<Case> cseList = new List<Case>();
            Case c = new Case();
            c.EOF_Account_OLO__c = acc.Id;
            c.Subject = 'Richiesta di attivazione';
            c.EOF_Codice_Ordine_OLO__c = '02112016_37';
            c.EOF_Data_Prevista_Attivazione__c = system.today();
            c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c.Status = 'Accettato';
            c.EOF_Fase__c = 'In Verifica BO';
            c.Type = '1';
            // c.status = 'Espletamento KO';
            c.EOF_Tipologia_Servizio__c = 'test1';
            c.EOF_Codice_Operatore_WS__c = 'TIS';
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
            c.OF_Bonifica_Locked_Row__c = True;
            cseList.add(c);
            insert c;
        
            OF_PP_GE_Utils.caseOriginale = c;
            
            // Inserting test Account
            Account a = new Account();
            a.name = 'Tiscali';
            a.EOF_Codice_Operatore__c = 'TIS';
            insert a;
            
            // Inserting test contact
            contact contatto = new contact();
            contatto.FirstName = 'Vlado';
            contatto.lastname = 'Test';
            contatto.Email = 'email@abc.com';
            contatto.PO_Contatto_telefonico__c ='1234';
            contatto.PO_N_Licenza__c = 'test';
            contatto.PO_Struttura_di_appartenenza__c = 'test';
            contatto.AccountId = a.Id;
            contatto.PO_Super_User__c = true;
            insert contatto;
            
            Profile prof = [SELECT Id 
                            FROM Profile 
                            WHERE Name='Partner Community Super User'];
            
            // Inserting test user 
            User portal_user = new User();
            portal_user.Firstname = 'John';
            portal_user.LastName = 'Smith';
            portal_user.email = 'msmithtest25@company.com';
            portal_user.Alias = 'alias12';
            portal_user.CommunityNickname = 'commnick';
            portal_user.EmailEncodingKey = 'UTF-8';
            portal_user.Username = 'msmithtest25@company.com';
            portal_user.TimeZoneSidKey = 'America/Denver';
            portal_user.LocaleSidKey = 'en_US';
            portal_user.EmailEncodingKey = 'UTF-8';
            portal_user.LanguageLocaleKey = 'en_US';
            portal_user.ProfileId = prof.Id;
            portal_user.ContactId = contatto.id;
            insert portal_user;
            
            //Updating  Test contact owner with Test user 
            contatto.ownerid = portal_user.id;
            update contatto;
            
            Account acc_test = tiscaliAccountCreation();
            Asset asset_test = assetCreation(acc_test);
            Contract contratto = createContract(acc_test);
            OF_CatalogoCommerciale__c cat = Catalogo_Creation();
            OF_Servizio__c servOpenStream = Servizio_Creation(cat);
            
            OF_ContrattoServizio__c cs = createContrattoServizio(contratto,servOpenStream);
            
            OF_Servizio__c servPP = ServizioPP_Creation(cat);
            OF_ContrattoServizio__c cs2 = createContrattoServizio(contratto,servPP);
            OF_CommercialElement__c ce_kit = CE_Kit_Creation(servPP);
            OF_CommercialElement__c ce_vlan = CE_Vlan_Creation(servPP);
            
            //Pricebook
            pricebook2 prb = new pricebook2(
            name = 'PREPROV_001_CAN_KIT',
            PO_Commercial_element__c = ce_kit.id,
            OF_Master__c = true
            //RecordTypeId = RecordTypes.get('Pricebook')
            );
            insert prb;
            
            //Product
            product2 pr = new product2(
            name = 'TestProd'
            );
            insert pr;
            
            //Pricebook standard
            ID id = Test.getStandardPricebookId();
            PriceBook2 pb2 = new PriceBook2();
            pb2.Id=id;
            update pb2;
            
            //PriceBookEntry Standard
            pricebookentry pbe = new pricebookentry(
            UnitPrice = -9999,
            IsActive = true,
            Product2ID = pr.id,
            Pricebook2ID = pb2.id  //pricebook standard
            );
            insert pbe;
            
            //PriceBookEntry
            PriceBookEntry prE = new PriceBookEntry(
            Product2Id = pr.Id,           
            Pricebook2Id = prb.Id,
            OF_Asset__c = asset_test.id,
            UnitPrice = -9.999
            );
            insert prE;
            
            Case vlanCase = caseVlanCreation(acc);
            System.debug('*****vlanCase*****:'+vlanCase);
            EOF_EAI_Service_Log__c logVlan = vlanLogCreation(vlanCase);
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
    
            reqVlan.CODICE_OPERATORE = 'TIS';
            reqVlan.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan.STATO_ORDINE='11';
            reqVlan.SERVICE_VLAN_ID='1234';
            reqVlan.USER_VLAN='835';
            reqVlan.NOTE = 'Test';
            //reqVlan.COS = 'Test';
            reqVlan.CODICE_MOTIVAZIONE = '01'; 
            reqVlan.MOTIVAZIONE = 'Sbagliato tutto';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan2 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan2.CODICE_OPERATORE = '';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan3 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan3.CODICE_OPERATORE = 'TIS';
            reqVlan3.CODICE_ORDINE_SFDC = '';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan4 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan4.CODICE_OPERATORE = 'TIS';
            reqVlan4.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan4.CODICE_ORDINE_SO = '';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan5 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan5.CODICE_OPERATORE = 'TIS';
            reqVlan5.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan5.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan5.DATA_NOTIFICA = '';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan6 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan6.CODICE_OPERATORE = 'TIS';
            reqVlan6.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan6.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan6.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan6.ID_NOTIFICA = '';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan7 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan7.CODICE_OPERATORE = 'TIS';
            reqVlan7.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan7.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan7.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan7.ID_NOTIFICA = 'ID_N001';
            reqVlan7.STATO_ORDINE = '';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan8 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan8.CODICE_OPERATORE = 'TIS';
            reqVlan8.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan8.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan8.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan8.ID_NOTIFICA = 'ID_N001';
            reqVlan8.STATO_ORDINE = '7';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan9 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan9.CODICE_OPERATORE = 'TIS';
            reqVlan9.CODICE_ORDINE_SFDC = 'test';
            reqVlan9.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan9.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan9.ID_NOTIFICA = 'ID_N001';
            reqVlan9.STATO_ORDINE = '11';
            reqVlan9.CODICE_MOTIVAZIONE = ''; 
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan10 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan10.CODICE_OPERATORE = '';
            reqVlan10.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan10.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan10.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan10.ID_NOTIFICA = 'ID_N001';
            reqVlan10.STATO_ORDINE = '10';
            reqVlan10.CODICE_MOTIVAZIONE = ''; 
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan11 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan11.CODICE_OPERATORE = 'TIS';
            reqVlan11.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan11.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan11.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan11.ID_NOTIFICA = 'ID_N001';
            reqVlan11.STATO_ORDINE = '10';
            reqVlan11.MOTIVAZIONE = '';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan12 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan12.CODICE_OPERATORE = 'TIS';
            reqVlan12.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan12.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan12.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan12.ID_NOTIFICA = 'ID_N001';
            reqVlan12.STATO_ORDINE = '11';
            reqVlan12.MOTIVAZIONE = 'Errore';
            reqVlan12.CODICE_MOTIVAZIONE = '00001';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan13 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan13.CODICE_OPERATORE = 'TIS';
            reqVlan13.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan13.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan13.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan13.ID_NOTIFICA = 'ID_N001';
            reqVlan13.STATO_ORDINE = '11';
            reqVlan13.MOTIVAZIONE = 'Lorem Ipsum è un testo segnaposto utilizzato nel settore della tipografia e della stampa. Lorem Ipsum è considerato il testo segnaposto standard sin dal sedicesimo secolo, quando un anonimo tipografo prese una cassetta di caratteri e li assemblò per preparare un testo campione. È sopravvissuto non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.';
            reqVlan13.CODICE_MOTIVAZIONE = '001';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan14 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan14.CODICE_OPERATORE = 'TIS';
            reqVlan14.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan14.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan14.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan14.ID_NOTIFICA = 'ID_N001';
            reqVlan14.STATO_ORDINE = '10';
            reqVlan14.NOTE = 'Lorem Ipsum è un testo segnaposto utilizzato nel settore della tipografia e della stampa. Lorem Ipsum è considerato il testo segnaposto standard sin dal sedicesimo secolo, quando un anonimo tipografo prese una cassetta di caratteri e li assemblò per preparare un testo campione. È sopravvissuto non solo a più di cinque secoli, ma anche al passaggio alla videoimpaginazione, pervenendoci sostanzialmente inalterato. Fu reso popolare, negli anni ’60, con la diffusione dei fogli di caratteri trasferibili “Letraset”, che contenevano passaggi del Lorem Ipsum, e più recentemente da software di impaginazione come Aldus PageMaker, che includeva versioni del Lorem Ipsum.';

            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan15 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan15.CODICE_OPERATORE = 'TIS';
            reqVlan15.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan15.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan15.ID_NOTIFICA = 'ID_N001';
            reqVlan15.STATO_ORDINE = '10';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan16 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan16.CODICE_OPERATORE = 'TIS';
            reqVlan16.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan16.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan16.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan16.ID_NOTIFICA = 'ID_N001';
            reqVlan16.STATO_ORDINE = '10';
            reqVlan16.USER_VLAN = '8370';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan17 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan17.CODICE_OPERATORE = 'TIS';
            reqVlan17.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan17.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan17.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan17.ID_NOTIFICA = 'ID_N001';
            reqVlan17.STATO_ORDINE = '10';
            reqVlan17.SERVICE_VLAN_ID = '12345678';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan18 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan18.CODICE_OPERATORE = 'TIS';
            reqVlan18.CODICE_ORDINE_SFDC = 'test';
            reqVlan18.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan18.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan18.ID_NOTIFICA = 'ID_N001';
            reqVlan18.STATO_ORDINE = '10';
            reqVlan18.USER_VLAN = '123';
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN reqVlan19 = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();
            reqVlan19.CODICE_OPERATORE = 'TIS';
            reqVlan19.CODICE_ORDINE_SFDC = vlanCase.Codice_Ordine_sfdc__c;
            reqVlan19.CODICE_ORDINE_SO = vlanCase.Codice_Ordine_SO__c;
            reqVlan19.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            reqVlan19.ID_NOTIFICA = 'ID_N001';
            reqVlan19.STATO_ORDINE = '11';
            reqVlan19.MOTIVAZIONE = 'Errore';
            reqVlan19.CODICE_MOTIVAZIONE = '01';

            Test.startTest();
        
            Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
            
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan2);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan3);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan4);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan5);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan6);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan7);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan8);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan9);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan10);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan11);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan12);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan13);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan14);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan15);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan16);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan17);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan18);
            OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdateVLAN(reqVlan19);
            
            Test.stopTest(); 
        }
    }
    
   public static testMethod void TestMe(){
    
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        con.Email = 'abcd@gmail.com';
        insert con;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'TIS';
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
        c.OF_Bonifica_Locked_Row__c = True;
        insert c;
        OF_PP_GE_Utils.caseOriginale = c;
       
        Id EofRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - ACK').getRecordTypeId(); 
        System.debug('@@@EofRecordType'+EofRecordType);
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        eof.RecordTypeId = EofRecordType ;
        eof.EOF_Codice_Ordine_OLo__C = 'Test';
        eof.OF_SA_Direzione_Flusso__c='SF-OM';
        eof.EOF_Codice_Operatore__c = 'TIS';
        eof.EOF_Data_Notifica__c = dateTime.now();
        eof.EOF_Stato_Richiesta__c = 'OK';
        eof.EOF_ID_Notifica__c = 'test_01';
        insert eof;
         
        List<EOF_EAI_Service_Log__c>  eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = EofRecordType ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.EOF_Codice_Operatore__c = 'TIS';
        slfiberReq.EOF_Data_Notifica__c = dateTime.now();
        slfiberReq.EOF_Stato_Richiesta__c = 'OK';
        slfiberReq.EOF_ID_Notifica__c = 'test_01';
        slFiberReq.OF_SA_Cpe_Log__c =eof.id;
        eofList.add(slFiberReq);
        insert eofList;
        OF_PP_GE_Utils.slSFOM = slFiberReq;
        map<String,Id> RTMap = new  map<String,Id>();
        rtMap.put('OF_PP_PreProvisioning_KITConsegna',CaseRecordTypeId);
        OF_PP_GE_Utils.rtMap = rtMap;
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new EntryCheckMock());
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        act.CODICE_OPERATORE = '';
        //act.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivation(act);
        
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act1 = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        act1.CODICE_OPERATORE = 'TIS';
        act1.DATA_NOTIFICA = '';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivation(act1);
        
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act2 = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        act2.CODICE_OPERATORE = 'TIS';
        act2.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        act2.ID_NOTIFICA = '';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivation(act2);
        
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act3 = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        act3.CODICE_OPERATORE = 'TIS';
        act3.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        act3.ID_NOTIFICA = 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivation(act3);
        
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act4 = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        act4.CODICE_OPERATORE = 'TIS';
        act4.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        act4.ID_NOTIFICA = 'SSSSS';
        act4.ID_NOTIFICA = '?';
        OF_PP_OLO_EntryChecksKIT.SyncChecksActivation(act4);
        Test.stopTest();
    }
    
    public static testMethod void TestMe1(){
        case c = new case();
        insert c;
        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest res = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        res.CODICE_OPERATORE = 'TIS';
        OF_PP_OLO_EntryChecksKIT.SyncChecksStatusUpdate(res);
    }
}
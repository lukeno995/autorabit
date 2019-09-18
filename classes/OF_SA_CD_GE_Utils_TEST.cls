@istest
public class OF_SA_CD_GE_Utils_TEST {
    
    public static Verticali__c createVerticaliCustomSetting() {

        Verticali__c cs = new Verticali__c();
        cs.Name='test';
        cs.delayAlgoritmo__c = 1;
        cs.delayBonifica__c = 240;
        cs.Email__c = 'test@test.org';
        cs.Email_CC__c = 'test@test.org';
        cs.Email_from__c = 'Contattaci OpenFiber';
        cs.emailSubject__c = 'subj';
        cs.giorniTolleranza__c = -2;
        cs.limitBatch__c = 10;
        cs.TextBody__c = 'text';
        //cs.RecordTypesAssets__c = 'OF_OpenStream';
        
        insert cs;
        return cs;
    } 
    
    @testsetup
    static void createData()
    {
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
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
        
        
        //-------Case Creation-------------A
        Case c1 = new Case();
        c1.EOF_Account_OLO__c = accOLO.Id;
        c1.Subject = 'Richiesta di attivazione';
        c1.EOF_Codice_Ordine_OLO__c = 'TEST_CHO_01';
        c1.EOF_Data_Prevista_Attivazione__c = system.today();
        c1.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c1.Status = 'Acquisito';
        c1.EOF_Fase__c = 'In Verifica BO';
        c1.Type = '1';
        c1.EOF_Tipologia_Servizio__c = 'test cho';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.EOF_SLA_Premium_Assurance__c ='Y';
        c1.Account = acc;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c1.EOF_Numero_Civico_WS__c = '7';
        c1.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c1.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c1.EOF_Recapito_Test_Linea__c = '111';
        c1.EOF_Tipologia_Apparato__c = 'test';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.EOF_Id_Notifica__c = 'test_01';
        c1.Origin = 'Web';
        c1.Priority = 'Medium';
        c1.EOF_GPON_Vincolante__c = 'Y';
        insert c1;
        
        
        Case c2 = new Case();
        c2.EOF_Account_OLO__c = accOLO.Id;
        c2.Subject = 'Richiesta di attivazione';
        c2.EOF_Codice_Ordine_OLO__c = 'TEST_CHO_02';
        c2.EOF_Data_Prevista_Attivazione__c = system.today();
        c2.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c2.Status = 'Acquisito';
        c2.EOF_Fase__c = 'In Verifica BO';
        c2.Type = '1';
        c2.EOF_Tipologia_Servizio__c = 'test cho';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.EOF_SLA_Premium_Assurance__c ='Y';
        c1.Account = acc;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c2.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c2.EOF_Numero_Civico_WS__c = '7';
        c2.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c2.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c2.EOF_Recapito_Test_Linea__c = '111';
        c2.EOF_Tipologia_Apparato__c = 'test';
        c2.OwnerId = userInfo.getUserId();
        c2.RecordTypeId = CaseRecordTypeId;
        c2.EOF_Id_Notifica__c = 'test_01';
        c2.Origin = 'Web';
        c2.Priority = 'Medium';
        c2.EOF_GPON_Vincolante__c = 'Y';
        insert c2;
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        
        //-----insert EAI Service Log------
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
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
        
        list<EOF_EAI_Service_Log__c> vlstslog = new list<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c elog = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                       from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239' limit 1];
        
        EOF_EAI_Service_Log__c elog11 = new  EOF_EAI_Service_Log__c();
        elog11.Caso__c = elog.Caso__c;
        elog11.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog11.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elog11.EOF_Response__c = elog.EOF_Response__c;
        elog11.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - CeD - FiberRequest').getRecordTypeId();
        elog11.EOF_Stato_Richiesta__c='Inserita Portale';
        insert elog11;
        
        EOF_EAI_Service_Log__c elog2 = new  EOF_EAI_Service_Log__c();
        elog2.Caso__c = elog.Caso__c;
        elog2.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog2.EOF_Codice_Ordine_OLO__c = elog11.EOF_Codice_Ordine_OLO__c;
        elog2.EOF_Response__c = elog.EOF_Response__c;
        elog2.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - CeD - FiberRequest').getRecordTypeId();
        insert elog2;
        
        EOF_EAI_Service_Log__c elog3 = new  EOF_EAI_Service_Log__c();
        elog3.Caso__c = elog.Caso__c;
        elog3.EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06';
        elog3.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog3.EOF_Codice_Ordine_OLO__c = elog2.EOF_Codice_Ordine_OLO__c;
        elog3.EOF_Response__c = elog.EOF_Response__c;
        elog3.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        insert elog3;
        
        EOF_EAI_Service_Log__c elog4 = new  EOF_EAI_Service_Log__c();
        elog4.Caso__c = elog.Caso__c;
        elog4.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog4.EOF_Codice_Ordine_OLO__c = elog3.EOF_Codice_Ordine_OLO__c;
        elog4.EOF_Response__c = elog.EOF_Response__c;
        elog4.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        insert elog4;
                
        EOF_EAI_Service_Log__c elogx5 = new  EOF_EAI_Service_Log__c();
        elogx5.Caso__c = elog.Caso__c;
        elogx5.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elogx5.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elogx5.EOF_Response__c = elog.EOF_Response__c;
        elogx5.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        elogx5.EOF_Stato_Richiesta__c='Inserita Portale';
        elogx5.EOF_Tipo_Comunicazione_String__c = 'CPE';
        insert elogx5;
        
        EOF_EAI_Service_Log__c elogx6 = new  EOF_EAI_Service_Log__c();
        elogx6.Caso__c = elog.Caso__c;
        elogx6.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elogx6.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elogx6.EOF_Response__c = elog.EOF_Response__c;
        elogx6.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        elogx6.EOF_Stato_Richiesta__c='Inserita Portale';
        elogx6.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        insert elogx6;
        
        EOF_EAI_Service_Log__c elog5 = new  EOF_EAI_Service_Log__c();
        elog5.Caso__c = elog.Caso__c;
        elog5.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog5.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elog5.EOF_Response__c = elog.EOF_Response__c;
        elog5.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId();
        elog5.EOF_Stato_Richiesta__c='Inserita Portale';
        elog5.EOF_Tipo_Comunicazione_String__c = 'CPE';
        insert elog5;
        
        EOF_EAI_Service_Log__c elog6 = new  EOF_EAI_Service_Log__c();
        elog6.Caso__c = elog.Caso__c;
        elog6.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog6.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elog6.EOF_Response__c = elog.EOF_Response__c;
        elog6.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId();
        elog6.EOF_Stato_Richiesta__c='Inserita Portale';
        elog6.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        insert elog6;
        
        EOF_EAI_Service_Log__c elog7 = new  EOF_EAI_Service_Log__c();
        elog7.Caso__c = elog.Caso__c;
        elog7.EOF_ID_Notifica__c = 'ID_049487';
        elog7.EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06';
        elog7.EOF_Response__c = elog.EOF_Response__c;
        elog7.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId();
        elog7.EOF_Stato_Richiesta__c='Inserita Portale';
        elog7.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        insert elog7;
        
        EOF_EAI_Service_Log__c elog8 = new  EOF_EAI_Service_Log__c();
        elog8.Caso__c = elog.Caso__c;
        elog8.EOF_ID_Notifica__c = 'ID_0494871';
        elog8.EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06';
        elog8.EOF_Response__c = elog.EOF_Response__c;
        elog8.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        elog8.EOF_Stato_Richiesta__c='Inserita Portale';
        elog8.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        insert elog8;
        
        EOF_EAI_Service_Log__c elog9 = new  EOF_EAI_Service_Log__c();
        elog9.Caso__c = elog.Caso__c;
        elog9.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog9.EOF_Codice_Ordine_OLO__c = 'TEST_CHO_01';
        elog9.EOF_Codice_Motivazione__c = '001';
        elog9.EOF_GPON_Attestazione__c = '1';
        elog9.EOF_Response__c = elog.EOF_Response__c;
        elog9.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_SA_CD_Log_ChangeOrderRequest').getRecordTypeId();
        elog9.EOF_Stato_Richiesta__c='Inserita Portale';
        elog9.EOF_Tipo_Comunicazione_String__c = 'CPE';
        insert elog9;
        
        EOF_EAI_Service_Log__c elog10 = new  EOF_EAI_Service_Log__c();
        elog10.Caso__c = elog.Caso__c;
        elog10.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog10.EOF_Codice_Ordine_OLO__c = 'TEST_CHO_01';
        elog10.EOF_Codice_Motivazione__c = '001';
        elog10.EOF_GPON_Attestazione__c = '1';
        elog10.EOF_Response__c = elog.EOF_Response__c;
        elog10.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_SA_CD_Log_ChangeOrderRequest').getRecordTypeId();
        elog10.EOF_Stato_Richiesta__c='Inserita Portale';
        elog10.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        insert elog10;
        
        EOF_EAI_Service_Log__c elog20 = new  EOF_EAI_Service_Log__c();
        elog20.Caso__c = c2.id;
        elog20.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog20.EOF_Codice_Ordine_OLO__c = 'TEST_CHO_02';
        elog20.EOF_Codice_Motivazione__c = '001';
        elog20.EOF_GPON_Attestazione__c = '1';
        elog20.EOF_Response__c = elog.EOF_Response__c;
        elog20.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_SA_CD_Log_ChangeOrderRequest').getRecordTypeId();
        elog20.EOF_Stato_Richiesta__c='Inserita Portale';
        elog20.EOF_Tipo_Comunicazione_String__c = 'CPE';
        insert elog20;
        
        //public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    //}
    
        
        //OF_SA_CD_GE_Utils.aggiornamentoDatiEspletamento();
    }
    
    public static testMethod void copy_request1()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request omns = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_SA_CD_GE_Utils.copy_request(omns); 
        test.stopTest();
    }
    
    public static testMethod void copy_request2()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest omns = new  OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void syncErrorActReq()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest omns = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01' 
                                     limit 1 
                                     FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        try{
            OF_SA_CD_GE_Utils.syncError(omns, null, null);
        }
        catch(Exception e){}
        
        test.stopTest();
    }
    
    public static testMethod void copy_request3()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    public static testMethod void copy_request3a()
    {
        test.startTest();
        GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element  omns = new GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void copy_request4()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest omns = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void copy_request5()
    {
        test.startTest();
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder omns = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void copy_request6()
    {
        test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void copy_request7()
    {
        test.startTest();
        OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element omns = new OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element();
        
        List< OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element> APP = new List< OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element>();
         OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element APP1 = new  OF_SA_WS_OLO_Classi.RITIRO_APPARATO_element();
        APP1.TIPOLOGIA_APPARATO= 'Test';
        APP1.ESITO_RITIRO_APPARATO= 'Test';
        APP.add(APP1);
        omns.apparato= APP;
        OF_SA_CD_GE_Utils.copy_request(omns);

        List<OF_SA_WS_OLO_classi.VLAN_element> VLAN = new List<OF_SA_WS_OLO_classi.VLAN_element>();
        OF_SA_WS_OLO_classi.VLAN_element VLAN1 = new OF_SA_WS_OLO_classi.VLAN_element();
        VLAN1.USER_VLAN = 'Test';
        VLAN1.SERVICE_VLAN = 'Test';
        VLAN.add(VLAN1);
        omns.VLan = VLAN;
        OF_SA_CD_GE_Utils.copy_request(omns);

        test.stopTest();
    }
    
    public static testMethod void copy_request8()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.AttivazioneGpona_element omns = new OF_SA_WS_OM_Classi.AttivazioneGpona_element();
        
        List<OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element> SER = new List<OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element>();
        OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element SER1= new  OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element();
        SER1.NOME_SERVIZIO= 'Test';
        SER1.INFORMAZIONI_SERVIZIO= 'Test';
        SER.add(SER1);
        omns.SERVIZIO_AGGIUNTIVO= SER;
        OF_SA_CD_GE_Utils.copy_request(omns);
        
        List<OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element> APP = new List<OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element>();
        OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element APP1 = new  OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element();
        APP1.TIPOLOGIA_APPARATO= 'Test';
        APP1.ID_APPARATO= 'Test';
        APP.add(APP1);
        omns.apparato= APP;
        OF_SA_CD_GE_Utils.copy_request(omns);
        
        List<OF_SA_WS_OM_Classi.VLAN_element> AP = new List<OF_SA_WS_OM_Classi.VLAN_element>();
        OF_SA_WS_OM_Classi.VLAN_element AP1 = new  OF_SA_WS_OM_Classi.VLAN_element();
        AP1.KIT_CONSEGNA_VLAN= 'Test';
        AP1.USER_VLAN = 'Test';
        AP.add(AP1);
        omns.VLAN= AP;
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void copy_request9()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.Disattivazione_element omns = new  OF_SA_WS_OM_Classi.Disattivazione_element();
        
        List<OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element> APP = new List<OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element>();
        OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element APP1 = new  OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element();
        APP1.TIPOLOGIA_APPARATO= 'Test';
        APP1.ID_APPARATO= 'Test';
        APP.add(APP1);
        omns.apparato= APP;
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void copy_request10()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.Rischedulazione_element omns = new OF_SA_WS_OM_Classi.Rischedulazione_element();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void copy_request11()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.AggiornamentoStato_element omns = new OF_SA_WS_OM_Classi.AggiornamentoStato_element();
        OF_SA_CD_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    
    public static testMethod void syncError()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request olo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        //OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request olo1 = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        olo.COdice_operatore = 'test';
        olo.CODICE_ORDINE_OLO = 'test1';
        olo.ID_NOTIFICA = 'test';
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01'
                                     limit 1 
                                     FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_SA_CD_GE_Utils.slOLOSF= new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.syncError(sl,'A10','test');
        //OF_SA_CD_GE_Utils.slOLOSF= new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.syncError(olo,'A10','test');
        test.stopTest();
    }
    
    public static testMethod void syncError1()
    {
        test.startTest();
        List<RecordType> orderrtypes = [Select Name, Id From RecordType 
                                        where sObjectType='Order'
                                        and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
            OrderRecordTypes.put(rt.Name,rt.Id); 
        
        GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element olo = new GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element();
        //OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request olo1 = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        olo.COdice_operatore = 'test';
        olo.CODICE_ORDINE_OLO = 'test1';
        olo.ID_NOTIFICA = 'test';
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01'
                                     limit 1 
                                     FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_SA_CD_GE_Utils.RTMap = new  map<String,String>();
        OF_SA_CD_GE_Utils.slOLOSF= new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.syncError(sl,'A10','test');
        //OF_SA_CD_GE_Utils.slOLOSF= new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.syncError(olo,'A10','test');
        test.stopTest();
    }

    public static testMethod void syncError1a()
    {
        test.startTest();
        List<RecordType> orderrtypes = [Select Name, Id From RecordType 
                  where sObjectType='Order' and isActive=true];
        
        Map<String,String> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: Orderrtypes)
         OrderRecordTypes.put(rt.Name,rt.Id); 
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request olo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request ();
        //OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request olo1 = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        olo.COdice_operatore = 'test';
        olo.CODICE_ORDINE_OLO = 'test1';
        olo.ID_NOTIFICA = 'test';
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01'
                                     limit 1 
                                     FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_SA_CD_GE_Utils.RTMap = new  map<String,String>();
        OF_SA_CD_GE_Utils.slOLOSF= new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.syncError(sl,'A10','test');
        //OF_SA_CD_GE_Utils.slOLOSF= new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.syncError(olo,'A10','test');
        test.stopTest();
    }
 
 
    
    public static testMethod void syncError2()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest omns = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01' 
                                     limit 1 
                                     FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_SA_CD_GE_Utils.syncError(sl,'A05','test');
        test.stopTest();
    }
    
    public static testMethod void create_EAI_Log()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request omns = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_SA_CD_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    
    public static testMethod void aggiornaSLPortaleChangeOrd_test()
    {
        test.startTest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c 
                  FROM Case 
                  where EOF_Codice_Ordine_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,
                                               EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c, EOF_MOTIVAZIONE__c,
                                               EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C 
                                               from EOF_EAI_Service_Log__c 
                                               where EOF_CODICE_ORDINE_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        string mystr = 'OM_StatusUpdate';
        try
        {
            OF_SA_CD_GE_Utils.aggiornaSLPortaleChangeOrd(eoflst1, mystr);
        }
        catch(Exception e){}
        test.stopTest();
    }
    
    public static testMethod void aggiornaSLPortaleChangeOrd_test1()
    {
        test.startTest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c
                  FROM Case 
                  where EOF_Codice_Ordine_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,
                                               OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_MOTIVAZIONE__c,
                                               EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C 
                                               from EOF_EAI_Service_Log__c 
                                               where EOF_CODICE_ORDINE_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        string mystr = 'OM_CompletionOrder';
       
        try
        {
            OF_SA_CD_GE_Utils.aggiornaSLPortaleChangeOrd(eoflst1, mystr);
        }
        catch(Exception e){}
        test.stopTest();
    }
    
    public static testMethod void aggiornaSLPortaleChangeOrd_test2()
    {
        test.startTest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c
                  FROM Case 
                  where EOF_Codice_Ordine_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,
                                               EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_MOTIVAZIONE__c,
                                               EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C 
                                               from EOF_EAI_Service_Log__c 
                                               where EOF_CODICE_ORDINE_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        string mystr = 'OM_Reschedule';
       
        try
        {
            OF_SA_CD_GE_Utils.aggiornaSLPortaleChangeOrd(eoflst1, mystr);
        }
        catch(Exception e){}
        test.stopTest();
    }
    
    
    public static testMethod void aggiornaSLPortaleChangeOrd_test3()
    {
        test.startTest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c
                  FROM Case 
                  where EOF_Codice_Ordine_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,
                                               EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_MOTIVAZIONE__c,
                                               EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C 
                                               from EOF_EAI_Service_Log__c 
                                               where EOF_CODICE_ORDINE_OLO__c = 'TEST_CHO_01' FOR UPDATE];
        
        string mystr = 'OLO_ActivationTO_OM'; 
       
        try
        {
            OF_SA_CD_GE_Utils.aggiornaSLPortaleChangeOrd(eoflst1, mystr);
        }
        catch(Exception e){}
        test.stopTest();
    }
    
    public static testMethod void aggiornaSLPortaleChangeOrd_test4()
    {
        test.startTest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c
                  FROM Case 
                  where EOF_Codice_Ordine_OLO__c = 'TEST_CHO_02'
                  FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,
                                               EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_MOTIVAZIONE__c,
                                               EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C 
                                               from EOF_EAI_Service_Log__c 
                                               where EOF_CODICE_ORDINE_OLO__c = 'TEST_CHO_02' 
                                               limit 1];
        
        string mystr = 'OM_StatusUpdate';
       
        OF_SA_CD_GE_Utils.aggiornaSLPortaleChangeOrd(eoflst1, mystr);
        test.stopTest();
    }
    
    public static testMethod void aggiornaSLPortale()
    {
        test.startTest();
        
        //-----insert EAI Service Log------
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37x';
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

        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_Stato_Richiesta__c = 'Inserita Portale';
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_DATA_Notifica__c = System.now();
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog;
        
        //String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_01';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog1.OF_SA_ACK__c = true;
        insert eaiLog1;
        
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c = c.Id;
        eaiLog2.EOF_ID_Notifica__c = 'test_01';
        eaiLog2.EOF_Codice_Ordine_OLO__c = '02112016_37';
        //eaiLog.recordTypeId = eaiRecordType;
        eaiLog2.OF_SA_ACK__c = true;
        insert eaiLog2;
        
        EOF_EAI_Service_Log__c  eaiLog4 = new EOF_EAI_Service_Log__c();
        eaiLog4.Caso__c  = c.Id;
        eaiLog4.EOF_Stato_Richiesta__c = 'Inserita Portale';
        eaiLog4.EOF_ID_Notifica__c = 'test_01';
        eaiLog4.EOF_DATA_Notifica__c = System.now();
        eaiLog4.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog4.recordTypeId = eaiRecordType;
        eaiLog4.OF_SA_ACK__c = true;
        insert eaiLog4;

        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                                EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                                EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                                EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,
                                                OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C 
                                                from EOF_EAI_Service_Log__c];

        string mystr = 'OM_StatusUpdate';
        string mystr1 = 'OM_CompletionOrder';
        try
        {
            OF_SA_CD_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
            OF_SA_CD_GE_Utils.aggiornaSLPortale(eoflst1,mystr1);
        }
        catch(exception e){}
        
        test.stopTest();
    }
    
    public static testMethod void aggiornaSLPortale1()
    {
        test.startTest();
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
       List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_ID_Risorsa__c,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_DDT__c,EOF_Data_Espletamento_Ordine__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c 
                                               where EOF_ID_Notifica__c = 'ID_049487' 
                                               and recordtype.name='PO - SA - CD - OpenStreamRequest' 
                                               and EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06' FOR UPDATE];
        
        string mystr = 'OM_CompletionOrder';
      
        OF_SA_CD_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
        test.stopTest();
    }
    
    public static testMethod void aggiornaSLPortale2()
    {
        test.startTest();
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case 
                  where EOF_Tipologia_Servizio__c = 'test sasya1' 
                  limit 1 FOR UPDATE];
          
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c 
                                               where EOF_ID_Notifica__c = 'ID_049487' 
                                               and recordtype.name='PO - SA - CD - OpenStreamRequest' 
                                               and EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06' FOR UPDATE];
        
        string mystr = 'OM_Reschedule';
      
        OF_SA_CD_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
        test.stopTest();
    }
    
    public static testMethod void aggiornamentoDatiAcquisizione_test()
    {
        test.startTest();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Cliente';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;

        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c 
                  FROM Case 
                  where EOF_Tipologia_Servizio__c = 'test sasya1' 
                  limit 1 FOR UPDATE];
        
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        EOF_EAI_Service_Log__c sl = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                     EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                     EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                     EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                     EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                     EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                     EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C 
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01' 
                                     limit 1 FOR UPDATE];

        try
        {
            TEMPLOG__c t = new TEMPLOG__c();
            t.Name = c.EOF_Codice_Ordine_OLO__c;
            t.DataInserimento__c=string.valueOF(system.now());
            t.Desc__c='error';
            t.Class__c='OF_SA_CD_GE_Utils';
            insert t;
            OF_Generatore_ID_Servizio__c gen = new OF_Generatore_ID_Servizio__c();
            // gen.name = '0000017531';
            insert gen;
            OF_SA_CD_GE_Utils.gen = gen;
            OF_SA_CD_GE_Utils.checkCliente = true;
            OF_SA_CD_GE_Utils.aggiornamentoDatiAcquisizione(c);   
        }
        catch(exception e){}
        test.stopTest();
    }
    
    public static testMethod void aggiornamentoDatiAttivazioneCessazioneToOM_test()
    {
        test.startTest();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Cliente';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37x';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        //c.Account = acc;
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
        c.PO_SA_Portale__c = true;
        insert c;
        
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        string processo = 'Create';
        //string tipo_comunicazione = '98';
        string esito = '2';
        OF_SA_CD_GE_Utils.checkApp = false;
        OF_SA_CD_GE_Utils.checkServAgg = false;
        OF_SA_CD_GE_Utils.checkCliente = true;
        
        try
        {
            OF_SA_CD_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM(processo,null,esito);   
        }
        catch(exception e){}
        
        test.stopTest();  
    }
    
    public static testMethod void aggiornamentoDatiAttivazioneCessazioneToOM_test2()
    {
        test.startTest();

        string processo = 'Delete';
        string tipo_comunicazione = '98';
        string estito = '2';
        OF_SA_CD_GE_Utils.checkApp = false;
        OF_SA_CD_GE_Utils.checkServAgg = false;
        
        try
        {
            OF_SA_CD_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM(processo,tipo_comunicazione,estito);   
        }
        catch(exception e){}
        
        test.stopTest();  
    }
        
    public static testMethod void aggiornamentoDatiAttivazioneCessazioneToOM_test3()
    {
        test.startTest();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Cliente';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        //c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37x';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        //c.Account = acc;
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
        
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        string processo = 'Create';
        //string tipo_comunicazione = '98';
        string esito = '2';
        OF_SA_CD_GE_Utils.checkApp = false;
        OF_SA_CD_GE_Utils.checkServAgg = false;
        OF_SA_CD_GE_Utils.checkCliente = false;
        OF_SA_CD_GE_Utils.checkVLan = true;
        
        try
        {
            OF_SA_CD_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM(processo,null,esito);   
        }
        catch(exception e){}
        
        test.stopTest();  
    }
    /*public static testMethod void aggiornamentoDatiEspletamento_test()
    {
        test.startTest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c
                  FROM Case 
                  where EOF_Tipologia_Servizio__c = 'test sasya1' 
                  limit 1 FOR UPDATE];
        
      List<EOF_EAI_Service_Log__c> eoflst = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' FOR UPDATE];
        
        eoflst[0].recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        update eoflst[0];
        
        string caseid = c.id;
        string  eoflog1 = eoflst[0].id;
        string  eoflog2 = eoflst[0].id;
        
        try
        {
            OF_SA_CD_GE_Utils.aggiornamentoDatiEspletamento(caseid, eoflog1, eoflog2);
        } 
        catch(exception e){}
        
        test.stopTest();
    }*/
    
    public static testMethod void copy_notify_AcqCess_test()
    {
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        //eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        //eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        //eaiLog1.recordTypeId = eaiRecordType1;
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
        OF_SA_CD_GE_Utils.copy_notify_AcqCess(eaiLog1);
        Test.stopTest();
    }
    
    public static testmethod  void MyUnitTest1(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
        
        system.assertEquals('A',OF_SA_CD_GE_Utils.IdservizioIntToString(1));
        system.assertEquals('B',OF_SA_CD_GE_Utils.IdservizioIntToString(2));
        system.assertEquals('C',OF_SA_CD_GE_Utils.IdservizioIntToString(3));
        system.assertEquals('D',OF_SA_CD_GE_Utils.IdservizioIntToString(4));
        system.assertEquals('E',OF_SA_CD_GE_Utils.IdservizioIntToString(5));
        system.assertEquals('F',OF_SA_CD_GE_Utils.IdservizioIntToString(6));
        system.assertEquals('G',OF_SA_CD_GE_Utils.IdservizioIntToString(7));
        system.assertEquals('H',OF_SA_CD_GE_Utils.IdservizioIntToString(8));
        system.assertEquals('I',OF_SA_CD_GE_Utils.IdservizioIntToString(9));
        system.assertEquals('J',OF_SA_CD_GE_Utils.IdservizioIntToString(10));
        system.assertEquals('K',OF_SA_CD_GE_Utils.IdservizioIntToString(11));
        system.assertEquals('L',OF_SA_CD_GE_Utils.IdservizioIntToString(12));
        system.assertEquals('M',OF_SA_CD_GE_Utils.IdservizioIntToString(13));
        system.assertEquals('N',OF_SA_CD_GE_Utils.IdservizioIntToString(14));
        system.assertEquals('O',OF_SA_CD_GE_Utils.IdservizioIntToString(15));
        system.assertEquals('P',OF_SA_CD_GE_Utils.IdservizioIntToString(16));
        system.assertEquals('Q',OF_SA_CD_GE_Utils.IdservizioIntToString(17));
        system.assertEquals('R',OF_SA_CD_GE_Utils.IdservizioIntToString(18));
        system.assertEquals('S',OF_SA_CD_GE_Utils.IdservizioIntToString(19));
        system.assertEquals('T',OF_SA_CD_GE_Utils.IdservizioIntToString(20));
        system.assertEquals('U',OF_SA_CD_GE_Utils.IdservizioIntToString(21));
        system.assertEquals('V',OF_SA_CD_GE_Utils.IdservizioIntToString(22));
        system.assertEquals('W',OF_SA_CD_GE_Utils.IdservizioIntToString(23));
        system.assertEquals('X',OF_SA_CD_GE_Utils.IdservizioIntToString(24));
        system.assertEquals('Y',OF_SA_CD_GE_Utils.IdservizioIntToString(25));
        system.assertEquals('Z',OF_SA_CD_GE_Utils.IdservizioIntToString(26));
    }
    /**MyUnitTest3() copre il seguente metodo:
/*1.IdServizioStringToInt
*/
    public static testmethod  void MyUnitTest2(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        system.assertEquals(1,OF_SA_CD_GE_Utils.IdservizioStringToInt('A'));
        system.assertEquals(2,OF_SA_CD_GE_Utils.IdservizioStringToInt('B'));
        system.assertEquals(3,OF_SA_CD_GE_Utils.IdservizioStringToInt('C'));
        system.assertEquals(4,OF_SA_CD_GE_Utils.IdservizioStringToInt('D'));
        system.assertEquals(5,OF_SA_CD_GE_Utils.IdservizioStringToInt('E'));
        system.assertEquals(6,OF_SA_CD_GE_Utils.IdservizioStringToInt('F'));
        system.assertEquals(7,OF_SA_CD_GE_Utils.IdservizioStringToInt('G'));
        system.assertEquals(8,OF_SA_CD_GE_Utils.IdservizioStringToInt('H'));
        system.assertEquals(9,OF_SA_CD_GE_Utils.IdservizioStringToInt('I'));
        system.assertEquals(10,OF_SA_CD_GE_Utils.IdservizioStringToInt('J'));
        system.assertEquals(11,OF_SA_CD_GE_Utils.IdservizioStringToInt('K'));
        system.assertEquals(12,OF_SA_CD_GE_Utils.IdservizioStringToInt('L'));
        system.assertEquals(13,OF_SA_CD_GE_Utils.IdservizioStringToInt('M'));
        system.assertEquals(14,OF_SA_CD_GE_Utils.IdservizioStringToInt('N'));
        system.assertEquals(15,OF_SA_CD_GE_Utils.IdservizioStringToInt('O'));
        system.assertEquals(16,OF_SA_CD_GE_Utils.IdservizioStringToInt('P'));
        system.assertEquals(17,OF_SA_CD_GE_Utils.IdservizioStringToInt('Q'));
        system.assertEquals(18,OF_SA_CD_GE_Utils.IdservizioStringToInt('R'));
        system.assertEquals(19,OF_SA_CD_GE_Utils.IdservizioStringToInt('S'));
        system.assertEquals(20,OF_SA_CD_GE_Utils.IdservizioStringToInt('T'));
        system.assertEquals(21,OF_SA_CD_GE_Utils.IdservizioStringToInt('U'));
        system.assertEquals(22,OF_SA_CD_GE_Utils.IdservizioStringToInt('V'));
        system.assertEquals(23,OF_SA_CD_GE_Utils.IdservizioStringToInt('W'));
        system.assertEquals(24,OF_SA_CD_GE_Utils.IdservizioStringToInt('X'));
        system.assertEquals(25,OF_SA_CD_GE_Utils.IdservizioStringToInt('Y'));
        system.assertEquals(26,OF_SA_CD_GE_Utils.IdservizioStringToInt('Z'));
    }    
    
    static testmethod void getQuery1()
    {
        test.startTest();
        string oggetto ='sl';
        string processo = 'AsyncActivation';
        OF_SA_CD_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    
    static testmethod void getQuery2()
    {
        test.startTest();
        string oggetto ='sl';
        string processo = 'AsyncDeactivation';
        OF_SA_CD_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    
    static testmethod void getQuery3()
    {
        test.startTest();
        string oggetto ='asset';
        string processo = 'AsyncDeactivation';
        OF_SA_CD_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    
    /**MyUnitTest4 copre il seguente metodo:
    /*1.copy_request**/
    public static testmethod  void MyUnitTest3(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest a = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        a.CODICE_OPERATORE ='VF';
        a.CODICE_ORDINE_OLO ='test12';
        a.DATA_NOTIFICA = '2017-05-16T13:00:15+01:00';
        a.NOME_REFERENTE_TECNICO_OLO = 'Gianluca';
        a.COGNOME_REFERENTE_TECNICO_OLO = 'Galeazzi';
        a.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
        a.EMAIL_REFERENTE_TECNICO_OLO = 'test@test.it';
        a.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        a.NOME_CLIENTE = 'Test';
        a.COGNOME_CLIENTE = 'Test';
        a.RECAPITO_TELEFONICO_CLIENTE_1 = 'Tel01';
        a.RECAPITO_TELEFONICO_CLIENTE_2 = 'Tel02';
        a.INFORMAZIONI_LOGISTICA_APPARATI = 'apparato1';
        a.DATA_PREVISTA_ATTIVAZIONE = '2017-07-17';
        a.ORARIO_APPUNTAMENTO = '18:00:00';
        a.CODICE_PROGETTO_SPECIALE = 'progetto1';
        a.PROMOZIONE = 'promozione1';
        a.CLUSTER_PROMOZIONE = 'Cluster1';
        a.NOTE = 'Note1';
        a.ID_BUILDING = '03_015_015146_1300_18';
        a.SCALA_PALAZZINA = 'Scala_Palazzina01';
        a.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Tel_Linea0123';
        a.RECAPITO_TEST_LINEA = 'Test_Linea_1';
        a.IDENTIFICATIVO_DEL_POP = 'MI/FCO/9';
        a.PROFILO = 'Profilo1';
        
        OF_SA_WS_IN_OLO_Activation.VLAN vlan1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        vlan1.KIT_CONSEGNA_VLAN = 'K';
        vlan1.USER_VLAN = 'v1';
        vlan1.SERVICE_VLAN = 'Serv';
        vlan1.PROFILO_VLAN = 'pr1';
        vlan1.INFORMAZIONI_VLAN = 'info1';
        vlan1.CUSTOMER_VLAN = 'cus1';
        vlan1.MODELLO_DI_SERVIZIO_VLAN = 'mod1';
        
        a.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        a.VLAN.add( vlan1 );
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO servAggiuntivo = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        servAggiuntivo.NOME_SERVIZIO =  's1'; 
        servAggiuntivo.INFORMAZIONI_SERVIZIO = 'Info_s1';
        
        a.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        a.SERVIZIO_AGGIUNTIVO.add( servAggiuntivo );
        
        OF_SA_WS_IN_OLO_Activation.APPARATO app = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        app.TIPOLOGIA_APPARATO = '1';
        app.PASSWORD_APPARATO = 'psw1';
        app.AZIONE_APPARATO = 'Y';
        
        a.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();        
        a.APPARATO.add( app );
        
        test.startTest();
        
        //Add by PG
        Case c = new Case();
        c.status = 'Acquisito KO';
        c.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c.EOF_Numero_Civico_WS__c = '12';
        c.EOF_Provincia_WS__c = 'RM';
        c.EOF_Comune_WS__c = 'Roma';
        insert c;
        
        Case c1 = new Case();
        c1.status = 'Acquisito';
        c1.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c1.EOF_Numero_Civico_WS__c = '12';
        c1.EOF_Provincia_WS__c = 'RM';
        c1.EOF_Comune_WS__c = 'Roma';
        insert c1;
        
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        
        //OF_SA_CD_GE_Utils.slOLOSF.id = TestDataFactory.ESlog[0].id;
                
        OF_SA_CD_GE_Utils.create_EAI_Log( a );
        OF_SA_CD_GE_Utils.CreateAcquisition_Log(c);
        OF_SA_CD_GE_Utils.CreateAcquisition_Log(c1);
        
        //OF_SA_CD_GE_Utils.create_ActivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog);        
        
        //OF_SA_CD_GE_Utils.syncError( a , 'A03' , 'test' );
        OF_SA_CD_GE_Utils.checkDate('2017-11-16');
        OF_SA_CD_GE_Utils.CheckTime('10:00:00');
        OF_SA_CD_GE_Utils.checkDateTime('2017-11-16T10:00:00');
        OF_SA_CD_GE_Utils.checkEmail('test@test.it');
        OF_SA_CD_GE_Utils.checkAmministratori(TestDataFactory.c1);
        //OF_SA_CD_GE_Utils.getQuery('a','test');
        OF_SA_CD_GE_Utils.simulateNACK ('test');
        
        OF_SA_CD_GE_Utils.CreateTemplogOLO(a);
        OF_SA_CD_GE_Utils.partialTemplog('test');
        OF_SA_CD_GE_Utils.EndTemplog();

        test.stopTest();
    }
    
    public static testmethod void OLO_CreateDeactivation_Log_1(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        
        deact.CODICE_OPERATORE = 'VF';
        deact.CODICE_ORDINE_OLO = 'Test123';
        deact.DATA_NOTIFICA = '2017-05-16T13:00:15+01:00';
        deact.ID_NOTIFICA = 'n123';
        deact.ID_RISORSA = 'Risorsa01';
        deact.NOME_CLIENTE = 'Pippo';
        deact.COGNOME_CLIENTE = 'Baudo';
        deact.RECAPITO_TELEFONICO_CLIENTE_1  = 'Tel012';
        deact.RECAPITO_TELEFONICO_CLIENTE_2 = 'Tel012';
        deact.CODICE_MOTIVAZIONE = '1';
        deact.MOTIVAZIONE = 'Y';
        deact.NOTE = 'Note1';
        
        OF_SA_WS_IN_OLO_Deactivation.APPARATO app = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
        
        app.TIPOLOGIA_APPARATO = '1';
        app.ID_APPARATO = '1';
        
        deact.APPARATO =  new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();        
        deact.APPARATO.add( app );
        
        test.startTest();
        
        OF_SA_CD_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;
        OF_SA_CD_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();
        
        OF_SA_CD_GE_Utils.create_EAI_Log( deact );
        OF_SA_CD_GE_Utils.syncError( deact , 'A07' , 'test' );
        
        //Add by PG
        Case c = new Case();
        c.status = 'Cessato KO';
        c.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c.EOF_Numero_Civico_WS__c = '12';
        c.EOF_Provincia_WS__c = 'RM';
        c.EOF_Comune_WS__c = 'Roma';
        insert c;
        
        OF_SA_CD_GE_Utils.OLO_CreateDeactivation_Log(c, deact);
        //OF_SA_CD_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_SA_CD_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        OF_SA_CD_GE_Utils.CreateTemplogOLO(deact);
        OF_SA_CD_GE_Utils.partialTemplog('test');
        OF_SA_CD_GE_Utils.EndTemplog();
        
        test.stopTest();
    }
    
    public static testmethod void OLO_CreateDeactivation_Log_2(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        
        deact.CODICE_OPERATORE = 'VF';
        deact.CODICE_ORDINE_OLO = 'Test123';
        deact.DATA_NOTIFICA = '2017-05-16T13:00:15+01:00';
        deact.ID_NOTIFICA = 'n123';
        deact.ID_RISORSA = 'Risorsa01';
        deact.NOME_CLIENTE = 'Pippo';
        deact.COGNOME_CLIENTE = 'Baudo';
        deact.RECAPITO_TELEFONICO_CLIENTE_1  = 'Tel012';
        deact.RECAPITO_TELEFONICO_CLIENTE_2 = 'Tel012';
        deact.CODICE_MOTIVAZIONE = '1';
        deact.MOTIVAZIONE = 'Y';
        deact.NOTE = 'Note1';
        
        OF_SA_WS_IN_OLO_Deactivation.APPARATO app = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
        
        app.TIPOLOGIA_APPARATO = '1';
        app.ID_APPARATO = '1';
        
        deact.APPARATO =  new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();        
        deact.APPARATO.add( app );
        
        test.startTest();
        
        OF_SA_CD_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;
        OF_SA_CD_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();
        
        OF_SA_CD_GE_Utils.create_EAI_Log( deact );
        OF_SA_CD_GE_Utils.syncError( deact , 'A07' , 'test' );
        
        //Add by PG
        Case c = new Case();
        c.status = 'Acquisito';
        c.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c.EOF_Numero_Civico_WS__c = '12';
        c.EOF_Provincia_WS__c = 'RM';
        c.EOF_Comune_WS__c = 'Roma';
        insert c;
        
        OF_SA_CD_GE_Utils.OLO_CreateDeactivation_Log(c, deact);
        //OF_SA_CD_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_SA_CD_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        OF_SA_CD_GE_Utils.CreateTemplogOLO(deact);
        OF_SA_CD_GE_Utils.partialTemplog('test');
        OF_SA_CD_GE_Utils.EndTemplog();
        
        test.stopTest();
    }
    
    public static testmethod void MyUnitTest5 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate ();
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-10-05T13:30:00+02:00';
        Notify.ID_NOTIFICA = '14950347';
        Notify.STATO_ORDINE ='7';
        Notify.CODICE_MOTIVAZIONE ='D02';
        Notify.MOTIVAZIONE ='test';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_SA_CD_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_SA_CD_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_SA_CD_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();        
    }
    
    public static testmethod void MyUnitTest6 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);

        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest Req = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
                
        Req.CODICE_OPERATORE ='VF';
        Req.CODICE_ORDINE_OLO ='Test';
        Req.DATA_NOTIFICA ='2017-08-28T11:30:15+01:00';
        Req.ID_NOTIFICA ='358925';
        Req.NOME_CLIENTE ='Marina';
        Req.COGNOME_CLIENTE ='Silvestro';
        Req.RECAPITO_TELEFONICO_CLIENTE_1 ='4352223';
        Req.RECAPITO_TELEFONICO_CLIENTE_2 ='1234454';
        Req.DATA_PREVISTA_ATTIVAZIONE ='2017-09-14';
        Req.ORARIO_APPUNTAMENTO ='14:30:00';
        Req.CODICE_MOTIVAZIONE ='D13';
        Req.MOTIVAZIONE ='Motivi cliente';
        Req.NOTE ='';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Req );
        OF_SA_CD_GE_Utils.syncError( Req , 'A05' , 'test' );
        OF_SA_CD_GE_Utils.OLO_CreateReschedule_Log(TestDataFactory.c1, Req);
        OF_SA_CD_GE_Utils.CreateTemplogOLO(Req);
        
        test.stopTest();        
    }
    
    public static testmethod void MyUnitTest7 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest Request = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest ();
        
        Request.CODICE_OPERATORE='VF'; 
        Request.CODICE_ORDINE_OLO='Test';
        Request.DATA_NOTIFICA='2017-07-10T15:20:15+02:00';
        Request.ID_NOTIFICA='test_01';
        Request.AZIONE='0';
        Request.CODICE_MOTIVAZIONE='AB';
        Request.MOTIVAZIONE='ABC';
        Request.DATA_PREVISTA_ATTIVAZIONE='2017-10-24';
        Request.ORARIO_APPUNTAMENTO='10:30:00';
        Request.NOME_CLIENTE='Mario';
        Request.COGNOME_CLIENTE='Rossi';
        Request.RECAPITO_TELEFONICO_CLIENTE_1='123456';
        Request.RECAPITO_TELEFONICO_CLIENTE_2='1234567';
        Request.NOTE='';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Request );
        OF_SA_CD_GE_Utils.syncError( Request , 'A08' , 'test' );
        OF_SA_CD_GE_Utils.OLO_CreateStatusUpdate_Log(TestDataFactory.c1,Request);
        OF_SA_CD_GE_Utils.CreateTemplogOLO(Request);        
        test.stopTest();
    }
    
    public static testmethod void MyUnitTest8 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','PO_SA_CD_Log_OpenStreamRequest', null);

        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule Notify = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO='Test';
        Notify.CODICE_ORDINE_OF= TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA='2017-10-05T15:00:00+01:00';
        Notify.ID_NOTIFICA='test_redac_01';
        Notify.NOME_CLIENTE='Mario';
        Notify.COGNOME_CLIENTE='Rossi';
        Notify.RECAPITO_TELEFONICO_CLIENTE_1='123456';
        Notify.RECAPITO_TELEFONICO_CLIENTE_2='1234567';
        Notify.DATA_PREVISTA_ATTIVAZIONE='2017-10-24';
        Notify.ORARIO_APPUNTAMENTO='16:00:00';
        Notify.CODICE_MOTIVAZIONE='D13';
        Notify.MOTIVAZIONE='Motivi Cliente';
        Notify.NOTE='';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'A06' , 'test' );                        
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_Reschedule');        
        OF_SA_CD_GE_Utils.OM_CreateReschedule_Log(TestDataFactory.c1,notify);
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();

    }
    
    public static testmethod void MyUnitTest9 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','PO_SA_CD_Log_OpenStreamRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);

        test.stopTest();
    }

    public static testmethod void MyUnitTest10 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','PO_SA_CD_Log_OpenStreamRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);

        test.stopTest();
    }

    public static testmethod void MyUnitTest11 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','PO_SA_CD_Log_OpenStreamRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest12 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','PO_SA_CD_Log_OpenStreamRequest', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';
        
        Notify.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO serv2 = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        serv2.TIPOLOGIA_APPARATO='Modem';                                                                   
        serv2.ESITO_CONSEGNA_APPARATO='1';                                                                  
        serv2.ID_APPARATO_CONSEGNATO='qwer';                                                                    
        serv2.CODICE_MOTIVAZIONE_CONSEGNA='';
        serv2.MOTIVAZIONE_CONSEGNA='';
        Notify.APPARATO.add(serv2);
        
        Notify.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO serv1 = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        serv1.NOME_SERVIZIO='Ribaltamento Impianto';
        serv1.ESITO_SERVIZIO='0';
        serv1.MOTIVAZIONE_SERVIZIO='';
        serv1.CODICE_MOTIVAZIONE_SERVIZIO='';        
        Notify.SERVIZIO_AGGIUNTIVO.add(serv1);
        
        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'A10' , 'test' );
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);

        test.stopTest();
    }

    public static testmethod void MyUnitTest13 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
       
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate ();
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-10-05T13:30:00+02:00';
        Notify.ID_NOTIFICA = '14950347';
        Notify.STATO_ORDINE ='7';
        Notify.CODICE_MOTIVAZIONE ='D02';
        Notify.MOTIVAZIONE ='test';

        Notify.APPARATO = new List<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        OF_SA_WS_IN_OM_StatusUpdate.APPARATO serv2 = new OF_SA_WS_IN_OM_StatusUpdate.APPARATO();
        serv2.TIPOLOGIA_APPARATO='Modem';
        serv2.ESITO_RITIRO_APPARATO='';
        serv2.CODICE_MOTIVAZIONE_RITIRO='';
        serv2.MOTIVAZIONE_RITIRO='';
        Notify.APPARATO.add(serv2);             
        
        Notify.VLAN = new List<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        OF_SA_WS_IN_OM_StatusUpdate.VLAN servV = new OF_SA_WS_IN_OM_StatusUpdate.VLAN();
        servV.USER_VLAN ='1';
        servV.SERVICE_VLAN ='1';
        servV.CUSTOMER_VLAN ='1';
        Notify.VLAN.add(servV);
        
        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_SA_CD_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_SA_CD_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_SA_CD_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_SA_CD_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();        
    }

    public static testmethod void MyUnitTest14 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);       
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        //OF_SA_CD_GE_Utils.aggiornamentoDatiEspletamento(TestDataFactory.c1.id,TestDataFactory.ESLog[0].id,TestDataFactory.ESLog[0].id);
        OF_SA_CD_GE_Utils.simulateNACK('OM');
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest15 (){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','PO - SA - FiberRequest2', null);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = TestDataFactory.c1.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2017-09-27';

        test.startTest();
        OF_SA_CD_GE_Utils.create_EAI_Log( Notify );
        OF_SA_CD_GE_Utils.syncError( Notify , 'A09' , 'test' );
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(TestDataFactory.c1, notify);
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_StatusUpdate');
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(TestDataFactory.ESlog,'OM_CompletionOrder');
        OF_SA_CD_GE_Utils.simulateNACK('OLO');
        OF_SA_CD_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest16(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest deact = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        
        deact.CODICE_OPERATORE = 'VF';
        deact.CODICE_ORDINE_OLO = 'Test123';
        deact.DATA_NOTIFICA = '2017-05-16T13:00:15+01:00';
        deact.ID_NOTIFICA = 'n123';
        deact.ID_RISORSA = 'Risorsa01';
        deact.NOME_CLIENTE = 'Pippo';
        deact.COGNOME_CLIENTE = 'Baudo';
        deact.RECAPITO_TELEFONICO_CLIENTE_1  = 'Tel012';
        deact.RECAPITO_TELEFONICO_CLIENTE_2 = 'Tel012';
        deact.CODICE_MOTIVAZIONE = '1';
        deact.MOTIVAZIONE = 'Y';
        deact.NOTE = 'Note1';
        
        
        OF_SA_WS_IN_OLO_Deactivation.APPARATO app = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
        
        app.TIPOLOGIA_APPARATO = '1';
        app.ID_APPARATO = '1';
        
        deact.APPARATO =  new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();        
        deact.APPARATO.add( app );
        
        test.startTest();
        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();
        OF_SA_CD_GE_Utils.tmpl.Tempi_Parziali__c = string.valueof(datetime.now());
        OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();         
        OF_SA_CD_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;
        
        OF_SA_CD_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();
        
        
        OF_SA_CD_GE_Utils.create_EAI_Log( deact );
        OF_SA_CD_GE_Utils.syncError( deact , 'A07' , 'test' );
        
        TestDataFactory.c1.status='Cessato KO';
        update TestDataFactory.c1;
        
        OF_SA_CD_GE_Utils.OLO_CreateDeactivation_Log(TestDataFactory.c1, deact);
        //OF_SA_CD_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_SA_CD_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        OF_SA_CD_GE_Utils.CreateTemplogOLO(deact);
        test.stopTest();       
    }

    public static testmethod void MyUnitTest17(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);

        OF_SA_WS_OLO_Classi.NotificaOrdineGpona_element ngp = new OF_SA_WS_OLO_Classi.NotificaOrdineGpona_element();
        
        ngp.CODICE_ORDINE_OLO ='';
        ngp.CODICE_OPERATORE ='';
        ngp.CODICE_ORDINE_EOF='';
        ngp.DATA_NOTIFICA ='';
        ngp.ID_NOTIFICA ='';
        ngp.STATO_ORDINE='';
        ngp.CODICE_MOTIVAZIONE='';
        ngp.MOTIVAZIONE ='';
        ngp.ID_RISORSA ='';
        ngp.DATA_ESPLETAMENTO_ORDINE ='';
        ngp.SCALA_PALAZZINA ='';
        ngp.DDT ='';
        ngp.NOTE ='';
       List<OF_SA_WS_OLO_classi.SERVIZIO_AGGIUNTIVO_element> ser = new List<OF_SA_WS_OLO_classi.SERVIZIO_AGGIUNTIVO_element>();
        OF_SA_WS_OLO_classi.SERVIZIO_AGGIUNTIVO_element ser1=New OF_SA_WS_OLO_classi.SERVIZIO_AGGIUNTIVO_element();
        ser1.NOME_SERVIZIO = 'Test';
        ser1.ESITO_SERVIZIO = 'Test';
        ser.add(ser1);
        ngp.SERVIZIO_AGGIUNTIVO=ser;
       // ngp.SERVIZIO_AGGIUNTIVO  ngp1= new List<OF_SA_WS_OLO_classi.SERVIZIO_AGGIUNTIVO_element>();
       // ngp1.add(ser);
        test.startTest();
        OF_SA_CD_GE_Utils.copy_request(ngp);

        List<OF_SA_WS_OLO_classi.CONSEGNA_APPARATO_element> APP = new List<OF_SA_WS_OLO_classi.CONSEGNA_APPARATO_element>();
        OF_SA_WS_OLO_classi.CONSEGNA_APPARATO_element APP1 = new OF_SA_WS_OLO_classi.CONSEGNA_APPARATO_element();
        APP1.TIPOLOGIA_APPARATO = 'Test';
        APP1.ESITO_CONSEGNA_APPARATO = 'Test';
        APP.add(APP1);
        ngp.apparato = APP;
        OF_SA_CD_GE_Utils.copy_request(ngp);

        test.stopTest();
    }

    public static testmethod void MyUnitTest18(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);

        OF_SA_WS_OLO_Classi.NotificaRischedulazione_element nre = new OF_SA_WS_OLO_Classi.NotificaRischedulazione_element();
        nre.CODICE_OPERATORE='';
        nre.CODICE_ORDINE_OLO ='';
        nre.DATA_NOTIFICA ='';
        nre.ID_NOTIFICA ='';
        nre.NOME_CLIENTE ='';
        nre.COGNOME_CLIENTE ='';
        nre.RECAPITO_TELEFONICO_CLIENTE_1 ='';
        nre.RECAPITO_TELEFONICO_CLIENTE_2 ='';
        nre.DATA_PREVISTA_ATTIVAZIONE ='';
        nre.ORARIO_APPUNTAMENTO ='';
        nre.CODICE_MOTIVAZIONE ='';
        nre.MOTIVAZIONE ='';
        nre.NOTE ='';
        
        test.startTest();
        OF_SA_CD_GE_Utils.copy_request(nre);       
        test.stopTest();
        
    }

    public static testmethod void MyUnitTest19(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
     
        map<string,string> mappa = new map<string,string>();
        mappa.put('Type','ACK');
        
        test.startTest();
        
        OF_SA_CD_GE_Utils.create_EAI_Log(mappa);
        
        test.stopTest();
    }

    public static testmethod void MyUnitTest20(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
        
        OF_SA_WS_OM_Classi.AttivazioneGpona_element age = new OF_SA_WS_OM_Classi.AttivazioneGpona_element();
        age.CODICE_OPERATORE='';
        age.CODICE_ORDINE_OLO='';
        age.DATA_NOTIFICA='';
        age.ID_NOTIFICA='';
        age.NOME_REFERENTE_TECNICO_OLO='';
        age.COGNOME_REFERENTE_TECNICO_OLO='';
        age.TELEFONO_REFERENTE_TECNICO_OLO='';
        age.EMAIL_REFERENTE_TECNICO_OLO='';
        age.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH='';
        age.NOME_CLIENTE='';
        age.COGNOME_CLIENTE='';
        age.RECAPITO_TELEFONICO_CLIENTE_1='';
        age.RECAPITO_TELEFONICO_CLIENTE_2='';
        age.INFORMAZIONI_LOGISTICA_APPARATI='';
        age.DATA_PREVISTA_ATTIVAZIONE='';
        age.ORARIO_APPUNTAMENTO='';
        age.CODICE_PROGETTO_SPECIALE='';
        age.PROMOZIONE='';
        age.CLUSTER_PROMOZIONE='';
        age.NOTE='';
        age.ID_BUILDING='';
        age.SCALA_PALAZZINA='';
        age.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
        age.RECAPITO_TEST_LINEA='';
        age.IDENTIFICATIVO_DEL_POP='';
        age.TIPO_COMUNICAZIONE='';
        age.SORGENTE='';
        age.CODICE_ORDINE_OF='';
        age.SLA_DATE='';
        age.GPON_ATTESTAZIONE='';
        age.GPON_VINCOLANTE='';
        age.ID_RISORSA='';
        age.OPZIONE_SYSTEM_UNICO='';
        age.CODICE_MOTIVAZIONE='';
        age.MOTIVAZIONE='';
        age.COLLEGAMENTO_P2P='';
        age.TRACCIATO='';
        age.ID_SERVIZIO='';
        age.PROFILO='';
        age.PROVINCIA='';
        age.COMUNE='';
        age.INDIRIZZO='';
        age.NUMERO_CIVICO='';
        age.PARTICELLA_TOPONOMASTICA='';
        age.SLA_PREMIUM_ASSURANCE='';

        test.starttest();
        OF_SA_CD_GE_Utils.create_EAI_Log(age);
        
        test.stoptest();
    }

    public static testmethod void MyUnitTest21(){
        
        //TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);

        list<EOF_EAI_Service_Log__c> sList = new list<EOF_EAI_Service_Log__c>();
                
        EOF_EAI_Service_Log__c eaiLog3 = new EOF_EAI_Service_Log__c();
        eaiLog3.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        eaiLog3.EOF_Data_Notifica__c = System.now();
        eaiLog3.EOF_ID_Notifica__c ='';
        eaiLog3.EOF_STATO_ORDINE__c ='Acquisito';
        String rType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - CeD - FiberRequest').getRecordTypeId();
        //eaiLog3.recordTypeId = [Select id from RecordType where DeveloperName ='OF_SA_CeD_FiberRequest' LIMIT 1].get(0).id; //eaiLog3.recordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_CeD_FiberRequest'); //EC 2018 - 12 - 13
        eaiLog3.recordTypeId = rType;
        sList.add(eaiLog3);
        
        EOF_EAI_Service_Log__c sl5 = new EOF_EAI_Service_Log__c();
        sl5 = new EOF_EAI_Service_Log__c();
        
        String rType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sl5.recordTypeId = rType1;
        //sl5.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl5.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        sl5.EOF_Data_Notifica__c = System.now();
        sl5.OF_SA_Servizi_Aggiuntivi_Log__c=sl5.id;
        sl5.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl5.OF_SA_NOME_SERVIZIO__c ='Modem';
        sl5.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';        
        
        sList.add(sl5);
        
        EOF_EAI_Service_Log__c sl3 = new EOF_EAI_Service_Log__c();
        String rType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sl3.recordTypeId = rType2;
        //sl3.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Vlan' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Vlan'); 
        sl3.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        sl3.EOF_Data_Notifica__c = System.now();
        sl3.EOF_ID_Notifica__c ='12345';
        sl3.EOF_STATO_ORDINE__c ='Acquisito';
        sl3.OF_SA_VLan_Log__c=sl3.id;
        sl3.EOF_Stato_Richiesta__c='Inserita Portale';
        
        sList.add(sl3);
        
        EOF_EAI_Service_Log__c sl4 = new EOF_EAI_Service_Log__c();
        String rType3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sl4.recordTypeId = rType3;
        //sl4.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Cpe' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Cpe'); 
        sl4.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        sl4.EOF_Data_Notifica__c = System.now();
        sl4.EOF_ID_Notifica__c ='12345';
        sl4.EOF_STATO_ORDINE__c ='Acquisito';
        sl4.OF_SA_Servizi_Aggiuntivi_Log__c=sl4.id;
        sl4.EOF_Stato_Richiesta__c='Inserita Portale';
        sl4.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl4.EOF_Tipo_Comunicazione_String__c='CPE';
        
        sList.add(sl4);
        insert sList;
        
        slist = [Select id, RecordType.developerName, EOF_Codice_Operatore__c, EOF_CODICE_ORDINE_OLO__c,
                EOF_data_NOTIFICA__c, EOF_ID_NOTIFICA__c, EOF_NOME_REFERENTE_TECNICO_OLO__c, EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, EOF_EMAIL_REFERENTE_TECNICO_OLO__c, EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                EOF_NOME_CLIENTE__c, EOF_COGNOME_CLIENTE__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c, EOF_DATA_PREVISTA_ATTIVAZIONE__c, EOF_ORARIO_APPUNTAMENTO__c,
                EOF_CODICE_PROGETTO_SPECIALE__c, EOF_PROMOZIONE__C, EOF_CLUSTER_PROMOZIONE__C, EOF_SCALA_PALAZZINA__C,
                EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C, EOF_RECAPITO_TEST_LINEA__C, EOF_ID_Pop__c, EOF_PROFILO__C,
                EOF_NOTE__c, OF_SA_KIT_CONSEGNA_VLAN__C, OF_SA_USER_VLAN__C, OF_SA_SERVICE_VLAN__C, OF_SA_PROFILO_VLAN__C,
                OF_SA_INFORMAZIONI_VLAN__C, OF_SA_CUSTOMER_VLAN__C, OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,
                EOF_TIPOLOGIA_APPARATO__C, OF_SA_PASSWORD_APPARATO__C, OF_SA_AZIONE_APPARATO__C, OF_SA_ID_APPARATO__c,
                OF_SA_NOME_SERVIZIO__c, OF_SA_INFORMAZIONI_SERVIZIO__c, EOF_ID_Risorsa__c, EOF_Esito_Consegna_Apparato__c
                from EOF_EAI_Service_Log__c];
        
        //Add by PG
        Case c = new Case();
        c.status = 'Acquisito';
        c.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c.EOF_Numero_Civico_WS__c = '12';
        c.EOF_Provincia_WS__c = 'RM';
        c.EOF_Comune_WS__c = 'Roma';
        insert c;
        
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
        
        Asset ax = new Asset();
        ax.name = 'Asset_Test';
        ax.AccountId = acc.Id;
        ax.OF_GPON_Attestazione__c = 'GP';
        ax.OF_IDServizio__c = '001';
        ax.OF_Provincia__c = 'RM';
        ax.OF_Comune__c = 'Roma';
        ax.OF_Particella_Toponomastica__c = 'Via';
        ax.OF_Indirizzo__c = 'Nazionale';
        ax.OF_Civico__c = '12';
        insert ax;
        
        Case c1 = new Case();
        c1.status = 'Acquisito KO';
        c1.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c1.EOF_Numero_Civico_WS__c = '12';
        c1.EOF_Provincia_WS__c = 'RM';
        c1.EOF_Comune_WS__c = 'Roma';
        insert c1;
        
        ax = [Select id, name, OF_GPON_Attestazione__c, OF_IDServizio__c, OF_Provincia__c, OF_Comune__c, OF_Particella_Toponomastica__c,
              OF_Indirizzo__c, OF_Civico__c
              from Asset];

        test.startTest();

        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.slOLOSF.id = eaiLog3.id;
        
        OF_SA_CD_GE_Utils.create_ActivationToOM_Log(c, sList);
        OF_SA_CD_GE_Utils.create_DeactivationToOM_Log(c1, sList, ax);
        
        test.stoptest();
    }
    
    public static testmethod void create_DeactivationToOM_Log_1(){
        
        //TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);

        list<EOF_EAI_Service_Log__c> sList = new list<EOF_EAI_Service_Log__c>();
                
        EOF_EAI_Service_Log__c eaiLog3 = new EOF_EAI_Service_Log__c();
        eaiLog3.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        eaiLog3.EOF_Data_Notifica__c = System.now();
        eaiLog3.EOF_ID_Notifica__c ='';
        eaiLog3.EOF_STATO_ORDINE__c ='Acquisito';
        String rType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - CeD - FiberRequest').getRecordTypeId();
        //eaiLog3.recordTypeId = [Select id from RecordType where DeveloperName ='OF_SA_CeD_FiberRequest' LIMIT 1].get(0).id; //eaiLog3.recordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_CeD_FiberRequest'); //EC 2018 - 12 - 13
        eaiLog3.recordTypeId = rType;
        sList.add(eaiLog3);
        
        EOF_EAI_Service_Log__c sl5 = new EOF_EAI_Service_Log__c();
        sl5 = new EOF_EAI_Service_Log__c();
        
        String rType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sl5.recordTypeId = rType1;
        //sl5.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl5.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        sl5.EOF_Data_Notifica__c = System.now();
        sl5.OF_SA_Servizi_Aggiuntivi_Log__c=sl5.id;
        sl5.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl5.OF_SA_NOME_SERVIZIO__c ='Modem';
        sl5.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';        
        
        sList.add(sl5);
        
        EOF_EAI_Service_Log__c sl3 = new EOF_EAI_Service_Log__c();
        String rType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sl3.recordTypeId = rType2;
        //sl3.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Vlan' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Vlan'); 
        sl3.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        sl3.EOF_Data_Notifica__c = System.now();
        sl3.EOF_ID_Notifica__c ='12345';
        sl3.EOF_STATO_ORDINE__c ='Acquisito';
        sl3.OF_SA_VLan_Log__c=sl3.id;
        sl3.EOF_Stato_Richiesta__c='Inserita Portale';
        
        sList.add(sl3);
        
        EOF_EAI_Service_Log__c sl4 = new EOF_EAI_Service_Log__c();
        String rType3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sl4.recordTypeId = rType3;
        //sl4.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Cpe' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Cpe'); 
        sl4.EOF_Codice_Ordine_OLO__c = 'TEST_X_CD_001';
        sl4.EOF_Data_Notifica__c = System.now();
        sl4.EOF_ID_Notifica__c ='12345';
        sl4.EOF_STATO_ORDINE__c ='Acquisito';
        sl4.OF_SA_Servizi_Aggiuntivi_Log__c=sl4.id;
        sl4.EOF_Stato_Richiesta__c='Inserita Portale';
        sl4.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl4.EOF_Tipo_Comunicazione_String__c='CPE';
        
        sList.add(sl4);
        insert sList;
        
        slist = [Select id, RecordType.developerName, EOF_Codice_Operatore__c, EOF_CODICE_ORDINE_OLO__c,
                EOF_data_NOTIFICA__c, EOF_ID_NOTIFICA__c, EOF_NOME_REFERENTE_TECNICO_OLO__c, EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c, EOF_EMAIL_REFERENTE_TECNICO_OLO__c, EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                EOF_NOME_CLIENTE__c, EOF_COGNOME_CLIENTE__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c, EOF_DATA_PREVISTA_ATTIVAZIONE__c, EOF_ORARIO_APPUNTAMENTO__c,
                EOF_CODICE_PROGETTO_SPECIALE__c, EOF_PROMOZIONE__C, EOF_CLUSTER_PROMOZIONE__C, EOF_SCALA_PALAZZINA__C,
                EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C, EOF_RECAPITO_TEST_LINEA__C, EOF_ID_Pop__c, EOF_PROFILO__C,
                EOF_NOTE__c, OF_SA_KIT_CONSEGNA_VLAN__C, OF_SA_USER_VLAN__C, OF_SA_SERVICE_VLAN__C, OF_SA_PROFILO_VLAN__C,
                OF_SA_INFORMAZIONI_VLAN__C, OF_SA_CUSTOMER_VLAN__C, OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,
                EOF_TIPOLOGIA_APPARATO__C, OF_SA_PASSWORD_APPARATO__C, OF_SA_AZIONE_APPARATO__C, OF_SA_ID_APPARATO__c,
                OF_SA_NOME_SERVIZIO__c, OF_SA_INFORMAZIONI_SERVIZIO__c, EOF_ID_Risorsa__c
                from EOF_EAI_Service_Log__c];
        
        //Add by PG
        Case c = new Case();
        c.status = 'Acquisito';
        c.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c.EOF_Numero_Civico_WS__c = '12';
        c.EOF_Provincia_WS__c = 'RM';
        c.EOF_Comune_WS__c = 'Roma';
        insert c;
        
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
        
        Asset ax = new Asset();
        ax.name = 'Asset_Test';
        ax.AccountId = acc.Id;
        ax.OF_GPON_Attestazione__c = 'GP';
        ax.OF_IDServizio__c = '001';
        ax.OF_Provincia__c = 'RM';
        ax.OF_Comune__c = 'Roma';
        ax.OF_Particella_Toponomastica__c = 'Via';
        ax.OF_Indirizzo__c = 'Nazionale';
        ax.OF_Civico__c = '12';
        insert ax;
        
        Case c1 = new Case();
        c1.status = 'Acquisito';
        c1.EOF_Indirizzo_WS__c = 'Piazza di Spagna';
        c1.EOF_Numero_Civico_WS__c = '12';
        c1.EOF_Provincia_WS__c = 'RM';
        c1.EOF_Comune_WS__c = 'Roma';
        insert c1;
        
        ax = [Select id, name, OF_GPON_Attestazione__c, OF_IDServizio__c, OF_Provincia__c, OF_Comune__c, OF_Particella_Toponomastica__c,
              OF_Indirizzo__c, OF_Civico__c
              from Asset];

        test.startTest();

        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        //OF_SA_CD_GE_Utils.slOLOSF.id = eaiLog3.id;
        
        OF_SA_CD_GE_Utils.create_DeactivationToOM_Log(c1, sList, ax);
        
        test.stoptest();
    }
    
    //giovanni ernetti 17-10-2018 INIZIO
    public static testmethod void MyUnitTest22()
    {
        /*OF_Puntamento_Callout__c cs = new OF_Puntamento_Callout__c();
        cs.Name='OGW';
        cs.OF_OGW__c='OFS-SVIL-WS';
        //cs.Other fiels values
        insert cs;   */      
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_GE_Utils.controlloVendibilita('VF','123');
        test.stopTest();
    }
    //giovanni ernetti 17-10-2018 FINE
    
    //EC start 2018 - 12 - 13
    
    public static testmethod void MyUnitTest23(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
        recordType rtFRSACD = new RecordType();
        rtFRSACD.Name = 'OF_SA_CeD_FiberRequest';
        rtFRSACD.DeveloperName = 'OF_SA_CeD_FiberRequest';
      // insert rtFRSACD;
        
        list<EOF_EAI_Service_Log__c> sList = new list<EOF_EAI_Service_Log__c>();
                
        EOF_EAI_Service_Log__c eaiLog3 = new EOF_EAI_Service_Log__c();
        eaiLog3.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        eaiLog3.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        eaiLog3.EOF_ID_Notifica__c ='';
        eaiLog3.EOF_STATO_ORDINE__c ='Acquisito';
        eaiLog3.recordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_CeD_FiberRequest' LIMIT 1].get(0).id; //eaiLog3.recordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_CeD_FiberRequest'); //EC 2018 - 12 - 13
        
        sList.add(eaiLog3);
        
        EOF_EAI_Service_Log__c sl5 = new EOF_EAI_Service_Log__c();
        sl5 = new EOF_EAI_Service_Log__c();
        sl5.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl5.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl5.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl5.OF_SA_Servizi_Aggiuntivi_Log__c=sl5.id;
        sl5.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl5.OF_SA_NOME_SERVIZIO__c ='Modem';
        sl5.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';        
        
        sList.add(sl5);
        
        EOF_EAI_Service_Log__c sl6 = new EOF_EAI_Service_Log__c();
        sl6 = new EOF_EAI_Service_Log__c();
        sl6.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl6.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl6.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl6.OF_SA_Servizi_Aggiuntivi_Log__c=sl6.id;
        sl6.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl6.OF_SA_NOME_SERVIZIO__c ='Smart TV';
        sl6.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';        
        
        sList.add(sl6);
        
        EOF_EAI_Service_Log__c sl7 = new EOF_EAI_Service_Log__c();
        sl7 = new EOF_EAI_Service_Log__c();
        sl7.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl7.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl7.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl7.OF_SA_Servizi_Aggiuntivi_Log__c=sl7.id;
        sl7.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl7.OF_SA_NOME_SERVIZIO__c ='Ribaltamento Impianto';
        sl7.EOF_Tipo_Comunicazione_String__c='RIBALTAMENTO IMPIANTO';        
        
        sList.add(sl7);
        
        
        EOF_EAI_Service_Log__c sl3 = new EOF_EAI_Service_Log__c();
        sl3.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Vlan' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Vlan'); 
        sl3.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl3.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl3.EOF_ID_Notifica__c ='12345';
        sl3.EOF_STATO_ORDINE__c ='Acquisito';
        sl3.OF_SA_VLan_Log__c=sl3.id;
        sl3.EOF_Stato_Richiesta__c='Inserita Portale';
        
        sList.add(sl3);
        
        EOF_EAI_Service_Log__c sl8 = new EOF_EAI_Service_Log__c();
        sl8.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Vlan' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Vlan'); 
        sl8.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl8.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl8.EOF_ID_Notifica__c ='12345';
        sl8.EOF_STATO_ORDINE__c ='Acquisito';
        sl8.OF_SA_VLan_Log__c=sl8.id;
        sl8.EOF_Stato_Richiesta__c='Inserita Portale';
        
        sList.add(sl8);
        
        EOF_EAI_Service_Log__c sl4 = new EOF_EAI_Service_Log__c();
        sl4.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Cpe' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Cpe'); 
        sl4.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl4.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl4.EOF_ID_Notifica__c ='12345';
        sl4.EOF_STATO_ORDINE__c ='Acquisito';
        sl4.OF_SA_Servizi_Aggiuntivi_Log__c=sl4.id;
        sl4.EOF_Stato_Richiesta__c='Inserita Portale';
        sl4.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl4.EOF_Tipo_Comunicazione_String__c='CPE';
        
        sList.add(sl4);
        
        insert sList;

        test.startTest();

        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.id = eaiLog3.id;
        
        //OF_SA_CD_GE_Utils.create_ActivationToOM_Log(TestDataFactory.c1,sList);        
        //OF_SA_CD_GE_Utils.aggiornaSLPortale(sList,'OM_StatusUpdate');
        // OF_SA_CD_GE_Utils.aggiornaSLPortale(sList,'OM_StatusUpdate');
        test.stoptest();
    }
    
    
     public static testmethod void MyUnitTest24(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD','OF_SA_CeD_FiberRequest', null);
        recordType rtFRSACD = new RecordType();
        rtFRSACD.Name = 'OF_SA_CeD_FiberRequest';
        rtFRSACD.DeveloperName = 'OF_SA_CeD_FiberRequest';
      // insert rtFRSACD;
        
        list<EOF_EAI_Service_Log__c> sList = new list<EOF_EAI_Service_Log__c>();
                
        EOF_EAI_Service_Log__c eaiLog3 = new EOF_EAI_Service_Log__c();
        eaiLog3.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        eaiLog3.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        eaiLog3.EOF_ID_Notifica__c ='';
        eaiLog3.EOF_STATO_ORDINE__c ='Acquisito';
        eaiLog3.recordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_CeD_FiberRequest' LIMIT 1].get(0).id; //eaiLog3.recordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_SA_CeD_FiberRequest'); //EC 2018 - 12 - 13
        
        sList.add(eaiLog3);
        
        EOF_EAI_Service_Log__c sl5 = new EOF_EAI_Service_Log__c();
        sl5 = new EOF_EAI_Service_Log__c();
        sl5.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl5.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl5.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl5.OF_SA_Servizi_Aggiuntivi_Log__c=sl5.id;
        sl5.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl5.OF_SA_NOME_SERVIZIO__c ='Modem';
        sl5.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';        
        
        sList.add(sl5);
        
        EOF_EAI_Service_Log__c sl6 = new EOF_EAI_Service_Log__c();
        sl6 = new EOF_EAI_Service_Log__c();
        sl6.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl6.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl6.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl6.OF_SA_Servizi_Aggiuntivi_Log__c=sl6.id;
        sl6.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl6.OF_SA_NOME_SERVIZIO__c ='Smart TV';
        sl6.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';        
        
        sList.add(sl6);
        
        EOF_EAI_Service_Log__c sl7 = new EOF_EAI_Service_Log__c();
        sl7 = new EOF_EAI_Service_Log__c();
        sl7.recordtypeId= [Select id from RecordType where DeveloperName ='OF_SA_Servizi_Aggiuntivi' LIMIT 1].get(0).id;// OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
        sl7.EOF_Codice_Ordine_OLO__c =testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl7.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl7.OF_SA_Servizi_Aggiuntivi_Log__c=sl7.id;
        sl7.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl7.OF_SA_NOME_SERVIZIO__c ='Ribaltamento Impianto';
        sl7.EOF_Tipo_Comunicazione_String__c='RIBALTAMENTO IMPIANTO';        
        
        sList.add(sl7);
        
        
        EOF_EAI_Service_Log__c sl3 = new EOF_EAI_Service_Log__c();
        sl3.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Vlan' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Vlan'); 
        sl3.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl3.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl3.EOF_ID_Notifica__c ='12345';
        sl3.EOF_STATO_ORDINE__c ='Acquisito';
        sl3.OF_SA_VLan_Log__c=sl3.id;
        sl3.EOF_Stato_Richiesta__c='Inserita Portale';
        
        sList.add(sl3);
        
        EOF_EAI_Service_Log__c sl8 = new EOF_EAI_Service_Log__c();
        sl8.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Vlan' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Vlan'); 
        sl8.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl8.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl8.EOF_ID_Notifica__c ='12345';
        sl8.EOF_STATO_ORDINE__c ='Acquisito';
        sl8.OF_SA_VLan_Log__c=sl8.id;
        sl8.EOF_Stato_Richiesta__c='Inserita Portale';
        
        sList.add(sl8);
        
        EOF_EAI_Service_Log__c sl4 = new EOF_EAI_Service_Log__c();
        sl4.RecordTypeId=[Select id from RecordType where DeveloperName ='OF_SA_Cpe' LIMIT 1].get(0).id;//OF_SA_CD_GE_Utils.rtMap.get('OF_SA_Cpe'); 
        sl4.EOF_Codice_Ordine_OLO__c = testdatafactory.cList[0].EOF_Codice_Ordine_OLO__c;
        sl4.EOF_Data_Notifica__c= testdatafactory.cList[0].EOF_Data_Notifica__c;
        sl4.EOF_ID_Notifica__c ='12345';
        sl4.EOF_STATO_ORDINE__c ='Acquisito';
        sl4.OF_SA_Servizi_Aggiuntivi_Log__c=sl4.id;
        sl4.EOF_Stato_Richiesta__c='Inserita Portale';
        sl4.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        sl4.EOF_Tipo_Comunicazione_String__c='CPE';
        
        //sList.add(sl4);
        
        insert sl4 ;

        test.startTest();

        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.id = eaiLog3.id;
        
        Date dt = system.today();
        OF_SA_CD_GE_Utils.dateToStringNoTime(dt);        
        OF_SA_CD_GE_Utils.copy_notify_AcqCessNew (sl4);
        OF_SA_CD_GE_Utils.slOLOSF = sl4;  
        OF_SA_CD_GE_Utils.slOLOSFResp= sl4;
        OF_SA_CD_GE_Utils.slSFOLO= sl4;
        OF_SA_CD_GE_Utils.slSFOLOResp= sl4;
        OF_SA_CD_GE_Utils.slSFOM= sl4;
        OF_SA_CD_GE_Utils.slSFOMResp= sl4;
        OF_SA_CD_GE_Utils.slOMSF= sl4;
        
        OF_SA_CD_GE_Utils.ListSlActivationOLOSF= sList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF= sList;
        OF_SA_CD_GE_Utils.ListSlActivationSFOM= sList;
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM= sList;
        OF_SA_CD_GE_Utils.ListSlCompletionOrderOMSF= sList;
        OF_SA_CD_GE_Utils.ListSlCompletionOrderSFOLO= sList;
        OF_SA_CD_GE_Utils.ListSlStatusUpdateOMSF= sList;
        OF_SA_CD_GE_Utils.ListSlStatusUpdateSFOLO = sList;
        
        OF_SA_CD_GE_Utils.Response= 'Test';
        OF_SA_CD_GE_Utils.RespCompletionOrder= 'Test';
        List<case> csList = new List<case>();
        case c = new case();
        csList.add(c);
        OF_SA_CD_GE_Utils.caseOriginale= c;
        Account ac = new Account();
        OF_SA_CD_GE_Utils.cliente= ac;
        Contact con = new Contact();
        OF_SA_CD_GE_Utils.RefTec= con;
        
        OF_SA_CD_GE_Utils.ListVLan= sList;
        OF_SA_CD_GE_Utils.ListApp= sList;
        OF_SA_CD_GE_Utils.ListServAgg= sList;
        OF_SA_CD_GE_Utils.ListVLanToOM= sList;
        OF_SA_CD_GE_Utils.ListAppToOM= sList;
        OF_SA_CD_GE_Utils.ListServAggToOM= sList;
        
        List<OF_CommercialElementIstanziato__c> comm = new List<OF_CommercialElementIstanziato__c>();
        OF_SA_CD_GE_Utils.ceiList= comm;
        
        Asset ass = new Asset();
        OF_SA_CD_GE_Utils.a =ass;
        OF_SA_CD_GE_Utils.processo = 'Test';
        
        OF_SA_CD_GE_Utils.ListCaseAmmToUpdate = csList;
        
        OF_Generatore_ID_Servizio__c gen1 = new OF_Generatore_ID_Servizio__c();
        OF_SA_CD_GE_Utils.gen= gen1;
        
        TEMPLOG__c temp = new TEMPLOG__c();
        OF_SA_CD_GE_Utils.tmpl=temp;
        
        OF_SA_CD_GE_Utils.OpName='Test';
        OF_SA_CD_GE_Utils.AttrTime = 123.3;
        //OF_SA_CD_GE_Utils.makeCalloutOLOOM(sl4);
        //OF_SA_CD_GE_Utils.makeCalloutOM(sList);
        test.stoptest();
    }
    public static TestMethod Void MyUnitTest25(){
      
      TestDataFactory.CreateTestRecords(null,null,null);
        
        Test.startTest();
        // --- Account Creation-----
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF SP Caso Attivazione CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = 'test12';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
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
        c.PO_SA_Portale__C=false;
        insert c; 
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        EOF_EAI_Service_Log__c eof =  new EOF_EAI_Service_Log__c( );
        eof.EOF_Tipo_Comunicazione_String__C ='SF->OLO - StatusUpdate';
        eof.EOF_CODICE_OPERATORE__c = 'test1';
        eof.EOF_CODICE_ORDINE_OLO__c = 'test1';
        eof.EOF_CODICE_ORDINE_EOF__c = 'test1';
        //  eof.EOF_DATA_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof.EOF_STATO_ORDINE__c = 'test1';
        eof.EOF_CODICE_MOTIVAZIONE__c = 'test1';
        eof.EOF_MOTIVAZIONE__c = 'test1';
        eof.EOF_GPON_Attestazione__c = 'test1';
        eof.EOF_NOME_CLIENTE__c = 'test1';
        eof.EOF_COGNOME_CLIENTE__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1';
        eof.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.Today();
        eof.EOF_ORARIO_APPUNTAMENTO__c = 'test1';
        eof.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1';
        eof.EOF_NOTE__c = 'test1';
        eof.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1';
        eof.EOF_EMAIL_REFERENTE_TECNICO_OLO__c  = 'test1';
        eof.EOF_TIPO_COMUNICAZIONE__c = 'test1';
        eof.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = 'test1';
        eof.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1';
        eof.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1';
        eof.EOF_ID_Case_Temp__c = c.Id;
        eof.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1';
        eof.EOF_PROMOZIONE__c = 'test1';
        eof.EOF_CLUSTER_PROMOZIONE__c = 'test1';
        eof.EOF_ID_BUILDING__c = 'test1';
        eof.EOF_SCALA_PALAZZINA__c = 'test1';
        eof.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1';
        eof.EOF_RECAPITO_TEST_LINEA__c = 'test1';
        eof.EOF_ID_POP__c = 'test1';
        eof.EOF_PROFILO__c = 'test1' ; 
        
        EOF_EAI_Service_Log__c eof1 =  new EOF_EAI_Service_Log__c( );
         eof1.EOF_Tipo_Comunicazione_String__C ='CPE';
        eof1.EOF_CODICE_OPERATORE__c = 'test1' ;
        eof1.EOF_CODICE_ORDINE_OLO__c  = 'test1' ;            
        eof1.EOF_CODICE_ORDINE_EOF__c = 'test1' ;
        eof1.EOF_DATA_NOTIFICA__c = System.today();
        eof1.EOF_ID_NOTIFICA__c = String.valueof(datetime.now());
        eof1.EOF_STATO_ORDINE__c = 'test1' ; 
        eof1.EOF_CODICE_MOTIVAZIONE__c = 'test1' ;
        eof1.EOF_MOTIVAZIONE__c = 'test1' ;
        eof1.EOF_NOME_CLIENTE__c = 'test1' ;
        eof1.EOF_COGNOME_CLIENTE__c  = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE__c = 'test1' ;
        eof1.EOF_DATA_PREVISTA_ATTIVAZIONE__c  = System.today();
        eof1.EOF_ORARIO_APPUNTAMENTO__c = 'test1' ; 
        eof1.EOF_PIN_INTERVENTO_A_VUOTO__c = 'test1' ;
        eof1.EOF_NOTE__c = 'test1' ;
        eof1.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_COGNOME_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'test1' ;
        eof1.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c  = 'test1' ;
        eof1.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = 'test1' ;
        eof1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'test1' ;
        eof1.EOF_CODICE_PROGETTO_SPECIALE__c = 'test1' ;
        eof1.EOF_PROMOZIONE__c = 'test1' ;
        eof1.EOF_CLUSTER_PROMOZIONE__c = 'test1' ;
        eof1.EOF_ID_BUILDING__c = 'test1' ;
        eof1.EOF_SCALA_PALAZZINA__c = 'test1' ;
        eof1.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c = 'test1' ;
        eof1.EOF_RECAPITO_TEST_LINEA__c = 'test1' ;
        eof1.EOF_ID_POP__c = 'test1' ;
        eof1.EOF_PROFILO__c = 'test1' ;
        eof1.EOF_SORGENTE__c = 'test1' ; 
        eof1.EOF_SLA_DATE__c = 'test1' ;
        eof1.EOF_GPON_ATTESTAZIONE__c = 'test1' ;
        eof1.EOF_GPON_VINCOLANTE__c = 'test1' ;
        eof1.EOF_ID_RISORSA__c = 'test1' ;
        eof1.EOF_OPZIONE_SYSTEM_UNICO__c = 'test1' ;
        eof1.EOF_TIPO_COMUNICAZIONE__c = 'test1' ;
        eof1.EOF_COLLEGAMENTO_P2P__c = 'test1' ;
        eof1.EOF_TRACCIATO__c = 'test1' ;
        eof1.EOF_ID_SERVIZIO__c = 'test1' ; 
        eof1.EOF_PROVINCIA__c = 'test1' ; 
        eof1.EOF_COMUNE__c = 'test1' ;
        eof1.EOF_INDIRIZZO__c = 'test1' ;
        eof1.EOF_NUMERO_CIVICO__c = 'test1' ;
        eof1.EOF_PARTICELLA_TOPONOMASTICA__c = 'test1' ;
        eof1.EOF_SLA_PREMIUM_ASSURANCE__c = 'test1' ;
        eof1.EOF_ID_Case_Temp__c = c.Id ;
        eof1.EOF_Tipo_Comunicazione_String__c = 'test1' ;
        //EOF_ID_Case_Temp__c
        
        
        String eofStr;
        String eofStr1;
        try
        {
            insert eof;
            insert eof1;
            eofStr = String.valueOf(eof.Id);
            eofStr1 = String.valueOf(eof1.Id);
            
            List<EOF_EAI_Service_Log__c> eoflst = new List<EOF_EAI_Service_Log__c>();
            eoflst.add(eof);
            //OF_SA_CD_GE_Utils.aggiornamentoDatiEspletamento('c.id','eof.id','eof.id');
            /**Step1**/
            Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test());
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(eof);
            OF_SA_CD_GE_Utils.makeCalloutOM(eoflst);
            
           /* eof1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - Deactivation' ;
            update eof1;
            String eofStr01 = String.valueOf(eof1.Id);
            OF_SA_CD_GE_Utils.makeCalloutOLOOM(eof);*/
                      
          Test.stopTest();

            
        }
        catch(exception e){
            system.debug('error message----->'+e.getStackTraceString());
        }  
    }
    
    
    
    public static Account accountCreation()
    {
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
        
        return acc;
    }
    
    public static Account accountOFCreation()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'OpenFiber';
        acc.Type = 'OLO';
        acc.EOF_Codice_Operatore__c = 'OF';
        acc.RecordTYpeId = AccountRecordTypeId ;
        insert acc;
        return acc;
    }

    public static Account account_OLO_Creation()
    {
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
        
        return accOLO;
    }
    
    public static Case caseActivationCreation(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
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
        c.AssetId = asset_t.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ord.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
        
        return c;
    }
    
    public static Case caseActivationCreation1(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.EOF_ID_Risorsa__c = 'IDR1234';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_t.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ord.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
        
        return c;
    }
     
    public static Case caseActivationCreation2(Account acc, Account accOLO, Asset asset_t,order ord)
    {
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF SP Caso Cessazione CeD').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.EOF_ID_Risorsa__c = 'IDR1234';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_t.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ord.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
        
        return c;
    }
    
   
    public static Order orderCreation(Asset asset_t, Account acc)
    {
        Order ordine = new Order();
        //ordine.OF_CaseID__c = c.id;
        ordine.OF_Asset__c = asset_t.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        return ordine;
    }

    public static Asset assetCreation(Account acc, String contractId){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contractId;
        insert asset_1;

        return asset_1;
    }

    public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
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
    
    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
       
        insert servizio;
        return servizio;
    }
    
    public static OF_Servizio__c Servizio_Creation1(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        //contratto.EndDate = System.today();
        insert contratto;
        return contratto;
    }
    
    public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO OPEN STREAM BASE';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    }  
    
    public static OF_BillingElement__c createContributoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo Attivazione';
        be.OF_CommercialElement__c = ce.id;
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        be.OF_Attivo__c = true;
        be.OF_DataInizioValidita__c = inizio;
        be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c = contr.Id;
        conServ.OF_Servizio__c = serv.id;
        
        insert conServ;      
        return conServ;
    }
    
    public static OF_BillingElement__c createContributoStornoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo di disattivazione';
        be.OF_CommercialElement__c = ce.id;
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        be.OF_Attivo__c = true;
        be.OF_DataInizioValidita__c = inizio;
        be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }

   public static OF_CommercialElementIstanziato__c  CEI_Creation(Asset assetStd,OF_CommercialElement__c CE)
   {
        OF_CommercialElementIstanziato__c CEI = new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        CEI.OF_Asset__c=assetStd.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=CE.id;
        CEI.OF_CPE__c = CEI.Id;
        insert CEI;
        return CEI;
    }
    
   //slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
  
   /*public static testMethod void test_OLO_AsyncActivation1(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        
         String slId = slFiberReq.id;
        slFiberReq.Caso__c = c.id;
        slFiberReq.Id = slId;
        insert slFiberReq;
        
         List<EOF_EAI_Service_Log__c> ListSlOrig = new List<EOF_EAI_Service_Log__c>();
        ListSlOrig.add(slFiberReq);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
       
        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = c;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = null;
        
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
        OF_SA_CD_GE_Utils.cliente = acc;
        
        OF_SA_CD_GE_Utils.refTec = new contact();

        
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
    //  slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Vlan');
    
     public static testMethod void test_OLO_AsyncActivation2(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Vlan');
        
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        Test.startTest();
         
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
    //  slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Cpe');
    
     public static testMethod void test_OLO_AsyncActivation3(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Cpe');
        
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 107;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        BusinessHours bh = [SELECT Id 
                                FROM BusinessHours 
                                WHERE IsDefault=true];
        
        //bh.isWithin('businessHoursId', system.now());         
        boolean isWithin = false;
        
        Test.startTest();
         
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c ='TIS_20170403_000000061';
         
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
    public static testMethod void test_OLO_AsyncActivation4(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Comune__c = 'Test';
        insert Ele;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
       // List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
      //  EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
       
        
       List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListServAgg = EOFList;
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
      public static testMethod void test_OLO_AsyncActivation5(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        //String AccountRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF SA Servizi Aggiuntivi').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 106;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Comune__c = 'Test';
        insert Ele;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation1(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        OF_ContrattoServizio__c conServ = createContrattoServizio(contratto,servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
          
        List<OF_ContrattoServizio__c> listcheckCDContract = new  List<OF_ContrattoServizio__c>();
        listcheckCDContract.add( conServ);

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
        //List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
       // EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
      
          
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
          
         OF_SA_CD_GE_Utils.ListServAgg = EOFList;
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
     public static testMethod void test_OLO_AsyncActivation6(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
       
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        //Ele.OF_CodiceIstat__c = Ele.Id;
        Ele.OF_Provincia__c = 'Test';
        Ele.OF_CodiceIstat__c = 'Test';
        insert Ele;
         
         OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 101;
        insert corretto;
         
        List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
        cList.add(Ele);
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation1(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        OF_ContrattoServizio__c conServ = createContrattoServizio(contratto,servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
          
        List<OF_ContrattoServizio__c> listcheckCDContract = new  List<OF_ContrattoServizio__c>();
        listcheckCDContract.add( conServ);
         
         BusinessHours bh = [SELECT Id 
                                FROM BusinessHours 
                                WHERE IsDefault=true];
        
        //bh.isWithin('businessHoursId', system.now());         
        boolean isWithin = false;

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
       // List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
       // EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
         
        OF_SA_CD_GE_Utils.ListServAgg = EOFList;

        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
     public static testMethod void test_OLO_AsyncActivation7(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - Cpe');
        
        insert slFiberReq;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 105;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Comune__c = 'Test';
        insert Ele;
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
         
         List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } 
    
      public static testMethod void test_OLO_AsyncActivation8(){
        
        List<RecordType> Casertypes = [Select Name, Id From RecordType 
                  where sObjectType='Case' and isActive=true];
        
        Map<String,String> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: Casertypes)
         CaseRecordTypes.put(rt.Name,rt.Id);
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                  where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> EOFServiceRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        EOFServiceRecordTypes.put(rt.Name,rt.Id);
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c ='VF';
        slFiberReq.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        slFiberReq.RecordTypeId = EOFServiceRecordTypes.get('OF - SA - CeD - FiberRequest');
        slFiberReq.EOF_NOME_CLIENTE__C = 'Test';
        insert slFiberReq;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        corretto.OF_SA_Comune__c = 'Test';
        corretto.OF_SA_Stato_Building__c = 101;
        insert corretto;
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
        Ele.OF_CodiceIstat__c = 'Test';
        Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        Contract contratto = createContract(acc);
        Asset asset_1 = assetCreation(acc,contratto.id);
        OF_Asset_Verticale__c va = assetVerticaleCreation(asset_1);
        Order ordine = orderCreation(va,asset_1,acc);
        Case c = caseActivationCreation(acc,accOLO,asset_1,ordine);
        OF_CatalogoCommerciale__c catalogo = Catalogo_Creation();
        OF_Servizio__c servizio = Servizio_Creation1(catalogo);
        OF_CommercialElement__c ce = CE_Creation(servizio);
        OF_ContrattoServizio__c conServ = createContrattoServizio(contratto,servizio);
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.OF_Olo_Id__c = acc.Id;
        oloId.Name = 'VF';
        insert oloId;
          
        List<OF_ContrattoServizio__c> listcheckCDContract = new  List<OF_ContrattoServizio__c>();
        listcheckCDContract.add( conServ);
          
        OF_Generatore_ID_Servizio__c GenServizio = new OF_Generatore_ID_Servizio__c();
        GenServizio.OF_Case_Id__c = c.id;
        insert GenServizio;

        Test.startTest();
       
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_CD_GE_Utils.caseOriginale = new Case();
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c = 'VF';
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c= acc.Id;
        
        OF_SA_CD_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        //OF_SA_CD_GE_Utils.caseOriginale.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('EOF Caso Attivazione OPENSTREAM CeD');
        
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Account_OLO__c = acc.Id;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c = system.today() - 5;
        OF_SA_CD_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c = system.today() + 5;
        OF_SA_CD_GE_Utils.caseOriginale.Id = c.Id;
          
       OF_SA_CD_GE_Utils.gen = GenServizio;
          
          
        OF_SA_CD_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        OF_SA_CD_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C = 'Test';
        
        OF_SA_CD_GE_Utils.processo = 'passivo';
        OF_SA_CD_GE_Utils.checkServAgg=true;
        
       // List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
       // EOFList.add(slFiberReq);
        
       // OF_SA_CD_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
       // OF_SA_CD_GE_Utils.ListServAgg.add(slFiberReq);
         
        List<EOF_EAI_Service_Log__c> EOFList = new List<EOF_EAI_Service_Log__c>();
        EOFList.add(slFiberReq);
         
        OF_SA_CD_GE_Utils.ListServAgg = EOFList;

        
        OF_SA_CD_GE_Utils.ListSlDeactivationSFOM = EOFList;
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF = EOFList;
        OF_SA_CD_GE_Utils.a = asset_1;
        OF_SA_CD_GE_Utils.caseOriginale = c;
        
        OF_SA_CD_GE_Utils.slSFOM = new EOF_EAI_Service_Log__c();
        OF_SA_CD_GE_Utils.slSFOM.OF_SA_ACK__c=true;
        
        List<EOF_EAI_Service_Log__C> sList = new List<EOF_EAI_Service_Log__C>();
        sList.add(slFiberReq);
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id,slFiberReq.Id);
       
        Test.stopTest();
    } */
    //AA - 13/12/18 - TestMethod OLO_AsyncActivation
    public static testMethod void test_OLO_AsyncActivation(){
        //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                          FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                                         WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
            ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
            ceServAgg.Name = 'Estensione Impianto Cliente';
            ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
            EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
            EOF_ID_Pop__c = 'RMAPA',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
        insert c;
        //Lego il log al case
        sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
        EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
        Test.stopTest();
    }
    //FINE AA - 13/12/18
    public static testMethod void test_OLO_AsyncActivation1(){
        //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                          FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                                         WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
            corretto.OF_SA_Pop__c ='test';
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
            ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
            ceServAgg.Name = 'Estensione Impianto Cliente';
            ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
           // EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
            EOF_ID_Pop__c = 'RMAPA',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_SP_Caso_Attivazione_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
            c.OF_Bonifica_Locked_Row__c=true;
        insert c;
        //Lego il log al case
        sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
        EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
        Test.stopTest();
    }
    
    public static testMethod void test_OLO_AsyncActivation2(){
        //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                          FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                                         WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
            corretto.OF_SA_Pop__c ='test';
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
            ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
            ceServAgg.Name = 'Estensione Impianto Cliente';
            ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
            EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
            EOF_ID_Pop__c = 'RMAPA',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
            c.OF_Bonifica_Locked_Row__c=true;
        insert c;
        //Lego il log al case
        sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
        EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
        Test.stopTest();
    }
    
    public static testMethod void test_OLO_AsyncActivation3(){
       //Recupero tutti i recordType dei case
        List<RecordType> casesLstRType = [SELECT developername, Id 
                                          FROM RecordType 
                                          WHERE sObjectType = 'Case' 
                                          AND isActive = true];
        //Popolo una map con tutti i recordType dei case avente come key il developername e come Value l'id
        Map<String,String> casesRType = new Map<String,String>();
        for(RecordType rt : casesLstRType){
            casesRType.put(rt.developername, rt.Id);
        }
        //Recupero tutti i recordType dei serviceLog
        List<RecordType> sLogLstRType = [SELECT developername, Id 
                                         FROM RecordType 
                                         WHERE sObjectType = 'EOF_EAI_Service_Log__c' 
                                         AND isActive = true];
        //Popolo una map con tutti i recordType dei serviceLog avente come key il developername e come Value l'id
        Map<String,String> sLogRType = new Map<String,String>();
        for(RecordType rt : sLogLstRType){
            sLogRType.put(rt.developername, rt.Id);
        }
        
        OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
            Ele.OF_CodiceIstat__c = 'Test';
            Ele.OF_Provincia__c = 'Test';
        insert Ele;
        
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
            corretto.OF_SA_Comune__c = 'Test';
            corretto.OF_SA_Stato_Building__c = 101;
            corretto.OF_SA_Pop__c ='test';
        insert corretto;
        //Inserisco il commercialElement del servizio aggiuntivo
        OF_CommercialElement__c ceServAgg = new OF_CommercialElement__c();
            ceServAgg.OF_Servizio__c = Servizio_Creation(Catalogo_Creation()).Id;
            ceServAgg.Name = 'Estensione Impianto Cliente';
            ceServAgg.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
            ceServAgg.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
        insert ceServAgg;
        //Account acc = accountCreation();
        Account accOLO = account_OLO_Creation();
        OLO_ID__c oloId = new OLO_ID__c();
            oloId.OF_Olo_Id__c = accOLO.Id;
            oloId.Name = 'VF';
        insert oloId;
        //Creo il log di attivazione
        EOF_EAI_Service_Log__c sLogOLOSF = new EOF_EAI_Service_Log__c(
            RecordTypeId = sLogRType.get('OF_SA_CeD_FiberRequest'),
            OF_SA_Direzione_Flusso__c = 'OLO-SF',
            OF_SA_Metodo__c = 'OLO_ActivationSetup_OpenStream',
            EOF_Tipo_COmunicazione_String__c = 'OLO->SF - ActivationRequest',
            EOF_CODICE_OPERATORE__C = 'VF',
            EOF_CODICE_ORDINE_OLO__C = 'TEST_Act_'+String.valueOf(system.now()).right(8),
            EOF_DATA_NOTIFICA__C = OF_SA_CD_GE_Utils.StringTODate(String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00'), 
            EOF_ID_NOTIFICA__C = String.valueOf(System.now().getTime()),
            EOF_NOME_REFERENTE_TECNICO_OLO__C = 'Nome',
            EOF_COGNOME_REFERENTE_TECNICO_OLO__C = 'Cognome',
            EOF_TELEFONO_REFERENTE_TECNICO_OLO__C = '1234',
            EOF_EMAIL_REFERENTE_TECNICO_OLO__C = 'aaa@aa.com',
            EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__C = '123456',
           // EOF_NOME_CLIENTE__C = 'Nome',
            EOF_COGNOME_CLIENTE__C = 'Cognome',
            EOF_RECAPITO_TELEFONICO_CLIENTE_1__C = '12324',
            EOF_RECAPITO_TELEFONICO_CLIENTE_2__C = '312312',
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__C = 'test',
            EOF_ORARIO_APPUNTAMENTO__C = '16:30:00',
            EOF_CODICE_PROGETTO_SPECIALE__c = '12',
            EOF_PROMOZIONE__C = '123',
            EOF_CLUSTER_PROMOZIONE__C = '123',
            EOF_ID_BUILDING__C = '12_058_058005_8000612172_31',
            EOF_SCALA_PALAZZINA__C = '',
            EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C='12323',
            EOF_RECAPITO_TEST_LINEA__C = '123123',
           // EOF_ID_Pop__c = 'test',
            EOF_PROFILO__C = '45',
            EOF_Note__c = 'asdf',
            EOF_DATA_PREVISTA_ATTIVAZIONE__C = OF_SA_CD_GE_Utils.StringTODateNoTime('2018-12-24')
        );
        
        //Creo il case di attivazione
        Case c = new Case(); 
            c.RecordTypeId = casesRType.get('EOF_SP_Caso_Attivazione_CeD');
            c.EOF_Codice_Ordine_Olo__c = sLogOLOSF.EOF_CODICE_ORDINE_OLO__C;
            c.EOF_Codice_Operatore_WS__c = sLogOLOSF.EOF_CODICE_OPERATORE__C;           
            c.EOF_Data_Notifica__c = sLogOLOSF.EOF_DATA_NOTIFICA__C;
            c.EOF_Id_Notifica__c = sLogOLOSF.EOF_ID_NOTIFICA__C;                
            c.EOF_Data_Prevista_Attivazione__c = sLogOLOSF.EOF_DATA_PREVISTA_ATTIVAZIONE__C;
            c.EOF_Identificativo_del_POP__c= sLogOLOSF.EOF_ID_Pop__c;
            c.EOF_ID_Building_WS__c = sLogOLOSF.EOF_ID_BUILDING__C;
            c.subject = 'Richiesta Attivazione';
            c.status = 'Inviato';
            c.EOF_FASE__C = 'NA';
            c.PO_SA_Portale__c = false;
            c.OF_Bonifica_Locked_Row__c=true;
        insert c;
        //Lego il log al case
        sLogOLOSF.Caso__c = c.Id;
        //Inserisco il log
        insert sLogOLOSF;
        //Inserisco le VLAN, Apparati e Serv.Aggiuntivi
        List<EOF_EAI_Service_Log__C> sLogList = new List<EOF_EAI_Service_Log__C>();
        Integer n = 1;
        //VLAN
        EOF_EAI_Service_Log__C vlan1 = new EOF_EAI_Service_Log__C();
            vlan1.recordtypeid = sLogRType.get('OF_SA_Vlan');
            vlan1.OF_SA_KIT_CONSEGNA_VLAN__C = 'TIS_MI_1';
            vlan1.OF_SA_USER_VLAN__C = '835';
            vlan1.OF_SA_SERVICE_VLAN__C = '100';
            vlan1.OF_SA_PROFILO_VLAN__C = 'AG11';
            vlan1.OF_SA_INFORMAZIONI_VLAN__C = '';
            vlan1.OF_SA_CUSTOMER_VLAN__C = '156';
            vlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__C = '1:1';
            vlan1.OF_SA_VLan_Log__c = sLogOLOSF.id;
            vlan1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(vlan1);
        n++;
        //Apparato
        EOF_EAI_Service_Log__C app1 = new EOF_EAI_Service_Log__C();
            app1.recordtypeid = sLogRType.get('OF_SA_Cpe');
            app1.EOF_TIPOLOGIA_APPARATO__C = 'SmartTV';
            app1.OF_SA_PASSWORD_APPARATO__C = '123';
            app1.OF_SA_AZIONE_APPARATO__C = '0';
            app1.OF_SA_Cpe_Log__c = sLogOLOSF.id;
            app1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(app1);
        n++;
        //Servizio Aggiuntivo
       /* EOF_EAI_Service_Log__C servAgg1 = new EOF_EAI_Service_Log__C();
            servAgg1.recordtypeid = sLogRType.get('OF_SA_Servizi_Aggiuntivi');
            servAgg1.OF_SA_NOME_SERVIZIO__c = 'Estensione Impianto Cliente';
            servAgg1.OF_SA_INFORMAZIONI_SERVIZIO__c = '0';
            servAgg1.OF_SA_servizi_Aggiuntivi_Log__c = sLogOLOSF.id;
            servAgg1.EOF_Ordine_Invio_OLO__c = n;
        sLogList.add(servAgg1);*/
        //Inserisco la lista
        insert sLogList;
        //Inserisco l'id_servizio
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=c.Id;
        insert g;
        //Inizia lo scope del test
        Test.startTest();
        //Setto il mock
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncActivation(c.Id, sLogOLOSF.Id);
        //Finisce lo scope del test
        Test.stopTest();
    }

    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_1(){
        
         Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
         Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
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
        
        Asset ass = new Asset();
        ass.Status = 'Cessato';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;        
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
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
        servizio.Name = 'Open Stream CD';
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
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();}
    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_2(){
        
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        // Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
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
        servizio.Name = 'Open Stream CD';
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
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }
    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_3(){
        
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
         Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
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
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id; 
        ser.OF_SA_VLan_Log__c=ser.id;
        insert ser;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
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
        servizio.Name = 'Open Stream CD';
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
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }
    
    public static testMethod void test_OLO_AsyncChangeOrder_Method_4(){
        
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
         Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
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
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id; 
        //ser.OF_SA_VLan_Log__c=ser.id;
        insert ser;
        
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=parentCase.Id; 
        ser2.OF_SA_VLan_Log__c=ser.id;
        insert ser2;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
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
        servizio.Name = 'Open Stream CD';
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
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }
    
    /*
    public static testMethod void test_OLO_AsyncChangeOrder_Method_5(){
        
        //Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream CeD').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        createVerticaliCustomSetting();
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                                   where sObjectType='Order' and isActive=true];
        
        Map<String,Id> OrderRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        {
            system.debug('listofordertypes:'+rtypes);
            OrderRecordTypes.put(rt.Name,rt.Id);
           // OF_CO_GE_Utils.RtMap.put(rt.Name,rt.Id);
        }
         OF_CO_GE_Utils.RtMap=OrderRecordTypes;
         
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        List<RecordType> rtypes1 = [Select Name, Id From RecordType 
                                   where sObjectType='Case' and isActive=true];
        
        Map<String,Id> CaseRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes1)
        {
            system.debug('listofordertypes:'+rtypes);
            CaseRecordTypes.put(rt.Name,rt.Id);
           // OF_CO_GE_Utils.RtMap.put(rt.Name,rt.Id);
        }
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = 'test1';
        parentCase.RecordtypeId = CaseRecordTypes.get('EOF Caso Cessazione OPENSTREAM CD');
        parentCase.OF_Response_Da_OLO__c = 'ack';
        parentCase.PO_SA_Portale__c = false;
	    parentCase.OF_SA_Profilo__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        insert parentCase;  
         
        system.debug('checking case:'+parentCase);
        
        Asset ass = new Asset();
        ass.Status = 'Sospeso';
        ass.name = 'test1';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
       
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id; 
        //ser.OF_SA_VLan_Log__c=ser.id;
        insert ser;
        
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=parentCase.Id; 
        ser2.OF_SA_Cpe_Log__c=ser.id;
        insert ser2;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
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
        servizio.Name = 'Open Stream CD';
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
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = parentCase.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(parentCase, notify);
        //OF_SA_CD_GE_Utils.slSFOLOResp=ser;
        //OF_SA_CD_GE_Utils.slSFOLO=ser;
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        OF_SA_CD_OLO_AsyncChecks olo1 = new OF_SA_CD_OLO_AsyncChecks();
        
        OF_SA_CD_OLO_AsyncChecks.OLO_AsyncChangeOrder(parentCase.Id, ser.id);
        
        Test.StopTest();
    }
    */
}
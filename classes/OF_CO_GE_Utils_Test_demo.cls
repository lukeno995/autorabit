/*
-------------------------------------------------------------------------------------------------------
Author : Sasya  Date : 29-05-2018  Description: Test code coverage for OF_CO_GE_Utils controller
-------------------------------------------------------------------------------------------------------
*/
@isTest
public class OF_CO_GE_Utils_Test_demo  {
    
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
        elog11.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        elog11.EOF_Stato_Richiesta__c='Inserita Portale';
         insert elog11;
        EOF_EAI_Service_Log__c elog2 = new  EOF_EAI_Service_Log__c();
        elog2.Caso__c = elog.Caso__c;
        elog2.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog2.EOF_Codice_Ordine_OLO__c = elog11.EOF_Codice_Ordine_OLO__c;
        elog2.EOF_Response__c = elog.EOF_Response__c;
        elog2.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        insert elog2;
        EOF_EAI_Service_Log__c elog3 = new  EOF_EAI_Service_Log__c();
        elog3.Caso__c = elog.Caso__c;
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
        
         EOF_EAI_Service_Log__c elog5 = new  EOF_EAI_Service_Log__c();
        elog5.Caso__c = elog.Caso__c;
        elog5.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog5.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elog5.EOF_Response__c = elog.EOF_Response__c;
        elog5.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        elog5.EOF_Stato_Richiesta__c='Inserita Portale';
        elog5.EOF_Tipo_Comunicazione_String__c = 'CPE';
         insert elog5;
          EOF_EAI_Service_Log__c elog6 = new  EOF_EAI_Service_Log__c();
        elog6.Caso__c = elog.Caso__c;
        elog6.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog6.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elog6.EOF_Response__c = elog.EOF_Response__c;
        elog6.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        elog6.EOF_Stato_Richiesta__c='Inserita Portale';
        elog6.EOF_Tipo_Comunicazione_String__c = 'VLAN';
         insert elog6;
        EOF_EAI_Service_Log__c elog7 = new  EOF_EAI_Service_Log__c();
        elog7.Caso__c = elog.Caso__c;
        elog7.EOF_ID_Notifica__c = 'ID_049487';
        elog7.EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06';
        elog7.EOF_Response__c = elog.EOF_Response__c;
        elog7.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        elog7.EOF_Stato_Richiesta__c='Inserita Portale';
        elog7.EOF_Tipo_Comunicazione_String__c = 'VLAN';
         insert elog7;
    }
    static list<EOF_EAI_Service_Log__c> createServicelog()
    {
        list<EOF_EAI_Service_Log__c> vlstslog = new list<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c elog = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                       from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        EOF_EAI_Service_Log__c elog1 = new  EOF_EAI_Service_Log__c();
        elog1.Caso__c = elog.Caso__c;
        elog1.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog1.EOF_Codice_Ordine_OLO__c = elog.EOF_Codice_Ordine_OLO__c;
        elog1.EOF_Response__c = elog.EOF_Response__c;
        elog1.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        elog1.EOF_Stato_Richiesta__c='Inserita Portale';
        vlstslog.add(elog1);
        EOF_EAI_Service_Log__c elog2 = new  EOF_EAI_Service_Log__c();
        elog2.Caso__c = elog.Caso__c;
        elog2.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog2.EOF_Codice_Ordine_OLO__c = elog1.EOF_Codice_Ordine_OLO__c;
        elog2.EOF_Response__c = elog.EOF_Response__c;
        elog2.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        vlstslog.add(elog2);
        EOF_EAI_Service_Log__c elog3 = new  EOF_EAI_Service_Log__c();
        elog3.Caso__c = elog.Caso__c;
        elog3.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog3.EOF_Codice_Ordine_OLO__c = elog1.EOF_Codice_Ordine_OLO__c;
        elog3.EOF_Response__c = elog.EOF_Response__c;
        elog3.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        vlstslog.add(elog3);
         EOF_EAI_Service_Log__c elog4 = new  EOF_EAI_Service_Log__c();
        elog4.Caso__c = elog.Caso__c;
        elog4.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog4.EOF_Codice_Ordine_OLO__c = elog3.EOF_Codice_Ordine_OLO__c;
        elog4.EOF_Response__c = elog.EOF_Response__c;
        elog4.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        vlstslog.add(elog4);
        insert vlstslog;
        return vlstslog;
    }
    static testMethod void syncError()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request olo = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        olo.COdice_operatore = 'test';
        olo.CODICE_ORDINE_OLO = 'test1';
        olo.ID_NOTIFICA = 'test';
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
       // OF_CO_GE_Utils.syncError(olo,'A03','test');
        //OF_CO_GE_Utils.syncError(olo,'A04','test');
        //OF_CO_GE_Utils.syncError(olo,'A05','test');
        //OF_CO_GE_Utils.syncError(olo,'A06','test');
       // OF_CO_GE_Utils.syncError(olo,'A07','test');
        //OF_CO_GE_Utils.syncError(olo,'A08','test');
        //OF_CO_GE_Utils.syncError(olo,'A09','test');
       // OF_CO_GE_Utils.syncError(olo,'A10','test');
       // OF_CO_GE_Utils.syncError(olo,'B04','test');
       OF_CO_GE_Utils.syncError(sl,'A10','test');
        test.stopTest();
    }
    static testMethod void syncError1()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_CO_GE_Utils.syncError(vlan,'A04','test');
        test.stopTest();
    }
    static testMethod void syncError2()
    {
        test.startTest();
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omns = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_CO_GE_Utils.syncError(sl,'A03','test');
        test.stopTest();
    }
    static testMethod void syncError3()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest omns = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_CO_GE_Utils.syncError(sl,'A05','test');
        test.stopTest();
    }
    static testMethod void syncError4()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest omns = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_CO_GE_Utils.syncError(sl,'A06','test');
        test.stopTest();
    }
    static testMethod void syncError5()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        OF_CO_GE_Utils.syncError(omns,'A07','test');
    }
    static testMethod void syncError6()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest omns = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        OF_CO_GE_Utils.syncError(omns,'A08','test');
        test.stopTest();
    }
    static testMethod void syncError7()
    {
        test.startTest();
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omns = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_CO_GE_Utils.syncError(sl,'A09','test');
        test.stopTest();
    }
    static testMethod void syncError8()
    {   
        test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        OF_CO_GE_Utils.syncError(omns,'B04','test');
        test.stopTest();
    }
    static testMethod void syncError9()
    {
        test.startTest();
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder omns = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        OF_CO_GE_Utils.syncError(omns,'A10','test');
        test.stopTest();
    }
    static testMethod void syncError10()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request omns = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        sl.EOF_Response__c='NACK';
        update sl;
        OF_CO_GE_Utils.syncError(sl,'A10','test');
        test.stopTest();
    }
    static testMethod void create_EAI_Log1()
    {
        test.startTest();
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];

          EOF_EAI_Service_Log__c sl = [select Caso__c,Caso__r.id,OF_SA_ACK__c,EOF_ID_Notifica__c,EOF_Codice_Ordine_OLO__c,EOF_Response__c 
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239' limit 1 FOR UPDATE];
        GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element omns = new GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element();
        omns.TIPO_COMUNICAZIONE = '15';
        omns.CODICE_OPERATORE = 'TIS';
        omns.CODICE_ORDINE_OLO = 'TEST_CE_16:55:06';
        omns.CODICE_ORDINE_OF = c.id;
        omns.DATA_NOTIFICA = dateTime.now();
        omns.ID_NOTIFICA = 'ID_178239';
        omns.ID_RISORSA = 'F3000010405';
        omns.CODICE_PROGETTO_SPECIALE = '?';
        omns.PROMOZIONE = '020103';
        omns.CLUSTER_PROMOZIONE = '123456';
        omns.NOTE = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        
        omns.ID_SERVIZIO = 'AAA0017481';
        omns.PROFILO = 'AG_11_36';
         OF_CO_GE_Utils.slSFOMResp = sl;
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log2()
    {
        test.startTest();
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omns = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log3()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request omns = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log4()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest omns = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log5()
    {
        test.startTest();
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder omns = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log6()
    {
        test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log7()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest omns = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log8()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest omns = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log9()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void create_EAI_Log10()
    {
        test.startTest();
        Map<String, String> omns = new Map<String, String>();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        test.stopTest();
    }
    static testMethod void OM_CreateCompletionOrder_Log()
    {
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder omnc = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(c,omnc);
    }
    static testMethod void CreateAcquisition_Log()
    {
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,OF_SA_Codice_Motivazione__c  FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_Response__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_OLO__c,EOF_Codice_Ordine_EOF__c,EOF_Tipo_Comunicazione__c,EOF_ID_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_Cod_Rifiuto_Sospensione_Annullamento__c,EOF_Mot_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Data_Notifica__c,EOF_stato_ordine__c,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        
        OF_CO_GE_Utils.CreateAcquisition_Log(c);
    }
    static testMethod void OM_CreateStatusUpdate_Log()
    {
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omns = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        list<OF_SA_WS_IN_OM_StatusUpdate.VLAN> vlan = new list<OF_SA_WS_IN_OM_StatusUpdate.VLAN>();
        list<OF_SA_WS_IN_OM_StatusUpdate.APPARATO> apprato = new list<OF_SA_WS_IN_OM_StatusUpdate.APPARATO>();
        omns.VLAN = vlan;
        omns.APPARATO = apprato;
        omns.NOTE = 'Testing';
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        OF_CO_GE_Utils.OM_CreateStatusUpdate_Log(c,omns);
    }
    static testMethod void OLO_CreateDeactivation_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest omns = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        list<OF_SA_WS_IN_OLO_Deactivation.APPARATO> apprato = new list<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        omns.APPARATO = apprato;
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        OF_CO_GE_Utils.OLO_CreateDeactivation_Log(c,omns);
        test.stopTest();
    }
    static testMethod void OM_CreateReschedule_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        OF_CO_GE_Utils.OM_CreateReschedule_Log(c,omns);
        test.stopTest();
    }
    static testMethod void create_ActivationToOM_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        case c = [SELECT Id, CaseNumber, OF_SA_ID_Building_OM__c, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c,Codice_Ordine_EOF__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId, OF_SA_AZIONE_APPARATO__c,OF_SA_PASSWORD_APPARATO__c, recordtype.developername,EOF_TIPOLOGIA_APPARATO__c,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239' FOR UPDATE];
        
        eoflst1[0].recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        update eoflst1[0];
        OF_CO_GE_Utils.create_ActivationToOM_Log(c,eoflst1);
        test.stopTest();
    }
    static testMethod void create_ChangeOrderToOM_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        case c = [SELECT Id, CaseNumber, OF_SA_ID_Building_OM__c, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c,Codice_Ordine_EOF__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId, OF_SA_AZIONE_APPARATO__c,OF_SA_PASSWORD_APPARATO__c, recordtype.developername,EOF_TIPOLOGIA_APPARATO__c,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239' FOR UPDATE];
        
        eoflst1[0].recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        update eoflst1[0];
        OF_CO_GE_Utils.create_ChangeOrderToOM_Log(c,eoflst1);
        test.stopTest();
    }
    static testMethod void OLO_CreateStatusUpdate_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest omns = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        OF_CO_GE_Utils.OLO_CreateStatusUpdate_Log(c,omns);
        test.stopTest();
    }
    static testMethod void OLO_CreateReschedule_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        OF_CO_GE_Utils.OLO_CreateReschedule_Log(c,omns);
        test.stopTest();
    }
    static testMethod void dateToStringNoTime()
    {
        date dt = date.today();
        OF_CO_GE_Utils.dateToStringNoTime(dt);
    }
    static testMethod void copy_notify_AcqCess()
    {
        Test.startTest();
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_Response__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_OLO__c,EOF_Codice_Ordine_EOF__c,EOF_Tipo_Comunicazione__c,EOF_ID_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_Cod_Rifiuto_Sospensione_Annullamento__c,EOF_Mot_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Data_Notifica__c
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        OF_CO_GE_Utils.copy_notify_AcqCess(sl);
        test.stopTest();
    }
    static testMethod void copy_notify_Acquisition()
    {
        Test.startTest();
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        EOF_EAI_Service_Log__c sl = [select Caso__c,EOF_Response__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_OLO__c,EOF_Codice_Ordine_EOF__c,EOF_Tipo_Comunicazione__c,EOF_ID_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_Cod_Rifiuto_Sospensione_Annullamento__c,EOF_Mot_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Data_Notifica__c,EOF_stato_ordine__c,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c
                                     from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
        OF_CO_GE_Utils.copy_notify_Acquisition(sl);
        test.stopTest();
    }
    static testMethod void copy_request1()
    {
        test.startTest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request omns = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request2()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest omns = new  OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request3()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request4()
    {
        test.startTest();
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest omns = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request5()
    {
        test.startTest();
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder omns = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request6()
    {
        test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request7()
    {
        test.startTest();
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omns = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request8()
    {
        test.startTest();
        OF_SA_WS_OLO_classi.NotificaOrdineGpona_element omns = new OF_SA_WS_OLO_classi.NotificaOrdineGpona_element();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request9()
    {
        test.startTest();
        OF_SA_WS_OLO_Classi.NotificaRischedulazione_element omns = new OF_SA_WS_OLO_Classi.NotificaRischedulazione_element();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request10()
    {
        test.startTest();
        OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element omns = new OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request11()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.AttivazioneGpona_element omns = new OF_SA_WS_OM_Classi.AttivazioneGpona_element();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request12()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.Disattivazione_element omns = new  OF_SA_WS_OM_Classi.Disattivazione_element();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request13()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.Rischedulazione_element omns = new OF_SA_WS_OM_Classi.Rischedulazione_element();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void copy_request14()
    {
        test.startTest();
        OF_SA_WS_OM_Classi.AggiornamentoStato_element omns = new OF_SA_WS_OM_Classi.AggiornamentoStato_element();
        OF_CO_GE_Utils.copy_request(omns);
        test.stopTest();
    }
    static testMethod void aggiornamentoDatiAttivazioneCessazioneToOM()
    {
        test.startTest();
        string processo = 'Create';
        string tipo_comunicazione = '98';
        string estito = '2';
        OF_CO_GE_Utils.checkApp = false;
        OF_CO_GE_Utils.checkServAgg = false;
        try
        {
            OF_CO_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM(processo,tipo_comunicazione,estito);   
        }
        catch(exception e)
        {}
        test.stopTest();  
    }
    static testmethod void IdservizioIntToString()
    {
        test.startTest();
        for(integer i=1;i<=26;i++)
        {
            OF_CO_GE_Utils.IdservizioIntToString(i); 
        }
        test.stopTest();
    }
    static testMethod void IdservizioStringToInt()
    {
        test.startTest();
        list<string> alphalist = new list<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
            for(string str : alphalist)
        {
            OF_CO_GE_Utils.IdservizioStringToInt(str);
        }
        test.stopTest();
    }
   
    static testmethod void returnStatusFromInt()
    {
        test.startTest();
        string metodo ='OM_StatusUpdate';
        list<string> numlist = new  list<string>{'0','1','2','3','4','5','6','7'};
            for(string str : numlist)
        {
            OF_CO_GE_Utils.returnStatusFromInt(str,metodo); 
        }
        test.stopTest();
    }
    static testmethod void returnStatusFromInt2()
    {
        test.startTest();
        string metodo ='OM_CompletionOrder';
        list<string> numlist = new  list<string>{'0','1','2','3','4','5','6','7'};
            for(string str : numlist)
        {
            OF_CO_GE_Utils.returnStatusFromInt(str,metodo); 
        }
        test.stopTest();
    }
    static testmethod void checkDate()
    {
        test.startTest();
        string date1 = string.valueof(date.today());
        OF_CO_GE_Utils.checkDate(date1);
        test.stopTest();
    }
    static testmethod void checkTime()
    {
        test.startTest();
        string date1 = string.valueof(datetime.now());
        OF_CO_GE_Utils.checkTime(date1);
        test.stopTest();
    }
    static testmethod void checkDateTime()
    {
        test.startTest();
        string date1 = string.valueof(datetime.now());
        OF_CO_GE_Utils.checkDateTime(date1);
        test.stopTest();
    }
    static testmethod void checkEmail()
    {
        test.startTest();
        string email = 'test@google.com';
        OF_CO_GE_Utils.checkEmail(email);
        test.stopTest();
    }
    static testmethod void getQuery()
    {
        test.startTest();
        string s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c,'
            +'EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,'
            +'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername,'
            +'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,CaseNumber,OF_Response_Da_OM__c,' 
            +'OF_SA_ID_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_Provincia_WS__c,EOF_Comune_WS__c,'
            +'EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,OF_SA_ID_Building_OM__c,'
            +'OF_Response_Da_OLO__c,OF_Bonifica_Locked_Row__c from Case';
        string oggetto ='case';
        string processo = 'AsyncActivation';
        OF_CO_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    static testmethod void getQuery3()
    {
        test.startTest();
        string s='Select Id, Codice_ordine_Eof__C, EOF_Codice_Ordine_Olo__c,'
            +'EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,'
            +'EOF_Data_Notifica__c,EOF_Id_Notifica__c,PO_SA_Portale__c,recordtype.developername,'
            +'EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,status,EOF_FASE__C,CaseNumber,OF_Response_Da_OM__c,' 
            +'OF_SA_ID_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,OF_SA_MOTIVAZIONE__c,EOF_Provincia_WS__c,EOF_Comune_WS__c,'
            +'EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,OF_SA_ID_Building_OM__c,'
            +'OF_Response_Da_OLO__c,OF_Bonifica_Locked_Row__c from Case';
        string oggetto ='case';
        string processo = 'AsyncDeactivation';
        OF_CO_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    static testmethod void getQuery2()
    {
        test.startTest();
        string oggetto ='sl';
        string processo = 'AsyncActivation';
        OF_CO_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    static testmethod void getQuery4()
    {
        test.startTest();
        string oggetto ='sl';
        string processo = 'AsyncDeactivation';
        OF_CO_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    static testmethod void getQuery5()
    {
        test.startTest();
        string oggetto ='asset';
        string processo = 'AsyncDeactivation';
        OF_CO_GE_Utils.getQuery(oggetto,processo);
        test.stopTest();
    }
    static testmethod void simulateNACK()
    {
        test.startTest();
        string origine='OLO';
        OF_CO_GE_Utils.simulateNACK(origine);
        test.stopTest();
    }
    static testmethod void simulateNACK2()
    {
        test.startTest();
        string origine='OM';
        OF_CO_GE_Utils.simulateNACK(origine);
        test.stopTest();
    }
    static testMethod void aggiornamentoDatiAcquisizione()
    {
        test.startTest();
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        system.debug('test 64 method===='+c);
        
        // OF_CO_GE_Utils.aggiornamentoDatiAcquisizione(c2);
        test.stopTest();
        
    }
    
    static testMethod void aggiornaSLPortale()
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
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239' FOR UPDATE];
        
        string mystr = 'OM_StatusUpdate';
       
        OF_CO_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
        test.stopTest();
    }
    static testMethod void aggiornaSLPortaleupdate3()
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
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c 
                                                where  EOF_ID_Notifica__c = 'ID_049487' and recordtype.name='PO - SA - FiberRequest' and EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06' FOR UPDATE];
     
        string mystr = 'OM_Reschedule';
       
        OF_CO_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
        test.stopTest();
    }
    
 
    
    
    
     static testMethod void aggiornaSLPortaleNewUpdate()
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
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c 
                                               where EOF_ID_Notifica__c = 'ID_049487' and recordtype.name='PO - SA - FiberRequest' and EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06' FOR UPDATE];
        
        string mystr = 'OM_Reschedule';
      
        OF_CO_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
        test.stopTest();
    }
     static testMethod void aggiornaSLPortaleNew2()
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
                                               where EOF_ID_Notifica__c = 'ID_049487' and recordtype.name='PO - SA - FiberRequest' and EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06' FOR UPDATE];
        
        string mystr = 'OM_CompletionOrder';
      
        OF_CO_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
        test.stopTest();
    }
    static testMethod void aggiornaSLPortale2()
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
                                               EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_DDT__c,EOF_Data_Espletamento_Ordine__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c 
                                               where EOF_ID_Notifica__c = 'ID_178239' FOR UPDATE];
        
        string mystr = 'OM_CompletionOrder';
        
      // List<EOF_EAI_Service_Log__c> eoflst = createServicelog();
        OF_CO_GE_Utils.aggiornaSLPortale(eoflst1,mystr);
        test.stopTest();
    }
    static testMethod void aggiornaSLPortale3()
    {
        test.startTest();
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
      List<EOF_EAI_Service_Log__c> eoflst = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' FOR UPDATE];
        
        eoflst[0].recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
      /* update eoflst[0];
         string caseid = c.id;
        string  eoflog1 = eoflst[0].id;
        string  eoflog2 = eoflst[0].id;
        OF_CO_GE_Utils.aggiornamentoDatiEspletamento(caseid,eoflog1,eoflog2);*/
        test.stopTest();
    }
    static testMethod void aggiornaSLPortale5()
    {
        test.startTest();
         case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
     EOF_EAI_Service_Log__c sl = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'test_01' limit 1 FOR UPDATE];
       
        try
        {
            TEMPLOG__c t = new TEMPLOG__c();
                t.Name=c.EOF_Codice_Ordine_OLO__c;
                t.DataInserimento__c=string.valueOF(system.now());
                t.Desc__c='error';
                t.Class__c='OF_CO_GE_Utils';
                insert t;
            OF_Generatore_ID_Servizio__c gen = new OF_Generatore_ID_Servizio__c();
           // gen.name = '0000017531';
            insert gen;
            OF_CO_GE_Utils.gen = gen;
          OF_CO_GE_Utils.aggiornamentoDatiAcquisizione(c);   
        }
        catch(exception e){}
        test.stopTest();
    }

    public static testmethod  void MyUnitTest3(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
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
        
        OF_CO_GE_Utils.slOLOSF = new EOF_EAI_Service_Log__c();
        OF_CO_GE_Utils.slOLOSF.id = TestDataFactory.ESlog[0].id;
                
        OF_CO_GE_Utils.create_EAI_Log( a );
        OF_CO_GE_Utils.CreateAcquisition_Log(TestDataFactory.c1);
        OF_CO_GE_Utils.create_ActivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog);        
        OF_CO_GE_Utils.syncError( a , 'A03' , 'test' );
        OF_CO_GE_Utils.checkDate('2017-11-16');
        OF_CO_GE_Utils.CheckTime('10:00:00');
        OF_CO_GE_Utils.checkDateTime('2017-11-16T10:00:00');
        OF_CO_GE_Utils.checkEmail('test@test.it');
        OF_CO_GE_Utils.checkAmministratori(TestDataFactory.c1);
        OF_CO_GE_Utils.getQuery('a','test');
        OF_CO_GE_Utils.simulateNACK ('test');
        
        //OF_CO_GE_Utils.CreateTemplogOLO(a);
        //OF_CO_GE_Utils.partialTemplog('test');
        //OF_CO_GE_Utils.EndTemplog();
        
        test.stopTest();
    }
    
    public static testmethod void MyUnitTest4(){
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);


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
        
        OF_CO_GE_Utils.slSFOLO = new EOF_EAI_Service_Log__c();
        OF_CO_GE_Utils.slSFOLO.id = TestDataFactory.ESlog[0].id;
        
        OF_CO_GE_Utils.slSFOLOresp = new EOF_EAI_Service_Log__c();        
        
        OF_CO_GE_Utils.create_EAI_Log( deact );
        OF_CO_GE_Utils.syncError( deact , 'A07' , 'test' );
        OF_CO_GE_Utils.OLO_CreateDeactivation_Log(TestDataFactory.c1, deact);
        //OF_CO_GE_Utils.create_DeactivationToOM_Log(TestDataFactory.c1,TestDataFactory.ESlog,TestDataFactory.ast[0]);
        //OF_CO_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM('test','1','0');
        //OF_CO_GE_Utils.CreateTemplogOLO(deact);
        //OF_CO_GE_Utils.partialTemplog('test');
        //OF_CO_GE_Utils.EndTemplog();

        
        test.stopTest();
        
    }

    public static testmethod void MyUnitTest5 (){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM','OF - SA - FiberRequest', null);
        
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
        OF_CO_GE_Utils.create_EAI_Log( Notify );
        //OF_CO_GE_Utils.syncError( Notify , 'B04' , 'test' );        
        OF_CO_GE_Utils.returnStatusFromInt('0','OM_CompletionOrder');
        OF_CO_GE_Utils.returnStatusFromInt('1','OM_CompletionOrder');
        OF_CO_GE_Utils.returnStatusFromInt('0','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('1','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('2','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('3','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('4','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('5','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('6','OM_StatusUpdate');
        OF_CO_GE_Utils.returnStatusFromInt('7','OM_StatusUpdate');
        OF_CO_GE_Utils.OM_CreateStatusUpdate_Log(TestDataFactory.c1, Notify);
        //OF_CO_GE_Utils.CreateTemlogOM(Notify);
        
        test.stopTest();        
    }
    public static testmethod void MyUnitTestAttivazione(){
        
             test.startTest();  
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        //accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        
        
        insert accOLO;
        
         Asset a1 = new Asset();
        //a1.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_OpenStream');
        a1.status='Attivo';
        a1.EOF_ID_Risorsa__c='risorsa';
        a1.name='Test';
        a1.accountId=accOlo.id;
        a1.EOF_OLO__c='VF';
        
              
        insert a1;
                OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        case c = [SELECT Id, CaseNumber, OF_SA_ID_Building_OM__c, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c,Codice_Ordine_EOF__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1 FOR UPDATE];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,OF_SA_ID_APPARATO__c,EOF_ID_Risorsa__c,recordtypeId, OF_SA_AZIONE_APPARATO__c,OF_SA_PASSWORD_APPARATO__c, recordtype.developername,EOF_TIPOLOGIA_APPARATO__c,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239' FOR UPDATE];
        
        eoflst1[0].recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        update eoflst1[0];
        OF_CO_GE_Utils.create_DeactivationToOM_Log(c,eoflst1,a1);
        test.stopTest();
        
    }

}
/*
-------------------------------------------------------------------------------------------------------
Author : Sasya  Date : 08-06-2018  Description: Test code coverage for OF_CO_GE_Utils controller
-------------------------------------------------------------------------------------------------------
*/
@isTest
public class OF_CO_GE_Utils_Test2 {
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
        c.EOF_Id_Risorsa__c = 'F3000010405';
        insert c;
        Asset objAsset = new Asset();
        objAsset.Name= 'Test Asset';
        objAsset.Status = 'Attivo';
        objAsset.EOF_ID_Risorsa__c = c.EOF_ID_Risorsa__c;
        objAsset.AccountId = acc.Id; 
        insert objAsset;
        
        
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
        EOF_EAI_Service_Log__c elog8 = new  EOF_EAI_Service_Log__c();
        elog8.Caso__c = elog.Caso__c;
        elog8.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog8.EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06';
        elog8.EOF_Response__c = elog.EOF_Response__c;
        elog8.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        elog8.EOF_Stato_Richiesta__c='Inserita Portale';
        elog8.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        insert elog8;
        EOF_EAI_Service_Log__c elog9 = new  EOF_EAI_Service_Log__c();
        elog9.Caso__c = elog.Caso__c;
        elog9.EOF_ID_Notifica__c = elog.EOF_ID_Notifica__c;
        elog9.EOF_Codice_Ordine_OLO__c = 'TEST_Sasya_16:55:06';
        elog9.EOF_Response__c = elog.EOF_Response__c;
        elog9.recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        elog9.EOF_Stato_Richiesta__c='Inserita Portale';
        elog9.EOF_Tipo_Comunicazione_String__c = 'VLAN';
        insert elog9;
    }
    static testMethod void create_ActivationToOM_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, Codice_Ordine_EOF__c,EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,OF_SA_ID_Building_OM__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                                EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                                EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                EOF_PROMOZIONE__C,OF_SA_INFORMAZIONI_VLAN__C,EOF_TIPOLOGIA_APPARATO__c,OF_SA_AZIONE_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                                OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_CUSTOMER_VLAN__C,EOF_RECAPITO_TEST_LINEA__C,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,OF_SA_USER_VLAN__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_INFORMAZIONI_SERVIZIO__c,OF_SA_NOME_SERVIZIO__c,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239'];
        
        eoflst1[0].recordtypeId =  Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        update eoflst1[0];
        OF_CO_GE_Utils.create_ChangeOrderToOM_Log(c,eoflst1);
        OF_CO_GE_Utils.create_ActivationToOM_Log(c,eoflst1);
        OF_CO_GE_Utils.create_EAI_Log(c);
        test.stopTest();
    }
    static testMethod void create_DeactivationToOM_Log()
    {
        Test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, Codice_Ordine_EOF__c,EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,OF_SA_ID_Building_OM__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                                EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                                EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                EOF_PROMOZIONE__C,EOF_ID_Risorsa__c,EOF_GPON_Vincolante__c,OF_SA_INFORMAZIONI_VLAN__C,EOF_TIPOLOGIA_APPARATO__c,OF_SA_AZIONE_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                                OF_SA_ID_APPARATO__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_CUSTOMER_VLAN__C,EOF_RECAPITO_TEST_LINEA__C,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,OF_SA_USER_VLAN__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_INFORMAZIONI_SERVIZIO__c,OF_SA_NOME_SERVIZIO__c,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239'];
        
        Asset A = [Select Id, Status, Name, EOF_ID_Risorsa__c,OF_GPON_Attestazione__c,OF_IDServizio__c,OF_Provincia__c,OF_Comune__c,
                   OF_Particella_Toponomastica__c,OF_Indirizzo__c,OF_Civico__c FROM Asset WHERE EOF_ID_Risorsa__c=: c.EOF_ID_Risorsa__c AND Status = 'Attivo' limit 1];
        OF_CO_GE_Utils.create_DeactivationToOM_Log(c,eoflst1,a);
        OF_CO_GE_Utils.create_ActivationToOM_Log(c,eoflst1);
        OF_CO_GE_Utils.create_EAI_Log(c);
        test.stopTest();
    }
    static testMethod void Method3()
    {
        test.startTest();
        case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                                EOF_ID_NOTIFICA__c,EOF_Tipo_Comunicazione_String__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                                EOF_NOME_CLIENTE__c,EOF_Codice_Motivazione__c,EOF_GPON_Attestazione__c,EOF_Stato_Ordine__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                EOF_PROMOZIONE__C,EOF_ID_Risorsa__c,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                                EOF_RECAPITO_TEST_LINEA__C,OF_SA_USER_VLAN__c,OF_SA_DDT__c,EOF_Data_Espletamento_Ordine__c,OF_SA_SERVICE_VLAN__c,OF_SA_Customer_vlan__c,OF_SA_MOTIVAZIONE_RITIRO__c,OF_SA_CODICE_MOTIVAZIONE_RITIRO__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_ESITO_RITIRO_APPARATO__c,EOF_ID_Pop__c,EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c 
                                                where EOF_ID_Notifica__c = 'ID_178239'];
        TEMPLOG__c t = new TEMPLOG__c();
        t.Name=c.EOF_Codice_Ordine_OLO__c;
        t.DataInserimento__c=string.valueOF(system.now());
        t.Class__c='OF_CO_GE_Utils';
        insert t;
        string process = 'Create';
        string comunizo = '98';
        string estio = '0';
        OF_CO_GE_Utils.checkApp = false;
        OF_CO_GE_Utils.checkServAgg = false;
        OF_CO_GE_Utils.aggiornamentoDatiAttivazioneCessazioneToOM(process,comunizo,estio);
        test.stopTest();
    }
    
    static testMethod void Method4()
    {
        Test.startTest();
        
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, Codice_Ordine_EOF__c,EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,OF_SA_ID_Building_OM__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' ];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                                EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                                EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                EOF_PROMOZIONE__C,OF_SA_INFORMAZIONI_VLAN__C,EOF_TIPOLOGIA_APPARATO__c,OF_SA_AZIONE_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                                OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_CUSTOMER_VLAN__C,EOF_RECAPITO_TEST_LINEA__C,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,OF_SA_USER_VLAN__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_INFORMAZIONI_SERVIZIO__c,OF_SA_NOME_SERVIZIO__c,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239'];
        
        list<OF_SA_WS_IN_OM_CompletionOrder.APPARATO> apprato = new list<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        OF_SA_WS_IN_OM_CompletionOrder.APPARATO oa = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        oa.TIPOLOGIA_APPARATO = 'Test';
        oa.ESITO_CONSEGNA_APPARATO = 'Test';
        oa.ID_APPARATO_CONSEGNATO = 'Test';
        oa.CODICE_MOTIVAZIONE_CONSEGNA = 'Test';
        oa.MOTIVAZIONE_CONSEGNA = 'Test';
        apprato.add(oa);
        
        list<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO> salst = new list<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();    
        OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO sa = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();       
        sa.NOME_SERVIZIO = 'Test';
        sa.ESITO_SERVIZIO = 'Test';
        sa.CODICE_MOTIVAZIONE_SERVIZIO = 'Test';
        sa.MOTIVAZIONE_SERVIZIO = 'TEST';
        salst.add(sa);
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ort = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        ort.CODICE_OPERATORE = 'Test';
        ort.CODICE_ORDINE_OLO = 'Test';
        ort.CODICE_ORDINE_OF = 'Test';
        ort.DATA_NOTIFICA = string.valueof(date.today());
        ort.ID_NOTIFICA = 'Test';
        ort.STATO_ORDINE = 'Testing';
        ort.CODICE_MOTIVAZIONE = 'Testing';
        ort.MOTIVAZIONE = 'Testing';
        ort.ID_RISORSA = 'Testing';
        ort.DATA_ESPLETAMENTO_ORDINE = string.valueof(date.today());
        ort.SCALA_PALAZZINA = 'Testing';
        ort.DDT = 'Testing';
        ort.NOTE = 'Testing ';
        ort.SERVIZIO_AGGIUNTIVO = salst;
        ort.APPARATO = apprato;                          
        
        OF_CO_GE_Utils.create_EAI_Log(clst[0]);
        OF_CO_GE_Utils.create_EAI_Log(ort);
        OF_CO_GE_Utils.create_EAI_Log(eoflst1[0]);
        OF_CO_GE_Utils.OM_CreateCompletionOrder_Log(clst[0],ort);
        Test.stopTest();
    }
    static testMethod void Method5()
    {
        Test.startTest();
        
        list<case> clst = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                           EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, Codice_Ordine_EOF__c,EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                           EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                           EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                           EOF_Provincia_WS__c,EOF_Comune_WS__c,OF_SA_ID_Building_OM__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                           EOF_Opzione_System_Unico__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' ];
        
        List<EOF_EAI_Service_Log__c> eoflst1 = [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                                EOF_ID_NOTIFICA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                                                EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                                EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                EOF_PROMOZIONE__C,OF_SA_INFORMAZIONI_VLAN__C,EOF_TIPOLOGIA_APPARATO__c,OF_SA_AZIONE_APPARATO__C,OF_SA_PASSWORD_APPARATO__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                                OF_SA_MODELLO_DI_SERVIZIO_VLAN__C,OF_SA_CUSTOMER_VLAN__C,EOF_RECAPITO_TEST_LINEA__C,OF_SA_SERVICE_VLAN__C,OF_SA_PROFILO_VLAN__C,OF_SA_USER_VLAN__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_INFORMAZIONI_SERVIZIO__c,OF_SA_NOME_SERVIZIO__c,EOF_ID_Pop__c,EOF_PROFILO__C from EOF_EAI_Service_Log__c where EOF_ID_Notifica__c = 'ID_178239'];
        
        list<OF_SA_WS_IN_OLO_Activation.VLAN> vlanlst = new  list<OF_SA_WS_IN_OLO_Activation.VLAN>();
        OF_SA_WS_IN_OLO_Activation.VLAN vlan = new  OF_SA_WS_IN_OLO_Activation.VLAN();
        vlan.KIT_CONSEGNA_VLAN = 'Test';
        vlan.USER_VLAN = 'Test';
        vlan.SERVICE_VLAN = 'Test';
        vlan.PROFILO_VLAN = 'Test';
        vlan.INFORMAZIONI_VLAN = 'Test';
        vlan.CUSTOMER_VLAN = 'Test';
        vlan.MODELLO_DI_SERVIZIO_VLAN = 'Test';
        vlanlst.add(vlan);
        
        list<OF_SA_WS_IN_OLO_Activation.APPARATO> applst = new list<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        OF_SA_WS_IN_OLO_Activation.APPARATO app = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        app.TIPOLOGIA_APPARATO = 'Test';
        app.PASSWORD_APPARATO = 'Test';
        app.AZIONE_APPARATO  = 'Test';
        applst.add(app);
        
        list<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO> salst = new list<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO sa1 = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        sa1.NOME_SERVIZIO  = 'Test'; 
        sa1.INFORMAZIONI_SERVIZIO = 'Test';
        salst.add(sa1);
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest sa = new  OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        sa.CODICE_OPERATORE = 'Test';
        sa.CODICE_ORDINE_OLO = 'test';
        sa.DATA_NOTIFICA = string.valueof(date.today());
        sa.ID_NOTIFICA = 'Test';
        sa.NOME_REFERENTE_TECNICO_OLO = 'Test';
        sa.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        sa.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        sa.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        sa.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'Test';
        sa.NOME_CLIENTE = 'Test';
        sa.COGNOME_CLIENTE = 'Test';
        sa.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        sa.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        sa.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        sa.DATA_PREVISTA_ATTIVAZIONE = string.valueof(date.today());
        sa.ORARIO_APPUNTAMENTO = 'Test';
        sa.CODICE_PROGETTO_SPECIALE = 'Test';
        sa.PROMOZIONE = 'Test';
        sa.CLUSTER_PROMOZIONE = 'Test';
        sa.NOTE = 'Test';
        sa.ID_BUILDING = 'Test';
        sa.SCALA_PALAZZINA = 'Test';
        sa.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        sa.RECAPITO_TEST_LINEA = 'Test';
        sa.IDENTIFICATIVO_DEL_POP = 'Test';
        sa.PROFILO = 'Test';
        sa.SERVIZIO_AGGIUNTIVO = salst;
        sa.APPARATO = applst;
        sa.VLAN = vlanlst;             
        
        OF_CO_GE_Utils.create_EAI_Log(clst[0]);
        OF_CO_GE_Utils.create_EAI_Log(sa);
        OF_CO_GE_Utils.create_EAI_Log(eoflst1[0]);
        
        Test.stopTest();
    }
    // syncError() method
    static testMethod void Method6(){
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse omns = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
        OF_CO_GE_Utils.syncError(omns,'A03','test');
        OF_CO_GE_Utils.syncError(omns,'A04','test');
        OF_CO_GE_Utils.syncError(omns,'A05','test');
        OF_CO_GE_Utils.syncError(omns,'A06','test');
        OF_CO_GE_Utils.syncError(omns,'A07','test');
        OF_CO_GE_Utils.syncError(omns,'A08','test');
        OF_CO_GE_Utils.syncError(omns,'A09','test');
        OF_CO_GE_Utils.syncError(omns,'A10','test');
        OF_CO_GE_Utils.syncError(omns,'B04','test'); 
        
    }
    
    /* static testMethod void Method7(){



OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request omns = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
//eaiLog.Caso__c  = c.Id;
eaiLog.EOF_ID_Notifica__c = 'test_01';
eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
//eaiLog.recordTypeId = eaiRecordType;
eaiLog.OF_SA_ACK__c = true;
eaiLog.EOF_Response__c='NACK';
insert eaiLog;
OF_CO_GE_Utils.syncError(omns,'A10','test');

} */
    
    
    
    static testMethod void Method8(){
        
        
        Test.startTest();
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule omns = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        
        OF_CO_GE_Utils.syncError(omns,'A10','test');
        Test.stopTest();
        
    }
    
    
    static testMethod void Method9(){
        
        
        Test.startTest();
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder omns = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        
        OF_CO_GE_Utils.syncError(omns,'A10','test');
        Test.stopTest();
        
    }
    //create_EAI_Log()
    
    static testMethod void Method10(){
        
        
        Test.startTest();
        GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element omns = new GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element();
        try
        {
            OF_CO_GE_Utils.create_EAI_Log(omns);
        }
        Catch(exception e)
        {
            
        }
        
        
        Test.stopTest();
        
    }
    
    static testMethod void Method11(){
        
        
        Test.startTest();
        
        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate omns1 = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        OF_CO_GE_Utils.create_EAI_Log(omns1);
        
        Test.stopTest();
        
    }
    
    static testMethod void Method12(){
        
        
        Test.startTest();
        
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request omns = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        OF_CO_GE_Utils.create_EAI_Log(omns);
        
        Test.stopTest();
        
    }
    
    
    
    static testMethod void Method13(){
        
        
        Test.startTest();
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest omns1 = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns1);
        
        Test.stopTest();
        
    }
    
    
    
    static testMethod void Method14(){
        
        
        Test.startTest();
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest omns1 = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns1);
        OF_CO_GE_Utils.syncError(omns1,'A10','test');
        
        Test.stopTest();
        
    }
    
    
    static testMethod void Method15(){
        
        
        Test.startTest();
        
        OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest omns1 = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns1);
        OF_CO_GE_Utils.syncError(omns1,'A10','test');
        
        Test.stopTest();
        
    }

    static testMethod void Method16(){
        
        
        Test.startTest();
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest omns1 = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        OF_CO_GE_Utils.create_EAI_Log(omns1);
        OF_CO_GE_Utils.syncError(omns1,'A10','test');
        
        Test.stopTest();
        
    }    



   
    
}
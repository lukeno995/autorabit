@isTest
public class OF_TTM_WS_IN_Notify_Services_Test {
    
    public static testmethod void Method1A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 =  new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 =  new OF_TTM_WS_IN_Notify.TTM_Notify();
        
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
        eaiLog1.EOF_NOTE__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        
        List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
        Case c = new Case();
        c.OF_TroubleTicketManager__c = True;
        c.Status = 'In Lavorazione';
        c.TTM_TICKETID__c = '';
        c.EOF_Codice_Comunicazione_OLO__c = obj3.CODICE_COMUNICAZIONE_OLO;
        c.RecordTypeId = rt.get(0).id;
        insert c;
        
        String responseDaOLO = 'ACK';
        OF_TTM_Utils.responseDaOLO = responseDaOLO;
        
        OF_TTM_WS_IN_Notify_Services.Sospensione(obj3);
    }
    
    public static testmethod void Method1B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 =  new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 =  new OF_TTM_WS_IN_Notify.TTM_Notify();
        OF_TTM_WS_IN_Notify_Services.Sospensione(obj3);
    }
    
    public static testmethod void Method2A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        
        List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
        Case c = new Case();
        c.OF_TroubleTicketManager__c = True;
        c.Status = 'Sospeso';
        c.TTM_TICKETID__c = '';
        c.EOF_Codice_Comunicazione_OLO__c = obj3.CODICE_COMUNICAZIONE_OLO;
        c.RecordTypeId = rt.get(0).id;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.Desospensione(obj3);
    }
    
    public static testmethod void Method2B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        OF_TTM_WS_IN_Notify_Services.Desospensione(obj3);
    }
    
    public static testmethod void Method3A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        
        List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
        Case c = new Case();
        c.OF_TroubleTicketManager__c = True;
        c.Status = 'In Annullamento';
        c.TTM_TICKETID__c = '';
        c.EOF_Codice_Comunicazione_OLO__c = obj3.CODICE_COMUNICAZIONE_OLO;
        c.RecordTypeId = rt.get(0).id;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.Annullato(obj3);
    }
    
    public static testmethod void Method3B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        OF_TTM_WS_IN_Notify_Services.Annullato(obj3);
    }
    
    public static testmethod void Method4A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        
        List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
        Case c = new Case();
        c.OF_TroubleTicketManager__c = True;
        c.Status = 'In Lavorazione';
        c.TTM_TICKETID__c = '';
        c.EOF_Codice_Comunicazione_OLO__c = obj3.CODICE_COMUNICAZIONE_OLO;
        c.RecordTypeId = rt.get(0).id;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.Chiusura(obj3);
    }
    
    public static testmethod void Method4B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        OF_TTM_WS_IN_Notify_Services.Chiusura(obj3);
    }
    
    public static testmethod void Method5A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        
        List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
        Case c = new Case();
        c.OF_TroubleTicketManager__c = True;
        c.Status = 'Richiesta Chiusura';
        c.TTM_TICKETID__c = '';
        c.EOF_Codice_Comunicazione_OLO__c = obj3.CODICE_COMUNICAZIONE_OLO;
        c.RecordTypeId = rt.get(0).id;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.TimeOut(obj3);
    }
    
    public static testmethod void Method5B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        OF_TTM_WS_IN_Notify_Services.TimeOut(obj3);
    }
    
    public static testmethod void Method6A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        
        List<Recordtype> rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Trouble Ticket' LIMIT 1];
        Case c = new Case();
        c.OF_TroubleTicketManager__c = True;
        c.Status = 'Accettato';
        c.TTM_TICKETID__c = '';
        c.EOF_Codice_Comunicazione_OLO__c = obj3.CODICE_COMUNICAZIONE_OLO;
        c.RecordTypeId = rt.get(0).id;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.updateTICKETID(obj3);
    }
    
    public static testmethod void Method6B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        OF_TTM_WS_IN_Notify.TTM_NotifyResponse obj2 = new OF_TTM_WS_IN_Notify.TTM_NotifyResponse();
        OF_TTM_WS_IN_Notify.TTM_Notify obj3 = new OF_TTM_WS_IN_Notify.TTM_Notify();
        OF_TTM_WS_IN_Notify_Services.updateTICKETID(obj3);
    }
    
    public static testmethod void Method7A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOTE__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        c.EOF_Comunicazioni_con_OLO__c = 'Test';
        C.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        c.EOF_Rischedulazione_Appuntamento__c = System.today() + 5;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreChiusura(c,eaiLog1);
    }
    
    public static testmethod void Method7B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOTE__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        C.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreChiusura(c,eaiLog1);
    }
    
    public static testmethod void Method7C(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreChiusura(c,eaiLog1);
    }
    
    
    
    public static testmethod void Method8A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOte__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        c.EOF_Comunicazioni_con_OLO__c = 'Test';
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreAnnullato(c,eaiLog1);
    }
    
    public static testmethod void Method8B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOte__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        //c.EOF_Comunicazioni_con_OLO__c = 'Test';
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreAnnullato(c,eaiLog1);
    }
    
    
    public static testmethod void Method9A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOTE__c = 'Test';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        c.EOF_Comunicazioni_con_OLO__c = 'Test';
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreDesospensione(c,eaiLog1);
    }
    
    public static testmethod void Method9B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOTE__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        c.EOF_Referente_desospensione__c = 'Test';
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreDesospensione(c,eaiLog1);
    }
    
    public static testmethod void Method9C(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOTE__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
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
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.PO_PP_ID_Richiesta__c=c.id;
        
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreDesospensione(c,eaiLog1);
    }
    
    public static testmethod void Method10A(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOte__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        Case c = new Case();
        c.eof_fase__c = 'in Analisi';
        c.EOF_Rischedulazione_Appuntamento__c = System.today() + 5;
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        c.eof_fase__c = 'On Field';
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        c.eof_fase__c = 'in Collaudo';
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        
        c.PO_TT_Portale__c=true;
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        
    } 
    
    public static testmethod void Method10B(){
        
        OF_TTM_WS_IN_Notify_Services obj1 = new OF_TTM_WS_IN_Notify_Services();
        
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
        eaiLog1.EOF_NOte__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        Case c = new Case();
        c.Status='Acquisito';
        c.eof_fase__c = 'in Analisi';
        //c.EOF_Rischedulazione_Appuntamento__c = System.today() + 5;
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        insert c;
        
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        c.eof_fase__c = 'On Field';
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        c.eof_fase__c = 'in Collaudo';
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        c.Status='Accettato';
        c.PO_TT_Portale__c=true;
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        c.Status='Annullato';
        c.PO_TT_Portale__c=true;
        OF_TTM_WS_IN_Notify_Services.coreSospensione(c,eaiLog1);
        
        
        
    } 
    public static testmethod void Method10B1(){
        
        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'TroubleTicketRequest'];
        RecordType rtCase = [Select id from RecordType where SobjectType='Case' and DeveloperName ='EOF_Caso_TT'];
        RecordType rtCaseTTM = [Select id from RecordType where SobjectType='Case' and DeveloperName ='Trouble_Ticket'];
        RecordType rtTTRequest = [Select id from RecordType where SobjectType='EOF_EAI_Service_Log__c' and DeveloperName ='TroubleTicketRequest'];
        RecordType rtTTNotify = [Select id from RecordType where SobjectType='EOF_EAI_Service_Log__c' and DeveloperName ='TroubleTicketNotify'];
        
        /*
		OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;	
		*/
        
        Case c = new Case();
        c.Status='In Lavorazione';
        c.PO_TT_Portale__c=true;
        c.eof_fase__c = 'in Analisi';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        c.CA_Azienda__c='CEIT';
        //c.CA_Censimento__c='Esterno';
        c.CA_Citt__c='Macerata';
        c.CA_Civico__c='46';
        c.CA_ID_Building__c='11_043_043023_8000685386_46';
		c.CA_ID_Building_Scala__c='11_043_043023_8000685386_46';
        c.CA_In_Lavorazione_Esterno__c=System.today().addMonths(-3);
        c.CA_Lavori_Civili_Interni__c= true;
        c.CA_Numero_Ordini_in_Corso__c=0;
        c.CA_Numero_UI_business__c='0';
        c.CA_Numero_UI_residenziali__c='4';
 		c.CA_Pfs__c='MC_01/03w42';
        c.CA_Via__c='via test';
        c.EOF_Async_Check_ctrl__c=false;
        c.Origin='Web';
         
        insert c;
        
        
        Case cTT = new Case(); 
        cTT.EOF_Id_Notifica__c='idNot00001';
        cTT.Status='Accettato';
        cTT.EOF_Fase__c='In Analisi';
        cTT.EOF_Codice_Operatore_WS__c ='TIS';
        cTT.EOF_GPON_Attestazione__c='PG_01';
        cTT.EOF_Id_Risorsa__c = 'IdRis0001';
        cTT.EOF_Data_Notifica__c= system.today();
        cTT.EOF_Data_Prevista_Attivazione__c= system.today();
        cTT.EOF_Nuova_DAC__c=null;  
        cTT.RecordTypeId=rtCaseTTM.id;
        cTT.OF_Bonifica_Locked_Row__c=true;
        cTT.EOF_Pertinenza_RDAC__c= null;
        cTT.canModify__c=false;
        cTT.EOF_Codice_Ordine_OM__c ='0000001';
        cTT.EOF_Order_Manager__c=true;
        cTT.OF_TroubleTicketManager__c=true;
        cTT.OF_Response_da_TTM__c ='ACK';
        insert cTT;    
        
                
        EOF_EAI_Service_Log__c notReq = new EOF_EAI_Service_Log__c();
        notReq.RecordTypeId = rtTTRequest.id;
        notReq.Caso__c=cTT.id;
        notReq.EOF_Codice_Comunicazione_OLO__c = 'Test0000000';
        notReq.EOF_Codice_Operatore__c = 'TIS';
        notReq.OF_SA_Direzione_Flusso__c = 'OLO -> SF';
        notReq.OF_SA_Metodo__c = OF_TTM_Utils.getStringTipoComunicazione('1');
        notReq.EOF_Tipo_Comunicazione__c = '1';
        notReq.EOF_Tipo_Comunicazione_String__c = 'OLO -> SF - TT ' + OF_TTM_Utils.getStringTipoComunicazione('1');
        notReq.EOF_Data_Notifica__c = System.now();
        notReq.EOF_ID_Notifica__c = 'IdNot00001';
        notReq.EOF_Richiesta_Notifica__c = 'TEST';
        notReq.EOF_ID_Risorsa__c = 'IdRis00001';
        notReq.EOF_Categoria_Guasto__c = '0';
        notReq.EOF_Data_Ora_Inizio_Guasto__c = system.Today().AddDays(-5);
        notReq.EOF_Data_Ora_Richiesta_Annullamento__c = System.today();
        notReq.EOF_Data_Ora_Desospensione__c = null;
        notReq.EOF_Data_Ora_Autoripristinato__c = null;
        notReq.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c = null;
        notReq.EOF_Causale_Desospensione__c = null;
        notReq.EOF_Nome_Cliente__c = 'NOME_CLIENTE';
        notReq.EOF_COgnome_CLiente__c = 'COGNOME_CLIENTE';
        notReq.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c = '333333333333';
        notReq.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c = '333333333333';
        notReq.EOF_NOME_REFERENTE_TECNICO_OLO__c = 'NOME_REFERENTE_TECNICO_OLO';
        notReq.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c = 'TELEFONO_REFERENTE_TECNICO_OLO';
        notReq.EOF_EMAIL_REFERENTE_TECNICO_OLO__c = 'tt.EMAIL_REFERENTE_TECNICO_OLO@emailTest.it';
        notReq.EOF_Referente_desospensione__c = 'tt.REFERENTE_DESOSPENSIONE';
        notReq.EOF_Verifica_apparato_cliente__c = 'Y';
        notReq.EOF_Descrizione_Problema__c = 'tt.DESCRIZIONE_PROBLEMA';
        notReq.EOF_NOTE_CLIENTE__c = 'tt.NOTE_CLIENTE';
        notReq.EOF_Causale_Apertura__c = '1';
        notReq.EOF_Intervento_Congiunto__c = 'N';
        notReq.EOF_Tec_OLO__c = 'tt.TEC_OLO';
        notReq.EOF_Tel_Tec_OLO__c = '3333333333';
        notReq.EOF_Data_Ora_Intervento_Congiunto__c = system.Now().AddDays(15);
        
        
        insert notReq;
        
        
        EOF_EAI_Service_Log__c notNotify = new EOF_EAI_Service_Log__c(); //Notifica
       
        notNotify.RecordTypeId = rtTTNotify.id;
        notNotify.Caso__c=cTT.id;
        notNotify.EOF_Codice_Comunicazione_OLO__c = 'Test0000000';
        notNotify.EOF_Codice_Operatore__c = 'TIS';
        notNotify.OF_SA_Direzione_Flusso__c = 'TTM -> SF';
        notNotify.OF_SA_Metodo__c = OF_TTM_WS_Notify_Utils.getMethodValue('4');
        notNotify.EOF_Tipo_Comunicazione__c = '4';
        notNotify.TTM_TICKETID__c= cTT.id;
        notNotify.EOF_Tipo_Comunicazione_String__c = OF_TTM_WS_Notify_Utils.getValueLogTipoCom('4', 'ACK');
        notNotify.EOF_Data_Notifica__c = System.now();
        notNotify.EOF_ID_Notifica__c = 'IdNot00001';
        notNotify.EOF_Richiesta_Notifica__c = 'TEST';
        notNotify.EOF_ID_Risorsa__c = 'IdRis00001';
        notNotify.DATA_ORA_CREAZIONE_TTM__c= system.Now();
        notNotify.EOF_Data_Ora_Notifica_Sospensione__c = system.Now();
        notNotify.EOF_Data_Ora_Notifica_Desospensione__c =null;
        notNotify.EOF_Data_Ora_Notifica_Annullamento__c = null;
        notNotify.EOF_Data_Ora_Notifica_Chiusura__c = null;
        notNotify.Causale_Sospensione__c ='Cliente Irreperibile';
        notNotify.EOF_Referente_desospensione__c ='tt.REFERENTE_DESOSPENSIONE';
        notNotify.Descrizione_Evento_Risoluzione__c = 'a.DESCRIZIONE_INTERVENTO_RISOLUZIONE';
        notNotify.EOF_Rischedulazione_Appuntamento__c = null;
        notNotify.EOF_Intervento_Congiunto__c = 'N';
        notNotify.EOF_Tec_OLO__c = 'tt.TEC_OLO';
        notNotify.EOF_Tel_Tec_OLO__c = '3333333333';
        notNotify.EOF_Data_Ora_Intervento_Congiunto__c = system.Now().AddDays(15);
        
        insert notNotify;
        
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
        eaiLog1.EOF_NOte__c = 'Test';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        
        
        TestDataFactory.CreateTestRecords(null,null, null);
        
          // custom settings creation for OF_TT_Parametri__c
        insert new OF_TT_Parametri__c(EOF_Num_min_ritorno_in_lavorazione__c = 360);
        // end custom settings creation for OF_TT_Parametri__c
        
        
        
        
        test.startTest();
       	OF_TTM_WS_IN_Notify_Services.coreSospensione(cTT,notNotify);
        notNotify.EOF_Rischedulazione_Appuntamento__c=System.Now().addDays(5);
        OF_TTM_WS_IN_Notify_Services.coreSospensione(cTT,notNotify);
        OF_TTM_WS_IN_Notify_Services.coreSospensione(cTT,notReq);
        notReq.EOF_Rischedulazione_Appuntamento__c=System.Now().addDays(5);
        OF_TTM_WS_IN_Notify_Services.coreSospensione(cTT,notReq);
         notNotify.EOF_Rischedulazione_Appuntamento__c=System.Now().addDays(-15);
        OF_TTM_WS_IN_Notify_Services.coreSospensione(cTT,notNotify);
        notReq.EOF_Rischedulazione_Appuntamento__c =system.Now().addDays(-15);
        OF_TTM_WS_IN_Notify_Services.coreSospensione(cTT,notReq);
        
        
        test.stopTest();
        
        
        
    }
    
}
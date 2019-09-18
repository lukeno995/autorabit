@isTest
public class OF_PP_GE_Utils_Test {
    
    static testMethod void syncError1()
    {
        test.startTest();
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest olo = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        
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
        OF_PP_GE_Utils.slOLOSF=eaiLog1;
       
		OF_PP_GE_Utils.syncError(olo,'A03','test');
        OF_PP_GE_Utils.syncError(olo,'A05','test');
		OF_PP_GE_Utils.syncError(olo,'A06','test');
        OF_PP_GE_Utils.syncError(olo,'A08','test');
        test.stopTest();
    }
    static testMethod void syncError2()
    {
        test.startTest();
        
        OF_PP_WS_IN_OLO_Activation.VLAN_PP vp=new  OF_PP_WS_IN_OLO_Activation.VLAN_PP ();
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
        OF_PP_GE_Utils.slOLOSF=eaiLog1;
        
        
         OF_PP_GE_Utils.syncError(vp,'A07','test');
         OF_PP_GE_Utils.syncError(vp,'B04','test');
         OF_PP_GE_Utils.syncError(vp,'A09','test');
         OF_PP_GE_Utils.syncError(vp,'A10','test');
        test.stopTest();
        
    }
     
    static testMethod void syncErrorVLAN1()
    {
        test.startTest();
        
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest olo = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
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
        eaiLog1.EOF_Response__c = 'NACK VLAN';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        OF_PP_GE_Utils.slOLOSF=eaiLog1;
       
        
        OF_PP_GE_Utils.syncErrorVLAN(olo,'A05','test');
        test.stopTest();
    }
    
    static testMethod void syncErrorVLAN2()
    {
         test.startTest();
        
        OF_PP_WS_IN_OLO_Activation.VLAN_PP vp=new  OF_PP_WS_IN_OLO_Activation.VLAN_PP();
        
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
        eaiLog1.EOF_Response__c = 'NACK VLAN';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
        OF_PP_GE_Utils.slOLOSF=eaiLog1;
      
        
        OF_PP_GE_Utils.syncErrorVLAN(vp,'B04','test');
        test.stopTest();
    }
   
   
    static testMethod void create_EAI_Logtest1()
    {
        test.startTest();
        OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest olo = new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
        
        OF_PP_GE_Utils.create_EAI_Log(olo);
        test.stopTest(); 
    }
    
     static testMethod void create_EAI_Logtest2()
    {   
        test.startTest();
        OF_PP_WS_IN_OLO_Activation.VLAN_PP vp=new  OF_PP_WS_IN_OLO_Activation.VLAN_PP ();
        
        OF_PP_GE_Utils.create_EAI_Log(vp);
        test.stopTest(); 
        
    }
     static testMethod void create_EAI_Logtest3()
    {   
        test.startTest();
        Map<String,String> mp=new Map<String,String>();
        mp.put('test','test');
        OF_PP_GE_Utils.create_EAI_Log(mp);
        test.stopTest(); 
        
    }
    static testMethod void create_ActivationToOM_Logtest()
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
        
        //list< EOF_EAI_Service_Log__c> sl=new list< EOF_EAI_Service_Log__c>();
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - VLAN - ActivationRequest').getRecordTypeId();
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
       
        eaiLog1.POP__c='test';
        
        //sl.add(eaiLog1);
        insert eaiLog1;
        list< EOF_EAI_Service_Log__c> sl= [select id,recordtypeId,recordtype.developername,EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_data_NOTIFICA__c,
                                               EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,POP__c,
                                               EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,
                                               EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                               EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                               EOF_PROMOZIONE__C,EOF_CLUSTER_PROMOZIONE__C,EOF_NOTE__C,EOF_SCALA_PALAZZINA__C,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__C,
                                               EOF_RECAPITO_TEST_LINEA__C,EOF_ID_Pop__c,EOF_PROFILO__C,PO_PP_POP_raccolta__c ,Banda_Interfaccia__c ,PO_PP_Interfaccia__c ,
    	            						   SVLAN__c ,PO_PP_cos_remarking__c ,
    	            						   PO_PP_dhcp_Option82__c ,PO_PP_cos_type__c ,
    	            						   PO_PP_cos_class__c ,Nome_del_KIT__c	 ,
    	            						   PO_PP_Progressivo_Ordine__c ,PO_PP_User_VLAN__c ,
    	                                       PO_PP_ID_Richiesta_testo__c , 
    	                                       EOF_Id_servizio__c ,
    	                                       EOF_CODICE_MOTIVAZIONE__c ,EOF_MOTIVAZIONE__c ,Caso__c,Caso__r.PO_PP_ID_Richiesta__c,EOF_ID_NOTIFICA__c from EOF_EAI_Service_Log__c ];
       // insert sl;
          OF_PP_GE_Utils.slSFOM=eaiLog1;
         OF_PP_GE_Utils.create_ActivationToOM_Log( c, sl);
        
        
        //For covering 2nd if
       
       
        
    }
    static testMethod void OLO_CreateStatusUpdate_Logtest()
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
        
        insert c;

        OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest olo =new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
        OF_PP_GE_Utils.OLO_CreateStatusUpdate_Log(c,olo);
         }
    
    static testMethod void OLO_CreateStatusUpdate_LogVLANtest()
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
        insert c;

       OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateRequestVLAN_PP olo =new OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateRequestVLAN_PP();
        OF_PP_GE_Utils.OLO_CreateStatusUpdate_LogVLAN(c,olo);
         }
        
    static testMethod void dateandStringtest()
    {
        datetime dt=datetime.now();
       OF_PP_GE_Utils.dateToString(dt);
        
        date d=date.today();
       OF_PP_GE_Utils.dateToStringNoTime(d);
        
       string s1 = string.valueof(datetime.now());
       OF_PP_GE_Utils.stringToDate(s1);
        
       string s2 = string.valueof(datetime.now());
       OF_PP_GE_Utils.stringToDateNoTime(s2);
        
       string s3 = string.valueof(datetime.now());
       OF_PP_GE_Utils.stringToDateTime(s3);
        
        datetime dt1=datetime.now();
       OF_PP_GE_Utils.DateTimeToString(dt1);
    }
    
    static testMethod void copy_notify_AcqCesstest()
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
        //OF_PP_GE_Utils.copy_notify_AcqCess(eaiLog1);
        
    }
    static testMethod void copy_requesttest1()
    {
     OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateRequestVLAN_PP olo=new OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateRequestVLAN_PP();
     OF_PP_GE_Utils.copy_request(olo);
        
    }
    static testMethod void copy_requesttest2()
    {
     OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest olo=new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
     OF_PP_GE_Utils.copy_request(olo);
        
    }
    static testMethod void copy_requesttest3()
    {
     OF_PP_WS_IN_OLO_Activation.VLAN_PP olo=new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
     OF_PP_GE_Utils.copy_request(olo);
        
    }
    
    
    static testMethod void makeCalloutOLOOMtest()
    {   
        EOF_EAI_Service_Log__c sl =new EOF_EAI_Service_Log__c();
        sl.EOF_Tipo_comunicazione__c='5';
        OF_PP_GE_Utils.makeCalloutOLOOM(sl);
    }
    
    static testMethod void Intandstringtest1()
    {
        test.startTest();
        for(integer i=1;i<=26;i++)
        {
            OF_PP_GE_Utils.IdservizioIntToString(i);
        }
        test.stopTest();
    }
        
      static testMethod void Intandstringtest2()
      {
        test.startTest();
        list<string> alphalist = new list<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
            for(string str : alphalist)
        {
             OF_PP_GE_Utils.IdservizioStringToInt(str); 
        }
        test.stopTest();
      }
        static testMethod void Intandstringtest3()
        {
        test.startTest();
        string metodo ='OM_StatusUpdate';
        list<string> nlist = new  list<string>{'0','1','2','3','4','5','6','7'};
            for(string str : nlist)
        {
             OF_PP_GE_Utils.returnStatusFromInt(str,metodo); 
        }
        test.stopTest();
        }
            
          static testMethod void Intandstringtest4()
        {
        test.startTest();
        string metodo ='OM_CompletionOrder';
        list<string> nlist = new  list<string>{'0','1'};
            for(string str : nlist)
        {
             OF_PP_GE_Utils.returnStatusFromInt(str,metodo); 
        }
        test.stopTest(); 
     }
        
     static testMethod void dateandtimetest()
     {
        
        string date1 = string.valueof(date.today());
        OF_PP_GE_Utils.checkDate(date1);
        
        string date2 = string.valueof(datetime.now());
        OF_PP_GE_Utils.checkTime(date2);
        
        string date3 = string.valueof(datetime.now());
        OF_PP_GE_Utils.checkDateTime(date3);
        
    
     }
    static testMethod void CreateTemplogOLOtest1()
    {
     OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest olo=new OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest();
     OF_PP_GE_Utils.CreateTemplogOLO(olo);
        
    }
    static testMethod void CreateTemplogOLOtest2()
    {
     OF_PP_WS_IN_OLO_Activation.VLAN_PP olo=new  OF_PP_WS_IN_OLO_Activation.VLAN_PP();
     OF_PP_GE_Utils.CreateTemplogOLO(olo);
        
    }
    static testMethod void  CreateTemlogOMtest1()
    {
     OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule olo=new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
     OF_PP_GE_Utils.CreateTemlogOM(olo);
        
    }
    static testMethod void  CreateTemlogOMtest2()
    {
     OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su=new  OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        
        
        list<string> nlist = new  list<string>{'0','1','2','3','4','5','6','7'};
            for(string str : nlist)
        {
              su.STATO_ORDINE=str;
              OF_PP_GE_Utils.CreateTemlogOM(su);
        }
    
        
    }
     static testMethod void  CreateTemlogOMtest3()
    {
    OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder su=new  OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
    
        list<string> nlist = new  list<string>{'0','1'};
            for(string str : nlist)
        {
              su.STATO_ORDINE=str;
              OF_PP_GE_Utils.CreateTemlogOM(su);
        }
        
    }
    static testMethod void partialTemplogtest()
    {   
        TEMPLOG__c  t1=new TEMPLOG__c ();
        OF_PP_GE_Utils.tmpl=t1;
        OF_PP_GE_Utils.partialTemplog('test');
       // OF_PP_GE_Utils.AttrTime=20:21:22;
        OF_PP_GE_Utils.EndTemplog();
    }
    static testMethod void getQuerytest1()
    {
    String s1='case';
    String s2='VLAN_Activation';
    OF_PP_GE_Utils.getQuery(s1,s2);
        
    }
    static testMethod void getQuerytest2()
    {
    String s1='sl';
    String s2='VLAN_Activation';
    OF_PP_GE_Utils.getQuery(s1,s2);
        
    }
    static testMethod void getQuerytest3()
    {
    String s1='sl';
    String s2='COS_Activation';
    OF_PP_GE_Utils.getQuery(s1,s2);
        
    }
    
    static testMethod void  simulateNACKtest1()
    {
    String s='OLO';
    OF_PP_GE_Utils.simulateNACK(s);
        
    }
    static testMethod void  simulateNACKtest2()
    {
    String s='OM';
    OF_PP_GE_Utils.simulateNACK(s);
        
    }
    
    
   
    
    
 

}
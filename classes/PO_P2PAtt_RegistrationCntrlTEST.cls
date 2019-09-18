@isTest
 class PO_P2PAtt_RegistrationCntrlTEST {
  
	static testMethod void test_ConstructorA(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       Test.stopTest(); 
        
    }  
     
    static testMethod void test_ConstructorB(){
        
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
        c.EOF_Account_OLO__c = acc.Id;
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
        
        //parentLog
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Bozza';
        insert eaiLog1;
        
        //childLog
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '12345678';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS1';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:07';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178230';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010400';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017401';
        eaiLog2.EOF_PROFILO__c = 'AG_11_30';
        eaiLog2.EOF_PROMOZIONE__c = '020100';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        eaiLog2.EOF_Stato_Richiesta__c='Bozza';
        insert eaiLog2;
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       ApexPages.currentPage().getParameters().put('parentId',eaiLog1.Id);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       Test.stopTest(); 
        
    } 
     
      static testMethod void test_ConstructorC(){
        
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
        c.EOF_Account_OLO__c = acc.Id;
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
          
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_CodiceIstat__c = 'Test';
        insert ele;
        
        //parentLog
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Bozza';
       // insert eaiLog1;
        
        //childLog
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '12345678';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS1';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:07';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178230';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010400';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017401';
        eaiLog2.EOF_PROFILO__c = 'AG_11_30';
        eaiLog2.EOF_PROMOZIONE__c = '020100';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        eaiLog2.EOF_Stato_Richiesta__c='Bozza';
        eaiLog2.OF_Id_Comune__c = ele.Id;
        insert eaiLog2;
          
        eaiLog1.EOF_SL_Riferimento__c = eaiLog2.id;
        insert eaiLog1;
          
       
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       ApexPages.currentPage().getParameters().put('cLogId',eaiLog2.Id);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       Test.stopTest(); 
        
    }
     
    static testMethod void test_getNumeroFibreA(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.tipoPercorso = 'Singola Via';
       pp.getNumeroFibre(pp.tipoPercorso);
       Test.stopTest(); 
        
    }
     
     static testMethod void test_getNumeroFibreB(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.tipoPercorso = 'Doppia Via';
       pp.getNumeroFibre(pp.tipoPercorso);
       Test.stopTest(); 
        
    }  
     
    static testMethod void test_uploadA(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.upload();
       Test.stopTest(); 
        
    }
     
    static testMethod void test_uploadB(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.fileName = 'Unit Test Attachment';
       pp.filebody = Blob.valueOf('Unit Test Attachment Body');
       pp.upload();
       Test.stopTest(); 
        
    }
   
    static testMethod void test_modificaVLAN (){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.modificaVLAN ();
       Test.stopTest(); 
        
    }
     
    static testMethod void test_insertNewVLAN(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.insertNewVLAN();
       Test.stopTest(); 
        
    }
     
    static testMethod void test_wrap(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       String ContactNamelable  = 'Test1';
       String ContactNamelable1 = 'Test2';
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       PO_P2PAtt_RegistrationCntrl.addAdressClass wrp = new PO_P2PAtt_RegistrationCntrl.addAdressClass(ContactNamelable,ContactNamelable1);
       wrp.ContactNameValue  = 'Value';
       wrp.ContactNameValue1 = 'Value1';
       Test.stopTest(); 
        
    }
     
     static testMethod void test_runSearchProfilo(){
         
       OF_CodificaProfiloListini__c codifica = new OF_CodificaProfiloListini__c();
       //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
       codifica.OF_Profilolistino__c = 'Test';
       codifica.Name = 'Name';
       codifica.IsPortalValid__c = true;
       insert codifica;
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       Apexpages.currentPage().getParameters().put('TextProfilo',codifica.OF_Profilolistino__c);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.runSearchProfilo();
       Test.stopTest(); 
        
    }
     
      static testMethod void test_deleteChildAlone(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.deleteChildAlone();
       Test.stopTest(); 
        
    }
     
      static testMethod void test_SaveParentChildLogInfo(){
          
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
        c.EOF_Account_OLO__c = acc.Id;
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
          
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_CodiceIstat__c = 'Test';
        insert ele;
        
        //parentLog
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Bozza';
       // insert eaiLog1;
        
        //childLog
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '12345678';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS1';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:07';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178230';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010400';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017401';
        eaiLog2.EOF_PROFILO__c = 'AG_11_30';
        eaiLog2.EOF_PROMOZIONE__c = '020100';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        eaiLog2.EOF_Stato_Richiesta__c='Bozza';
        eaiLog2.OF_Id_Comune__c = ele.Id;
        insert eaiLog2;
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.selectedIdComune = ele.id;
       pp.SaveParentChildLogInfo();
       Test.stopTest(); 
        
    }
     
     static testMethod void test_SaveParentChildLogInfoAndRedirect(){
         
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
        c.EOF_Account_OLO__c = acc.Id;
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
          
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_CodiceIstat__c = 'Test';
        insert ele;
        
        //parentLog
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Bozza';
       // insert eaiLog1;
        
        //childLog
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '12345678';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS1';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:07';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178230';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010400';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017401';
        eaiLog2.EOF_PROFILO__c = 'AG_11_30';
        eaiLog2.EOF_PROMOZIONE__c = '020100';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        eaiLog2.EOF_Stato_Richiesta__c='Bozza';
        eaiLog2.OF_Id_Comune__c = ele.Id;
        insert eaiLog2;
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.selectedIdComune = ele.id;
       pp.SaveParentChildLogInfoAndRedirect();
       Test.stopTest(); 
        
    }
     
    static testMethod void test_searchComune(){
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.searchTerm = 'Term';
       PO_P2PAtt_RegistrationCntrl.searchComune(pp.searchTerm);
       Test.stopTest(); 
        
    }
     
     
     static testMethod void test_cessaVLAN(){
         
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
        c.EOF_Account_OLO__c = acc.Id;
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
          
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_CodiceIstat__c = 'Test';
        insert ele;
        
        //parentLog
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
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
        eaiLog1.EOF_Stato_Richiesta__c='Bozza';
       // insert eaiLog1;
        
        //childLog
        String eaiRecordType2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog2 = new EOF_EAI_Service_Log__c();
        eaiLog2.Caso__c  = c.Id;
        eaiLog2.EOF_CLUSTER_PROMOZIONE__c = '12345678';
        eaiLog2.EOF_Codice_Operatore__c = 'TIS1';
        eaiLog2.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog2.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:07';
        eaiLog2.recordTypeId = eaiRecordType2;
        eaiLog2.OF_SA_ACK__c = true;
        eaiLog2.EOF_Data_Notifica__c = dateTime.now();
        eaiLog2.EOF_ID_Notifica__c = 'ID_178230';
        eaiLog2.EOF_ID_Risorsa__c = 'F3000010400';
        eaiLog2.EOF_ID_SERVIZIO__c = 'AAA0017401';
        eaiLog2.EOF_PROFILO__c = 'AG_11_30';
        eaiLog2.EOF_PROMOZIONE__c = '020100';
        eaiLog2.EOF_Response__c = 'ACK';
        eaiLog2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog2.EOF_Tipo_Comunicazione__c = '15';
        eaiLog2.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        eaiLog2.EOF_Stato_Richiesta__c='Bozza';
        eaiLog2.OF_Id_Comune__c = ele.Id;
        insert eaiLog2;
        
       Test.startTest();
       PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
       Test.setCurrentPage(pageRef);
       PO_P2PAtt_RegistrationCntrl pp = new PO_P2PAtt_RegistrationCntrl();
       pp.idVLAN = eaiLog2.id;
       pp.cessaVLAN ();
       Test.stopTest(); 
        
    }
     
     
   
     
     
}
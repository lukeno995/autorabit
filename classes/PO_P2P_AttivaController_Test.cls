@isTest
global class PO_P2P_AttivaController_Test
{    
    global static testMethod void testp2pAttivaController1()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'insVLAN');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }                        
        
    global static testMethod void testp2pAttivaController2()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editVLAN');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }
    
    /*
     * global static testMethod void testp2pAttivaController3()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'insApp');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }
*/
    global static testMethod void testp2pAttivaController4()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editApparato');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }
/*
    global static testMethod void testp2pAttivaController5()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'insServAgg');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }    
  */  
    global static testMethod void testp2pAttivaController6()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editServAgg');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }   
    
    global static testMethod void testp2pAttivaController8()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editServAgg');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  
   /* 
    global static testMethod void testp2pAttivaController9()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editAttivazione');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }     
    
    global static testMethod void testp2pAttivaController10()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editCessazione');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  

    global static testMethod void testp2pAttivaController11()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'confirmPageATT');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  

    global static testMethod void testp2pAttivaController12()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'confirmPageCESS');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  
*/
    global static testMethod void testp2pAttivaController13()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'attivazioneInserita');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  
/*
    global static testMethod void testp2pAttivaController14()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'cessazioneInserita');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  
*/
    global static testMethod void testp2pAttivaController15()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'InserimentoRichiestaATT');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  

    global static testMethod void testp2pAttivaController16()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'InserimentoRichiestaCESS');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  
/*
    global static testMethod void testp2pAttivaController17()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'reqChangeOrderInserita');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  
*/
    global static testMethod void testp2pAttivaController18()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'InserimentoRichiestaCHANORD');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }  

    global static testMethod void testp2pAttivaController19()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'CHANORD');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }      
    
    global static testMethod void testp2pAttivaController20()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'CESS');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }        
    /*
    global static testMethod void testp2pAttivaController21()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'successInsertCESS');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }          
    
    global static testMethod void testp2pAttivaController22()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'errorInsertCESS');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }          
    
    global static testMethod void testp2pAttivaController23()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'successInsertATT');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }
    
    global static testMethod void testp2pAttivaController24()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'errorInsertATT');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }    
    */
    global static testMethod void testp2pAttivaController25()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'attivazioneInoltrata');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }    
    
    global static testMethod void testp2pAttivaController26()
    {
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'cessazioneInoltrata');
        Test.setCurrentPage(pageRef);
        
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();             
    }    
    
    global static testMethod void testp2pAttivaController27()
    {        
        PO_P2P_AttivaController.goTo('testing');        
    }
    
    global static testMethod void testp2pAttivaController28()
    {
         Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('System Administrator'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');
      insert standard;
        
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
        //eaiLog1.standard
        eaiLog1.OwnerId = standard.id;
        insert eaiLog1;
        
        system.runas(standard){
        Test.startTest();
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'insApp');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('origId',eaiLog1.Id);
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();
        Test.stopTest();
        }
    } 
    
    global static testMethod void testp2pAttivaController29()
    {
         Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('System Administrator'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');
      insert standard;
        
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
        //eaiLog1.standard
        eaiLog1.OwnerId = standard.id;
        insert eaiLog1;
        
        system.runas(standard){
        Test.startTest();
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'insServAgg');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('origId',eaiLog1.Id);
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();
        Test.stopTest();
        }
    } 
    
    global static testMethod void testp2pAttivaController30()
    {
         Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('System Administrator'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');
      insert standard;
        
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
        //eaiLog1.standard
        eaiLog1.OwnerId = standard.id;
        insert eaiLog1;
        
        system.runas(standard){
        Test.startTest();
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editAttivazione');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('origId',eaiLog1.Id);
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();
        Test.stopTest();
        }
    } 
    
    global static testMethod void testp2pAttivaController31()
    {
         Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('System Administrator'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');
      insert standard;
        
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
        //eaiLog1.standard
        eaiLog1.OwnerId = standard.id;
        insert eaiLog1;
        
        system.runas(standard){
        Test.startTest();
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'editCessazione');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('origId',eaiLog1.Id);
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();
        Test.stopTest();
        }
    } 
    
     global static testMethod void testp2pAttivaController32()
    {
         Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('System Administrator'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');
      insert standard;
        
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
        //eaiLog1.standard
        eaiLog1.OwnerId = standard.id;
        insert eaiLog1;
        
        system.runas(standard){
        Test.startTest();
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'confirmPageATT');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('origId',eaiLog1.Id);
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();
        Test.stopTest();
        }
    } 
    
     global static testMethod void testp2pAttivaController33()
    {
         Map<String,ID> profiles = new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
      }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

      User standard = new User(alias = 'standt', 
      email='standarduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('System Administrator'), 
      timezonesidkey='America/Los_Angeles', 
      username='standarduser1234*@testorg.com');
      insert standard;
        
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
        //eaiLog1.standard
        eaiLog1.OwnerId = standard.id;
        insert eaiLog1;
        
        system.runas(standard){
        Test.startTest();
        PageReference pageRef = Page.PO_P2P_Attivo_DisplayRequest; // Add your VF page Name here
		pageRef.getParameters().put('proc', 'confirmPageCESS');
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('origId',eaiLog1.Id);
        PO_P2P_AttivaController theController = new PO_P2P_AttivaController();
        Test.stopTest();
        }
    } 
}
@isTest
public class PO_P2PAttiva_EditLogInfoCntrl_Test {
    
  static testMethod void testMethod4()
  {
      	TestDataFactory.CreateTestRecords(null, null, null);
		
		 Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		
        Profile prf = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
       Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('PO Partner').getRecordTypeId();
       

        
       //Create account

		Account acc = [select id, Name, AccountNumber, RecordtypeId, Recordtype.developerName, EOF_Codice_Operatore__c,
                       Class__c, VATNumber__c,BillingStreet, BillingPostalCode,
                       BillingCity, BillingState, BillingCountry, OwnerId
                       from Account 
                       where EOF_Codice_Operatore__c='TIS'];
       
       


//Create contact
         
 		Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
		cnt.FirstName='Test';
        cnt.LastName='TESTTEST';
        cnt.PO_P2P_Attiva__c=true;
        cnt.RecordTypeId=RecordTypeIdContact;
        cnt.PO_N_Licenza__c='1111';
         
 		Database.insert(cnt);           
        // insert cnt;		 
		 
		 
	//Create user
	Profile portalProfile = [SELECT Id FROM Profile WHERE Name LIKE '%Portal User%' Limit 1];

	User thisUser = new User(
    Username = System.now().millisecond() + 'test12345@test.com',
    ContactId = cnt.Id,
    ProfileId = portalProfile.Id,
    Alias = 'test123',
    Email = 'test12345@test.com',
    EmailEncodingKey = 'UTF-8',
    LastName = 'TESTTEST',
    CommunityNickname = 'test12345',
    TimeZoneSidKey = 'America/Los_Angeles',
    LocaleSidKey = 'en_US',
    LanguageLocaleKey = 'en_US'
	);
	Database.insert(thisUser);
    
  		test.startTest();      
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
		//	UserRoleID = Usr.Id and /* ProfileId =:prf.Id and */	
        OLO_ID__c olo = new OLO_ID__c();
         olo.name = 'TIS';
         olo.OF_Olo_Id__c = acc.Id;
       	 insert olo;   
         
        Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
         OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
       
        System.RunAs(thisUser)
        {            
        
 
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request'); //('PO_P2PAttiva_Request');
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        //sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        // //P2P_Attiva_Collegamento//P2P_Attiva_Collegamento /PO_Collegamento_P2P_Attiva
        
        sl.RecordTypeId=mpRT.get('OF_SA_Vlan');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Doppia Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2+2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.PO_Offerta__c='E-Access';
        insert sl;
        
      
        List<EOF_EAI_Service_Log__c> lst = new List<EOF_EAI_Service_Log__c>();
        lst.add(slFatt);
        lst.add(sl);
        //Inizia lo scope del test
        
        Test.setCurrentPage(Page.PO_P2PAttiva_EditLogInfo);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', sl.Id);
        ApexPages.currentPage().getParameters().put('TextProfilo', 'AG_11_36');
        //Setto l'id del parentLog
        //ApexPages.currentPage().getParameters().put('parentId', slFatt.Id);
        //Istanzio la classe da testare
        PO_P2PAttiva_EditLogInfoCntrl ctrl = new PO_P2PAttiva_EditLogInfoCntrl();
        ctrl.accountN= acc;
        ctrl.accId=acc.id;

        ctrl.fileBody = null;
        ctrl.upload();
        ctrl.getProfiloVLAN();
        //ctrl.runSearchProfilo();
        ctrl.profiloName = 'MONO_COS';
        ctrl.VLanMaxRagg(lst);  
        ctrl.insertChildLog();    
        ctrl.selectedIdComune = ele.Id;
        ctrl.insertMOde = true;
        ctrl.SaveParentChildLogInfo();
        ctrl.inserisciNuovoKit();
        ctrl.inserisciNuovoKit_OLD();
        ctrl.insertVlan();
        ctrl.insertNewVLAN();
        ctrl.modificaVLAN();
        ctrl.Annulla();
        ctrl.idVLAN=sl.Id;
        ctrl.cessaVLAN();
        //ctrl.getRecordProfili();
        ctrl.deleteChildAlone();
        ctrl.modifyProf();
       
       
        //Fine scope del test
        Test.stopTest();
        } 
    }
    
    static testMethod void testMethod5()
  {
      	TestDataFactory.CreateTestRecords(null, null, null);
		
		 Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		
        Profile prf = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
       Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('PO Partner').getRecordTypeId();
       

        //Create portal account owner

       /*  user portalAccountOwner1= [select id, UserRoleId, ProfileId, Username, Alias, 
                                    Email,EmailEncodingKey, Firstname,LastName, LanguageLocaleKey, 
                                    LocaleSidKey, TimeZoneSidKey 
                                    from User 
                                    where Alias = 'batman' 
                                    Limit 1];*/
//Create account

		Account acc = [select id, Name, AccountNumber, RecordtypeId, Recordtype.developerName, EOF_Codice_Operatore__c,
                       Class__c, VATNumber__c,BillingStreet, BillingPostalCode,
                       BillingCity, BillingState, BillingCountry, OwnerId
                       from Account 
                       where EOF_Codice_Operatore__c='TIS'];
       
        // acc.IsPartner = true;
        // acc.PO_P2P_Attiva__pc= true;
           
         
       //  insert acc;
	


//Create contact
         
 Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
		cnt.FirstName='Test';
        cnt.LastName='TESTTEST';
        cnt.PO_P2P_Attiva__c=true;
        cnt.RecordTypeId=RecordTypeIdContact;
        cnt.PO_N_Licenza__c='1111';
         
 Database.insert(cnt);           
      // insert cnt;		 
		 
		 
//Create user
Profile portalProfile = [SELECT Id FROM Profile WHERE Name LIKE '%Portal User%' Limit 1];

	User thisUser = new User(
    Username = System.now().millisecond() + 'test12345@test.com',
    ContactId = cnt.Id,
    ProfileId = portalProfile.Id,
    Alias = 'test123',
    Email = 'test12345@test.com',
    EmailEncodingKey = 'UTF-8',
    LastName = 'TESTTEST',
    CommunityNickname = 'test12345',
    TimeZoneSidKey = 'America/Los_Angeles',
    LocaleSidKey = 'en_US',
    LanguageLocaleKey = 'en_US'
	);
Database.insert(thisUser);
    
  test.startTest();      
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
		//	UserRoleID = Usr.Id and /* ProfileId =:prf.Id and */	
        OLO_ID__c olo = new OLO_ID__c();
            olo.name = 'TIS';
            olo.OF_Olo_Id__c = acc.Id;
        insert olo;   
         
          Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
         OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
       
        System.RunAs(thisUser)
        {            
        // String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        //account acc = new account();
		   
      /*      
        User ContactUser = [Select contactId from User where id=:UserInfo.getUserId()];
        System.debug('***ContactUser Id: '+ContactUser.Id);
        Id accId = acc.id;
        System.debug('***AccountId: '+accId);*/
      
       
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request'); //('PO_P2PAttiva_Request');
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        //sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        // //P2P_Attiva_Collegamento//P2P_Attiva_Collegamento /PO_Collegamento_P2P_Attiva
        
        sl.RecordTypeId=mpRT.get('OF_SA_Vlan');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Doppia Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2+2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        insert sl;
        
      
        List<EOF_EAI_Service_Log__c> lst = new List<EOF_EAI_Service_Log__c>();
        lst.add(slFatt);
        lst.add(sl);
        //Inizia lo scope del test
        
        Test.setCurrentPage(Page.PO_P2PAttiva_EditLogInfo);
        //Setto l'id del childLog
       // ApexPages.currentPage().getParameters().put('cLogId', sl.Id);
        //ApexPages.currentPage().getParameters().put('TextProfilo', 'AG_11_36');
        //Setto l'id del parentLog
        ApexPages.currentPage().getParameters().put('parentId', slFatt.Id);
        //Istanzio la classe da testare
        PO_P2PAttiva_EditLogInfoCntrl ctrl = new PO_P2PAttiva_EditLogInfoCntrl();
        ctrl.insertChildLog();
        ctrl.deleteChildAlone();
        ctrl.fileName='Unit Test Attachment';   
        ctrl.fileBody=Blob.valueOf('Unit Test Attachment Body');
        ctrl.upload();  
        Test.stopTest();
        } 
  }
    
    static testMethod void testMethod1(){
      TestDataFactory.CreateTestRecords(null, null, null);
		
		 Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		
        Profile prf = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
       Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('PO Partner').getRecordTypeId();
       

        //Create portal account owner

       /*  user portalAccountOwner1= [select id, UserRoleId, ProfileId, Username, Alias, 
                                    Email,EmailEncodingKey, Firstname,LastName, LanguageLocaleKey, 
                                    LocaleSidKey, TimeZoneSidKey 
                                    from User 
                                    where Alias = 'batman' 
                                    Limit 1];*/
//Create account

		Account acc = [select id, Name, AccountNumber, RecordtypeId, Recordtype.developerName, EOF_Codice_Operatore__c,
                       Class__c, VATNumber__c,BillingStreet, BillingPostalCode,
                       BillingCity, BillingState, BillingCountry, OwnerId
                       from Account 
                       where EOF_Codice_Operatore__c='TIS'];
       
        // acc.IsPartner = true;
        // acc.PO_P2P_Attiva__pc= true;
           
         
       //  insert acc;
	


//Create contact
         
 Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
		cnt.FirstName='Test';
        cnt.LastName='TESTTEST';
        cnt.PO_P2P_Attiva__c=true;
        cnt.RecordTypeId=RecordTypeIdContact;
        cnt.PO_N_Licenza__c='1111';
         
 Database.insert(cnt);           
      // insert cnt;		 
		 
		 
//Create user
Profile portalProfile = [SELECT Id FROM Profile WHERE Name LIKE '%Portal User%' Limit 1];

	User thisUser = new User(
    Username = System.now().millisecond() + 'test12345@test.com',
    ContactId = cnt.Id,
    ProfileId = portalProfile.Id,
    Alias = 'test123',
    Email = 'test12345@test.com',
    EmailEncodingKey = 'UTF-8',
    LastName = 'TESTTEST',
    CommunityNickname = 'test12345',
    TimeZoneSidKey = 'America/Los_Angeles',
    LocaleSidKey = 'en_US',
    LanguageLocaleKey = 'en_US'
	);
Database.insert(thisUser);
    
  test.startTest();      
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
		//	UserRoleID = Usr.Id and /* ProfileId =:prf.Id and */	
        OLO_ID__c olo = new OLO_ID__c();
            olo.name = 'TIS';
            olo.OF_Olo_Id__c = acc.Id;
        insert olo;   
         
          Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
         OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
       
        System.RunAs(thisUser)
        {            
        // String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        //account acc = new account();
		   
      /*      
        User ContactUser = [Select contactId from User where id=:UserInfo.getUserId()];
        System.debug('***ContactUser Id: '+ContactUser.Id);
        Id accId = acc.id;
        System.debug('***AccountId: '+accId);*/
      
       
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request'); //('PO_P2PAttiva_Request');
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        //sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        // //P2P_Attiva_Collegamento//P2P_Attiva_Collegamento /PO_Collegamento_P2P_Attiva
        
        sl.RecordTypeId=mpRT.get('OF_SA_Vlan');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Doppia Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2+2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.PO_Offerta__c='E-Line';
        insert sl;
        
      
        List<EOF_EAI_Service_Log__c> lst = new List<EOF_EAI_Service_Log__c>();
        lst.add(slFatt);
        lst.add(sl);
        //Inizia lo scope del test
        
        Test.setCurrentPage(Page.PO_P2PAttiva_EditLogInfo);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', sl.Id);
        //ApexPages.currentPage().getParameters().put('TextProfilo', 'AG_11_36');
        //Setto l'id del parentLog
        ApexPages.currentPage().getParameters().put('parentId', slFatt.Id);
        //Istanzio la classe da testare
        PO_P2PAttiva_EditLogInfoCntrl ctrl = new PO_P2PAttiva_EditLogInfoCntrl();
        ctrl.recordOfferta='test';  
        ctrl.searchTerm='Napoli';
        ctrl.searchTerm1='test';
        ctrl.selectedIdComune1='test';
        ctrl.selectedIdComune2='test';
        ctrl.urlPage='test';
        ctrl.NomeProgetto='test';
        ctrl.verifyProfilo='test';
        ctrl.profiloCommerciale='test';
        ctrl.searchvalue='test';
        ctrl.render1=true;
        ctrl.pirCOS5=1;
        ctrl.cirCOS5=2;
        ctrl.pirCOS3=3;
        ctrl.cirCOS3=4;
        ctrl.pirCOS1=5;
        ctrl.cirCOS1=6;
        ctrl.searchTerm2='6';   
        ctrl.sLogKit=sl;
        ctrl.P2PAttivaLogList=lst;
        ctrl.OF_ElencoComuniItalianiobj=null;
        ctrl.OF_ElencoComuniItalianiobj1=null; 
        ctrl.OF_ElencoComuniItalianiobj2=null;
        ctrl.retUrl='test';
        ctrl.accId=acc.id;
        ctrl.onkeyupAction();
        string searchTerm='Napoli'; 
        PO_P2PAttiva_EditLogInfoCntrl.searchComune(searchTerm);
                
        Test.stopTest();
        } 
        
        
    }
    
    static testMethod void testMethodgetRecordProfili(){
      TestDataFactory.CreateTestRecords(null, null, null);
		
		 Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
		
        Profile prf = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        
       Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('PO Partner').getRecordTypeId();
       

        //Create portal account owner

       /*  user portalAccountOwner1= [select id, UserRoleId, ProfileId, Username, Alias, 
                                    Email,EmailEncodingKey, Firstname,LastName, LanguageLocaleKey, 
                                    LocaleSidKey, TimeZoneSidKey 
                                    from User 
                                    where Alias = 'batman' 
                                    Limit 1];*/
//Create account

		Account acc = [select id, Name, AccountNumber, RecordtypeId, Recordtype.developerName, EOF_Codice_Operatore__c,
                       Class__c, VATNumber__c,BillingStreet, BillingPostalCode,
                       BillingCity, BillingState, BillingCountry, OwnerId
                       from Account 
                       where EOF_Codice_Operatore__c='TIS'];
       
        // acc.IsPartner = true;
        // acc.PO_P2P_Attiva__pc= true;
           
         
       //  insert acc;
	


//Create contact
         
 Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
		cnt.FirstName='Test';
        cnt.LastName='TESTTEST';
        cnt.PO_P2P_Attiva__c=true;
        cnt.RecordTypeId=RecordTypeIdContact;
        cnt.PO_N_Licenza__c='1111';
         
 Database.insert(cnt);           
      // insert cnt;		 
		 
		 
//Create user
Profile portalProfile = [SELECT Id FROM Profile WHERE Name LIKE '%Portal User%' Limit 1];

	User thisUser = new User(
    Username = System.now().millisecond() + 'test12345@test.com',
    ContactId = cnt.Id,
    ProfileId = portalProfile.Id,
    Alias = 'test123',
    Email = 'test12345@test.com',
    EmailEncodingKey = 'UTF-8',
    LastName = 'TESTTEST',
    CommunityNickname = 'test12345',
    TimeZoneSidKey = 'America/Los_Angeles',
    LocaleSidKey = 'en_US',
    LanguageLocaleKey = 'en_US'
	);
Database.insert(thisUser);
    
  test.startTest();      
        OF_ElencoComuniItaliani__c ele = new OF_ElencoComuniItaliani__c();
        ele.OF_Regione__c = 'Campania';
        ele.OF_Comune__c = 'Napoli';
        ele.OF_CodiceIstat__c = '123';
        insert ele;
        
		//	UserRoleID = Usr.Id and /* ProfileId =:prf.Id and */	
        OLO_ID__c olo = new OLO_ID__c();
            olo.name = 'TIS';
            olo.OF_Olo_Id__c = acc.Id;
        insert olo;   
         
          Contract contratto = new Contract();
        contratto.AccountId = acc.Id;
        contratto.Status = 'Attivo';  
        contratto.contractTerm = 6;
        contratto.StartDate = system.today();
        //cont.EndDate = system.today()+100;  
        insert contratto;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataFineValidita__c = system.today()+100;
        catalogo.OF_DataInizioValidita__c = system.today();
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        //servizio.Name = 'Open Stream';
        servizio.Name = 'P2P Attiva';
        servizio.OF_DataFineValidita__c = system.today()+10;
        servizio.OF_DataInizioValidita__c = system.today();
        servizio.OF_CatalogoCommerciale__c = catalogo.Id;
        insert servizio;
        
        OF_ContrattoServizio__c contrServ = new OF_ContrattoServizio__c();
        contrServ.OF_Servizio__c = servizio.id;
        contrServ.OF_Contract__c = contratto.id;
        insert contrServ;
         OF_AreaGeograficaJunction__c areaJunction = new OF_AreaGeograficaJunction__c();
        areaJunction.OF_Comune__c = 'Mondragone';
        areaJunction.OF_Contratto__c = contratto.id;
        insert areaJunction;
       
        System.RunAs(thisUser)
        {            
       
        List<EOF_EAI_Service_Log__c> slList= new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c='Test_nomeProgetto_001';
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request'); //('PO_P2PAttiva_Request');
       // map_IdCollIdOrdine.put(sLog.Caso__r.ParentId, sLog.Caso__c); 
        //slList.add(slFatt);
        insert slFatt;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Doppia Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2+2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.PO_Offerta__c='E-Line';
        insert sl;
            
        EOF_EAI_Service_Log__c slVlan= new EOF_EAI_Service_Log__c(); //sl Collegamento
        //sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento_ELine');
        // //P2P_Attiva_Collegamento//P2P_Attiva_Collegamento /PO_Collegamento_P2P_Attiva
        
        slVlan.RecordTypeId=mpRT.get('OF_SA_Vlan');
        slVlan.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        slVlan.PO_Tipo_percorso__c='Doppia Via';
        slVlan.PO_Indirizzo_collegamento__c='via test';
        slVlan.EOF_Comune__c='Roma';
        slVlan.EOF_Stato_Richiesta__c='Accettato';
        slVlan.PO_Offerta__c='P2P Attiva';
        slVlan.EOF_Codice_Operatore__c='TIS';
        //sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        slVlan.PO_Tipo_di_collegamento__c='Point-to-Point';
        
        slVlan.PO_Prime_Contractor__c='TEST';
        slVlan.PO_Incluso_nell_offerta__c=true;
        slVlan.PO_Numero_fibre_richieste__c='2+2';
        slVlan.EOF_PROFILO__c='1';
        slVlan.PO_Sito__c='test';
        slVlan.PO_Civico__c='12';
        slVlan.EOF_SL_Riferimento__c=sl.id;
        slVlan.PO_Offerta__c='E-Line';
        insert slVlan;    
        
      
        List<EOF_EAI_Service_Log__c> lst = new List<EOF_EAI_Service_Log__c>();
        lst.add(slFatt);
        lst.add(sl);
        //Inizia lo scope del test
        
        Test.setCurrentPage(Page.PO_P2PAttiva_EditLogInfo);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', sl.Id);
        //ApexPages.currentPage().getParameters().put('TextProfilo', 'AG_11_36');
        //Setto l'id del parentLog
        ApexPages.currentPage().getParameters().put('parentId', slFatt.Id);
        //Istanzio la classe da testare
        PO_P2PAttiva_EditLogInfoCntrl ctrl = new PO_P2PAttiva_EditLogInfoCntrl();
        ctrl.recordOfferta='test';  
        ctrl.searchTerm='Napoli';
        ctrl.searchTerm1='test';
        ctrl.selectedIdComune1='test';
        ctrl.selectedIdComune2='test';
        ctrl.urlPage='test';
        ctrl.NomeProgetto='test';
        ctrl.verifyProfilo='test';
        ctrl.profiloCommerciale='test';
        ctrl.searchvalue='test';
        ctrl.render1=true;
        ctrl.pirCOS5=1;
        ctrl.cirCOS5=2;
        ctrl.pirCOS3=3;
        ctrl.cirCOS3=4;
        ctrl.pirCOS1=5;
        ctrl.cirCOS1=6;
        ctrl.searchTerm2='6';   
        ctrl.sLogKit=sl;
        ctrl.P2PAttivaLogList=lst;
        ctrl.OF_ElencoComuniItalianiobj=null;
        ctrl.OF_ElencoComuniItalianiobj1=null; 
        ctrl.OF_ElencoComuniItalianiobj2=null;
        ctrl.retUrl='test';
        ctrl.accId=acc.id;
        ctrl.onkeyupAction();
       
        ctrl.getRecordProfili();
                
        Test.stopTest();
        } 
        
        
    }
    //EC 2019 06 06 Metodo in failed
    /*static testMethod void testMethod1(){
       
        Profile prf = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt11', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = prf.Id,UserRoleID = Usr.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'PFProduction@test.com',isactive = true);
        insert thisUser;
       
        System.RunAs(thisUser)
        {            
        // String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        //account acc = new account();
		Account acc = AccountCreation();
		
		Contact con = new Contact();
		con.AccountId = acc.Id;
		con.LastName = 'Test';
		insert con;
        
        OLO_ID__c olo = new OLO_ID__c();
            olo.name = 'VF';
            olo.OF_Olo_Id__c = acc.Id;
        insert olo;             
            
        User ContactUser = [Select contactId from User where id=:UserInfo.getUserId()];
        System.debug('***ContactUser Id: '+ContactUser.Id);
        Id accId = [Select AccountId from Contact where id =: ContactUser.ContactId].AccountId;
        System.debug('***AccountId: '+accId);
        Account accountN = [select Name from Account where id =:accId];
        System.debug('***accountN Id: '+accountN.id);
        
        EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        List<EOF_EAI_Service_Log__c> lst = new List<EOF_EAI_Service_Log__c>();
        lst.add(parentLog);
        lst.add(childLog);
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_EditLogInfo);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        ApexPages.currentPage().getParameters().put('TextProfilo', 'AG_11_36');
        //Setto l'id del parentLog
        //ApexPages.currentPage().getParameters().put('parentId', parentLog.Id);
        //Istanzio la classe da testare
        PO_P2PAttiva_EditLogInfoCntrl ctrl = new PO_P2PAttiva_EditLogInfoCntrl();
        ctrl.fileBody = null;
        ctrl.upload();
        ctrl.getProfiloVLAN();
        //ctrl.runSearchProfilo();
        ctrl.profiloName = 'MONO_COS';
        ctrl.VLanMaxRagg(lst);        
        ctrl.selectedIdComune = [SELECT Id FROM OF_ElencoComuniItaliani__c LIMIT 1].Id;
        ctrl.insertMOde = true;
        ctrl.SaveParentChildLogInfo();
        ctrl.insertNewVLAN();
        ctrl.Annulla();
        ctrl.modificaVLAN();
        //Fine scope del test
        Test.stopTest();
        } 
    }
    static testMethod void testMethod2(){
        EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_EditLogInfo);
        //Setto l'id del childLog
        //ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        //Setto l'id del parentLog
        ApexPages.currentPage().getParameters().put('parentId', parentLog.Id);
        //Istanzio la classe da testare
        PO_P2PAttiva_EditLogInfoCntrl ctrl = new PO_P2PAttiva_EditLogInfoCntrl();
        ctrl.insertChildLog();
        ctrl.fileBody = Blob.valueOf('ciao');
        ctrl.fileName = 'test_aa_attach';
        ctrl.upload();
        ctrl.idVLAN = childLog.Id;
        ctrl.cessaVLAN();
        ctrl.deleteChildAlone();
        //Fine scope del test
        Test.stopTest();
    }
    
    */

}
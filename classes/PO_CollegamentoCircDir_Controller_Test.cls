@isTest
public with sharing class PO_CollegamentoCircDir_Controller_Test {
    
    @testSetup
    public static void creazioneutenze()
    {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'PO Supporto Vendite'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
            
        );
        
        insert u;
        
        Group g = [Select id from Group where name ='Coda Ordini Fattibilità Supporto Vendite'];

        /////Adding users to Queue//////////
        GroupMember member = new GroupMember();
        member.UserOrGroupId = u.Id;
        member.GroupId = g.Id;
        
        insert member;
        
       
    }
    
    @isTest
    public static void PO_CollegamentoCircDir_ControllerTest1(){ 
        Group testGroup = new Group(Name='test group', Type='Queue');
        insert testGroup;
        
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            QueuesObject testQueue = new QueueSObject(QueueID = testGroup.id, SObjectType = 'Case');
            insert testQueue;
        }
        
        
        
        
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
                
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Circuiti Diretti', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_DarkFiber__c = true,
                               Subject = 'TestSetUpPadre',
                              ownerId = testGroup.Id);  
        insert padre;
        //Inserimento case Ordine
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_Circuiti_Diretti'), 
                                PO_Offerta__c = 'Circuiti Diretti', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_DarkFiber__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio',
                                OwnerId = testGroup.Id);  
        
        System.debug('OwnerID   '+ figlio.ownerId+ '   OwnerType   '+ figlio.Owner.Type);
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = false;
        dmo.assignmentRuleHeader.assignmentRuleID = null;
        figlio.setOptions(dmo);

        Database.SaveResult sr = Database.insert(figlio, dmo);

        
        system.debug('@@@@@@OWNER'+[select id,Type from Group where Name = 'Coda Ordini Fattibilità Supporto Vendite']);
        system.debug('@@@@@@OWNER'+figlio.OwnerId);
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        
        
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        
        User u = [select id from User where Email ='puser000@amamama.com'];
        
            TEst.startTest();
            
            PO_CollegamentoCircDir_Controller DarkFiberCtr = new  PO_CollegamentoCircDir_Controller(new ApexPages.StandardController(figlio));
            DarkFiberCtr.PrendiInCarico();
            DarkFiberCtr.setViewPopUpPSM();  
            DarkFiberCtr.updateLog(figlio.Id);
            DarkFiberCtr.setViewErrorFilePopUpPSM();    
            TEst.stopTest();
        
    }
    
    @isTest
    private static void findObjectNameFromRecordIdPrefixTest(){
        
        String recordIdOrPrefix='a0A';
        
        
        test.startTest();
        PO_CollegamentoCircDir_Controller.findObjectNameFromRecordIdPrefix(recordIdOrPrefix);
        test.stopTest();
    }
    
    
    @isTest
    
    private static void updateLogTest(){
        
        
        
        Group testGroup = new Group(Name='test group', Type='Queue');
        insert testGroup;
        
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            QueuesObject testQueue = new QueueSObject(QueueID = testGroup.id, SObjectType = 'Case');
            insert testQueue;
        }
        
        
        
        
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Circuiti Diretti', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_DarkFiber__c = true,
                               Subject = 'TestSetUpPadre',
                               ownerId = testGroup.Id);  
        insert padre;
        //Inserimento case Ordine
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_Circuiti_Diretti'), 
                                PO_Offerta__c = 'Circuiti Diretti', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_DarkFiber__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio',
                                OwnerId = testGroup.Id);  
        
        System.debug('OwnerID   '+ figlio.ownerId+ '   OwnerType   '+ figlio.Owner.Type);
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = false;
        dmo.assignmentRuleHeader.assignmentRuleID = null;
        figlio.setOptions(dmo);
        
        Database.SaveResult sr = Database.insert(figlio, dmo);
        
        
        system.debug('@@@@@@OWNER'+[select id,Type from Group where Name = 'Coda Ordini Fattibilità Supporto Vendite']);
        system.debug('@@@@@@OWNER'+figlio.OwnerId);
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        
        
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        
        
        EOF_EAI_Service_Log__c log= new EOF_EAI_Service_Log__c();
        log.Caso__c=figlio.id;
        insert log;
        
        
        PO_CollegamentoCircDir_Controller ccdc = new  PO_CollegamentoCircDir_Controller(new ApexPages.StandardController(figlio));
        
        
        
        test.startTest();
        ccdc.updateLog(figlio.id);
        test.stopTest();
        
        
    }
    
    
    
     @isTest
    
    private static void InvioPSMTest(){
        
        
        
     
        
        
        
        
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Circuiti Diretti', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_DarkFiber__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Ordine
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_Circuiti_Diretti'), 
                                PO_Offerta__c = 'Circuiti Diretti', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_DarkFiber__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        
        System.debug('OwnerID   '+ figlio.ownerId+ '   OwnerType   '+ figlio.Owner.Type);
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = false;
        dmo.assignmentRuleHeader.assignmentRuleID = null;
        figlio.setOptions(dmo);
        
        Database.SaveResult sr = Database.insert(figlio, dmo);
        
        
        system.debug('@@@@@@OWNER'+[select id,Type from Group where Name = 'Coda Ordini Fattibilità Supporto Vendite']);
        system.debug('@@@@@@OWNER'+figlio.OwnerId);
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        
        
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        
        
        EOF_EAI_Service_Log__c log= new EOF_EAI_Service_Log__c();
        log.Caso__c=figlio.id;
        insert log;
        
        
        PO_CollegamentoCircDir_Controller ccdc = new  PO_CollegamentoCircDir_Controller(new ApexPages.StandardController(figlio));
        
        
        
        test.startTest();
        ccdc.InvioPSM();
        test.stopTest();
    }
    
    
  
    
    
}
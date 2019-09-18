@isTest
public class PO_CollegamentoFiberLink_CtrlTest {
    @isTest 
    public static void FiberLinkBackend_test1(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio));
        FiberLinkCtr.sospendi();
        FiberLinkCtr.desospendi();
        FiberLinkCtr.annulla();
        FiberLinkCtr.PrendiInCarico();
        FiberLinkCtr.InviaAlNetworkCreation();
        FiberLinkCtr.setViewPopUpPSM();            
        FiberLinkCtr.setViewErrorFilePopUpPSM();            
    }
    
    @isTest
    public static void FiberLinkBackend_test2(){
        PO_ServFatt_DataFactory.wrapdata wrp = PO_ServFatt_DataFactory.createFiberLinkData();
        
        /*OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        
        if(ServFattList__c.getAll().get('Fiber Link') == null) PO_ServFatt_DataFactory.createCustomSettings();
        ServFattList__c cs = ServFattList__c.getAll().get('Fiber Link');
        Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
        OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
        List<OF_Servizio__c> servs = [SELECT Id, CreatedDate, Name FROM OF_Servizio__c WHERE Name = 'Fiber Link'];
        OF_Servizio__c serv = servs.size()>0? servs[0] : PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
        Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
        OF_Listino__c l = PO_ServFatt_DataFactory.createListino(serv, 'FiberLink_DEF');
        List<OF_CommercialElement__c> ce = [SELECT Id, CreatedDate, Name, OF_Servizio__r.Name FROM OF_CommercialElement__c WHERE OF_Servizio__r.Name = 'Fiber Link' AND Name = 'Fiber Link'];
        List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
        if( ce.isEmpty()) {
            ce.add(PO_ServFatt_DataFactory.createCE(serv, 'Fiber Link', 'CE-OF007775'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Canone', 'BE-OF077711'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Aggiuntivo', 'BE-OF007779'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Attivazione', 'BE-OF077710'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Disattivazione', 'BE-OF777119'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Migrazione', 'BE-OF777120'));
        }
        
        PO_ServFatt_DataFactory.createProductAppoggio();
        PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l);
        

       
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        RecordType caseRt = [SELECT Id FROM RecordType WHERE DeveloperName = :wrp.cs.caseDevName__c LIMIT 1];
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        
        Case c = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                           Contact = contactTest, 
                           PO_Offerta__c = 'Fiber Link', 
                           Status = 'In Lavorazione', 
                           Origin = 'Web',
                           Priority = 'Medium',
                           PO_Fiber_Link__c = true,
                           Subject = 'TestSetUpPadre');  
        insert c;
        //Inserimento case Collegamento
        Case c2 = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                            PO_Offerta__c = 'Fiber Link', 
                            Status = 'In Lavorazione',
                            PO_BB_1_via_interessato__c=4.3,
                            PO_Posa_1_via_nuovo_Drop__c=4.3,
                            PO_Tempi_di_attivazione_mesi__c=4.3,
                            PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                            PO_Area_Geografica__c='Centro',
                            PO_Assegnazione_Area_Geografica__c='Centro',
                            PO_Fiber_Link__c = true,
                            PO_Richiesta_a_fattibilit__c=c.Id,
                            PO_Esito_collegamento__c = 'SI Inf. OP',
                            EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
                            Subject = 'TestSetUpFiglio');  
        insert c2;
        Order o = PO_ServFatt_DataFactory.createOrder(contr, c);
        c.OF_Order__c = o.Id;
        c.OF_IDContratto__c = contr.Id;
        c.PO_Accordo_Quadro__c = contr.Id;
        c.PO_Case_Collegamento__c = c2.Id;
        c2.ParentId = c.Id;
        c2.PO_Costo_lavori_civili__c = 10;
        c2.PO_Tipo_percorso__c='DOPPIA VIA DIVERSIFICATA';
        c2.PO_Numero_fibre_richieste__c='2+2';
        c2.PO_BB_1_via_interessato__c=100;
        c2.PO_Posa_1_via_nuovo_Drop__c=200;
        c2.OF_SA_Profilo__c = '';
        update c;
        update c2;
         */
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = wrp.casecollegamento.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        
        ApexPages.currentPage().getParameters().put('Id', wrp.casecollegamento.Id);
        
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(wrp.casecollegamento)); 
        FiberLinkCtr.esitiCompletati(); 
    }
    
    @isTest 
    public static void FiberLinkBackend_test3(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio));         
        FiberLinkCtr.InvioPSM();     
        FiberLinkCtr.assegnaAlTecnico();
    }
    
    @isTest
    public static void FiberLinkBackend_test4(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               OwnerId = [select Id from Group where Name = 'Coda Ref. Fattibilità Centro' and Type = 'Queue'].Id, 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento1
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_Fiber_Link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                OwnerId = [select Id from Group where Name = 'Coda Ref. Fattibilità Centro' and Type = 'Queue'].Id, 
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Fase__c='In Lavorazione Supporto Vendite',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina1
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'SupVenToRefFat');
        ApexPages.currentPage().getParameters().put('OLO', 'true');
        User u = [SELECT Id, Name, Profile.Name FROM User WHERE Profile.Name != 'System Administrator'][0];
        System.runAs(u){
            PO_CollegamentoFiberLink_Controller FiberLinkCtr1 = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); // controllare parametri
            FiberLinkCtr1.PrendiInCarico();	
            FiberLinkCtr1.InviaAlDelivery();
            FiberLinkCtr1.InviaAlSupportoVendite();
            
        }
    }
    
    @isTest 
    public static void FiberLinkBackend_test5(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                PO_Owner_Originario__c = 'Test', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Network Creation',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Sos');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        FiberLinkCtr.inserisciNote();         
    }
    
    @isTest
    public static void FiberLinkBackend_test6(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Network Creation',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Del');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        FiberLinkCtr.inserisciNote();         
    }
    
    @isTest
    public static void FiberLinkBackend_test7(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Network Creation',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Des');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        FiberLinkCtr.inserisciNote();           
    }
    
    @isTest
    public static void FiberLinkBackend_test8(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Referente Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NetCreToSupVen');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        FiberLinkCtr.inviaAlTecFat();    
        FiberLinkCtr.inserisciNote();   
    }
    
    
    @isTest 
    public static void FiberLinkBackend_test9(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Network Creation',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'DelToSupVen');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        FiberLinkCtr.inviaAlTecFat();          
        FiberLinkCtr.inserisciNote();  
    }
    
    @isTest
    public static void FiberLinkBackend_test10(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Supporto Vendite',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'Ann');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        FiberLinkCtr.inviaAlRefFat();        
        FiberLinkCtr.inserisciNote();      
        
    }
    
    @isTest 
    public static void FiberLinkBackend_test11(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NC');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        FiberLinkCtr.inviaAlRefFat();        
        FiberLinkCtr.inserisciNote();    
    }
    
    @isTest 
    public static void FiberLinkBackend_test12(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Fase__c='In Attesa Presa In Carico Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio));
        FiberLinkCtr.assegnaAlTecnico();     
        FiberLinkCtr.setViewPopUpPSM();            
        FiberLinkCtr.setViewErrorFilePopUpPSM();
        FiberLinkCtr.assegnaAlTecnico();    }
    
    //pp
    @isTest
    public static void FiberLinkListino_test(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;         
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Fiber_Link__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c = 'Test',
                                EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NC');
        
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio)); 
        
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','1',900,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','1',2100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','1',3100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','1',4100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','1',5100,'1');
        
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2',900,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2',2100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2',3100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2',4100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2',5100,'1');
        
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','4',900,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','4',2100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','4',3100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','4',4100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','4',5100,'1');
        
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('DOPPIA VIA DIVERSIFICATA','2+2',900,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2+2',2100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2+2',3100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2+2',4100,'1');
        PO_CollegamentoFiberLink_Controller.calcolaListiniFL('SINGOLA VIA','2+2',5100,'1');
        
    }
    
    @isTest 
    public static void FiberLinkBackend_test13(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID'; 
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Nord Ovest',
                                PO_Assegnazione_Area_Geografica__c='Nord Ovest',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c= 'Test',
                                EOF_Note__c = 'Test',
                                EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NC');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio));
        FiberLinkCtr.mostraNoteTecFatToRefFat = true;
        FiberLinkCtr.mostraNoteTecFatToNetCre = true;
        FiberLinkCtr.inserisciNote();  
    }
    
    @isTest 
    public static void FiberLinkBackend_test14(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID'; 
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        //Inserimento case Richiesta di fattibilità
        Case padre = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'Fiber Link', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_Fiber_link'), 
                                PO_Offerta__c = 'Fiber Link', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Nord Ovest',
                                PO_Assegnazione_Area_Geografica__c='Nord Ovest',
                                PO_Fiber_Link__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
                                EOF_Note_Operatore__c= 'Test',
                                EOF_Note__c = 'Test',
                                EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'SupVenToNetCre');
        PO_CollegamentoFiberLink_Controller FiberLinkCtr = new  PO_CollegamentoFiberLink_Controller(new ApexPages.StandardController(figlio));
        FiberLinkCtr.esitiCompletati();
        FiberLinkCtr.title='';
        FiberLinkCtr.CaseId='';
        FiberLinkCtr.idNotify='';
        FiberLinkCtr.urlRedir='';
        FiberLinkCtr.perform='';
        FiberLinkCtr.getMethodStatic();
    }    
}
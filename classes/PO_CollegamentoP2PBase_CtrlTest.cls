@isTest
public class PO_CollegamentoP2PBase_CtrlTest {
    @isTest 
    public static void P2PBaseBackend_test1(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio));
        P2PBaseCtr.sospendi();
        P2PBaseCtr.desospendi();
        P2PBaseCtr.annulla();
        P2PBaseCtr.PrendiInCarico();
        P2PBaseCtr.InviaAlNetworkCreation();
        //P2PBaseCtr.InviaAlSupportoVendite();
        P2PBaseCtr.setViewPopUpPSM();            
        P2PBaseCtr.setViewErrorFilePopUpPSM(); 
        PO_CollegamentoP2PBase_Controller.findObjectNameFromRecordIdPrefix('recordIdOrPrefix');
    }
    
    @isTest 
    public static void P2PBaseBackend_test2(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe; 
        if(ServFattList__c.getAll().get('P2P Base') == null) PO_ServFatt_DataFactory.createCustomSettings();
        ServFattList__c cs = ServFattList__c.getAll().get('P2P Base');
        Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
        OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
        List<OF_Servizio__c> servs = [SELECT Id, CreatedDate, Name FROM OF_Servizio__c WHERE Name = 'P2P Base'];
        OF_Servizio__c serv = servs.size()>0? servs[0] : PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
        Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
        OF_Listino__c l = PO_ServFatt_DataFactory.createListino(serv, 'P2PBASE_MONOFIBRA');
        List<OF_CommercialElement__c> ce = [SELECT Id, CreatedDate, Name, OF_Servizio__r.Name FROM OF_CommercialElement__c WHERE OF_Servizio__r.Name = 'P2P Base' AND Name = 'Punto Punto Passiva'];
        List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
        if( ce.isEmpty()) {
            ce.add(PO_ServFatt_DataFactory.createCE(serv, 'Punto Punto Passiva', 'CE-OF000009'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Attivazione', 'BE-OF000020'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Canone', 'BE-OF000018'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Aggiuntivo', 'BE-OF000017'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Disattivazione', 'BE-OF000019'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Migrazione', 'BE-OF000021'));
        }
        PO_ServFatt_DataFactory.createProductAppoggio();
        PO_ServFatt_DataFactory.createPriceBooksWithProduct(beList, l);
        RecordType caseRt = [SELECT Id FROM RecordType WHERE DeveloperName = :cs.caseDevName__c LIMIT 1];
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        Case c = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                           Contact = contactTest, 
                           PO_Offerta__c = 'P2P Base', 
                           Status = 'In Lavorazione', 
                           Origin = 'Web',
                           Priority = 'Medium',
                           PO_P2P_Base__c = true,
                           Subject = 'TestSetUpPadre');  
        insert c;
        //Inserimento case Collegamento
        Case c2 = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                            PO_Offerta__c = 'P2P Base', 
                            Status = 'In Lavorazione',
                            PO_BB_1_via_interessato__c=4.3,
                            PO_Posa_1_via_nuovo_Drop__c=4.3,
                            PO_Tempi_di_attivazione_mesi__c=4.3,
                            PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                            PO_Area_Geografica__c='Centro',
                            PO_Assegnazione_Area_Geografica__c='Centro',
                            PO_P2P_Base__c = true,
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
        update c;
        update c2;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = c2.Id);
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', c2.Id);
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(c2)); 
        P2PBaseCtr.esitiCompletati(); 
    }
    
    @isTest
    public static void P2PBaseBackend_test3(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio));         
        P2PBaseCtr.InvioPSM();     
        P2PBaseCtr.assegnaAlTecnico();
    }
    
    @isTest 
    public static void P2PBaseBackend_test4(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento1
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                OwnerId = [select Id from Group where Name = 'Coda Ref. Fattibilità Centro' and Type = 'Queue'].Id, 
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
            PO_CollegamentoP2PBase_Controller P2PBaseCtr1 = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); // controllare parametri
            P2PBaseCtr1.PrendiInCarico();	
            P2PBaseCtr1.InviaAlDelivery();
        }
    }
    
    @isTest
    public static void P2PBaseBackend_test5(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                PO_Owner_Originario__c = 'Test', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.inserisciNote();         
    }
    
    @isTest 
    public static void P2PBaseBackend_test6(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.inserisciNote();         
    }
    
    @isTest 
    public static void P2PBaseBackend_test7(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.inserisciNote();           
    }
    
    @isTest
    public static void P2PBaseBackend_test8(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.inviaAlTecFat();    
        P2PBaseCtr.inserisciNote();   
    }
    
    @isTest
    public static void P2PBaseBackend_test9(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.inviaAlTecFat();          
        P2PBaseCtr.inserisciNote();  
    }
    
    @isTest 
    public static void P2PBaseBackend_test10(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.inviaAlRefFat();        
        P2PBaseCtr.inserisciNote();      
        
    }
    
    @isTest 
    public static void P2PBaseBackend_test11(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.inviaAlRefFat();
        P2PBaseCtr.sospendi();
        //P2PBaseCtr.InviaAlSupportoVendite();        
        P2PBaseCtr.inserisciNote();    
    }
    
    @isTest
    public static void P2PBaseBackend_test12(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio));         
        P2PBaseCtr.assegnaAlTecnico();     
        P2PBaseCtr.setViewPopUpPSM();            
        P2PBaseCtr.setViewErrorFilePopUpPSM();
        P2PBaseCtr.assegnaAlTecnico();
        P2PBaseCtr.InviaAlSupportoVendite();
    }
    
    @isTest
    public static void P2PBaseBackend_test13(){
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
                               PO_Offerta__c = 'P2P Base', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_P2P_Base__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_P2P'), 
                                PO_Offerta__c = 'P2P Base', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_P2P_Base__c = true,
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
        PO_CollegamentoP2PBase_Controller P2PBaseCtr = new  PO_CollegamentoP2PBase_Controller(new ApexPages.StandardController(figlio)); 
        P2PBaseCtr.mostraNoteTecFatToRefFat = true;
        P2PBaseCtr.mostraNoteTecFatToNetCre = true;
        P2PBaseCtr.inserisciNote();    
    }
}
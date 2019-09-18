@isTest
public class PO_CollegamentoBTS_CtrlTest {
    @isTest
    public static void BTSBackend_test1(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                EOF_COmunicazioni_con_OLO__c = 'OLO',
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio));
        BTSCtr.sospendi();
        BTSCtr.desospendi();
        BTSCtr.annulla();
        BTSCtr.PrendiInCarico();
        BTSCtr.InviaAlNetworkCreation();
        BTSCtr.InviaAlSupportoVendite();
        BTSCtr.setViewPopUpPSM();            
        BTSCtr.setViewErrorFilePopUpPSM();            
    }
    
    @isTest
    public static void BTSBackend_test2(){
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;  
        if(ServFattList__c.getAll().get('BTS') == null) PO_ServFatt_DataFactory.createCustomSettings();
        ServFattList__c cs = ServFattList__c.getAll().get('BTS');
        Account acc = PO_ServFatt_DataFactory.createAccount('Tiscali ', 'TIS');
        OF_CatalogoCommerciale__c catal = PO_ServFatt_DataFactory.createCatalogo();
        List<OF_Servizio__c> servs = [SELECT Id, CreatedDate, Name FROM OF_Servizio__c WHERE Name = 'BTS'];
        OF_Servizio__c serv = servs.size()>0? servs[0] : PO_ServFatt_DataFactory.createServizio(catal, cs.Name, cs.code__c);
        Contract contr = PO_ServFatt_DataFactory.createContract(acc, serv);
        OF_Listino__c l = PO_ServFatt_DataFactory.createListino(serv, 'BTS_DEF');
        List<OF_CommercialElement__c> ce = [SELECT Id, CreatedDate, Name, OF_Servizio__r.Name FROM OF_CommercialElement__c WHERE OF_Servizio__r.Name = 'BTS' AND Name = 'BTS'];
        List<OF_CommercialElement__c> ce2 = [SELECT Id, CreatedDate, Name, OF_Servizio__r.Name FROM OF_CommercialElement__c WHERE OF_Servizio__r.Name = 'BTS' AND Name = 'Manutenzione'];
        List<OF_BillingElement__c> beList = new List<OF_BillingElement__c>();
        if( ce.isEmpty()) {
            ce.add(PO_ServFatt_DataFactory.createCE(serv, 'BTS', 'CE-OF007775'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Corrispettivo IRU', 'BE-OF077711'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Aggiuntivo', 'BE-OF007779'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Attivazione', 'BE-OF077710'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce[0], 'Contributo Disattivazione', 'BE-OF777119'));
        }
        if(ce2.isEmpty()){
            ce2.add(PO_ServFatt_DataFactory.createCE(serv, 'Manutenzione', 'CE-OF007776'));
            beList.add(PO_ServFatt_DataFactory.createBE(ce2[0], 'Canone Manutenzione', 'BE-OF077712'));
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
                           PO_Offerta__c = 'BTS', 
                           Status = 'In Lavorazione', 
                           Origin = 'Web',
                           Priority = 'Medium',
                           PO_BTS__c = true,
                           Subject = 'TestSetUpPadre');  
        insert c;
        //Inserimento case Collegamento
        Case c2 = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                            PO_Offerta__c = 'BTS', 
                            Status = 'In Lavorazione',
                            PO_BB_1_via_interessato__c=4.3,
                            PO_Posa_1_via_nuovo_Drop__c=4.3,
                            PO_Tempi_di_attivazione_mesi__c=4.3,
                            PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                            PO_Area_Geografica__c='Centro',
                            PO_Assegnazione_Area_Geografica__c='Centro',
                            PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(c2)); 
        BTSCtr.esitiCompletati(); 
        BTSCtr.assegnaAlTecnico();     
        BTSCtr.setViewPopUpPSM();            
        BTSCtr.setViewErrorFilePopUpPSM();
        BTSCtr.assegnaAlTecnico();
    }
    
    @isTest
    public static void BTSBackend_test3(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio));         
        BTSCtr.InvioPSM();     
        BTSCtr.assegnaAlTecnico();
    }
    
    @isTest
    public static void BTSBackend_test4(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento1
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Ordine_BTS'), 
                                 PO_Offerta__c = 'BTS', 
                                 Status = 'In Lavorazione',
                                 OwnerId = [select Id from Group where Name = 'Coda Ref. Fattibilità Centro' and Type = 'Queue'].Id, 
                                 PO_BB_1_via_interessato__c=4.3,
                                 PO_Posa_1_via_nuovo_Drop__c=4.3,
                                 PO_Tempi_di_attivazione_mesi__c=4.3,
                                 PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                 PO_Area_Geografica__c='Centro',
                                 PO_Assegnazione_Area_Geografica__c='Centro',
                                 PO_BTS__c = true,
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
            PO_CollegamentoBTS_Controller BTSCtr1 = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); // controllare parametri
            BTSCtr1.PrendiInCarico();	
            BTSCtr1.InviaAlDelivery();
        }
    }

    @isTest 
    public static void BTSBackend_test5(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                PO_Owner_Originario__c = 'Test', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.inserisciNote();         
    }
    
    @isTest 
    public static void BTSBackend_test6(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.inserisciNote();         
    }
    
    @isTest
    public static void BTSBackend_test7(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.inserisciNote();           
    }
    
    @isTest
    public static void BTSBackend_test8(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.inviaAlTecFat();    
        BTSCtr.inserisciNote();   
    }


    @isTest
    public static void BTSBackend_test9(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.inviaAlTecFat();          
        BTSCtr.inserisciNote();  
    }
    
    @isTest
    public static void BTSBackend_test10(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'Acquisito',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.inviaAlRefFat();        
        BTSCtr.inserisciNote();      
      
    }
    
    @isTest 
    public static void BTSBackend_test11(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'Sospeso',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Centro',
                                PO_Assegnazione_Area_Geografica__c='Centro',
                                PO_BTS__c = true,
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
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.inviaAlRefFat();        
        BTSCtr.inserisciNote();    
    }
    
    @isTest
    public static void BTSBackend_test12(){
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
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               EOF_Fase__c = 'In Lavorazione Network Creation',
                               Origin = 'Web',
                               PO_Owner_Originario__c = 'Test',
                               Priority = 'Medium',
                               PO_BTS__c = true,
                               Subject = 'TestSetUpPadre');  
        insert padre;
        //Inserimento case Collegamento
        Case figlio = new Case (RecordTypeId = RecordTypeNameId.get('PO_Collegamento_BTS'), 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione',
                                PO_BB_1_via_interessato__c=4.3,
                                PO_Posa_1_via_nuovo_Drop__c=4.3,
                                PO_Tempi_di_attivazione_mesi__c=4.3,
                                PO_Disponibilit_della_rete_a_partire_da__c=date.today(),
                                PO_Area_Geografica__c='Nord Est',
                                PO_Assegnazione_Area_Geografica__c='Nord Est',
                                PO_BTS__c = true,
                                PO_Richiesta_a_fattibilit__c=padre.Id,
                                PO_Esito_collegamento__c = 'SI Inf. OP',
								EOF_Note_Operatore__c = 'Test',
								EOF_Note_Interne__c = 'Test',
                                EOF_Fase__c='In Lavorazione Tecnico Fattibilità',
                                PO_Owner_Originario__c = 'Test',
                                Subject = 'TestSetUpFiglio');  
        insert figlio;
        EOF_EAI_Service_Log__c logFiglio = new EOF_EAI_Service_Log__c ( Caso__c = figlio.Id, eof_comunicazioni_con_olo__c = 'Test');
        insert logFiglio;
        //Creazione pagina
        PageReference pageRef = Page.PO_ServiziFattibilita_Buttons_Page;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', figlio.Id);
        ApexPages.currentPage().getParameters().put('Oper', 'NC');
        PO_CollegamentoBTS_Controller BTSCtr = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(figlio)); 
        BTSCtr.mostraNoteTecFatToRefFat = true;
        BTSCtr.mostraNoteTecFatToNetCre = true;
        BTSCtr.title = 'Test';
        BTSCtr.CaseId = 'Test';
        BTSCtr.idNotify = 'Test';
        BTSCtr.urlRedir = 'Test';
        BTSCtr.perform = 'Test';
        BTSCtr.inserisciNote();   
        BTSCtr.InviaAlSupportoVendite();    
        PO_CollegamentoBTS_Controller BTSCtr1 = new  PO_CollegamentoBTS_Controller(new ApexPages.StandardController(padre)); 
        BTSCtr1.collegamentoFattibilita = true;
        BTSCtr1.inserisciNote();  
    }
    
}
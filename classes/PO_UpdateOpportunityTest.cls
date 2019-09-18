@isTest
Public class PO_UpdateOpportunityTest{
    
    static testMethod void UpdateQuarter(){
        PO_ServFatt_DataFactory.createCustomSettings();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        test.starttest();
        OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo.Name='13';
        fiberPrezzo.Prezzo__c=70;
        fiberPrezzo.Anno__c= 'Anno13';
        insert fiberPrezzo;
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo1.Name='Backbone1';
        fiberPrezzo1.Prezzo__c=70;
        
        insert fiberPrezzo1; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo2.Name='Backbone2';
        fiberPrezzo2.Prezzo__c=70;
        
        insert fiberPrezzo2; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo3.Name='Drop1';
        fiberPrezzo3.Prezzo__c=70;
        
        insert fiberPrezzo3; 
        
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo4.Name='Drop2';
        fiberPrezzo4.Prezzo__c=70;
        
        insert fiberPrezzo4; 
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name='Default';
        paramFat.Fascia1__c=1;
        insert paramFat; 
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        Account AcntRec1 = new Account(name = 'Acc1', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec1;
        
        Product2 prod = new Product2(Name = 'Laptop X200',Family = 'Hardware');
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2(Name= 'P2P BaseAcc', isActive=true);
        insert customPB;
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id,
                                                        UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        // Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        // Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.recordtypeId = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Posa_1_nuovo_Drop__c=100;
        
        parentCase.PO_BB_1_interessato__c = 2;
        parentCase.PO_BB_2_interessato__c =2;
        //parentCase.PO_Tipologia_Offerta__c = 'P2P Base';
        // parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In lavorazione'; //FD 2019-01-22 CLassi di test
        insert parentCase;
        
        List<Opportunity> listOpp = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c =parentCase.ID, name='Opp',Pricebook2id= customPB.Id, stageName='Open', closeDate=Date.newInstance(2008,10,10));
        //insert OppRecA;
        
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c =parentCase.ID, name='Opp',Pricebook2id= customPB.Id, stageName='Open', closeDate=Date.newInstance(2008,10,10));
        //insert OppRecA1; 
        
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=parentCase.Id, name='Opp',Pricebook2id= customPB.Id, stageName='Open', closeDate=Date.newInstance(2008,10,10));
        //insert OppRecA2;
        
        listOpp.add(OppRecA);
        listOpp.add(OppRecA1);
        listOpp.add(OppRecA2);
		insert listOpp;
        
        OF_CatalogoCommerciale__c ofc =New OF_CatalogoCommerciale__c(Name='P2P BaseAcc',OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        insert ofc;
        
        OF_Servizio__c ser = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        insert ser;
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec1.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        insert ser1;
        test.stopTest();
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        //update OppRecA;
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=customPrice.id, UnitPrice = 100, Quantity = 3);
        //insert OppLI_Rec;
    }
    
    //FD 2019-01-22 Classi di test - START
    @isTest
    public static void PO_UpdateOpportunityTest_method1(){
        PO_ServFatt_DataFactory.createCustomSettings();
        Opportunity offertaTotale = new Opportunity(CloseDate = date.today(),
                                                     Name = 'Offerta Totale',
                                                     StageName = 'Prospecting');
        insert OffertaTotale;
        
        Opportunity backhaulingOpp = new Opportunity(CloseDate = date.today(),
                                                     Name = 'backhaulingOpp',
                                                     StageName = 'Prospecting',
                                                     RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Oppty_collegamenti_Backhauling'].Id,
                                                     PO_Offerta_totale__c = offertaTotale.Id,
                                                     PO_Canone_collegamento__c =987);
        
        insert backhaulingOpp;
        backhaulingOpp.PO_Canone_collegamento__c = 234;
        update backhaulingOpp;
    }
       
    @isTest
    public static void PO_UpdateOpportunityTest_method2(){
        PO_ServFatt_DataFactory.createCustomSettings();
        Opportunity offertaTotale = new Opportunity(CloseDate = date.today(),
                                                     Name = 'Offerta Totale',
                                                     StageName = 'Prospecting');
        insert OffertaTotale;
        Opportunity BTSOpp = new Opportunity(CloseDate = date.today(),
                                                     Name = 'BTSOpp',
                                                     StageName = 'Prospecting',
                                                     RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Oppty_collegamenti_BTS'].Id,
                                                     PO_Offerta_totale__c = offertaTotale.Id,
                                                     PO_Canone_collegamento__c =987);
        
        insert BTSOpp;
        BTSOpp.PO_Canone_collegamento__c = 234;
        update BTSOpp;
    } 
    
    @isTest
    public static void PO_UpdateOpportunityTest_method3(){
        PO_ServFatt_DataFactory.createCustomSettings();
        Opportunity offertaTotale = new Opportunity(CloseDate = date.today(),
                                                     Name = 'Offerta Totale',
                                                     StageName = 'Prospecting');
        insert OffertaTotale;
        Opportunity P2PBaseOpp = new Opportunity(CloseDate = date.today(),
                                                     Name = 'P2PBaseOpp',
                                                     StageName = 'Prospecting',
                                                     RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'PO_Oppty_collegamenti_P2PBase'].Id,
                                                     PO_Offerta_totale__c = offertaTotale.Id,
                                                     PO_Contributo_attivazione_collegamento__c = 25.75,
                                                     PO_CostiAggiuntiviCollegamento__c = 123,
                                                     PO_Canone_collegamento__c =987);
        
        insert P2PBaseOpp;
        P2PBaseOpp.PO_Canone_collegamento__c = 234;
        update P2PBaseOpp;
    }
    
    @isTest
    public static void PO_UpdateOpportunityTest_method4(){
        PO_ServFatt_DataFactory.createCustomSettings();
        Opportunity offertaTotale = new Opportunity(CloseDate = date.today(),
                                                     Name = 'Offerta Totale',
                                                     StageName = 'Prospecting');
        insert OffertaTotale;
        Opportunity DarkFiberOpp = new Opportunity(CloseDate = date.today(),
                                                     Name = 'DarkFiberOpp',
                                                     StageName = 'Prospecting',
                                                     RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'PO_Oppty_collegamenti_DarkFiber'].Id,
                                                     PO_Offerta_totale__c = offertaTotale.Id,
                                                     PO_Contributo_attivazione_collegamento__c = 25.75,
                                                     PO_CostiAggiuntiviCollegamento__c = 123,
                                                     PO_Canone_collegamento__c =987);
        
        System.debug('@@@ FD rt pre '+ DarkFiberOpp.RecordTypeId);
        insert DarkFiberOpp;
        DarkFiberOpp.PO_Canone_collegamento__c = 234;
        System.debug('@@@ FD rt post '+ OF_Utility.getRT_IdDevName_Map().get(DarkFiberOpp.RecordTypeId));
        update DarkFiberOpp;
    }
    //FD 2019-01-22 Classi di test - END
}
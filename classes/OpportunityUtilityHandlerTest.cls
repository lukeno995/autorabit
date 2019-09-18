@isTest
public class OpportunityUtilityHandlerTest
{  
    /*static testMethod void OpportunityUtilityHandlerTestMethod()
    { 
        
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema7 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo = cfrSchema7.getRecordTypeInfosByName(); 
        Id rtId6 = opportunityRecordTypeInfo.get('PO Oppty Evento Temporaneo').getRecordTypeId();
        
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
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='IRU',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'IRU', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,PO_Canone_manutenzione_collegamento__c =10,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
      
        //insert OppRecA;
          oppList.add(OppRecA);
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                               recordtypeID = rtId6 ,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                               Pricebook2id = pricebookList[2].Id, 
                                               stageName ='Open',//PO_Offerta_totale__c=OppRecA1.id, 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               PO_Offerta_totale__c=OppRecA1.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',
                                               PO_Offerta_totale__c=OppRecA1.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        insert oppList;
        
        
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
       // update OppRecA;
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        insert OppLI_Rec;
        prod.Name = 'Contributo Attivazione';
        update prod;
        OpportunityLineItem OppLI_Rec1 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec1;
        prod.Name = 'Canone Manutenzione';
       // update prod;
        OpportunityLineItem OppLI_Rec2 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,PO_SalesPrice__c=12,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec2;
        Set<id> oppIdSet = new Set<id>();
        oppIdSet.add(OppRecA1.id); 
        Test.startTest();
        OpportunityUtilityHandler.CheckOnce();
        OpportunityUtilityHandler.ChildCalculateOpp(oppIdSet);
        OpportunityUtilityHandler.updateProduct(oppList);       
        OpportunityUtilityHandler.updatePricebook(oppList);
        Test.stopTest();
        
    }
    
    
    static testMethod void OpportunityUtilityHandlerTestMethod1()
    { 
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        //parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.RecordTypeId = rtId;
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2;
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        //ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.RecordTypeId = rtId;
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='P2P Base',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               Default__c = true,
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               Default__c = true,
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'IRU',
                                               Default__c = true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA);
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c = ChildCase.Id,
                                               name ='Opp',
                                               // Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c = ChildCase.Id,
                                               name='Opp',
                                               // Pricebook2id = pricebookList[1].Id, 
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        insert oppList;
        //  OppRecA.stageName = 'close';
        //  OppRecA.closeDate = Date.newInstance(2009,10,10);
        //  OppRecA.name ='Opp1';
        //  update OppRecA;
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        prod.Name = 'Corrispettivo IRU';
        update prod;
        OpportunityLineItem OppLI_Rec3 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 PO_SalesPrice__c = 10,
                                                                 Quantity = 3);
        insert OppLI_Rec3;
    }
    
    
    static testMethod void CalculateOppTest()
    {
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema1 = Schema.SObjectType.Opportunity; 
        Map<String,Schema.RecordTypeInfo> OppRecordTypeInfo1 = cfrSchema1.getRecordTypeInfosByName(); 
        Id rtId6 = OppRecordTypeInfo1.get('PO Oppty collegamenti').getRecordTypeId();
        Id rtId7 = OppRecordTypeInfo1.get('PO Oppty IRU').getRecordTypeId();
        Id rtId8 = OppRecordTypeInfo1.get('PO Oppty Fiber Link').getRecordTypeId();
        
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
        
        
        
        
        OF_CatalogoCommerciale__c Catalogo = New OF_CatalogoCommerciale__c(Name = 'P2P BaseAcc',
                                                                           OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                           OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert Catalogo;
        
        OF_Servizio__c ser = new OF_Servizio__c(Name='P2P Base',
                                                OF_CatalogoCommerciale__c = Catalogo.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        insert ser;
        
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        insert comElement;
        
        Pricebook2 pricebook = new Pricebook2(PO_Commercial_element__c = comElement.id,Name= 'IRU',isActive = true);
        insert pricebook;
        
        Pricebook2 pricebook1 = new Pricebook2(PO_Commercial_element__c = comElement.id,Name= 'P2P Base',isActive = true);
        insert pricebook1;
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_ContrattoServizio__c contSer = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,OF_Servizio__c = ser.Id);
        insert contSer;
        
        case parentCase = new case();
        parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.PO_Incluso_nell_offerta__c = true;
        parentCase.RecordTypeId = rtId5;
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2;
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.RecordTypeId = rtId5;
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        system.debug('case===='+childCase);
        
        Opportunity testOpp = new Opportunity(Name = 'TestOpportunity',
                                              PO_Richiesta_fattibilit__c = parentCase.Id,
                                              PO_Totale_canoni__c = 100,
                                              PO_Collegamento__c = childCase.id,
                                              PO_Summary__c = true,
                                              PO_Totale_contributi_attivazione__c = 200,
                                              PO_Contributo_attivazione_collegamento__c = 300,
                                              PO_Totale_costi_aggiuntivi__c = 500,
                                              PO_Canone_collegamento__c = 600,
                                              PO_Canone_annuo_1anno__c = 700,
                                              PO_Contributo_attivazione_1anno__c = 800,
                                              PO_Canone_annuo_2anni__c = 900,
                                              StageName = 'Prospecting',
                                              CloseDate = System.today()+150);
        insert testOpp;
        
        List<Opportunity> oppListParent = new List<Opportunity>();
        oppListParent.add(testOpp);
        
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity testOpportunity = new Opportunity(Name = 'Test Opportunity',
                                                      PO_Richiesta_fattibilit__c = parentCase.Id,
                                                      PO_Offerta_totale__c = testOpp.Id ,
                                                      PO_Collegamento__c = childCase.id,
                                                      RecordTypeId = rtId6, 
                                                      PO_Totale_canoni__c = 100,
                                                      PO_Summary__c = true,
                                                      PO_Totale_contributi_attivazione__c = 200,
                                                      PO_Contributo_attivazione_collegamento__c = 300,
                                                      PO_Canone_manutenzione_collegamento__c = 400,
                                                      PO_Totale_costi_aggiuntivi__c = 500,
                                                      PO_Canone_collegamento__c = 600,
                                                      PO_CostiAggiuntiviCollegamento__c = 700,
                                                      StageName = 'Prospecting',
                                                      CloseDate = System.today());
        insert testOpportunity;
        oppList.add(testOpportunity);
        
        
        
        Opportunity testOpportunity1 = new Opportunity(Name = 'Test Opportunity',
                                                       PO_Richiesta_fattibilit__c = parentCase.Id,
                                                       PO_Offerta_totale__c = testOpp.Id ,
                                                       PO_Collegamento__c = childCase.id,
                                                       RecordTypeId = rtId7,
                                                       PO_Totale_canoni__c = 100,
                                                       PO_Summary__c = true,
                                                       PO_Totale_contributi_attivazione__c = 200,
                                                       PO_Contributo_attivazione_collegamento__c = 300,
                                                       PO_Canone_manutenzione_collegamento__c = 400,
                                                       PO_Totale_costi_aggiuntivi__c = 500,
                                                       PO_Canone_collegamento__c = 600,
                                                       PO_CostiAggiuntiviCollegamento__c = 700,
                                                       StageName = 'Prospecting',
                                                       CloseDate = System.today());
        insert testOpportunity1;
        oppList.add(testOpportunity1);
        
        Opportunity testOpportunity2 = new Opportunity(Name = 'Test Opportunity',
                                                       PO_Richiesta_fattibilit__c = parentCase.Id,
                                                       PO_Offerta_totale__c = testOpp.Id ,
                                                       PO_Collegamento__c = childCase.id,
                                                       RecordTypeId = rtId8,
                                                       PO_Totale_canoni__c = 100,
                                                       PO_Summary__c = true,
                                                       PO_Totale_contributi_attivazione__c = 200,
                                                       PO_Contributo_attivazione_collegamento__c = 300,
                                                       PO_Canone_manutenzione_collegamento__c = 400,
                                                       PO_Totale_costi_aggiuntivi__c = 500,
                                                       PO_Canone_collegamento__c = 600,
                                                       PO_CostiAggiuntiviCollegamento__c = 700,
                                                       PO_Costi_Aggiuntivi_Anno1__c = 800,
                                                       PO_Costi_Aggiuntivi_Anno2__c = 900,
                                                       PO_Costi_Aggiuntivi_Anno3__c = 900,
                                                       PO_Canone_annuo_AltriAnni__c = 900,
                                                       PO_Contributo_attivazione_altri_anni__c = 900,
                                                       PO_Costi_Aggiuntivi_Altri_Anni__c = 900,
                                                       StageName = 'Prospecting',
                                                       CloseDate = System.today());
        insert testOpportunity2;
        oppList.add(testOpportunity2);
        system.debug('testOpportunity===='+testOpportunity);
        
        Test.startTest();
        OpportunityUtilityHandler.CalculateOpp(oppList);
        OpportunityUtilityHandler.ParentOpportunityUpdation(oppListParent);
        OpportunityUtilityHandler.updatePricebook(oppList);
        Test.stopTest();
    }
    
    
    static testMethod void OpportunityUtilityHandlerTestMethod2()
    {   
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'Fiber Link';
        
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2;
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Listino__c='Fiber Link Fascia';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='Fiber Link',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'Fiber Link Fascia', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA);
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c = ChildCase.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               Pricebook2id = pricebookList[2].Id,PO_Collegamento__c = ChildCase.id, 
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c = ChildCase.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c = ChildCase.Id,
                                               name='Opp',
                                               
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        insert oppList;
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        update OppRecA;
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        insert OppLI_Rec;
        prod.Name = 'Contributo Attivazione';
        update prod;
        OpportunityLineItem OppLI_Rec1 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec1;
      //  prod.Name = 'Canone Manutenzione';
        update prod;
        OpportunityLineItem OppLI_Rec2 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec2;
        
        Test.startTest();
        OpportunityUtilityHandler.CheckOnce();
        OpportunityUtilityHandler.updateProduct(oppList);       
        OpportunityUtilityHandler.updatePricebook(oppList);
        Test.stopTest();
    }
    
    
    static testMethod void OpportunityUtilityHandlerTestMethod3()
    {   
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'Evento Temporaneo';
        
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2;
        
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='Fiber Link',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'Evento Temporaneo', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA);
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c = ChildCase.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               Pricebook2id = pricebookList[2].Id,PO_Collegamento__c = ChildCase.id, 
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c = ChildCase.Id,
                                               
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',
                                               PO_Collegamento__c = ChildCase.Id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        insert oppList;
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        update OppRecA;
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        insert OppLI_Rec;
        prod.Name = 'Contributo Attivazione';
        update prod;
        OpportunityLineItem OppLI_Rec1 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec1;
        prod.Name = 'Canone Manutenzione';
       // update prod;
        OpportunityLineItem OppLI_Rec2 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec2;
        Test.startTest();
        OpportunityUtilityHandler.CheckOnce();
        OpportunityUtilityHandler.updateProduct(oppList);       
        OpportunityUtilityHandler.updatePricebook(oppList);
        Test.stopTest();
    }
    
    
    
    
    
    static testMethod void OpportunityUtilityHandlerTestMethod4()
    {   
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'Fiber Lease';
        
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2;
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Listino__c= 'Fiber Link Misto Fascia';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Drop_FL_1__c=true;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='Fiber Link',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'Fiber Link Misto Fascia', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA);
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c = ChildCase.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               Pricebook2id = pricebookList[2].Id,PO_Collegamento__c = ChildCase.id, 
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               PO_Collegamento__c = ChildCase.Id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',
                                               PO_Collegamento__c = ChildCase.Id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        insert oppList;
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        update OppRecA;
        
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        insert OppLI_Rec;
        prod.Name = 'Contributo Attivazione';
        update prod;
        OpportunityLineItem OppLI_Rec1 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec1;
        prod.Name = 'Canone Manutenzione';
      //  update prod;
        OpportunityLineItem OppLI_Rec2 = new OpportunityLineItem(OpportunityId = OppRecA.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec2;
        Test.startTest();
        OpportunityUtilityHandler.CheckOnce();
        OpportunityUtilityHandler.updateProduct(oppList);       
        OpportunityUtilityHandler.updatePricebook(oppList);
        Test.stopTest();
    }
    
    static testMethod void OpportunityUtilityHandlerTestMethod5()
    { 
        
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema7 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo = cfrSchema7.getRecordTypeInfosByName(); 
        Id rtId6 = opportunityRecordTypeInfo.get('PO Oppty Evento Temporaneo').getRecordTypeId();
        
        
        
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
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='IRU',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'IRU', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        Opportunity OppRec = new Opportunity(AccountId = AcntRec.Id,
                                             name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                             recordtypeID = rtId6 ,
                                             Pricebook2id = pricebookList[1].Id, 
                                             stageName ='Open',
                                             closeDate = Date.newInstance(2008,10,10));
        insert OppRec;
        List<Opportunity> oppList = new List<Opportunity>();
        
        
        
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        
        Opportunity OppRecA12 = new Opportunity(AccountId = AcntRec.Id,
                                                name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                                Pricebook2id = pricebookList[2].Id, RecordtypeID=rtId6 ,
                                                stageName ='Open',PO_Offerta_totale__c=OppRec.id, PO_CostiAggiuntiviCollegamento__c=100,
                                                closeDate = Date.newInstance(2008,10,10));
        insert OppRecA12;
        oppList.add(OppRecA12);
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        insert OppLI_Rec;
        prod.Name = 'Contributo Attivazione';
        update prod;
        OpportunityLineItem OppLI_Rec1 = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec1;
        prod.Name = 'Canone Manutenzione';
        update prod;
        OpportunityLineItem OppLI_Rec2 = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec2;
        Set<id> oppIdSet = new Set<id>();
        oppIdSet.add(OppRec.id); 
        Test.startTest();
        
        OpportunityUtilityHandler.ChildCalculateOpp(oppIdSet);
        
        Test.stopTest();
        
    } 
    
    static testMethod void OpportunityUtilityHandlerTestMethod6()
    { 
        
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema7 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo = cfrSchema7.getRecordTypeInfosByName(); 
        Id rtId6 = opportunityRecordTypeInfo.get('PO Oppty Fiber Link').getRecordTypeId();
        
        
        
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
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='IRU',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'IRU', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        Opportunity OppRec = new Opportunity(AccountId = AcntRec.Id,
                                             name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                             recordtypeID = rtId6 ,
                                             Pricebook2id = pricebookList[1].Id, 
                                             stageName ='Open',
                                             closeDate = Date.newInstance(2008,10,10));
        insert OppRec;
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA);
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                               recordtypeID = rtId6 ,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                               Pricebook2id = pricebookList[2].Id, 
                                               stageName ='Open',//PO_Offerta_totale__c=OppRecA1.id, 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        //insert oppList;
        
        
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        
        // update OppRecA;
        Opportunity OppRecA12 = new Opportunity(AccountId = AcntRec.Id,
                                                name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                                Pricebook2id = pricebookList[2].Id, RecordtypeID=rtId6 ,
                                                stageName ='Open',PO_Offerta_totale__c=OppRec.id,PO_Costi_Aggiuntivi_Anno1__c =100,
                                                PO_Costi_Aggiuntivi_Anno2__c =100,
                                                PO_Costi_Aggiuntivi_Anno3__c=100,
                                                PO_Canone_annuo_AltriAnni__c=100,
                                                PO_Contributo_attivazione_altri_anni__c=100,
                                                PO_Costi_Aggiuntivi_Altri_Anni__c= 100,
                                                closeDate = Date.newInstance(2008,10,10));
        insert OppRecA12;
        oppList.add(OppRecA12);
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        insert OppLI_Rec;
        prod.Name = 'Contributo Attivazione';
        update prod;
        OpportunityLineItem OppLI_Rec1 = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec1;
        prod.Name = 'Canone Manutenzione';
        update prod;
        OpportunityLineItem OppLI_Rec2 = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec2;
        Set<id> oppIdSet = new Set<id>();
        oppIdSet.add(OppRec.id); 
        Test.startTest();
        
        OpportunityUtilityHandler.ChildCalculateOpp(oppIdSet);
        
        Test.stopTest();
        
    } 
    
    
    static testMethod void OpportunityUtilityHandlerTestMethod7()
    { 
        
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema7 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo = cfrSchema7.getRecordTypeInfosByName(); 
        Id rtId6 = opportunityRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
        
        
        
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
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='IRU',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'IRU', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        Opportunity OppRec = new Opportunity(AccountId = AcntRec.Id,
                                             name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                             recordtypeID = rtId6 ,
                                             Pricebook2id = pricebookList[1].Id, 
                                             stageName ='Open',
                                             closeDate = Date.newInstance(2008,10,10));
        insert OppRec;
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA);
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                               recordtypeID = rtId6 ,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                               Pricebook2id = pricebookList[2].Id, 
                                               stageName ='Open',//PO_Offerta_totale__c=OppRecA1.id, 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        //insert oppList;
        
        
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        
        // update OppRecA;
        Opportunity OppRecA12 = new Opportunity(AccountId = AcntRec.Id,
                                                name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ParentCase.id,
                                                Pricebook2id = pricebookList[2].Id, RecordtypeID=rtId6 ,
                                                stageName ='Open',PO_Offerta_totale__c=OppRec.id,PO_Costi_Aggiuntivi_Anno1__c =100,
                                                PO_Costi_Aggiuntivi_Anno2__c =100,
                                                PO_Costi_Aggiuntivi_Anno3__c=100,
                                                PO_Canone_annuo_AltriAnni__c=100,
                                                PO_Contributo_attivazione_altri_anni__c=100,
                                                PO_Costi_Aggiuntivi_Altri_Anni__c= 100,
                                                closeDate = Date.newInstance(2008,10,10));
        insert OppRecA12;
        oppList.add(OppRecA12);
        OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                pricebookentryid = pbEntry.id,
                                                                UnitPrice = 200,
                                                                Quantity = 3);
        insert OppLI_Rec;
        prod.Name = 'Contributo Attivazione';
        update prod;
        OpportunityLineItem OppLI_Rec1 = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec1;
        prod.Name = 'Canone Manutenzione';
        update prod;
        OpportunityLineItem OppLI_Rec2 = new OpportunityLineItem(OpportunityId = OppRec.Id,
                                                                 pricebookentryid = pbEntry.id,
                                                                 UnitPrice = 200,
                                                                 Quantity = 3);
        insert OppLI_Rec2;
        Set<id> oppIdSet = new Set<id>();
        oppIdSet.add(OppRec.id); 
        Test.startTest();
        
        OpportunityUtilityHandler.ChildCalculateOpp(oppIdSet);
        
        Test.stopTest();
        
    } 
    
    static testMethod void OpportunityUtilityHandlerTestMethod8()
    { 
        
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema7 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo = cfrSchema7.getRecordTypeInfosByName(); 
        Id rtId6 = opportunityRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema8 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo1 = cfrSchema8.getRecordTypeInfosByName(); 
        Id rtId7 = opportunityRecordTypeInfo1.get('PO Oppty Fiber Lease').getRecordTypeId();
        
        
        
        OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo.Name='13';
        fiberPrezzo.Prezzo__c=70;
        fiberPrezzo.Anno__c= 'Anno13';
        insert fiberPrezzo;
        
         OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo15= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo15.Name='12';
        fiberPrezzo15.Prezzo__c=70;
        fiberPrezzo15.Anno__c= 'Anno13';
        insert fiberPrezzo15;

OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo21= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo21.Name='11';
        fiberPrezzo21.Prezzo__c=70;
        fiberPrezzo21.Anno__c= 'Anno13';
        insert fiberPrezzo21;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo31= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo31.Name='10';
        fiberPrezzo31.Prezzo__c=70;
        fiberPrezzo31.Anno__c= 'Anno13';
        insert fiberPrezzo31;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo41= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo41.Name='9';
        fiberPrezzo41.Prezzo__c=70;
        fiberPrezzo41.Anno__c= 'Anno13';
        insert fiberPrezzo41;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo5= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo5.Name='8';
        fiberPrezzo5.Prezzo__c=70;
        fiberPrezzo5.Anno__c= 'Anno13';
        insert fiberPrezzo5;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo6= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo6.Name='7';
        fiberPrezzo6.Prezzo__c=70;
        fiberPrezzo6.Anno__c= 'Anno13';
        insert fiberPrezzo6;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo7= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo7.Name='6';
        fiberPrezzo7.Prezzo__c=70;
        fiberPrezzo7.Anno__c= 'Anno13';
        insert fiberPrezzo7;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo8= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo8.Name='5';
        fiberPrezzo8.Prezzo__c=70;
        fiberPrezzo8.Anno__c= 'Anno13';
        insert fiberPrezzo8;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo9= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo9.Name='4';
        fiberPrezzo9.Prezzo__c=70;
        fiberPrezzo9.Anno__c= 'Anno13';
        insert fiberPrezzo9;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo10= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo10.Name='3';
        fiberPrezzo10.Prezzo__c=70;
        fiberPrezzo10.Anno__c= 'Anno13';
        insert fiberPrezzo10;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo11= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo11.Name='2';
        fiberPrezzo11.Prezzo__c=70;
        fiberPrezzo11.Anno__c= 'Anno13';
        insert fiberPrezzo11;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo12= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo12.Name='1';
        fiberPrezzo12.Prezzo__c=70;
        fiberPrezzo12.Anno__c= 'Anno13';
        insert fiberPrezzo12;
        
          OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo16= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo16.Name='Drop2AltreCoppie';
        fiberPrezzo16.Prezzo__c=70;
        
        insert fiberPrezzo16; 
         
            OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo17= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo17.Name='CostanteFiberLease1';
        fiberPrezzo17.Prezzo__c=70;
        
        insert fiberPrezzo17; 
        
           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo18= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo18.Name='CostanteFiberLease2';
        fiberPrezzo18.Prezzo__c=70;
        
        insert fiberPrezzo18; 
        
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
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='IRU',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'IRU', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRec = new Opportunity(AccountId = AcntRec.Id,
                                             name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                             recordtypeID = rtId6 ,
                                            
                                             stageName ='Open',
                                             closeDate = Date.newInstance(2008,10,10));
        insert OppRec;
        oppList.add(OppRec);
        
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                               recordtypeID = rtId6 ,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        
        
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                               Pricebook2id = pricebookList[2].Id, 
                                               stageName ='Open',//PO_Offerta_totale__c=OppRecA1.id, 
                                               closeDate = Date.newInstance(2008,10,10));
      
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
       
        //insert oppList;
        
        
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        
        // update OppRecA;
        Opportunity OppRecA12 = new Opportunity(AccountId = AcntRec.Id,
                                                name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                                Pricebook2id = pricebookList[2].Id, RecordtypeID=rtId7,
                                                stageName ='Open',PO_Costi_Aggiuntivi_Anno1__c =100,
                                                PO_Costi_Aggiuntivi_Anno2__c =100,
                                                PO_Costi_Aggiuntivi_Anno3__c=100,
                                                PO_Richiesta_fattibilit__c=parentCase.id,
                                                PO_CostiCollegamento__c = 100,PO_CostoStruttura__c =100,
                                                PO_Canone_annuo_AltriAnni__c=100,
                                                PO_Contributo_attivazione_altri_anni__c=100,
                                                PO_Costi_Aggiuntivi_Altri_Anni__c= 100,
                                                closeDate = Date.newInstance(2008,10,10));
        insert OppRecA12;
        
       
        Set<id> oppIdSet = new Set<id>();
        oppIdSet.add(OppRec.id); 
        Test.startTest();
        
        OpportunityUtilityHandler.ParentOpportunityUpdation(oppList);
        
        Test.stopTest();
        
    } 
    
    
     static testMethod void OpportunityUtilityHandlerTestMethod9()
    { 
        
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema7 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo = cfrSchema7.getRecordTypeInfosByName(); 
        Id rtId6 = opportunityRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema8 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo1 = cfrSchema8.getRecordTypeInfosByName(); 
        Id rtId7 = opportunityRecordTypeInfo1.get('PO Oppty Fiber Lease').getRecordTypeId();
        
        
        
          OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo.Name='13';
        fiberPrezzo.Prezzo__c=70;
        fiberPrezzo.Anno__c= 'Anno13';
        insert fiberPrezzo;
        
         OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo15= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo15.Name='12';
        fiberPrezzo15.Prezzo__c=70;
        fiberPrezzo15.Anno__c= 'Anno13';
        insert fiberPrezzo15;

OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo21= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo21.Name='11';
        fiberPrezzo21.Prezzo__c=70;
        fiberPrezzo21.Anno__c= 'Anno13';
        insert fiberPrezzo21;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo31= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo31.Name='10';
        fiberPrezzo31.Prezzo__c=70;
        fiberPrezzo31.Anno__c= 'Anno13';
        insert fiberPrezzo31;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo41= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo41.Name='9';
        fiberPrezzo41.Prezzo__c=70;
        fiberPrezzo41.Anno__c= 'Anno13';
        insert fiberPrezzo41;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo5= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo5.Name='8';
        fiberPrezzo5.Prezzo__c=70;
        fiberPrezzo5.Anno__c= 'Anno13';
        insert fiberPrezzo5;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo6= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo6.Name='7';
        fiberPrezzo6.Prezzo__c=70;
        fiberPrezzo6.Anno__c= 'Anno13';
        insert fiberPrezzo6;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo7= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo7.Name='6';
        fiberPrezzo7.Prezzo__c=70;
        fiberPrezzo7.Anno__c= 'Anno13';
        insert fiberPrezzo7;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo8= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo8.Name='5';
        fiberPrezzo8.Prezzo__c=70;
        fiberPrezzo8.Anno__c= 'Anno13';
        insert fiberPrezzo8;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo9= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo9.Name='4';
        fiberPrezzo9.Prezzo__c=70;
        fiberPrezzo9.Anno__c= 'Anno13';
        insert fiberPrezzo9;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo10= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo10.Name='3';
        fiberPrezzo10.Prezzo__c=70;
        fiberPrezzo10.Anno__c= 'Anno13';
        insert fiberPrezzo10;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo11= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo11.Name='2';
        fiberPrezzo11.Prezzo__c=70;
        fiberPrezzo11.Anno__c= 'Anno13';
        insert fiberPrezzo11;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo12= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo12.Name='1';
        fiberPrezzo12.Prezzo__c=70;
        fiberPrezzo12.Anno__c= 'Anno13';
        insert fiberPrezzo12;
        
        
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
        
          OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo16= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo16.Name='Drop2AltreCoppie';
        fiberPrezzo16.Prezzo__c=70;
        
        insert fiberPrezzo16; 
         
            OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo17= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo17.Name='CostanteFiberLease1';
        fiberPrezzo17.Prezzo__c=70;
        
        insert fiberPrezzo17; 
        
           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo18= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo18.Name='CostanteFiberLease2';
        fiberPrezzo18.Prezzo__c=70;
        
        insert fiberPrezzo18; 
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
          contract contr1 = new contract(AccountId = AcntRec.Id);
        insert contr1;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='IRU',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr1.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'IRU', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRec = new Opportunity(AccountId = AcntRec.Id,
                                             name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                             recordtypeID = rtId6 ,
                                             //Pricebook2id = pricebookList[1].Id, 
                                             stageName ='Open',
                                             closeDate = Date.newInstance(2008,10,10));
        insert OppRec;
        oppList.add(OppRec);
        
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                               recordtypeID = rtId6 ,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                               Pricebook2id = pricebookList[2].Id, 
                                               stageName ='Open',//PO_Offerta_totale__c=OppRecA1.id, 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        //insert oppList;
        
        
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        
        // update OppRecA;
        Opportunity OppRecA12 = new Opportunity(AccountId = AcntRec.Id,
                                                name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ParentCase.id,
                                                Pricebook2id = pricebookList[2].Id, RecordtypeID=rtId7,
                                                stageName ='Open',PO_Offerta_totale__c=OppRec.id,PO_Costi_Aggiuntivi_Anno1__c =100,
                                                PO_Costi_Aggiuntivi_Anno2__c =100,
                                                PO_Costi_Aggiuntivi_Anno3__c=100,
                                                PO_CostiCollegamento__c = 100,PO_CostoStruttura__c =100,
                                                PO_Canone_annuo_AltriAnni__c=100,
                                                PO_Contributo_attivazione_altri_anni__c=100,
                                                PO_Costi_Aggiuntivi_Altri_Anni__c= 100,
                                                closeDate = Date.newInstance(2008,10,10));
        insert OppRecA12;
        oppList.add(OppRecA12);
        Set<id> oppIdSet = new Set<id>();
        oppIdSet.add(OppRec.id); 
        Test.startTest();
        
        OpportunityUtilityHandler.updatePricebook(oppList);
        
        Test.stopTest();
        
    } 
    
    
    
    
     static testMethod void OpportunityUtilityHandlerTestMethod10()
    { 
        
        Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
        Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema7 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo = cfrSchema7.getRecordTypeInfosByName(); 
        Id rtId6 = opportunityRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
        
        Schema.DescribeSObjectResult cfrSchema8 = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> opportunityRecordTypeInfo1 = cfrSchema8.getRecordTypeInfosByName(); 
        Id rtId7 = opportunityRecordTypeInfo1.get('PO Oppty Fiber Lease').getRecordTypeId();
        
        
        
          OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo.Name='13';
        fiberPrezzo.Prezzo__c=70;
        fiberPrezzo.Anno__c= 'Anno13';
        insert fiberPrezzo;
        
         OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo15= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo15.Name='12';
        fiberPrezzo15.Prezzo__c=70;
        fiberPrezzo15.Anno__c= 'Anno13';
        insert fiberPrezzo15;

OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo21= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo21.Name='11';
        fiberPrezzo21.Prezzo__c=70;
        fiberPrezzo21.Anno__c= 'Anno13';
        insert fiberPrezzo21;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo31= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo31.Name='10';
        fiberPrezzo31.Prezzo__c=70;
        fiberPrezzo31.Anno__c= 'Anno13';
        insert fiberPrezzo31;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo41= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo41.Name='9';
        fiberPrezzo41.Prezzo__c=70;
        fiberPrezzo41.Anno__c= 'Anno13';
        insert fiberPrezzo41;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo5= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo5.Name='8';
        fiberPrezzo5.Prezzo__c=70;
        fiberPrezzo5.Anno__c= 'Anno13';
        insert fiberPrezzo5;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo6= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo6.Name='7';
        fiberPrezzo6.Prezzo__c=70;
        fiberPrezzo6.Anno__c= 'Anno13';
        insert fiberPrezzo6;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo7= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo7.Name='6';
        fiberPrezzo7.Prezzo__c=70;
        fiberPrezzo7.Anno__c= 'Anno13';
        insert fiberPrezzo7;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo8= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo8.Name='5';
        fiberPrezzo8.Prezzo__c=70;
        fiberPrezzo8.Anno__c= 'Anno13';
        insert fiberPrezzo8;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo9= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo9.Name='4';
        fiberPrezzo9.Prezzo__c=70;
        fiberPrezzo9.Anno__c= 'Anno13';
        insert fiberPrezzo9;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo10= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo10.Name='3';
        fiberPrezzo10.Prezzo__c=70;
        fiberPrezzo10.Anno__c= 'Anno13';
        insert fiberPrezzo10;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo11= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo11.Name='2';
        fiberPrezzo11.Prezzo__c=70;
        fiberPrezzo11.Anno__c= 'Anno13';
        insert fiberPrezzo11;
OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo12= new OF_FiberLeaseListinoPrezzoAnnuo__c();
        fiberPrezzo12.Name='1';
        fiberPrezzo12.Prezzo__c=70;
        fiberPrezzo12.Anno__c= 'Anno13';
        insert fiberPrezzo12;
        
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo1.Name='Backbone1';
        fiberPrezzo1.Prezzo__c=70;
        
        insert fiberPrezzo1; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo2.Name='Backbone2';
        fiberPrezzo2.Prezzo__c=70;
        
        insert fiberPrezzo2; 
        
         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo16= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo16.Name='Drop2AltreCoppie';
        fiberPrezzo16.Prezzo__c=70;
        
        insert fiberPrezzo16; 
         
            OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo17= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo17.Name='CostanteFiberLease1';
        fiberPrezzo17.Prezzo__c=70;
        
        insert fiberPrezzo17; 
        
           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo18= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo18.Name='CostanteFiberLease2';
        fiberPrezzo18.Prezzo__c=70;
        
        insert fiberPrezzo18; 
                
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo3.Name='Drop1';
        fiberPrezzo3.Prezzo__c=70;
        
        insert fiberPrezzo3; 
        
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo4.Name='Drop2';
        fiberPrezzo4.Prezzo__c=70;
        
        insert fiberPrezzo4; 
        
        
        Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
        insert AcntRec;
        
        contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
        insert con;
        
        case parentCase = new case();
        parentCase.AccountId = AcntRec.Id;
        parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100;
        parentCase.PO_Costo_lavori_ottici__c = 100;
        parentCase.Status = 'In approvazione Cliente';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        parentCase.PO_Listino__c='Fiber Link Fascia';
        insert parentCase;
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.accountId = AcntRec.Id;
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_Numero_fibre_richieste__c = '2';
        ChildCase.Status = 'In approvazione Cliente';
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2;
        insert ChildCase;
        
        contract contr = new contract(AccountId = AcntRec.Id);
        insert contr;
        
          contract contr1 = new contract(AccountId = AcntRec.Id);
        insert contr1;
        
        OF_CatalogoCommerciale__c ofc = New OF_CatalogoCommerciale__c(Name='P2P Base',
                                                                      OF_DataFineValidita__c = Date.newInstance(2018,1,1),
                                                                      OF_DataInizioValidita__c = Date.newInstance(1995,12,01));
        insert ofc;
        
        List<OF_Servizio__c> serList = new List<OF_Servizio__c>();
        OF_Servizio__c ser = new OF_Servizio__c(Name='P2P Base',
                                                OF_CatalogoCommerciale__c = ofc.Id,
                                                OF_DataFineValidita__c = System.today()+20,
                                                OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser);
        
        OF_Servizio__c ser1 = new OF_Servizio__c(Name='IRU'+AcntRec.name,
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser1);
        
        OF_Servizio__c ser2 = new OF_Servizio__c(Name='IRU',
                                                 OF_CatalogoCommerciale__c = ofc.Id,
                                                 OF_DataFineValidita__c = System.today()+20,
                                                 OF_DataInizioValidita__c = System.today()+1);
        serList.add(ser2);
        insert serList;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c(Name = 'SINGOLA VIA BIFIBRA',
                                                                         OF_Servizio__c = ser.Id,
                                                                         OF_DataFineValidita__c = System.today()+15,
                                                                         OF_DataInizioValidita__c = System.today()+10);
        comList.add(comElement);
        
        OF_CommercialElement__c comElement1 = new OF_CommercialElement__c(Name = 'SINGOLA VIA MONOFIBRA',
                                                                          OF_Servizio__c = ser.Id,
                                                                          OF_DataFineValidita__c = System.today()+15,
                                                                          OF_DataInizioValidita__c = System.today()+10);
        insert comElement1;
        insert comList;
        
        OF_ContrattoServizio__c contractser = new OF_ContrattoServizio__c(OF_Contract__c = contr1.Id,
                                                                          OF_Servizio__c = serList[0].Id);
        insert contractser;
        
        Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                          Product2Id = prod.Id,
                                                          UnitPrice = 10000,
                                                          IsActive = true);
        insert standardPrice;
        
        List<Pricebook2> pricebookList = new List<Pricebook2>();
        Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comList[0].id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook1);
        
        Pricebook2 pricebook2 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base',
                                               isActive = true);
        pricebookList.add(pricebook2);
        Pricebook2 pricebook3 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               PO_Commercial_element__c = comElement1.id,
                                               Name= 'P2P Base', Default__c =true,
                                               isActive = true);
        pricebookList.add(pricebook3);
        insert pricebookList;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookList[1].Id,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 12000,
                                                    IsActive = true);
        insert pbEntry;
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity OppRec = new Opportunity(AccountId = AcntRec.Id,
                                             name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                             recordtypeID = rtId6 ,
                                             //Pricebook2id = pricebookList[1].Id, 
                                             stageName ='Open',
                                             closeDate = Date.newInstance(2008,10,10));
        insert OppRec;
        oppList.add(OppRec);
        
        Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
                                              AccountId = AcntRec.Id,
                                              name ='Opp',PO_Contratto__c = contr.Id,
                                              Pricebook2id = pricebookList[1].Id,
                                              stageName = 'Open', 
                                              closeDate = Date.newInstance(2008,10,10));
        
        //insert OppRecA;
        Opportunity OppRecA1 = new Opportunity(AccountId = AcntRec.Id,
                                               name ='Opp',PO_Contratto__c = contr.Id,PO_Richiesta_fattibilit__c = parentCase.Id,
                                               recordtypeID = rtId6 ,
                                               Pricebook2id = pricebookList[0].Id, 
                                               stageName ='Open',
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA1);
        
        Opportunity OppRecA2 = new Opportunity(AccountId = AcntRec.Id,
                                               name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ChildCase.id,
                                               Pricebook2id = pricebookList[2].Id, 
                                               stageName ='Open',//PO_Offerta_totale__c=OppRecA1.id, 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA2);
        Opportunity OppRecA3 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',PO_Contratto__c = contr.Id,
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA3);
        Opportunity OppRecA4 = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c=ChildCase.id,
                                               name='Opp',
                                               PO_Offerta_totale__c=OppRec.id,
                                               stageName ='Open', 
                                               closeDate = Date.newInstance(2008,10,10));
        oppList.add(OppRecA4);
        //insert oppList;
        
        
        
        //OF_Servizio__c ser1 = new OF_Servizio__c(Name='P2P Base'+AcntRec.name,OF_CatalogoCommerciale__c=ofc.Id,OF_DataFineValidita__c=system.today(),OF_DataInizioValidita__c=system.today());
        // insert ser1;
        OppRecA.stageName = 'close';
        OppRecA.closeDate = Date.newInstance(2009,10,10);
        OppRecA.name ='Opp1';
        
        // update OppRecA;
        Opportunity OppRecA12 = new Opportunity(AccountId = AcntRec.Id,
                                                name='Opp',PO_Contratto__c = contr.Id,PO_Collegamento__c=ParentCase.id,
                                                Pricebook2id = pricebookList[2].Id, RecordtypeID=rtId7,
                                                stageName ='Open',PO_Offerta_totale__c=OppRec.id,PO_Costi_Aggiuntivi_Anno1__c =100,
                                                PO_Costi_Aggiuntivi_Anno2__c =100,
                                                PO_Costi_Aggiuntivi_Anno3__c=100,
                                                PO_CostiCollegamento__c = 100,PO_CostoStruttura__c =100,
                                                PO_Canone_annuo_AltriAnni__c=100,
                                                PO_Contributo_attivazione_altri_anni__c=100,
                                                PO_Costi_Aggiuntivi_Altri_Anni__c= 100,
                                                closeDate = Date.newInstance(2008,10,10));
        insert OppRecA12;
        oppList.add(OppRecA12);
        Set<id> oppIdSet = new Set<id>();
        oppIdSet.add(OppRec.id); 
        Test.startTest();
        
        OpportunityUtilityHandler.updatePricebook(oppList);
        FutureUtility.isFutureUpdate = false;
        
        Test.stopTest();
        
    } 
    
    */
       @isTest static void testMethod1() 
    {
         OpportunityUtilityHandler theController = new OpportunityUtilityHandler();    
    }

    
}
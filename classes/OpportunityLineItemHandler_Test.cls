@isTest
public class OpportunityLineItemHandler_Test{
    @isTest
     static void testMethod1(){
       
         OpportunityLineItemHandler PO=new OpportunityLineItemHandler();
     }  
    // static testMethod void OpportunityUtilityHandlerTestMethod(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
    //      OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'IRU';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //             parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //             ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                               
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                 UnitPrice = 12000,
    //                                               // StandardPrice=100,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }
    
    
    //  static testMethod void OpportunityUtilityHandlerTestMethod1(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
    //     OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'IRU';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }
    
    
    
    //  static testMethod void OpportunityUtilityHandlerTestMethod2(){
    //  OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware',PO_Anni_Fiber_Link__c = '1 Anno');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }
    
    //       static testMethod void OpportunityUtilityHandlerTestMethod3(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //      OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
            
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Contributo Attivazione', Family = 'Hardware',PO_Anni_Fiber_Link__c = '1 Anno');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }       
    
    // static testMethod void OpportunityUtilityHandlerTestMethod4(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //      OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
            
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Contributo Attivazione', Family = 'Hardware',PO_Anni_Fiber_Link__c = '2 Anni');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }  
    
    //  static testMethod void OpportunityUtilityHandlerTestMethod5(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //       OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
            
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware',PO_Anni_Fiber_Link__c = '2 Anni');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }  
    
    
    // static testMethod void OpportunityUtilityHandlerTestMethod6(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //     OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4;
             
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware',PO_Anni_Fiber_Link__c = '3 Anni');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }      
       
    //     static testMethod void OpportunityUtilityHandlerTestMethod7(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //     OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
            
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Contributo Attivazione', Family = 'Hardware',PO_Anni_Fiber_Link__c = '3 Anni');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }      
                  
                  
    //   static testMethod void OpportunityUtilityHandlerTestMethod8(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //      OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
            
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware',PO_Anni_Fiber_Link__c = 'X Anni');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }      
       
    //     static testMethod void OpportunityUtilityHandlerTestMethod9(){
    
    //   Schema.DescribeSObjectResult cfrSchema6 = Schema.SObjectType.case; 
    //     Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema6.getRecordTypeInfosByName(); 
    //     Id rtId5 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //   OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
    //         fiberPrezzo.Name='13';
    //         fiberPrezzo.Prezzo__c=70;
    //         fiberPrezzo.Anno__c= 'Anno13';
    //         insert fiberPrezzo;
            
    //         OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo1.Name='Backbone1';
    //         fiberPrezzo1.Prezzo__c=70;
            
    //         insert fiberPrezzo1; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo2.Name='Backbone2';
    //         fiberPrezzo2.Prezzo__c=70;
            
    //         insert fiberPrezzo2; 
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo3.Name='Drop1';
    //         fiberPrezzo3.Prezzo__c=70;
            
    //         insert fiberPrezzo3; 
            
            
    //           OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
    //         fiberPrezzo4.Name='Drop2';
    //         fiberPrezzo4.Prezzo__c=70;
            
    //         insert fiberPrezzo4; 
            
    //     Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
    //             insert AcntRec;
                
    //             contact con = new contact( LastName = 'Testing',AccountId = AcntRec.Id);
    //             insert con;
                
    //             case parentCase = new case();
    //             parentCase.AccountId = AcntRec.Id;
    //             parentCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             parentCase.contactId = con.Id;
    //             parentCase.PO_Offerta__c = 'Fiber Link';
    //             parentCase.PO_Tipo_percorso__c = 'Singola Via';
    //             parentCase.PO_Costo_lavori_civili__c = 100;
    //             parentCase.PO_Costo_lavori_ottici__c = 100;
    //             parentCase.Status = 'In approvazione Cliente';
    //              parentCase.PO_BB_1_interessato__c = 2;
    //             parentCase.PO_BB_2_interessato__c =2;
    //             parentCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert parentCase;
                
    //             case ChildCase = new Case();
    //             ChildCase.ParentId = parentCase.id;
    //             ChildCase.RecordTypeId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
    //             ChildCase.PO_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
    //             ChildCase.PO_Costo_lavori_civili__c = 100;
    //             ChildCase.PO_Costo_lavori_ottici__c = 100;
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.PO_Tipo_di_collegamento__c = 'BTS';
    //             //ChildCase.PO_Tipologia_Offerta__c = 'P2P Base';
    //             ChildCase.PO_Tipo_percorso__c = 'Singola Via';
    //             ChildCase.accountId = AcntRec.Id;
    //             ChildCase.contactId = con.Id; 
    //             ChildCase.PO_Numero_fibre_richieste__c = '1';
    //             ChildCase.PO_Numero_fibre_richieste__c = '2';
    //              ChildCase.Status = 'In approvazione Cliente';
    //              ChildCase.PO_BB_1_interessato__c = 2;
    //             ChildCase.PO_BB_2_interessato__c =2;
    //             ChildCase.PO_Posa_1_nuovo_Drop__c=100;
    //             insert ChildCase;
                
    //             contract contr = new contract(AccountId = AcntRec.Id);
    //             insert contr;
                
    //             Pricebook2 pricebook1 = new Pricebook2(PO_Contratto__c = contr.Id,
                                                
    //                                           Name= 'P2P Base',
    //                                           isActive = true);
    //             insert pricebook1;
                
    //               Product2 prod = new Product2(Name = 'Contributo Attivazione', Family = 'Hardware',PO_Anni_Fiber_Link__c = 'X Anni');
    //               insert prod;
    //               Product2 prod1 = new Product2(Name = 'Corrispettivo IRU', Family = 'Hardware');
    //               insert prod1;
                 
    //               Id pricebookId = Test.getStandardPricebookId();
    //               PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
    //                                                       Product2Id = prod.Id,
    //                                                       UnitPrice = 10000,
    //                                                       IsActive = true);
    //              insert standardPrice;
                 
    //              PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebook1 .Id,
    //                                                 Product2Id = prod.Id,
    //                                                   //StandardPrice=100,
    //                                                 UnitPrice = 12000,
    //                                                 IsActive = true);
    //             insert pbEntry;
                
    //             Opportunity OppRecA = new Opportunity(PO_Collegamento__c = ChildCase.Id,
    //                                           AccountId = AcntRec.Id,
    //                                           name ='Opp',PO_Contratto__c = contr.Id,
    //                                           //Pricebook2id = pricebookList[1].Id,
    //                                           stageName = 'Open', 
    //                                           closeDate = Date.newInstance(2008,10,10));
    //              insert OppRecA;
                
    //             OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id,
    //                                                             pricebookentryid = pbEntry.id,
    //                                                             UnitPrice = 200,
    //                                                             Quantity = 3);
    //               insert OppLI_Rec;
    // }      
                                               
}
@isTest
public class UtilityHandlerTest
{
    static testMethod void UtilityHandlerMethod1()
    {
        Schema.DescribeSObjectResult ciruSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = ciruSchema.getRecordTypeInfosByName(); 
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId(); 
        
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name = 'Default';
        paramFat.Fascia1__c = 1;
        insert paramFat;
        
        OF_FiberLeaseListinoPrezzoAnnuo__c PrezzoAnnuo = new OF_FiberLeaseListinoPrezzoAnnuo__c();
        PrezzoAnnuo.Name = '13';
        PrezzoAnnuo.Prezzo__c = 70;
        PrezzoAnnuo.Anno__c = 'Anno13';
        insert PrezzoAnnuo;
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo1.Name ='Backbone1';
        fiberPrezzo1.Prezzo__c = 70;
        insert fiberPrezzo1; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo2.Name = 'Backbone2';
        fiberPrezzo2.Prezzo__c = 70;
        insert fiberPrezzo2; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo3.Name = 'Drop1';
        fiberPrezzo3.Prezzo__c = 70;
        insert fiberPrezzo3; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo4.Name = 'Drop2';
        fiberPrezzo4.Prezzo__c = 70;
        insert fiberPrezzo4; 
        
        Account acc = new Account();
        acc.name = 'TestAccount';
        acc.Type = 'Customer';
        acc.Industry = 'Automotive';       
        insert acc;
        
        contact con = new contact();
        con.LastName = 'Testing'; 
        con.AccountId = acc.Id;
        insert con; 
        
        Contract contractObj = new Contract();
        contractObj.AccountId =  acc.Id;
        contractObj.OF_IdContratto__c = 'test';
        contractObj.Status = 'Attivo';
        contractObj.StartDate = System.today();
        contractObj.ContractTerm = 30;
        contractObj.OF_EsistenzaServizio__c = True;
        insert contractObj;
        
        OF_ElencoComuniItaliani__c eleCom = new OF_ElencoComuniItaliani__c();
        eleCom.OF_CodiceIstat__c ='test';
        eleCom.OF_Comune__c = 'test';
        eleCom.OF_Provincia__c = 'test';
        eleCom.OF_Regione__c = 'test';
        eleCom.OF_Ripartizionegeografica__c = 'test';
        insert eleCom;
        
        case parentCase = new case();
        parentCase.accountId = acc.Id;
        parentCase.PO_BB_1_via_interessato__c  = 100;
        parentCase.PO_Posa_1_via_nuovo_Drop__c = 100;
        parentCase.PO_BB_2_via_interessato__c =100;
        parentCase.PO_Posa_2_via_nuovo_Drop__c = 100;
        ParentCase.recordTypeId = rtId1;
        parentCase.contactId = con.Id;
        parentCase.Status = 'Acquisito';
        parentCase.PO_Comune2__c = eleCom.Id;
        parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100.00;
        parentCase.PO_Costo_lavori_ottici__c = 100.00;
        parentCase.PO_Tipo_di_collegamento__c = 'SDH';
        parentCase.PO_Posa_1_nuovo_Drop__c = 100;
        parentCase.PO_BB_1_interessato__c= 2;
        parentCase.PO_BB_2_interessato__c= 2; 
        insert parentCase;  
        
        case ChildCase = new Case();
        ChildCase.ParentId = parentCase.id;
        ChildCase.status='Acquisito';
        ChildCase.recordTypeId = rtId1;
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.accountId = acc.Id;
        ChildCase.PO_Comune2__c = eleCom.Id;
        //ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'SDH';
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        ChildCase.PO_BB_1_via_interessato__c  = 100;
        ChildCase.PO_Posa_1_via_nuovo_Drop__c = 100;
        ChildCase.PO_BB_2_via_interessato__c =100;
        ChildCase.PO_Posa_2_via_nuovo_Drop__c = 100;
        ChildCase.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase.PO_BB_1_interessato__c= 2;
        ChildCase.PO_BB_2_interessato__c= 2; 
        insert ChildCase;
        
        case ChildCase1 = new Case();
        ChildCase1.ParentId = parentCase.id;
        ChildCase.recordTypeId = rtId1;
        ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase1.accountId = acc.Id;
        ChildCase1.PO_Comune2__c = eleCom.Id;
        ChildCase1.PO_Costo_lavori_civili__c = 100.00;
        ChildCase1.PO_Costo_lavori_ottici__c = 100.00;
        ChildCase1.contactId = con.Id; 
        ChildCase1.PO_Numero_fibre_richieste__c = '2';
        ChildCase1.PO_BB_1_via_interessato__c  = 100;
        ChildCase1.PO_Posa_1_via_nuovo_Drop__c = 100;
        ChildCase1.PO_BB_2_via_interessato__c  = 100;
        ChildCase1.PO_Posa_2_via_nuovo_Drop__c = 100; 
        ChildCase1.PO_Posa_1_nuovo_Drop__c = 100;
        ChildCase1.PO_BB_1_interessato__c= 2;
        ChildCase1.PO_BB_2_interessato__c= 2; 
        insert ChildCase1;
        
        OF_CatalogoCommerciale__c catlogcomm = new OF_CatalogoCommerciale__c();
        catlogcomm.Name ='P2P Base';
        catlogcomm.OF_Attivo__c = True ;
        catlogcomm.OF_DataFineValidita__c = Date.newInstance(2068,1,1);
        catlogcomm.OF_DataInizioValidita__c = Date.newInstance(1992,12,01);
        insert catlogcomm;
        
        OF_Servizio__c ser = new OF_Servizio__c();
        ser.Name ='P2P Base';
        ser.OF_Attivo__c = True;
        ser.OF_CatalogoCommerciale__c =  catlogcomm.Id;
        ser.OF_DataFineValidita__c = System.today()+15;
        ser.OF_DataInizioValidita__c = System.today()+1;
        insert ser;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c();
        comElement.Name = 'SINGOLA VIA BIFIBRA';
        comElement.OF_Servizio__c = ser.Id;
        comElement.OF_DataFineValidita__c = System.today()+15;
        comElement.OF_DataInizioValidita__c = System.today()+10;
        insert comElement;
        
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name = 'testPb';
        pricebook.PO_Commercial_element__c = comElement.Id;
        pricebook.PO_Contratto__c = contractObj.Id;
        pricebook.isActive = true;
        insert pricebook;
        
        OF_AreaGeograficaCustom__c areageoCustom = new OF_AreaGeograficaCustom__c();
        areageoCustom.OF_Comune__c = 'Test';
        areageoCustom.OF_Istat__c = 'Test';
        areageoCustom.OF_Provincia__c = 'Test';
        areageoCustom.OF_Regione__c = 'Test';
        insert areageoCustom;
        
        OF_AreaGeograficaJunction__c areageoJun = new OF_AreaGeograficaJunction__c();
        areageoJun.OF_AreaGeografica__c = areageoCustom.Id;
        areageoJun.OF_Comune__c = 'Test';
        areageoJun.OF_Contratto__c = contractObj.Id;
        areageoJun.Servizio__c = ser.Id;
        areageoJun.OF_Provincia__c ='test';
        areageoJun.OF_Regione__c ='test';
        insert areageoJun;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<Opportunity> oppList = new List<Opportunity>();
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Open';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.pricebook2Id = pricebookID;
        insert opportunity;
        oppList.add(opportunity);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'TestOpportunity1';
        opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity1.PO_Collegamento__c = ChildCase1.id;
        opportunity1.PO_Offerta_totale__c = opportunity.id;
        opportunity1.PO_Totale_canoni__c = 100;
        opportunity1.PO_Summary__c = true;
        opportunity1.StageName = 'Open';
        opportunity1.CloseDate = System.today();
        opportunity1.PO_Canone_collegamento__c = 100.00;    
        opportunity1.PO_Canone_collegamento_scontato__c = 90.00;
        opportunity1.PO_CostiCollegamento__c = 100;
        insert opportunity1;
        oppList.add(opportunity1);
        
        Map<ID, Opportunity> OpptyMap = new Map<ID, Opportunity>();
        OpptyMap.put(opportunity.ID,Opportunity);
        OpptyMap.put(opportunity1.ID,Opportunity1);
        
        //Create your product
        Product2 prod = new Product2(Name = 'Contributo Aggiuntivo',
                                     ProductCode = 'TestPro',
                                     isActive = true
                                    );
        insert prod;
        
        Product2 prod1 = new Product2(Name = 'Canone',
                                      ProductCode = 'TestPro',
                                      isActive = true
                                     );
        insert prod1;
        Product2 prod2 = new Product2(Name = 'Contributo Attivazione',
                                      ProductCode = 'TestPro',
                                      isActive = true
                                     );
        insert prod2;
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 100.00,
                                                    IsActive = true
                                                   );
        insert pbEntry;
        
        PricebookEntry pbEntry1 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod1.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry1;
        PricebookEntry pbEntry2 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod2.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry2;
        
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opportunity1.Id,
                                                          PricebookEntryId = pbEntry.Id,
                                                          Quantity = 5,
                                                          TotalPrice =  100
                                                         );
        insert oli; 
        
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry1.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100
                                                          );
        insert oli1; 
        OpportunityLineItem oli2 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry2.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100
                                                          );
        insert oli2; 
        
        Test.startTest();
        UtilityHandler.updateContract(oppList);
        //UtilityHandler.ChildOppOrphanDiscountUpdation(oppList);
        Test.stopTest();
    }  
    
    static testMethod void UtilityHandlerMethod2()
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId(); 
        
        Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
        Id rtyId1 = OpptyRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
        
        Test.startTest();
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name = 'Default';
        paramFat.Fascia1__c = 1;
        insert paramFat;
        
        Account acc = new Account();
        acc.name = 'TestAccount';
        acc.Type = 'Customer';
        acc.Industry = 'Automotive';       
        insert acc;
        
        contact con = new contact();
        con.LastName = 'Testing'; 
        con.AccountId = acc.Id;
        insert con; 
        
        Contract contractObj = new Contract();
        contractObj.AccountId =  acc.Id;
        contractObj.OF_IdContratto__c = 'test';
        contractObj.Status = 'Attivo';
        contractObj.StartDate = System.today();
        contractObj.ContractTerm = 30;
        contractObj.OF_EsistenzaServizio__c = True;
        insert contractObj;
        
        OF_ElencoComuniItaliani__c eleCom = new OF_ElencoComuniItaliani__c();
        eleCom.OF_CodiceIstat__c ='test';
        eleCom.OF_Comune__c = 'test';
        eleCom.OF_Provincia__c = 'test';
        eleCom.OF_Regione__c = 'test';
        eleCom.OF_Ripartizionegeografica__c = 'test';
        insert eleCom;
        
        case parentCase = new case();
        parentCase.accountId = acc.Id;
        ParentCase.recordTypeId = rtId1;
        parentCase.contactId = con.Id;
        parentCase.Status = 'Acquisito';
        parentCase.PO_Comune2__c = eleCom.Id;
        parentCase.PO_Offerta__c = 'Fiber Link';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100.00;
        parentCase.PO_Costo_lavori_ottici__c = 100.00;
        parentCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        insert parentCase;  
        
        case ChildCase = new Case();
        ChildCase.status='Acquisito';        
        ChildCase.ParentId = parentCase.id;
        ChildCase.recordTypeId = rtId1;
        ChildCase.accountId = acc.Id;
        ChildCase.PO_Comune2__c = eleCom.Id;
        //ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        insert ChildCase;
        
        case ChildCase1 = new Case();
        ChildCase1.status='Acquisito';        
        ChildCase1.ParentId = parentCase.id;
        ChildCase1.recordTypeId = rtId1;
        ChildCase1.accountId = acc.Id;
        ChildCase1.PO_Comune2__c = eleCom.Id;
        // ChildCase1.PO_Offerta__c = 'P2P Base';
        ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase1.PO_Costo_lavori_civili__c = 100.00;
        ChildCase1.PO_Costo_lavori_ottici__c = 100.00;
        ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase1.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase1.contactId = con.Id; 
        ChildCase1.PO_Numero_fibre_richieste__c = '2';
        insert ChildCase1;
        
        OF_CatalogoCommerciale__c catlogcomm = new OF_CatalogoCommerciale__c();
        catlogcomm.Name ='P2P Base';
        catlogcomm.OF_Attivo__c = True ;
        catlogcomm.OF_DataFineValidita__c = Date.newInstance(2068,1,1);
        catlogcomm.OF_DataInizioValidita__c = Date.newInstance(1992,12,01);
        insert catlogcomm;
        
        OF_Servizio__c ser = new OF_Servizio__c();
        ser.Name ='IRU';
        ser.OF_Attivo__c = True;
        ser.OF_CatalogoCommerciale__c =  catlogcomm.Id;
        ser.OF_DataFineValidita__c = System.today()+15;
        ser.OF_DataInizioValidita__c = System.today()+1;
        insert ser;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c();
        comElement.Name = 'SINGOLA VIA BIFIBRA';
        comElement.OF_Servizio__c = ser.Id;
        comElement.OF_DataFineValidita__c = System.today()+15;
        comElement.OF_DataInizioValidita__c = System.today()+10;
        insert comElement;
        
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name= 'testPB';
        pricebook.PO_Commercial_element__c = comElement.Id;
        pricebook.PO_Contratto__c = contractObj.Id;
        pricebook.isActive = true;
        insert pricebook;
        
        OF_AreaGeograficaCustom__c areageoCustom = new OF_AreaGeograficaCustom__c();
        areageoCustom.OF_Comune__c = 'Test';
        areageoCustom.OF_Istat__c = 'Test';
        areageoCustom.OF_Provincia__c = 'Test';
        areageoCustom.OF_Regione__c = 'Test';
        insert areageoCustom;
        
        OF_AreaGeograficaJunction__c areageoJun = new OF_AreaGeograficaJunction__c();
        areageoJun.OF_AreaGeografica__c = areageoCustom.Id;
        areageoJun.OF_Comune__c = 'Test';
        areageoJun.OF_Contratto__c = contractObj.Id;
        areageoJun.Servizio__c = ser.Id;
        areageoJun.OF_Provincia__c ='test';
        areageoJun.OF_Regione__c ='test';
        insert areageoJun;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<Opportunity> oppList = new List<Opportunity>();
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.recordTypeId = rtyId1;
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100.00;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Open';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.PO_Sconto_contributi_attivazione__c = 20;
        opportunity.pricebook2Id = pricebookID;
        insert opportunity;
        oppList.add(opportunity);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'TestOpportunity1';
        opportunity1.recordTypeId = rtyId1;
        opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity1.PO_Collegamento__c = ChildCase1.id;
        opportunity1.PO_Offerta_totale__c = opportunity.id;
        opportunity1.PO_Totale_canoni__c = 100.00;
        opportunity1.PO_Summary__c = true;
        opportunity1.StageName = 'Open';
        opportunity1.CloseDate = System.today();
        opportunity1.PO_Canone_collegamento__c = 100.00;    
        opportunity1.PO_Canone_collegamento_scontato__c = 90.00;
        Opportunity1.PO_Contributo_attivazione_collegamento__c = 10;
        insert opportunity1;
        oppList.add(opportunity1);
        
        Map<ID, Opportunity> OpptyMap = new Map<ID, Opportunity> ();
        OpptyMap.put(opportunity.ID,Opportunity);
        OpptyMap.put(opportunity1.ID,Opportunity1);
        
        //Create your product
        Product2 prod = new Product2(Name = 'Contributo Aggiuntivo',
                                     ProductCode = 'TestPro',
                                     PO_Anni_Fiber_Link__c = '3 Anni',
                                     isActive = true
                                    );
        insert prod;
        
        Product2 prod1 = new Product2(Name = 'Contributo Attivazione',
                                      ProductCode = 'TestPro',
                                      PO_Anni_Fiber_Link__c = '3 Anni',
                                      isActive = true
                                     );
        insert prod1;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 100.00,
                                                    IsActive = true
                                                   );
        insert pbEntry;
        
        PricebookEntry pbEntry1 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod1.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry1;
        
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opportunity1.Id,
                                                          PricebookEntryId = pbEntry.Id,
                                                          Quantity = 5,
                                                          TotalPrice =  100
                                                         );
        insert oli; 
        
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry1.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100
                                                          );
        insert oli1; 
        UtilityHandler.updateContract(oppList);
        UtilityHandler.ChildOppOrphanDiscountUpdation(OpptyMap,1);
        Test.stopTest();
    }
    
    static testMethod void UtilityHandlerMethod3()
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        
        Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.Opportunity; 
        Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
        Id rtyId1 = OpptyRecordTypeInfo.get('PO Oppty Fiber Link').getRecordTypeId();
        
        Test.startTest();
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name ='Default';
        paramFat.Fascia1__c = 1;
        insert paramFat;
        
        Account acc = new Account();
        acc.name = 'TestAccount';
        acc.Type = 'Customer';
        acc.Industry = 'Automotive';       
        insert acc;
        
        contact con = new contact();
        con.LastName = 'Testing'; 
        con.AccountId = acc.Id;
        insert con; 
        
        Contract contractObj = new Contract();
        contractObj.AccountId =  acc.Id;
        contractObj.OF_IdContratto__c = 'test';
        contractObj.Status = 'Attivo';
        contractObj.StartDate = System.today();
        contractObj.ContractTerm = 30;
        contractObj.OF_EsistenzaServizio__c = True;
        insert contractObj;
        
        OF_ElencoComuniItaliani__c eleCom = new OF_ElencoComuniItaliani__c();
        eleCom.OF_CodiceIstat__c ='test';
        eleCom.OF_Comune__c = 'test';
        eleCom.OF_Provincia__c = 'test';
        eleCom.OF_Regione__c = 'test';
        eleCom.OF_Ripartizionegeografica__c = 'test';
        insert eleCom;
        
        case parentCase = new case();
        parentCase.accountId = acc.Id;
        ParentCase.recordTypeId = rtId1;
        parentCase.contactId = con.Id;
        parentCase.Status = 'Acquisito';
        parentCase.PO_Comune2__c = eleCom.Id;
        parentCase.PO_Offerta__c = 'Fiber Lease';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100.00;
        parentCase.PO_Costo_lavori_ottici__c = 100.00;
        parentCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        insert parentCase;  
        
        case ChildCase = new Case();
        ChildCase.status='Acquisito';        
        ChildCase.ParentId = parentCase.id;
        ChildCase.recordTypeId = rtId1;
        ChildCase.accountId = acc.Id;
        ChildCase.PO_Comune2__c = eleCom.Id;
        //ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        insert ChildCase;
        
        case ChildCase1 = new Case();
        ChildCase1.status='Acquisito';        
        ChildCase1.ParentId = parentCase.id;
        ChildCase1.recordTypeId = rtId1;
        ChildCase1.accountId = acc.Id;
        ChildCase1.PO_Comune2__c = eleCom.Id;
        //ChildCase1.PO_Offerta__c = 'P2P Base';
        ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase1.PO_Costo_lavori_civili__c = 100.00;
        ChildCase1.PO_Costo_lavori_ottici__c = 100.00;
        ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase1.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase1.contactId = con.Id; 
        ChildCase1.PO_Numero_fibre_richieste__c = '2';
        insert ChildCase1;
        
        OF_CatalogoCommerciale__c catlogcomm = new OF_CatalogoCommerciale__c();
        catlogcomm.Name ='P2P Base';
        catlogcomm.OF_Attivo__c = True ;
        catlogcomm.OF_DataFineValidita__c = Date.newInstance(2068,1,1);
        catlogcomm.OF_DataInizioValidita__c = Date.newInstance(1992,12,01);
        insert catlogcomm;
        
        OF_Servizio__c ser = new OF_Servizio__c();
        ser.Name ='Fiber Link';
        ser.OF_Attivo__c = True;
        ser.OF_CatalogoCommerciale__c =  catlogcomm.Id;
        ser.OF_DataFineValidita__c = System.today()+15;
        ser.OF_DataInizioValidita__c = System.today()+1;
        insert ser;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c();
        comElement.Name = 'SINGOLA VIA BIFIBRA';
        comElement.OF_Servizio__c = ser.Id;
        comElement.OF_DataFineValidita__c = System.today()+15;
        comElement.OF_DataInizioValidita__c = System.today()+10;
        insert comElement;
        
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name= 'testPB';
        pricebook.PO_Commercial_element__c = comElement.Id;
        pricebook.PO_Contratto__c = contractObj.Id;
        pricebook.isActive = true;
        insert pricebook;
        
        OF_AreaGeograficaCustom__c areageoCustom = new OF_AreaGeograficaCustom__c();
        areageoCustom.OF_Comune__c = 'Test';
        areageoCustom.OF_Istat__c = 'Test';
        areageoCustom.OF_Provincia__c = 'Test';
        areageoCustom.OF_Regione__c = 'Test';
        insert areageoCustom;
        
        OF_AreaGeograficaJunction__c areageoJun = new OF_AreaGeograficaJunction__c();
        areageoJun.OF_AreaGeografica__c = areageoCustom.Id;
        areageoJun.OF_Comune__c = 'Test';
        areageoJun.OF_Contratto__c = contractObj.Id;
        areageoJun.Servizio__c = ser.Id;
        areageoJun.OF_Provincia__c ='test';
        areageoJun.OF_Regione__c ='test';
        insert areageoJun;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<Opportunity> oppList = new List<Opportunity>();
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.recordTypeId = rtyId1;
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100.00;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Open';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.PO_Sconto_contributi_attivazione__c = 20;
        opportunity.pricebook2Id = pricebookID;
        insert opportunity;
        oppList.add(opportunity);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'TestOpportunity1';
        opportunity1.recordTypeId = rtyId1;
        opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity1.PO_Collegamento__c = ChildCase1.id;
        opportunity1.PO_Offerta_totale__c = opportunity.id;
        opportunity1.PO_Totale_canoni__c = 100.00;
        opportunity1.PO_Summary__c = true;
        opportunity1.StageName = 'Open';
        opportunity1.CloseDate = System.today();
        opportunity1.PO_Canone_collegamento__c = 100.00;    
        opportunity1.PO_Canone_collegamento_scontato__c = 90.00;
        Opportunity1.PO_Contributo_attivazione_collegamento__c = 10;
        insert opportunity1;
        oppList.add(opportunity1);
        
        Map<ID, Opportunity> OpptyMap = new Map<ID, Opportunity> ();
        OpptyMap.put(opportunity.ID,Opportunity);
        OpptyMap.put(opportunity1.ID,Opportunity1);
        
        //Create your product
        Product2 prod = new Product2(Name = 'Contributo Attivazione',
                                     ProductCode = 'TestPro',
                                     PO_Anni_Fiber_Link__c = '1 Anno',
                                     isActive = true
                                    );
        insert prod;
        
        Product2 prod1 = new Product2(Name = 'Contributo Aggiuntivo',
                                      ProductCode = 'TestPro',
                                      PO_Anni_Fiber_Link__c = '1 Anno',
                                      isActive = true
                                     );
        insert prod1;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 100.00,
                                                    IsActive = true
                                                   );
        insert pbEntry;
        
        PricebookEntry pbEntry1 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod1.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry1;
        
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opportunity1.Id,
                                                          PricebookEntryId = pbEntry.Id,
                                                          Quantity = 5,
                                                          TotalPrice =  100
                                                         );
        insert oli; 
        
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry1.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100
                                                          );
        insert oli1; 
        UtilityHandler.updateContract(oppList);
        UtilityHandler.ChildOppOrphanDiscountUpdation(OpptyMap,1);
        Test.stopTest();
    }
    
    static testMethod void UtilityHandlerMethod4()
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.Opportunity; 
        Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
        Id rtyId1 = OpptyRecordTypeInfo.get('PO Oppty Fiber Link').getRecordTypeId();  
        
        Test.startTest();
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name = 'Default';
        paramFat.Fascia1__c = 1;
        insert paramFat; 
        Account acc = new Account();
        acc.name = 'TestAccount';
        acc.Type = 'Customer';
        acc.Industry = 'Automotive';       
        insert acc;
        
        contact con = new contact();
        con.LastName = 'Testing'; 
        con.AccountId = acc.Id;
        insert con; 
        
        Contract contractObj = new Contract();
        contractObj.AccountId =  acc.Id;
        contractObj.OF_IdContratto__c = 'test';
        contractObj.Status = 'Attivo';
        contractObj.StartDate = System.today();
        contractObj.ContractTerm = 30;
        contractObj.OF_EsistenzaServizio__c = True;
        insert contractObj;
        
        OF_ElencoComuniItaliani__c eleCom = new OF_ElencoComuniItaliani__c();
        eleCom.OF_CodiceIstat__c ='test';
        eleCom.OF_Comune__c = 'test';
        eleCom.OF_Provincia__c = 'test';
        eleCom.OF_Regione__c = 'test';
        eleCom.OF_Ripartizionegeografica__c = 'test';
        insert eleCom;
        
        case parentCase = new case();
        parentCase.accountId = acc.Id;
        ParentCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        parentCase.contactId = con.Id;
        parentCase.Status = 'Acquisito';
        parentCase.PO_Comune2__c = eleCom.Id;
        parentCase.PO_Offerta__c = 'Fiber Lease';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100.00;
        parentCase.PO_Costo_lavori_ottici__c = 100.00;
        parentCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        insert parentCase;  
        
        case ChildCase = new Case();
        ChildCase.status='Acquisito';        
        ChildCase.ParentId = parentCase.id;
        ChildCase.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU' ).getRecordTypeId();
        ChildCase.accountId = acc.Id;
        ChildCase.PO_Comune2__c = eleCom.Id;
        //ChildCase.PO_Offerta__c = 'P2P Base';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        insert ChildCase;
        
        case ChildCase1 = new Case();
        ChildCase1.status='Acquisito';        
        ChildCase1.ParentId = parentCase.id;
        ChildCase1.recordtypeid = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        ChildCase1.accountId = acc.Id;
        ChildCase1.PO_Comune2__c = eleCom.Id;
        //ChildCase1.PO_Offerta__c = 'P2P Base';
        ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase1.PO_Costo_lavori_civili__c = 100.00;
        ChildCase1.PO_Costo_lavori_ottici__c = 100.00;
        ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase1.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase1.contactId = con.Id; 
        ChildCase1.PO_Numero_fibre_richieste__c = '2';
        insert ChildCase1;
        
        OF_CatalogoCommerciale__c catlogcomm = new OF_CatalogoCommerciale__c();
        catlogcomm.Name ='P2P Base';
        catlogcomm.OF_Attivo__c = True ;
        catlogcomm.OF_DataFineValidita__c = Date.newInstance(2068,1,1);
        catlogcomm.OF_DataInizioValidita__c = Date.newInstance(1992,12,01);
        insert catlogcomm;
        
        OF_Servizio__c ser = new OF_Servizio__c();
        ser.Name ='Fiber Lease';
        ser.OF_Attivo__c = True;
        ser.OF_CatalogoCommerciale__c =  catlogcomm.Id;
        ser.OF_DataFineValidita__c = System.today()+15;
        ser.OF_DataInizioValidita__c = System.today()+1;
        insert ser;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c();
        comElement.Name = 'SINGOLA VIA BIFIBRA';
        comElement.OF_Servizio__c = ser.Id;
        comElement.OF_DataFineValidita__c = System.today()+15;
        comElement.OF_DataInizioValidita__c = System.today()+10;
        insert comElement;
        
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name= 'testPB';
        pricebook.PO_Commercial_element__c = comElement.Id;
        pricebook.PO_Contratto__c = contractObj.Id;
        pricebook.isActive = true;
        insert pricebook;
        
        OF_AreaGeograficaCustom__c areageoCustom = new OF_AreaGeograficaCustom__c();
        areageoCustom.OF_Comune__c = 'Test';
        areageoCustom.OF_Istat__c = 'Test';
        areageoCustom.OF_Provincia__c = 'Test';
        areageoCustom.OF_Regione__c = 'Test';
        insert areageoCustom;
        
        OF_AreaGeograficaJunction__c areageoJun = new OF_AreaGeograficaJunction__c();
        areageoJun.OF_AreaGeografica__c = areageoCustom.Id;
        areageoJun.OF_Comune__c = 'Test';
        areageoJun.OF_Contratto__c = contractObj.Id;
        areageoJun.Servizio__c = ser.Id;
        areageoJun.OF_Provincia__c ='test';
        areageoJun.OF_Regione__c ='test';
        insert areageoJun;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<Opportunity> oppList = new List<Opportunity>();
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.RecordTypeID = rtyId1;
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100.00;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Open';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.PO_Sconto_contributi_attivazione__c = 20;
        opportunity.pricebook2Id = pricebookID;
        insert opportunity;
        oppList.add(opportunity);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'TestOpportunity1';
        opportunity1.RecordTypeID = rtyId1;
        opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity1.PO_Collegamento__c = ChildCase1.id;
        opportunity1.PO_Offerta_totale__c = opportunity.id;
        opportunity1.PO_Totale_canoni__c = 100.00;
        opportunity1.PO_Summary__c = true;
        opportunity1.StageName = 'Open';
        opportunity1.CloseDate = System.today();
        opportunity1.PO_Canone_collegamento__c = 100.00;    
        opportunity1.PO_Canone_collegamento_scontato__c = 90.00;
        Opportunity1.PO_Contributo_attivazione_collegamento__c = 10;
        
        insert opportunity1;
        oppList.add(opportunity1);
        
        Map<ID, Opportunity> OpptyMap = new Map<ID, Opportunity> ();
        OpptyMap.put(opportunity.ID,Opportunity);
        OpptyMap.put(opportunity1.ID,Opportunity1);
        
        //Create your product
        Product2 prod = new Product2(Name = 'Canone',
                                     ProductCode = 'TestPro',
                                     PO_Anni_Fiber_Link__c = '1 Anno',
                                     isActive = true
                                    );
        insert prod;
        
        Product2 prod1 = new Product2(Name = 'Canone',
                                      ProductCode = 'TestPro',
                                      PO_Anni_Fiber_Link__c = '2 Anni',
                                      isActive = true
                                     );
        insert prod1;
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 100.00,
                                                    IsActive = true
                                                   );
        insert pbEntry;
        
        PricebookEntry pbEntry1 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod1.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry1;
        
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opportunity1.Id,
                                                          PricebookEntryId = pbEntry.Id,
                                                          Quantity = 5,
                                                          TotalPrice =  100
                                                         );
        insert oli; 
        
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry1.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100
                                                          );
        insert oli1; 
        UtilityHandler.updateContract(oppList);
        UtilityHandler.ChildOppOrphanDiscountUpdation(OpptyMap,1);
        Test.stopTest();
    }
    
    static testMethod void UtilityHandlerMethod5()
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.Opportunity; 
        Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
        Id rtyId1 = OpptyRecordTypeInfo.get('PO Oppty Fiber Link').getRecordTypeId();
        
        Test.startTest();
        Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
        paramFat.Name = 'Default';
        paramFat.Fascia1__c = 1;
        insert paramFat; 
        
        Account acc = new Account();
        acc.name = 'TestAccount';
        acc.Type = 'Customer';
        acc.Industry = 'Automotive';       
        insert acc;
        
        contact con = new contact();
        con.LastName = 'Testing'; 
        con.AccountId = acc.Id;
        insert con; 
        
        Contract contractObj = new Contract();
        contractObj.AccountId =  acc.Id;
        contractObj.OF_IdContratto__c = 'test';
        contractObj.Status = 'Attivo';
        contractObj.StartDate = System.today();
        contractObj.ContractTerm = 30;
        contractObj.OF_EsistenzaServizio__c = True;
        insert contractObj;
        
        OF_ElencoComuniItaliani__c eleCom = new OF_ElencoComuniItaliani__c();
        eleCom.OF_CodiceIstat__c ='test';
        eleCom.OF_Comune__c = 'test';
        eleCom.OF_Provincia__c = 'test';
        eleCom.OF_Regione__c = 'test';
        eleCom.OF_Ripartizionegeografica__c = 'test';
        insert eleCom;
        
        case parentCase = new case();
        parentCase.accountId = acc.Id;
        ParentCase.recordTypeId = rtId1;
        parentCase.contactId = con.Id;
        parentCase.Status = 'Acquisito';
        parentCase.PO_Comune2__c = eleCom.Id;
        parentCase.PO_Offerta__c = 'Fiber Link';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100.00;
        parentCase.PO_Costo_lavori_ottici__c = 100.00;
        parentCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        insert parentCase;  
        
        case ChildCase = new Case();
        ChildCase.status='Acquisito';        
        ChildCase.ParentId = parentCase.id;
        ChildCase.recordTypeId = rtId1;
        ChildCase.accountId = acc.Id;
        ChildCase.PO_Comune2__c = eleCom.Id;
        ChildCase.PO_Offerta__c = 'Fiber Link';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase.contactId = con.Id; 
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        insert ChildCase;
        
        case ChildCase1 = new Case();
        ChildCase1.status='Acquisito';
        ChildCase1.ParentId = parentCase.id;
        ChildCase1.recordTypeId = rtId1;
        ChildCase1.accountId = acc.Id;
        ChildCase1.PO_Comune2__c = eleCom.Id;
        ChildCase1.PO_Offerta__c = 'Fiber Link';
        ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase1.PO_Costo_lavori_civili__c = 100.00;
        ChildCase1.PO_Costo_lavori_ottici__c = 100.00;
        ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase1.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase1.contactId = con.Id; 
        ChildCase1.PO_Numero_fibre_richieste__c = '2';
        insert ChildCase1;
        
        OF_CatalogoCommerciale__c catlogcomm = new OF_CatalogoCommerciale__c();
        catlogcomm.Name ='P2P BaseAcc';
        catlogcomm.OF_Attivo__c = True ;
        catlogcomm.OF_DataFineValidita__c = Date.newInstance(2068,1,1);
        catlogcomm.OF_DataInizioValidita__c = Date.newInstance(1992,12,01);
        insert catlogcomm;
        
        OF_Servizio__c ser = new OF_Servizio__c();
        ser.Name ='Fiber Link';
        ser.OF_Attivo__c = True;
        ser.OF_CatalogoCommerciale__c =  catlogcomm.Id;
        ser.OF_DataFineValidita__c = System.today()+15;
        ser.OF_DataInizioValidita__c = System.today()+1;
        insert ser;
        
        List<OF_CommercialElement__c> comList = new List<OF_CommercialElement__c>();
        OF_CommercialElement__c comElement = new OF_CommercialElement__c();
        comElement.Name = 'SINGOLA VIA BIFIBRA';
        comElement.OF_Servizio__c = ser.Id;
        comElement.OF_DataFineValidita__c = System.today()+15;
        comElement.OF_DataInizioValidita__c = System.today()+10;
        insert comElement;
        
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name= 'testPB';
        pricebook.PO_Commercial_element__c = comElement.Id;
        pricebook.PO_Contratto__c = contractObj.Id;
        pricebook.isActive = true;
        insert pricebook;
        
        OF_AreaGeograficaCustom__c areageoCustom = new OF_AreaGeograficaCustom__c();
        areageoCustom.OF_Comune__c = 'Test';
        areageoCustom.OF_Istat__c = 'Test';
        areageoCustom.OF_Provincia__c = 'Test';
        areageoCustom.OF_Regione__c = 'Test';
        insert areageoCustom;
        
        OF_AreaGeograficaJunction__c areageoJun = new OF_AreaGeograficaJunction__c();
        areageoJun.OF_AreaGeografica__c = areageoCustom.Id;
        areageoJun.OF_Comune__c = 'Test';
        areageoJun.OF_Contratto__c = contractObj.Id;
        areageoJun.Servizio__c = ser.Id;
        areageoJun.OF_Provincia__c ='test';
        areageoJun.OF_Regione__c ='test';
        insert areageoJun;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<Opportunity> oppList = new List<Opportunity>();
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.RecordTypeId = rtyId1;
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100.00;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Open';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.PO_Sconto_contributi_attivazione__c = 20;
        opportunity.pricebook2Id =pricebookID;
        insert opportunity;
        oppList.add(opportunity);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'TestOpportunity1';
        opportunity1.RecordTypeId = rtyId1;
        opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity1.PO_Collegamento__c = ChildCase1.id;
        opportunity1.PO_Offerta_totale__c = opportunity.id;
        opportunity1.PO_Totale_canoni__c = 100.00;
        opportunity1.PO_Summary__c = true;
        opportunity1.StageName = 'Open';
        opportunity1.CloseDate = System.today();
        opportunity1.PO_Canone_collegamento__c = 100.00;    
        opportunity1.PO_Canone_collegamento_scontato__c = 90.00;
        Opportunity1.PO_Contributo_attivazione_collegamento__c = 10;
        insert opportunity1;
        oppList.add(opportunity1);
        
        Map<ID, Opportunity> OpptyMap = new Map<ID, Opportunity> ();
        OpptyMap.put(opportunity.ID,Opportunity);
        OpptyMap.put(opportunity1.ID,Opportunity1);
        
        //Create your product
        Product2 prod = new Product2(Name = 'Contributo Attivazione',
                                     ProductCode = 'TestPro',
                                     PO_Anni_Fiber_Link__c = 'X Anni',
                                     isActive = true
                                    );
        insert prod;
        
        Product2 prod1 = new Product2(Name = 'Contributo Aggiuntivo',
                                      ProductCode = 'TestPro',
                                      PO_Anni_Fiber_Link__c = 'X Anni',
                                      isActive = true
                                     );
        insert prod1;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 100.00,
                                                    IsActive = true
                                                   );
        insert pbEntry;
        
        PricebookEntry pbEntry1 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod1.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry1;
        
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opportunity1.Id,
                                                          PricebookEntryId = pbEntry.Id,
                                                          Quantity = 5,
                                                          TotalPrice =  100
                                                         );
        insert oli; 
        
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry1.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100
                                                          );
        insert oli1; 
        UtilityHandler.updateContract(oppList);
        UtilityHandler.ChildOppOrphanDiscountUpdation(OpptyMap,1);
        Test.stopTest();
    }
    
  /*  static testMethod void OppLineItemIRU1()
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
        Id rtId2 = OpptyRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
        
        Test.startTest();
        case parentCase = new case();
        ParentCase.recordTypeId = rtId1;
        parentCase.Status = 'Acquisito';
        parentCase.PO_Offerta__c = 'IRU';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100.00;
        parentCase.PO_Costo_lavori_ottici__c = 100.00;
        parentCase.PO_BB_1_via_interessato__c = 200;
        parentCase.PO_Posa_1_via_nuovo_Drop__c = 200;
        parentCase.PO_BB_2_via_interessato__c = 300;
        parentCase.PO_Posa_2_via_nuovo_Drop__c = 300;
        parentCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        insert parentCase;  
        
        case ChildCase = new Case();
        ChildCase.status='Acquisito';        
        ChildCase.ParentId = parentCase.id;
        ChildCase.recordTypeId = rtId1;
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        insert ChildCase;
        
        case ChildCase1 = new Case();
        ChildCase1.status='Acquisito';        
        ChildCase1.ParentId = parentCase.id;
        ChildCase1.recordTypeId = rtId1;
        ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase1.PO_Costo_lavori_civili__c = 100.00;
        ChildCase1.PO_Costo_lavori_ottici__c = 100.00;
        ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase1.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase1.PO_Numero_fibre_richieste__c = '2';
        insert ChildCase1;
        
        OF_CatalogoCommerciale__c catlogcomm = new OF_CatalogoCommerciale__c();
        catlogcomm.Name ='P2P Base';
        catlogcomm.OF_Attivo__c = True ;
        catlogcomm.OF_DataFineValidita__c = Date.newInstance(2068,1,1);
        catlogcomm.OF_DataInizioValidita__c = Date.newInstance(1992,12,01);
        insert catlogcomm;
        
        OF_Servizio__c ser = new OF_Servizio__c();
        ser.Name ='IRU';
        ser.OF_Attivo__c = True;
        ser.OF_CatalogoCommerciale__c =  catlogcomm.Id;
        ser.OF_DataFineValidita__c = System.today()+20;
        ser.OF_DataInizioValidita__c = System.today()+1;
        insert ser;
        
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name= 'testPB';
        pricebook.isActive = true;
        insert pricebook;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<Opportunity> oppList = new List<Opportunity>();
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.recordTypeId = rtId2;
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100.00;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Open';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.PO_Sconto_contributi_attivazione__c = 20;
        opportunity.PO_Sconto_corrispettivo_IRU__c = 30;
        opportunity.PO_Corrispettivo_IRU__c = 30;
        opportunity.pricebook2Id = pricebookID;
        insert opportunity;
        oppList.add(opportunity);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'TestOpportunity1';
        opportunity1.recordTypeId = rtId2;
        opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity1.PO_Collegamento__c = ChildCase1.id;
        opportunity1.PO_Offerta_totale__c = opportunity.id;
        opportunity1.PO_Totale_canoni__c = 100.00;
        opportunity1.PO_Summary__c = true;
        opportunity1.StageName = 'Open';
        opportunity1.CloseDate = System.today();
        opportunity1.PO_Canone_collegamento__c = 100.00;    
        opportunity1.PO_Canone_collegamento_scontato__c = 90.00;
        Opportunity1.PO_Contributo_attivazione_collegamento__c = 10;
        insert opportunity1;
        oppList.add(opportunity1);
        
        //Create your product
        Product2 prod = new Product2(Name = 'Corrispettivo IRU',
                                     ProductCode = 'TestPro',
                                     isActive = true
                                    );
        insert prod;
        
        Product2 prod1 = new Product2(Name = 'Canone Manutenzione',
                                      ProductCode = 'TestPro',
                                      isActive = true
                                     );
        insert prod1;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 100.00,
                                                    IsActive = true
                                                   );
        insert pbEntry;
        
        PricebookEntry pbEntry1 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod1.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry1;
        
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opportunity1.Id,
                                                          PricebookEntryId = pbEntry.Id,
                                                          Quantity = 5,
                                                          TotalPrice =  100,
                                                          PO_SalesPrice__c = 10
                                                         );
        insert oli; 
        
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry1.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100,
                                                           PO_SalesPrice__c = 10
                                                          );
        insert oli1;
        Test.stopTest();
    }*/
    
    static testMethod void OppLineItemIRU2()
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        
        Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.opportunity; 
        Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
        Id rtId2 = OpptyRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
        Id rtId3 = OpptyRecordTypeInfo.get('PO Oppty Misto Lease-Link per FW').getRecordTypeId();
        
        List<OF_FiberLeaseListinoPrezzoAnnuo__c> PrezzoAnnuoList = new List<OF_FiberLeaseListinoPrezzoAnnuo__c>();
        for(integer i = 0 ; i <= 13; i++)
        {
            OF_FiberLeaseListinoPrezzoAnnuo__c PrezzoAnnuo = new OF_FiberLeaseListinoPrezzoAnnuo__c();
            PrezzoAnnuo.Name = String.valueOf(i);
            PrezzoAnnuo.Prezzo__c = 70;
            PrezzoAnnuo.Anno__c = 'Anno13';
            PrezzoAnnuoList.add(PrezzoAnnuo);
        }
        insert PrezzoAnnuoList;
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo1 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo1.Name ='Backbone1';
        fiberPrezzo1.Prezzo__c = 70;
        insert fiberPrezzo1; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo2.Name = 'Backbone2';
        fiberPrezzo2.Prezzo__c = 70;
        insert fiberPrezzo2; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo3 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo3.Name = 'Drop1';
        fiberPrezzo3.Prezzo__c = 70;
        insert fiberPrezzo3; 
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo4 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo4.Name = 'Drop2';
        fiberPrezzo4.Prezzo__c = 70;
        insert fiberPrezzo4;
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo5 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo5.Name ='Drop2AltreCoppie';
        fiberPrezzo5.Prezzo__c = 70;
        insert fiberPrezzo5;
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo6 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo6.Name ='CostanteFiberLease1';
        fiberPrezzo6.Prezzo__c = 70;
        insert fiberPrezzo6;
        
        OF_FiberLeasePrezzoMedioAnnuo__c  fiberPrezzo7 = new OF_FiberLeasePrezzoMedioAnnuo__c();
        fiberPrezzo7.Name ='CostanteFiberLease2';
        fiberPrezzo7.Prezzo__c = 70;
        insert fiberPrezzo7;
        
        Test.startTest();        
        case parentCase = new case();
        ParentCase.recordTypeId = rtId1;
        parentCase.Status = 'Acquisito';
        parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.PO_Tipo_percorso__c = 'Singola Via';
        parentCase.PO_Costo_lavori_civili__c = 100.00;
        parentCase.PO_Costo_lavori_ottici__c = 100.00;
        parentCase.PO_BB_1_via_interessato__c = 200;
        parentCase.PO_Posa_1_via_nuovo_Drop__c = 200;
        parentCase.PO_BB_2_via_interessato__c = 300;
        parentCase.PO_Posa_2_via_nuovo_Drop__c = 300;
        parentCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        insert parentCase;  
        
        case ChildCase = new Case();
        ChildCase.status='Acquisito';        
        ChildCase.ParentId = parentCase.id;
        ChildCase.recordTypeId = rtId1;
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Costo_lavori_civili__c = 100;
        ChildCase.PO_Costo_lavori_ottici__c = 100;
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase.PO_Numero_fibre_richieste__c = '1';
        insert ChildCase;
        
        case ChildCase1 = new Case();
        ChildCase1.status='Acquisito';        
        ChildCase1.ParentId = parentCase.id;
        ChildCase1.recordTypeId = rtId1;
        ChildCase1.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase1.PO_Costo_lavori_civili__c = 100.00;
        ChildCase1.PO_Costo_lavori_ottici__c = 100.00;
        ChildCase1.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase1.PO_Tipo_di_collegamento__c = 'Backhauling';
        ChildCase1.PO_Numero_fibre_richieste__c = '2';
        insert ChildCase1;
        
        OF_CatalogoCommerciale__c catlogcomm = new OF_CatalogoCommerciale__c();
        catlogcomm.Name ='P2P Base';
        catlogcomm.OF_Attivo__c = True ;
        catlogcomm.OF_DataFineValidita__c = Date.newInstance(2068,1,1);
        catlogcomm.OF_DataInizioValidita__c = Date.newInstance(1992,12,01);
        insert catlogcomm;
        
        OF_Servizio__c ser = new OF_Servizio__c();
        ser.Name ='P2P Base';
        ser.OF_Attivo__c = True;
        ser.OF_CatalogoCommerciale__c =  catlogcomm.Id;
        ser.OF_DataFineValidita__c = System.today()+20;
        ser.OF_DataInizioValidita__c = System.today()+1;
        insert ser;
        
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name= 'testPB';
        pricebook.isActive = true;
        insert pricebook;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<Opportunity> oppList = new List<Opportunity>();
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.recordTypeId = rtId3;
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100.00;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Open';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.PO_Sconto_contributi_attivazione__c = 20;
        opportunity.PO_Sconto_corrispettivo_IRU__c = 30;
        opportunity.PO_Corrispettivo_IRU__c = 30;
        opportunity.pricebook2Id = pricebookID;
        opportunity.PO_CostiCollegamento__c=100;
        opportunity.PO_CostoStruttura__c =100;
        
        insert opportunity;
        oppList.add(opportunity);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'TestOpportunity1';
        opportunity1.recordTypeId = rtId3;
        opportunity1.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity1.PO_Collegamento__c = ChildCase1.id;
        opportunity1.PO_Offerta_totale__c = opportunity.id;
        opportunity1.PO_Totale_canoni__c = 100.00;
        opportunity1.PO_Summary__c = true;
        opportunity1.StageName = 'Open';
        opportunity1.CloseDate = System.today();
        opportunity1.PO_Canone_collegamento__c = 100.00;    
        opportunity1.PO_Canone_collegamento_scontato__c = 90.00;
        Opportunity1.PO_Contributo_attivazione_collegamento__c = 10;
        opportunity1.PO_CostiCollegamento__c = 100.00;
        opportunity1.pricebook2Id = pricebookID; opportunity1.PO_CostiCollegamento__c=100;
        opportunity1.PO_CostoStruttura__c =100;
        system.debug('opportunity1=========='+opportunity1);
        try
        {
        insert opportunity1;
        }
        catch(exception e)
        {
            system.debug('error message===='+e.getStackTraceString());
        }
        oppList.add(opportunity1);
        
        //Create your product
        Product2 prod = new Product2(Name = 'Contributo Attivazione',
                                     ProductCode = 'TestPro',
                                     PO_Anni_Fiber_Link__c = '2 Anni',
                                     isActive = true
                                    );
        insert prod;
        
        Product2 prod1 = new Product2(Name = 'Contributo Aggiuntivo',
                                      ProductCode = 'TestPro',
                                      PO_Anni_Fiber_Link__c = '2 Anni',
                                      isActive = true
                                     );
        insert prod1;
        
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,
                                                    Product2Id = prod.Id,
                                                    UnitPrice = 100.00,
                                                    IsActive = true
                                                   );
        insert pbEntry;
        
        PricebookEntry pbEntry1 = new PricebookEntry(Pricebook2Id = pricebookId,
                                                     Product2Id = prod1.Id,
                                                     UnitPrice = 100.00,
                                                     IsActive = true
                                                    );
        insert pbEntry1;
        
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opportunity1.Id,
                                                          PricebookEntryId = pbEntry.Id,
                                                          Quantity = 5,
                                                          TotalPrice =  100,
                                                          PO_SalesPrice__c = 10
                                                         );
        insert oli; 
        
        OpportunityLineItem oli1 = new OpportunityLineItem(OpportunityId = opportunity.Id,
                                                           PricebookEntryId = pbEntry1.Id,
                                                           Quantity = 5,
                                                           TotalPrice =  100,
                                                           PO_SalesPrice__c = 10
                                                          );
        insert oli1;
        Test.stopTest();
    }
}
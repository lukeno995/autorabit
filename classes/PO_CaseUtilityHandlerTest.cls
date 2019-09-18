@isTest(SeeAllData = FALSE)
public class PO_CaseUtilityHandlerTest
{
    public static testMethod void t1() {
		new PO_CaseUtilityHandler();
	}
//     static testMethod void CalculateOppMethod()
//     {

//         OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
//         tibco.OF_Tibco_ID__c='00558000001f743AAA';
//         tibco.name='Tibco UserID';
//         insert tibco;

        
//         OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
//         abilitaTrig.name='Status';
//         abilitaTrig.OF_Enable_Trigger__c=true;
//         insert abilitaTrig;        


//         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
//         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
//         Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
//         Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
//         Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId(); 
//         Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
//         Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
//         Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
//         Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
//         Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.Opportunity; 
//         Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
//         Id opprdId = OpptyRecordTypeInfo.get('PO Oppty collegamenti').getRecordTypeId();
//         Id opprdId1 = OpptyRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
//         Id opprdId2 = OpptyRecordTypeInfo.get('PO Oppty Evento Temporaneo').getRecordTypeId();
//         Id opprdId3 = OpptyRecordTypeInfo.get('PO Oppty Fiber Lease').getRecordTypeId();
//         Id opprdId4 = OpptyRecordTypeInfo.get('PO Oppty Misto Lease-Link per FW').getRecordTypeId();
//         Id opprdId5 = OpptyRecordTypeInfo.get('PO Oppty Fiber Link').getRecordTypeId();
//              Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
//         insert AcntRec;
//         Account AcntRec1 = new Account(name = 'Acc1', Type = 'Customer', Industry = 'Automotive');
//         insert AcntRec1;
        
//         Product2 prod = new Product2(Name = 'Laptop X200',Family = 'Hardware');
//         insert prod;
        
//         Id pricebookId = Test.getStandardPricebookId();
//         PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
//                                                           Product2Id = prod.Id,
//                                                           UnitPrice = 10000,
//                                                           IsActive = true);
//         insert standardPrice;
        
//         Pricebook2 customPB = new Pricebook2(Name= 'P2P BaseAcc', isActive=true);
//         insert customPB;
//         PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id,
//                                                         UnitPrice = 12000, IsActive = true);
//         insert customPrice;
        
//         Case parentCase = new Case(PO_Offerta__c = 'P2P Base',
//                                   PO_Tipo_percorso__c = 'Singola Via',
//                                   PO_Costo_lavori_civili__c = 100,
//                                   RecordTypeId = rtId,
//                                   PO_Costo_lavori_ottici__c = 100,
//                                   PO_Incluso_nell_offerta__c= true,
//                                   Status ='Bozza', 
//                                   Priority = 'Medium',
//                                   Origin = 'Email'); 
//         insert parentCase;
        
//         List<case> caseList = new List<case>();
//         Case childCase1 = new Case(ParentId = parentCase.Id,
//                                   PO_Richiesta_a_fattibilit__c = parentCase.Id,
//                                   PO_Offerta__c = 'P2P Base',
//                                   RecordTypeId = rtId,
//                                   PO_Tipo_percorso__c = 'Singola Via',
//                                   PO_Costo_lavori_civili__c = 100,
//                                   PO_Costo_lavori_ottici__c = 100,
//                                   PO_Incluso_nell_offerta__c= true,
//                                   Status ='Bozza', 
//                                   Priority = 'Medium',
//                                   Origin = 'Email'); 
//         insert childCase1;        
//         caseList.add(childCase1);
        
//         Case childCase2 = new Case(ParentId = parentCase.Id,
//                                   PO_Richiesta_a_fattibilit__c = parentCase.Id,
//                                   PO_Offerta__c = 'P2P Base',
//                                   PO_Tipo_percorso__c = 'Singola Via',
//                                   RecordTypeId = rtId,
//                                   PO_Costo_lavori_civili__c = 100,
//                                   PO_Costo_lavori_ottici__c = 100,
//                                   PO_Incluso_nell_offerta__c= true,
//                                   Status ='Nuovo',
//                                   Priority = 'Medium',
//                                   Origin = 'Email'); 
//         insert childCase2;
//         caseList.add(childCase2);
        
//         Opportunity Parentopp = new Opportunity(Name = 'TestOpportunity',
//                                                 AccountId = AcntRec.Id,
//                                                 PO_Richiesta_fattibilit__c=parentCase.Id,
//                                                 PO_Collegamento__c = parentCase.Id,
//                                                 Pricebook2id= customPB.Id, 
//                                                 RecordTypeID = opprdId5,
//                                                 PO_Totale_canoni__c = 0,
//                                                 PO_Totale_contributi_attivazione__c = 100.00,
//                                                 PO_Totale_costi_aggiuntivi__c = 100.00,
//                                                 StageName = 'Prospecting',
//                                                 closeDate = Date.newInstance(2017,10,10));
//         insert Parentopp;
//         //Opportunity OppRecA = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c =parentCase.ID, name='Opp',Pricebook2id= customPB.Id, stageName='Open', closeDate=Date.newInstance(2008,10,10));
//         //insert OppRecA;
//         List<Opportunity> oppList = New List<Opportunity>();
//         Opportunity ChildOpp = new Opportunity(Name = 'Unit TestOpportunity',
//                                               PO_Richiesta_fattibilit__c = childCase1.Id,
//                                               PO_Offerta_totale__c = Parentopp.id ,
//                                               PO_Collegamento__c = parentCase.id,
//                                               RecordTypeID = opprdId5,
//                                               PO_Totale_canoni__c = 100,
//                                               PO_Summary__c = true,
//                                               PO_Totale_contributi_attivazione__c = 200,
//                                               PO_Contributo_attivazione_collegamento__c = 300,
//                                               PO_Totale_costi_aggiuntivi__c = 500,
//                                               PO_Canone_manutenzione_collegamento__c = 600,
//                                               PO_Corrispettivo_IRU__c = 600,
//                                               PO_Canone_collegamento__c = 600,
//                                               PO_Canone_annuo_1anno__c = 100,
//                                               PO_Canone_annuo_2anni__c = 100,
//                                               PO_Canone_annuo_3anni__c = 100,
//                                               PO_Contributo_attivazione_1anno__c = 200,
//                                               PO_Contributo_attivazione_2anni__c = 200,
//                                               PO_Contributo_attivazione_3anni__c = 200,
//                                               PO_Costi_Aggiuntivi_Anno1__c = 300,
//                                               PO_Costi_Aggiuntivi_Anno2__c = 300,
//                                               PO_Costi_Aggiuntivi_Anno3__c = 300,
//                                               PO_Canone_annuo_AltriAnni__c = 400,
//                                               PO_Contributo_attivazione_altri_anni__c = 500,
//                                               PO_Costi_Aggiuntivi_Altri_Anni__c = 600,
//                                               PO_CostiAggiuntiviCollegamento__c = 700,
//                                               PO_Valore_medio_annuo_altre_coppie__c = 800,
//                                               PO_Valore_medio_annuo_totale__c = 800,
//                                               PO_Valore_totale_prima_coppia_fino_2030__c = 800,
//                                               StageName = 'Offerta presentata',
//                                               CloseDate = System.today());
//         insert ChildOpp;
//         oppList.add(ChildOpp);
//         Map<id,Boolean> mapCase = new map<id,Boolean>();
//         mapcase.put(childOpp.id,False);
//         Test.startTest();
//         //PO_CaseUtilityHandler.CaseFattDopFL(mapcase);
//         PO_CaseUtilityHandler.CalculateOpp(oppList);
//         Test.stopTest();
//     }

//       static testMethod void CalculateOppMethod1()
//     {

//         OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
//         tibco.OF_Tibco_ID__c='00558000001f743AAA';
//         tibco.name='Tibco UserID';
//         insert tibco;

        
//         OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
//         abilitaTrig.name='Status';
//         abilitaTrig.OF_Enable_Trigger__c=true;
//         insert abilitaTrig;        


//         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
//         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
//         Id rtId = CaseRecordTypeInfo.get('PO_Registrazione').getRecordTypeId();
//         Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
//         Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId(); 
//         Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
//         Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
//         Id rtId5 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
//         Id rtId6 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
//         Schema.DescribeSObjectResult oppSchema = Schema.SObjectType.Opportunity; 
//         Map<String,Schema.RecordTypeInfo> OpptyRecordTypeInfo = oppSchema.getRecordTypeInfosByName();
//         Id opprdId = OpptyRecordTypeInfo.get('PO Oppty collegamenti').getRecordTypeId();
//         Id opprdId1 = OpptyRecordTypeInfo.get('PO Oppty IRU').getRecordTypeId();
//         Id opprdId2 = OpptyRecordTypeInfo.get('PO Oppty Evento Temporaneo').getRecordTypeId();
//         Id opprdId3 = OpptyRecordTypeInfo.get('PO Oppty Fiber Lease').getRecordTypeId();
//         Id opprdId4 = OpptyRecordTypeInfo.get('PO Oppty Misto Lease-Link per FW').getRecordTypeId();
//         Id opprdId5 = OpptyRecordTypeInfo.get('PO Oppty Fiber Link').getRecordTypeId();
//              Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
//         insert AcntRec;
//         Account AcntRec1 = new Account(name = 'Acc1', Type = 'Customer', Industry = 'Automotive');
//         insert AcntRec1;
        
//         Product2 prod = new Product2(Name = 'Laptop X200',Family = 'Hardware');
//         insert prod;
        
//         Id pricebookId = Test.getStandardPricebookId();
//         PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
//                                                           Product2Id = prod.Id,
//                                                           UnitPrice = 10000,
//                                                           IsActive = true);
//         insert standardPrice;
        
//         Pricebook2 customPB = new Pricebook2(Name= 'P2P BaseAcc', isActive=true);
//         insert customPB;
//         PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id,
//                                                         UnitPrice = 12000, IsActive = true);
//         insert customPrice;
        
//         Case parentCase = new Case(PO_Offerta__c = 'P2P Base',
//                                   PO_Tipo_percorso__c = 'Singola Via',
//                                   PO_Costo_lavori_civili__c = 100,
//                                   RecordTypeId = rtId,
//                                   PO_Costo_lavori_ottici__c = 100,
//                                   PO_Incluso_nell_offerta__c= true,
//                                   Status ='Bozza', 
//                                   Priority = 'Medium',
//                                   Origin = 'Email'); 
//         insert parentCase;
        
//         List<case> caseList = new List<case>();
//          List<case> parentList= new List<case>();
//         Case childCase1 = new Case(ParentId = parentCase.Id,
//                                   PO_Richiesta_a_fattibilit__c = parentCase.Id,
//                                   PO_Offerta__c = 'P2P Base',
//                                   RecordTypeId = rtId,
//                                   PO_Tipo_percorso__c = 'Singola Via',
//                                   PO_Costo_lavori_civili__c = 100,
//                                   PO_Costo_lavori_ottici__c = 100,
//                                   PO_Incluso_nell_offerta__c= true,
//                                   Status ='Bozza', 
//                                   Priority = 'Medium',
//                                   Origin = 'Email'); 
//         insert childCase1;        
//         caseList.add(childCase1);
        
//         Case childCase2 = new Case(ParentId = parentCase.Id,
//                                   PO_Richiesta_a_fattibilit__c = parentCase.Id,
//                                   PO_Offerta__c = 'P2P Base',
//                                   PO_Tipo_percorso__c = 'Singola Via',
//                                   RecordTypeId = rtId,
//                                   PO_Costo_lavori_civili__c = 100,
//                                   PO_Costo_lavori_ottici__c = 100,
//                                   PO_Incluso_nell_offerta__c= true,
//                                   Status ='Nuovo',
//                                   Priority = 'Medium',
//                                   Origin = 'Email'); 
//         insert childCase2;
//         caseList.add(childCase2);
//         //parentCase.PO_Case_Collegamento__c=childcase1.id;
//       // update parentCase;
//       // parentList.add(parentCase);
//         Opportunity Parentopp = new Opportunity(Name = 'TestOpportunity',
//                                                 AccountId = AcntRec.Id,
//                                                 PO_Richiesta_fattibilit__c=parentCase.Id,
//                                                 PO_Collegamento__c = parentCase.Id,
//                                                 Pricebook2id= customPB.Id, 
//                                                 RecordTypeID = opprdId1,
//                                                 PO_Totale_canoni__c = 0,
//                                                 PO_Totale_contributi_attivazione__c = 100.00,
//                                                 PO_Totale_costi_aggiuntivi__c = 100.00,
//                                                 StageName = 'Prospecting',
//                                                 closeDate = Date.newInstance(2017,10,10));
//         insert Parentopp;
//         //Opportunity OppRecA = new Opportunity(AccountId = AcntRec.Id,PO_Collegamento__c =parentCase.ID, name='Opp',Pricebook2id= customPB.Id, stageName='Open', closeDate=Date.newInstance(2008,10,10));
//         //insert OppRecA;
//         List<Opportunity> oppList = New List<Opportunity>();
//         Opportunity ChildOpp = new Opportunity(Name = 'Unit TestOpportunity',
//                                               PO_Richiesta_fattibilit__c = childCase1.Id,
//                                               PO_Offerta_totale__c = Parentopp.id ,
//                                               PO_Collegamento__c = parentCase.id,
//                                               RecordTypeID = opprdId1,
//                                               PO_Totale_canoni__c = 100,
//                                               PO_Summary__c = true,
//                                               PO_Totale_contributi_attivazione__c = 200,
//                                               PO_Contributo_attivazione_collegamento__c = 300,
//                                               PO_Totale_costi_aggiuntivi__c = 500,
//                                               PO_Canone_manutenzione_collegamento__c = 600,
//                                               PO_Corrispettivo_IRU__c = 600,
//                                               PO_Canone_collegamento__c = 600,
//                                               PO_Canone_annuo_1anno__c = 100,
//                                               PO_Canone_annuo_2anni__c = 100,
//                                               PO_Canone_annuo_3anni__c = 100,
//                                               PO_Contributo_attivazione_1anno__c = 200,
//                                               PO_Contributo_attivazione_2anni__c = 200,
//                                               PO_Contributo_attivazione_3anni__c = 200,
//                                               PO_Costi_Aggiuntivi_Anno1__c = 300,
//                                               PO_Costi_Aggiuntivi_Anno2__c = 300,
//                                               PO_Costi_Aggiuntivi_Anno3__c = 300,
//                                               PO_Canone_annuo_AltriAnni__c = 400,
//                                               PO_Contributo_attivazione_altri_anni__c = 500,
//                                               PO_Costi_Aggiuntivi_Altri_Anni__c = 600,
//                                               PO_CostiAggiuntiviCollegamento__c = 700,
//                                               PO_Valore_medio_annuo_altre_coppie__c = 800,
//                                               PO_Valore_medio_annuo_totale__c = 800,
//                                               PO_Valore_totale_prima_coppia_fino_2030__c = 800,
//                                               StageName = 'Offerta presentata',
//                                               CloseDate = System.today());
//         insert ChildOpp;
//         oppList.add(ChildOpp);
//         Map<id,Boolean> mapCase = new map<id,Boolean>();
//         mapcase.put(childOpp.id,False);
//         Test.startTest();
//       // PO_CaseUtilityHandler.CaseFattDopFL(mapcase);
//         PO_CaseUtilityHandler.CalculateOpp(oppList);
//         PO_CaseUtilityHandler.OffertaCreata(caseList);
//         PO_CaseUtilityHandler.CaseFattDropFL(mapcase);
//         Test.stopTest();
//     }

    
    
//     static testMethod void ParamFattibilitaMethod1()
//     {
//         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
//         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
//         Id rtId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
//         Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        
//         Map<id,case> csMap = new Map<id,case>();        
//         case parentCase1 = new case();
//         parentCase1.recordtypeId = rtId;
//         parentCase1.PO_Offerta__c = 'IRU';
//         parentCase1.PO_Tipo_percorso__c = 'Singola Via';
//         parentCase1.PO_Costo_lavori_civili__c = 100;
//         parentCase1.PO_Costo_lavori_ottici__c = 100;
//         parentCase1.PO_BB_1_via_interessato__c  = 500;
//         parentCase1.PO_Posa_1_via_nuovo_Drop__c = 1000;
//         parentCase1.PO_BB_2_via_interessato__c = 400;
//         parentCase1.PO_Posa_2_via_nuovo_Drop__c = 400;
//         insert parentCase1;
        
//         case parentCase2 = new case();
//         parentCase2.recordtypeId = rtId1;
//         parentCase2.PO_Tipo_percorso__c = 'Singola Via';
//         insert parentCase2;
        
//         Parametri_Fattibilita__c ParamFat = new Parametri_Fattibilita__c();
//         ParamFat.Name = 'Default';
//         ParamFat.Fascia1__c = 2;
//         ParamFat.Fascia2__c = 0;
//         ParamFat.Fascia3__c = 0;
//         ParamFat.Fascia4__c = 0;
//         ParamFat.Fascia5__c = 0;
//         insert ParamFat;
        
//         Test.startTest();
//         //Case cs = [select OwnerId from Case where Id =: parentCase.Id];
//         Case ParentCs1 = [Select ID,RecordTypeId,PO_Lunghezza_m__c,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratte_complessiva__c from Case where Id =:parentCase1.Id ];
//         csMap.put(parentCase1.Id,ParentCs1);
        
//         Case ParentCs2 = [Select ID,RecordTypeId,PO_Lunghezza_m__c,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratte_complessiva__c from Case where Id =:parentCase2.Id ];
//         csMap.put(ParentCase2.Id,ParentCs2);
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
        
//         ParamFat.Fascia1__c = 1;
//         ParamFat.Fascia2__c = 2;
//         update ParamFat;
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
        
//         ParamFat.Fascia2__c = 1;
//         ParamFat.Fascia3__c = 2;
//         update ParamFat;
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
        
//         ParamFat.Fascia3__c = 1;
//         ParamFat.Fascia4__c = 2;
//         update ParamFat;
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
        
//         ParamFat.Fascia4__c = 1;
//         ParamFat.Fascia5__c = 2;
//         update ParamFat;
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
//         Test.stopTest();
//     }
//   // no need this code, covered ParamFattibilita Method by test method ParamFattibilitaMethod1 
//   /* static testMethod void ParamFattibilitaMethod2()
//     {
//         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
//         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
//         Id rtId = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
       
//         Map<id,case> csMap = new Map<id,case>();
        
//         Parametri_Fattibilita__c ParamFat = new Parametri_Fattibilita__c();
//         ParamFat.Name = 'Default';
//         ParamFat.Fascia1__c = 2; 
//         ParamFat.Fascia2__c = 2;
//         ParamFat.Fascia3__c = 0;
//         ParamFat.Fascia4__c = 0;
//         ParamFat.Fascia5__c = 0;
//         insert ParamFat;
        
//         case parentCase = new case();
//         parentCase.recordtypeid = rtId;
//         parentCase.PO_Offerta__c = 'IRU';
//         parentCase.PO_Tipo_percorso__c = 'Singola Via';
//         parentCase.PO_Costo_lavori_civili__c = 100;
//         parentCase.PO_Costo_lavori_ottici__c = 100;
//         parentCase.PO_BB_1_via_interessato__c  = 600;
//         parentCase.PO_Posa_1_via_nuovo_Drop__c = 700;
//         parentCase.PO_BB_2_via_interessato__c = 1;
//         parentCase.PO_Posa_2_via_nuovo_Drop__c = 2;
//         insert parentCase;
//         Case cs = [select OwnerId from Case where Id =: parentCase.Id];
//         Case ParentCase1=[Select ID,RecordTypeId,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_m__c,PO_Lunghezza_tratte_complessiva__c from Case where Id =:parentCase.Id ];
//         System.debug('parentCase'+ParamFat.Fascia1__c);
//         System.debug('parentCase'+ParentCase1.PO_Lunghezza_tratte_complessiva__c);
        
//         csMap.put(ParentCase1.Id,ParentCase1);
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
//     }
    
//     static testMethod void ParamFattibilitaMethod3()
//     {
//         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
//         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
//         Id rtId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        
        
//         Map<id,case> csMap = new Map<id,case>();
        
//         Parametri_Fattibilita__c ParamFat = new Parametri_Fattibilita__c();
//         ParamFat.Name = 'Default';
//         ParamFat.Fascia1__c = 1; 
//         ParamFat.Fascia2__c = 2;
//         ParamFat.Fascia3__c = 3;
//         ParamFat.Fascia4__c = 4;
//         ParamFat.Fascia5__c = 5;
//         insert ParamFat;
        
//         case parentCase = new case();
//         parentCase.recordtypeid = rtId;
//         parentCase.PO_Offerta__c = 'IRU';
//         parentCase.PO_Tipo_percorso__c = 'Singola Via';
//         parentCase.PO_Costo_lavori_civili__c = 100;
//         parentCase.PO_Costo_lavori_ottici__c = 100;
//         parentCase.PO_BB_1_via_interessato__c  = 100;
//         parentCase.PO_Posa_1_via_nuovo_Drop__c = 100;
//         parentCase.PO_BB_2_via_interessato__c = 300;
//         parentCase.PO_Posa_2_via_nuovo_Drop__c = 300;
//         insert parentCase;
//         Case cs = [select OwnerId from Case where Id =: parentCase.Id];
//         Case ParentCase1=[Select ID,RecordTypeId,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratte_complessiva__c from Case where Id =:parentCase.Id ];
//         System.debug('parentCase'+ParamFat.Fascia1__c);
//         System.debug('parentCase'+ParentCase1.PO_Lunghezza_tratte_complessiva__c);
        
//         csMap.put(ParentCase1.Id,ParentCase1);
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
//     }
    
//   /* static testMethod void ParamFattibilitaMethod4()
//     {
//         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
//         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
//         Id rtId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        
        
//         Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
//         User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
//                                  EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
//                                  LocaleSidKey='en_US', ProfileId = prfl.Id, 
//                                  TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
//         insert thisUser ;
        
        
//         Map<id,case> csMap = new Map<id,case>();
        
//         Parametri_Fattibilita__c ParamFat = new Parametri_Fattibilita__c();
//         ParamFat.Name = 'Default';
//         ParamFat.Fascia1__c = 1; 
//         ParamFat.Fascia2__c = 2;
//         ParamFat.Fascia3__c = 3;
//         ParamFat.Fascia4__c = 4;
//         ParamFat.Fascia5__c = 5;
//         insert ParamFat;
        
//         case parentCase = new case();
//         parentCase.recordtypeid = rtId;
//         parentCase.PO_Offerta__c = 'IRU';
//         parentCase.PO_Tipo_percorso__c = 'Singola Via';
//         parentCase.PO_Costo_lavori_civili__c = 100;
//         parentCase.PO_Costo_lavori_ottici__c = 100;
//         parentCase.PO_BB_1_via_interessato__c  = 1000;
//         parentCase.PO_Posa_1_via_nuovo_Drop__c = 1000;
//         parentCase.PO_BB_2_via_interessato__c = 600;
//         parentCase.PO_Posa_2_via_nuovo_Drop__c = 700;
//         insert parentCase;
        
//         Case cs = [select OwnerId from Case where Id =: parentCase.Id];
        
//         Case ParentCase1=[Select ID,RecordTypeId,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratte_complessiva__c from Case where Id =:parentCase.Id ];
//         System.debug('parentCase'+ParamFat.Fascia1__c);
//         System.debug('parentCase'+ParentCase1.PO_Lunghezza_tratte_complessiva__c);
        
//         csMap.put(ParentCase1.Id,ParentCase1);
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
//     }
    
//     static testMethod void ParamFattibilitaMethod5()
//     {
//         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
//         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
//         Id rtId = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        
//         Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
//         User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
//                                  EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
//                                  LocaleSidKey='en_US', ProfileId = prfl.Id, 
//                                  TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
//         insert thisUser ;
        
        
//         Map<id,case> csMap = new Map<id,case>();
        
//         Parametri_Fattibilita__c ParamFat = new Parametri_Fattibilita__c();
//         ParamFat.Name = 'Default';
//         ParamFat.Fascia1__c = 1; 
//         ParamFat.Fascia2__c = 2;
//         ParamFat.Fascia3__c = 3;
//         ParamFat.Fascia4__c = 4;
//         ParamFat.Fascia5__c = 5;
//         insert ParamFat;
        
//         case parentCase = new case();
//         parentCase.recordtypeId = rtId;
//         parentCase.PO_Offerta__c = 'IRU';
//         parentCase.PO_Tipo_percorso__c = 'Singola Via';
//         parentCase.PO_Costo_lavori_civili__c = 100;
//         parentCase.PO_Costo_lavori_ottici__c = 100;
//         parentCase.PO_BB_1_via_interessato__c  = 1000;
//         parentCase.PO_Posa_1_via_nuovo_Drop__c = 2000;
//         parentCase.PO_BB_2_via_interessato__c = 1000;
//         parentCase.PO_Posa_2_via_nuovo_Drop__c = 300;
//         insert parentCase;
        
//         Case cs = [select OwnerId from Case where Id =: parentCase.Id];
        
//         Case ParentCase1=[Select ID,RecordTypeId,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratte_complessiva__c from Case where Id =:parentCase.Id ];
//         System.debug('parentCase'+ParamFat.Fascia1__c);
//         System.debug('parentCase'+ParentCase1.PO_Lunghezza_tratte_complessiva__c);
        
//         csMap.put(ParentCase1.Id,ParentCase1);
//         PO_CaseUtilityHandler.ParamFattibilita(csMap);
//     }*/
//     // metodo fake da eliminare asap
// 	public static testMethod void CodeCoverage(){
//     	test.starttest();
// 		PO_CaseUtilityHandler.CodeCoverage(2);
// 		test.stoptest();
//     }    
}
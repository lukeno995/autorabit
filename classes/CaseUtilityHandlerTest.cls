@isTest
public class CaseUtilityHandlerTest
{
    static testMethod void CalculateOppTestMethod()
    {  
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
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
        
        Case parentCase = new Case(PO_Offerta__c = 'P2P Base',
                                   PO_Tipo_percorso__c = 'Singola Via',
                                   RecordTypeId = rtId2,
                                   PO_Costo_lavori_civili__c = 100,
                                   PO_Costo_lavori_ottici__c = 100,
                                   PO_Incluso_nell_offerta__c= true,
                                   PO_Posa_1_nuovo_Drop__c=100,
                                  
                                   PO_BB_1_interessato__c = 2,
                                   PO_BB_2_interessato__c =2,
                                   Status ='Nuovo', 
                                   Priority = 'Medium',
                                   Origin = 'Email'); 
        insert parentCase;
        
        List<case> caseList = new List<case>();
        Case childCase1 = new Case(ParentId = parentCase.Id,
                                   PO_Richiesta_a_fattibilit__c = parentCase.Id,
                                   RecordTypeId = rtId2,
                                   PO_Offerta__c = 'P2P Base',
                                   PO_Tipo_percorso__c = 'Singola Via',
                                   PO_BB_1_interessato__c = 2,
                                   PO_BB_2_interessato__c =2,
                                   PO_Costo_lavori_civili__c = 100,
                                   PO_Costo_lavori_ottici__c = 100,
                                   PO_Incluso_nell_offerta__c= true,
                                   PO_Posa_1_nuovo_Drop__c=100,
                                   Status ='Nuovo', 
                                   Priority = 'Medium',
                                   Origin = 'Email'); 
        insert childCase1;        
        caseList.add(childCase1);
        
        Case childCase2 = new Case(ParentId = parentCase.Id,
                                   PO_Richiesta_a_fattibilit__c = parentCase.Id,
                                   PO_Offerta__c = 'P2P Base',
                                   RecordTypeId = rtId2,
                                   PO_Tipo_percorso__c = 'Singola Via',
                                   PO_Costo_lavori_civili__c = 100,
                                   PO_Costo_lavori_ottici__c = 100,
                                   PO_BB_1_interessato__c = 2,
                                   PO_BB_2_interessato__c =2,
                                   PO_Posa_1_nuovo_Drop__c=100,
                                   PO_Incluso_nell_offerta__c= false,
                                   Status ='Nuovo',
                                   Priority = 'Medium',
                                   Origin = 'Email'); 
        insert childCase2;
        caseList.add(childCase2);
        
        Opportunity Parentopp = new Opportunity(Name = 'TestOpportunity',
                                                PO_Richiesta_fattibilit__c = parentCase.Id,
                                                PO_Totale_canoni__c = 100.00,
                                                PO_Collegamento__c=parentCase.Id,
                                                PO_Totale_contributi_attivazione__c = 100.00,
                                                PO_Totale_costi_aggiuntivi__c = 100.00,
                                                StageName = 'Offerta presentata',
                                                closeDate = Date.newInstance(2009,10,10));
        insert Parentopp;
        
        Opportunity ChildOpp = new Opportunity(Name = 'IUnit TestOpportunity',
                                               PO_Richiesta_fattibilit__c = childCase1.Id,
                                               PO_Offerta_totale__c = Parentopp.Id ,
                                               PO_Collegamento__c = parentCase.id,
                                               PO_Totale_canoni__c = 100,
                                               PO_Summary__c = true,
                                               PO_Totale_contributi_attivazione__c = 200,
                                               PO_Contributo_attivazione_collegamento__c = 300,
                                               // PO_Costi_aggiuntivi_collegamento__c = 400,
                                               PO_Totale_costi_aggiuntivi__c = 500,
                                               PO_Canone_collegamento__c = 600,
                                               StageName = 'Offerta presentata',
                                               CloseDate = System.today());
        insert ChildOpp;
        Opportunity ChildOpp2 = new Opportunity(Name = 'Unit Testopportunity',
                                                PO_Richiesta_fattibilit__c = childCase1.Id,
                                                PO_Offerta_totale__c = Parentopp.Id ,
                                                PO_Collegamento__c = childCase2.id,
                                                PO_Totale_canoni__c = 100,
                                                PO_Summary__c = true,
                                                PO_Totale_contributi_attivazione__c = 200,
                                                PO_Contributo_attivazione_collegamento__c = 300,
                                                // PO_Costi_aggiuntivi_collegamento__c = 400,
                                                PO_Totale_costi_aggiuntivi__c = 500,
                                                PO_Canone_collegamento__c = 600,
                                                StageName = 'Offerta presentata',
                                                CloseDate = System.today());
        insert ChildOpp2;
        
        Test.startTest();
        CaseUtilityHandler.CalculateOpp(caseList);
        Test.stopTest();
    }
}
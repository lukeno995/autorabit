@isTest
public class PO_UpdateAccordoOperativo_Test {
    @isTest (seeAllData = true)
    public static void testmethod1(){
        Account acc = new Account(Name = 'Test');
        insert acc;
		Order ordine = new Order(AccountId = acc.Id, EffectiveDate = System.today(), Status = 'Aperto');
		insert ordine;
        
        Map<String, Id> RecordTypeNameId = new Map<String,Id>();
        for(RecordType rt : [SELECT Id, DeveloperName FROM recordType]) RecordTypeNameId.put(rt.DeveloperName, rt.Id);
        Contact contactTest = new Contact(LastName = 'Test');
        insert contactTest;
        Case richiesta = new Case (RecordTypeId = RecordTypeNameId.get('PO_Richiesta_a_servizio_a_fattibilit'), 
                               Contact = contactTest, 
                               PO_Offerta__c = 'BTS', 
                               Status = 'In Lavorazione', 
                               Origin = 'Web',
                               Priority = 'Medium',
                               PO_Backhauling__c = true,
                               Subject = 'TestSetUpRichiesta');  
        insert richiesta;
        Case cOrdine = new Case(RecordTypeId = RecordTypeNameId.get('PO_Ordine_BTS'),
                                Contact = contactTest, 
                                PO_Offerta__c = 'BTS', 
                                Status = 'In Lavorazione', 
                                Origin = 'Web',
                                Priority = 'Medium',
                                PO_Backhauling__c = true,
                                Subject = 'TestSetUpOrdine',
                                OF_Order__c = ordine.Id,
                                PO_Richiesta_a_fattibilit_ordine__c = richiesta.Id);
		insert cOrdine;
		/*Case collegamento= new Case();
        insert collegamento;*/
		cOrdine.Accordo_Operativo__c = '123';
		update cOrdine;
		
    }
}
@isTest
public class Numerofiledupdate_Test{
    public static testmethod void NumerofiledupdateMethod(){
    
        account acc = new account();
        acc.name = 'test';        
        insert acc;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
       // parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.PO_Nome_Progetto__c='test';
        insert parentCase;
        
        case ChildCase = new Case();
        
        
        ChildCase.ParentId = parentCase.id;
        ChildCase.accountId = acc.Id;
        ChildCase.PO_Offerta__c = 'Fiber Link';
        ChildCase.PO_Richiesta_a_fattibilit__c = parentCase.id;
        ChildCase.PO_Area_Geografica__c = 'Nord Est';
        ChildCase.PO_Prime_Contractor__c = 'test';
        ChildCase.PO_Numero_fibre_richieste__c = 'test';
        ChildCase.PO_Tipo_percorso__c = 'Singola Via';
        ChildCase.PO_Numero_fibre_richieste__c = 'test';
        ChildCase.PO_Siti_da_collegare__c = 'test';
        ChildCase.PO_Nome_sito__c = 'test';
        ChildCase.PO_Note_collegamento__c = 'test';
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.PO_Richiesta_fattibilit__c = parentCase.Id;
        opportunity.PO_Collegamento__c = ChildCase.id;
        opportunity.PO_Totale_canoni__c = 100.00;
        opportunity.PO_Summary__c = true;
        opportunity.StageName = 'Offerta presentata';
        opportunity.CloseDate = System.today();
        opportunity.PO_Sconto_canone__c = 10;
        opportunity.PO_Sconto_costi_aggiuntivi__c = 10;
        opportunity.PO_Numero_Anni__c = 123;
        insert opportunity;
        
    }
}
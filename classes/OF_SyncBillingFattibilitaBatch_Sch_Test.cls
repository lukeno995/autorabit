@isTest
public class OF_SyncBillingFattibilitaBatch_Sch_Test {

    @testSetup
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        Insert new Verticali__c(RecordTypesAssets__c ='\'PO_Asset_Backhauling_Collegamento\',\'PO_Asset_BTS_Collegamento\',\'P2P\',\'PO_Asset_DarkFiber_Collegamento\',\'Fiber_Link\',\'PO_Asset_P2P_Attiva_Collegamento\',\'OF_GPONPassiva\',\'OF_OpenStream\'', createNotifyBatchLimit__c = 10000, callWsBillingBatchSize__c = 4,RecorTypesList__c = '\'OF_ServiziAggiuntivi\',\'OF_CPE\',\'OF_VLAN\',\'OF_Standard\',\'PO_Portalino\'');
    }
    
    public static testmethod void SchedulableMethod(){
        Test.startTest();
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'Test';
        acc.AccountNumber = '123';
        acc.VATNumber__c = 'Test';
        acc.TaxationCode__c = 123;
        acc.Status__c = 'Bozza';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Codice_Operatore__c= 'Te';
        acc.StartDate__c = system.today();
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset ass= new Asset();
        ass.Name = 'Test';
        ass.accountId = acc.id;
        ass.OF_Contract__c = contratto.id;
        insert ass;
        
        string assetId=ass.Id;
        
        Datetime dt = Datetime.now().addMinutes(1);
        String CRON_EXP = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
        OF_SyncBillingFattibilitaBatch_Sched sbatch = new OF_SyncBillingFattibilitaBatch_Sched(new list<string> {assetId});
        sbatch.execute(null);   
        Test.stopTest();
    }  
}
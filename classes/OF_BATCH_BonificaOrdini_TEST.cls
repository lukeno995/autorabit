@isTest
private class OF_BATCH_BonificaOrdini_TEST {

    static testMethod void test1() {
        Account a = new Account();
        a.name='1234';
        a.type='Temp';
        insert a;
        
        Account a1 = new Account();
        a1.name='1234';
        a1.type='OLO';
        insert a1;
        
        Contract c = new Contract();
        c.accountId=a.id;
        insert c;
        
        Order o = new Order();
        o.name='1234';
        o.accountId=a.Id;
        o.OF_AccountTemporaneo__c=a1.Id;
        o.OF_ContractTemporaneo__c=c.Id;
        o.status='Aperto';
        o.effectiveDate=Date.today();
        insert o;
        test.startTest();
        // This test runs a scheduled job at midnight Sept. 3rd. 2022
     	String CRON_EXP = '0 0 0 3 9 ? 2022';
       // Schedule the test job
       String jobId = System.schedule('BorrarAseguradosTest', CRON_EXP, new OF_BATCH_SCHEDULE_BonificaOrdini());
        
        test.stopTest();
    }
    static testMethod void test2() {
        Account a = new Account();
        a.name='1234';
        a.type='Temp';
        insert a;
        
        Account a1 = new Account();
        a1.name='1234';
        a1.type='OLO';
        insert a1;
        
        Contract c = new Contract();
        c.accountId=a1.id;
        insert c;
        
        Order o = new Order();
        o.name='1234';
        o.accountId=a.Id;
        o.OF_AccountTemporaneo__c=a1.Id;
        o.OF_ContractTemporaneo__c=c.Id;
        o.status='Aperto';
        o.effectiveDate=Date.today();
        insert o;
        test.startTest();
        // This test runs a scheduled job at midnight Sept. 3rd. 2022
     	String CRON_EXP = '0 0 0 3 9 ? 2022';
       // Schedule the test job
       String jobId = System.schedule('BorrarAseguradosTest', CRON_EXP, new OF_BATCH_SCHEDULE_BonificaOrdini());
        
        test.stopTest();
    }
}
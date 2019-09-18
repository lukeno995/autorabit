@isTest
public class OF_SyncBillingContractTrigger_Test {
    
    public static testMethod void testOne(){
        
         test.starttest();
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract con = new Contract();
         con.AccountId = acc.id;
         con.Status = 'Draft';
         insert con;
         con.Status = 'Attivo';
         update con; 
        
         test.stopTest();
    }
    
    public static testMethod void testTwo(){
        
         test.starttest();
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract con = new Contract();
         con.AccountId = acc.id;
         con.Status = 'Attivo';
         insert con;
         update con; 
        
         test.stopTest();
    }
    
    public static testMethod void testThree(){
        
         test.starttest();
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract con = new Contract();
         con.AccountId = acc.id;
         con.OF_BillingSyncronized__c = true;
         con.Status = 'Attivo';
         insert con;
         con.Status = 'Cessato';
         update con; 
        
         test.stopTest();
    }
    
    public static testMethod void testFour(){
        
         test.starttest();
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract con = new Contract();
         con.AccountId = acc.id;
         con.OF_BillingSyncronized__c = true;
         con.Status = 'Cessato';
         insert con;
         con.Status = 'Cessato';
         update con; 
        
         test.stopTest();
    }
    
    public static testMethod void testFive(){
        
         test.starttest();
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract con = new Contract();
         con.AccountId = acc.id;
         con.OF_BillingSyncronized__c = true;
         con.Status = 'Sospeso';
         insert con;
         con.Status = 'Attivo';
         update con; 
        
         test.stopTest();
    }


}
@isTest
public class OF_SyncBillingAccountTrigger_Test {

    public static testMethod void test1(){
    
    Test.StartTest();
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
    acc.Status__c = 'Attivo';
    update acc;
    Test.StopTest();
    
    }
    public static testMethod void test2(){
    
    Test.StartTest();
    String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
    Account acc = new Account();
    acc.Name = 'Test';
    acc.AccountNumber = '123';
    acc.VATNumber__c = 'Test';
    acc.TaxationCode__c = 123;
    acc.SyncBilling__c = False;
    acc.Status__c = 'Attivo';
    acc.RecordTYpeId = AccountRecordTypeId ;
    acc.EOF_Codice_Operatore__c= 'Te';
    acc.StartDate__c = system.today();
    insert acc;
    acc.Status__c = 'Bozza';
    update acc;
    Test.StopTest();
    
    }
}
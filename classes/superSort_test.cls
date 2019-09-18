@isTest
public class superSort_test {

    @isTest
    public static void test(){
        Test.startTest();
        
        superSort.sortList(new List<Account>{new Account(Name = 'a')}, 'Name',  'asc');
        superSort.sortList(new List<Account>{new Account(Name = 'a')}, 'Name',  'desc');        
        superSort.sortList( new List<EOF_EAI_Service_Log__c>{new EOF_EAI_Service_Log__c(Notify__c = 'a024E000000yURb')}, 'Notify__c',  'desc' );
        
        Test.stopTest();
    }
    
}
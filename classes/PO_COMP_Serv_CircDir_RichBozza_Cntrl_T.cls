@isTest
public class PO_COMP_Serv_CircDir_RichBozza_Cntrl_T {
    static testmethod void testMethod1(){
        
        
        EOF_EAI_Service_Log__c serv= new EOF_EAI_Service_Log__c();
        insert(serv);
        
        
        PO_COMP_Serv_CircDir_RichBozza_Cntrl theController= new PO_COMP_Serv_CircDir_RichBozza_Cntrl();
        theController.parentLogId=serv.id;
        theController.vediReqBozza();
        theController.pageDown();
        theController.pageUp();
        theController.setPagination(true);
        theController.preparePage();
    }
    @isTest
    public static  void testMethod2(){
        
        
        Account acc = PO_ServFatt_DataFactory.createAccount('Ambrogio','VF');

        
        Contact c = new Contact();
        c.AccountId = acc.Id;
        c.LastName='caramella';
        c.FirstName='andonio';
        insert c;
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Partner Community Super User'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            contactId = c.id
        );
        
        insert u;
        
        EOF_EAI_Service_Log__c serv= new EOF_EAI_Service_Log__c();
        insert(serv);
        
        List<EOF_EAI_Service_Log__c> listLog=new List<EOF_EAI_Service_Log__c>();
        
        Id rtId = [select id from RecordType where developerName= 'PO_Log_CircuitiDiretti_Request'].id;
        for(integer i=0; i<10; i++){
            EOF_EAI_Service_Log__c serv2= new EOF_EAI_Service_Log__c();
            serv2.RecordTypeId = rtId;
            serv2.EOF_Stato_Richiesta__c='Bozza';
            serv2.EOF_Codice_Operatore__c= 'VF';
            listLog.add(serv2);
        }
        insert listLog;
        
        system.runAs(u){
            PO_COMP_Serv_CircDir_RichBozza_Cntrl theController= new PO_COMP_Serv_CircDir_RichBozza_Cntrl();
            theController.parentLogId=serv.id;
            theController.vediReqBozza();
            theController.pageDown();
            theController.pageUp();
            theController.setPagination(true);
            theController.preparePage();
        }
    } 
}
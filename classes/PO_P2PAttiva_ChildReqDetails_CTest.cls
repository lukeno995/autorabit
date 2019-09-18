@isTest
public class PO_P2PAttiva_ChildReqDetails_CTest {
    @isTest
    public static void testMethod1(){
        EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
        log.Tipologia_Sede__c = 'Satellite';
        insert log;
        EOF_EAI_Service_Log__c log2 = new EOF_EAI_Service_Log__c();
        log2.EOF_SL_Riferimento__c = log.Id;
        log2.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF_SA_Vlan_ELine').getRecordTypeId();
        insert log2;
        PageReference pageRef = Page.PO_P2PAttiva_OverviewchildLogReq;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('childId', log.Id);
        pageRef.getParameters().put('tipoP2Patt','eLine');
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        Id p = [select id from profile where name='Partner Community User'].id;  
        Account acc = new Account();
        acc.name = 'Test';
        
        acc.EOF_Codice_Operatore__c='TST';
        acc.VATNumber__c='00246465465';
        acc.Status__c='Attivo';
        acc.StartDate__c=DateTime.newInstance(2019, 4, 3, 3, 1, 5);
        
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=acc.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;  
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        
        insert cnt;
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US',  profileid = p, country='United States',IsActive =true,
                             ContactId = cnt.Id,
                             timezonesidkey='America/Los_Angeles', username='standarduse4rtest@testorg.com');
        
        insert user;
        System.runAs(user) {
            PO_P2PAttiva_ChildReqDetails_Ctrl cntrl = new PO_P2PAttiva_ChildReqDetails_Ctrl();
            cntrl.detailparentlog();
            cntrl.DesospendiClg();
        }
    }
}
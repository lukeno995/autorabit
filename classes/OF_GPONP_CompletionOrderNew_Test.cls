@isTest
public class OF_GPONP_CompletionOrderNew_Test {
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    static testMethod void testMethod1(){
        Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());        	       
      	List<EOF_EAI_Service_Log__c> slist = new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c log1 = new EOF_EAI_Service_Log__c();
        log1.EOF_Tipo_Comunicazione_String__c = 'SF-OLO - CompletionOrder';
        
        EOF_EAI_Service_Log__c log2 = new EOF_EAI_Service_Log__c();
        log2.EOF_Tipo_Comunicazione_String__c = 'CPE';
        
        EOF_EAI_Service_Log__c log3 = new EOF_EAI_Service_Log__c();
        log3.EOF_Tipo_Comunicazione_String__c = 'SERVIZIO AGGIUNTIVO';
        	
        slist.add(log1);
        slist.add(log2);
        slist.add(log3);
        
        OF_GPONP_CompletionOrderNew.PortTypeEndpoint6 req = new OF_GPONP_CompletionOrderNew.PortTypeEndpoint6();
        req.CompletionOrder_GPONP(slist);
        	
        OF_GPONP_Res_Schema_CompletionOrderNew.Response_element res = new OF_GPONP_Res_Schema_CompletionOrderNew.Response_element();
        Test.stopTest();
    }
}
@isTest
public class OF_SA_WS_OLO_CompletionOrder_TEST {
    testMethod static void testOF_SA_WS_OLO_CompletionOrder(){
        
        TestDataFactory.CreateTestRecords(null, null, null);
        
        List<EOF_EAI_Service_Log__c> eofList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.EOF_Tipo_Comunicazione__c	= 'test';
        eof.EOF_Tipo_Comunicazione_String__C='SF-OLO - CompletionOrder';
        eof.EOF_DATA_ESPLETAMENTO_ORDINE__C	= system.today();
        //eof.EOF_Tipo_COmunicazione_String__c	= 'CPE';
        eofList.add(eof);
        EOF_EAI_Service_Log__c eof2 = new EOF_EAI_Service_Log__c();
        eof2.EOF_Tipo_Comunicazione__c	= 'test';
        eof2.EOF_Tipo_Comunicazione_String__C='SF-OLO - CompletionOrder';
        eof2.EOF_DATA_ESPLETAMENTO_ORDINE__C	= system.today();
        eof2.EOF_Tipo_COmunicazione_String__c	= 'CPE';
        eofList.add(eof2);
        EOF_EAI_Service_Log__c eof1 = new EOF_EAI_Service_Log__c();
        eof1.EOF_Tipo_Comunicazione__c	= 'test';
        eof1.EOF_Tipo_Comunicazione_String__C='SF-OLO - CompletionOrder';
        eof1.EOF_DATA_ESPLETAMENTO_ORDINE__C	= system.today();
        //eof1.EOF_Tipo_COmunicazione_String__c='CPE';
        eof1.EOF_Tipo_COmunicazione_String__c='SERVIZIO AGGIUNTIVO';
        eofList.add(eof1);
        insert eofList; 
        
        test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        OF_SA_WS_OLO_CompletionOrder.NotifyPortTypeEndpoint ofee = new OF_SA_WS_OLO_CompletionOrder.NotifyPortTypeEndpoint();
        
        ofee.NotifyCompletamentoOrdine(eofList);
        test.stopTest();
    }


}
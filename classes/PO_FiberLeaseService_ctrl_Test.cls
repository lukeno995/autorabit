@isTest
public class PO_FiberLeaseService_ctrl_Test {
	@testSetup
    public static void setupMethod(){
        Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }
        
        
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        Account acc = new Account();
        acc.Name = 'Tiscali';
        acc.EOF_Codice_Operatore__c = 'TIS';
        insert acc;
        
        OF_ElencoComuniItaliani__c comm = new OF_ElencoComuniItaliani__c();
        comm.OF_CodiceIstat__c = 'test';
        comm.OF_Comune__c = 'Torino';
        insert comm;
        
        
        EOF_EAI_Service_Log__c testParentLog = new EOF_EAI_Service_Log__c();        
        testParentLog.EOF_Codice_Ordine_OLO__c = 'test'; 
        testParentLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Request');
        
        insert testParentLog;               
        
        EOF_EAI_Service_Log__c testCollegamentoLog = new EOF_EAI_Service_Log__c();
        testCollegamentoLog.RecordTypeId = theRecordTypes.get('PO_Log_FiberLease_Collegamento'); 
        testCollegamentoLog.EOF_Codice_Ordine_OLO__c = 'test';
        testCollegamentoLog.EOF_SL_Riferimento__c = testParentLog.Id;
        insert testCollegamentoLog;        
        
        OF_CaseLogAttach__c clAtt = new OF_CaseLogAttach__c();
        clAtt.EAI_Service_Log__c = testCollegamentoLog.Id;
        insert clAtt;
        
        PageReference pageRef = Page.PO_FiberLeaseInsRich;
        pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));        
        pageRef.getParameters().put('childId', testCollegamentoLog.Id);  
        pageRef.getParameters().put('accountId', String.valueOf(acc.Id));           
        Test.setCurrentPage(pageRef);
    }
     
    @isTest
    public static void doInitInsRich_Test(){ 
             
        Account acc = [SELECT Id, Name, EOF_Codice_Operatore__c FROM Account LIMIT 1];
                                           
        
        PageReference pageRef = Page.PO_FiberLeaseInsRich; 
        pageRef.getParameters().put('accountId', String.valueOf(acc.Id));           
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        PO_FiberLeaseService_ctrl controller = new PO_FiberLeaseService_ctrl();
        controller.doInitInsRich();
        controller.uploadCSV();
        Test.stopTest();
    }
    
    @isTest
    public static void childCase_Test(){
        Account acc = [SELECT Id, Name, EOF_Codice_Operatore__c FROM Account LIMIT 1];
                                           
        
        PageReference pageRef = Page.PO_FiberLeaseInsRich; 
        pageRef.getParameters().put('accountId', String.valueOf(acc.Id));           
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        PO_FiberLeaseService_ctrl controller = new PO_FiberLeaseService_ctrl();
        controller.doInitInsRich();
        controller.annullaInsRich();
        controller.childCase();
        Test.stopTest();
    }
    
    @isTest
    public static void doInitInsColl_Test(){
        Map<String,String> theRecordTypes = new Map<String,String>();
        for(RecordType rt : [select id, developername from recordtype])
        {
            theRecordTypes.put(rt.developername, rt.id);
        }
        
        OF_ElencoComuniItaliani__c comm = [SELECT Id,OF_Regione__c,OF_Comune__c 
                                            FROM OF_ElencoComuniItaliani__c WHERE OF_Comune__c = 'Torino'];
        
        EOF_EAI_Service_Log__c testParentLog = [SELECT Id, EOF_Codice_Operatore__c, PO_Nome_Progetto__c 
                                            	FROM EOF_EAI_Service_Log__c WHERE RecordTypeId = :theRecordTypes.get('PO_Log_FiberLease_Request') LIMIT 1];
        
        
        
        EOF_EAI_Service_Log__c testCollegamentoLog = [SELECT Id, EOF_Codice_Operatore__c, PO_Nome_Progetto__c 
                                            	FROM EOF_EAI_Service_Log__c WHERE RecordTypeId = :theRecordTypes.get('PO_Log_FiberLease_Collegamento') LIMIT 1];
        
        
        
        Test.startTest();
        PageReference pageRef = Page.PO_FiberLeaseInsRich;
        pageRef.getParameters().put('parentId', String.valueOf(testParentLog.Id));
        Test.setCurrentPage(pageRef);
        
        PO_FiberLeaseService_ctrl controller = new PO_FiberLeaseService_ctrl();
        controller.doInitInsColl();
        controller.fileName = 'Test.txt';
        controller.fileBody = Blob.valueOf('File di test');
        controller.selectedIdComune = comm.Id;
        controller.selectedIdComune1 = comm.Id;
        controller.upload();
        controller.SaveParentChildCaseInfo();
        
        PageReference pageRef1 = Page.PO_FiberLeaseInsRich;
        pageRef1.getParameters().put('parentId', String.valueOf(testParentLog.Id));
        pageRef1.getParameters().put('childId', testCollegamentoLog.Id);
        Test.setCurrentPage(pageRef1);
        
        PO_FiberLeaseService_ctrl controller1 = new PO_FiberLeaseService_ctrl();
        controller1.doInitInsColl();
        controller1.annullaInsColl();
        Test.stopTest();
    }
    
    
}
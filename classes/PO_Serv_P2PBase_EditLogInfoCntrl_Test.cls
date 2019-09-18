@isTest
private class PO_Serv_P2PBase_EditLogInfoCntrl_Test {
     static testMethod void testMethod1() 
    {
        Test.startTest(); 
        OF_ElencoComuniItaliani__c  comune = new OF_ElencoComuniItaliani__c (OF_Comune__c = 'Test', OF_Regione__c = 'Lombardia', OF_CodiceIstat__c = 'ISTAT-000000');
        insert comune;
        EOF_EAI_Service_Log__c theParentLog = new EOF_EAI_Service_Log__c(OF_Id_Comune__c = comune.Id , PO_Log_IdComune2__c = comune.Id);
        insert theParentLog;
        
        PageReference pageRef = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef.getParameters().put('parentId', theParentLog.Id); 
        pageRef.getParameters().put('cLogId', theParentLog.Id);         
        Test.setCurrentPage(pageRef);
        
        PO_Serv_P2PBase_EditLogInfoCntrl theController = new PO_Serv_P2PBase_EditLogInfoCntrl();
        theController.recordOfferta='';
        theController.searchTerm='';
        theController.searchTerm1='';
        theController.searchTerm2='';
        theController.OF_ElencoComuniItalianiobj=new OF_ElencoComuniItaliani__c();
        theController.OF_ElencoComuniItalianiobj1=new OF_ElencoComuniItaliani__c();
        theController.OF_ElencoComuniItalianiobj2=new OF_ElencoComuniItaliani__c();
        theController.selectedIdComune2='';
        theController.vLanNoMax=false;
        theController.profiloName='';
        theController.attlst=new list<attachment>();
		theController.newAtt= new list<attachment>();
		theController.attxlxs= new list<attachment>(); 
        theController.parentCase=new case();
        theController.parentCaseObj=new case();
        theController.optScelta='';
        theController.NomeProgetto='';
        theController.urlPage='';
        theController.childLogToInsert= new list<EOF_EAI_Service_Log__c>();
        theController.insertChildLog();
        theController.SaveParentChildLogInfo();
        theController.Annulla();        
        theController.upload(); 
        //FD
        theController.idVLAN = 'Test';
        theController.verifyProfilo = 'Test';
        theController.viewError = false;
        theController.viewProfilo = false;
        theController.profiloCommerciale = 'Test';
        //theController.runSearchProfilo();
        //theController.getProfiloVLAN();
        PO_Serv_P2PBase_EditLogInfoCntrl.searchComune('testing');
        theController.deleteChildAlone();
        EOF_EAI_Service_Log__c serv=new EOF_EAI_Service_Log__c();
        insert(serv);
        PageReference pageRef2 = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef2.getParameters().put('cLogId', serv.Id);         
        Test.setCurrentPage(pageRef2);
        theController.deletechildLog();
        
        Test.stopTest();
    }
    
    static testMethod void testMethod2() 
    {
        Test.startTest(); 
        
        EOF_EAI_Service_Log__c theParentLog = new EOF_EAI_Service_Log__c();
        insert theParentLog;
        
        PageReference pageRef = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef.getParameters().put('parentId', theParentLog.Id); 
        pageRef.getParameters().put('cLogId', null);         
        Test.setCurrentPage(pageRef);
        
        PO_Serv_P2PBase_EditLogInfoCntrl theController = new PO_Serv_P2PBase_EditLogInfoCntrl();
        theController.insertChildLog();
        theController.SaveParentChildLogInfo();
        theController.Annulla();        
        theController.upload();        
        //theController.runSearchProfilo();
        //theController.getProfiloVLAN();
        PO_Serv_P2PBase_EditLogInfoCntrl.searchComune('testing');
        theController.deleteChildAlone();
        EOF_EAI_Service_Log__c serv=new EOF_EAI_Service_Log__c();
        insert(serv);
        PageReference pageRef2 = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef2.getParameters().put('cLogId', serv.Id);         
        Test.setCurrentPage(pageRef2);
        theController.deletechildLog();
        
        Test.stopTest();
    }
    
      static testMethod void testMethod3() 
    {
        Test.startTest(); 
        
        EOF_EAI_Service_Log__c theParentLog = new EOF_EAI_Service_Log__c();
        insert theParentLog;
        
        PageReference pageRef = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef.getParameters().put('parentId', theParentLog.Id); 
        pageRef.getParameters().put('cLogId', theParentLog.Id);         
        Test.setCurrentPage(pageRef);
        
        PO_Serv_P2PBase_EditLogInfoCntrl theController = new PO_Serv_P2PBase_EditLogInfoCntrl();
        theController.insertChildLog();
        theController.SaveParentChildLogInfo();
        theController.Annulla(); 
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        theController.filebody=bodyBlob;
        theController.upload();        
        //theController.runSearchProfilo();
        //theController.getProfiloVLAN();
        PO_Serv_P2PBase_EditLogInfoCntrl.searchComune('testing');
        theController.deleteChildAlone();
        EOF_EAI_Service_Log__c serv=new EOF_EAI_Service_Log__c();
        insert(serv);
        PageReference pageRef2 = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef2.getParameters().put('cLogId', serv.Id);         
        Test.setCurrentPage(pageRef2);
        theController.deletechildLog();
        
        Test.stopTest();
    }
    
    static testMethod void testMethod4() 
    {
        Test.startTest(); 
        
        EOF_EAI_Service_Log__c theParentLog = new EOF_EAI_Service_Log__c();
        insert theParentLog;
        
        PageReference pageRef = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef.getParameters().put('parentId', theParentLog.Id); 
        pageRef.getParameters().put('cLogId', null);         
        Test.setCurrentPage(pageRef);
        
        PO_Serv_P2PBase_EditLogInfoCntrl theController = new PO_Serv_P2PBase_EditLogInfoCntrl();
        theController.insertChildLog();
        theController.SaveParentChildLogInfo();
        theController.Annulla();  
        EOF_EAI_Service_Log__c serv=new EOF_EAI_Service_Log__c();
        insert(serv);
        PageReference pageRef2 = Page.PO_Serv_P2PBase_EditLogInfo;
        pageRef2.getParameters().put('cLogId', serv.Id);         
        Test.setCurrentPage(pageRef2);
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        theController.filebody=bodyBlob;
        theController.upload();        
        //theController.runSearchProfilo();
        //theController.getProfiloVLAN();
        PO_Serv_P2PBase_EditLogInfoCntrl.searchComune('testing');
        theController.deleteChildAlone();
        theController.deletechildLog();
        
        Test.stopTest();
    }

}
@isTest
private class PO_Serv_FiberLease_ComplOrd_Cntrl_Test {
    
    static testMethod void testMethod1() 
    {
        Test.startTest();       
        
        insert new OF_Tibco_userID__c(Name = 'Tibco UserID', OF_Tibco_ID__c = '00558000001f743AAA');
        insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status', OF_Enable_Trigger__c = true);
        
        
        
        Case theRichiesta = new Case();
        insert theRichiesta;
        
        Case theCollegamento = new Case();
       	theCollegamento.PO_Richiesta_a_fattibilit__c = theRichiesta.Id;   
        insert theCollegamento;
        
        EOF_EAI_Service_Log__c theLogParent = new EOF_EAI_Service_Log__c();        
        insert theLogParent;
        
        Case theOrder = new Case();
        theOrder.PO_Case_Collegamento__c = theCollegamento.Id; 
        theOrder.ParentId = theRichiesta.Id;
        insert theOrder;
        
        EOF_EAI_Service_Log__c theOrderLog = new EOF_EAI_Service_Log__c();
        theOrderLog.Caso__c = theOrder.Id;
        insert theOrderLog;
                        
        EOF_EAI_Service_Log__c theLog = new EOF_EAI_Service_Log__c(); 
        theLog.Caso__c  = theRichiesta.Id; 
        insert theLog;
                                            
        PageReference pageRef = Page.PO_FiberLease_OverviewchildLogOrd;
        pageRef.getParameters().put('ordercaseditId', theOrder.Id);        
        Test.setCurrentPage(pageRef);
        
        PO_Serv_FiberLease_CompletaOrdine_Cntrl theController = new PO_Serv_FiberLease_CompletaOrdine_Cntrl();  
        
        theController.date4 = Datetime.now().format('yyyy-MM-dd'); 
        theController.SaveOrderCase();
        theController.orderAnnulla();
        
        Test.stopTest();
    }

}
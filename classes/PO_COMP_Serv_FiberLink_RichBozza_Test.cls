@isTest
private class PO_COMP_Serv_FiberLink_RichBozza_Test {
    static testmethod void testMethod1(){
        
        
        EOF_EAI_Service_Log__c serv= new EOF_EAI_Service_Log__c();
        insert(serv);
       
            
        PO_COMP_Serv_FiberLink_RichBozza_Cntrl theController= new PO_COMP_Serv_FiberLink_RichBozza_Cntrl();
        theController.parentLogId=serv.id;
        theController.vediReqBozza();
        theController.pageDown();
        theController.pageUp();
        theController.setPagination(true);
        theController.preparePage();
        
        

}

}
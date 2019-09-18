@isTest
private class PO_DarkFiber_ChildReqDetails_Ctrl_Test {
    
         static testmethod void testMethod1(){
              
        EOF_EAI_Service_Log__c serv=new EOF_EAI_Service_Log__c();
        insert(serv);   
            
        PageReference pageRef = Page.PO_Serv_DarkFiber_Riepilogo;
        pageRef.getParameters().put('childId', serv.Id);                   
        Test.setCurrentPage(pageRef);  
            
        PO_DarkFiber_ChildReqDetails_Ctrl theController= new PO_DarkFiber_ChildReqDetails_Ctrl();
            
        theController.detailparentlog();
        theController.DesospendiClg();
        
	
}

}
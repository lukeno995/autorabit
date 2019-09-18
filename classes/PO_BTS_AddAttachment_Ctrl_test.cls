@isTest
private class PO_BTS_AddAttachment_Ctrl_test {
    
    static testmethod void testMethod1(){
       
       EOF_EAI_Service_Log__c serv=new EOF_EAI_Service_Log__c();
       insert(serv);
       PO_BTS_AddAttachment_Ctrl theController= new PO_BTS_AddAttachment_Ctrl();
       theController.parentLogObj=serv;
	   String myString = 'StringToBlob';
	   Blob myBlob = Blob.valueof(myString);
       theController.fileBody=myBlob;
       thecontroller.attachUpload();
       
   }


}
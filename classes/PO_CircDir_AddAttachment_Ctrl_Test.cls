@isTest
public class PO_CircDir_AddAttachment_Ctrl_Test {

     static testmethod void testMethod1(){
       
       EOF_EAI_Service_Log__c serv=new EOF_EAI_Service_Log__c();
       insert(serv);
       PO_CircDir_AddAttachment_Ctrl theController= new PO_CircDir_AddAttachment_Ctrl();
       theController.parentLogObj=serv;
	   String myString = 'StringToBlob';
	   Blob myBlob = Blob.valueof(myString);
       theController.fileBody=myBlob;
       thecontroller.attachUpload();
       
   }
}
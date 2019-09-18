@isTest
public class CQS_Isp_SignatureComponentCtrl_Test{
    public static testMethod void IspMethod(){
        
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.Name = 'Test';
        pro.CQS_Pro_Area__c = 'Test';
        insert pro;
        
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_Accantieramento_conforme__c = 'Sì';
        cqs.CQS_ISP_Progetto__c = pro.Id;
        cqsList.add(cqs);
        insert cqsList;

        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=cqsList[0].id;
        insert attach;
        
        
       ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(cqsList);
        CQS_Isp_SignatureComponentController  isp = new CQS_Isp_SignatureComponentController (stdSetController);
        
        
        //stdSetController.stdCntrlr (isp);
        
        CQS_Isp_SignatureComponentController.closeAfterSave();
        CQS_Isp_SignatureComponentController.saveSignature('Test',cqsList[0].Id);
    }
}
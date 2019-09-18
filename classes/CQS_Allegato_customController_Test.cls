@isTest
public class CQS_Allegato_customController_Test{
    public static testMethod void CQSMethod(){
        Id RecordTypeIdeven = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();
        
        OF_CQS_Anagrafica__c ana = new OF_CQS_Anagrafica__c();
        ana.CQS_Check_Affidataria__c = true;
        ana.Name = 'TESTANA';
        insert ana;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.Name = 'Test';
        pro.CQS_Pro_Area__c = 'Test';
        insert pro;
        
        OF_CQS_Evento__c Evento = new OF_CQS_Evento__c();
        Evento.OF_CQS_Impresa_Esecutrice_Eventi__c = ana.Id;
        Evento.OF_CQS_Impresa_Mandataria__c = ana.Id;
        Evento.OF_CQS_Data_Evento__c = system.today();
        Evento.VIA__c = 'ROSSI';
        Evento.OF_CQS_Numero_Civico__c = '3';
        Evento.RecordTypeId = RecordTypeIdeven;
        Evento.OF_CQS_Diffida__c = FALSE;
        Evento.OF_CQS_Richiesta_Danni__c = FALSE;
        Evento.OF_CQS_Inadempienze_Operative__c = FALSE;
        Evento.OF_CQS_ev_Segnalazione_Comune__c= True;
        evento.CQS_Ev_Progetto__c = pro.Id;
        insert Evento;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=Evento.id;
        insert attach;
        
        CQS_Allegati__c alle = new CQS_Allegati__c();
        alle.Name = 'MailError.PNG';
        alle.CQS_All_ev__c = Evento.Id;
        alle.CQS_All_Tipo_Allegato__c = 'Altro';
        alle.CQS_Ev_Allegato__c = '00P8E000005csd9UAA';
        insert alle;
        
        ApexPages.currentPage().getParameters().put('evId',Evento.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(Evento);
        CQS_Allegato_customController allega = new CQS_Allegato_customController (sc);
        allega.fileName = attach.name;
        allega.fileBody = attach.body;
        allega.back();
        allega.processUpload();
      //  public void callMethod(){
        //    if(Test.isRunningTest()){
        allega.callMethod();
     //       }
        //}
       
        //allega.saveStandardAttachment(attach.id);
        //
        //allega.saveCustomAttachment();
        
    }
    
    
    
}
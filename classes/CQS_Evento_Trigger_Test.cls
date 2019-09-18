@isTest
public class CQS_Evento_Trigger_Test{
    public static testmethod void CQS_Evento_TriggerMethod(){
    Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();
    
     Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
      User u2 = new User(Alias = 'nUser1a', Email='newuser1a@testorg.com',
         EmailEncodingKey='UTF-8', LastName='Testing1a', LanguageLocaleKey='en_US',
         LocaleSidKey='en_US', ProfileId = p.Id,
         TimeZoneSidKey='America/Los_Angeles', UserName='newuser1a@testorg.com');
         
          System.runAs(u2) {
    Account acc = new account();
    acc.name = 'Test';
    insert acc;
    
    OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
    anag.CQS_Check_Affidataria__c = true;
    insert anag;
 CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
    
    OF_CQS_Evento__c even = new OF_CQS_Evento__c();
    even.OF_CQS_Impresa_Mandataria__c = anag.Id;
    even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
    even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
    even.OF_CQS_Data_Evento__c = System.today();
    even.OF_CQS_Rispetto_Procedura__c = 'Sì';
    even.OF_CQS_Diffida__c  = FALSE;
    even.CQS_Ev_Progetto__c=pro.id;
    even.OF_CQS_Inadempienze_Operative__c = FALSE;
    even.recordtypeid=RecordTypeIdevent;
    even.OF_CQS_Richiesta_Danni__c  = true;
    insert even;
    
    TEMPLOG__c tem = new TEMPLOG__c();
    tem.Class__c = 'Test';
    insert tem;
    }
    }
}
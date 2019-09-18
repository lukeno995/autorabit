@isTest
public class OF_UnivocitaCatalogoApparatiTEST{

   public static testmethod void MyUnitTest1()
   {
      //Creazione Account-OLO
      String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
      Account accOLO = new Account();
      accOLO.Name = 'Vodafone';
      accOLO.EOF_Codice_Operatore__c = 'VF';
      accOLO.Type = 'OLO';
      accOLO.Industry = 'Telecommunications';
      accOLO.RecordTypeId = oloAccountRecordTypeId;
      insert accOLO;
      //Creazione apparato sotto l'OLO
      OF_CatalogoApparati__c obj = new OF_CatalogoApparati__c();
      obj.OF_TipologiaApparato__c = 'test';
      obj.OF_OLO__c = accOLO.Id;
      insert obj;
      //select id, OF_TipologiaApparato__c, OF_OLO__r.name from OF_CatalogoApparati__c
    }



}
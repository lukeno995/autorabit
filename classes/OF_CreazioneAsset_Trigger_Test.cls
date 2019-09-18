@isTest
public class OF_CreazioneAsset_Trigger_Test {
   public static testmethod void MyUnit1()
   {
      
      Account acc = new Account();
      String idR = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
       
      acc.Name = 'Vodafone';
      acc.EOF_Codice_Operatore__c = 'VF';
      acc.Industry = 'Telecommunictions';
      acc.RecordTypeId = idR;insert acc;
     
      Recordtype rectINORDER=[SELECT Id,name from recordtype where sobjecttype = 'Order' and Name = 'INORDER'];
       
      Order ordine1 = new Order();
      ordine1.RecordTypeId = rectINORDER.Id;
      ordine1.EffectiveDate = Date.newInstance(2016,1,1);
      ordine1.Status = 'Aperto';
      ordine1.AccountId = acc.Id;
      ordine1.Name = 'test';
      ordine1.OF_IDRisorsa__c = '12er';
      ordine1.OF_EsitoConsegnaApparato__c = 'Ribaltamento Impianto';
      insert ordine1;
   }
}
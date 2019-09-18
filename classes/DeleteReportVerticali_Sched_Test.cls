@isTest
public class DeleteReportVerticali_Sched_Test {
    
    public static void CreazioneConsistenza()
    {
        ReportVerticali__c repV = new ReportVerticali__c();
        repV.Civico__c='1';
        repV.Comune__c='Napoli';
        repV.IDBuilding__c='12';
        insert repV;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.EOF_Codice_Operatore__c='te';
        acc.AccountNumber='123456';
        insert acc;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = '1234567890123456789';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_ID_Building__c = 'yyyyy';
        asset_1.OF_Particella_Toponomastica__c  ='VIA';
        asset_1.OF_Indirizzo__c = 'JJJJJ';  
        asset_1.OF_Civico__c ='9';  
        asset_1.OF_Comune__c ='Napoli';        
        insert asset_1;      
    }
    
   @isTest(SeeAllData='true')
    public static void Method1()
    {
        CreazioneConsistenza();
        SchedulableContext SC = null;
        DeleteReportVerticali_Sched sched = new DeleteReportVerticali_Sched();
        sched.execute(SC);
    }
}
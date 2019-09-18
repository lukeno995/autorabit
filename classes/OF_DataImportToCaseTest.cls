@isTest
public class OF_DataImportToCaseTest {
    
    static testmethod void myUnitTest1()
    {
                /*Creazione Account*/
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOloVOD = new Account();
        accOloVOD.Name = 'Vodafone';
        accOloVOD.EOF_Codice_Operatore__c = 'VF';
        accOloVOD.Type = 'OLO';
        accOloVOD.Industry = 'Telecommunications';
        accOloVOD.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOloVOD;
        /*Creazione Contract*/
        Contract c1vod = new Contract();
        c1vod.AccountId = accOloVOD.Id;
        c1vod.OF_IdContratto__c = '12';
        c1vod.StartDate = Date.newInstance(2016,1,1);
        c1vod.ContractTerm = 1;
        c1vod.Status = 'Attivo';
        insert c1vod;
        
        Asset ass = new Asset();
        ass.Name = '1234';
        ass.AccountId = accOloVOD.Id;
        ass.OF_Contract__c = c1vod.Id;
        ass.Status = 'Attivo';
       // ass.OF_DataAttivazione__c = Date.today();
        ass.OF_DataAttivazione2__c = Date.today();
        ass.OF_DataCessazione2__c = Date.today();
        insert ass;

        
        List<EOF_EAI_Service_Log__c> listServiceLog = new List<EOF_EAI_Service_Log__c>();
        Case c = new Case();
        c.AssetId = ass.Id;
        insert c;
        

        EOF_EAI_Service_Log__c serviceLog1 = new EOF_EAI_Service_Log__c();
        EOF_EAI_Service_Log__c serviceLog2 = new EOF_EAI_Service_Log__c();
        EOF_EAI_Service_Log__c serviceLog3 = new EOF_EAI_Service_Log__c();
        EOF_EAI_Service_Log__c serviceLog4 = new EOF_EAI_Service_Log__c();
        
        serviceLog1.EOF_Tipo_Comunicazione_String__c = 'OM->SF - Fibernotify - Espletamento OK';
        serviceLog1.Caso__c = c.Id;
        serviceLog2.EOF_Tipo_Comunicazione_String__c = 'OM->SF - Fibernotify - Cessazione OK';
        serviceLog2.Caso__c = c.Id;
        serviceLog3.EOF_Tipo_Comunicazione_String__c = 'SF->OLO - Fibernotify - Espletamento OK';
        serviceLog3.Caso__c = c.Id;
        serviceLog4.EOF_Tipo_Comunicazione_String__c = 'SF->OLO - Fibernotify - Cessazione';
        serviceLog4.Caso__c = c.Id;

        listServiceLog.add(serviceLog1);
        listServiceLog.add(serviceLog2);
        listServiceLog.add(serviceLog3);
        listServiceLog.add(serviceLog4);
        
        insert listServiceLog;
        //EOF_EAI_Service_Log__c serviceLog2 = new EOF_EAI_Service_Log__c();
                                   
    }
   
}
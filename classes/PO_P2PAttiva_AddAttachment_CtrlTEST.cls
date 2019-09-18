@isTest
public class PO_P2PAttiva_AddAttachment_CtrlTEST {
 	
    	public static testMethod void testMethod1(){
         TestDataFactory.CreateTestRecords(null, null, null);
        
         Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        Contact cnt = new Contact();
        cnt.AccountId=TestDataFactory.accOLO.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
            
        insert cnt;
        
        User usr = [Select id from User where ProfileId =:prfl.Id and IsActive=true LIMIT 1];
        
        
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
         List<Case> listOrderCases = new List<Case>();
         List<EOF_EAI_Service_Log__c> SlogToInsert = new List<EOF_EAI_Service_Log__c>();
         Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita']; 
         Case oCase = new Case();
         oCase.Status='Accettato';
         oCase.EOF_Codice_Operatore_WS__c='TIS';
         oCase.AccountId=TestDataFactory.accOLO.id;
         oCase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         oCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase.OwnerId=usr.id;
         oCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         oCase.PO_Nome_Progetto__c='TEST Nome Progetto';
        insert oCase; 
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        
        insert slFatt;
        
         
        Test.startTest();
        Test.setCurrentPage(Page.PO_P2PAttiva_AddAttachment);
        ApexPages.currentPage().getParameters().put('parentId', slFatt.id);
        
        PO_P2PAttiva_AddAttachment_Ctrl p2pAttAtt = new PO_P2PAttiva_AddAttachment_Ctrl();
        //p2pAttAtt.parentLogId=slFatt.id;
        p2pAttAtt.parentCaseObj= oCase;
        p2pAttAtt.parentLogObj=slFatt;
        
        p2pAttAtt.fileBody= Blob.valueOf('a'.repeat(5242880));
        p2pAttAtt.fileName='Test';
        Test.setCurrentPage(Page.PO_P2PAtt_RiepReq_ElCo);
        ApexPages.currentPage().getParameters().put('parentId',  p2pAttAtt.parentLogObj.id);
      
        
        
        p2pAttAtt.attachUpload();
        
        Test.stopTest();
        
        
        
    }

}
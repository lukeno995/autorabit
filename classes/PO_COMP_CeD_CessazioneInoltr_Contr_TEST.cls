@isTest
public class PO_COMP_CeD_CessazioneInoltr_Contr_TEST {

    public static testmethod void testmethod1(){
        
        // account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account acc = new account();
        acc.name ='test';
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Type = 'OLO';
        acc.industry = 'Telecommunications';
        acc.RecordTypeID = oloAccountRecordTypeId;
        
        insert acc;
        // end account creation
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Cessazione OPENSTREAM CD').getRecordTypeId();
        case c = new case();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Account_OLO__c = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.EOF_Data_Notifica__c= system.now();
        insert c;
        // end case creation
        
       
        //service log creation 
              
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
                
        insert sl;
        
        // end service log creation
     
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sv.OF_SA_Cpe_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStream_CeD_DisplayRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_CeD_CessazioneInoltrata_Contr cic = new PO_COMP_CeD_CessazioneInoltrata_Contr();
    }
}
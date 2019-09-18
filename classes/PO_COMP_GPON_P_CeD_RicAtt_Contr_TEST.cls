@isTest
public class PO_COMP_GPON_P_CeD_RicAtt_Contr_TEST {
    
    public static testmethod void test1(){
        
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD', null, null);

        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
                
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - GponPassivaRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_GPON_Passiva_CeD_RicAtt_Contr.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;       
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        System.currentPageReference().getParameters().put('tipo', 'clona');
        
        test.startTest();
        PO_COMP_GPON_Passiva_CeD_RicAtt_Contr rac = new PO_COMP_GPON_Passiva_CeD_RicAtt_Contr();

        rac.savesl();
        rac.annullaInsSl();
        rac.updatesl();
        test.stopTest();
    }
    
    
    public static testmethod void test2(){

        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD', null, null);
                
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
                
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - GponPassivaRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        //PO_COMP_CeD_RichiestaAttivazione_Contr.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = TesTDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;       
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_GPON_Passiva_CeD_RicAtt_Contr rac = new PO_COMP_GPON_Passiva_CeD_RicAtt_Contr();
        
        rac.savesl();
        rac.annullaInsSl();
        rac.updatesl();
        
        test.stopTest();
    }    
    
}
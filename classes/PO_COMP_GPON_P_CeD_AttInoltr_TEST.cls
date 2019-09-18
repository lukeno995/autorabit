@isTest
public class PO_COMP_GPON_P_CeD_AttInoltr_TEST {

    public static testmethod void testmethod5() {
    	
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null, null);
        
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
        
        // end service log creation
     
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
                
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'errorRimod');
        
    	test.startTest();
    	PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr pac = new PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void testmethod6() {
    	
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null, null);
        
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
        
        // end service log creation
     
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'errorDesosp');
        
    	test.startTest();
    	PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr pac = new PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void testmethod7() {
    	
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null, null);
        
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
        
        // end service log creation
     
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'successDesosp');
        
    	test.startTest();
    	PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr pac = new PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void testmethod8() {
    	
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null, null);
        
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
        
        // end service log creation
     
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'successRimod');
        
    	test.startTest();
    	PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr pac = new PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void testmethod9() {
        
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null, null);
        
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
        
        // end service log creation
        
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('proc', 'errorAnnull');
        
        test.startTest();
        PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr pac = new PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
        test.stopTest();
    }

    public static testmethod void testmethod10() {
        
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD',null, null);
        
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
        
        // end service log creation
        
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_GPON_Passiva_CeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('proc','successAnnull');
        
        test.startTest();
        PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr pac = new PO_COMP_GPON_Passiva_CeD_AttInoltr_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
        test.stopTest();
    }
}
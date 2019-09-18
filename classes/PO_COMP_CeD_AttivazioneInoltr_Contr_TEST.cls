@isTest
public class PO_COMP_CeD_AttivazioneInoltr_Contr_TEST {

    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod1() {

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
		String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
 		// end business account creation
       
        //service log creation 
              
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
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
        
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sc.OF_SA_VLan_Log__c=sl.id;       
        insert sc;
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('origId', sl.id);
        
    	test.startTest();
    	PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }
    
    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod2(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
		String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
 		// end business account creation
       
        //service log creation 
              
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStream_CeD_DisplayRequest')); 
		System.currentPageReference().getParameters().put('origId', sl.id);
        
    	test.startTest();
    	PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.goToRicIns();
        
    	test.stopTest();
    }
    
    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod3() {
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
                
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito KO';
        
        insert sl;
        
        // end service log creation
        
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
        test.stopTest();
    }

    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod4() {
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Sospeso';
        
        insert sl;
        
        // end service log creation
        
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
        test.stopTest();
        
    }
    
    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod5() {
    	
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
		String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
 		// end business account creation
        
        //service log creation 
              
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
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
                
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'errorRimod');
        
    	test.startTest();
    	PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod6() {
    	
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
		String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
 		// end business account creation
              
        //service log creation 
              
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'errorDesosp');
        
    	test.startTest();
    	PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod7() {
    	
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
		String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
 		// end business account creation
        
       
        //service log creation 
              
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'successDesosp');
        
    	test.startTest();
    	PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod8() {
    	
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
		String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
 		// end business account creation
       
        //service log creation 
              
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
		System.currentPageReference().getParameters().put('proc', 'successRimod');
        
    	test.startTest();
    	PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
    	test.stopTest();
    }

    public static testmethod void PO_COMP_CeD_Attivaz_Testmethod9() {
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('proc', 'errorAnnull');
        
        test.startTest();
        PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
        test.stopTest();
    }

    public static testmethod void PO_COMP_Attivaz_Testmethod10() {
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM_CeD',null, null);
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('proc', 'successAnnull');
        
        test.startTest();
        PO_COMP_CeD_AttivazioneInoltrata_Contr pac = new PO_COMP_CeD_AttivazioneInoltrata_Contr();
        pac.desospensione();
        pac.rimodulazioneDAC();
        pac.annullamento();
        pac.insNewReq();
        
        test.stopTest();
    }
}
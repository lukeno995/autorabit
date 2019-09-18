@isTest
public class PO_COMP_GPON_P_CeD_ListaRicIns_Con_TEST {

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
        
        List<EOF_EAI_Service_Log__c> listInserite = new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - GponPassivaRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_Codice_Operatore__c= TestDatafactory.accOLO.EOF_Codice_Operatore__c;
        listInserite.add(sl);
        insert listInserite;
        
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
        
        test.startTest();
        PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con lri = new PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con();
        PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con.optionApex opr=new PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con.optionApex('Test','Test');
        lri.tipoRIchiesta='Attivazione';
        lri.vediReq();
        lri.clonaRequest();
        lri.debugSoql='test';
        lri.optTipoRichiestaString='test';
        lri.optStatoRichiestaString='test';
        lri.pageUp();
        lri.pageDown();
        lri.ricalcolaOptionFiltri(listInserite);
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
        
        List<EOF_EAI_Service_Log__c> listInserite = new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - GponPassivaRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_Codice_Operatore__c= TestDatafactory.accOLO.EOF_Codice_Operatore__c;
        listInserite.add(sl);
        insert listInserite;
        
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
        
        test.startTest();
        PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con lri = new PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con();
        PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con.optionApex opr = new PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con.optionApex('Test','Test');
        lri.tipoRIchiesta='Cessazione';
        ApexPages.currentPage().getParameters().put('proc','editCessazione');
        lri.vediReq();
        lri.clonaRequest();
        lri.debugSoql='test';
        lri.optTipoRichiestaString='test';
        lri.optStatoRichiestaString='test';
        lri.pageUp();
        lri.pageDown();
        lri.ricalcolaOptionFiltri(listInserite);
        test.stopTest();
    }
    
    
    public static testmethod void test3(){
        
        TestDataFactory.CreateTestRecords('EOF_SP_Caso_Attivazione_CeD', null, null);
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        //service log creation 
        
        List<EOF_EAI_Service_Log__c> listInserite = new List<EOF_EAI_Service_Log__c>();
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        //sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        Id RecordTypeIdcom = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_CO_FiberRequest').getRecordTypeId();
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_Codice_Operatore__c= TestDataFactory.accOLO.EOF_Codice_Operatore__c;
        sl.RecordTypeId = RecordTypeIdcom;
        sl.EOF_Stato_Richiesta__c = 'Inserita Portale';
        listInserite.add(sl);
        insert listInserite;
        
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
        
        test.startTest();
        PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con lri = new PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con();
        PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con.optionApex opr=new PO_COMP_GPON_Passiva_CeD_ListaRicIns_Con.optionApex('Test','Test');
        lri.tipoRIchiesta='Change Order';
        lri.vediReq();
        lri.clonaRequest();
        lri.debugSoql='test';
        lri.optTipoRichiestaString='test';
        lri.optStatoRichiestaString='test';
        lri.pageUp();
        lri.pageDown();
        boolean next = null;
        boolean filtered = true;
        lri.setPagination(next);
        lri.preparePage();
        ApexPages.currentPage().getParameters().put('DataInizioNotifica','test');
        ApexPages.currentPage().getParameters().put('DataFineNotifica','test');
        ApexPages.currentPage().getParameters().put('DataInizioCreazione','test');
        ApexPages.currentPage().getParameters().put('DataFineCreazione','test');
        // List<String> ListTipo = new List<String>();
        // ListTipo= (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().put('selectValueL1','test'), List<String>.class);
        // String json ='[{\'test1\',\'test2\',\'test3\'}]';
        //ApexPages.currentPage().getParameters().put('selectValueL1',json);
        //  ApexPages.currentPage().getParameters().put('selectValueL2',json);
        ApexPages.currentPage().getParameters().put('valPOP','test');
        ApexPages.currentPage().getParameters().put('valCodOrdOLO','test');
        ApexPages.currentPage().getParameters().put('valIDRisorsa','test');
        
        lri.runQuery();
        lri.runSearch();
        lri.ricalcolaOptionFiltri(listInserite);
        
        test.stopTest();
   } 
}
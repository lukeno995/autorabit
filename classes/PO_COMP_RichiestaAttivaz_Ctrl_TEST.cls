@isTest
public class PO_COMP_RichiestaAttivaz_Ctrl_TEST {

    //TEAM NAPOLI 6-04
    /**Questo metodo crea il CustomSetting OF_CodificaProfiloListini__c **/
    public static list<OF_CodificaProfiloListini__c> cod_Prof_list_creation()
    {
        list<OF_CodificaProfiloListini__c> CustSettList = new list<OF_CodificaProfiloListini__c>();
        
        OF_CodificaProfiloListini__c cs_0 = new OF_CodificaProfiloListini__c(
        name = '1',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_20_5',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_20_5',
        IsPortalValid__c = true
        );
        CustSettList.add(cs_0);
        
        OF_CodificaProfiloListini__c cs_1 = new OF_CodificaProfiloListini__c(
        name = '35',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_500_100',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_500_100',
        IsPortalValid__c = true
        );
        CustSettList.add(cs_1);
        
        OF_CodificaProfiloListini__c cs_2 = new OF_CodificaProfiloListini__c(
        name = '10',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_300_100',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_300_100',
        IsPortalValid__c = true
        );
        CustSettList.add(cs_2);

        insert CustSettList;
        return CustSettList;
    }
    //END

    public static testmethod void test1(){
        
        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);

        list<OF_CodificaProfiloListini__c> custom_setting_list = cod_Prof_list_creation(); //TEAM NAPOLI 6-04
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
                
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_RichiestaAttivazione_Controller.slOrig = sl;
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        System.currentPageReference().getParameters().put('tipo', 'clona');
        
        test.startTest();
        PO_COMP_RichiestaAttivazione_Controller rac = new PO_COMP_RichiestaAttivazione_Controller();
        
        Boolean esito = rac.verifyProfiloNew(custom_setting_list.get(0).name); //TEAM NAPOLI 6-04
        //System.debug('ESITO: '+esito);
        rac.savesl();
        rac.runSearchProfilo(); //TEAM NAPOLI 6-04
        rac.annullaInsSl();
        rac.updatesl();
        test.stopTest();
    }
    
    public static testmethod void test2(){

        TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
                
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
                
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = TestDataFactory.c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= TestDataFactory.c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        //PO_COMP_RichiestaAttivazione_Controller.slOrig = sl;
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_RichiestaAttivazione_Controller rac = new PO_COMP_RichiestaAttivazione_Controller();
        //rac.savesl();
        rac.annullaInsSl();
        rac.updatesl();
        test.stopTest();
    }    
    
}
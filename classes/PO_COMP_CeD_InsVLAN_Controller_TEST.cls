@isTest
public class PO_COMP_CeD_InsVLAN_Controller_TEST {
    
    public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        return catalogo;
    }
    
    public static OF_Servizio__c ServizioPP_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'PreProvisioning';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
    public static OF_CommercialElement__c CE_Vlan_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO VLAN';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    }

    public static testmethod void test1(){
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
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
        //PO_COMP_CeD_InserimentoVLAN_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sv.OF_SA_PROFILO_VLAN__c='COS 0';
        sv.OF_SA_VLan_Log__c=sl.id;
        sv.OF_SA_SERVICE_VLAN__c='835';
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;       
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id );
        test.startTest();
        
        PO_COMP_CeD_InserimentoVLAN_Controller ivc = new PO_COMP_CeD_InserimentoVLAN_Controller ();
        ApexPages.currentPage().getParameters().put('orig','ATT');

        //ivc.showSVLAN(); 
        //ivc.fillFields();
        ivc.modifyPicklist();
        ivc.annullaVLAN();
        ivc.InserisciVLAN();
        ivc.updateVLAN();
        //ApexPages.currentPage().getParameters().put('orig','CESS');
        //ivc.InserisciVLAN();
        //ivc.updateVLAN();
        test.stopTest();
    }
    
    public static testmethod void test2(){
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
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
        sl.EOF_STATO_ORDINE__c = 'Acquisito';
        
        insert sl;
        //PO_COMP_CeD_InserimentoVLAN_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c = c.EOF_Data_Notifica__c;
        sv.OF_SA_PROFILO_VLAN__c='COS 0';
        sv.OF_SA_VLan_Log__c = sl.id;       
        insert sv;
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;       
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('orig', 'ATT');
        
        test.startTest();
        PO_COMP_CeD_InserimentoVLAN_Controller ivc = new PO_COMP_CeD_InserimentoVLAN_Controller ();
        ivc.annullaVLAN();
        sv.OF_SA_PROFILO_VLAN__c = 'COS 1';
        update sv;
      //  ivc.InserisciVLAN();
       // ivc.updateVLAN();
        test.stopTest();
    }


    public static testmethod void test3(){
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
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
        sl.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        insert sl;
        //PO_COMP_InserimentoVLAN_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sv.OF_SA_PROFILO_VLAN__c = 'COS 1';
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv;
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;       
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('orig', 'CESS');
        
        test.startTest();
        PO_COMP_CeD_InserimentoVLAN_Controller ivc = new PO_COMP_CeD_InserimentoVLAN_Controller();
        ivc.annullaVLAN();
        sv.OF_SA_PROFILO_VLAN__c = 'COS 1';
        update sv;
        //ivc.InserisciVLAN();
        //ivc.updateVLAN();
        test.stopTest();
    }
     public static testmethod void test4(){
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
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
        //PO_COMP_CeD_InserimentoVLAN_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;       
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('idVlan', sv.id ); 
        test.startTest();
        
        PO_COMP_CeD_InserimentoVLAN_Controller ivc = new PO_COMP_CeD_InserimentoVLAN_Controller ();        
        ivc.getProfiloVLAN();
        
        test.stopTest();
    }
    
        public static testmethod void test5(){
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
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
        //PO_COMP_CeD_InserimentoVLAN_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sv.OF_SA_PROFILO_VLAN__c='COS 0';
        sv.OF_SA_VLan_Log__c=sl.id;
        sv.OF_SA_SERVICE_VLAN__c='835';
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;       
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id );
        ApexPages.currentPage().getParameters().put('idVlan',sa.id);

        test.startTest();
        
        PO_COMP_CeD_InserimentoVLAN_Controller ivc = new PO_COMP_CeD_InserimentoVLAN_Controller ();

        //ivc.showSVLAN(); 
        //ivc.fillFields();
        ivc.modifyPicklist();
        ivc.annullaVLAN();
        ivc.serviceVLan='Test';
        OF_CommercialElementIstanziato__c com = new OF_CommercialElementIstanziato__c();
        ivc.VLANValues=com;
        List<SelectOption> listaKIT =new List<SelectOption>();
        ivc.listaKIT  = listaKIT ;
        ivc.updateVLAN();
        test.stopTest();
    }
}
@isTest
public class PO_COMP_CessazInserita_Contrl_TEST {
    public static testmethod void testmethod1(){
        
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
         spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
         spp1.Name='Semaforo Proxy Portale Cessazione';
         spp1.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp1.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp1;
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
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
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CessazioneInserita_Controller.slOrig = sl;
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_CessazioneInserita_Controller pci = new PO_COMP_CessazioneInserita_Controller();
        //pci.inserisciVLAN();
        pci.editslCESS();
        pci.deleteslCESS();
        pci.inserisciApparatoCESS();
        //pci.inserisciServAgg();
        //pci.deleteVLAN();
        //pci.editVLAN();
        //pci.deleteApparatoCESS();
        pci.editApparatoCESS();
        //pci.deleteServAgg();
        //pci.editServAgg();
        pci.confermaRequestCESS();
        pci.inoltraRequestCESS();
        pci.annullaInoltroCESS();
        pci.insNewReq();
        pci.goToRicIns();
        test.stopTest();


    }
    
    public static testmethod void testmethod2(){
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
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
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CessazioneInserita_Controller.slOrig = sl;
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStream_DisplayRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_CessazioneInserita_Controller pci = new PO_COMP_CessazioneInserita_Controller();
        pci.goToRicIns();
        test.stopTest();
        
        
    }

    public static testmethod void testmethod3(){
        
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
         spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
         spp1.Name='Semaforo Proxy Portale Cessazione';
         spp1.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp1.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp1;
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
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
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CessazioneInserita_Controller.slOrig = sl;
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'confirmPageCESS');
        
        test.startTest();
        PO_COMP_CessazioneInserita_Controller pci = new PO_COMP_CessazioneInserita_Controller();
        //pci.inserisciVLAN();
        pci.editslCESS();
        pci.deleteslCESS();
        pci.inserisciApparatoCESS();
        //pci.inserisciServAgg();
        //pci.deleteVLAN();
        //pci.editVLAN();
        //pci.deleteApparatoCESS();
        pci.editApparatoCESS();
        //pci.deleteServAgg();
        //pci.editServAgg();
        pci.confermaRequestCESS();
        pci.inoltraRequestCESS();
        pci.annullaInoltroCESS();
        pci.insNewReq();
        pci.goToRicIns();
        test.stopTest();


    }

    public static testmethod void testmethod4(){
        
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
         spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
         spp1.Name='Semaforo Proxy Portale Cessazione';
         spp1.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp1.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp1;
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
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
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CessazioneInserita_Controller.slOrig = sl;
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'successInsertCESS');
        
        test.startTest();
        PO_COMP_CessazioneInserita_Controller pci = new PO_COMP_CessazioneInserita_Controller();
        //pci.inserisciVLAN();
        pci.editslCESS();
        pci.deleteslCESS();
        pci.inserisciApparatoCESS();
        //pci.inserisciServAgg();
        //pci.deleteVLAN();
        //pci.editVLAN();
        //pci.deleteApparatoCESS();
        pci.editApparatoCESS();
        //pci.deleteServAgg();
        //pci.editServAgg();
        pci.confermaRequestCESS();
        pci.inoltraRequestCESS();
        pci.annullaInoltroCESS();
        pci.insNewReq();
        pci.goToRicIns();
        test.stopTest();


    }

    public static testmethod void testmethod5(){
        
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
         spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
         spp1.Name='Semaforo Proxy Portale Cessazione';
         spp1.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp1.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp1;
        
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
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
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
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CessazioneInserita_Controller.slOrig = sl;
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
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'errorInsertCESS');
        
        test.startTest();
        PO_COMP_CessazioneInserita_Controller pci = new PO_COMP_CessazioneInserita_Controller();
        //pci.inserisciVLAN();
        pci.editslCESS();
        pci.deleteslCESS();
        pci.inserisciApparatoCESS();
        //pci.inserisciServAgg();
        //pci.deleteVLAN();
        //pci.editVLAN();
        //pci.deleteApparatoCESS();
        pci.editApparatoCESS();
        //pci.deleteServAgg();
        //pci.editServAgg();
        pci.confermaRequestCESS();
        pci.inoltraRequestCESS();
        pci.annullaInoltroCESS();
        pci.insNewReq();
        pci.goToRicIns();
        test.stopTest();


    }
    
   public static testmethod void testmethod6(){
        
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
         spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
         spp1.Name='Semaforo Proxy Portale Cessazione';
         spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp1;
       
       CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Comune__c='015146';
        cpp.Data__c=system.today().addDays(-14);
        insert cpp;
       
        // account creation
        //   id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account acc = new account();
        acc.name ='test';
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Type = 'OLO';
        acc.industry = 'Telecommunications';
        acc.RecordTypeID = oloAccountRecordTypeId;
        
        insert acc;
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId;
        insert accOLO;
       
       // end account creation
        
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        // 
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
       
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Cessazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Cessazione';
            c1.OF_SA_Interfaccia_OM__c='Nuova IF';
            c1.OF_OM_Nuovo_Flusso__c= true;
            c1.EOF_Identificativo_del_POP__c='MI/FCO/2';
            insert c1;
            
            OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=c1.Id;
            insert g;
            String gid=g.id;
        	 gid= gid.abbreviate(10);
            c1.OF_SA_ID_Servizio__c=gid;
            update c1;
                
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='0000000';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='Y';
        sl.EOF_NOME_REFERENTE_TECNICO_OLO__c= 'NomeRefTec'; 
		sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c='CognomeRefTec' ; 
		sl.EOF_Telefono_Referente_OLO_Onfield_Notec__c= '06230514258587'; 
		sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c= '06230514258586'; 
		sl.EOF_Nome_Cliente__c= 'NomeCliente' ; 
		sl.EOF_COgnome_CLiente__c= 'CognomeCliente' ; 
		sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= '0623051425899' ; 
		sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= '06230514258888' ; 
		sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c= System.today().addDays(35); 
		sl.EOF_ORARIO_APPUNTAMENTO__c='10:00:00' ; 
		sl.EOF_NOTE__c= 'Note request' ; 
		sl.EOF_ID_BUILDING__c= 'ID_Building001' ; 
		sl.EOF_ID_Pop__c ='MI/FCO/2';
       
        insert sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        sc.OF_SA_Azione_APPARATO__c='1';
        insert sc;
        // end cpe service log creation
        sl.OF_SA_Cpe_Log__c=sc.id;
       update sl;
       
       PO_COMP_CessazioneInserita_Controller.slOrig=sl;
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa; 
       
       	case c = new case();
        c.EOF_Account_OLO__c = accOLO.id;
            c.EOF_Codice_Ordine_OLO__c = 'Test33';
            c.EOF_Codice_Operatore_WS__c ='TIS';
            c.EOF_Contact__c = null;
            c.status = 'Espletato';
            c.EOF_FASE__C = 'Espletato OK';
            c.EOF_ID_Building_WS__c ='ID_Building001';
            c.RecordTypeId =CaseRecordTypeId;
            c.EOF_DATA_NOTIFICA__c=system.now();
            c.EOF_Data_Prevista_Attivazione__c=system.today();
            c.OF_SA_Tipo_Lavorazione__c='Attivazione';
            c.OF_SA_Interfaccia_OM__c='';
            c.OF_OM_Nuovo_Flusso__c= true;
            c.EOF_Identificativo_del_POP__c='MI/FCO/3';
    		c.EOF_Id_Risorsa__c=c1.EOF_Id_Risorsa__c;
        	c.EOF_Data_Notifica__c= system.now();
        	c.EOF_Comune_WS__c='Milano';
       		
       		insert c;
        // end case creation
        OF_SA_GE_UtilsNew.caseOriginale = c;
        Asset a = new Asset();
       a.AccountId=accOLO.id;
       a.Name='TEST_00001';
       a.Comune__c='Roma';
       a.EOF_ID_Risorsa__c ='TEST_00001';
    //   a.OF_Case__c = c.id;
       a.OF_DataAttivazione__c= system.today().addDays(-3);
       a.OF_IDCaseAttivazione__c=c.id;
       insert a;
        
       c1.AssetId =a.id;
       update c1;
       /*
        //service log creation 
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='Test_00001';
        sl.EOF_STATO_ORDINE__c ='Espletato';
        
        insert sl;
        PO_COMP_CessazioneInserita_Controller.slOrig = sl;
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
        */
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'successInsertCESS');
        System.currentPageReference().getParameters().put('origID', sl.id);
       
        
        test.startTest();
        PO_COMP_CessazioneInserita_Controller pci = new PO_COMP_CessazioneInserita_Controller();
        //pci.inserisciVLAN();
        pci.editslCESS();
        pci.deleteslCESS();
        pci.inserisciApparatoCESS();
        //pci.inserisciServAgg();
        //pci.deleteVLAN();
        //pci.editVLAN();
        //pci.deleteApparatoCESS();
        pci.editApparatoCESS();
        //pci.deleteServAgg();
        //pci.editServAgg();
        pci.confermaRequestCESS();
        pci.inoltraRequestCESS();
        pci.annullaInoltroCESS();
        pci.insNewReq();
        pci.goToRicIns();
        test.stopTest();


    }

    public static testmethod void testmethod7(){
        
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
         spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
         spp1.Name='Semaforo Proxy Portale Cessazione';
         spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp1;
       
       CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Comune__c='015146';
        cpp.Data__c=system.today().addDays(-14);
        insert cpp;
       
        // account creation
        //   id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account acc = new account();
        acc.name ='test';
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Type = 'OLO';
        acc.industry = 'Telecommunications';
        acc.RecordTypeID = oloAccountRecordTypeId;
        
        insert acc;
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId;
        insert accOLO;
       
       // end account creation
        
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        // 
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
       
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Cessazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Cessazione';
            c1.OF_SA_Interfaccia_OM__c='Nuova IF';
            c1.OF_OM_Nuovo_Flusso__c= true;
            c1.EOF_Identificativo_del_POP__c='MI/FCO/2';
            insert c1;
            
            OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
            g.OF_Case_Id__c=c1.Id;
            insert g;
            String gid=g.id;
        	 gid= gid.abbreviate(10);
            c1.OF_SA_ID_Servizio__c=gid;
            update c1;
                
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='0000000';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='Y';
        sl.EOF_NOME_REFERENTE_TECNICO_OLO__c= 'NomeRefTec'; 
		sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c='CognomeRefTec' ; 
		sl.EOF_Telefono_Referente_OLO_Onfield_Notec__c= '06230514258587'; 
		sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c= '06230514258586'; 
		sl.EOF_Nome_Cliente__c= 'NomeCliente' ; 
		sl.EOF_COgnome_CLiente__c= 'CognomeCliente' ; 
		sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c= '0623051425899' ; 
		sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c= '06230514258888' ; 
		sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c= System.today().addDays(35); 
		sl.EOF_ORARIO_APPUNTAMENTO__c='10:00:00' ; 
		sl.EOF_NOTE__c= 'Note request' ; 
		sl.EOF_ID_BUILDING__c= 'ID_Building001' ; 
		sl.EOF_ID_Pop__c ='MI/FCO/2';
       
        insert sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        sc.OF_SA_Azione_APPARATO__c='1';
        insert sc;
        // end cpe service log creation
        sl.OF_SA_Cpe_Log__c=sc.id;
        update sl;
       
       PO_COMP_CessazioneInserita_Controller.slOrig=sl;
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa; 
       
       	case c = new case();
        c.EOF_Account_OLO__c = accOLO.id;
            c.EOF_Codice_Ordine_OLO__c = 'Test33';
            c.EOF_Codice_Operatore_WS__c ='TIS';
            c.EOF_Contact__c = null;
            c.status = 'Espletato';
            c.EOF_FASE__C = 'Espletato OK';
            c.EOF_ID_Building_WS__c ='ID_Building001';
            c.RecordTypeId =CaseRecordTypeId;
            c.EOF_DATA_NOTIFICA__c=system.now();
            c.EOF_Data_Prevista_Attivazione__c=system.today();
            c.OF_SA_Tipo_Lavorazione__c='Attivazione';
            c.OF_SA_Interfaccia_OM__c='';
            c.OF_OM_Nuovo_Flusso__c= true;
            c.EOF_Identificativo_del_POP__c='MI/FCO/3';
    		c.EOF_Id_Risorsa__c=c1.EOF_Id_Risorsa__c;
        	c.EOF_Data_Notifica__c= system.now();
        	c.EOF_Comune_WS__c='Milano';
       		
       		insert c;
        // end case creation
        OF_SA_GE_UtilsNew.caseOriginale = c;
        Asset a = new Asset();
       a.AccountId=accOLO.id;
       a.Name='TEST_00001';
       a.Comune__c='Roma';
       a.EOF_ID_Risorsa__c ='TEST_00001';
    //   a.OF_Case__c = c.id;
       a.OF_DataAttivazione__c= system.today().addDays(-3);
       a.OF_IDCaseAttivazione__c=c.id;
       insert a;
        
       c1.AssetId =a.id;
       update c1;
        
        
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'cessazioneInserita');
        System.currentPageReference().getParameters().put('origID', sl.id);
       
        
        test.startTest();
        PO_COMP_CessazioneInserita_Controller pci = new PO_COMP_CessazioneInserita_Controller();
        pci.IdApparato= sl.id;
        pci.deleteApparatoCESS();
        pci.IdApparato=sc.id;
        pci.deleteApparatoCESS();
        test.stopTest();
        

        
    } 
    
}
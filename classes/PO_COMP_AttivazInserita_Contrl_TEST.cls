@isTest
public class PO_COMP_AttivazInserita_Contrl_TEST {
    
    public static testmethod void test1(){
          OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
        insert spp1;
        
        //String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        
        //OF_SA_GE_UtilsNew.caseOriginale = TestDataFactory.c1;
      //  TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
         Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        OF_SA_GE_UtilsNew.caseOriginale = c1; //.EOF_ID_Building_WS__c='TEST_000001';
       // update  OF_SA_GE_UtilsNew.caseOriginale;
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
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
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.sl = sa;
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
    
    public static testmethod void test2(){
           OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
        insert spp1;
        
   id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId(); 
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='';
        
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c=c1.EOF_Data_Notifica__c;
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
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c =c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'confirmPageATT');
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
    
    public static testmethod void test3(){
        
           OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
        insert spp1;
        
           id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId(); 
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
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
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'successInsertATT');
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
    
    public static testmethod void test4(){
        
           OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
        insert spp1;
        

          id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId(); 
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
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
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'errorInsertATT');
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
    
    public static testmethod void test5(){
        
           OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
        insert spp1;
        
   id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId(); 
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        
       // TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        
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
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c =c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sc.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        sc.OF_SA_Azione_APPARATO__c='1';
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
    
    public static testmethod void test6(){
         OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=false;
         spp.Semaforo_Proxy_Portale_Cessazione__c=false;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=false;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=false;
        insert spp1;
        
   id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId(); 
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        
       // TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        
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
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c =c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sv.OF_SA_VLan_Log__c=sl.id;       
        insert sv; 
        // end vlan service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sc.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        sc.OF_SA_Azione_APPARATO__c='1';
        sc.OF_SA_Cpe_Log__c=sl.id;
        insert sc;
        // end cpe service log creation
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
       	
        //PO_COMP_AttivazioneInserita_Controller.IdVLAN= sv.id; //.IdVLAN = sv;
        //VLANToDelete.Id=IdVLAN;
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        
        pai.IdVLAN =sv.id;
        pai.deleteVLAN();
        
        pai.IdApparato=sc.id;
        pai.deleteApparato();
        
        pai.IdServAgg= sa.id;
        pai.deleteServAgg();
       
        test.stopTest();
        
    }
    
     public static testmethod void test1b(){
          OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=true;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=true;
        insert spp1;
        
        //String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        
        //OF_SA_GE_UtilsNew.caseOriginale = TestDataFactory.c1;
      //  TestDataFactory.CreateTestRecords('EOF_Caso_Attivazione_OPENSTREAM', null, null);
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
         Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        OF_SA_GE_UtilsNew.caseOriginale = c1; //.EOF_ID_Building_WS__c='TEST_000001';
       // update  OF_SA_GE_UtilsNew.caseOriginale;
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
        sl.OF_SA_Interfaccia_OM__c='Nuova IF';
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
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
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.sl = sa;
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
    
    public static testmethod void test2b(){
           OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=true;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=true;
        insert spp1;
        
   id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId(); 
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='';
		sl.OF_SA_Interfaccia_OM__c='Nuova IF';
        
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
        // end service log creation
        
        // vlan service log creation
        EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
        sv.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        sv.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sv.EOF_Data_Notifica__c=c1.EOF_Data_Notifica__c;
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
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c =c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'confirmPageATT');
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
	
	public static testmethod void test4b(){
        
           OF_ElencoComuniItaliani__c eci = new OF_ElencoComuniItaliani__c();
         eci.OF_CodiceIstat__c = '015146';
		 eci.OF_Comune__c = 'Milano';
		 eci.OF_Provincia__c = 'Milano';
		 eci.OF_Regione__c ='Lombardia';
         eci.OF_Ripartizionegeografica__c ='Nord-ovest';
        // eci.PO_Ripartizione_geografica_NC__c ='';
         //eci.PO_Titolarit_NC__c ='';
         insert eci; 
        
         OF_AreaGeograficaCustom__c ac = new OF_AreaGeograficaCustom__c();
         ac.OF_Comune__c = 'Milano';
         ac.OF_Istat__c='015146';
         insert ac;
        
         Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
 		 spp.Name='Semaforo Proxy Portale Attivazione';
         spp.Semaforo_Proxy_Portale_Attivazione__c=true;
         spp.Semaforo_Proxy_Portale_Cessazione__c=true;
         insert spp;
        
        
        CONFIGURAZIONE_PROXY_PORTALE__c cpp = new CONFIGURAZIONE_PROXY_PORTALE__c();
        cpp.Name='MI_CESSAZIONE';
        cpp.POP__c='MI/FCO/2';
        cpp.Tipo_Lavorazione__c='Cessazione';
        cpp.Data__c=system.today().addDays(-14);
        cpp.Comune__c='';
        insert cpp;
        
        Semaforo_Proxy_Portale__c spp1 = new Semaforo_Proxy_Portale__c();
        spp1.Name='Semaforo Proxy Portale Cessazione';
        spp1.Semaforo_Proxy_Portale_Attivazione__c=true;
        spp1.Semaforo_Proxy_Portale_Cessazione__c=true;
        insert spp1;
        

          id accOloRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId(); 
        
        Account accOLO2 = new Account();
        accOLO2.Name = 'Vodafone';
        accOLO2.EOF_Codice_Operatore__c = 'VF';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = accOloRTid;
        insert accOLO2;
        
        Account accOLO = new Account();
        accOLO.Name = 'Tiscali';
        accOLO.EOF_Codice_Operatore__c = 'TIS';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = accOloRTid;
        insert accOLO;
        
        // creazione contratto
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
       Case c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Acquisito';
            c1.EOF_FASE__C = 'Da Lavorare';
            c1.EOF_ID_Building_WS__c ='ID_Building001';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='OF_SA_Attivazione' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            c1.OF_SA_Tipo_Lavorazione__c='Attivazione';
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
        sl.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
		sl.OF_SA_Interfaccia_OM__c='Nuova IF';
        
        insert sl;
        PO_COMP_AttivazioneInserita_Controller.slOrig = sl;
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
        
        // servizi aggiuntivi service log creation
        EOF_EAI_Service_Log__c sa = new EOF_EAI_Service_Log__c();
        sa.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
        sa.EOF_Codice_Ordine_OLO__c = c1.EOF_Codice_Ordine_OLO__c;
        sa.EOF_Data_Notifica__c= c1.EOF_Data_Notifica__c;
        sa.OF_SA_Servizi_Aggiuntivi_Log__c=sl.id;
        sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
        insert sa;
        // end servivi aggiuntivi service log creation
        OF_SA_GE_UtilsNew.caseOriginale=c1;
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamService_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('proc', 'errorInsertATT');
        
        test.startTest();
        PO_COMP_AttivazioneInserita_Controller pai = new PO_COMP_AttivazioneInserita_Controller();
        
        pai.inserisciVLAN();
        pai.editsl();
        pai.deletesl();
        pai.inserisciApparato();
        pai.inserisciServAgg();
        //pai.deleteVLAN();
        pai.editVLAN();
        //pai.deleteApparato();
        pai.editApparato();
        //pai.deleteServAgg();
        pai.editServAgg();
        pai.confermaRequest();
        pai.InoltraRequest();
        pai.annullaInoltro();
        pai.insNewReq();
        pai.goToRicIns();
        test.stopTest();
        
    }
    
}
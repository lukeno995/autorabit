@isTest
public class PO_COMP_DesosAnnulRimod_Ctrl_TEST {
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
        System.currentPageReference().getParameters().put('proc','desospensione');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.inoltraFlusso();
        dar.annullaFlusso();
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
        System.currentPageReference().getParameters().put('proc','desospensione');
        
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();  
        dar.inoltraFlusso();
        dar.annullaFlusso();
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
        sl.EOF_MOTIVAZIONE__c='test class';
        
        insert sl;
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
        System.currentPageReference().getParameters().put('proc', 'rimodulazioneDAC');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.inoltraFlusso();
        dar.annullaFlusso();
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
        System.currentPageReference().getParameters().put('proc', 'annullamento');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.inoltraFlusso();
        dar.annullaFlusso();
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
        //insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id); 
        /*
OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
tibco.OF_Tibco_ID__c='00558000001f743AAA';
tibco.name='Tibco UserID';
insert tibco;
*/
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
        spp.Name='Semaforo Proxy Portale Attivazione';
        spp.Semaforo_Proxy_Portale_Attivazione__c=true;
        spp.Semaforo_Proxy_Portale_Cessazione__c=true;
        insert spp;
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
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
        System.currentPageReference().getParameters().put('proc', 'annullamento');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.inoltraFlusso();
        dar.annullaFlusso();
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
        //insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id); 
        /*
OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
tibco.OF_Tibco_ID__c='00558000001f743AAA';
tibco.name='Tibco UserID';
insert tibco;
*/
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
        spp.Name='Semaforo Proxy Portale Attivazione';
        spp.Semaforo_Proxy_Portale_Attivazione__c=true;
        spp.Semaforo_Proxy_Portale_Cessazione__c=true;
        insert spp;
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
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
        sl.OF_SA_Interfaccia_OM__c='Nuova IF';
        sl.EOF_MOTIVAZIONE__c='D13 - Motivi Cliente';
        
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
        System.currentPageReference().getParameters().put('proc', 'rimodulazioneDAC');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.inoltraFlusso();
        dar.annullaFlusso();
        test.stopTest();
        
        
    }
    
    public static testmethod void test7(){
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
        //insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id); 
        /*
OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
tibco.OF_Tibco_ID__c='00558000001f743AAA';
tibco.name='Tibco UserID';
insert tibco;
*/
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
        spp.Name='Semaforo Proxy Portale Attivazione';
        spp.Semaforo_Proxy_Portale_Attivazione__c=true;
        spp.Semaforo_Proxy_Portale_Cessazione__c=true;
        insert spp;
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
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
        c1.status = 'Accettato';
        c1.EOF_FASE__C = 'In Lavorazione';
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
        sl.OF_SA_Interfaccia_OM__c='Nuova IF';
        sl.EOF_MOTIVAZIONE__c='D13 - Motivi Cliente';
        
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
        System.currentPageReference().getParameters().put('proc', 'desospensione');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.inoltraFlusso();
        dar.annullaFlusso();
        test.stopTest();
        
        //desospensione
    }
    
    public static testmethod void test8(){
        
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
        //insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id); 
        /*
OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
tibco.OF_Tibco_ID__c='00558000001f743AAA';
tibco.name='Tibco UserID';
insert tibco;
*/
        Semaforo_Proxy_Portale__c spp = new Semaforo_Proxy_Portale__c();
        spp.Name='Semaforo Proxy Portale Attivazione';
        spp.Semaforo_Proxy_Portale_Attivazione__c=true;
        spp.Semaforo_Proxy_Portale_Cessazione__c=true;
        insert spp;
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
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
        c1.status = 'Accettato';
        c1.EOF_FASE__C = 'In Lavorazione';
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
        // sl.OF_SA_Interfaccia_OM__c='Nuova IF';
        sl.EOF_MOTIVAZIONE__c='D13 - Motivi Cliente';
        
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
        System.currentPageReference().getParameters().put('proc', 'rimodulazioneDAC');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.sl= sl;
        //dar.rimodula=true;
        dar.inoltraFlusso();
        dar.annullaFlusso();
        test.stopTest();
        
        
    }
    
    public static testmethod void test9(){
        
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
        sl.EOF_MOTIVAZIONE__c='D13 - Motivi Cliente';
        
        insert sl;
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
        System.currentPageReference().getParameters().put('proc', 'rimodulazioneDAC');
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.rimodula = true;
        dar.inoltraFlusso();
        dar.annullaFlusso();
        test.stopTest();
        
    }
    
    public static testmethod void test10(){
        
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
        c.EOF_FASE__C = 'In Lavorazione';
        c.EOF_Data_Notifica__c= system.now();
        insert c;
        // end case creation
        
        
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - FiberRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Accettato';
        
        insert sl;
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
        System.currentPageReference().getParameters().put('proc', 'annullamento');
        
        
        test.startTest();
        PO_COMP_DesospAnnullRimod_controller dar = new PO_COMP_DesospAnnullRimod_controller();
        dar.annulla= true;
        dar.inoltraFlusso();
        //dar.annullaFlusso();
        test.stopTest();
        
    }     
}
@isTest
public class OF_TTM_EntryChecks_Test1 {
    
    
    public static testmethod void method1(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= 'Disservizio';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= ' ';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = 'Disservizio';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
		test.stoptest();
        
	}
    
     public static testmethod void method2(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_COMUNICAZIONE_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
     }   
    
    public static testmethod void method3(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CATEGORIA_GUASTO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method4(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.ID_NOTIFICA = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method5(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.ID_RISORSA = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method6(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.TIPO_COMUNICAZIONE = '9';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method7(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.TIPO_COMUNICAZIONE = '6';
        tt.CAUSALE_DESOSPENSIONE = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method8(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.TIPO_COMUNICAZIONE = '1';
        tt.CAUSALE_APERTURA = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method9(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.TIPO_COMUNICAZIONE = '50';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method10(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_COMUNICAZIONE_OLO = 'ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
  public static testmethod void method11(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.ID_NOTIFICA = 'ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method12(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
		 
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
		
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
        tt.ID_RISORSA = 'tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    
     public static testmethod void method13(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '1';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        //Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
         
        tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
   public static testmethod void method14(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '11';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = '0';
        insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
		test.starttest();
		OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

       // Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
       // Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST());
        
		tt.NOME_REFERENTE_TECNICO_OLO= '';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= ' ';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
       
        tt.CATEGORIA_GUASTO = '';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
   public static testmethod void method15A(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '6';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Chiuso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '6';
        
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.Status = 'Chiuso';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
      /**  tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.Status = 'Sospeso';
        tt.NOTE = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF); **/
        
		test.stoptest();
        
	}
    
     public static testmethod void method15B(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '6';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        //c.Status = 'Chiuso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.Status = 'Sospeso';
        c.OF_Retry_Automatico__c = True;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '6';
        
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
         
        tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.Status = 'Sospeso';
        c.OF_Retry_Automatico__c = True;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        
      /**  tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.Status = 'Sospeso';
        tt.NOTE = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF); **/
        
		test.stoptest();
        
	}
    
    public static testmethod void method15C(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '6';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        //c.Status = 'Chiuso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.Status = 'Sospeso';
        c.EOF_GPON_Attestazione__c = '';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '6';
        
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.EOF_GPON_Attestazione__c = '';
        tt.COGNOME_CLIENTE = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.EOF_GPON_Attestazione__c = '';
        tt.COGNOME_CLIENTE = 'Test';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
      /**  tt.DATA_ORA_DESOSPENSIONE = '2018-12-19T12:00:00+01:00';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.REFERENTE_DESOSPENSIONE = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.Status = 'Sospeso';
        tt.NOTE = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF); **/
        
		test.stoptest();
        
	}
    
    
    public static testmethod void method16A(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '9';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'In Lavorazione';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_Data_Max_Risoluzione_Ticket__c = system.today() + 5;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '9';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);

        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'In Lavorazione';
        tt.NOTE = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'In Lavorazione';
        tt.NOTE = '';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);

        
		test.stoptest();
        
	}
    
    public static testmethod void method16B(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '9';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'In Lavorazione';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '9';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);

        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'In Lavorazione';
        tt.NOTE = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        

        
		test.stoptest();
        
	}
    
    public static testmethod void method16C(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '9';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'In Lavorazione';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_Data_Max_Risoluzione_Ticket__c = system.today() + 5;
        c.EOF_Rischedulazione_Appuntamento__c = System.today() + 5;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '9';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);

        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'In Lavorazione';
        tt.NOTE = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'In Lavorazione';
        tt.NOTE = '';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        c.EOF_Rischedulazione_Appuntamento__c = System.today() + 5;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);

        
		test.stoptest();
        
	}
    
    public static testmethod void method16D(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '9';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'In Lavorazione';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '9';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);

        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'In Lavorazione';
        tt.NOTE = 'Test';
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        

        
		test.stoptest();
        
	}
    
    
    public static testmethod void method16E(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '9';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'In Lavorazione';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
         c.OF_Retry_Automatico__c = true;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '9';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.OF_Retry_Automatico__c = True;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);

        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'In Lavorazione';
        tt.NOTE = 'Test';
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
        c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        

        
		test.stoptest();
        
	}
    
    
    
     public static testmethod void method17A(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '8';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '8';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        tt.NOTE = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
		test.stoptest();
        
	}
     public static testmethod void method17B(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '8';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '8';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        tt.NOTE = 'Test';
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
		test.stoptest();
        
	}
    
    public static testmethod void method17C(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '8';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Sospeso';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.OF_Retry_Automatico__c = True;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '8';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '';
        c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.OF_Retry_Automatico__c = True;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.Status = 'Sospeso';
        tt.DATA_ORA_AUTORIPRISTINATO = '2018-07-19T12:00:00+01:00';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        tt.NOTE = 'Test';
        c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
		test.stoptest();
        
	}
    
    public static testmethod void method17D(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '8';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '8';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
		test.stoptest();
        
	}
     public static testmethod void method18A(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '12';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		//tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '12';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'test';
        c.Status = 'Richiesta Chiusura';
        tt.INTERVENTO_CONGIUNTO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
         
         
         
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method18B(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '12';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '12';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
         
         
         
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = '';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
     public static testmethod void method18C(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '12';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
         c.EOF_COmunicazioni_con_OLO__C = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '12';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
         
         
         
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'Richiesta Chiusura';
        c.EOF_COmunicazioni_con_OLO__C = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method18D(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '12';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        c.EOF_Rischedulazione_Appuntamento__c = System.today() + 5;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '12';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
         
         
         
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = '';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        c.EOF_Rischedulazione_Appuntamento__c = System.today() + 5;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    public static testmethod void method18E(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '12';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '12';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         

        tt.NOTE = 'Test';
        c.Status = 'Richiesta Chiusura';
        tt.INTERVENTO_CONGIUNTO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        
		test.stoptest();
        
	}
    
    public static testmethod void method18F(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '12';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		//tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
         c.OF_Retry_Automatico__c = True;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '12';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = '';
        c.Status = 'Richiesta Chiusura';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'test';
        c.Status = 'Richiesta Chiusura';
        tt.INTERVENTO_CONGIUNTO = '';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = '';
        c.Status = 'Richiesta Chiusura';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        c.Status = 'Richiesta Chiusura';
         c.OF_Retry_Automatico__c = false;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'Richiesta Chiusura';
        c.OF_Retry_Automatico__c = True;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
         
        tt.NOTE = 'Test';
        tt.INTERVENTO_CONGIUNTO = 'Test';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        c.Status = 'Richiesta Chiusura';
         c.OF_Retry_Automatico__c = false;
        c.EOF_Data_Max_Risoluzione_Ticket__c = System.today() + 5;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
		test.stoptest();
        
	}
    
    
    public static testmethod void method19A(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '11';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		//tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.status ='Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '11';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Chiuso';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        
		test.stoptest();
        
	}
    
    public static testmethod void method19B(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '11';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.status ='Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '11';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Chiuso';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        tt.NOTE = 'test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
		test.stoptest();
        
	}
  
    public static testmethod void method19C(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '11';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.status ='Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.EOF_Comunicazioni_con_OLO__c = 'Test';
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '11';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Chiuso';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        tt.NOTE = 'test';
        c.EOF_Comunicazioni_con_OLO__c = 'Test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
		test.stoptest();
        
	}
    
     
    public static testmethod void method19D(){
	
	    OF_SA_GE_Utils.rtMap=new map<String,String>();
	    for(recordtype rt : [select id,developername from recordtype]){
	        OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
	    }
        
        Map<String,Id> rtMap = new Map<String,Id>(); 
        for(recordtype rt : [select id,developername from recordtype]){
        	rtMap.put(rt.developername,rt.id);
        }
        
        OF_TT_WS_TroubleTicketRequest.troubleTicket tt =new OF_TT_WS_TroubleTicketRequest.troubleTicket();
		tt.TIPO_COMUNICAZIONE= '11';
		tt.CODICE_OPERATORE= 'VF';
		//tt.CODICE_COMUNICAZIONE_OLO='TEST_TTM_v0x106';
		tt.CATEGORIA_GUASTO= '0';
		tt.ID_RISORSA= 'Asset20180611_v4';
		tt.ID_NOTIFICA= 'TT_Att_0031';
		tt.DATA_ORA_INIZIO_GUASTO= '2018-07-16T11:15:00+01:00';
		tt.NOME_CLIENTE='GIACOMO' ;
		tt.COGNOME_CLIENTE= 'LEOPARDI';
		tt.RECAPITO_TELEFONICO_CLIENTE_1= '3289575977';
		tt.RECAPITO_TELEFONICO_CLIENTE_2= '123456789';
		tt.NOME_REFERENTE_TECNICO_OLO= 'Antonio Marco';
		tt.TELEFONO_REFERENTE_TECNICO_OLO= '3269696966';
		tt.EMAIL_REFERENTE_TECNICO_OLO= 'Marco.rossi@test.it';
		tt.DESCRIZIONE_PROBLEMA= 'cliente non naviga';
		tt.NOTE_CLIENTE= 'ciao';
		tt.NOTE= 'test';
		tt.CAUSALE_APERTURA= '4';
		tt.INTERVENTO_CONGIUNTO='N';
		tt.DATA_ORA_INTERVENTO_CONGIUNTO ='2018-07-19T12:00:00+01:00';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.COGNOME_CLIENTE = '';
            
		
		account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        insert accOLO;
        
        //-------Case Creation-------------
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.status ='Richiesta Chiusura';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test sasya1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = accOLO;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        //c.RecordTypeId = CaseRecordTypeId;
        c.RecordTypeId = rtMap.get('Trouble_Ticket');
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_GPON_Attestazione__c = '';
        c.EOF_categoria_guasto__c = 'Disservizio';
        c.EOF_Codice_Comunicazione_OLO__c = 'Test';
        c.EOF_codice_Operatore_WS__c = 'WN';
        //C.EOF_categoria_guasto__c = '2';
        c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_GPON_Attestazione__c = 'Test';
        c.OF_Retry_Automatico__c = True;
        //insert c;
        
        String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_CLUSTER_PROMOZIONE__c = '123456';
        eaiLog1.EOF_Codice_Operatore__c = 'TIS';
        eaiLog1.EOF_Codice_Ordine_EOF__c = c.id;
        eaiLog1.EOF_Codice_Ordine_OLO__c = 'TEST_CE_16:55:06';
        eaiLog1.recordTypeId = eaiRecordType1;
        eaiLog1.OF_SA_ACK__c = true;
        eaiLog1.EOF_Data_Notifica__c = dateTime.now();
        eaiLog1.EOF_ID_Notifica__c = 'ID_178239';
        eaiLog1.EOF_ID_Risorsa__c = 'F3000010405';
        eaiLog1.EOF_ID_SERVIZIO__c = 'AAA0017481';
        eaiLog1.EOF_PROFILO__c = 'AG_11_36';
        eaiLog1.EOF_PROMOZIONE__c = '020103';
        eaiLog1.EOF_Response__c = 'ACK';
        eaiLog1.EOF_Tipo_Comunicazione_String__c = 'SF->OM - ChangeOrderRequest';
        eaiLog1.EOF_Tipo_Comunicazione__c = '15';
        eaiLog1.EOF_Stato_Richiesta__c = 'In Inserimento';
        eaiLog1.recordtypeId=rtMap.get('TroubleTicketRequest');
        eaiLog1.EOF_Data_Ora_Scarto__c = System.today();
        eaiLog1.EOF_Data_Ora_Creazione__c = System.today(); 
        eaiLog1.EOF_Data_Ora_Notifica_Sospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Desospensione__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Annullamento__c = System.today();
        eaiLog1.EOF_Data_Ora_Notifica_Chiusura__c = System.today();
        eaiLog1.Causale_Scarto__c = 'Test';
        eaiLog1.EOF_Descrizione_Causale_Scarto__c = 'Test';
        eaiLog1.Causale_Sospensione__c = 'Cliente Indisponibile';
        eaiLog1.EOF_Referente_desospensione__c = 'Test';
        eaiLog1.Descrizione_Evento_Risoluzione__c = 'Descrizione_Evento_Risoluzione__c';
        eaiLog1.EOF_Rischedulazione_Appuntamento__c = System.today();
        eaiLog1.EOF_Intervento_Congiunto__c = 'Y';
        eaiLog1.EOF_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Tel_Tec_Eof__c = 'Test';
        eaiLog1.EOF_Data_Ora_Intervento_Congiunto__c = System.today();
        eaiLog1.EOF_Richiesta_Notifica__c = 'TIPO_COMUNICAZIONE: 15 CODICE_OPERATORE: TIS CODICE_ORDINE_OLO: TEST_ANI_23 CODICE_ORDINE_OF: 5008E00000An5McQAJ DATA_NOTIFICA: 2018-05-28 09:20:30 ID_NOTIFICA: ID_123456 ID_RISORSA: F3000010405 CODICE_PROGETTO_SPECIALE: null PROMOZIONE: P_12 CLUSTER_PROMOZIONE: 123456 NOTE: TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream PROFILO: AG_11_36 VLAN 1: KIT_CONSEGNA_VLAN: TIS_MI_1 USER_VLAN: 089 SERVICE_VLAN: 210 PROFILO_VLAN: AG12 INFORMAZIONI_VLAN: null CUSTOMER_VLAN: 123 MODELLO_DI_SERVIZIO_VLAN: 1:1';
        insert eaiLog1;
		
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today());
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
       	asset a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='Asset20180611_v4';
        a.name='Asset20180611_v4';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        insert a;
        
		OF_TTM_Utils.sLogOLOSF = OF_TTM_Utils.create_Eai_log(tt);
		insert OF_TTM_Utils.sLogOLOSF;
        
        List<Case> caseList = new List<Case>();
        caseList.add(c);
        insert caseList;
        OF_TTM_EntryChecks.case_tmp_list = caseList;
        
		test.starttest();
		
       /** 
		tt.NOME_REFERENTE_TECNICO_OLO= 'Test';
		OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        tt.CODICE_OPERATORE= 'Test';
        tt.CAUSALE_DESOSPENSIONE = '2';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.CATEGORIA_GUASTO = '2';
        tt.RECAPITO_TELEFONICO_CLIENTE_1 = ''; **/
        tt.CODICE_OPERATORE = 'Test1';
        tt.CODICE_COMUNICAZIONE_OLO = 'Test';
        tt.CATEGORIA_GUASTO = '0';
        tt.ID_NOTIFICA = 'Test1';
        tt.ID_RISORSA = 'Test';
        tt.TIPO_COMUNICAZIONE= '9';
        tt.CAUSALE_DESOSPENSIONE = '2';
        tt.TIPO_COMUNICAZIONE= '1';
        tt.Codice_operatore = 'WN';
        
        tt.TIPO_COMUNICAZIONE= '11';
        tt.DATA_ORA_DESOSPENSIONE = '2018-07-19T12:00:00+01:00';
        tt.CAUSALE_RICHIESTA_ANNULLAMENTO = 'Test';
        tt.DATA_ORA_RICHIESTA_ANNULLAMENTO = '2018-07-19T12:00:00+01:00';
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;

        //Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TTM_EntryChecks_Mock());
        
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = '';
        c.OF_Retry_Automatico__c = False;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = '';
        c.OF_Retry_Automatico__c = False;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = '';
        c.OF_Retry_Automatico__c = False;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Chiuso';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.OF_Retry_Automatico__c = False;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.OF_Retry_Automatico__c = True;
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
        c.status ='Richiesta Chiusura';
        tt.NOME_REFERENTE_TECNICO_OLO = 'Test';
        tt.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        tt.EMAIL_REFERENTE_TECNICO_OLO = 'Marco.rossi@test.it';
        c.OF_Retry_Automatico__c = False;
        tt.NOTE = 'test';
        OF_TTM_EntryChecks.PORTAL_checkSync(tt,OF_TTM_Utils.sLogOLOSF);
        
		test.stoptest();
        
	}
}
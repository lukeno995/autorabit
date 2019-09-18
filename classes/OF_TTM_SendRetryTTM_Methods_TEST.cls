@isTest
public class OF_TTM_SendRetryTTM_Methods_TEST {
  @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    public static testmethod void test1(){
        
        OF_TTM_Utils.RTMap = new  map<String,String>();

        for(recordtype rt : [select id,developername from recordtype]){
           OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
        }


        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTypeId = OF_TTM_Utils.RTMap.get('OLO') ;
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
        
        
        case c5 = new case();
        
        c5.EOF_Account_OLO__c = accOLO.Id;
        c5.Subject = 'Richiesta Risoluzione Guasto';
        c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';    
        c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c5.Status = 'In Lavorazione';
        c5.EOF_Fase__c = 'In lavorazione';
        c5.Type = '1';
        c5.EOF_Tipologia_Servizio__c = 'test';
        c5.EOF_Codice_Operatore_WS__c = 'VF';
        c5.EOF_SLA_Premium_Assurance__c ='N';
        c5.EOF_Causale_Apertura__c='';
        c5.EOF_Intervento_Congiunto__c='N';
        c5.RecordTypeId = OF_TTM_Utils.RTMap.get('Trouble_Ticket');
        c5.EOF_Id_Notifica__c = 'test_01';
        c5.Origin = 'Web';
        c5.Priority = 'Medium';
        c5.EOF_GPON_Vincolante__c = 'N';
        c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
        c5.EOF_Categoria_Guasto__C='Degrado';
        c5.EOF_Referente_Desospensione__c='';
        c5.OF_TroubleTicketManager__c= true;
        c5.OF_Response_Da_OLO__c ='';
        c5.OF_Response_da_TTM__c ='';
        c5.Staging_retry__c = 0;
        
        insert c5;      
        
        test.startTest();
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
           
        Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST()); 
        
        
        OF_TTM_SendRetryTTM_Methods.retryCalloutToTTM(c5.id);
        
        test.stopTest();
    }
    
    
    public static testmethod void test2(){
        
        OF_TTM_Utils.RTMap = new  map<String,String>();

        for(recordtype rt : [select id,developername from recordtype]){
           OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
        }


        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTypeId = OF_TTM_Utils.RTMap.get('OLO') ;
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
        
        
        case c5 = new case();
        
        c5.EOF_Account_OLO__c = accOLO.Id;
        c5.Subject = 'Richiesta Risoluzione Guasto';
        c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';    
        c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c5.Status = 'In Lavorazione';
        c5.EOF_Fase__c = 'In lavorazione';
        c5.Type = '1';
        c5.EOF_Tipologia_Servizio__c = 'test';
        c5.EOF_Codice_Operatore_WS__c = 'VF';
        c5.EOF_SLA_Premium_Assurance__c ='N';
        c5.EOF_Causale_Apertura__c='';
        c5.EOF_Intervento_Congiunto__c='N';
        c5.RecordTypeId = OF_TTM_Utils.RTMap.get('Trouble_Ticket');
        c5.EOF_Id_Notifica__c = 'test_01';
        c5.Origin = 'Web';
        c5.Priority = 'Medium';
        c5.EOF_GPON_Vincolante__c = 'N';
        c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
        c5.EOF_Categoria_Guasto__C='Degrado';
        c5.EOF_Referente_Desospensione__c='';
        c5.OF_TroubleTicketManager__c= true;
        //c5.OF_Response_Da_OLO__c ='';
        c5.OF_Response_Da_OLO__c ='NACK TECNICO';
        c5.OF_Response_da_TTM__c ='NACK TECNICO';
        c5.Staging_retry__c = 0;
        
        insert c5; 
        
        
        EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
            
        TTlog.recordtypeId= OF_TTM_Utils.rtMap.get('TroubleTicketRequest');            
        TTlog.EOF_Codice_Comunicazione_OLO__c = c5.EOF_CODICE_COMUNICAZIONE_OLO__c;                   
        TTlog.EOF_Codice_Operatore__c = c5.EOF_Codice_Operatore_WS__c;
        TTlog.EOF_Tipo_Comunicazione__c = '1';
        TTlog.EOF_Data_Notifica__c = c5.EOF_Data_Notifica__c;
        TTlog.EOF_ID_Notifica__c = c5.EOF_ID_NOTIFICA__c;                 
        TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
        TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        TTlog.EOF_Categoria_Guasto__c ='';
        TTlog.EOF_ID_Risorsa__c ='Asset20180611_v4';
        TTlog.EOF_Causale_Apertura__c ='';
        TTlog.EOF_Nome_Cliente__c ='Test';
        TTlog.EOF_COgnome_CLiente__c ='';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
        TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
        TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
        TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
        TTlog.EOF_Verifica_apparato_cliente__c ='';
        TTlog.EOF_Descrizione_Problema__c ='';
        TTlog.EOF_NOTE__c ='';
        TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
        TTlog.EOF_Causale_Desospensione__c ='';
        TTlog.EOF_Referente_desospensione__c ='';
        TTlog.EOF_NOTE_CLIENTE__c ='';
        TTlog.EOF_Intervento_Congiunto__c ='';
        TTlog.Causale_Scarto__c ='';
        TTlog.EOF_Descrizione_Causale_Scarto__c ='';
        TTlog.Causale_Sospensione__c ='';
        TTlog.Descrizione_Evento_Risoluzione__c ='';
        TTlog.EOF_Tec_Eof__c ='';
        TTlog.EOF_Tel_Tec_Eof__c ='';
        TTlog.EOF_STATO_ORDINE__c='';
        TTlog.EOF_Response__c='NACK TECNICO';
        TTlog.Caso__c = c5.id;
        TTlog.Ordine_retry__c =1;
        //TTlog.EOF_Tipo_Comunicazione_String__c = '%OLO%';
        insert TTlog;         
            
        
        test.startTest();
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = true;
           
        Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST()); 
        
        
        OF_TTM_SendRetryTTM_Methods.retryCalloutToTTM(c5.id);
        
        test.stopTest();
    }
    
    public static testmethod void test3(){
        
        OF_TTM_Utils.RTMap = new  map<String,String>();

        for(recordtype rt : [select id,developername from recordtype]){
           OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
        }

//test.startTest();
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTypeId = OF_TTM_Utils.RTMap.get('OLO') ;
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
        
        
        case c5 = new case();
        
        c5.EOF_Account_OLO__c = accOLO.Id;
        c5.Subject = 'Richiesta Risoluzione Guasto';
        c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';    
        c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c5.Status = 'In Lavorazione';
        c5.EOF_Fase__c = 'In lavorazione';
        c5.Type = '1';
        c5.EOF_Tipologia_Servizio__c = 'test';
        c5.EOF_Codice_Operatore_WS__c = 'VF';
        c5.EOF_SLA_Premium_Assurance__c ='N';
        c5.EOF_Causale_Apertura__c='';
        c5.EOF_Intervento_Congiunto__c='N';
        c5.RecordTypeId = OF_TTM_Utils.RTMap.get('Trouble_Ticket');
        c5.EOF_Id_Notifica__c = 'test_01';
        c5.Origin = 'Web';
        c5.Priority = 'Medium';
        c5.EOF_GPON_Vincolante__c = 'N';
        c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
        c5.EOF_Categoria_Guasto__C='Degrado';
        c5.EOF_Referente_Desospensione__c='';
        c5.OF_TroubleTicketManager__c= true;
       // c5.OF_Response_Da_OLO__c ='';
        c5.OF_Response_da_TTM__c ='NACK TECNICO';
        c5.Staging_retry__c = 0;
        c5.OF_Response_Da_OLO__c = 'ACK';
        insert c5; 
        
        
        EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
            
        TTlog.recordtypeId= OF_TTM_Utils.rtMap.get('TroubleTicketRequest');            
        TTlog.EOF_Codice_Comunicazione_OLO__c = c5.EOF_CODICE_COMUNICAZIONE_OLO__c;                   
        TTlog.EOF_Codice_Operatore__c = c5.EOF_Codice_Operatore_WS__c;
        TTlog.EOF_Tipo_Comunicazione__c = '1';
        TTlog.EOF_Data_Notifica__c = c5.EOF_Data_Notifica__c;
        TTlog.EOF_ID_Notifica__c = c5.EOF_ID_NOTIFICA__c;                 
        TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
        TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        TTlog.EOF_Categoria_Guasto__c ='';
        TTlog.EOF_ID_Risorsa__c ='Asset20180611_v4';
        TTlog.EOF_Causale_Apertura__c ='';
        TTlog.EOF_Nome_Cliente__c ='Test';
        TTlog.EOF_COgnome_CLiente__c ='';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
        TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
        TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
        TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
        TTlog.EOF_Verifica_apparato_cliente__c ='';
        TTlog.EOF_Descrizione_Problema__c ='';
        TTlog.EOF_NOTE__c ='';
        TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
        TTlog.EOF_Causale_Desospensione__c ='';
        TTlog.EOF_Referente_desospensione__c ='';
        TTlog.EOF_NOTE_CLIENTE__c ='';
        TTlog.EOF_Intervento_Congiunto__c ='';
        TTlog.Causale_Scarto__c ='';
        TTlog.EOF_Descrizione_Causale_Scarto__c ='';
        TTlog.Causale_Sospensione__c ='';
        TTlog.Descrizione_Evento_Risoluzione__c ='';
        TTlog.EOF_Tec_Eof__c ='';
        TTlog.EOF_Tel_Tec_Eof__c ='';
        TTlog.EOF_STATO_ORDINE__c='';
        TTlog.EOF_Response__c='NACK TECNICO';
        TTlog.Caso__c = c5.id;
        TTlog.Ordine_retry__c =1;
        insert TTlog;         
            
        OF_TTM_Utils.caseOriginale = c5;
        
          
        
        
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = false;
        test.startTest();
        Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        Test.setMock(WebServiceMock.class, new OF_TT_WS_Sincronizzazione_TEST()); 
                
        OF_TTM_SendRetryTTM_Methods.retryCalloutToTTM(c5.id);
       // Test.setMock(WebServiceMock.class, new OF_TTM_SendRetryTTM_Methods_Mock());
       // OF_TTM_ForwardRequest.SyncPortTypeEndpoint1 stub = new OF_TTM_ForwardRequest.SyncPortTypeEndpoint1();      
        //  stub.ForwardTroubleTicket_TTM(TTlog);
       // OF_TTM_SendRetryTTM_Methods.makeRetryCalloutOLO(TTlog);
        
        test.stopTest();
    }  
    
            
         public static testmethod void test4(){
        
        OF_TTM_Utils.RTMap = new  map<String,String>();

        for(recordtype rt : [select id,developername from recordtype]){
           OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
        }

//test.startTest();
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTypeId = OF_TTM_Utils.RTMap.get('OLO') ;
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
        
        
        case c5 = new case();
        
        c5.EOF_Account_OLO__c = accOLO.Id;
        c5.Subject = 'Richiesta Risoluzione Guasto';
        c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';    
        c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c5.Status = 'In Lavorazione';
        c5.EOF_Fase__c = 'In lavorazione';
        c5.Type = '1';
        c5.EOF_Tipologia_Servizio__c = 'test';
        c5.EOF_Codice_Operatore_WS__c = 'VF';
        c5.EOF_SLA_Premium_Assurance__c ='N';
        c5.EOF_Causale_Apertura__c='';
        c5.EOF_Intervento_Congiunto__c='N';
        c5.RecordTypeId = OF_TTM_Utils.RTMap.get('Trouble_Ticket');
        c5.EOF_Id_Notifica__c = 'test_01';
        c5.Origin = 'Web';
        c5.Priority = 'Medium';
        c5.EOF_GPON_Vincolante__c = 'N';
        c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
        c5.EOF_Categoria_Guasto__C='Degrado';
        c5.EOF_Referente_Desospensione__c='';
        c5.OF_TroubleTicketManager__c= true;
       // c5.OF_Response_Da_OLO__c ='';
        c5.OF_Response_da_TTM__c ='NACK TECNICO';
        c5.Staging_retry__c = 0;
        c5.OF_Response_Da_OLO__c = 'ACK';
        insert c5; 
        
        
        
        EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
            
        TTlog.recordtypeId= OF_TTM_Utils.rtMap.get('TroubleTicketRequest');            
        TTlog.EOF_Codice_Comunicazione_OLO__c = c5.EOF_CODICE_COMUNICAZIONE_OLO__c;                   
        TTlog.EOF_Codice_Operatore__c = c5.EOF_Codice_Operatore_WS__c;
        TTlog.EOF_Tipo_Comunicazione__c = '1';
        TTlog.EOF_Data_Notifica__c = c5.EOF_Data_Notifica__c;
        TTlog.EOF_ID_Notifica__c = c5.EOF_ID_NOTIFICA__c;                 
        TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
        TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        TTlog.EOF_Categoria_Guasto__c ='';
        TTlog.EOF_ID_Risorsa__c ='Asset20180611_v4';
        TTlog.EOF_Causale_Apertura__c ='';
        TTlog.EOF_Nome_Cliente__c ='Test';
        TTlog.EOF_COgnome_CLiente__c ='';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
        TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
        TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
        TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
        TTlog.EOF_Verifica_apparato_cliente__c ='';
        TTlog.EOF_Descrizione_Problema__c ='';
        TTlog.EOF_NOTE__c ='';
        TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
        TTlog.EOF_Causale_Desospensione__c ='';
        TTlog.EOF_Referente_desospensione__c ='';
        TTlog.EOF_NOTE_CLIENTE__c ='';
        TTlog.EOF_Intervento_Congiunto__c ='';
        TTlog.Causale_Scarto__c ='';
        TTlog.EOF_Descrizione_Causale_Scarto__c ='';
        TTlog.Causale_Sospensione__c ='';
        TTlog.Descrizione_Evento_Risoluzione__c ='';
        TTlog.EOF_Tec_Eof__c ='';
        TTlog.EOF_Tel_Tec_Eof__c ='';
        TTlog.EOF_STATO_ORDINE__c='';
        TTlog.EOF_Response__c='NACK TECNICO';
        TTlog.Caso__c = c5.id;
        TTlog.Ordine_retry__c =1;
        insert TTlog;         
            
        OF_TTM_Utils.caseOriginale = c5;
        
          test.starttest();
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = false;
        
       
        Test.setMock(WebServiceMock.class, new OF_TTM_SendRetryTTM_Methods_Mock());
      
        OF_TTM_SendRetryTTM_Methods.makeRetryCalloutTTM(TTlog);
        
        test.stopTest();
    } 
             public static testmethod void test5(){
        
        OF_TTM_Utils.RTMap = new  map<String,String>();

        for(recordtype rt : [select id,developername from recordtype]){
           OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
        }

//test.startTest();
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTypeId = OF_TTM_Utils.RTMap.get('OLO') ;
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
        
        
        case c5 = new case();
        
        c5.EOF_Account_OLO__c = accOLO.Id;
        c5.Subject = 'Richiesta Risoluzione Guasto';
        c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';    
        c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c5.Status = 'In Lavorazione';
        c5.EOF_Fase__c = 'In lavorazione';
        c5.Type = '1';
        c5.EOF_Tipologia_Servizio__c = 'test';
        c5.EOF_Codice_Operatore_WS__c = 'VF';
        c5.EOF_SLA_Premium_Assurance__c ='N';
        c5.EOF_Causale_Apertura__c='';
        c5.EOF_Intervento_Congiunto__c='N';
        c5.RecordTypeId = OF_TTM_Utils.RTMap.get('Trouble_Ticket');
        c5.EOF_Id_Notifica__c = 'test_01';
        c5.Origin = 'Web';
        c5.Priority = 'Medium';
        c5.EOF_GPON_Vincolante__c = 'N';
        c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
        c5.EOF_Categoria_Guasto__C='Degrado';
        c5.EOF_Referente_Desospensione__c='';
        c5.OF_TroubleTicketManager__c= true;
       // c5.OF_Response_Da_OLO__c ='';
        c5.OF_Response_da_TTM__c ='NACK TECNICO';
        c5.Staging_retry__c = 0;
        c5.OF_Response_Da_OLO__c = 'ACK';
        insert c5; 
        
        
        
        EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
            
        TTlog.recordtypeId= OF_TTM_Utils.rtMap.get('TroubleTicketRequest');            
        TTlog.EOF_Codice_Comunicazione_OLO__c = c5.EOF_CODICE_COMUNICAZIONE_OLO__c;                   
        TTlog.EOF_Codice_Operatore__c = c5.EOF_Codice_Operatore_WS__c;
        TTlog.EOF_Tipo_Comunicazione__c = '1';
        TTlog.EOF_Data_Notifica__c = c5.EOF_Data_Notifica__c;
        TTlog.EOF_ID_Notifica__c = c5.EOF_ID_NOTIFICA__c;                 
        TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
        TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        TTlog.EOF_Categoria_Guasto__c ='';
        TTlog.EOF_ID_Risorsa__c ='Asset20180611_v4';
        TTlog.EOF_Causale_Apertura__c ='';
        TTlog.EOF_Nome_Cliente__c ='Test';
        TTlog.EOF_COgnome_CLiente__c ='';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
        TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
        TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
        TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
        TTlog.EOF_Verifica_apparato_cliente__c ='';
        TTlog.EOF_Descrizione_Problema__c ='';
        TTlog.EOF_NOTE__c ='';
        TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
        TTlog.EOF_Causale_Desospensione__c ='';
        TTlog.EOF_Referente_desospensione__c ='';
        TTlog.EOF_NOTE_CLIENTE__c ='';
        TTlog.EOF_Intervento_Congiunto__c ='';
        TTlog.Causale_Scarto__c ='';
        TTlog.EOF_Descrizione_Causale_Scarto__c ='';
        TTlog.Causale_Sospensione__c ='';
        TTlog.Descrizione_Evento_Risoluzione__c ='';
        TTlog.EOF_Tec_Eof__c ='';
        TTlog.EOF_Tel_Tec_Eof__c ='';
        TTlog.EOF_STATO_ORDINE__c='';
        TTlog.EOF_Response__c='NACK TECNICO';
        TTlog.Caso__c = c5.id;
        TTlog.Ordine_retry__c =1;
        insert TTlog;         
            
        OF_TTM_Utils.caseOriginale = c5;
        
          test.starttest();
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = false;
        
       
        Test.setMock(WebServiceMock.class, new OF_TTM_SendRetryTTM_Methods_Mock1());
      
        OF_TTM_SendRetryTTM_Methods.makeRetryCalloutTTM(TTlog);
        
        test.stopTest();
    } 
    
      public static testmethod void test6(){
        
        OF_TTM_Utils.RTMap = new  map<String,String>();

        for(recordtype rt : [select id,developername from recordtype]){
           OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
        }

//test.startTest();
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTypeId = OF_TTM_Utils.RTMap.get('OLO') ;
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
        
        
        case c5 = new case();
        
        c5.EOF_Account_OLO__c = accOLO.Id;
        c5.Subject = 'Richiesta Risoluzione Guasto';
        c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';    
        c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c5.Status = 'In Lavorazione';
        c5.EOF_Fase__c = 'In lavorazione';
        c5.Type = '1';
        c5.EOF_Tipologia_Servizio__c = 'test';
        c5.EOF_Codice_Operatore_WS__c = 'VF';
        c5.EOF_SLA_Premium_Assurance__c ='N';
        c5.EOF_Causale_Apertura__c='';
        c5.EOF_Intervento_Congiunto__c='N';
        c5.RecordTypeId = OF_TTM_Utils.RTMap.get('Trouble_Ticket');
        c5.EOF_Id_Notifica__c = 'test_01';
        c5.Origin = 'Web';
        c5.Priority = 'Medium';
        c5.EOF_GPON_Vincolante__c = 'N';
        c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
        c5.EOF_Categoria_Guasto__C='Degrado';
        c5.EOF_Referente_Desospensione__c='';
        c5.OF_TroubleTicketManager__c= true;
       // c5.OF_Response_Da_OLO__c ='';
        c5.OF_Response_da_TTM__c ='NACK';
        c5.Staging_retry__c = 0;
        c5.OF_Response_Da_OLO__c = 'ACK';
        insert c5; 
        
        
        
        EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
            
        TTlog.recordtypeId= OF_TTM_Utils.rtMap.get('TroubleTicketRequest');            
        TTlog.EOF_Codice_Comunicazione_OLO__c = c5.EOF_CODICE_COMUNICAZIONE_OLO__c;                   
        TTlog.EOF_Codice_Operatore__c = c5.EOF_Codice_Operatore_WS__c;
        TTlog.EOF_Tipo_Comunicazione__c = '1';
        TTlog.EOF_Data_Notifica__c = c5.EOF_Data_Notifica__c;
        TTlog.EOF_ID_Notifica__c = c5.EOF_ID_NOTIFICA__c;                 
        TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
        TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        TTlog.EOF_Categoria_Guasto__c ='';
        TTlog.EOF_ID_Risorsa__c ='Asset20180611_v4';
        TTlog.EOF_Causale_Apertura__c ='';
        TTlog.EOF_Nome_Cliente__c ='Test';
        TTlog.EOF_COgnome_CLiente__c ='';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
        TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
        TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
        TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
        TTlog.EOF_Verifica_apparato_cliente__c ='';
        TTlog.EOF_Descrizione_Problema__c ='';
        TTlog.EOF_NOTE__c ='';
        TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
        TTlog.EOF_Causale_Desospensione__c ='';
        TTlog.EOF_Referente_desospensione__c ='';
        TTlog.EOF_NOTE_CLIENTE__c ='';
        TTlog.EOF_Intervento_Congiunto__c ='';
        TTlog.Causale_Scarto__c ='';
        TTlog.EOF_Descrizione_Causale_Scarto__c ='';
        TTlog.Causale_Sospensione__c ='';
        TTlog.Descrizione_Evento_Risoluzione__c ='';
        TTlog.EOF_Tec_Eof__c ='';
        TTlog.EOF_Tel_Tec_Eof__c ='';
        TTlog.EOF_STATO_ORDINE__c='';
        TTlog.EOF_Response__c='NACK TECNICO';
        TTlog.Caso__c = c5.id;
        TTlog.Ordine_retry__c =1;
        insert TTlog;         
            
        OF_TTM_Utils.caseOriginale = c5;
        
          test.starttest();
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = false;
        
       //Test.setMock(WebServiceMock.class, new OF_TTM_SendRetryTTM_Methods_Mock());
       // OF_TTM_SendRetryTTM_Methods.makeRetryCalloutTTM(TTlog);
        Test.setMock(WebServiceMock.class, new OF_TTM_SendRetryTTM_Methods_Mock2());
        OF_TTM_SendRetryTTM_Methods.makeRetryCalloutOLO(TTlog);
        
        test.stopTest();
    } 
    
                 public static testmethod void test7(){
        
        OF_TTM_Utils.RTMap = new  map<String,String>();

        for(recordtype rt : [select id,developername from recordtype]){
           OF_TTM_Utils.RTMap.put(rt.developername,rt.id);
        }

//test.startTest();
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTypeId = OF_TTM_Utils.RTMap.get('OLO') ;
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
        
        
        case c5 = new case();
        
        c5.EOF_Account_OLO__c = accOLO.Id;
        c5.Subject = 'Richiesta Risoluzione Guasto';
        c5.EOF_ID_Risorsa__c = 'Asset20180611_v4';    
        c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c5.Status = 'In Lavorazione';
        c5.EOF_Fase__c = 'In lavorazione';
        c5.Type = '1';
        c5.EOF_Tipologia_Servizio__c = 'test';
        c5.EOF_Codice_Operatore_WS__c = 'VF';
        c5.EOF_SLA_Premium_Assurance__c ='N';
        c5.EOF_Causale_Apertura__c='';
        c5.EOF_Intervento_Congiunto__c='N';
        c5.RecordTypeId = OF_TTM_Utils.RTMap.get('Trouble_Ticket');
        c5.EOF_Id_Notifica__c = 'test_01';
        c5.Origin = 'Web';
        c5.Priority = 'Medium';
        c5.EOF_GPON_Vincolante__c = 'N';
        c5.EOF_Codice_comunicazione_olo__c='TEST_TTM_v0x105';
        c5.EOF_Categoria_Guasto__C='Degrado';
        c5.EOF_Referente_Desospensione__c='';
        c5.OF_TroubleTicketManager__c= true;
       // c5.OF_Response_Da_OLO__c ='';
        c5.OF_Response_da_TTM__c ='NACK TECNICO';
        c5.Staging_retry__c = 0;
        c5.OF_Response_Da_OLO__c = 'ACK';
        insert c5; 
        
        
        
        EOF_EAI_Service_Log__c TTlog = new EOF_EAI_Service_Log__c ();
            
        TTlog.recordtypeId= OF_TTM_Utils.rtMap.get('TroubleTicketRequest');            
        TTlog.EOF_Codice_Comunicazione_OLO__c = c5.EOF_CODICE_COMUNICAZIONE_OLO__c;                   
        TTlog.EOF_Codice_Operatore__c = c5.EOF_Codice_Operatore_WS__c;
        TTlog.EOF_Tipo_Comunicazione__c = '1';
        TTlog.EOF_Data_Notifica__c = c5.EOF_Data_Notifica__c;
        TTlog.EOF_ID_Notifica__c = c5.EOF_ID_NOTIFICA__c;                 
        TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
        TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
        TTlog.EOF_Categoria_Guasto__c ='';
        TTlog.EOF_ID_Risorsa__c ='Asset20180611_v4';
        TTlog.EOF_Causale_Apertura__c ='';
        TTlog.EOF_Nome_Cliente__c ='Test';
        TTlog.EOF_COgnome_CLiente__c ='';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='12345678';
        TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='123456789';
        TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='Test';
        TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='12345678';
        TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='test@test.it';
        TTlog.EOF_Verifica_apparato_cliente__c ='';
        TTlog.EOF_Descrizione_Problema__c ='';
        TTlog.EOF_NOTE__c ='';
        TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
        TTlog.EOF_Causale_Desospensione__c ='';
        TTlog.EOF_Referente_desospensione__c ='';
        TTlog.EOF_NOTE_CLIENTE__c ='';
        TTlog.EOF_Intervento_Congiunto__c ='';
        TTlog.Causale_Scarto__c ='';
        TTlog.EOF_Descrizione_Causale_Scarto__c ='';
        TTlog.Causale_Sospensione__c ='';
        TTlog.Descrizione_Evento_Risoluzione__c ='';
        TTlog.EOF_Tec_Eof__c ='';
        TTlog.EOF_Tel_Tec_Eof__c ='';
        TTlog.EOF_STATO_ORDINE__c='';
        TTlog.EOF_Response__c='NACK TECNICO';
        TTlog.Caso__c = c5.id;
        TTlog.Ordine_retry__c =1;
        insert TTlog;         
            
        OF_TTM_Utils.caseOriginale = c5;
        
          test.starttest();
        
        OF_TTM_WS_IN_Notify_CalloutMock.isACK = false;
        
       
        Test.setMock(WebServiceMock.class, new OF_TTM_SendRetryTTM_Methods_Mock3());
      
         OF_TTM_SendRetryTTM_Methods.makeRetryCalloutOLO(TTlog);
        
        test.stopTest();
    }
    

 }
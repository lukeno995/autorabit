@isTest
public class OF_SA_CD_OLO_EntryChecks_TestNew {
    
    @testSetup
	public static void testSetUpData() {
        List<Stato_Building_positivi__c> lstCsPositivi = new List<Stato_Building_positivi__c>();
        
        Stato_Building_positivi__c state102 = new Stato_Building_positivi__c();
        	state102.Name = '102';
        lstCsPositivi.add(state102);
        
        Stato_Building_positivi__c state104 = new Stato_Building_positivi__c();
        	state104.Name = '104';
        lstCsPositivi.add(state104);        
        
        Stato_Building_positivi__c state105 = new Stato_Building_positivi__c();
        	state105.Name = '105';
        lstCsPositivi.add(state105);
        
        Stato_Building_positivi__c state107 = new Stato_Building_positivi__c();
        	state107.Name = '107';
        lstCsPositivi.add(state107);
        
        Stato_Building_positivi__c state109 = new Stato_Building_positivi__c();
        	state109.Name = '109';
        lstCsPositivi.add(state109);
        
        Stato_Building_positivi__c state110 = new Stato_Building_positivi__c();
        	state110.Name = '110';
        lstCsPositivi.add(state110);
        
        insert lstCsPositivi;
        
		List<Stato_Building_negativi__c> lstCsNegativi = new List<Stato_Building_negativi__c>();        
        
        Stato_Building_negativi__c stateN101 = new Stato_Building_negativi__c();
        	stateN101.Name = '101';
        lstCsNegativi.add(stateN101);
        
        Stato_Building_negativi__c stateN103 = new Stato_Building_negativi__c();
        	stateN103.Name = '103';
        lstCsNegativi.add(stateN103);
        
        Stato_Building_negativi__c stateN106 = new Stato_Building_negativi__c();
        	stateN106.Name = '106';
        lstCsNegativi.add(stateN106);
        
        Stato_Building_negativi__c stateN108 = new Stato_Building_negativi__c();
        	stateN108.Name = '108';
        lstCsNegativi.add(stateN108);
        
        insert lstCsNegativi;
		Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
		Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }

    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select developerName, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
		
		for(RecordType rt: rtypes)
    		RecordType.put(rt.developerName,rt.Id);
                
       return RecordType;
    }
 
  
     public static testMethod void MetodoSU1(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       
              
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_OPERATORE = '';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_ORDINE_OF = 'Test';
		
		StatReq.CODICE_ORDINE_OLO = 'TEST';
        
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = 'T';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
 
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();       
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        EsEl.ID_NOTIFICA = 'Test';
		EsEl.CODICE_MOTIVAZIONE = 'Test';
		EsEl.MOTIVAZIONE = 'Test';

        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        EsEl1.ID_NOTIFICA = 'Test';
		EsEl1.CODICE_MOTIVAZIONE = 'Test';
		EsEl1.MOTIVAZIONE = 'Test';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
     
     public static testMethod void MetodoSU2(){
        
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       
             
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = ' ';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		
        //StatReq.AZIONE = '';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        //StatReq.AZIONE = '1T';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        //StatReq.AZIONE = '�';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        //StatReq.AZIONE = 'T';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
 
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
        
    }
  
    public static testMethod void MetodoSU3(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       
             
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		//StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		
		
        StatReq.DATA_NOTIFICA = '';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
       
        
        StatReq.ID_NOTIFICA = 'Test';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
 
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
        
    }
    
    public static testMethod void MetodoSU4(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       
             
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		//StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		
		
        StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.ID_NOTIFICA = '';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ID_NOTIFICA = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ID_NOTIFICA = 'Test�';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
       // StatReq.ID_NOTIFICA = 'Test';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
       // StatReq.ID_NOTIFICA = 'Test';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
 
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
        
    }
  
    // base
    
    public static testMethod void Metodo1(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       
              
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = 'T';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
 
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();       
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        EsEl.ID_NOTIFICA = 'Test';
		EsEl.CODICE_MOTIVAZIONE = 'Test';
		EsEl.MOTIVAZIONE = 'Test';

        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        EsEl1.ID_NOTIFICA = 'Test';
		EsEl1.CODICE_MOTIVAZIONE = 'Test';
		EsEl1.MOTIVAZIONE = 'Test';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
        
    }
  
    // test azione 
    public static testMethod void Metodo4(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       
             
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		
        StatReq.AZIONE = '';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.AZIONE = '1T';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.AZIONE = '�';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.AZIONE = 'T';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
 
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
        
    }
    
    // test azione != 0 e != 1
    public static testMethod void Metodo5(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '2';
		StatReq.CODICE_MOTIVAZIONE = 'M';
		StatReq.MOTIVAZIONE = 'M';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = StatReq.CODICE_OPERATORE;
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
              
        Account acc = new Account();
        acc.name = StatReq.COGNOME_CLIENTE;
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = StatReq.codice_ordine_olo;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	//c.EOF_Contact__c = con.id;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
 		insert c;
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();               
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OLO_Response.Esito_element respTemp= stub.NotifyAggiornaStato(eoflst);
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }

    // test azione = 1 & codice motivazione
    public static testMethod void Metodo6(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
       
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
              
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        
        StatReq.CODICE_MOTIVAZIONE = '';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_MOTIVAZIONE = 'TTTT';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_MOTIVAZIONE = '�';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.CODICE_MOTIVAZIONE = 'T';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
     
    public static testMethod void Metodo7(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
               
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        
        StatReq.MOTIVAZIONE = '';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        // StatReq.MOTIVAZIONE = '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678909876555';
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.MOTIVAZIONE = '�';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.MOTIVAZIONE = 'T';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);

        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }

    // test case non a sistema
    public static testMethod void Metodo8(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	//insert c;
    	
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = 'T';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
 
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest(); 
    }

     
    // test azione = 1 & stato != Acquisito,Accettato,Sospeso
    public static testMethod void Metodo10(){
       
        Map<String,String> RecordTypeMap = RecordType();
       
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
           
        Account acc = new Account();
        acc.name = 'Test';
        // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Desospeso';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
    // test codice motivazione = � & azione = 0
    public static testMethod void Metodo11(){
       
        Map<String,String> RecordTypeMap = RecordType();
       
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
           
        Account acc = new Account();
        acc.name = 'Test';
        // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '0';
        StatReq.CODICE_MOTIVAZIONE = '�';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
    // test motivazione = � & azione = 0
    public static testMethod void Metodo12(){
       
        Map<String,String> RecordTypeMap = RecordType();
      
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            
        Account acc = new Account();
        acc.name = 'Test';
        // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
   
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Sospeso';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '0';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = '�';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
        
    // test azione = 0 & recapito telefonico cliente 1/2
    public static testMethod void Metodo13(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
 		insert c;
 		
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '0';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = '';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'TestTestTestTestTestTest';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
		
        StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();        
    }
        
    // test azione = 0 & orario appuntamento & data prevista attivazione
    public static testMethod void Metodo14(){
       
        Map<String,String> RecordTypeMap = RecordType();
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
     
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
        Account acc = new Account();
        acc.name = 'Test';
        // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '0';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		
        StatReq.DATA_PREVISTA_ATTIVAZIONE = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15z';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.ORARIO_APPUNTAMENTO = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ORARIO_APPUNTAMENTO = '10:00:00z';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();
    }
    
    // test nome cliente = � & azione = 1
    public static testMethod void Metodo15(){
       
        Map<String,String> RecordTypeMap = RecordType();
        
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
       
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
              
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test�';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();        
    }
    
    // test cognome cliente = � & azione = 1
    public static testMethod void Metodo16(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
       
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test�';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();        
    }
   
	// test recapito telefonico cliente 1 = � & azione = 1
    public static testMethod void Metodo17(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
       
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
             
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
    
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test�';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();
    }
	 
	// test recapito telefonico cliente 2 = � & azione = 1
    public static testMethod void Metodo18(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
       
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
              
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test�';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest();
    }
	 
	//test data prevista attivazione = � & azione = 1
    public static testMethod void Metodo19(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11�15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
                
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
    // test orario appuntamento = � & azione = 1
    public static testMethod void Metodo20(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00�00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    // test note = � & azione = 1
    public static testMethod void Metodo21(){
       
        Map<String,String> RecordTypeMap = RecordType();
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
           
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
    
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = '1';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test�';
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
		OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        Test.stopTest(); 
    }
    
   //12122018 for first4functions 


    //for portal functions of each process
    // test response from OM =0
    
    public static testMethod void Metodo22(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        insert accOloWIND;
        
        Account acc = new Account();
        acc.name = 'Test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Accettato';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest StatReq = new OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
		StatReq.CODICE_ORDINE_OF = 'Test';
		StatReq.CODICE_OPERATORE = 'TIS';
		StatReq.CODICE_ORDINE_OLO = 'Test';
		StatReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		StatReq.ID_NOTIFICA = 'Test';
		StatReq.AZIONE = 'T';
        StatReq.CODICE_MOTIVAZIONE = 'T';
        StatReq.MOTIVAZIONE = 'T';
		StatReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		StatReq.ORARIO_APPUNTAMENTO = '10:00:00';
		StatReq.NOME_CLIENTE = 'Test';
		StatReq.COGNOME_CLIENTE = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		StatReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		StatReq.NOTE = 'Test';
		
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        //OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        //OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        EsEl.ID_NOTIFICA = 'Test';
		EsEl.CODICE_MOTIVAZIONE = 'Test';
		EsEl.MOTIVAZIONE = 'Test';

        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        EsEl1.ID_NOTIFICA = 'Test';
		EsEl1.CODICE_MOTIVAZIONE = 'Test';
		EsEl1.MOTIVAZIONE = 'Test';
        
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksStatusUpdate(StatReq, TestDataFactory.ESLog[0]);
        //OF_SA_CD_OLO_EntryChecks.SyncChecksStatusUpdate(StatReq);
        
        Test.stopTest();
    }     
    
    //START SyncChecksDeactivation
	
    // base
	public static testMethod void MetodoD1(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    public static testMethod void MetodoD1new1(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		//Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
     public static testMethod void MetodoD1new2(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
	    
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		//Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    public static testMethod void MetodoD1new3(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123456';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    public static testMethod void MetodoD1new4(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = '�';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    
    public static testMethod void MetodoD1new5(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
 		insert c;
 		
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		//Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    public static testMethod void MetodoD1new5_1(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
          
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		//Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    public static testMethod void MetodoD1new5_2(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
  
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();

		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = '�';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();
    }
    
    public static testMethod void MetodoD1new6(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;

        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();

		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		//Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    public static testMethod void MetodoD1new7(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            
        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;

        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= '123456789012345678901234567890123456789012345678901234567890';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }

    // test id risorsa
    public static testMethod void MetodoD4(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;

        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901';
        Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test';        
        Deactiv.ID_RISORSA= '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_RISORSA= 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_RISORSA= 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.ID_RISORSA= 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);

		//OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);

		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    public static testMethod void MetodoD1new8(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;

        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();

		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = '1234';
		Deactiv.ID_RISORSA= '�';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();
    }
    
    public static testMethod void MetodoD1new9(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;

        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();

		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = '1234';
		Deactiv.ID_RISORSA= '1234';
		Deactiv.NOME_CLIENTE = '123456789012345678901';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }

    public static testMethod void MetodoD1new10(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
       
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test123456Test123';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = '1234';
		Deactiv.ID_RISORSA= '1234';
		Deactiv.NOME_CLIENTE = '�';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }

    // test note = �
    public static testMethod void MetodoD5(){
       
        Map<String,String> RecordTypeMap = RecordType();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
    
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();

		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
        Deactiv.NOTE = 'Test�';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    // test apparato != null & tipologia apparato vuoto
    public static testMethod void MetodoD6(){
       
        Map<String,String> RecordTypeMap = RecordType();
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        //acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;

        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = '';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);

        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    // test apparato != null & tipologia apparato > 100
    public static testMethod void MetodoD7(){
       
        Map<String,String> RecordTypeMap = RecordType();

        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;

        Account acc = new Account();
        acc.name = 'test';
        // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;

        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;

        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }
    
    // test apparato != null & id apparato vuoto
    public static testMethod void MetodoD8(){
       
        Map<String,String> RecordTypeMap = RecordType();
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
             

         
        Account acc = new Account();
        acc.name = 'test';
      //  acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
  
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = '';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }
    
    // test apparato != null & id apparato > 50
    public static testMethod void MetodoD9(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        

          
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
  
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
        
    }

    // test tipologia apparato != null & cognome cliente > 70
	public static testMethod void MetodoD10(){
       
        Map<String,String> RecordTypeMap = RecordType();

    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            

         
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
  
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
        Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }
    
    // test tipologia apparato != null & cognome cliente = �
	public static testMethod void MetodoD11(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
              

         
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test�';
        Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    

    // test tipologia apparato != null & recapito telefonico cliente 1 vuoto
	public static testMethod void MetodoD12(){
       
        Map<String,String> RecordTypeMap = RecordType();

   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
             

        
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
      
        
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test';
        Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = '';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 1 > 20
	public static testMethod void MetodoD13(){
       
        Map<String,String> RecordTypeMap = RecordType();

    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
               

          
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
      
        
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test';
        Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTest';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 1 = �
	public static testMethod void MetodoD14(){
       
        Map<String,String> RecordTypeMap = RecordType();

   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
             

          
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
     
        
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test';
        Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test�';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 2 > 20
	public static testMethod void MetodoD15(){
       
        Map<String,String> RecordTypeMap = RecordType();

   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            

        
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test';
        Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'TestTestTestTestTestTest';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    
    
    // test tipologia apparato != null & recapito telefonico cliente 2 = �
	public static testMethod void MetodoD16(){
       
        Map<String,String> RecordTypeMap = RecordType();

    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
            

           
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'WN';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA= 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
        Deactiv.COGNOME_CLIENTE=  'Test';
        Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test�';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
		
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest();        
    }    

    // test nome cliente
    public static testMethod void MetodoD17(){
       
        Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
           

          
        Account acc = new Account();
        acc.name = 'test';
       // acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
       
        
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   
        
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		
        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
        Deactiv.ID_RISORSA= 'Test';

        //Deactiv.NOME_CLIENTE = 'TestTestTestTestTestTest';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        //Deactiv.NOME_CLIENTE = 'Test�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Deactiv.NOME_CLIENTE = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        
        Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_CD_OLO_EntryChecks.SyncChecksDeactivation(Deactiv);
        Test.stopTest(); 
    }

   
     public static testMethod void MetodoD18(){
        
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
        Map<String,String> RecordTypeMap = RecordType();
        
         
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
         
        OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deactiv = new OF_SA_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
		        
		OF_SA_WS_IN_OLO_Deactivation.APPARATO appa = new OF_SA_WS_IN_OLO_Deactivation.APPARATO();
		appa.TIPOLOGIA_APPARATO = 'Test';
		appa.ID_APPARATO = 'Test';
		
		Deactiv.CODICE_OPERATORE = 'VF';
		Deactiv.CODICE_ORDINE_OLO = 'Test';
		Deactiv.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		Deactiv.ID_NOTIFICA = 'Test';
		Deactiv.ID_RISORSA = 'Test';
		Deactiv.NOME_CLIENTE = 'Test';
		Deactiv.COGNOME_CLIENTE=  'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		Deactiv.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		Deactiv.CODICE_MOTIVAZIONE = 'T';
		Deactiv.MOTIVAZIONE = 'T';
		Deactiv.NOTE = 'Test';
		
		Deactiv.APPARATO = new List<OF_SA_WS_IN_OLO_Deactivation.APPARATO>();
        Deactiv.APPARATO.add(appa);
        
      
         Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksDeactivation(Deactiv, testDataFactory.ESlog[0]);
        test.stopTest();
    }
    
    
   // START SyncChecksReschedule 
    
    // Test base per il metodo SyncChecksReschedule
    public static testMethod void MetodoR0(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
           
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS ';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    public static testMethod void MetodoR1(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-12-13';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'A04';
		RR.MOTIVAZIONE = 'M';
    	
        BusinessHours bh = [SELECT Id 
                            FROM BusinessHours 
                            WHERE IsDefault=true];
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        //OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksReschedule(RR, TestDataFactory.ESLog[0]);
        Test.stopTest(); 
        
    }
    
    // test codice operatore
    public static testMethod void MetodoR2(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		 
        RR.CODICE_OPERATORE = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_OPERATORE = 'TISS';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_OPERATORE = 'TI�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_OPERATORE = 'TIS';

        
        RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
   
    public static testMethod void MetodoR3(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

  
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
      
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		
        RR.CODICE_ORDINE_OLO = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_ORDINE_OLO = 'TestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_ORDINE_OLO = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_ORDINE_OLO = 'Test';
        
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test data notifica
    public static testMethod void MetodoR4(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
      
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		
        RR.DATA_NOTIFICA = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00z';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01�00';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        
        RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
   
    // test id notifica
    public static testMethod void MetodoR5(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
           
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		
        RR.ID_NOTIFICA = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ID_NOTIFICA = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestT';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ID_NOTIFICA = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ID_NOTIFICA = 'Test';
        
        RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test nome cliente
    public static testMethod void MetodoR6(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

  
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
          
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		
        RR.NOME_CLIENTE = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.NOME_CLIENTE = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.NOME_CLIENTE = 'Test';
        
        RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test Stato != Acquisito,Accettato,Sospeso
    public static testMethod void MetodoR7(){
    	
    	Map<String,String> RecordTypeMap = RecordType();

    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
   
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Bho';
 		c.EOF_FASE__C = 'NA';
    	insert c;
           
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test cognome cliente
    public static testMethod void MetodoR8(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

  
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
      
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
         
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		
        RR.COGNOME_CLIENTE = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.COGNOME_CLIENTE = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.COGNOME_CLIENTE = 'Test';
        
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test recapito telefonico cliente 1
    public static testMethod void MetodoR9(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
       
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test recapito telefonico cliente 2
    public static testMethod void MetodoR10(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	      
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
                
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test data prevista attivazione
    public static testMethod void MetodoR11(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
          
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		
        RR.DATA_PREVISTA_ATTIVAZIONE = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15z';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11�15';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        
        RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    //test orario appuntamento
    public static testMethod void MetodoR12(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
          
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		
        RR.ORARIO_APPUNTAMENTO = '';
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ORARIO_APPUNTAMENTO = '10:00�00';
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.ORARIO_APPUNTAMENTO = '10:00:00';
                
        RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test codice motivazione
    public static testMethod void MetodoR13(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
      
       	
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	      
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		
        RR.CODICE_MOTIVAZIONE = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_MOTIVAZIONE = 'MMMM';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_MOTIVAZIONE = 'M�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.CODICE_MOTIVAZIONE = 'M';
        
        RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test motivazione
    public static testMethod void MetodoR14(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
         
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';
		RR.NOTE = 'Test';
		RR.CODICE_MOTIVAZIONE = 'M';
		
        RR.MOTIVAZIONE = '';
    	OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.MOTIVAZIONE = 'M�';
    	OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        RR.MOTIVAZIONE = 'M';
        
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
    
    // test note
    public static testMethod void MetodoR15(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        
    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	      
        
    	OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest RR = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
		RR.CODICE_ORDINE_OF = 'Test';
		RR.CODICE_OPERATORE = 'TIS';
		RR.CODICE_ORDINE_OLO = 'Test';
		RR.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		RR.ID_NOTIFICA = 'Test';
		RR.NOME_CLIENTE = 'Test';
		RR.COGNOME_CLIENTE = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		RR.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		RR.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		RR.ORARIO_APPUNTAMENTO = '10:00:00';		
        RR.NOTE = 'Test�';
        RR.CODICE_MOTIVAZIONE = 'M';
		RR.MOTIVAZIONE = 'M';
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_CRMWorkAround.Esito = 1;
        OF_SA_CD_OLO_EntryChecks.SyncChecksReschedule(RR);
        Test.stopTest(); 
        
    }
 
   
    
    // START SyncChecksActivation
    public static testMethod void MetodoA1(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
      
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
    // test codice operatore & codice ordine olo
    public static testMethod void MetodoA2(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	
        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
        ActivationReq.CODICE_OPERATORE = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_OPERATORE = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_OPERATORE = 'WNNN';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_OPERATORE = 'WN';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.CODICE_ORDINE_OLO = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_ORDINE_OLO = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_ORDINE_OLO = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        
        ActivationReq.DATA_NOTIFICA = '2017-08-22T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
        
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
     // test data notifica & id notifica
    public static testMethod void MetodoA3(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
        
        
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		
        ActivationReq.DATA_NOTIFICA = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30�15+01:00';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:0';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.ID_NOTIFICA = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_NOTIFICA = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_NOTIFICA = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_NOTIFICA = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        
         OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test nome referente & cognome referente
    public static testMethod void MetodoA4(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        
         OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 

    }
    
    // test telefono referente & email referente
    public static testMethod void MetodoA5(){
        
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
        
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789999999999999999999999999999999999999999999999999999999999';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test�.com';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl.Tempi_Parziali__c = string.valueof(datetime.now());        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
         OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest(); 
    }
    
    // test telefono referente on field & nome cliente & cognome cliente
    public static testMethod void MetodoA6(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
    
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789999999999999';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.NOME_CLIENTE = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_CLIENTE = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_CLIENTE = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.COGNOME_CLIENTE = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_CLIENTE = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_CLIENTE = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.COGNOME_CLIENTE = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test recapito telefonico cliente 1 & 2
    public static testMethod void MetodoA7(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'TestTestTestTestTestTest';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test data prevista attivazione & NUMERO_TELEFONICO_PRINCIPALE_LINEA
    public static testMethod void MetodoA8(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15z';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11�15';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '012345678901234567891';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
        
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test data IDENTIFICATIVO_DEL_POP & ID_BUILDING
    public static testMethod void MetodoA9(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        
        ActivationReq.IDENTIFICATIVO_DEL_POP = '';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.IDENTIFICATIVO_DEL_POP = '12345678901';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.IDENTIFICATIVO_DEL_POP = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
       
        
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
     // test data ID_BUILDING
    public static testMethod void MetodoA10(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        
       
        
        ActivationReq.ID_BUILDING='';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_BUILDING = '123456789012345678901234512345678901234567890123451234567890123456789012345123456789012345678901234512345678901234567890123451234567890123456789012345111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.ID_BUILDING = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
        
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
       // test data ID_BUILDING
    public static testMethod void MetodoA11(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '1234567890123456789012345123456789012345222222222221111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    
     // test data ID_BUILDING
    public static testMethod void MetodoA12(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_CLIENTE = '1234567890123456789012345123456789012345222222222221111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOME_CLIENTE = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test data ID_BUILDING
    public static testMethod void MetodoA13(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = '1234567890123456789012345123456789012345222222222221111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    // test data ID_BUILDING
    public static testMethod void MetodoA14(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_PROGETTO_SPECIALE = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CODICE_PROGETTO_SPECIALE = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test data ID_BUILDING
    public static testMethod void MetodoA14A(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.PROMOZIONE = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.PROMOZIONE = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		//ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
     // test data ID_BUILDING
    public static testMethod void MetodoA14B(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE='test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CLUSTER_PROMOZIONE = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.CLUSTER_PROMOZIONE = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		//ActivationReq.PROMOZIONE = 'Test';
		//ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
     // test data ID_BUILDING
    public static testMethod void MetodoA14C(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOTE= '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890012345678901234567890012345678901234567890012345678901234567890012345678901234567890012345678901234567890012345678901234567890012345678901234567890012345678901234567890';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.NOTE = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		//ActivationReq.PROMOZIONE = 'Test';
		//ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		//ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
     // test data ID_BUILDING
    public static testMethod void MetodoA14D(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.SCALA_PALAZZINA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.SCALA_PALAZZINA = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.ID_BUILDING = 'Test';
		//ActivationReq.SCALA_PALAZZINA = 'Test';
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
     // test data ID_BUILDING
    public static testMethod void MetodoA14E(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = '�';
		OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
                 OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
     // test data ID_BUILDING
    public static testMethod void MetodoA14F(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		//OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
       
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		//ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
       // ActivationReq.VLAN.add(OLO_VAN);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
 // test data ID_BUILDING
    public static testMethod void MetodoA14V1(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
        // test data ID_BUILDING
    public static testMethod void MetodoA14V2(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='1234567890123';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
         // test data ID_BUILDING
    public static testMethod void MetodoA14V3(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='12�';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
         // test data ID_BUILDING
    public static testMethod void MetodoA14V4(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
        OLO_VAN1.USER_VLAN='';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
         // test data ID_BUILDING
    public static testMethod void MetodoA14V5(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='123456';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
         // test data ID_BUILDING
    public static testMethod void MetodoA14V6(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='12�';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    public static testMethod void MetodoA14V7(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
        OLO_VAN1.SERVICE_VLAN='';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    public static testMethod void MetodoA14V8(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
        OLO_VAN1.SERVICE_VLAN='123456';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    public static testMethod void MetodoA14V9(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='�12';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    public static testMethod void MetodoA14V10(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    public static testMethod void MetodoA14V11(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='123456';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    public static testMethod void MetodoA14V12(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
       OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='�123';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
     public static testMethod void MetodoA14V13(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
       OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='t';
          OLO_VAN1.CUSTOMER_VLAN='123456';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
     public static testMethod void MetodoA14V14(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='t';
          OLO_VAN1.CUSTOMER_VLAN='�12';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
     public static testMethod void MetodoA14V15(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
      OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='t';
          OLO_VAN1.CUSTOMER_VLAN='t';
          OLO_VAN1.MODELLO_DI_SERVIZIO_VLAN='12345678901234567890123456';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
     public static testMethod void MetodoA14V16(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
       OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='t';
          OLO_VAN1.CUSTOMER_VLAN='t';
          OLO_VAN1.MODELLO_DI_SERVIZIO_VLAN='12�';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
     public static testMethod void MetodoA14V17(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
       OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='t';
          OLO_VAN1.CUSTOMER_VLAN='t';
          OLO_VAN1.MODELLO_DI_SERVIZIO_VLAN='t';
         OLO_VAN1.INFORMAZIONI_VLAN='123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
     public static testMethod void MetodoA14V18(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);

        OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
   
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN1 = new OF_SA_WS_IN_OLO_Activation.VLAN();
      OLO_VAN1.KIT_CONSEGNA_VLAN='test';
         OLO_VAN1.USER_VLAN='t';
          OLO_VAN1.SERVICE_VLAN='t';
         OLO_VAN1.PROFILO_VLAN='t';
          OLO_VAN1.CUSTOMER_VLAN='t';
          OLO_VAN1.MODELLO_DI_SERVIZIO_VLAN='t';
         OLO_VAN1.INFORMAZIONI_VLAN='�';
        
       // OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        
        
       // OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
       
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		//ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		//ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		//ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		//ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2017-06-01T18:30:15+01:00';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA= 'test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'test';
        ActivationReq.ID_BUILDING='test';
       
        
        // ActivationReq.PROFILO='';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '123456789012345678901234512345678901234522222222222';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        //ActivationReq.PROFILO = '�';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       
         ActivationReq.PROFILO='test';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'test';
        ActivationReq.NOME_CLIENTE ='test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2='test';
        ActivationReq.CODICE_PROGETTO_SPECIALE='test';
        ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		//ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // ActivationReq.RECAPITO_TEST_LINEA = '1234567890123456789012345123456789012345222222222221111111111111111111111111111111111111111111111111111111111111111111111111111';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        ActivationReq.RECAPITO_TEST_LINEA = 'TEST';
		//OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        
        //ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		
		//ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		//ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		//ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		//ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN1);
        
       // ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
       // ActivationReq.APPARATO.add(OLO_APPARATO);
        
       // ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
       // ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_GE_Utils.processo = 'attivo';
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
         OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO OPEN STREAM BASE';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    
     // test tipologia apparato vuoto
    public static testMethod void MetodoA15(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = '';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test tipologia apparato > 100
    public static testMethod void MetodoA16(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
    }
    
    // test tipologia apparato = �
    public static testMethod void MetodoA18(){
       
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
   

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T�';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }
    
     // test password apparato > 50
    public static testMethod void MetodoA20(){
       
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();
    	OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();
    	
    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
      //  accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test password apparato = �
    public static testMethod void MetodoA21(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T�';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test azione apparato vuoto
    public static testMethod void MetodoA22(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
      
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
 

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = '';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test azione apparato > 1
    public static testMethod void MetodoA23(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'TT';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test azione apparato = �
    public static testMethod void MetodoA24(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
      
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = '�';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }
    
    // test nome servizio vuoto
    public static testMethod void MetodoA42(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
  

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = ''; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test nome servizio > 50
    public static testMethod void MetodoA43(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        //accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test nome servizio = �
    public static testMethod void MetodoA44(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T�'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test informazioni servizio vuoto
    public static testMethod void MetodoA45(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
       
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = '';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test informazioni servizio > 2
    public static testMethod void MetodoA46(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
        
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
 		c.EOF_FASE__C = 'NA';
    	insert c;
    

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'TTT';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }

	// test informazioni servizio = �
    public static testMethod void MetodoA47(){
      
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords(null,null,null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
  

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = '�';
		
		ActivationReq.CODICE_OPERATORE = 'WN';
		ActivationReq.CODICE_ORDINE_OLO = 'Test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        Test.stopTest();
        
    }


    public static testMethod void MetodoA49(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = '02112016_37';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksActivation(ActivationReq, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    //added for new functionality 17th jan 2019
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		ActivationReq.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = '02112016_37';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test1(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		ActivationReq.CODICE_ORDINE_OLO = '02112016_37';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
     public static testMethod void PORTAL_SyncChecksChangeSetup_Test2(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = '12345678901234567890';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test3(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = '�';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test4(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
		ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test5(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
		//OpenStreamRequest.DATA_NOTIFICA = '2017';
		ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test6(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		//ActivationReq.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.ID_NOTIFICA = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.ID_NOTIFICA = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test7(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		ActivationReq.PROFILO = 'Test';
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.ID_RISORSA = '12345678901234567890123456789012345678901234567890123456789012345678901';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.ID_RISORSA = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
     public static testMethod void PORTAL_SyncChecksChangeSetup_Test8(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        //OpenStreamRequest.PROFILO = 'Test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.PROFILO = '123456789012345678901234567890';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.PROFILO = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test9(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '123456789012345678901234567890123456789012345678901234567890';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		ActivationReq.PROMOZIONE = 'Test';
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
       // OpenStreamRequest.PROFILO = '123456789012345678901234567890';
       // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test10(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = '123456789012345678901234567890123456789012345678901234567890';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		ActivationReq.CLUSTER_PROMOZIONE = 'Test';
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
       // OpenStreamRequest.PROFILO = '123456789012345678901234567890';
       // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.PROMOZIONE = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test11(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = '123456789012345678901234567890123456789012345678901234567890';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		
		ActivationReq.NOTE = 'Test';
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
       // OpenStreamRequest.PROFILO = '123456789012345678901234567890';
       // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test12(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
       // OpenStreamRequest.PROFILO = '123456789012345678901234567890';
       // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OpenStreamRequest.NOTE = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test13(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		ActivationReq.VLAN = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        ActivationReq.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
       // OpenStreamRequest.PROFILO = '123456789012345678901234567890';
       // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
       // OpenStreamRequest.NOTE = 'Te�';
      //  OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test14(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
       // OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.KIT_CONSEGNA_VLAN = '123456789012345678901234567890';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.KIT_CONSEGNA_VLAN  = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test15(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
      //  OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.USER_VLAN = '1234567';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.USER_VLAN  = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test16(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
       // OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.SERVICE_VLAN = '1234567';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.SERVICE_VLAN  = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    /*
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test17(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
    	

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        //OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		
		
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.PROFILO_VLAN = '1234567';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.PROFILO_VLAN  = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    */
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test18(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        //OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
       
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.CUSTOMER_VLAN = '1234567';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.CUSTOMER_VLAN  = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test19(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = '1234567890123456789012';
        OLO_VAN.INFORMAZIONI_VLAN = 'T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        // OLO_VAN.CUSTOMER_VLAN = '1234567';
        // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test20(){
    	
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Ricevuto';
 		c.EOF_FASE__C = 'NA';
    	insert c;
        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        OLO_VAN.INFORMAZIONI_VLAN = '1111111234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
		
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        // OLO_VAN.CUSTOMER_VLAN = '1234567';
        // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        OLO_VAN.INFORMAZIONI_VLAN = 'Te�';
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
    
    /*public static testMethod void PORTAL_SyncChecksChangeSetup_Test21(){
    	
        
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
       // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
       	
       	
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
        c.PO_SA_Portale__c = false;
        c.OF_Bonifica_Locked_Row__c = false;
    	insert c;
        
        OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = accOloWIND.Id;
        //ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        OF_SA_CD_GE_Utils.a=ass;
    	
        
       // String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - CeD - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        //eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.RecordTypeId = RecordTypeMap.get('OF_SA_CeD_FiberRequest');
        insert eaiLog;
        
        EOF_EAI_Service_Log__c  eaiLog1=[select RecordTypeId,recordtype.developername,Caso__c,EOF_ID_Notifica__c,OF_SA_ACK__c from EOF_EAI_Service_Log__c where recordtype.developername='OF_SA_CeD_FiberRequest'];
        
        system.debug('@@@@@newwwww'+eaiLog.RecordTypeId);
        system.debug('@@@@@newwwww2'+eaiLog1);
        
        OF_SA_CD_GE_Utils.slSFOLO=eaiLog1;
        OF_SA_CD_GE_Utils.slSFOM=eaiLog1;
        
        list<EOF_EAI_Service_Log__c> listeailog=new list<EOF_EAI_Service_Log__c>();
        listeailog.add(eaiLog1);
        OF_SA_CD_GE_Utils.ListSlDeactivationOLOSF=listeailog;

        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
       // OLO_VAN.INFORMAZIONI_VLAN = '1111111234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OLO_VAN.INFORMAZIONI_VLAN ='T';
        
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
		ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
		ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
		ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
		ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
		ActivationReq.NOME_CLIENTE = 'Test';
		ActivationReq.COGNOME_CLIENTE = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
		ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
		ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
		ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
		ActivationReq.ORARIO_APPUNTAMENTO = '10:00:00';
		
		ActivationReq.ID_BUILDING = 'Test';
		ActivationReq.SCALA_PALAZZINA = 'Test';
		ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
		ActivationReq.RECAPITO_TEST_LINEA = 'Test';
		ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
        
        ActivationReq.APPARATO = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        ActivationReq.APPARATO.add(OLO_APPARATO);
        
        ActivationReq.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        ActivationReq.SERVIZIO_AGGIUNTIVO.add(OLO_SERAGG);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
       // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_GE_Utils.checkRTMap=FALSE;
        
         OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'VLAN';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        // OLO_VAN.CUSTOMER_VLAN = '1234567';
        // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        //OLO_VAN.INFORMAZIONI_VLAN = 'Te�';
        //OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }*/
    
    public static testMethod void PORTAL_SyncChecksChangeSetup_Test21(){
        
    	Map<String,String> RecordTypeMap = RecordType();
        TestDataFactory.CreateTestRecords('EOF Caso - Attivazione','FiberRequest',null);
    	//c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Vodafone';
        accOloWIND.EOF_Codice_Operatore__c = 'VF';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        // accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        
        insert accOloWIND;
     
        Case c = new Case();
    	c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    	c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Operatore_WS__c= accOloWIND.EOF_Codice_Operatore__c;
    	c.EOF_Contact__c = null;
    	c.status = 'Acquisito';
 		c.EOF_FASE__C = 'NA';
        c.PO_SA_Portale__c = false;
        c.OF_Bonifica_Locked_Row__c = false;
    	insert c;
        
        // OF_SA_CD_GE_Utils.caseOriginale=c;
        
        Asset ass = new Asset();
        ass.Status = 'In Modifica';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = accOloWIND.Id;
        //ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        //OF_SA_CD_GE_Utils.a=ass;
    	
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo; 
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio2;
	    servizio.OF_DataFineValidita__c = fine2;
	    servizio.OF_CatalogoCommerciale__c = catalogo.id;
       
	    insert servizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
	    Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
	    ce.name = 'VLAN';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio1;
	    ce.OF_DataFineValidita__c = fine1;
	    ce.OF_Servizio__c = servizio.id;
	    insert ce;
        
		OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request OpenStreamRequest= new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
		
		OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN OLO_VAN = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'T';
        OLO_VAN.USER_VLAN = 'T';
        OLO_VAN.SERVICE_VLAN = 'T';
        OLO_VAN.PROFILO_VLAN = 'T';
        OLO_VAN.CUSTOMER_VLAN = 'T';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'T';
        // OLO_VAN.INFORMAZIONI_VLAN = '1111111234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
        OLO_VAN.INFORMAZIONI_VLAN ='T';
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'T';
        OLO_APPARATO.PASSWORD_APPARATO = 'T';
        OLO_APPARATO.AZIONE_APPARATO = 'T';
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'T'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'T';
		
		OpenStreamRequest.CODICE_OPERATORE = 'VF';
		OpenStreamRequest.CODICE_ORDINE_OLO = 'test';
	    OpenStreamRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
		OpenStreamRequest.ID_NOTIFICA = 'Test';
        OpenStreamRequest.ID_RISORSA = 'Te';
        OpenStreamRequest.PROFILO = 'Test';
        OpenStreamRequest.CODICE_PROGETTO_SPECIALE = '1234567890123';
        OpenStreamRequest.PROMOZIONE = 'test';
        OpenStreamRequest.CLUSTER_PROMOZIONE = 'test';
        OpenStreamRequest.NOTE = 'test';
	
		OpenStreamRequest.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        OpenStreamRequest.VLAN.add(OLO_VAN);
    	
    	Test.startTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock2());
        
		OF_SA_CD_GE_Utils.tmpl = new TEMPLOG__c();        
        OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint stub = new OF_SA_WS_OLO_StatusUpdate.NotifyPortTypeEndpoint();
        OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint stub1 = new OF_SA_WS_OM_StatusUpdate.AggiornaStatoPortTypeEndpoint();
        
        OF_SA_WS_OLO_Response.Esito_element EsEl = new OF_SA_WS_OLO_Response.Esito_element();
        EsEl.ESITO = '0';
        
        OF_SA_WS_OM_Response.Esito_element EsEl1 = new OF_SA_WS_OM_Response.Esito_element();
        EsEl1.ESITO = '0';
        
        //OF_SA_CD_OLO_EntryChecks.SyncChecksActivation(ActivationReq);
        // OF_SA_CD_GE_Utils.checkCaseOriginale=true;
        //OF_SA_CD_GE_Utils.caseOriginale=c;
        OF_SA_CD_GE_Utils.checkRTMap=FALSE;
        OF_SA_CD_GE_Utils.PORTAL=false;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        Notify.CODICE_OPERATORE='VF';
        Notify.CODICE_ORDINE_OLO ='Test';
        Notify.CODICE_ORDINE_OF = c.id;
        Notify.DATA_NOTIFICA ='2017-09-08T17:00:00+02:00';
        Notify.ID_NOTIFICA = 'test_espl_01';
        Notify.STATO_ORDINE ='0';
        Notify.CODICE_MOTIVAZIONE ='C07';
        Notify.MOTIVAZIONE ='Espletato OK';
        Notify.ID_RISORSA ='';
        Notify.DATA_ESPLETAMENTO_ORDINE ='2019-01-14';
        
        OF_SA_CD_GE_Utils.OM_CreateCompletionOrder_Log(c, notify);
        OF_SA_CD_OLO_EntryChecks.SyncChecksChangeSetup(OpenStreamRequest);
        // OLO_VAN.CUSTOMER_VLAN = '1234567';
        // OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        //OLO_VAN.INFORMAZIONI_VLAN = 'Te�';
        //OF_SA_CD_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(OpenStreamRequest, TestDataFactory.ESlog[0]);
        Test.stopTest(); 
    }
}